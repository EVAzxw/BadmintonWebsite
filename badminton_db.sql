CREATE DATABASE  IF NOT EXISTS `badminton_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `badminton_db`;
-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: badminton_db
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `collections`
--

DROP TABLE IF EXISTS `collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collections` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '收藏ID（自增）',
  `username` varchar(20) NOT NULL COMMENT '收藏用户的用户名',
  `type` int NOT NULL COMMENT '收藏类型（1=赛事，2=装备）',
  `target_id` int NOT NULL COMMENT '关联的赛事ID或装备ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_type_target` (`username`,`type`,`target_id`),
  CONSTRAINT `collections_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='收藏表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collections`
--

LOCK TABLES `collections` WRITE;
/*!40000 ALTER TABLE `collections` DISABLE KEYS */;
INSERT INTO `collections` (`id`, `username`, `type`, `target_id`, `create_time`) VALUES (17,'654321',1,1,'2025-12-02 14:31:23'),(18,'654321',1,2,'2025-12-02 14:31:25'),(19,'654321',2,1,'2025-12-02 14:31:26'),(20,'654321',2,2,'2025-12-02 14:31:27'),(21,'654321',2,4,'2025-12-02 14:31:28');
/*!40000 ALTER TABLE `collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '评论ID（自增）',
  `equip_id` int NOT NULL COMMENT '关联的装备ID',
  `username` varchar(20) NOT NULL COMMENT '评论用户的用户名',
  `content` varchar(200) NOT NULL COMMENT '评论内容',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
  PRIMARY KEY (`id`),
  KEY `equip_id` (`equip_id`),
  KEY `username` (`username`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`equip_id`) REFERENCES `equipment` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` (`id`, `equip_id`, `username`, `content`, `create_time`) VALUES (1,1,'zhangsan','球拍手感很好，扣杀有力，适合进阶玩家！','2025-11-30 11:51:25'),(2,1,'lisi','重量适中，平衡点精准，打了2小时不累手','2025-11-30 11:51:25'),(3,2,'zhangsan','鞋底防滑效果不错，减震效果好，适合长时间运动','2025-11-30 11:51:25'),(4,1,'123456','的撒旦撒旦','2025-12-04 12:49:54'),(5,1,'123456','的撒大苏打实打实的','2025-12-04 12:50:03');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '装备ID（自增）',
  `equip_name` varchar(30) NOT NULL COMMENT '装备名称',
  `brand` varchar(20) NOT NULL COMMENT '装备品牌（如：尤尼克斯、胜利）',
  `price` decimal(8,2) NOT NULL COMMENT '装备价格（保留2位小数）',
  `image_url` varchar(100) DEFAULT NULL COMMENT '装备图片路径',
  `image_urls` varchar(500) DEFAULT NULL COMMENT '多图片路径（逗号分隔）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='装备表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
INSERT INTO `equipment` (`id`, `equip_name`, `brand`, `price`, `image_url`, `image_urls`) VALUES (1,'ASTROX 99 PRO','尤尼克斯',1700.00,'/static/images/equip/equip_1/equip_1_1.jpg','/static/images/equip/equip_1/equip_1_1.jpg,/static/images/equip/equip_1/equip_1_2.jpg,/static/images/equip/equip_1/equip_1_3.jpg'),(2,'A970 专业羽毛球鞋','胜利',599.00,'/static/images/equip/equip_2/equip_2_1.jpg','/static/images/equip/equip_2/equip_2_1.jpg,/static/images/equip/equip_2/equip_2_2.jpg,/static/images/equip/equip_2/equip_2_3.jpg'),(3,'RSL 7号 比赛级羽毛球','亚狮龙',128.00,'/static/images/equip/equip_3/equip_3_1.jpg','/static/images/equip/equip_3/equip_3_1.jpg,/static/images/equip/equip_3/equip_3_2.jpg,/static/images/equip/equip_3/equip_3_3.jpg'),(4,'ARC 11 PRO 均衡型球拍','尤尼克斯',1099.00,'/static/images/equip/equip_4/equip_4_1.jpg','/static/images/equip/equip_4/equip_4_1.jpg,/static/images/equip/equip_4/equip_4_2.jpg,/static/images/equip/equip_4/equip_4_3.jpg'),(5,'ASTROX 88D PRO','李宁',1600.00,'/static/images/equip/equip_5/equip_5_1.jpg','/static/images/equip/equip_5/equip_5_1.jpg,/static/images/equip/equip_5/equip_5_2.jpg,/static/images/equip/equip_5/equip_5_3.jpg'),(6,'刀锋2PRO','李宁',600.00,'/static/images/equip/equip_6/equip_6_1.jpg','/static/images/equip/equip_6/equip_6_1.jpg,/static/images/equip/equip_6/equip_6_2.jpg,/static/images/equip/equip_6/equip_6_3.jpg');
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matches`
--

DROP TABLE IF EXISTS `matches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matches` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '赛事ID（自增）',
  `match_name` varchar(50) NOT NULL COMMENT '赛事名称',
  `match_time` varchar(20) NOT NULL COMMENT '赛事时间（格式：2025-12-10 14:00）',
  `location` varchar(50) NOT NULL COMMENT '赛事地点',
  `requirement` varchar(200) DEFAULT NULL COMMENT '参赛要求（可选）',
  `image_url` varchar(100) DEFAULT NULL COMMENT '赛事图片路径（如：/static/images/matches/123.jpg）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='赛事表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matches`
--

LOCK TABLES `matches` WRITE;
/*!40000 ALTER TABLE `matches` DISABLE KEYS */;
INSERT INTO `matches` (`id`, `match_name`, `match_time`, `location`, `requirement`, `image_url`) VALUES (1,'校园羽毛球单打赛','2025-12-15 15:00','学校体育馆','仅限在校学生报名，需携带学生证','/static/images/matches/match1.jpg'),(2,'社区友谊混合双打赛','2025-12-20 14:00','社区活动中心','无门槛，欢迎羽毛球爱好者参与','/static/images/matches/match2.jpg'),(3,'城市业余羽毛球锦标赛','2026-01-05 09:00','市体育中心','18-45岁，需提交健康证明','/static/images/matches/match3.jpg');
/*!40000 ALTER TABLE `matches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户ID（自增）',
  `username` varchar(20) NOT NULL COMMENT '用户名（唯一，登录用）',
  `password` varchar(32) NOT NULL COMMENT '密码（MD5加密后存储）',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号（可选）',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间（自动填充当前时间）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `username`, `password`, `phone`, `create_time`) VALUES (1,'zhangsan','e10adc3949ba59abbe56e057f20f883e','13800138000','2025-11-30 11:51:25'),(2,'lisi','e10adc3949ba59abbe56e057f20f883e','13900139000','2025-11-30 11:51:25'),(3,'dawdads','3c183a30cffcda1408daf1c61d47b274','','2025-12-01 17:20:45'),(4,'111111','96e79218965eb72c92a549dd5a330112','','2025-12-01 17:20:59'),(5,'123456','e10adc3949ba59abbe56e057f20f883e','','2025-12-01 17:21:47'),(6,'654321','c33367701511b4f6020ec61ded352059','','2025-12-01 18:58:03'),(7,'741852','6cf82ee1020caef069e753c67a97a70d','','2025-12-02 11:14:22');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-05 13:54:30
