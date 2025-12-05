const equipId = getQueryParam('id'); // 从 utils.js 里的工具方法获取 URL 里的 id

window.onload = function() {
    if(!equipId) {
        alert("参数错误");
        window.location.href = 'index.html';
        return;
    }
    loadDetail();
};

async function loadDetail() {
    const res = await request('api/equipment/detail', 'GET', { id: equipId });
    if (res && res.code === 200) {
        renderInfo(res.data.equipment);
        renderComments(res.data.commentList);
    } else {
        alert(res.msg);
    }
}

function renderInfo(equip) {
    // 处理多图：假设 imageUrls 是逗号分隔的字符串
    let imagesHtml = '';
    if (equip.imageUrls) {
        const urls = equip.imageUrls.split(',');
        urls.forEach(url => {
            imagesHtml += `<img src="${url}" style="width: 200px; border:1px solid #ddd; border-radius:4px;">`;
        });
    }

    const html = `
        <div class="detail-container">
            <div style="display:flex; flex-direction:column; gap:10px;">
                ${imagesHtml}
            </div>
            <div class="detail-info">
                <h2>${equip.equipName}</h2>
                <p><strong>品牌：</strong>${equip.brand}</p>
                <p><strong>价格：</strong>¥${equip.price}</p>
            </div>
        </div>
    `;
    document.getElementById('equip-detail-area').innerHTML = html;
}

function renderComments(list) {
    const container = document.getElementById('comment-list-area');
    if (!list || list.length === 0) {
        container.innerHTML = '<p style="padding:20px; color:#999">暂无评论</p>';
        return;
    }

    let html = '';
    list.forEach(c => {
        // 简单的日期格式化
        const dateStr = new Date(c.createTime).toLocaleString();
        html += `
            <div class="comment-item">
                <div class="comment-meta">
                    <span class="comment-user">${c.username}</span> 
                    <span>${dateStr}</span>
                </div>
                <div class="content">${c.content}</div>
            </div>
        `;
    });
    container.innerHTML = html;
}

async function submitComment() {
    const content = document.getElementById('comment-content').value;
    if (!content) {
        alert("请填写评论内容");
        return;
    }

    const res = await request('api/comment/add', 'POST', {
        equipId: equipId,
        content: content
    });

    if (res && res.code === 200) {
        alert('评论成功');
        document.getElementById('comment-content').value = ''; // 清空输入框
        loadDetail(); // 重新加载列表
    } else {
        alert(res.msg); // 可能是没登录
        if(res.msg.includes('登录')) {
            window.location.href = 'login.html';
        }
    }
}