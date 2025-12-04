<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>羽毛球网站 - 首页</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "微软雅黑", sans-serif;
        }
        /* 导航栏样式 */
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
        .nav .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .nav .user-info a {
            color: white;
            text-decoration: none;
        }
        .nav .user-info a:hover {
            text-decoration: underline;
        }
        /* 内容容器 */
        .container {
            width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        /* 赛事列表标题 */
        .section-title {
            font-size: 22px;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #ff6600;
        }
        /* 赛事卡片列表 */
        .match-list {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }
        .match-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            transition: box-shadow 0.3s;
        }
        .match-card:hover {
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .match-card h3 {
            color: #ff6600;
            margin-bottom: 10px;
        }
        .match-card p {
            color: #666;
            margin-bottom: 8px;
            font-size: 14px;
        }
    </style>
</head>
<body>
<!-- 导航栏 -->
<div class="nav">
    <div class="logo">羽毛球网站</div>
    <div class="user-info">
        <span>欢迎您，${loginUser.username}！</span>
        <a href="${pageContext.request.contextPath}/collect/list" style="color: white; margin: 0 10px;">我的收藏</a>
        <a href="${pageContext.request.contextPath}/logout">退出登录</a>
    </div>
</div>

<!-- 内容容器 -->
<div class="container">
    <!-- 赛事列表区域 -->
    <div class="section-title">近期赛事</div>
    <div class="match-list">
        <c:forEach items="${matchList}" var="match">
            <div class="match-card">
                <h3>${match.matchName}</h3>
                <p>时间：${match.matchTime}</p>
                <p>地点：${match.location}</p>
                <p>要求：${match.requirement}</p>
                <!-- 赛事收藏按钮（添加在这里） -->
                <form action="/collect/toggle" method="post" style="margin-top: 10px;">
                    <input type="hidden" name="type" value="1">
                    <input type="hidden" name="targetId" value="${match.id}">
                    <!-- 判断当前赛事是否已被用户收藏 -->
                    <c:set var="isCollected" value="false" />
                    <c:forEach items="${userCollects}" var="col">
                        <c:if test="${col.type == 1 && col.targetId == match.id}">
                            <c:set var="isCollected" value="true" />
                        </c:if>
                    </c:forEach>
                    <!-- 按钮样式根据收藏状态变化 -->
                    <button type="submit" style="border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer;
                    ${isCollected ? 'background: #e55a00; color: white;' : 'background: #ff6600; color: white;'}">
                            ${isCollected ? '已收藏 ✓' : '收藏赛事'}
                    </button>
                </form>
            </div>
        </c:forEach>
    </div>

    <!-- 装备列表区域 -->
    <div class="section-title" style="margin-top: 50px;">热门装备</div>
    <div class="match-list">
        <c:forEach items="${equipList}" var="equip">
            <div class="match-card">
                <!-- 主图（移动到循环内） -->
                <img src="${equip.imageUrl}" alt="${equip.equipName}" width="100%" style="border-radius: 8px; margin-bottom: 10px;">
                <h3><a href="/equipment/detail?id=${equip.id}" style="color: #ff6600; text-decoration: none;">${equip.equipName}</a></h3>
                <p>品牌：${equip.brand}</p>
                <p>价格：¥${equip.price}</p>
                <!-- 替换后的装备收藏按钮（带状态判断） -->
                <form action="/collect/toggle" method="post" style="margin-top: 10px;">
                    <input type="hidden" name="type" value="2">
                    <input type="hidden" name="targetId" value="${equip.id}">
                    <!-- 判断当前装备是否已被用户收藏 -->
                    <c:set var="isCollected" value="false" />
                    <c:forEach items="${userCollects}" var="col">
                        <c:if test="${col.type == 2 && col.targetId == equip.id}">
                            <c:set var="isCollected" value="true" />
                        </c:if>
                    </c:forEach>
                    <!-- 按钮样式根据收藏状态变化 -->
                    <button type="submit" style="border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer;
                    ${isCollected ? 'background: #e55a00; color: white;' : 'background: #ff6600; color: white;'}">
                            ${isCollected ? '已收藏 ✓' : '收藏装备'}
                    </button>
                </form>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>