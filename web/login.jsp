<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/6
  Time: 22:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>free-登陆页</title>
<jsp:include page="common_header.jsp"></jsp:include>
</head>
<body>
<div class="middle-box text-center loginscreen animated fadeInDown">
    <div>
        <div>

            <h2 class="logo-name">free</h2>

        </div>
        <form class="m-t" role="form" action="index.html">
            <div class="form-group">
                <input type="email" class="form-control" placeholder="Username" required="" id="userName">
            </div>
            <div class="form-group">
                <input type="password" class="form-control" placeholder="Password" required="" id="password">
            </div>

            <button type="button" class="btn btn-primary block full-width m-b" onclick="login()">Login</button>

            <%--<a href="login.html#"><small>Forgot password?</small></a>--%>
        </form>
    </div>
</div>
<jsp:include page="common_footer.jsp"></jsp:include>
<script>
    function login() {

        $.ajax({
            url: url+"/system/login",
            type: "post",
            data:{
                "userName":$("#userName").val(),
                "password":$("#password").val()
            },
            dataType: "json",
            success: function (obj) {
                if(1 != obj.code){
                    sweetAlert(obj.message);
                }else{
                    /*alert(obj.data.token);
                    alert(obj.data.userName);
                    alert(obj.data.userId);*/
                    sessionStorage.setItem("token",obj.data.token);
                    sessionStorage.setItem("userId",obj.data.userId);
                    sessionStorage.setItem("userName",obj.data.userName);
                    location.href="index.jsp";

                }
            },
            /*error: function (obj) {
                alert(obj.message);
            }*/
            error: function (jqXHR, textStatus, errorThrown) {
                alert("jqXHR.responseText:"+"["+jqXHR.responseText+"]---"+
                    "jqXHR.status"+"["+jqXHR.status+"]---"+
                    "jqXHR.readyState"+"["+jqXHR.readyState+"]---"+
                    "jqXHR.statusText"+"["+jqXHR.statusText+"]---"+
                    "textStatus"+"["+textStatus+"]---"+
                    "errorThrown"+"["+errorThrown+"]");
            }
        });
    }

</script>
</body>
</html>
