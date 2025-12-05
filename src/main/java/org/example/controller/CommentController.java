package org.example.controller;

import org.example.model.Comment;
import org.example.model.User;
import org.example.service.CommentService;
import org.example.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class CommentController {
    @Autowired
    private CommentService commentService;

    // 发表评论接口
    @PostMapping("/api/comment/add")
    @ResponseBody
    public Result<String> addComment(Integer equipId, String content, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return Result.error("请先登录");
        }

        Comment comment = new Comment();
        comment.setUsername(loginUser.getUsername());
        comment.setEquipId(equipId);
        comment.setContent(content);

        boolean success = commentService.addComment(comment);
        if (success) {
            return Result.success("评论成功");
        } else {
            return Result.error("评论失败");
        }
    }
}