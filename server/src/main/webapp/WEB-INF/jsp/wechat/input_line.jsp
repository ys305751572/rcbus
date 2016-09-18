<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../inc/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>输入线路-江城巴士</title>
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="favicon.ico">
    <link rel="stylesheet" href="${contextPath}/wechat/css/app.css">
    <link rel="stylesheet" href="${contextPath}/wechat/css/mobiscroll.animation.css" />
    <link rel="stylesheet" href="${contextPath}/wechat/css/mobiscroll.frame.css" />
    <link rel="stylesheet" href="${contextPath}/wechat/css/mobiscroll.frame.ios.css" />
</head>

<body>

<header>
    <div class="title">输入线路</div>
</header>

<section class="wrap">
    <div class="ui-form2">
        <div class="floor">
            <div class="item">
                <div class="txt">出发城市</div>
                <div class="cnt">
                    <input type="text" class="ipt arrow" id="city" placeholder="" readonly value="" onclick="city()">
                    <span class="error"></span>
                    <i>&gt;</i>
                </div>
            </div>

            <div class="item">
                <div class="txt">起点</div>
                <div class="cnt">
                    <input type="text" class="ipt" id="from" placeholder="" value="">
                    <span class="error"></span>
                </div>
            </div>

            <div class="item">
                <div class="txt">终点</div>
                <div class="cnt">
                    <input type="text" class="ipt" id="to" placeholder="" value="">
                    <span class="error"></span>
                </div>
            </div>
        </div>

        <div class="floor">
            <div class="item">
                <div class="txt">包车方式</div>
                <div class="cnt">
                    <label><input type="radio" name="stype" class="rdo" checked value="0">单程</label>
                    <label><input type="radio" name="stype" class="rdo" value="1">往返</label>
                    <label><input type="radio" name="stype" class="rdo" value="2">包天</label>
                </div>
            </div>

            <div class="item">
                <div class="txt">出发时间</div>
                <div class="cnt">
                    <input type="text" class="ipt arrow" id="time1" placeholder="" readonly value="">
                    <span class="error"></span>
                    <i>&gt;</i>
                </div>
            </div>

            <div class="item">
                <div class="txt">返回时间</div>
                <div class="cnt">
                    <input type="text" class="ipt arrow" id="time2" placeholder="" readonly value="">
                    <span class="error"></span>
                    <i>&gt;</i>
                </div>
            </div>

            <div class="item">
                <div class="txt">需要车辆</div>
                <div class="cnt">
                    <input type="text" class="ipt" id="number" placeholder="" value="4">
                    <span class="error"></span>
                </div>
            </div>

            <div class="item">
                <div class="txt">总人数</div>
                <div class="cnt">
                    <input type="text" class="ipt" id="amount" placeholder="" value="24">
                    <span class="error"></span>
                </div>
            </div>

            <div class="item">
                <div class="txt">发票</div>
                <div class="cnt">
                    <label><input type="checkbox" id="ticket" class="rdo"></label>
                </div>
            </div>

            <div class="item">
                <div class="txt">发票抬头</div>
                <div class="cnt">
                    <input type="text" class="ipt" id="title" placeholder="xxx科技有限公司">
                    <span class="error"></span>
                </div>
            </div>
        </div>

        <div class="floor">
            <div class="item">
                <div class="txt">用车联系人</div>
                <div class="cnt">
                    <input type="text" class="ipt" id="linkman" placeholder="" value="小牧">
                    <span class="error"></span>
                </div>
            </div>

            <div class="item">
                <div class="txt">联系电话</div>
                <div class="cnt">
                    <input type="text" class="ipt" id="mobile" placeholder="" value="15098741234">
                    <span class="error"></span>
                </div>
            </div>
        </div>

        <div class="button">
            <button class="ubtn ubtn-blue" id="submit">确认订单</button>
        </div>

    </div>
</section>

