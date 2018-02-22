<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>验证码</title>
</head>
<body>
<div> 用户登录</div>
<div>
    <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post">
        <div style="height:40px;">
            <label class="tip">登&nbsp;录&nbsp;名:&nbsp;&nbsp; </label>
            <input name="name" type="text" id="name"/>
        </div>
        <div style="height:40px;">
            <label class="tip">密 &nbsp;&nbsp;码：&nbsp;&nbsp;</label>
            <input type="password" id="password" name="password"/>
        </div>
        <div style="height:60px;">
            <label class="tip">验&nbsp;证&nbsp;码:&nbsp;&nbsp; </label>
            <input type="text" name="verifyCode" id="verifyCode" onblur="checkCode()"/>
            <img src="${ctx}/kaptcha/image" width="110" height="26" id="kaptchaImage"
                 onclick="changeImage()"  style="margin-bottom:-10px;"/>
        </div>
        <div style="height:40px;">
            <label class="tip">结 &nbsp;&nbsp;果：&nbsp;&nbsp;</label>
            <input type="text"  id="result" readonly="readonly" style="color: brown"/>
        </div>
        <div style="margin-left:15px">
            <input type="button" class="login-btn" value="登录"/>
            <input type="reset" class="login-btn" style="margin-left:10px;" value="重置"/>
        </div>
    </form>
</div>
<script type="text/javascript" src="${ctx}/js/jquery-3.0.0.js"></script>
<script type="text/javascript">
    function changeImage() {
        $("#kaptchaImage").attr("src", "${ctx}/kaptcha/image?nocache=" + new Date().getTime());
    }

    function checkCode() {
        var code = $("#verifyCode").val();
        if (code.replace(/\s/g, "") == "") {
            $("#result").val("请输入验证码");
        } else {
            //异步检查验证码是否输入正确
            var url = "${ctx}/kaptcha/check";
            $.ajax({
                type: "POST",
                url: url,
                data: {"code": code},
                success: function (data) {
                    if (data == true) {
                        //验证码正确，进行提交操作
                        $("#result").val("输入正确 ！");
                    } else {
                        $("#result").val("验证码错误，请重新输入！");
                    }
                },
                error: function (e) {
                    alert(e);
                }
            });
        }
    }

</script>
</body>
</html>
