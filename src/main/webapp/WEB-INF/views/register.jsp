<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>羽毛球网站 - 注册</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        body {
            font-family: "微软雅黑", sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .register-box {
            background-color: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 350px;
        }
        .register-box h2 {
            text-align: center;
            color: #ff6600;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .error-msg {
            color: red;
            text-align: center;
            margin-bottom: 15px;
        }
        .btn-register {
            width: 100%;
            padding: 12px;
            background-color: #ff6600;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn-register:hover {
            background-color: #e55a00;
        }
        .login-link {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }
        .login-link a {
            color: #ff6600;
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="register-box">
    <h2>羽毛球网站 - 注册</h2>
    <!-- 显示注册错误提示 -->
    <c:if test="${not empty errorMsg}">
        <div class="error-msg">${errorMsg}</div>
    </c:if>
    <!-- 注册表单：提交到/doRegister -->
    <form action="${pageContext.request.contextPath}/doRegister" method="post">
        <div class="form-group">
            <label for="username">用户名</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">密码</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <label for="phone">手机号（可选）</label>
            <input type="tel" id="phone" name="phone">
        </div>
        <button type="submit" class="btn-register">注册</button>
        <div class="login-link">
            已有账号？<a href="${pageContext.request.contextPath}/login">立即登录</a>
        </div>
    </form>
</div>
</body>
</html>