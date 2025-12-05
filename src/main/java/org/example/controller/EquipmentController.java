package org.example.controller;

import org.example.model.Comment;
import org.example.model.Equipment;
import org.example.service.CommentService;
import org.example.service.EquipmentService;
import org.example.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EquipmentController {
    @Autowired
    private EquipmentService equipmentService;
    @Autowired
    private CommentService commentService;

    // 装备详情接口
    @GetMapping("/api/equipment/detail")
    @ResponseBody
    public Result<Map<String, Object>> getEquipDetail(@RequestParam Integer id) {
        // 1. 查装备信息
        Equipment equipment = equipmentService.getAllEquipments().stream()
                .filter(e -> e.getId().equals(id))
                .findFirst()
                .orElse(null);

        if (equipment == null) {
            return Result.error("装备不存在");
        }

        // 2. 查评论
        List<Comment> commentList = commentService.getCommentsByEquipId(id);

        Map<String, Object> data = new HashMap<>();
        data.put("equipment", equipment);
        data.put("commentList", commentList);

        return Result.success(data);
    }
}