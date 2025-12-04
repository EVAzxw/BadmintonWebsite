package org.example.service;

import org.example.mapper.CollectMapper;
import org.example.model.Collect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CollectService {
    @Autowired
    private CollectMapper collectMapper;

    // 收藏（如果未收藏则新增，已收藏则取消）
    public boolean toggleCollect(Collect collect) {
        Integer count = collectMapper.checkCollect(collect);
        if (count > 0) {
            collectMapper.deleteCollect(collect);
            return false; // 已取消收藏
        } else {
            collectMapper.insertCollect(collect);
            return true; // 已收藏
        }
    }

    // 查询用户收藏列表
    public List<Collect> getCollectsByUsername(String username) {
        return collectMapper.selectCollectsByUsername(username);
    }
}