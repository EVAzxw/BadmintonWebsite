package org.example.controller;

import org.example.model.Collect;
import org.example.model.User;
import org.example.service.CollectService;
import org.example.service.EquipmentService;
import org.example.service.MatchService;
import org.example.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CollectController {
    @Autowired
    private CollectService collectService;
    @Autowired
    private MatchService matchService;
    @Autowired
    private EquipmentService equipmentService;

    // 切换收藏状态
    @PostMapping("/api/collect/toggle")
    @ResponseBody
    public Result<String> toggleCollect(Integer type, Integer targetId, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return Result.error("请先登录");
        }

        Collect collect = new Collect();
        collect.setUsername(loginUser.getUsername());
        collect.setType(type);
        collect.setTargetId(targetId);

        boolean isCollected = collectService.toggleCollect(collect);
        // 返回现在的状态：true=已收藏，false=已取消
        return Result.success(isCollected ? "collected" : "canceled");
    }

    // 收藏列表数据接口
    @GetMapping("/api/collect/list")
    @ResponseBody
    public Result<Map<String, Object>> getCollectList(HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return Result.error("unauthorized"); // 前端收到这个code应该跳去登录页
        }

        Map<String, Object> data = new HashMap<>();
        data.put("collectList", collectService.getCollectsByUsername(loginUser.getUsername()));
        // 这里把所有数据都给前端，让前端JS去根据ID匹配显示（这是一种简单做法）
        data.put("allMatches", matchService.getAllMatches());
        data.put("allEquips", equipmentService.getAllEquipments());
        data.put("loginUser", loginUser);

        return Result.success(data);
    }
}