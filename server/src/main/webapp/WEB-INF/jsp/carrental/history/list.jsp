<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../inc/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="ThemeBucket">
    <link rel="shortcut icon" href="#" type="image/png">
    <title>Dynamic Table</title>
    <%@ include file="../../inc/new2/css.jsp" %>
</head>
<body class="sticky-header">
<section>
    <%@ include file="../../inc/new2/menu.jsp" %>
    <!-- main content start-->
    <div class="main-content">
        <%@ include file="../../inc/new2/header.jsp" %>
        <!--body wrapper start-->
        <div class="wrapper">
            <div class="row">
                <div class="col-sm-12">
                    <section class="panel">
                        <div class="panel-body">
                            <div class="form-group col-sm-2">
                                <input type="text" id="orderNo" name="orderNo" class="form-control" placeholder="订单号">
                            </div>
                            <div class="form-group col-sm-2">
                                <input type="text" id="driverName" name="driverName" class="form-control" placeholder="司机姓名">
                            </div>

                            <div class="form-group col-sm-2">
                                <input type="text" id="userName" name="userName" class="form-control" placeholder="客人姓名">
                            </div>

                            <div class="form-group col-sm-2">
                                <input type="text" id="start" name="start" class="form-control input-append date form_datetime" placeholder="发车时间(大于)">
                            </div>
                            <div class="form-group col-sm-2">
                                <input type="text" id="end" name="end" class="form-control input-append date form_datetime" placeholder="发车时间(小于)">
                            </div>
                            <div class="form-group col-sm-2">
                                <button id="c_search" class="btn btn-info">搜索</button>
                                <button id="c_clear" class="btn btn-info" ><i class="fa fa-recycle"></i> 清空</button>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <section class="panel">
                        <header class="panel-heading">
                            会员列表
                            <span class="tools pull-right">
                               <button class="btn btn-default " type="button" id="c_refresh"><i class="fa fa-refresh"></i>刷新</button>
                            </span>
                        </header>
                        <div class="panel-body">
                            <div class="adv-table">
                                <table class="display table table-bordered table-striped" id="dataTables" width="100%">
                                    <thead>
                                    <tr>
                                        <th><input type="checkbox" class="list-parent-check"
                                                   onclick="$leoman.checkAll(this);"/></th>
                                        <th>订单号</th>
                                        <th>路线起始</th>
                                        <th>客人名称</th>
                                        <th>发车时间</th>
                                        <th>巴士数量</th>
                                        <th>详情</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </div>
</section>
<%@ include file="../../inc/new2/foot.jsp" %>
<%@ include file="../../inc/new2/confirm.jsp" %>
<script>
    $carRental = {
        v: {
            list: [],
            dTable: null
        },
        fn: {
            init: function () {
                $carRental.fn.dataTableInit();
                $("#c_search").click(function () {
                    $carRental.v.dTable.ajax.reload();
                });
                //清空
                $("#c_clear").click(function () {
                    $(this).parents(".panel-body").find("input,select").val("");
                });
                //刷新
                $("#c_refresh").click(function () {
                    $("#c_clear").parents(".panel-body").find("input,select").val("");
                    $carRental.v.dTable.ajax.reload();
                });
                //时间控件初始化
                $('.form_datetime').datetimepicker({
                    language: 'zh-CN',
                    weekStart: 1,
                    todayBtn: 1,
                    autoclose: 1,
                    minView: "month",
                    format: 'yyyy-mm-dd'
                });
            },
            dataTableInit: function () {
                $carRental.v.dTable = $leoman.dataTable($('#dataTables'), {
                    "processing": true,
                    "serverSide": true,
                    "searching": false,
                    "bSort": false,
                    "ajax": {
                        "url": "${contextPath}/admin/carRental/list",
                        "type": "POST"
                    },
                    "columns": [
                        {
                            "data": "id",
                            "render": function (data) {
                                var checkbox = "<input type='checkbox' class='list-check' onclick='$leoman.subSelect(this);' value=" + data + ">";
                                return checkbox;
                            }
                        },
                        {
                            "data": "order.orderNo",
                            "sDefaultContent" : ""
                        },
                        {
                            "data": "",
                            "render": function (data, type, row, meta) {
                                return row.startPoint+"————>"+row.endPoint
                            },
                            "sDefaultContent" : ""

                        },
                        {
                            "data": "order.userName",
                            "sDefaultContent" : ""
                        },
                        {
                            "data": "startDate",
                            "render": function (data) {
                                return new Date(data).format("yyyy-MM-dd hh:mm:ss");
                            },
                            "sDefaultContent" : ""
                        },
                        {
                            "data": "busNum",
                            "sDefaultContent" : ""

                        },
                        {
                            "data": "id",
                            "render": function (data, type, row, meta) {
                                var detail = "<button title='查看' class='btn btn-primary btn-circle add' onclick=\"$carRental.fn.detail(\'" + data + "\')\">" +
                                        "<i class='fa fa-eye'></i> 查看</button>";
                                return  detail ;
                            }
                        }

                    ],
                    "fnServerParams": function (aoData) {
                        aoData.orderNo = $("#orderNo").val();
                        aoData.driverName = $("#driverName").val();
                        aoData.userName = $("#userName").val();
                        aoData.Dstart = $("#start").val();
                        aoData.Dend = $("#end").val();
                        //只显示已完成的
                        aoData.orderStatus = 3;
                    }
                });
            },
            detail: function (id) {
                var params = "";
                if (id != null && id != '') {
                    params = "?id=" + id;
                }
                window.location.href = "${contextPath}/admin/carRental/history/detail" + params;
            },

            responseComplete: function (result, action) {
                if (result.status == "0") {
                    if (action) {
                        $carRental.v.dTable.ajax.reload(null, false);
                    } else {
                        $carRental.v.dTable.ajax.reload();
                    }
                    $leoman.notify(result.msg, "success");
                } else {
                    $leoman.notify(result.msg, "error");
                }
            }
        }
    }
    $(function () {
        $carRental.fn.init();
    })
</script>
</body>
</html>
