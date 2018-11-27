<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <!--360浏览器优先以webkit内核解析-->

    <title></title>
    <jsp:include page="/common_header.jsp"></jsp:include>
</head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="panel panel-default">
        <div class="panel-heading">查询条件</div>
        <div class="panel-body">
            <form id="formSearch" class="form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-2" for="permissionsName">权限名称</label>
                    <div class="col-sm-2">
                        <input type="text" class="form-control" id="permissionsName" name="permissionsName">
                    </div>
                    <label class="control-label col-sm-2" for="type">权限级别</label>
                    <div class="col-sm-2">
                        <select class="form-control" id="permissionsType">
                            <option value="">请选择</option>
                            <option value="1">一级权限</option>
                            <option value="2">二级权限</option>
                            <%--<option value="3">三级权限</option>--%>
                        </select>
                    </div>
                    <div class="col-sm-2" style="text-align:right;">
                        <button type="button" id="btn_query" class="btn btn-primary">查询</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div id="toolbar" class="btn-group">
       <%-- glyphicon-import导入  glyphicon-download下载--%>
        <%--<button id="btn_export" type="button" class="btn btn-primary" style="margin-right: 5px">
            <span class="glyphicon glyphicon-export" aria-hidden="true"></span>导出
        </button>--%>
        <button id="btn_add" type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>增加
        </button>
    </div>
    <div class="example-wrap">
        <div class="example">
            <table id="tb_list" class="table table-bordered"></table>
        </div>
    </div>
</div>

<!-- 增加 -->
<div class="modal inmodal" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content animated bounceInRight">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">增加权限</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <table>
                        <tr>
                            <td style="text-align: center;padding: 30px;font-size: 1em">
                                <label>权限名称:</label>
                            </td>
                            <td style="text-align: center;">
                                <input type="text" placeholder="权限名称" class="form-control" id="perName">
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center;padding: 30px;font-size: 1em">
                                <label>权限路径:</label>
                            </td>
                            <td style="text-align: center;">
                                <input type="text" placeholder="权限路径" class="form-control" id="perUrl">
                            </td>
                        </tr>
                        <%--<tr>
                            <td style="text-align: center;padding: 30px;font-size: 1em">
                                <label>权限图片:</label>
                            </td>
                            <td style="text-align: center;">
                                <input type="text" placeholder="权限图片" class="form-control">
                            </td>
                        </tr>--%>
                        <tr>
                            <td style="text-align: center;padding: 30px;font-size: 1em">
                                <label>权限等级:</label>
                            </td>
                            <td style="text-align: center;" onchange="showShang()" id="type">
                                <select class="form-control">
                                    <option value="">请选择</option>
                                    <option value="1">一级权限</option>
                                    <option value="2">二级权限</option>
                                    <%--<option value="3">三级权限</option>--%>
                                </select>
                            </td>
                        </tr>
                        <tr style="display: none" id="parentIdTr">
                            <td style="text-align: center;padding: 30px;font-size: 1em">
                                <label>上级权限:</label>
                            </td>
                            <td style="text-align: center;">
                                <select class="form-control" id="parentId">
                                    <option value="">请选择</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="add()">保存</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/common_footer.jsp"></jsp:include>
