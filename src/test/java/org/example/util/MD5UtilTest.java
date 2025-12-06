package org.example.util;

import org.junit.Test;
import static org.junit.Assert.*;

public class MD5UtilTest {

    //测试 MD5加密功能的正确性
    @Test
    public void testEncrypt() {
        // 准备数据
        String inputPassword = "123456";
        // 这是我们已知的 "123456" 加密后的正确结果
        String expectedHash = "e10adc3949ba59abbe56e057f20f883e";

        // 执行方法
        // 调用我们要测试的工具类方法
        String actualHash = MD5Util.encrypt(inputPassword);

        // 验证结果，“实际结果”必须等于“预期结果”
        // 如果相等，IDEA里会显示绿色对勾；如果不等，会显示红色感叹号
        assertEquals("密码加密结果不匹配", expectedHash, actualHash);

        // 额外测试一个空值情况
        System.out.println("测试通过：MD5加密逻辑正常");
    }
}