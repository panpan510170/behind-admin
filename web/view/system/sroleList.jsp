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
        <button id="btn_add" type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModaladd">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>增加
        </button>
    </div>
    <div class="example-wrap">
        <div class="example">
            <table id="tb_list" class="table table-bordered"></table>
        </div>
    </div>
</div>

<!-- 分配权限 -->
<div class="modal inmodal" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content animated bounceInRight">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">分配权限</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <div id="tree"></div>
                    <input type="hidden" id="roleId"/>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-white" data-dismiss="modal" onclick="down()">关闭</button>
                <button type="button" class="btn btn-primary" onclick="savePermissions()">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 增加 -->
<div class="modal inmodal" id="myModaladd" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content animated bounceInRight">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">新增角色</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <table>
                        <tr>
                            <td style="text-align: center;padding: 30px;font-size: 1em">
                                <label>角色名称:</label>
                            </td>
                            <td style="text-align: center;">
                                <input type="text" placeholder="角色名称" class="form-control" id="sroleName">
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center;padding: 30px;font-size: 1em">
                                <label>角色描述:</label>
                            </td>
                            <td style="text-align: center;">
                                <input type="text" placeholder="角色描述" class="form-control" id="descrition">
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="addRole()">保存</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/common_footer.jsp"></jsp:include>
<script>
    var userId = sessionStorage.getItem("userId");
    var token = sessionStorage.getItem("token");

    function addRole(){
        var flag = true;
        var roleName = $("#sroleName").val();
        var descrition = $("#descrition").val();

        if("" == roleName || null == roleName){
            flag = false;
        }
        if("" == descrition || null == descrition){
            flag = false;
        }

        if(flag){
            var param = {
                "roleName" : roleName,
                "descrition" : descrition
            };

            $.ajax({
                url: url+"/system/addRole",
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
                        location.href = "/view/system/sroleList.jsp";
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

   function savePermissions() {
       var ids = $('#tree').treeview('getChecked');
       var param = {
           roleId:$("#roleId").val(),
           rolePermissionsList:ids
       };
       $.ajax({
           url: url + "/system/saveRolePermissionsTree",
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
                   location.href = "/view/system/sroleList.jsp";
               }
           },
           error: function (result) {
               alert(result)
           }
       });
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
        url: url+"/system/getRoleList",         /*请求后台的URL（*）*/
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
                "roleName": $("#roleName").val()
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
                title: "角色名称",//标题
                field: "roleName"
            },
            {
                title: "描述",//标题
                field: "descrition"
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
                    return '<a onclick="showUpdatePermissions('+row.id+')">修改权限</a>';
                }
            }
        ], onLoadSuccess: function () {

        }, onLoadError: function () {

        }
    });


    function showUpdatePermissions(id){
        var param = {
            roleId:id
        };
        $.ajax({
            url: url+"/system/rolePermissionsTreeList",
            type: "post",
            contentType:"application/json",
            data:JSON.stringify(param),
            dataType: "json",
            headers:{"Access-Token":token,"Access-Source":"2"},
            success: function (result) {
                /*alert(result.data);*/
                $('#tree').treeview({
                    data: result.data,
                    showIcon: false,
                    showCheckbox: true
                });
                $("#roleId").val(id);
                $("#myModal").show();
            },
            error: function () {
                alert("树形结构加载失败！")
            }
        });
    }

    function down() {
        $("#myModal").hide();
    }
</script>
</body>

</html>