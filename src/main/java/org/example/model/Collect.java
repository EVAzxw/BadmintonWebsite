package org.example.model;

// 收藏实体类：映射collections表
public class Collect {
    private Integer id;         // 收藏ID
    private String username;    // 收藏用户名
    private Integer type;       // 类型（1=赛事，2=装备）
    private Integer targetId;   // 目标ID（赛事/装备ID）

    // getter和setter
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public Integer getType() { return type; }
    public void setType(Integer type) { this.type = type; }
    public Integer getTargetId() { return targetId; }
    public void setTargetId(Integer targetId) { this.targetId = targetId; }
}