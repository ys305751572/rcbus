<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../inc/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>车辆位置-江城巴士</title>
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="${contextPath}/wechat-html/favicon.ico">

    <link rel="stylesheet" href="${contextPath}/wechat-html/css/app.css">
</head>

<body>

<header>
    <div class="title">车辆位置</div>
</header>


<section class="wrap location-box">
    <div class="slide-wrap">
        <div class="hd">
            <span><img src="${contextPath}/wechat-html/images/file.png" />车辆信息</span>
        </div>
        <div class="slide">
            <ul>

            </ul>
        </div>
    </div>

    <div class="hd">
        <span><img src="${contextPath}/wechat-html/images/road.png" />发车线路</span>
        <em onclick="toPosition()">实时线路</em>
    </div>
    <div class="location">
        <ul id="line">

        </ul>
    </div>

    <div class="departure">
        <h2><img src="${contextPath}/wechat-html/images/clock.png" />发车时间</h2>

        <dl>
            <dd class="time1">

            </dd>
        </dl>
    </div>


    <div class="button">
        <button type="button" class="ubtn ubtn-blue" id="submit" onclick="toOrder()">预定座位</button>
    </div>
</section>

<!-- 车辆信息模板 -->
<li id="busTemplate" style="display: none;">
    <div class="avatar">
        <img src="${contextPath}/wechat-html/images/bus_avatar.jpg" />
        <span></span>
    </div>
    <div class="detail">
        <em>司机姓名</em>
        <span></span>
        <em>司机电话</em>
        <span></span>
        <div class="col">
            <em>品牌</em>
            <span></span>
        </div>
        <div class="col">
            <em>车型</em>
            <span></span>
        </div>
    </div>
</li>


<script src="${contextPath}/wechat-html/js/zepto.min.js"></script>
<script src="${contextPath}/wechat-html/js/app.js"></script>
<script>
    $(function() {

        initOther();

    })

    var sidArr = [];//所有车辆当前站点id数组
    var carNoArr = [];//所有车辆车牌号数组

    //初始化班车，路线，时间
    function initOther(){
        $.post("${contextPath}/wechat/route/other",{'routeId':"${routeId}"},function(res){

            //班车
            var bsList = res.data.object.map.bsList;
            $(".slide ul").empty();
            for(var i=0; i<bsList.length;i++){
                var template = $("#busTemplate").clone().removeAttr("id");
                template.find(".avatar img").attr("src",bsList[i].bus.image==null?'':bsList[i].bus.image.path);
                template.find(".avatar span").text(bsList[i].bus.carNo);
                template.find(".detail span").eq(0).text(bsList[i].bus.driverName);
                template.find(".detail span").eq(1).text(bsList[i].bus.driverPhone);
                template.find(".detail .col").eq(0).find("span").text(bsList[i].bus.brand);
                template.find(".detail .col").eq(1).find("span").text(bsList[i].bus.modelNo);
                sidArr.push(bsList[i].bus.stationId);
                carNoArr.push(bsList[i].bus.carNo);
                template.show();
                $(".slide ul").append(template);
            }

            //站点
            var stationList = res.data.object.map.stationList;
            $("#line").empty();
            for(var i=0; i<stationList.length;i++){
                $("#line").append('<li sid="'+stationList[i].id+'"><i class="arrow"></i><em>'+stationList[i].stationName+'</em></li>');
            }
            var count = $("#line").find('li').length;
            $('#line').width(56 * count - 10);

            //时间
            var timeList = res.data.object.map.timeList;
            $(".time1").empty();
            for(var i=0; i<timeList.length;i++){
                $(".time1").append('<span style="margin-left: 20px;"><em>'+timeList[i].departTime+'</em></span>');
            }

            //初始化滑动效果
            initSlide();

        });
    }

    //初始化滑动效果
    function initSlide(){
        $('.slide').each(function() {
            var $self = $(this),
                    $nav,
                    length = $self.find('li').length;

            if (length < 2) {
                return;
            }
            var nav = ['<div class="nav">'];
            for (var i = 0 ; i < length; i++) {
                nav.push( i === 0 ? '<i cursid="'+sidArr[i]+'" cno="'+carNoArr[i]+'" class="current"></i>' : '<i cursid="'+sidArr[i]+'" cno="'+carNoArr[i]+'"></i>');
            }
            nav.push('</div>');
            $self.append(nav.join(''));
            $nav = $self.find('i');

            $(this).swipeSlide({
                index : 0,
                continuousScroll : true,
                autoSwipe : false,
                lazyLoad : true,
                firstCallback : function(i,sum){
                    $nav.eq(i).addClass('current').siblings().removeClass('current');
                    //初始化，显示该车辆的当前位置
                    var cursid = $nav.eq(i).attr("cursid");
                    showCurLoc(cursid);
                },
                callback : function(i,sum){
                    $nav.eq(i).addClass('current').siblings().removeClass('current');
                    //滑动，显示该车辆的当前位置
                    var cursid = $nav.eq(i).attr("cursid");
                    showCurLoc(cursid);
                }
            });
        });
    }

    //显示当前位置
    function showCurLoc(cursid){
        $("#line li").removeClass("current");
        $("#line li[sid='"+cursid+"']").addClass("current");
    }

    //跳转至订单页
    function toOrder(){
        location.href = "${contextPath}/wechat/route/toOrder?routeId=${routeId}";
    }

    function toPosition(){
        location.href = "http://221.234.42.20:89/Interface/findPosition.action?carNum=鄂ALB229";
        location.href = "${contextPath}/wechat/route/toPosition?routeId=${routeId}";
    }

</script>

</body>
</html>