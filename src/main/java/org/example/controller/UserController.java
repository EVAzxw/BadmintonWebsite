package org.example.controller;

import org.example.model.Collect;
import org.example.model.Match;
import org.example.model.User;
import org.example.service.CollectService;
import org.example.service.EquipmentService;
import org.example.service.MatchService;
import org.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

// @Controller：标记为Spring MVC控制器，处理HTTP请求
@Controller
public class UserController {

    // 自动注入UserService实例
    @Autowired
    private UserService userService;
    @Autowired
    private MatchService matchService;
    @Autowired
    private EquipmentService equipmentService;
    @Autowired // 新增：CollectService注入
    private CollectService collectService; // 新增这一行

    /**
     * 1. 跳转到登录页（GET请求：访问/login）
     */
    @GetMapping({"/", "/login"})
    public String toLogin() {
        return "login"; // 视图解析器拼接为/WEB-INF/views/login.jsp
    }

    /**
     * 2. 跳转到注册页（GET请求：访问/register）
     */
    @GetMapping("/register")
    public String toRegister() {
        return "register"; // 跳转到注册页
    }

    /**
     * 跳转到首页（index.jsp）
     */
    @GetMapping("/index")
    public String toIndex(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        // 1. 传递用户信息
        model.addAttribute("loginUser", loginUser);
        // 2. 传递赛事数据
        model.addAttribute("matchList", matchService.getAllMatches());
        // 3. 传递装备数据
        model.addAttribute("equipList", equipmentService.getAllEquipments());
        // 4. 传递用户收藏列表（用于判断收藏状态，改变按钮样式）
        List<Collect> userCollects = collectService.getCollectsByUsername(loginUser.getUsername());
        model.addAttribute("userCollects", userCollects);
        return "index";
    }

    /**
     * 3. 处理注册请求（POST请求：表单提交到/doRegister）
     * @param user 接收前端表单参数（username、password、phone）
     * @param model 传递数据到前端页面（显示注册结果提示）
     */
    @PostMapping("/doRegister")
    public String doRegister(User user, Model model) {
        int result = userService.register(user);
        if (result == 1) {
            // 注册成功：跳转到登录页，并提示"注册成功，请登录"
            model.addAttribute("msg", "注册成功，请登录！");
            return "login";
        } else if (result == 0) {
            // 用户名已存在：返回注册页，提示"用户名已被占用"
            model.addAttribute("errorMsg", "用户名已被占用！");
            return "register";
        } else {
            // 注册失败：返回注册页，提示"注册失败，请重试"
            model.addAttribute("errorMsg", "注册失败，请重试！");
            return "register";
        }
    }

    /**
     * 4. 处理登录请求（POST请求：表单提交到/doLogin）
     * @param username 前端输入的用户名
     * @param password 前端输入的密码
     * @param session 会话对象：登录成功后存储用户信息
     * @param model 传递错误提示到前端
     */
    @PostMapping("/doLogin")
    public String doLogin(@RequestParam String username,
                          @RequestParam String password,
                          HttpSession session,
                          Model model) {
        // 调用Service层登录逻辑
        User loginUser = userService.login(username, password);
        if (loginUser != null) {
            // 登录成功：将用户信息存入Session（后续验证登录状态用）
            session.setAttribute("loginUser", loginUser);
            // 跳转到首页（index.jsp）
            return "redirect:/index";
        } else {
            // 登录失败：返回登录页，提示"用户名或密码错误"
            model.addAttribute("errorMsg", "用户名或密码错误！");
            return "login";
        }
    }

    /**
     * 5. 处理注销请求（GET请求：访问/logout）
     * @param session 销毁会话中的用户信息
     */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 销毁Session，清除登录状态
        return "redirect:/login"; // 跳转到登录页
    }
}
