window.onload = function() {
    loadCollects();
};

async function loadCollects() {
    const res = await request('api/collect/list', 'GET');

    if (res && res.code === 200) {
        const data = res.data;
        renderList(data);
    } else {
        alert(res.msg);
        window.location.href = 'login.html';
    }
}

function renderList(data) {
    const collects = data.collectList;
    const matches = data.allMatches;
    const equips = data.allEquips;
    const container = document.getElementById('collect-container');

    if (collects.length === 0) {
        container.innerHTML = '<p style="margin:20px">暂无收藏</p>';
        return;
    }

    let html = '';

    collects.forEach(c => {
        // 类型1是赛事
        if (c.type === 1) {
            const match = matches.find(m => m.id === c.targetId);
            if (match) {
                html += `
                    <div class="card">
                        <h3>[赛事] ${match.matchName}</h3>
                        <p>${match.matchTime} @ ${match.location}</p>
                        <button class="btn-small btn-cancel" onclick="cancelCollect(1, ${match.id})">取消收藏</button>
                    </div>
                `;
            }
        }
        // 类型2是装备
        else if (c.type === 2) {
            const equip = equips.find(e => e.id === c.targetId);
            if (equip) {
                html += `
                    <div class="card">
                        <h3>[装备] ${equip.equipName}</h3>
                        <p>¥${equip.price}</p>
                        <button class="btn-small btn-cancel" onclick="cancelCollect(2, ${equip.id})">取消收藏</button>
                    </div>
                `;
            }
        }
    });

    container.innerHTML = html;
}

async function cancelCollect(type, id) {
    if(confirm('确定取消收藏吗？')) {
        const res = await request('api/collect/toggle', 'POST', {
            type: type,
            targetId: id
        });
        if (res.code === 200) {
            loadCollects(); // 刷新页面
        }
    }
}