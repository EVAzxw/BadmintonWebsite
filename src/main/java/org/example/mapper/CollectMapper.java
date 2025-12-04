package org.example.mapper;

import org.example.model.Collect;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CollectMapper {
    // 新增收藏
    void insertCollect(Collect collect);
    // 取消收藏
    void deleteCollect(Collect collect);
    // 检查是否已收藏
    Integer checkCollect(Collect collect);
    // 查询用户的收藏列表
    List<Collect> selectCollectsByUsername(String username);
}