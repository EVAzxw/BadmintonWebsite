package org.example.controller;

import org.example.model.Collect;
import org.example.service.CollectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import javax.servlet.http.HttpSession;

import org.example.service.MatchService;
import org.example.service.EquipmentService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;

import java.util.List;

@Controller
public class CollectController {
    @Autowired
    private CollectService collectService;

    @Autowired
    private MatchService matchService;
    @Autowired
    private EquipmentService equipmentService;

    /**
     * 切换收藏状态（收藏/取消）
     */
    @PostMapping("/collect/toggle")
    public String toggleCollect(@RequestParam Integer type,
                                @RequestParam Integer targetId,
                                HttpSession session) {
        String username = ((org.example.model.User) session.getAttribute("loginUser")).getUsername();
        Collect collect = new Collect();
        collect.setUsername(username);
        collect.setType(type);
        collect.setTargetId(targetId);
        collectService.toggleCollect(collect);
        // 直接重定向回首页（替代原来的currentUrl）
        return "redirect:/index";
    }

    // 新增：跳转到收藏列表页的方法
    @GetMapping("/collect/list")
    public String toCollectList(HttpSession session, Model model) {
        // 1. 获取当前登录用户
        org.example.model.User loginUser = (org.example.model.User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login"; // 未登录则跳登录页
        }
        // 2. 获取用户的所有收藏记录
        List<Collect> collectList = collectService.getCollectsByUsername(loginUser.getUsername());
        // 3. 获取所有赛事和装备数据（用于匹配收藏的目标信息）
        List<org.example.model.Match> allMatches = matchService.getAllMatches();
        List<org.example.model.Equipment> allEquips = equipmentService.getAllEquipments();
        // 4. 把数据传递到前端页面
        model.addAttribute("collectList", collectList);
        model.addAttribute("allMatches", allMatches);
        model.addAttribute("allEquips", allEquips);
        model.addAttribute("loginUser", loginUser);
        return "collectList"; // 对应WEB-INF/views/collectList.jsp
    }
}