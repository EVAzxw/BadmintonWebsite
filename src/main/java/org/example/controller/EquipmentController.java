package org.example.controller;

import org.example.model.Comment;
import org.example.model.Equipment;
import org.example.service.CommentService;
import org.example.service.EquipmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class EquipmentController {
    @Autowired
    private EquipmentService equipmentService;
    @Autowired
    private CommentService commentService;

    /**
     * 跳转到装备详情页（含评论）
     */
    @GetMapping("/equipment/detail")
    public String toEquipDetail(@RequestParam Integer id, Model model, HttpSession session) {
        // 1. 查询装备详情
        Equipment equipment = equipmentService.getAllEquipments().stream()
                .filter(e -> e.getId().equals(id))
                .findFirst()
                .orElse(null);
        if (equipment == null) {
            return "redirect:/index"; // 装备不存在则跳首页
        }
        // 2. 查询该装备的评论
        List<Comment> commentList = commentService.getCommentsByEquipId(id);
        // 3. 传递数据到页面
        model.addAttribute("equipment", equipment);
        model.addAttribute("commentList", commentList);
        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        return "equipment";
    }
}