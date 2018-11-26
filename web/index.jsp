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
        <div class="sidebar-collapse" id="daohang">
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


                <li>
                    <a><i class="fa fa-th-large"></i> <span class="nav-label">系统管理</span> <span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level">
                        <li><a href="/view/system/suserList.jsp" target="content">系统用户管理</a></li>
                        <li><a href="/view/system/sroleList.jsp" target="content">角色管理</a></li>
                        <li><a href="/view/system/sPermissionsList.jsp" target="content">权限管理</a></li>
                        <li><a href="/view/system/suserList.jsp" target="content">用户角色管理</a></li>
                        <li><a href="/view/system/suserList.jsp" target="content">角色权限管理</a></li>
                    </ul>
                </li>

                <%--<li>
                    <a><i class="fa fa-th-large"></i> <span class="nav-label">系统管理123</span> <span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level">
                        <li><a href="/view/system/suserList.jsp" target="content">系统用户管理123</a></li>
                        <li><a href="/view/system/suserList.jsp" target="content">角色管理123</a></li>
                        <li><a href="/view/system/suserList.jsp" target="content">权限管理123</a></li>
                        <li><a href="/view/system/suserList.jsp" target="content">用户角色管理123</a></li>
                        <li><a href="/view/system/suserList.jsp" target="content">角色权限管理123</a></li>
                    </ul>
                </li>--%>
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

        <div class="row  border-bottom white-bg dashboard-header">
            <iframe  name="content" src="/hello.jsp"  width="100%" height="100%"  frameborder="0"></iframe>
        </div>
    </div>
</div>
<jsp:include page="/common_footer.jsp"></jsp:include>
<script type="text/javascript">

    var userId = sessionStorage.getItem("userId");
    var token = sessionStorage.getItem("token");

    $.ajax({
        url: url+"/system/userPermissionsList",
        type: "post",
        data:{
            "userId":userId
        },
        dataType: "json",
        headers:{"Access-Token":token,"Access-Source":"2"},
        success: function (obj) {
            if(1 != obj.code){
                sweetAlert(obj.message);
                location.href = "login.jsp";
            }else{
                $.each(obj.data ,function (index,value) {
                    /*alert(value.name);
                    alert(value.list);*/
                    $("#side-menu").append(
                        "<li class="+'"zhui"'+">" +
                        "<a class="+'"zhui"'+">" +
                        "<i class="+'"fa fa-th-large"'+"></i>" +
                        "<span class="+'"nav-label zhui"'+">"+value.name+"</span>" +
                        "<span class="+'"fa arrow"'+"></span>" +
                        "</a>" +
                        "<ul class="+'"nav nav-second-level collapse"'+" id='"+value.name+"'></ul>" +
                        "</li>")
                    var id = value.name;
                    $.each(value.list ,function (index,value) {
                        /*alert(value.name);*/
                        $("#"+id).append("<li class="+'"quanxian"'+"><a href='"+value.url+"' target="+"content"+">"+value.name+"</a></li>");
                    });

                });
            }
        },
        error: function (obj) {
            alert(obj);
        }
    });


    $("body").on("click","li",function(){
        /*alert("事件绑定成功！");*/

        $(this).siblings('li').removeClass('active');
        $("ul").removeClass('in');
        $(this).addClass('active');
        $(this).children("ul").addClass('in');

        /*$(this).addClass("active");
        $(this).parent().addClass("in");
        $(this).parent('li').addClass("active");*/
    });


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