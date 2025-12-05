/**
 * 封装的统一请求方法
 * @param {string} url 请求地址
 * @param {string} method 请求方法 (GET, POST)
 * @param {object} params 参数数据 (对象)
 * @returns {Promise} 返回Promise对象
 */
async function request(url, method = 'GET', params = null) {
    // 基础配置
    const options = {
        method: method,
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded' // 表单格式提交
        }
    };

    // 处理参数
    if (params) {
        const formData = new URLSearchParams();
        for (const key in params) {
            formData.append(key, params[key]);
        }

        if (method === 'GET') {
            url += '?' + formData.toString();
        } else {
            options.body = formData;
        }
    }

    try {
        const response = await fetch(url, options);
        // 如果后端返回JSON，解析它
        const res = await response.json();
        return res;
    } catch (error) {
        console.error('API请求错误:', error);
        alert('网络请求失败，请检查控制台');
        return null;
    }
}

// 获取URL栏的参数 (例如 ?id=1)
function getQueryParam(name) {
    const reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    const r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}