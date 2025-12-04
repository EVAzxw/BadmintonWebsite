package org.example.model;

// 装备实体类：映射数据库equipment表
public class Equipment {
    private Integer id;         // 装备ID
    private String equipName;   // 装备名称
    private String brand;       // 品牌
    private Double price;       // 价格
    private String imageUrl;    // 图片路径
    private String imageUrls; // 对应数据库的image_urls

    // getter和setter
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getEquipName() { return equipName; }
    public void setEquipName(String equipName) { this.equipName = equipName; }
    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }
    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public String getImageUrls() { return imageUrls; }
    public void setImageUrls(String imageUrls) { this.imageUrls = imageUrls; }
}