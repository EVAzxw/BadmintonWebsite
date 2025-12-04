package org.example.mapper;

import org.example.model.Comment;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CommentMapper {
    // 根据装备ID查询评论列表
    List<Comment> selectCommentsByEquipId(Integer equipId);
    // 新增：插入评论（参数为Comment对象，返回受影响的行数）
    int insertComment(Comment comment);
}