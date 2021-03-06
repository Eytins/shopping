<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="zh">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>backend</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/bootstarp/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/index.css"/>
    <script src="${pageContext.request.contextPath }/js/jquery.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/bootstarp/js/bootstrap.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="${pageContext.request.contextPath }/js/userSetting.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/bootstrap-paginator.js"></script>
    <script type="text/javascript">
        $(function () {
            var pages;

            if ("${sysProductTypePageInfo.pages }" === 0) {
                pages = 1;
            } else {
                pages = "${sysProductTypePageInfo.pages}";
            }
            var options =
                {
                    bootstrapMajorVersion: 3, // bootstrap版本 (此项目中所有的页面都是用bootstrap 3画的)
                    currentPage: "${sysProductTypePageInfo.pageNum }", // pageNum对应PageInfo对象中的字段pageNum
                    totalPages: pages,//总页数
                    aligment: "center",
                    pageUrl: function (type, page, current) {
                        return "${pageContext.request.contextPath }/productType/findAll?pageNo=" + page;//发送请求到productType/findAll获取当前页数据
                    }
                };
            //初始化分页插件，并获取当前页码
            $("#productTypePage").bootstrapPaginator(options);

            $("#addProductType").click(function () {
                $.ajax(
                    {
                        type: "post",
                        url: "${pageContext.request.contextPath }/productType/addType",
                        data: {"name": $("#productTypeName").val()},//模态框中数据ID作为取值ID
                        dataType: "json",
                        success: function (result) {
                            if (result.responseCode === 1) {
                                location.href = "${pageContext.request.contextPath }/productType/findAll?pageNo=" + ${sysProductTypePageInfo.pages};
                            } else {
                                $("#errorMsg").tooptip(
                                    {
                                        title: "error",
                                        placement: "center",
                                        template: "<div class='tooltip errorMsg'>" + result.message + "</div>",
                                        tigger: "manual"
                                    }).tooltip("show");
                            }
                        },
                        error: function () {
                            alert("服务器内容错误!");
                        }
                    }
                );
            });

            //AJAX设置当前弹出模态框中的初始值
            $("input[name='toModifyType']").click(function () {
                $.ajax(
                    {
                        type: "post",
                        url: "${pageContext.request.contextPath }/productType/findById",
                        data: {"id": $(this).attr("data-value")},
                        dataType: "json",
                        success: function (result) {
                            if (result.responseCode === 1) {
                                // 页面设置 商品类型ID 字段的值
                                $("#modifyTypeId").val(result.returnObject.id);

                                // 页面设置 商品类型名称 字段的值
                                $("#modifyTypeName").val(result.returnObject.name);
                            } else {
                                $("#errorMsg").tooptip(
                                    {
                                        title: "error",
                                        placement: "center",
                                        template: "<div class='tooltip errorMsg'>" + result.message + "</div>",
                                        tigger: "manual"
                                    }).tooltip("show");
                            }
                        },
                        error: function () {
                            alert("服务器内容错误!");
                        }
                    }
                );
            });

            //修改数据的模态框，返回给页面AJAX
            $("#modifyType").click(function () {
                $.ajax(
                    {
                        type: "post",
                        url: "${pageContext.request.contextPath }/productType/modifyName",
                        data: {
                            "id": $("#modifyTypeId").val(),
                            "name": $("#modifyTypeName").val()
                        },
                        dataType: "json",
                        success: function (result) {
                            if (result.responseCode === 1) {
                                //返回到修改的页数
                                location.href = "${pageContext.request.contextPath }/productType/findAll?pageNo=" + ${sysProductTypePageInfo.pageNum };
                            } else {
                                $("#errorMsg").tooptip(
                                    {
                                        title: "error",
                                        placement: "center",
                                        template: "<div class='tooltip errorMsg'>" + result.message + "</div>",
                                        tigger: "manual"
                                    }).tooltip("show");
                            }
                        },
                        error: function () {
                            alert("服务器内容错误!");
                        }
                    });

            });

            $("#doExportProType").click(function () {
                $.ajax(
                    {
                        type: "post",
                        url: "${pageContext.request.contextPath }/productType/exportExcel",
                        data: {"name": $("#productTypeName").val()},//模态框中数据ID作为取值ID
                        dataType: "json",
                        success: function (result) {
                            if (result.responseCode === 1) {
                                location.href = "${pageContext.request.contextPath }/productType/findAll?pageNo=" + ${sysProductTypePageInfo.pages};
                            } else {
                                $("#errorMsg").tooptip(
                                    {
                                        title: "error",
                                        placement: "center",
                                        template: "<div class='tooltip errorMsg'>" + result.message + "</div>",
                                        tigger: "manual"
                                    }).tooltip("show");
                            }
                        },
                        error: function () {
                            alert("服务器内容错误!");
                        }
                    }
                );
            });
        });

    </script>
