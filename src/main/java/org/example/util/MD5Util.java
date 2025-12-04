package org.example.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

// MD5加密工具类：将明文密码转换为32位MD5字符串
public class MD5Util {
    public static String encrypt(String password) {
        try {
            // 1. 获取MD5加密实例
            MessageDigest md = MessageDigest.getInstance("MD5");
            // 2. 将明文密码转换为字节数组（UTF-8编码）
            byte[] inputBytes = password.getBytes("UTF-8");
            // 3. 执行加密
            byte[] encryptedBytes = md.digest(inputBytes);
            // 4. 将加密后的字节数组转换为32位十六进制字符串
            StringBuilder sb = new StringBuilder();
            for (byte b : encryptedBytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    sb.append('0'); // 不足两位补0
                }
                sb.append(hex);
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException | java.io.UnsupportedEncodingException e) {
            throw new RuntimeException("MD5加密失败", e);
        }
    }

    // 测试方法（可选，可运行main方法验证加密效果）
    public static void main(String[] args) {
        String password = "123456"; // 明文密码
        String encrypted = MD5Util.encrypt(password);
        System.out.println("明文密码：" + password);
        System.out.println("MD5加密后：" + encrypted); // 输出：e10adc3949ba59abbe56e057f20f883e（与测试数据一致）
    }
}