<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/27
  Time: 12:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<link rel="stylesheet" href="/css/zTree/demo.css" type="text/css">
<link rel="stylesheet" href="/css/zTree/zTreeStyle/zTreeStyle.css" type="text/css">
<script src="/js/jquery-2.1.1.js"></script>
<script type="text/javascript" src="/js/zTree/jquery.ztree.all.js"></script>
<SCRIPT LANGUAGE="JavaScript">
    var zTreeObj;
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var setting = {

    };
    // zTree 的数据属性，深入使用请参考 API 文档（zTreeNode 节点数据详解）
    var zNodes = [
        {name:"test1", open:true, children:[
                {name:"test1_1"}, {name:"test1_2"}]},
        {name:"test2", open:true, children:[
                {name:"test2_1"}, {name:"test2_2"}]}
    ];
    $(document).ready(function(){
        zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
    });
</SCRIPT>
<body>

<div>
    <ul id="treeDemo" class="ztree"></ul>
</div>
</body>
</html>
