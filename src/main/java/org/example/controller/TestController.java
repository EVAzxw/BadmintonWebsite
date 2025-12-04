package org.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

// 标记此类为Spring MVC控制器（处理HTTP请求）
@Controller
public class TestController {

    // 处理GET请求：访问http://localhost:8080/test时，执行此方法
    @GetMapping("/test")
    public String test() {
        // 返回"test"，视图解析器会自动拼接为/WEB-INF/views/test.jsp
        return "test";
    }
}