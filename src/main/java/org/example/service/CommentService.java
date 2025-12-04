package org.example.service;

import org.example.mapper.CommentMapper;
import org.example.model.Comment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CommentService {
    @Autowired
    private CommentMapper commentMapper;

    // 根据装备ID获取评论列表
    public List<Comment> getCommentsByEquipId(Integer equipId) {
        return commentMapper.selectCommentsByEquipId(equipId);
    }

    // 新增：发表评论（返回true表示成功，false表示失败）
    public boolean addComment(Comment comment) {
        // 调用Mapper插入评论，受影响行数>=1则表示成功
        int rows = commentMapper.insertComment(comment);
        return rows > 0;
    }
}