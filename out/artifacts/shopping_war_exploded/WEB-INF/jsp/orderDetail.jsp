<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>

<!-- 引入JSTL标签库 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html lang="zh">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>订单详情</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/style.css"/>
    <script src="${pageContext.request.contextPath }/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
</head>

<body>
<div class="navbar navbar-default clear-bottom">
    <div class="container">
        <!-- logo start -->
        <div class="navbar-header">
            <a class="navbar-brand logo-style" href="/">
                <img class="brand-img" src="${pageContext.request.contextPath }/images/com-logo1.png" alt="logo"
                     height="70">
            </a>
        </div>
        <!-- logo end -->

        <!-- navbar start -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li>
                    <a href="${pageContext.request.contextPath }/product/findProductFuzzyParamList">商城主页</a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath }/cart/show">购物车</a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath }/order/findAll">我的订单</a>
                </li>

                <li class="dropdown">

                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                       aria-expanded="false">
                        预留链接 <span class="caret"></span>
                    </a>

                    <ul class="dropdown-menu">
                        <li>
                            <a href="#">预留链接</a>
                        </li>
                    </ul>
                </li>

                <li>
                    <a id="cartMsg"></a>
                </li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="#" data-toggle="modal" data-target="#loginModal">登陆</a>
                </li>

                <li>
                    <a href="#" data-toggle="modal" data-target="#registModal">注册</a>
                </li>

                <li class="userName">
                    您好:${user.userName }
                </li>

                <li class="dropdown">
                    <a href="#" class="dropdown-toggle user-active" data-toggle="dropdown" role="button">
                        <img class="img-circle" src="${pageContext.request.contextPath }/images/user.jpeg" height="30"/>
                        <span class="caret"></span>
                    </a>

                    <ul class="dropdown-menu">
                        <li>
                            <a href="${pageContext.request.contextPath }/user/showCenter">
                                <i class="glyphicon glyphicon-cog"></i> 个人中心
                            </a>
                        </li>

                        <li>
                            <a href="#" data-toggle="modal" data-target="#modifyPasswordModal">
                                <i class="glyphicon glyphicon-cog"></i>修改密码
                            </a>
                        </li>

                        <li>
                            <a href="#">
                                <i class="glyphicon glyphicon-off"></i> 退出
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
        <!-- navbar end -->
    </div>
</div>


<!-- content start -->
<div class="container">

    <div class="row">
        <div class="col-xs-12">
            <div class="page-header" style="margin-bottom: 0px;">
                <h3>我的订单</h3>
            </div>
        </div>
    </div>

    <div class="row head-msg">
        <div class="col-md-12">
            用户:<b><span>${order.user.userName }</span></b>
        </div>

        <div class="col-md-12">
            订单: <b><span>${order.no }</span></b>
        </div>
    </div>
    <table class="table table-hover table-striped table-bordered">
        <tr>
            <th>序号</th>
            <th>商品名称</th>
            <th>商品图片</th>
            <th>商品数量</th>
            <th>商品总价</th>
        </tr>

        <c:forEach items="${order.items }" var="item" varStatus="i">
            <tr>
                <td>${i.index + 1 }</td>
                <td>${item.product.name }</td>
                <td><img src="${pageContext.request.contextPath }${item.product.image }" alt="" width="60" height="60">
                </td>
                <td>${item.num }</td>
                <td>${item.price }</td>
            </tr>
        </c:forEach>

        <tr>
            <td colspan="5" class="foot-msg">
                共<b><span>${order.count }</span></b>条&nbsp; &nbsp;
                总计<b><span>${order.price }</span></b>元
            </td>
        </tr>
    </table>
</div>
<!-- content end-->

<!-- footers start -->
<!--
<div class="footers">
                           版权所有:&nbsp; &nbsp; 南京中兴  liyan@zte.com
</div>
-->
<!-- footers end -->

<!-- 修改密码模态框 -->
<div class="modal fade" id="modifyPasswordModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改密码</h4>
            </div>
            <form action="" class="form-horizontal" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">原密码:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">新密码:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">重复密码:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password">
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">
                        关&nbsp;&nbsp;闭
                    </button>
                    <button type="reset" class="btn btn-warning">重&nbsp;&nbsp;置</button>
                    <button type="submit" class="btn btn-warning">修&nbsp;&nbsp;改</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- 登录模态框 -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">登&nbsp;陆</h4>
            </div>
            <form action="" class="form-horizontal" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">登录帐号:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">密码:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">验证码:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password">
                        </div>
                        <div class="col-sm-2 input-height">
                            1234
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">
                        关&nbsp;&nbsp;闭
                    </button>
                    <button type="reset" class="btn btn-warning">重&nbsp;&nbsp;置</button>
                    <button type="submit" class="btn btn-warning">登&nbsp;&nbsp;陆</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- 注册模态框 -->
<div class="modal fade" id="registModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">会员注册</h4>
            </div>
            <form action="" class="form-horizontal" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">用户姓名:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="text">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">登陆账号:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="text">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">登录密码:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">联系电话:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="text">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">联系地址:</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="text">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">
                        关&nbsp;&nbsp;闭
                    </button>
                    <button type="reset" class="btn btn-warning">重&nbsp;&nbsp;置</button>
                    <button type="submit" class="btn btn-warning">注&nbsp;&nbsp;册</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
