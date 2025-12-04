package org.example.service;

import org.example.mapper.UserMapper;
import org.example.model.User;
import org.example.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

// @Service：标记为业务逻辑层组件，让Spring扫描识别
@Service
public class UserService {

    // @Autowired：自动注入UserMapper实例（Spring自动创建，无需手动new）
    @Autowired
    private UserMapper userMapper;

    /**
     * 用户注册业务逻辑
     * @param user 前端传入的用户对象（包含username、password、phone）
     * @return 注册结果：1=成功，0=用户名已存在，-1=注册失败
     */
    public int register(User user) {
        // 1. 校验用户名是否已存在（查询数据库）
        User existingUser = userMapper.selectByUsername(user.getUsername());
        if (existingUser != null) {
            return 0; // 用户名已存在
        }

        // 2. 将明文密码MD5加密后存入user对象
        String encryptedPassword = MD5Util.encrypt(user.getPassword());
        user.setPassword(encryptedPassword);

        // 3. 插入新用户到数据库
        try {
            return userMapper.insertUser(user); // 插入成功返回1，失败返回0
        } catch (Exception e) {
            e.printStackTrace();
            return -1; // 注册失败（数据库异常）
        }
    }

    /**
     * 用户登录业务逻辑
     * @param username 前端传入的用户名
     * @param password 前端传入的明文密码
     * @return 登录成功返回User对象，失败返回null
     */
    public User login(String username, String password) {
        // 1. 根据用户名查询数据库中的用户
        User user = userMapper.selectByUsername(username);
        if (user == null) {
            return null; // 用户名不存在
        }

        // 2. 将前端传入的明文密码加密，与数据库中的加密密码对比
        String encryptedPassword = MD5Util.encrypt(password);
        if (encryptedPassword.equals(user.getPassword())) {
            return user; // 密码一致，登录成功
        } else {
            return null; // 密码不一致，登录失败
        }
    }
}