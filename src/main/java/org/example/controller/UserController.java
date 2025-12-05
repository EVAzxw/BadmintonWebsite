package org.example.controller;

import org.example.model.Collect;
import org.example.model.User;
import org.example.service.CollectService;
import org.example.service.EquipmentService;
import org.example.service.MatchService;
import org.example.service.UserService;
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
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private MatchService matchService;
    @Autowired
    private EquipmentService equipmentService;
    @Autowired
    private CollectService collectService;

    // 获取当前登录用户（前端初始化时调用）
    @GetMapping("/user/current")
    @ResponseBody
    public Result<User> getCurrentUser(HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        return Result.success(user); // 没登录就是null，前端自己判断
    }

    // 首页数据接口：一次性返回赛事、装备、用户收藏信息
    @GetMapping("/api/index-data")
    @ResponseBody
    public Result<Map<String, Object>> getIndexData(HttpSession session) {
        Map<String, Object> data = new HashMap<>();

        // 1. 所有赛事和装备
        data.put("matchList", matchService.getAllMatches());
        data.put("equipList", equipmentService.getAllEquipments());

        // 2. 如果用户登录了，获取他的收藏列表（用于前端显示已收藏状态）
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser != null) {
            List<Collect> userCollects = collectService.getCollectsByUsername(loginUser.getUsername());
            data.put("userCollects", userCollects);
            data.put("loginUser", loginUser);
        }

        return Result.success(data);
    }

    // 注册接口
    @PostMapping("/doRegister")
    @ResponseBody
    public Result<String> doRegister(User user) {
        int result = userService.register(user);
        if (result == 1) {
            return Result.success("注册成功");
        } else if (result == 0) {
            return Result.error("用户名已被占用");
        } else {
            return Result.error("注册失败，请重试");
        }
    }

    // 登录接口
    @PostMapping("/doLogin")
    @ResponseBody
    public Result<User> doLogin(String username, String password, HttpSession session) {
        User loginUser = userService.login(username, password);
        if (loginUser != null) {
            session.setAttribute("loginUser", loginUser);
            return Result.success(loginUser);
        } else {
            return Result.error("用户名或密码错误");
        }
    }

    // 注销接口
    @GetMapping("/logout")
    @ResponseBody
    public Result<String> logout(HttpSession session) {
        session.invalidate();
        return Result.success("已退出登录");
    }
}