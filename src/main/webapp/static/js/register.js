async function doRegister() {
    const form = document.getElementById('register-form');

    // 参数准备
    const params = {
        username: form.username.value,
        password: form.password.value,
        phone: form.phone.value
    };

    if (!params.username || !params.password) {
        alert("用户名和密码必填");
        return;
    }

    const res = await request('doRegister', 'POST', params);

    if (res && res.code === 200) {
        alert('注册成功，请登录！');
        window.location.href = 'login.html';
    } else {
        document.getElementById('error-msg').innerText = res.msg;
        document.getElementById('error-msg').style.display = 'block';
    }
}