<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../inc/taglibs.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>转赠优惠券-江城巴士</title>
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="favicon.ico">

    <link rel="stylesheet" href="${contextPath}/wechat-html/css/app.css">
</head>

<body>

<header>
    <div class="title">转赠优惠券</div>
</header>

<section class="wrap ui-form">
    <div class="banner">
        <img src="${contextPath}/wechat-html/images/banner_coupons.jpg" width="100%" alt="">
    </div>


    <div class="coupons-list">
        <ul>
            <li class="c1">
                <div class="hd">
                    <em>6.8</em>
                    <sub>折</sub>
                </div>
                <div class="bd">
                    <h4>折扣券</h4>
                    <p>限15座以下车型使用</p>
                    <p>有效期至2016-09-09</p>
                </div>
            </li>
        </ul>

        <div class="result">
            更多精彩活动，尽在江城巴士公众号
        </div>

    </div>

    <div class="button">
        <button class="ubtn ubtn-blue" id="submit">转增给好友</button>
    </div>

</section>


<div id="mobilebox" class="hide">
    <div class="hd">请输入好友电话</div>
    <div class="input">
        <input type="text" class="ipt" />
    </div>
</div>


<script src="${contextPath}/wechat-html/js/zepto.min.js"></script>
<script src="${contextPath}/wechat-html/js/layer/layer.js"></script>
<script src="${contextPath}/wechat-html/js/app.js"></script>
<script>
    $(function(){

        var modal = $('#mobilebox').html();

        // 保存
        $('#submit').on('click', function() {
            layer.open({
                content: modal
                ,className: 'popup'
                ,btn: '确定转增'
                ,yes: function(index) {
                    var val = $('.popup .ipt').val();
                    if (!val) {
                        alertMsg('请输入手机号', 3e3);
                    } else if (!/^1[3-9]\d{9}$/.test(val)) {
                        alertMsg('手机号码格式错误', 3e3);
                    } else {
                        layer.close(index);
                    }
                }
            });
        });
    })
</script>

</body>
</html>