</head>

<body>
<div class="panel panel-default" id="userSet">
    <div class="panel-heading">
        <h3 class="panel-title">商品类型管理</h3>
    </div>
    <div class="panel-body">
        <input type="button" value="添加商品类型" class="btn btn-primary" id="doAddProType">
        <input type="button" value="导出商品类型" class="btn btn-primary" id="doExportProType">
        <input type="button" value="导入商品类型" class="btn btn-primary" id="doImportProType">

        <div class="modal fade" tabindex="-1" id="importProType">
            <!-- 窗口声明 -->
            <div class="modal-dialog modal-lg">
                <!-- 内容声明 -->
                <div class="modal-content">
                    <!-- 头部、主体、脚注 -->
                    <div class="modal-header">
                        <button class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">导入商品类型信息</h4>
                    </div>
                    <form action="${pageContext.request.contextPath }/productType/importProductType" method="post"
                          id="addProductTypeExcelForm" enctype="multipart/form-data">
                        <div class="modal-body text-center">
                            <div class="row text-right">
                                <label for="file" class="col-sm-4 control-label">Excel文件：</label>
                                <div class="col-sm-4">
                                    <a href="javascript:;" class="file">选择文件
                                        <input type="file" name="file" id="file">
                                    </a>
                                </div>
                            </div>
                            <br>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-primary addProductType" id="addProductTypeExcel">导入</button>
                            <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="modal fade" tabindex="-1" id="ProductType">
            <!-- 窗口声明 -->
            <div class="modal-dialog modal-lg">
                <!-- 内容声明 -->
                <div class="modal-content">
                    <!-- 头部、主体、脚注 -->
                    <div class="modal-header">
                        <button class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">添加商品类型信息</h4>
                    </div>
                    <div class="modal-body text-center">
                        <div class="row text-right">
                            <label for="productTypeName" class="col-sm-4 control-label">类型名称：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="productTypeName">
                            </div>
                        </div>
                        <br>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary addProductType" id="addProductType">添加</button>
                        <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </div>
        </div>
        <br>
        <br>
        <div class="show-list">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">
                    <th class="text-center">编号</th>
                    <th class="text-center">类型名称</th>
                    <th class="text-center">状态</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody id="tb">
                <c:forEach items="${sysProductTypePageInfo.list }" var="type">
                    <tr>
                        <td>${type.id }</td>
                        <td>${type.name }</td>
                        <td>
                            <c:if test="${type.status eq 1 }">启用</c:if>
                            <c:if test="${type.status eq 0 }">禁用</c:if>
                        </td>

                        <td class="text-center">
                            <!-- 添加  data-value="${type.id }" name="toModifyType" 注意这里有多条数据有修改操作, 所以这里不能用id选择器 选中要"修改"的数据 -->
                            <input type="button" class="btn btn-warning btn-sm doProTypeModify" value="修改"
                                   data-value="${type.id }" name="toModifyType">

                            <c:if test="${type.status eq 1 }">
                                <!-- <input type="button" class="btn btn-danger btn-sm doProTypeDisable" value="禁用"> -->
                                <!-- 将以上的input标签变成a标签 因为input标签不能用问号传参 -->
                                <a type="button" class="btn btn-danger btn-sm doProTypeDisable"
                                   href="${pageContext.request.contextPath }/productType/modifyProductTypeStatus?id=${type.id }&status=${type.status }&pageNo=${sysProductTypePageInfo.pageNum }">
                                    禁用 </a>
                            </c:if>

                            <c:if test="${type.status eq 0 }">
                                <!-- 把 class的值 btn-danger 改成 btn-success -->
                                <a type="button" class="btn btn-success btn-sm doProTypeDisable"
                                   href="${pageContext.request.contextPath }/productType/modifyProductTypeStatus?id=${type.id }&status=${type.status }&pageNo=${sysProductTypePageInfo.pageNum }">
                                    启用 </a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <!-- 添加: 分页 ul -->
            <ul id="productTypePage">
            </ul>
        </div>
        <div class="modal fade" tabindex="-1" id="myProductType">
            <!-- 窗口声明 -->
            <div class="modal-dialog modal-lg">
                <!-- 内容声明 -->
                <div class="modal-content">
                    <!-- 头部、主体、脚注 -->
                    <div class="modal-header">
                        <button class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">商品修改</h4>
                    </div>
                    <div class="modal-body text-center">
                        <div class="row text-right">
                            <label for="modifyTypeId" class="col-sm-4 control-label">编号：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="modifyTypeId" readonly="readonly">
                            </div>
                        </div>
                        <br>
                        <div class="row text-right">
                            <label for="modifyTypeName" class="col-sm-4 control-label">类型名称</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="modifyTypeName">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-warning updateProType" id="modifyType">修改</button>
                        <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>

</html>