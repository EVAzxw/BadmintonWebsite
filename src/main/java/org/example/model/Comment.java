package org.example.model;

import java.util.Date;

// 评论实体类：映射comments表
public class Comment {
    private Integer id;         // 评论ID
    private Integer equipId;    // 关联装备ID
    private String username;    // 评论用户名
    private String content;     // 评论内容
    private Date createTime;    // 评论时间

    // getter和setter
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getEquipId() { return equipId; }
    public void setEquipId(Integer equipId) { this.equipId = equipId; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}