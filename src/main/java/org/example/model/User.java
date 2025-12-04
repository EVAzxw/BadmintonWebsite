package org.example.model;

import java.util.Date;

// 用户实体类：映射数据库users表
public class User {
    private Integer id;         // 用户ID（自增）
    private String username;    // 用户名（唯一）
    private String password;    // 密码（MD5加密后）
    private String phone;       // 手机号（可选）
    private Date createTime;    // 创建时间（自动填充）

    // getter和setter方法（必须，Spring MVC才能接收前端参数、MyBatis才能映射数据库字段）
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}