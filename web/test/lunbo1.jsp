<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/23
  Time: 17:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>unslider演示</title>
    <script src="/js/jquery-1.11.1.min.js"></script>
    <script src="/js/unslider.min.js"></script>
    <style>
        html, body { font-family: Segoe, "Segoe UI", "DejaVu Sans", "Trebuchet MS", Verdana, sans-serif;}
        ul, ol { padding: 0;}

        .banner { position: relative; overflow: auto; text-align: center;}
        .banner li { list-style: none; }
        .banner ul li { float: left; }
    </style>
</head>

<body>

<style>
    #b06 { width: 640px;}
    #b06 .dots { position: absolute; left: 0; right: 0; bottom: 20px;}
    #b06 .dots li
    {
        display: inline-block;
        width: 10px;
        height: 10px;
        margin: 0 4px;
        text-indent: -999em;
        border: 2px solid #fff;
        border-radius: 6px;
        cursor: pointer;
        opacity: .4;
        -webkit-transition: background .5s, opacity .5s;
        -moz-transition: background .5s, opacity .5s;
        transition: background .5s, opacity .5s;
    }
    #b06 .dots li.active
    {
        background: #fff;
        opacity: 1;
    }
    #b06 .arrow { position: absolute; top: 200px;}
    #b06 #al { left: 15px;}
    #b06 #ar { right: 15px;}
</style>

<div class="banner" id="b06">
    <ul>
        <li><img class="sliderimg" src="/r/images/lunbo/01.jpg" alt="" width="100%" height="480px" ></li>
        <li><img class="sliderimg" src="/r/images/lunbo/02.jpg" alt="" width="100%" height="480px" ></li>
        <li><img class="sliderimg" src="/r/images/lunbo/03.jpg" alt="" width="100%" height="480px" ></li>
        <li><img class="sliderimg" src="/r/images/lunbo/04.jpg" alt="" width="100%" height="480px" ></li>
        <li><img class="sliderimg" src="/r/images/lunbo/05.jpg" alt="" width="100%" height="480px" ></li>
    </ul>
    <a href="javascript:void(0);" class="unslider-arrow06 prev"><img class="arrow" id="al" src="/r/images/lunbo/arrowl.png" alt="prev" width="20" height="35"></a>
    <a href="javascript:void(0);" class="unslider-arrow06 next"><img class="arrow" id="ar" src="/r/images/lunbo/arrowr.png" alt="next" width="20" height="37"></a>
</div>

<script>
    function imgReload()
    {
        var imgHeight = 0;
        var wtmp = $("body").width();
        $("#b06 ul li").each(function(){
            $(this).css({width:wtmp + "px"});
        });
        $(".sliderimg").each(function(){
            $(this).css({width:wtmp + "px"});
            imgHeight = $(this).height();
        });
    }

    $(window).resize(function(){imgReload();});

    $(document).ready(function(e) {
        imgReload();
        var unslider06 = $('#b06').unslider({
                dots: true,
                fluid: true
            }),
            data06 = unslider06.data('unslider');

        $('.unslider-arrow06').click(function() {
            var fn = this.className.split(' ')[1];
            data06[fn]();
        });
    });
</script>


<%--<h2>初始化参数说明</h2>
<span>这里说明的unslider版本较旧，新版本添加了一些，请自行对照。</span>
<table border="1">
    <thead>
    <th>参数</th><th>说明</th>
    </thead>
    <tbody>
    <tr>
        <td>speed</td>
        <td>图片切换的速度，数字，单位为毫秒</td>
    </tr>
    <tr>
        <td>delay</td>
        <td>图片停留的时间，数字，单位为毫秒</td>
    </tr>
    <tr>
        <td>complete</td>
        <td>每次图片切换完后的回调函数，function() {}</td>
    </tr>
    <tr>
        <td>keys</td>
        <td>是否支持键盘控制，取值true / false</td>
    </tr>
    <tr>
        <td>dots</td>
        <td>是否显示指示器，取值true / false</td>
    </tr>
    <tr>
        <td>fluid</td>
        <td>是否支持响应式布局，取值true / false</td>
    </tr>
    </tbody>
</table>--%>
</body>
</html>

