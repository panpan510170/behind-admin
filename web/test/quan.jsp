<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/26
  Time: 16:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<ul id="listproject" class="list-group">

</ul>



<script src="/js/jquery-2.1.1.js"></script>
    <script type="text/javascript">
        var JSarray = new Array();
        JSarray[0] = "array0";
        JSarray[1] = "array1";
        JSarray[2] = "array2";
        JSarray[3] = "array3";
        JSarray[4] = "array4";

        for(var i = 0;i<5;i++){
            $("#listproject").append("<li id=li"+i+">"+JSarray[i]+"</li>"); //在ul标签上动态添加li标签
            $("#li"+i).attr("class",'list-group-item');     //为li标签添加class属性
        }
        $('.list-group-item').on('click',function(){      //绑定事件
            alert("事件绑定成功！");
        });
    </script>
</body>
</html>
