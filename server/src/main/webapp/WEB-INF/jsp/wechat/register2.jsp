<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../inc/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>设置密码-江城巴士</title>
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="favicon.ico">

    <link rel="stylesheet" href="css/app.css">
</head>

<body class="bg-reg">

<header>
    <div class="title">设置密码</div>
</header>

<section class="wrap reg-box">
    <div class="form form-extal">

        <div class="item">
            <input type="password" class="ipt" value="" name="" id="oldpwd" placeholder="请输入登录密码" />
            <span class="error"></span>
        </div>

        <div class="item">
            <input type="password" class="ipt" name="" id="newpwd" placeholder="请输入确认密码" />
            <span class="error"></span>
        </div>

        <div class="button">
            <button type="submit" class="ubtn ubtn-blue" id="submit">确定</button>
        </div>

    </div>
</section>


<script src="js/zepto.min.js"></script>
<script>
    $(function() {
        var $oldpwd = $('#oldpwd'),
                $newpwd = $('#newpwd');

        function checkOldpwd() {
            var val = $oldpwd.val();
            if (!val) {
                $oldpwd.next().html('请输入登录密码').show();
            } else {
                $oldpwd.next().html('').hide();
                return true;
            }
            $oldpwd.focus();
            return false;
        }
        function checkNewpwd() {
            var val = $newpwd.val();
            if (!val) {
                $newpwd.next().html('请输入确认密码').show();
            } else {
                $newpwd.next().html('').hide();
                return true;
            }
            $newpwd.focus();
            return false;
        }
        function checkIpt() {
            if (checkOldpwd() && checkNewpwd()) {
                return true;
            }
            return false;
        }
        // 保存
        $('#submit').on('click', function() {
            return checkIpt();
        });

        $('body').on('click', function() {
            $('.error').html('').hide();
        });


    });

</script>

</body>
</html>