<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>backend</title>
    <link rel="stylesheet" type="text/css" href="../../../bootstarp/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="../../../css/index.css" />
    <script src="../../../js/jquery.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../../bootstarp/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../../js/userSetting.js" type="text/javascript" charset="utf-8"></script>
</head>

<body>
    <!-- 管理员管理 -->
    <div class="panel panel-default" id="adminSet">
        <div class="panel-heading">
            <h3 class="panel-title">管理员管理</h3>
        </div>
        <div class="panel-body">
            <div class="showmargersearch">
                <form class="form-inline">
				  <div class="form-group">
				    <label for="exampleInputName2">姓名:</label>
				    <input type="text" class="form-control" id="userName" placeholder="请输入姓名">
				  </div>
				  <div class="form-group">
				    <label for="exampleInputName2">帐号:</label>
				    <input type="text" class="form-control" id="loginName" placeholder="请输入帐号">
				  </div>
				  <div class="form-group">
				    <label for="exampleInputName2">电话:</label>
				    <input type="text" class="form-control" id="phone" placeholder="请输入电话">
				  </div>
				  <div class="form-group">
				    <label for="exampleInputEmail3">邮箱:</label>
				    <input type="email" class="form-control" id="email" placeholder="请输入邮箱">
				  </div>
				  <div class="form-group">
				    <label for="exampleInputName2">部门</label>
	                    <select class="form-control" name="deptId">
	                        <option value="-1">全部</option>
	                        <option value="1">---有效---</option>
	                        <option value="0">---无效---</option>
	                    </select>
				  </div>
				  <div class="form-group">
				    <label for="exampleInputName2">角色</label>
	                    <select class="form-control" name="isValid">
	                        <option value="-1">全部</option>
	                        <option value="1">系统管理员</option>
	                        <option value="0">普通管理员</option>
	                    </select>
				  </div>
				  <div class="form-group">
				    <label for="exampleInputName2">状态</label>
	                    <select class="form-control" name="isValid">
	                        <option value="-1">全部</option>
	                        <option value="1">---有效---</option>
	                        <option value="0">---无效---</option>
	                    </select>
				  </div>
				  <input type="button" value="查询" class="btn btn-primary" id="doSearch">
				</form>
            </div>
            <br>
            <br>
            <input type="button" value="添加管理员" class="btn btn-primary" id="doAddManger">
            <!-- 添加管理员 -->
            <div class="modal fade" tabindex="-1" id="myMangerUser">
                <!-- 窗口声明 -->
                <div class="modal-dialog modal-lg">
                    <!-- 内容声明 -->
                    <div class="modal-content">
                        <!-- 头部、主体、脚注 -->
                        <div class="modal-header">
                            <button class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">添加管理员</h4>
                        </div>
                        <div class="modal-body text-center">
                            <div class="row text-right">
                                <label for="marger-username" class="col-sm-4 control-label">用户姓名：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="marger-username">
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="marger-loginName" class="col-sm-4 control-label">登录帐号：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="marger-loginName">
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="marger-password" class="col-sm-4 control-label">登录密码：</label>
                                <div class="col-sm-4">
                                    <input type="password" class="form-control" id="marger-password">
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="marger-phone" class="col-sm-4 control-label">联系电话：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="marger-phone">
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="marger-adrees" class="col-sm-4 control-label">联系地址：</label>
                                <div class="col-sm-4">
                                    <input type="email" class="form-control" id="marger-adrees">
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="role" class="col-sm-4 control-label">角&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色：</label>
                                <div class=" col-sm-4">
                                    <select class="form-control">
                                        <option>请选择</option>
                                        <option>系统管理员</option>
                                        <option>普通管理员</option>
                                    </select>
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="role" class="col-sm-4 control-label">部&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;门：</label>
                                <div class=" col-sm-4">
                                    <select class="form-control">
                                        <option>请选择</option>
                                        <option>研发部</option>
                                        <option>市场部</option>
                                    </select>
                                </div>
                            </div>
                            <br/>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-primary add-Manger">添加</button>
                            <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 管理员修改 -->
            <div class="modal fade" tabindex="-1" id="myModal-Manger">
                <!-- 窗口声明 -->
                <div class="modal-dialog modal-lg">
                    <!-- 内容声明 -->
                    <div class="modal-content">
                        <!-- 头部、主体、脚注 -->
                        <div class="modal-header">
                            <button class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">管理员修改</h4>
                        </div>
                        <div class="modal-body text-center">
                            <div class="row text-right">
                                <label for="MargerUsername" class="col-sm-4 control-label">id：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="MargerStaffId" readonly="readonly">
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="MargerUsername" class="col-sm-4 control-label">管理员姓名：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="MargerStaffname">
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="MargerLoginName" class="col-sm-4 control-label">登录帐号：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="MargerLoginName" readonly="readonly">
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="MargerPhone" class="col-sm-4 control-label">联系电话：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="MargerPhone">
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="MargerAdrees" class="col-sm-4 control-label">联系地址：</label>
                                <div class="col-sm-4">
                                    <input type="email" class="form-control" id="MargerAdrees">
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="MargerRole" class="col-sm-4 control-label">角&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色：</label>
                                <div class=" col-sm-4">
                                    <select class="form-control" id="MargerRole">
                                        <option>请选择</option>
                                        <option>系统管理员</option>
                                        <option>普通管理员</option>
                                    </select>
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="role" class="col-sm-4 control-label">部&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;门：</label>
                                <div class=" col-sm-4">
                                    <select class="form-control">
                                        <option>请选择</option>
                                        <option>研发部</option>
                                        <option>市场部</option>
                                    </select>
                                </div>
                            </div>
                            <br/>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-warning doMargerModal">修改</button>
                            <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="show-list" style="position: relative; top: 10px;">
                <table class="table table-bordered table-hover" style='text-align: center;'>
                    <thead>
                        <tr class="text-danger">
                            <th class="text-center">序号</th>
                            <th class="text-center">姓名</th>
                            <th class="text-center">帐号</th>
                            <th class="text-center">电话</th>
                            <th class="text-center">邮箱</th>
                            <th class="text-center">部门</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">角色</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody id="tb">
                        <tr>
                            <td>1</td>
                            <td>admin</td>
                            <td>admin</td>
                            <td>15996868058</td>
                            <td>江苏南京</td>
                            <td>研发部</td>
                            <td>有效</td>
                            <td>系统管理员</td>
                            <td class="text-center">
                                <input type="button" class="btn btn-warning btn-sm doMangerModify" value="修改">
                                <input type="button" class="btn btn-danger btn-sm doMangerDisable" value="禁用">
                            </td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>admin</td>
                            <td>admin</td>
                            <td>15996868058</td>
                            <td>江苏南京</td>
                            <td>研发部</td>
                            <td>无效</td>
                            <td>系统管理员</td>
                            <td class="text-center">
                                <input type="button" class="btn btn-warning btn-sm doMangerModify" value="修改">
                                <input type="button" class="btn btn-success btn-sm doMangerDisable" value="启用">
                            </td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>admin2</td>
                            <td>admin2</td>
                            <td>15996868058</td>
                            <td>江苏南京</td>
                            <td>研发部</td>
                            <td>无效</td>
                            <td>系统管理员</td>
                            <td class="text-center">
                                <input type="button" class="btn btn-warning btn-sm doMangerModify" value="修改">
                                <input type="button" class="btn btn-danger btn-sm doMangerDisable" value="禁用">
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>

</html>