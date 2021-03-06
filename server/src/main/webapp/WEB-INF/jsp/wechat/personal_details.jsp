<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../inc/taglibs.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>个人信息-江城巴士</title>
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="favicon.ico">
    <link rel="stylesheet" href="${contextPath}/wechat-html/css/app.css">
</head>

<body>

<header>
    <div class="title">个人信息</div>
</header>

<section class="wrap user-box">
    <div class="info">
        <div class="inner">
            <img src="${user.weChatUser.headImgUrl}" alt="">
            <%--<img src="${contextPath}/wechat-html/images/f/avatar.png" alt="">--%>
            <%--<em><a href="#">点击修改</a></em>--%>
            <em>${user.mobile}</em>
        </div>
    </div>

    <div class="list">
        <div class="floor">
            <div class="item">
                <img src="${contextPath}/wechat-html/images/f/3.png" alt="">
                <a href="javascript:;" onclick="toMyOrder()">我的订单</a>
                <i></i>
            </div>
            <div class="item">
                <img src="${contextPath}/wechat-html/images/f/4.png" alt="">
                <a href="javascript:;" onclick="toMyTrip()">我的行程</a>
                <i></i>
            </div>
            <div class="item">
                <img src="${contextPath}/wechat-html/images/f/5.png" alt="">
                <a href="javascript:;" onclick="toCollection()">我的收藏</a>
                <i></i>
            </div>
        </div>

        <div class="floor">
            <div class="item">
                <img src="${contextPath}/wechat-html/images/f/6.png" alt="">
                <a href="javascript:;" onclick="toCommuting()">个人通勤</a>
                <i></i>
            </div>
            <div class="item">
                <img src="${contextPath}/wechat-html/images/f/11.png" alt="">
                <a href="javascript:;" onclick="toMyCoupon()">我的礼券</a>
                <i></i>
            </div>
        </div>

        <div class="floor">
            <div class="item">
                <img src="${contextPath}/wechat-html/images/f/7.png" alt="">
                <a href="javascript:;" onclick="toUpdPwd()">修改密码</a>
                <i></i>
            </div>
            <div class="item">
                <img src="${contextPath}/wechat-html/images/f/9.png" alt="">
                <a href="javascript:;" onclick="toReport()">反馈意见</a>
                <i></i>
            </div>
            <div class="item">
                <img src="${contextPath}/wechat-html/images/f/10.png" alt="">
                <a href="javascript:;" onclick="toHelp()">帮助</a>
                <i></i>
            </div>
        </div>
    </div>

    <div class="button">
        <a href="javascript:;" onclick="logout()" class="ubtn ubtn-red">注销登录</a>
    </div>

</section>


<script src="${contextPath}/wechat-html/js/zepto.min.js"></script>
<script>

    //我的订单
    function toMyOrder(){
        window.location.href = "${contextPath}/wechat/order/myOrder/index";
    }
    //我的行程
    function toMyTrip(){
        window.location.href = "${contextPath}/wechat/order/myTrip/index";
    }
    //我的优惠券
    function toMyCoupon(){
        window.location.href = "${contextPath}/wechat/coupon/index";
    }
    //意见反馈
    function toReport(){
        window.location.href = "${contextPath}/wechat/report/index";
    }

    //个人通勤
    function toCommuting(){
        location.href = "${contextPath}/wechat/commuting/apply";
    }

    //修改密码
    function toUpdPwd(){
        location.href = "${contextPath}/wechat/toUpdPwd";
    }

    //我的收藏
    function toCollection(){
        location.href = "${contextPath}/wechat/route/collect/index";
    }

    //我的收藏
    function toHelp(){
        location.href = "${contextPath}/wechat/help";
    }

    //注销
    function logout(){
        location.href = "${contextPath}/wechat/logout";
    }


</script>

</body>
</html>