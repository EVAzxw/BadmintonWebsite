async function doLogin() {
    // 1. 获取表单数据
    const form = document.getElementById('login-form');
    const username = form.username.value;
    const password = form.password.value;

    if (!username || !password) {
        showError('请输入用户名和密码');
        return;
    }

    // 2. 发送请求
    // 使用我们在 utils.js 里写的 request 方法
    const res = await request('doLogin', 'POST', {
        username: username,
        password: password
    });

    // 3. 处理结果
    if (res && res.code === 200) {
        // 登录成功，跳转到首页
        window.location.href = 'index.html';
    } else {
        // 登录失败，显示错误信息
        showError(res ? res.msg : '登录失败');
    }
}

// 显示错误提示
function showError(msg) {
    const errorDiv = document.getElementById('error-msg');
    errorDiv.innerText = msg;
    errorDiv.style.display = 'block';
}