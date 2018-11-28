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
                    <label class="control-label col-sm-2" for="userName">角色名称</label>
                    <div class="col-sm-2">
                        <input type="text" class="form-control" id="userName" name="userName">
                    </div>
                    <label class="control-label col-sm-2" for="roleName">角色名称</label>
                    <div class="col-sm-2">
                        <input type="text" class="form-control" id="roleName" name="roleName">
                    </div>
                    <div class="col-sm-2" style="text-align:right;">
                        <button type="button" id="btn_query" class="btn btn-primary">查询</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div id="toolbar" class="btn-group">
        <%--<button id="btn_export" type="button" class="btn btn-primary">
            <span class="glyphicon glyphicon-export" aria-hidden="true"></span>导出
        </button>--%>
    </div>
    <div class="example-wrap">
        <div class="example">
            <table id="tb_list" class="table table-bordered"></table>
        </div>
    </div>
</div>
<%----%>
<!-- 分配角色 -->
<div class="modal inmodal" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content animated bounceInRight">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">分配角色</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <table>
                        <tr id="roleId">
                            <input type="hidden" id="userId"/>
                            <td style="text-align: center;padding: 30px;font-size: 1em">
                                <label>角色:</label>
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
                <button type="button" class="btn btn-white" data-dismiss="modal" onclick="down()">关闭</button>
                <button type="button" class="btn btn-primary" onclick="saveUserRole()">保存</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/common_footer.jsp"></jsp:include>
<script>
    var userId = sessionStorage.getItem("userId");
    var token = sessionStorage.getItem("token");

    function down() {
        $("#myModal").hide();
    }

    function saveUserRole(){
        var flag = true;
        var id = $("#userId").val();
        var parentId = $("#parentId option:selected").val();

        if("" == id || null == id){
            flag = false;
        }

        if("" == parentId || null == parentId){
            flag = false;
        }

        var param = {
            userId:id,
            roleId:parentId
        };

        if(flag){
            $.ajax({
                url: url+"/system/saveUserRole",
                type: "post",
                contentType:"application/json",
                data:JSON.stringify(param),
                dataType: "json",
                headers:{"Access-Token":token,"Access-Source":"2"},
                success: function (obj) {
                    if(null == obj || "" == obj){
                        sweetAlert(obj.message);
                        location.href = "/view/system/suserRoleList.jsp";
                    }else{
                        location.href = "/view/system/suserRoleList.jsp";
                    }
                },
                error: function () {
                    alert("错误！")
                }
            });
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
        url: url+"/system/getUserRoleList",         /*请求后台的URL（*）*/
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
                "roleName": $("#roleName").val(),
                "userName": $("#userName").val()
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
                title: "用户id",//标题
                field: "id",
                formatter: function (value, row, index) {
                    return '<a onclick="detailed('+row.id+')">'+value+'</a>';
                }
            },
            {
                title: "用户名称",//标题
                field: "userName"
            },
            {
                title: "角色名称",//标题
                field: "roleName"
            },
            {
                title: "描述",//标题
                field: "descrition"
            },
            {
                title: "操作",//标题
                field: "id",
                formatter: function (value, row, index) {
                    if(null == row.roleName || "" == row.roleName){
                        return '<a onclick="toAddUserRole('+row.id+')">分配角色</a>';
                    }else{
                        return '<a onclick="toAddUserRole('+row.id+')">修改角色</a>';
                    }

                }
            }
        ], onLoadSuccess: function () {

        }, onLoadError: function () {

        }
    });


    function toAddUserRole(id){
        var param = {
            id:id
        };
        $.ajax({
            url: url+"/system/getRoleAllList",
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
                    for (var i = 0; i < obj.data.length; i++) {
                        $("#parentId").append("<option value='"+obj.data[i].id+"'>"+obj.data[i].roleName+"</option>");
                    };
                    $("#userId").val(id);
                    $("#myModal").show();
                }
            },
            error: function () {
                alert("树形结构加载失败！")
            }
        });
    }


</script>
</body>

</html>