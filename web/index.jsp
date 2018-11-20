<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>free-后台管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
</head>
<jsp:include page="common_header.jsp"></jsp:include>
<body>
<div id="wrapper">
    <nav class="navbar-default navbar-static-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav metismenu" id="side-menu">
                <li class="nav-header">
                    <div class="dropdown profile-element">
                        <span>
                            <img alt="image" class="img-circle" src="img/profile_small.jpg" />
                        </span>
                        <a data-toggle="dropdown" class="dropdown-toggle" href="index.html#">
                            <span class="clear">
                                <span class="block m-t-xs">
                                    <strong class="font-bold">admin</strong>
                                </span>
                            </span>
                        </a>
                    </div>
                    <div class="logo-element">
                        IN+
                    </div>
                </li>


                <li>
                    <a href="index.html"><i class="fa fa-th-large"></i> <span class="nav-label">系统管理</span> <span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level">
                        <li class="active"><a href="index.html">用户管理</a></li>
                        <li><a href="dashboard_2.html">角色管理</a></li>
                        <li><a href="dashboard_3.html">权限管理</a></li>
                        <li><a href="dashboard_4_1.html">用户角色管理</a></li>
                        <li><a href="dashboard_5.html">角色权限管理</a></li>
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
</div>
<jsp:include page="common_footer.jsp"></jsp:include>
</body>
</html>