<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>${equipment.equipName} - 装备详情</title>
    <style>
        * {margin: 0; padding: 0; box-sizing: border-box; font-family: "微软雅黑"}
        .nav {background: #ff6600; color: white; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center;}
        .nav .logo {font-size: 20px; font-weight: bold;}
        .nav .user-info a {color: white; text-decoration: none; margin-left: 15px;}
        .container {width: 1200px; margin: 30px auto; padding: 0 20px;}
        .equip-detail {display: flex; gap: 30px; margin-bottom: 50px;}
        .equip-info h2 {color: #ff6600; margin-bottom: 20px;}
        .equip-info p {color: #333; margin-bottom: 10px; font-size: 16px;}
        .comment-section .section-title {font-size: 22px; color: #333; border-bottom: 2px solid #ff6600; padding-bottom: 10px; margin-bottom: 20px;}
        .comment-item {border: 1px solid #ddd; border-radius: 8px; padding: 15px; margin-bottom: 15px;}
        .comment-item .username {color: #ff6600; font-weight: bold;}
        .comment-item .time {color: #999; font-size: 12px; margin-left: 10px;}
        .comment-item .content {margin-top: 10px; color: #666;}
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
    <!-- 装备详情 -->
    <div class="equip-detail">
        <!-- 多图片区域（放在equip-detail内，和equip-info并列） -->
        <div class="equip-images" style="margin: 20px 0; display: flex; gap: 10px; flex-direction: column;">
            <c:forTokens items="${equipment.imageUrls}" delims="," var="imgUrl">
                <img src="${imgUrl}" alt="${equipment.equipName}" width="200" style="border: 1px solid #ddd; border-radius: 4px;">
            </c:forTokens>
        </div>
        <div class="equip-info">
            <h2>${equipment.equipName}</h2>
            <p><strong>品牌：</strong>${equipment.brand}</p>
            <p><strong>价格：</strong>¥${equipment.price}</p>
        </div>
    </div>

    <!-- 评论列表 -->
    <div class="comment-section">
        <div class="section-title">用户评论</div>

        <!-- 新增：评论提交表单（仅登录用户可见） -->
        <c:if test="${not empty loginUser}">
            <form action="${pageContext.request.contextPath}/comment/add" method="post" style="margin-bottom: 30px;">
                <!-- 隐藏参数：传递当前装备的ID（与详情页装备ID一致） -->
                <input type="hidden" name="equipId" value="${equipment.id}">

                <!-- 评论输入框（支持多行，限制非空） -->
                <div style="margin-bottom: 10px;">
                    <label style="display: block; margin-bottom: 8px; color: #333;">发表你的评论：</label>
                    <textarea name="content"
                              style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; resize: vertical;"
                              rows="4"
                              placeholder="请输入评论内容（不超过200字）..."
                              required></textarea>
                </div>

                <!-- 提交按钮（与网站主题色一致） -->
                <button type="submit" style="border: none; background: #ff6600; color: white; padding: 8px 15px; border-radius: 4px; cursor: pointer;">
                    提交评论
                </button>
            </form>
        </c:if>

        <c:forEach items="${commentList}" var="comment">
            <div class="comment-item">
                <div>
                    <span class="username">${comment.username}</span>
                    <span class="time"><fmt:formatDate value="${comment.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                </div>
                <div class="content">${comment.content}</div>
            </div>
        </c:forEach>
        <c:if test="${empty commentList}">
            <p>暂无评论~</p>
        </c:if>
    </div>
</div>
</body>
</html>