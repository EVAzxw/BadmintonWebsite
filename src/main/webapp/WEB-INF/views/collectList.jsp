<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>我的收藏 - 羽毛球网站</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "微软雅黑", sans-serif;
        }
        .nav {
            background-color: #ff6600;
            padding: 15px 20px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .nav .logo {
            font-size: 20px;
            font-weight: bold;
        }
        .nav .user-info a {
            color: white;
            text-decoration: none;
            margin-left: 15px;
        }
        .container {
            width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .section-title {
            font-size: 22px;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #ff6600;
        }
        .collect-list {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }
        .collect-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
        }
        .collect-card h3 {
            color: #ff6600;
            margin-bottom: 10px;
        }
        .collect-card p {
            color: #666;
            margin-bottom: 8px;
            font-size: 14px;
        }
        .btn-cancel {
            border: none;
            background: #ff4444;
            color: white;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
        }
        .empty-tip {
            color: #999;
            text-align: center;
            padding: 50px 0;
            font-size: 18px;
        }
    </style>
</head>
<body>
<!-- 导航栏 -->
<div class="nav">
    <div class="logo">羽毛球网站</div>
    <div class="user-info">
        <span>欢迎您，${loginUser.username}！</span>
        <a href="${pageContext.request.contextPath}/index">首页</a>
        <a href="${pageContext.request.contextPath}/logout">退出登录</a>
    </div>
</div>

<!-- 内容容器 -->
<div class="container">
    <div class="section-title">我的收藏</div>

    <!-- 空收藏提示 -->
    <c:if test="${empty collectList}">
        <div class="empty-tip">您的收藏夹还是空的，去首页收藏赛事或装备吧！</div>
    </c:if>

    <!-- 收藏列表 -->
    <div class="collect-list">
        <c:forEach items="${collectList}" var="col">
            <!-- 赛事收藏项 -->
            <c:if test="${col.type == 1}">
                <c:forEach items="${allMatches}" var="match">
                    <c:if test="${match.id == col.targetId}">
                        <div class="collect-card">
                            <h3>${match.matchName}</h3>
                            <p>时间：${match.matchTime}</p>
                            <p>地点：${match.location}</p>
                            <p>要求：${match.requirement}</p>
                            <form action="/collect/toggle" method="post">
                                <input type="hidden" name="type" value="1">
                                <input type="hidden" name="targetId" value="${match.id}">
                                <button type="submit" class="btn-cancel">取消收藏</button>
                            </form>
                        </div>
                    </c:if>
                </c:forEach>
            </c:if>

            <!-- 装备收藏项 -->
            <c:if test="${col.type == 2}">
                <c:forEach items="${allEquips}" var="equip">
                    <c:if test="${equip.id == col.targetId}">
                        <div class="collect-card">
                            <img src="${equip.imageUrl}" alt="${equip.equipName}" width="100%" style="border-radius: 8px; margin-bottom: 10px;">
                            <h3>${equip.equipName}</h3>
                            <p>品牌：${equip.brand}</p>
                            <p>价格：¥${equip.price}</p>
                            <form action="/collect/toggle" method="post">
                                <input type="hidden" name="type" value="2">
                                <input type="hidden" name="targetId" value="${equip.id}">
                                <button type="submit" class="btn-cancel">取消收藏</button>
                            </form>
                        </div>
                    </c:if>
                </c:forEach>
            </c:if>
        </c:forEach>
    </div>
</div>
</body>
</html>