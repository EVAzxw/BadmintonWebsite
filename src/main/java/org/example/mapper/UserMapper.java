package org.example.mapper;

import org.example.model.User;
import org.springframework.stereotype.Repository;

// @Repository：标记为数据访问层组件，让Spring扫描识别
@Repository
public interface UserMapper {
    // 1. 根据用户名查询用户（登录时验证用户名和密码）
    User selectByUsername(String username);

    // 2. 新增用户（注册时插入新用户数据）
    int insertUser(User user);
}