<script src="${contextPath}/wechat/js/zepto.min.js"></script>
<script src="${contextPath}/wechat/js/mobiscroll/mobiscroll.dom.js"></script>
<script src="${contextPath}/wechat/js/mobiscroll/mobiscroll.core.js"></script>
<script src="${contextPath}/wechat/js/mobiscroll/mobiscroll.scrollview.js"></script>
<script src="${contextPath}/wechat/js/mobiscroll/mobiscroll.frame.js"></script>
<script src="${contextPath}/wechat/js/mobiscroll/mobiscroll.scroller.js"></script>
<script src="${contextPath}/wechat/js/mobiscroll/mobiscroll.frame.ios.js"></script>
<script src="${contextPath}/wechat/js/mobiscroll/mobiscroll.i18n.zh.js"></script>
<script src="${contextPath}/wechat/js/layer/layer.js"></script>


<script type="text/javascript">
    var $time1 = $('#time1');

    var mydate = new Date();
    var maxDay = 15; // 最后期限
    var dateArr = []; // 日期范围
    var hours = ['00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23'];
    var minutes = ['05', 10, 15, 20, 25, 30, 35, 40, 45, 50, 55];
    var time1;


    //求月份最大天数
    function getDaysInMonth(year, month){
        return new Date(year, month + 1, 0).getDate();
    }

    function getDate(mydate) {

        var year = mydate.getFullYear();
        var month = mydate.getMonth();
        var date = mydate.getDate() + 1; // 从明天开始
        var maxMonthDays = getDaysInMonth(year, month);
        var i, arr = [];
        if (maxMonthDays > date + maxDay) {
            for (i = date; i < maxMonthDays - maxDay; i ++) {
                arr.push(year + '-' + (month + 1) + '-' + i);
            }
        } else {
            for (i = date; i <= maxMonthDays; i ++) {
                arr.push(year + '-' + (month + 1) + '-' + i);
            }
            for (i = 1; i < maxDay + date - maxMonthDays; i ++) {
                arr.push(year + '-' + (month + 2) + '-' + i);
            }
        }

        return arr;
    }

    dateArr = getDate(mydate);
    time1 = dateArr[0].replace(/-/g,'');

    mobiscroll.scroller('#time1', {
        theme: 'ios',
        display: 'bottom',
        lang: 'zh',
        headerText: '出发时间',
        focusOnClose: false,
        formatValue: function (data) {
            return data[0] + ' ' + data[1] + ':' + data[2];
        },
        wheels: [
            [
                {
                    circular: false,
                    data: dateArr
                },
                {
                    circular: false,
                    data: hours
                },
                {
                    circular: false,
                    data: minutes
                }
            ]
        ],
        onSet: function(event, inst) {
            time1 = event.valueText.split(' ')[0].replace(/-/g, '');
        }
    });

    mobiscroll.scroller('#time2', {
        theme: 'ios',
        display: 'bottom',
        lang: 'zh',
        headerText: '返回时间',
        focusOnClose: false,
        formatValue: function (data) {
            return data[0] + ' ' + data[1] + ':' + data[2];
        },
        wheels: [
            [
                {
                    circular: false,
                    data: dateArr
                },
                {
                    circular: false,
                    data: hours
                },
                {
                    circular: false,
                    data: minutes
                }
            ]
        ],
        validate: function (event, inst) {
            var i,
                    values = event.values[0],
                    disabledValues = [];

            for (i = 0; i < dateArr.length; i ++) {
                if (time1 && parseInt(dateArr[i].replace(/-/g, ''), 10) < parseInt(time1, 10)) {
                    disabledValues.push(dateArr[i]);
                }
            }

            return {
                disabled: [
                    disabledValues, [], []
                ]
            }
        }
    });



    $('#submit').on('click', function() {
        layer.open({
            content: '当前座位已满，是否申请增派车辆？'
            ,btn: ['申请', '取消']
            ,yes: function(index){
                layer.close(index);
            }
        });

        layer.open({
            content: '<i class="ico ico-right2"></i><br /><br />您的订单已提交成功，请等待<br />客服人员与您联系'
            ,btn: '确定'
        });
        return false;
    })

    function city(){
        window.location.href = "${contextPath}/wechat/carrental/city"
    }

</script>
</body>
</html>