<script>
    /*$(function () {

    });*/
    var userId = sessionStorage.getItem("userId");
    var token = sessionStorage.getItem("token");

    function add(){
        var flag = true;
        var type = $("#type option:selected").val();
        var permissionsName = $("#perName").val();
        var permissionsUrl = $("#perUrl").val();
        var parentId = $("#parentId option:selected").val();

        if("" == permissionsName || null == permissionsName){
            flag = false;
        }
        if(2 == type || 3 == type){
            if("" == permissionsUrl || null == permissionsUrl){
                flag = false;
            }

            if("" == parentId || null == parentId){
                flag = false;
            }
        }
        if(flag){
            var param = {
                "permissionsName" : permissionsName,
                "permissionsUrl" : permissionsUrl,
                "type" : type,
                "parentId" : parentId
            };

            $.ajax({
                url: url+"/system/addPermissions",
                type: "post",
                contentType:"application/json",
                data:JSON.stringify(param),
                dataType: "json",
                headers:{"Access-Token":token,"Access-Source":"2"},
                success: function (obj) {
                    if(1 != obj.code){
                        sweetAlert(obj.message);
                        location.href = "login.jsp";
                    }else{
                        location.href = "/view/system/sPermissionsList.jsp";
                    }
                },
                error: function (obj) {
                    alert(obj);
                }
            });
        }else{
            sweetAlert("参数不对")
        }
    }

    function showShang(){
        var type = $("#type option:selected").val();
        if(1 != type && "" != type && null != type){

            var param = {
                "pageSize": 10000,
                "pageNo": 0,
                "type": type-1
            };
            $.ajax({
                url: url+"/system/getPermissionsList",
                type: "post",
                contentType:"application/json",
                data:JSON.stringify(param),
                dataType: "json",
                headers:{"Access-Token":token,"Access-Source":"2"},
                success: function (obj) {
                    if(null == obj || "" == obj){
                        sweetAlert("查询错误");
                        location.href = "login.jsp";
                    }else{
                        for (var i = 0; i < obj.rows.length; i++) {
                            $("#parentId").append("<option value='"+obj.rows[i].id+"'>"+obj.rows[i].permissionsName+"</option>");
                        };
                    }

                },
                error: function (obj) {
                    alert(obj);
                }
            });
            $("#parentIdTr").show();
        }else{
            $("#parentIdTr").hide();
        }
    }

    //导出
    $("#btn_export").click(function () {
        sweetAlert('正在导出...下载窗口未弹出前，请不要关闭此窗口');
        $("#formSearch").attr("action", "v_exportUserAccount.do");
        $("#formSearch").submit();
        $("#formSearch").attr("action", "");
    });


    //点击刷新当前table
    $('#btn_query').click(function () {
        $('#tb_list').bootstrapTable('refreshOptions',{pageNumber:1,pageSize:10});
        $('#tb_list').bootstrapTable("refresh");
    });

    $('#tb_list').bootstrapTable({
        url: url+"/system/getPermissionsList",         /*请求后台的URL（*）*/
        method: 'post',                      /*请求方式（*）*/
        search: false,//是否搜索
        pagination: true,//是否分页
        pageSize: 10,//单页记录数
        pageList: [10,20, 50,100],//分页步进值
        sidePagination: "server",//服务端分页
        //contentType: "application/x-www-form-urlencoded",//请求数据内容格式 默认是 application/json 自己根据格式自行服务端处理
        dataType: "json",//期待返回数据类型
        searchAlign: "left",//查询框对齐方式
        queryParamsType: "limit",//查询参数组织方式
        ajaxOptions:{
            headers:{"Access-Token":token,"Access-Source":"2"},
        },
        queryParams: function queryParams(params) {   //设置查询参数
            var param = {
                "pageSize": params.limit,
                "pageNo": params.offset,
                "permissionsName": $("#permissionsName").val(),
                "type": $("#permissionsType option:selected").val()
            };
            return param;
        },
        /*responseHandler:function(obj){
            rows = obj.data.list;
            total = obj.data.count;
        },*/
        searchOnEnterKey: false,//回车搜索
        showRefresh: true,//刷新按钮
        showColumns: true,//列选择按钮
        buttonsAlign: "left",//按钮对齐方式
        toolbar: "#toolbar",//指定工具栏
        toolbarAlign: "right",//工具栏对齐方式
        idField: "id",
        silentSort: false,
        columns: [
            {
                title: "id",//标题
                field: "id",
                formatter: function (value, row, index) {
                    return '<a onclick="detailed('+row.id+')">'+value+'</a>';
                }
            },
            {
                title: "权限名称",//标题
                field: "permissionsName"
            },
            {
                title: "权限路径",//标题
                field: "permissionsUrl"
            },
            {
                title: "权限图片路径",//标题
                field: "permissionsImageUrl"
            },
            {
                title: "权限级别",//标题
                field: "type"
            },
            {
                title: "创建时间",//标题
                field: "createTime",
                formatter: function (value, row, index) {
                    return changeDateFormat(value)
                }
            },
            {
                title: "操作",//标题
                field: "id",
                formatter: function (value, row, index) {
                    return '<a onclick="delPermissions('+row.id+')">删除</a>';
                }
            }
        ], onLoadSuccess: function () {

        }, onLoadError: function () {

        }
    });


    function delPermissions(id){
        var param = {
            id:id
        };
        $.ajax({
            url: url+"/system/delPermissions",
            type: "post",
            contentType:"application/json",
            data:JSON.stringify(param),
            dataType: "json",
            headers:{"Access-Token":token,"Access-Source":"2"},
            success: function (obj) {
                if(null == obj || "" == obj){
                    sweetAlert("查询错误");
                    location.href = "login.jsp";
                }else{
                    location.href = "/view/system/sPermissionsList.jsp";
                }

            },
            error: function (obj) {
                alert(obj);
            }
        });
    }
</script>
</body>

</html>