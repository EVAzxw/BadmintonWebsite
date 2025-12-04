package org.example.model;

// 赛事实体类：映射数据库matches表
public class Match {
    private Integer id;         // 赛事ID
    private String matchName;   // 赛事名称
    private String matchTime;   // 赛事时间
    private String location;    // 赛事地点
    private String requirement; // 参赛要求
    private String imageUrl;    // 赛事图片路径

    // getter和setter方法
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public String getMatchName() {
        return matchName;
    }
    public void setMatchName(String matchName) {
        this.matchName = matchName;
    }
    public String getMatchTime() {
        return matchTime;
    }
    public void setMatchTime(String matchTime) {
        this.matchTime = matchTime;
    }
    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
        this.location = location;
    }
    public String getRequirement() {
        return requirement;
    }
    public void setRequirement(String requirement) {
        this.requirement = requirement;
    }
    public String getImageUrl() {
        return imageUrl;
    }
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}