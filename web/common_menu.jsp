<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/21
  Time: 11:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<nav class="navbar-default navbar-static-side" role="navigation">
    <div class="sidebar-collapse">
        <ul class="nav metismenu" id="side-menu">
            <li class="nav-header">
                <div class="dropdown profile-element">
                        <span>
                            <img alt="image" class="img-circle" src="/img/profile_small.jpg" />
                        </span>
                    <a data-toggle="dropdown" class="dropdown-toggle" href="index.html#">
                            <span class="clear">
                                <span class="block m-t-xs">
                                    <strong class="font-bold" id="userName11"></strong>
                                </span>
                            </span>
                    </a>
                </div>
                <div class="logo-element">
                    IN+
                </div>
            </li>


            <li class="action" id="213">
                <a href="index.html"><i class="fa fa-th-large"></i> <span class="nav-label">系统管理</span> <span class="fa arrow"></span></a>
                <ul class="nav nav-second-level">
                    <li class="action sonDao"><a href="/view/system/suserList.jsp">系统用户管理</a></li>
                    <li class="sonDao"><a href="/view/system/suserList.jsp">角色管理</a></li>
                    <li class="sonDao"><a href="/view/system/suserList.jsp">权限管理</a></li>
                    <li class="sonDao"><a href="/view/system/suserList.jsp">用户角色管理</a></li>
                    <li class="sonDao"><a href="/view/system/suserList.jsp">角色权限管理</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>

<div id="page-wrapper" class="gray-bg dashbard-1">
    <div class="row border-bottom">
        <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0;background-color: #1a2d41">
            <ul class="nav navbar-top-links navbar-right">
                <li>
                    <a href="login.jsp">
                        <i class="fa fa-sign-out"></i> 退出
                    </a>
                </li>
            </ul>
        </nav>
    </div>
</div>
<jsp:include page="/common_footer.jsp"></jsp:include>
<script>

    $("[name='sonDao']").click(
        alert("12312");
        var id=$(this).parent().parent().attr('id');
    );

    /*
        sessionStorage.setItem("key","value");//保存数据到sessionStorage
        var data = sessionStorage.getItem（"key"）;//获取数据
        sessionStorage.removeItem("key");//删除数据
        sessionStorage.clear(); //删除保存的所有数据
    */

    var token = sessionStorage.getItem("token");   //获取数据
    var userName = sessionStorage.getItem("userName");   //获取数据
    if("" != token && null != token){
        $("#userName11").text(userName);
    }else{
        location.href = "login.jsp";
    }
</script>
</body>
</html>
