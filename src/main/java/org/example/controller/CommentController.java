package org.example.controller;

import org.example.model.Comment;
import org.example.model.User;
import org.example.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import javax.servlet.http.HttpSession;

@Controller
public class CommentController {
    // 注入CommentService（用于调用发表评论的业务方法）
    @Autowired
    private CommentService commentService;

    /**
     * 处理发表评论请求（表单提交路径：/comment/add）
     * @param equipId 评论对应的装备ID（从装备详情页传递）
     * @param content 用户输入的评论内容
     * @param session 用于获取当前登录用户的用户名（避免手动输入，保证安全性）
     */
    @PostMapping("/comment/add")
    public String addComment(@RequestParam Integer equipId,
                             @RequestParam String content,
                             HttpSession session) {
        // 1. 验证用户是否登录：未登录则跳转到登录页
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }

        // 2. 封装评论数据到Comment对象
        Comment comment = new Comment();
        comment.setUsername(loginUser.getUsername()); // 评论者用户名（从Session获取）
        comment.setEquipId(equipId);                  // 关联的装备ID
        comment.setContent(content);                  // 评论内容（用户输入）

        // 3. 调用Service发表评论（无需关注Mapper细节，由Service层封装）
        commentService.addComment(comment);

        // 4. 评论成功后，重定向回当前装备的详情页（刷新评论列表）
        return "redirect:/equipment/detail?id=" + equipId;
    }
}