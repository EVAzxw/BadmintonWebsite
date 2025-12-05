// 页面加载完成后自动执行
window.onload = function() {
    loadIndexData();
};

let currentUser = null; // 存储当前登录用户
let userCollects = [];  // 存储用户的收藏列表 (用于判断按钮颜色)

async function loadIndexData() {
    // 调用我们在后端写的 getIndexData 接口
    const res = await request('api/index-data', 'GET');

    if (res && res.code === 200) {
        const data = res.data;

        // 1. 处理用户信息
        currentUser = data.loginUser;
        userCollects = data.userCollects || []; // 如果没登录可能是null
        renderNavBar();

        // 2. 渲染赛事
        renderMatches(data.matchList);

        // 3. 渲染装备
        renderEquipments(data.equipList);
    }
}

// 渲染导航栏
function renderNavBar() {
    const navDiv = document.getElementById('nav-user-info');
    if (currentUser) {
        navDiv.innerHTML = `
            <span>欢迎您，${currentUser.username}！</span>
            <a href="collectList.html">我的收藏</a>
            <a href="#" onclick="doLogout()">退出登录</a>
        `;
    } else {
        navDiv.innerHTML = `<a href="login.html">登录</a> | <a href="register.html">注册</a>`;
    }
}

// 渲染赛事列表
function renderMatches(list) {
    const container = document.getElementById('match-container');
    let html = '';

    list.forEach(match => {
        // 判断该赛事是否在用户的收藏列表中
        const isCollected = checkCollected(1, match.id);
        const btnText = isCollected ? '已收藏 ✓' : '收藏赛事';
        const btnClass = isCollected ? 'btn-collected' : 'btn-collect';

        html += `
            <div class="card">
                <h3>${match.matchName}</h3>
                <p>时间：${match.matchTime}</p>
                <p>地点：${match.location}</p>
                <p>要求：${match.requirement}</p>
                <button class="btn-small ${btnClass}" onclick="toggleCollect(1, ${match.id}, this)">
                    ${btnText}
                </button>
            </div>
        `;
    });
    container.innerHTML = html;
}

// 渲染装备列表
function renderEquipments(list) {
    const container = document.getElementById('equip-container');
    let html = '';

    list.forEach(equip => {
        const isCollected = checkCollected(2, equip.id);
        const btnText = isCollected ? '已收藏 ✓' : '收藏装备';
        const btnClass = isCollected ? 'btn-collected' : 'btn-collect';

        html += `
            <div class="card">
                <img src="${equip.imageUrl}" width="100%" height="200">
                <h3><a href="equipment.html?id=${equip.id}">${equip.equipName}</a></h3>
                <p>品牌：${equip.brand}</p>
                <p>价格：¥${equip.price}</p>
                <button class="btn-small ${btnClass}" onclick="toggleCollect(2, ${equip.id}, this)">
                    ${btnText}
                </button>
            </div>
        `;
    });
    container.innerHTML = html;
}

// 检查是否已收藏 (辅助函数)
function checkCollected(type, targetId) {
    if (!userCollects) return false;
    // 数组查找：是否存在类型和ID都匹配的记录
    return userCollects.some(c => c.type === type && c.targetId === targetId);
}

// 点击收藏/取消收藏按钮
async function toggleCollect(type, targetId, btnElement) {
    if (!currentUser) {
        alert('请先登录！');
        window.location.href = 'login.html';
        return;
    }

    const res = await request('api/collect/toggle', 'POST', {
        type: type,
        targetId: targetId
    });

    if (res && res.code === 200) {
        // 根据后端返回的状态修改按钮样式
        if (res.data === 'collected') {
            btnElement.innerText = '已收藏 ✓';
            btnElement.className = 'btn-small btn-collected';
        } else {
            btnElement.innerText = '收藏';
            btnElement.className = 'btn-small btn-collect';
        }
    } else {
        alert(res.msg);
    }
}

async function doLogout() {
    await request('logout', 'GET');
    window.location.reload();
}