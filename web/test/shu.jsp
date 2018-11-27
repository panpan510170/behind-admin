<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/26
  Time: 20:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <!-- 样式表 -->
    <link href="/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="/css/plugins/treeview/bootstrap-treeview.css" rel="stylesheet"/>

    <!-- JS文件 -->
    <script src="/js/jquery-2.1.1.js"></script>
    <script src="/js/plugins/treeview/bootstrap-treeview.js"></script>
</head>
<body>
<div id="tree"></div>

<input type="button" value="保存" onclick="ids()">
<script>
     $(function () {
         $.ajax({
             type: "Post",
             url: "http://localhost:8888/system/rolePermissionsTreeList",
             dataType: "json",
             success: function (result) {
                 /*alert(result.data);*/
                 $('#tree').treeview({
                     data: result.data,
                     showIcon: false,
                     showCheckbox: true/*,
                     onNodeChecked: function(event, node) {
                         alert(node.id);
                     },
                     onNodeUnchecked: function (event, node) {
                         alert(node.text);
                     }*/
                 });
                 /*
                 $('#tree').treeview({
                     data: result.data,         // 数据源
                     showCheckbox: true,   //是否显示复选框
                     highlightSelected: false,    //是否高亮选中
                     nodeIcon: 'glyphicon glyphicon-globe',
                     emptyIcon: '',    //没有子节点的节点图标
                     multiSelect: true,    //多选
                     icon: "glyphicon glyphicon-stop",
                     selectedIcon: "glyphicon glyphicon-stop",
                     color: "#000000",
                     backColor: "#FFFFFF",
                     href: "#node-1",
                     selectable: true,
                     state: {
                         checked: true,
                         disabled: true,
                         expanded: true,
                         selected: true
                     },
                     tags: ['available'],
                     onNodeChecked: function (event,data) {
                         alert(data.id);
                     },
                     onNodeSelected: function (event, data) {
                         alert(data.text);
                     }*/

             },
             error: function () {
                 alert("树形结构加载失败！")
             }
         });
     })

    function ids() {
        var ids = $('#tree').treeview('getChecked');
        alert(JSON.stringify(ids));
        $.ajax({
            type: "Post",
            url: "http://localhost:8888/system/saveRolePermissionsTree",
            data: JSON.stringify(ids),
            dataType: "json",
            contentType:"application/json",
            success: function (result) {
                alert(result)
            },
            error: function () {
                alert("树形结构加载失败！")
            }
        });
    }
</script>

</body>
</html>
