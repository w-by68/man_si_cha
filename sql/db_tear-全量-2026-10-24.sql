-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: db_tear
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '地址ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货人姓名',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号',
  `tag` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '家' COMMENT '标签 家/公司/学校',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '省',
  `province_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '省代码',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '市',
  `city_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '市代码',
  `district` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '区',
  `district_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '区代码',
  `detail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '详细地址',
  `full_address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '完整地址',
  `is_default` tinyint(1) DEFAULT '0' COMMENT '是否默认 0-否 1-是',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_is_default` (`is_default`) USING BTREE,
  CONSTRAINT `fk_address_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='收货地址表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,1,'张茶友','13800138001','家','浙江省','330000','杭州市','330100','西湖区','330106','龙井路88号 漫思茶苑','浙江省杭州市西湖区龙井路88号 漫思茶苑',0,'2026-03-05 16:54:29','2026-03-05 16:54:29');
INSERT INTO `address` VALUES (2,1,'张茶友','13800138001','公司','浙江省','330000','杭州市','330100','滨江区','330108','网商路699号 阿里巴巴园区','浙江省杭州市滨江区网商路699号 阿里巴巴园区',0,'2026-03-05 16:54:29','2026-03-05 16:54:29');
INSERT INTO `address` VALUES (3,2,'李悠然','13800138002','家','浙江省','330000','杭州市','330100','拱墅区','330105','莫干山路100号 大悦城公寓','浙江省杭州市拱墅区莫干山路100号 大悦城公寓',1,'2026-03-05 16:54:29','2026-03-05 16:54:29');
INSERT INTO `address` VALUES (4,2,'李悠然','13800138002','公司','浙江省','330000','杭州市','330100','西湖区','330106','学院路77号 黄龙国际中心','浙江省杭州市西湖区学院路77号 黄龙国际中心',0,'2026-03-05 16:54:29','2026-03-05 16:54:29');
INSERT INTO `address` VALUES (5,3,'王静心','13800138003','家','江苏省','320000','苏州市','320500','姑苏区','320508','平江路128号','江苏省苏州市姑苏区平江路128号',1,'2026-03-05 16:54:29','2026-03-05 16:54:29');
INSERT INTO `address` VALUES (6,3,'王静心','13800138003','公司','江苏省','320000','苏州市','320500','工业园区','320571','苏州大道西 国际大厦','江苏省苏州市工业园区苏州大道西 国际大厦',0,'2026-03-05 16:54:29','2026-03-05 16:54:29');
INSERT INTO `address` VALUES (7,4,'赵雅集','13800138004','家','北京市','110000','北京市','110100','朝阳区','110105','建国门外大街 茶文化中心','北京市朝阳区建国门外大街 茶文化中心',1,'2026-03-05 16:54:29','2026-03-05 16:54:29');
INSERT INTO `address` VALUES (8,4,'赵雅集','13800138004','公司','北京市','110000','北京市','110100','海淀区','110108','中关村大街 创业大厦','北京市海淀区中关村大街 创业大厦',0,'2026-03-05 16:54:29','2026-03-05 16:54:29');
INSERT INTO `address` VALUES (9,5,'陈墨香','13800138005','家','上海市','310000','上海市','310100','徐汇区','310104','衡山路 茶人小筑','上海市徐汇区衡山路 茶人小筑',1,'2026-03-05 16:54:29','2026-03-05 16:54:29');
INSERT INTO `address` VALUES (10,5,'陈墨香','13800138005','公司','上海市','310000','上海市','310100','浦东新区','310115','世纪大道 金融中心','上海市浦东新区世纪大道 金融中心',0,'2026-03-05 16:54:29','2026-03-05 16:54:29');
INSERT INTO `address` VALUES (11,6,'刘听雨','13800138006','家','广东省','440000','广州市','440100','天河区','440106','体育西路 茶韵轩','广东省广州市天河区体育西路 茶韵轩',1,'2026-03-05 16:54:29','2026-03-05 16:54:29');
INSERT INTO `address` VALUES (12,7,'周观山','13800138007','家','福建省','350000','福州市','350100','鼓楼区','350102','三坊七巷 茶文化街','福建省福州市鼓楼区三坊七巷 茶文化街',1,'2026-03-05 16:54:29','2026-03-05 16:54:29');
INSERT INTO `address` VALUES (13,8,'吴寻香','13800138008','家','四川省','510000','成都市','510100','青羊区','510105','宽窄巷子 茶舍','四川省成都市青羊区宽窄巷子 茶舍',1,'2026-03-05 16:54:29','2026-03-05 16:54:29');
INSERT INTO `address` VALUES (14,9,'郑忘机','13800138009','家','安徽省','340000','黄山市','341000','屯溪区','341002','老街 茶博馆','安徽省黄山市屯溪区老街 茶博馆',1,'2026-03-05 16:54:29','2026-03-05 16:54:29');
INSERT INTO `address` VALUES (15,10,'孙拾光','13800138010','家','江西省','360000','景德镇市','360200','昌江区','360202','陶瓷城 茶具街','江西省景德镇市昌江区陶瓷城 茶具街',1,'2026-03-05 16:54:29','2026-03-05 16:54:29');
INSERT INTO `address` VALUES (17,11,'王寻真','13800138011','家','安徽省','340000','合肥市','340100','瑶海区','340102','三姑度假区大王峰路88号','安徽省合肥市瑶海区三姑度假区大王峰路88号',0,'2026-03-16 23:16:54','2026-04-02 13:59:34');
INSERT INTO `address` VALUES (21,1,'qq','13900000012','家','江西省','','南昌市','','南昌大学','','南昌大学','江西省南昌市南昌大学南昌大学',0,'2026-10-07 16:49:24','2026-10-07 16:49:24');
INSERT INTO `address` VALUES (22,1,'qq','13900000012','家','江西省','','南昌市','','南昌大学','','南昌大学','江西省南昌市南昌大学南昌大学',0,'2026-10-07 16:51:05','2026-10-07 16:51:05');
INSERT INTO `address` VALUES (23,1,'qq','13900000012','家','江西省','','南昌市','','红谷滩区','','南昌大学','江西省南昌市红谷滩区南昌大学',1,'2026-10-07 16:55:26','2026-10-07 16:55:26');
INSERT INTO `address` VALUES (24,11,'测试','13800138000','家','福建省','','厦门市','','思明区','','软件园二期','福建省厦门市思明区软件园二期',0,'2026-10-07 21:35:16','2026-10-07 21:35:16');
INSERT INTO `address` VALUES (25,12,'qq','13900000012','家','江西省','','南昌市','','南昌大学','','南昌大学','江西省南昌市南昌大学南昌大学',1,'2026-10-08 11:50:22','2026-10-08 11:50:22');
INSERT INTO `address` VALUES (26,11,'qq','13900000012','家','江西省','','南昌市','','南昌大学','','南昌大学','江西省南昌市南昌大学南昌大学',0,'2026-10-08 12:05:58','2026-10-08 12:05:58');
INSERT INTO `address` VALUES (28,11,'qq','13900000012','家','江西省','','南昌市','','青山湖区','','南昌大学','江西省南昌市青山湖区南昌大学',1,'2026-10-08 12:17:57','2026-10-08 12:17:57');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `balance_record`
--

DROP TABLE IF EXISTS `balance_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `balance_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `balance_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '余额类型 wechat-微信 alipay-支付宝',
  `change_amount` decimal(10,2) NOT NULL COMMENT '变动金额（正数为增加，负数为减少）',
  `before_balance` decimal(10,2) NOT NULL COMMENT '变动前余额',
  `after_balance` decimal(10,2) NOT NULL COMMENT '变动后余额',
  `order_id` bigint DEFAULT NULL COMMENT '关联订单ID',
  `payment_id` bigint DEFAULT NULL COMMENT '关联支付ID',
  `operation_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作类型 recharge-充值 pay-支付 refund-退款',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '描述',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_order_id` (`order_id`) USING BTREE,
  KEY `idx_payment_id` (`payment_id`) USING BTREE,
  KEY `idx_operation_type` (`operation_type`) USING BTREE,
  KEY `idx_created_at` (`created_at`) USING BTREE,
  CONSTRAINT `fk_balance_record_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='余额变动记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `balance_record`
--

LOCK TABLES `balance_record` WRITE;
/*!40000 ALTER TABLE `balance_record` DISABLE KEYS */;
INSERT INTO `balance_record` VALUES (1,1,'wechat',100.00,28.50,128.50,NULL,NULL,'recharge','微信充值','2026-03-15 09:55:39');
INSERT INTO `balance_record` VALUES (2,1,'alipay',50.00,8.00,58.00,NULL,NULL,'recharge','支付宝充值','2026-03-15 09:55:39');
INSERT INTO `balance_record` VALUES (3,1,'wechat',-30.00,128.50,98.50,1,NULL,'pay','订单支付','2026-03-15 09:55:39');
INSERT INTO `balance_record` VALUES (4,2,'wechat',200.00,156.80,356.80,NULL,NULL,'recharge','微信充值','2026-03-15 09:55:39');
INSERT INTO `balance_record` VALUES (5,2,'alipay',-120.50,241.00,120.50,2,NULL,'pay','订单支付','2026-03-15 09:55:39');
INSERT INTO `balance_record` VALUES (6,3,'wechat',-50.00,250.00,200.00,3,NULL,'pay','订单支付','2026-03-15 09:55:39');
/*!40000 ALTER TABLE `balance_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '购物车ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_user_id` (`user_id`) USING BTREE,
  CONSTRAINT `fk_cart_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='购物车表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,11,'2026-03-05 16:55:08','2026-03-14 14:12:59');
INSERT INTO `cart` VALUES (2,2,'2026-03-05 16:55:08','2026-03-05 16:55:08');
INSERT INTO `cart` VALUES (3,3,'2026-03-05 16:55:08','2026-03-05 16:55:08');
INSERT INTO `cart` VALUES (4,4,'2026-03-05 16:55:08','2026-03-05 16:55:08');
INSERT INTO `cart` VALUES (5,5,'2026-03-05 16:55:08','2026-03-05 16:55:08');
INSERT INTO `cart` VALUES (6,6,'2026-03-05 16:55:08','2026-03-05 16:55:08');
INSERT INTO `cart` VALUES (7,7,'2026-03-05 16:55:08','2026-03-05 16:55:08');
INSERT INTO `cart` VALUES (8,8,'2026-03-05 16:55:08','2026-03-05 16:55:08');
INSERT INTO `cart` VALUES (9,9,'2026-03-13 15:37:42','2026-03-14 15:37:48');
INSERT INTO `cart` VALUES (10,10,'2026-03-14 15:38:10','2026-03-14 15:38:24');
INSERT INTO `cart` VALUES (11,1,'2026-03-15 15:38:38','2026-03-15 15:38:41');
INSERT INTO `cart` VALUES (13,12,'2026-10-06 23:04:06','2026-10-06 23:04:06');
INSERT INTO `cart` VALUES (14,13,'2026-10-24 17:18:53','2026-10-24 17:18:53');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_item`
--

DROP TABLE IF EXISTS `cart_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '购物车项ID',
  `cart_id` bigint NOT NULL COMMENT '购物车ID',
  `product_id` bigint NOT NULL COMMENT '商品ID',
  `quantity` int NOT NULL DEFAULT '1' COMMENT '数量',
  `checked` tinyint(1) DEFAULT '1' COMMENT '是否选中',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `spec_id` bigint DEFAULT NULL COMMENT '规格ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_cart_product` (`cart_id`,`product_id`) USING BTREE,
  KEY `idx_cart_id` (`cart_id`) USING BTREE,
  KEY `idx_product_id` (`product_id`) USING BTREE,
  KEY `fk_cart_item_spec` (`spec_id`) USING BTREE,
  CONSTRAINT `fk_cart_item_cart` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_cart_item_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_cart_item_spec` FOREIGN KEY (`spec_id`) REFERENCES `product_spec` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='购物车项表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_item`
--

LOCK TABLES `cart_item` WRITE;
/*!40000 ALTER TABLE `cart_item` DISABLE KEYS */;
INSERT INTO `cart_item` VALUES (18,2,3,1,1,'2026-03-05 17:15:10','2026-03-13 09:01:40',8);
INSERT INTO `cart_item` VALUES (19,2,5,1,0,'2026-03-05 17:15:10','2026-03-13 09:01:52',13);
INSERT INTO `cart_item` VALUES (20,3,4,3,1,'2026-03-05 17:15:10','2026-03-13 09:02:00',9);
INSERT INTO `cart_item` VALUES (21,3,6,1,1,'2026-03-05 17:15:10','2026-03-13 09:02:08',14);
INSERT INTO `cart_item` VALUES (22,4,3,1,1,'2026-03-05 17:15:10','2026-03-13 09:02:27',7);
INSERT INTO `cart_item` VALUES (23,4,2,2,0,'2026-03-05 17:15:10','2026-03-13 09:02:28',4);
INSERT INTO `cart_item` VALUES (24,5,8,1,1,'2026-03-05 17:15:10','2026-03-13 09:04:18',20);
INSERT INTO `cart_item` VALUES (25,5,11,1,1,'2026-03-05 17:15:10','2026-03-13 09:04:44',27);
INSERT INTO `cart_item` VALUES (26,6,17,2,1,'2026-03-05 17:15:10','2026-03-13 09:04:54',42);
INSERT INTO `cart_item` VALUES (27,6,16,1,0,'2026-03-05 17:15:10','2026-03-13 09:05:13',39);
INSERT INTO `cart_item` VALUES (28,7,14,1,1,'2026-03-05 17:15:10','2026-03-13 09:05:28',36);
INSERT INTO `cart_item` VALUES (29,8,20,1,1,'2026-03-05 17:15:10','2026-03-13 09:05:37',50);
INSERT INTO `cart_item` VALUES (30,8,13,1,1,'2026-03-05 17:15:10','2026-03-13 09:07:36',33);
INSERT INTO `cart_item` VALUES (48,11,1,1,1,'2026-10-06 20:18:12','2026-10-06 20:18:12',2);
/*!40000 ALTER TABLE `cart_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '图标',
  `sort_order` int DEFAULT '0' COMMENT '排序',
  `parent_id` int DEFAULT '0' COMMENT '父分类ID',
  `level` tinyint(1) DEFAULT '1' COMMENT '层级 1-一级 2-二级',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态 0-隐藏 1-显示',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_parent_id` (`parent_id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='商品分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'绿茶','🍃',1,0,1,1,'2026-03-05 16:27:54','2026-03-05 16:27:54');
INSERT INTO `category` VALUES (2,'红茶','🍂',2,0,1,1,'2026-03-05 16:27:54','2026-03-05 16:27:54');
INSERT INTO `category` VALUES (3,'乌龙茶','🌿',3,0,1,1,'2026-03-05 20:43:35','2026-03-05 20:43:35');
INSERT INTO `category` VALUES (4,'白茶','🌱',4,0,1,1,'2026-03-05 20:43:35','2026-03-05 20:43:35');
INSERT INTO `category` VALUES (5,'黑茶','🌾',5,0,1,1,'2026-03-05 20:43:35','2026-03-05 20:43:35');
INSERT INTO `category` VALUES (6,'黄茶','🌸',6,0,1,1,'2026-03-05 20:43:35','2026-03-05 20:43:35');
INSERT INTO `category` VALUES (7,'茶具','🏺',7,0,1,1,'2026-03-05 20:43:35','2026-03-05 20:43:35');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupon`
--

DROP TABLE IF EXISTS `coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '优惠券ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '优惠券名称',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '类型 full-满减 discount-折扣',
  `value` decimal(10,2) NOT NULL COMMENT '面值（满减为金额，折扣为折扣率如0.8表示8折）',
  `condition` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '使用条件描述',
  `min_order_amount` decimal(10,2) DEFAULT '0.00' COMMENT '最低订单金额（0表示无门槛）',
  `max_discount` decimal(10,2) DEFAULT NULL COMMENT '最高抵扣金额（折扣券专用）',
  `theme_id` int DEFAULT NULL COMMENT '关联主题ID，NULL表示通用券',
  `theme_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '主题名称（冗余字段）',
  `is_exclusive` tinyint(1) DEFAULT '0' COMMENT '是否专享券 0-通用券 1-专享券（仅限主题商品使用）',
  `stock` int DEFAULT '0' COMMENT '库存',
  `total_count` int DEFAULT '0' COMMENT '发行总量',
  `received_count` int DEFAULT '0' COMMENT '已领取数量',
  `used_count` int DEFAULT '0' COMMENT '已使用数量',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态 0-失效 1-有效',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_theme_id` (`theme_id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_type` (`type`) USING BTREE,
  KEY `idx_is_exclusive` (`is_exclusive`) USING BTREE,
  KEY `idx_time` (`start_time`,`end_time`) USING BTREE,
  CONSTRAINT `fk_coupon_theme` FOREIGN KEY (`theme_id`) REFERENCES `theme` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='优惠券表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupon`
--

LOCK TABLES `coupon` WRITE;
/*!40000 ALTER TABLE `coupon` DISABLE KEYS */;
INSERT INTO `coupon` VALUES (1,'江南春晓·文人专享','full',30.00,'满200元可用',200.00,NULL,1,'江南春晓 · 文人茶韵',1,499,5000,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:02','2026-10-23 22:50:13');
INSERT INTO `coupon` VALUES (2,'江南春晓·文人雅集','full',50.00,'满300元可用',300.00,NULL,1,'江南春晓 · 文人茶韵',1,299,3000,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:02','2026-10-23 22:40:42');
INSERT INTO `coupon` VALUES (3,'高山流水·隐士专享','full',40.00,'满250元可用',250.00,NULL,2,'高山流水 · 隐士之茶',1,399,4000,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:02','2026-10-23 22:40:44');
INSERT INTO `coupon` VALUES (4,'高山流水·山野之礼','full',60.00,'满400元可用',400.00,NULL,2,'高山流水 · 隐士之茶',1,199,2000,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:02','2026-10-23 22:40:13');
INSERT INTO `coupon` VALUES (5,'丝路茶香·古道专享','full',35.00,'满200元可用',200.00,NULL,3,'丝路茶香 · 万里茶道',1,449,4500,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:02','2026-10-23 22:40:44');
INSERT INTO `coupon` VALUES (6,'丝路茶香·驼铃礼遇','full',55.00,'满350元可用',350.00,NULL,3,'丝路茶香 · 万里茶道',1,249,2500,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:02','2026-10-23 22:40:41');
INSERT INTO `coupon` VALUES (7,'四季流转·春分券','full',25.00,'满150元可用',150.00,NULL,4,'四季流转 · 节气茶会',1,599,6000,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:02','2026-10-23 22:50:14');
INSERT INTO `coupon` VALUES (8,'四季流转·冬至券','full',45.00,'满280元可用',280.00,NULL,4,'四季流转 · 节气茶会',1,349,3500,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:02','2026-10-23 22:40:43');
INSERT INTO `coupon` VALUES (9,'茶禅一味·静心券','full',30.00,'满200元可用',200.00,NULL,5,'茶禅一味 · 修行者茶',1,499,5000,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:02','2026-10-23 22:40:45');
INSERT INTO `coupon` VALUES (10,'茶禅一味·悟道券','full',50.00,'满300元可用',300.00,NULL,5,'茶禅一味 · 修行者茶',1,299,3000,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:02','2026-10-23 22:40:42');
INSERT INTO `coupon` VALUES (11,'花间茶语·玫瑰券','full',20.00,'满120元可用',120.00,NULL,6,'花间茶语 · 花香茶韵',1,799,8000,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:02','2026-10-23 22:50:14');
INSERT INTO `coupon` VALUES (12,'花间茶语·牡丹券','full',40.00,'满250元可用',250.00,NULL,6,'花间茶语 · 花香茶韵',1,399,4000,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:02','2026-10-23 22:40:43');
INSERT INTO `coupon` VALUES (13,'茶和天下·东方之旅','full',50.00,'满300元可用',300.00,NULL,7,'茶和天下 · 世界茶旅',1,299,3000,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:02','2026-10-23 22:40:41');
INSERT INTO `coupon` VALUES (14,'茶和天下·环球礼遇','full',80.00,'满500元可用',500.00,NULL,7,'茶和天下 · 世界茶旅',1,149,1500,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:02','2026-10-23 22:40:07');
INSERT INTO `coupon` VALUES (15,'新客专享券','full',20.00,'无门槛',0.00,NULL,NULL,NULL,0,999,10000,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',0,'2026-03-07 23:21:02','2026-10-24 00:26:29');
INSERT INTO `coupon` VALUES (16,'满200减20','full',20.00,'满200元可用',200.00,NULL,NULL,NULL,0,799,8000,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:02','2026-10-23 21:16:24');
INSERT INTO `coupon` VALUES (17,'满300减30','full',30.00,'满300元可用',300.00,NULL,NULL,NULL,0,599,6000,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:02','2026-10-23 21:16:24');
INSERT INTO `coupon` VALUES (18,'满500减60','full',60.00,'满500元可用',500.00,NULL,NULL,NULL,0,399,4000,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:02','2026-10-23 20:37:10');
INSERT INTO `coupon` VALUES (19,'江南春晓·文人折扣','discount',0.85,'85折，最高减50',100.00,50.00,1,'江南春晓 · 文人茶韵',1,299,3000,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:11','2026-10-23 22:50:14');
INSERT INTO `coupon` VALUES (20,'高山流水·隐士折扣','discount',0.80,'8折，最高减80',150.00,80.00,2,'高山流水 · 隐士之茶',1,249,2500,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:11','2026-10-23 22:50:15');
INSERT INTO `coupon` VALUES (21,'丝路茶香·古道折扣','discount',0.88,'88折，最高减60',120.00,60.00,3,'丝路茶香 · 万里茶道',1,279,2800,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:11','2026-10-23 22:50:14');
INSERT INTO `coupon` VALUES (22,'四季流转·节气折扣','discount',0.90,'9折，最高减40',80.00,40.00,4,'四季流转 · 节气茶会',1,399,4000,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:11','2026-10-23 22:50:14');
INSERT INTO `coupon` VALUES (23,'茶禅一味·修行折扣','discount',0.82,'82折，最高减70',130.00,70.00,5,'茶禅一味 · 修行者茶',1,219,2200,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:11','2026-10-23 22:50:15');
INSERT INTO `coupon` VALUES (24,'花间茶语·花香折扣','discount',0.92,'92折，最高减30',60.00,30.00,6,'花间茶语 · 花香茶韵',1,499,5000,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:11','2026-10-23 22:50:14');
INSERT INTO `coupon` VALUES (25,'茶和天下·环球折扣','discount',0.75,'75折，最高减100',200.00,100.00,7,'茶和天下 · 世界茶旅',1,149,1500,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:11','2026-10-23 22:50:15');
INSERT INTO `coupon` VALUES (26,'全场9折券','discount',0.90,'9折，最高减50',50.00,50.00,NULL,NULL,0,599,6000,1,0,'2026-10-23 17:37:18','2027-12-31 23:59:59',1,'2026-03-07 23:21:11','2026-10-23 22:45:06');
INSERT INTO `coupon` VALUES (27,'VIP 85折券','discount',0.85,'85折，最高减100',100.00,100.00,NULL,NULL,0,299,30,1,0,'2026-10-23 00:00:00','2027-12-31 23:59:59',1,'2026-03-07 23:21:11','2026-10-24 16:48:40');
/*!40000 ALTER TABLE `coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupon_code`
--

DROP TABLE IF EXISTS `coupon_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon_code` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `coupon_id` bigint NOT NULL COMMENT '优惠券ID',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '券号（唯一）',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `batch_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '批次号',
  `value` decimal(10,2) NOT NULL COMMENT '面值',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '优惠券类型',
  `theme_id` int DEFAULT NULL COMMENT '关联主题ID',
  `theme_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '主题名称',
  `is_exclusive` tinyint(1) DEFAULT '0' COMMENT '是否专享券',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'unclaimed' COMMENT '状态 unclaimed-未领取 claimed-已领取 used-已使用 expired-已过期',
  `user_id` bigint DEFAULT NULL COMMENT '领取用户ID',
  `received_time` datetime DEFAULT NULL COMMENT '领取时间',
  `used_time` datetime DEFAULT NULL COMMENT '使用时间',
  `expire_time` datetime NOT NULL COMMENT '过期时间',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `version` int DEFAULT '0' COMMENT '乐观锁版本号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_code` (`code`) USING BTREE,
  KEY `idx_coupon_id` (`coupon_id`) USING BTREE,
  KEY `idx_theme_id` (`theme_id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_batch_no` (`batch_no`) USING BTREE,
  CONSTRAINT `fk_coupon_code_coupon` FOREIGN KEY (`coupon_id`) REFERENCES `coupon` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4835 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='优惠券兑换码表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupon_code`
--

LOCK TABLES `coupon_code` WRITE;
/*!40000 ALTER TABLE `coupon_code` DISABLE KEYS */;
INSERT INTO `coupon_code` VALUES (4701,1,'C1260407000149','037069','BATCH1_20260407_125142_0',30.00,'full',1,'江南春晓 · 文人茶韵',1,'expired',11,'2026-04-07 13:23:29',NULL,'2026-05-07 12:51:42','2026-04-07 12:51:42',1);
INSERT INTO `coupon_code` VALUES (4702,1,'C1260407000269','342849','BATCH1_20260407_125142_0',30.00,'full',1,'江南春晓 · 文人茶韵',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:42','2026-04-07 12:51:42',0);
INSERT INTO `coupon_code` VALUES (4703,1,'C1260407000364','180523','BATCH1_20260407_125142_0',30.00,'full',1,'江南春晓 · 文人茶韵',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:42','2026-04-07 12:51:42',0);
INSERT INTO `coupon_code` VALUES (4704,2,'C2260407000197','344301','BATCH2_20260407_125142_1',50.00,'full',1,'江南春晓 · 文人茶韵',1,'expired',11,'2026-04-07 13:24:04',NULL,'2026-05-07 12:51:42','2026-04-07 12:51:42',1);
INSERT INTO `coupon_code` VALUES (4705,2,'C2260407000278','917010','BATCH2_20260407_125142_1',50.00,'full',1,'江南春晓 · 文人茶韵',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:42','2026-04-07 12:51:42',0);
INSERT INTO `coupon_code` VALUES (4706,2,'C2260407000321','324489','BATCH2_20260407_125142_1',50.00,'full',1,'江南春晓 · 文人茶韵',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:42','2026-04-07 12:51:42',0);
INSERT INTO `coupon_code` VALUES (4707,3,'C3260407000197','912202','BATCH3_20260407_125142_2',40.00,'full',2,'高山流水 · 隐士之茶',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:42','2026-04-07 12:51:42',0);
INSERT INTO `coupon_code` VALUES (4708,3,'C3260407000262','411436','BATCH3_20260407_125142_2',40.00,'full',2,'高山流水 · 隐士之茶',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:42','2026-04-07 12:51:42',0);
INSERT INTO `coupon_code` VALUES (4709,3,'C3260407000316','607471','BATCH3_20260407_125142_2',40.00,'full',2,'高山流水 · 隐士之茶',1,'expired',11,'2026-04-07 13:24:30',NULL,'2026-05-07 12:51:42','2026-04-07 12:51:42',1);
INSERT INTO `coupon_code` VALUES (4710,4,'C4260407000153','839033','BATCH4_20260407_125142_3',60.00,'full',2,'高山流水 · 隐士之茶',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:42','2026-04-07 12:51:42',0);
INSERT INTO `coupon_code` VALUES (4711,4,'C4260407000259','474386','BATCH4_20260407_125142_3',60.00,'full',2,'高山流水 · 隐士之茶',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:42','2026-04-07 12:51:42',0);
INSERT INTO `coupon_code` VALUES (4712,4,'C4260407000357','462042','BATCH4_20260407_125142_3',60.00,'full',2,'高山流水 · 隐士之茶',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:42','2026-04-07 12:51:42',0);
INSERT INTO `coupon_code` VALUES (4713,5,'C5260407000157','509328','BATCH5_20260407_125142_4',35.00,'full',3,'丝路茶香 · 万里茶道',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:42','2026-04-07 12:51:42',0);
INSERT INTO `coupon_code` VALUES (4714,5,'C5260407000280','518859','BATCH5_20260407_125142_4',35.00,'full',3,'丝路茶香 · 万里茶道',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:42','2026-04-07 12:51:42',0);
INSERT INTO `coupon_code` VALUES (4715,5,'C5260407000316','274383','BATCH5_20260407_125142_4',35.00,'full',3,'丝路茶香 · 万里茶道',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:42','2026-04-07 12:51:42',0);
INSERT INTO `coupon_code` VALUES (4716,6,'C6260407000187','543542','BATCH6_20260407_125143_5',55.00,'full',3,'丝路茶香 · 万里茶道',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4717,6,'C6260407000209','857852','BATCH6_20260407_125143_5',55.00,'full',3,'丝路茶香 · 万里茶道',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4718,6,'C6260407000399','407324','BATCH6_20260407_125143_5',55.00,'full',3,'丝路茶香 · 万里茶道',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4719,7,'C7260407000104','018482','BATCH7_20260407_125143_6',25.00,'full',4,'四季流转 · 节气茶会',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4720,7,'C7260407000294','685250','BATCH7_20260407_125143_6',25.00,'full',4,'四季流转 · 节气茶会',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4721,7,'C7260407000358','853411','BATCH7_20260407_125143_6',25.00,'full',4,'四季流转 · 节气茶会',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4722,8,'C8260407000152','047571','BATCH8_20260407_125143_7',45.00,'full',4,'四季流转 · 节气茶会',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4723,8,'C8260407000267','223159','BATCH8_20260407_125143_7',45.00,'full',4,'四季流转 · 节气茶会',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4724,8,'C8260407000309','811893','BATCH8_20260407_125143_7',45.00,'full',4,'四季流转 · 节气茶会',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4725,9,'C9260407000177','417529','BATCH9_20260407_125143_8',30.00,'full',5,'茶禅一味 · 修行者茶',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4726,9,'C9260407000277','626026','BATCH9_20260407_125143_8',30.00,'full',5,'茶禅一味 · 修行者茶',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4727,9,'C9260407000380','136728','BATCH9_20260407_125143_8',30.00,'full',5,'茶禅一味 · 修行者茶',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4728,10,'C10260407000127','963614','BATCH10_20260407_125143_9',50.00,'full',5,'茶禅一味 · 修行者茶',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4729,10,'C10260407000299','078118','BATCH10_20260407_125143_9',50.00,'full',5,'茶禅一味 · 修行者茶',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4730,10,'C10260407000340','811722','BATCH10_20260407_125143_9',50.00,'full',5,'茶禅一味 · 修行者茶',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4731,11,'C11260407000183','719665','BATCH11_20260407_125143_10',20.00,'full',6,'花间茶语 · 花香茶韵',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4732,11,'C11260407000210','368148','BATCH11_20260407_125143_10',20.00,'full',6,'花间茶语 · 花香茶韵',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4733,11,'C11260407000352','517831','BATCH11_20260407_125143_10',20.00,'full',6,'花间茶语 · 花香茶韵',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4734,12,'C12260407000101','525452','BATCH12_20260407_125143_11',40.00,'full',6,'花间茶语 · 花香茶韵',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4735,12,'C12260407000257','323113','BATCH12_20260407_125143_11',40.00,'full',6,'花间茶语 · 花香茶韵',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4736,12,'C12260407000387','410086','BATCH12_20260407_125143_11',40.00,'full',6,'花间茶语 · 花香茶韵',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4737,13,'C13260407000142','883622','BATCH13_20260407_125143_12',50.00,'full',7,'茶和天下 · 世界茶旅',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4738,13,'C13260407000214','098050','BATCH13_20260407_125143_12',50.00,'full',7,'茶和天下 · 世界茶旅',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4739,13,'C13260407000304','910353','BATCH13_20260407_125143_12',50.00,'full',7,'茶和天下 · 世界茶旅',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4740,14,'C14260407000142','414260','BATCH14_20260407_125143_13',80.00,'full',7,'茶和天下 · 世界茶旅',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4741,14,'C14260407000278','677761','BATCH14_20260407_125143_13',80.00,'full',7,'茶和天下 · 世界茶旅',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4742,14,'C14260407000303','149128','BATCH14_20260407_125143_13',80.00,'full',7,'茶和天下 · 世界茶旅',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4743,15,'C15260407000163','733589','BATCH15_20260407_125143_14',20.00,'full',NULL,NULL,0,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4744,15,'C15260407000275','596036','BATCH15_20260407_125143_14',20.00,'full',NULL,NULL,0,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4745,15,'C15260407000370','722384','BATCH15_20260407_125143_14',20.00,'full',NULL,NULL,0,'expired',11,'2026-04-07 13:24:57',NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',1);
INSERT INTO `coupon_code` VALUES (4746,16,'C16260407000150','360981','BATCH16_20260407_125143_15',20.00,'full',NULL,NULL,0,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4747,16,'C16260407000228','357189','BATCH16_20260407_125143_15',20.00,'full',NULL,NULL,0,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4748,16,'C16260407000392','537764','BATCH16_20260407_125143_15',20.00,'full',NULL,NULL,0,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4749,17,'C17260407000192','002820','BATCH17_20260407_125143_16',30.00,'full',NULL,NULL,0,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4750,17,'C17260407000224','213700','BATCH17_20260407_125143_16',30.00,'full',NULL,NULL,0,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4751,17,'C17260407000333','034929','BATCH17_20260407_125143_16',30.00,'full',NULL,NULL,0,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4752,18,'C18260407000116','740357','BATCH18_20260407_125143_17',60.00,'full',NULL,NULL,0,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4753,18,'C18260407000219','752432','BATCH18_20260407_125143_17',60.00,'full',NULL,NULL,0,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4754,18,'C18260407000317','632992','BATCH18_20260407_125143_17',60.00,'full',NULL,NULL,0,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4755,19,'C19260407000163','254976','BATCH19_20260407_125143_18',0.85,'discount',1,'江南春晓 · 文人茶韵',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4756,19,'C19260407000238','147614','BATCH19_20260407_125143_18',0.85,'discount',1,'江南春晓 · 文人茶韵',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4757,19,'C19260407000359','509895','BATCH19_20260407_125143_18',0.85,'discount',1,'江南春晓 · 文人茶韵',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4758,20,'C20260407000177','359486','BATCH20_20260407_125143_19',0.80,'discount',2,'高山流水 · 隐士之茶',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4759,20,'C20260407000246','241172','BATCH20_20260407_125143_19',0.80,'discount',2,'高山流水 · 隐士之茶',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4760,20,'C20260407000381','346903','BATCH20_20260407_125143_19',0.80,'discount',2,'高山流水 · 隐士之茶',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4761,21,'C21260407000129','420619','BATCH21_20260407_125143_20',0.88,'discount',3,'丝路茶香 · 万里茶道',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4762,21,'C21260407000222','869642','BATCH21_20260407_125143_20',0.88,'discount',3,'丝路茶香 · 万里茶道',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4763,21,'C21260407000366','737632','BATCH21_20260407_125143_20',0.88,'discount',3,'丝路茶香 · 万里茶道',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4764,22,'C22260407000168','188227','BATCH22_20260407_125143_21',0.90,'discount',4,'四季流转 · 节气茶会',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4765,22,'C22260407000290','937640','BATCH22_20260407_125143_21',0.90,'discount',4,'四季流转 · 节气茶会',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4766,22,'C22260407000398','121116','BATCH22_20260407_125143_21',0.90,'discount',4,'四季流转 · 节气茶会',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4767,23,'C23260407000164','862452','BATCH23_20260407_125143_22',0.82,'discount',5,'茶禅一味 · 修行者茶',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4768,23,'C23260407000237','296548','BATCH23_20260407_125143_22',0.82,'discount',5,'茶禅一味 · 修行者茶',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4769,23,'C23260407000335','872340','BATCH23_20260407_125143_22',0.82,'discount',5,'茶禅一味 · 修行者茶',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:43','2026-04-07 12:51:43',0);
INSERT INTO `coupon_code` VALUES (4770,24,'C24260407000130','905544','BATCH24_20260407_125144_23',0.92,'discount',6,'花间茶语 · 花香茶韵',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:44','2026-04-07 12:51:44',0);
INSERT INTO `coupon_code` VALUES (4771,24,'C24260407000261','354278','BATCH24_20260407_125144_23',0.92,'discount',6,'花间茶语 · 花香茶韵',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:44','2026-04-07 12:51:44',0);
INSERT INTO `coupon_code` VALUES (4772,24,'C24260407000392','581387','BATCH24_20260407_125144_23',0.92,'discount',6,'花间茶语 · 花香茶韵',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:44','2026-04-07 12:51:44',0);
INSERT INTO `coupon_code` VALUES (4773,25,'C25260407000112','857857','BATCH25_20260407_125144_24',0.75,'discount',7,'茶和天下 · 世界茶旅',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:44','2026-04-07 12:51:44',0);
INSERT INTO `coupon_code` VALUES (4774,25,'C25260407000292','066800','BATCH25_20260407_125144_24',0.75,'discount',7,'茶和天下 · 世界茶旅',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:44','2026-04-07 12:51:44',0);
INSERT INTO `coupon_code` VALUES (4775,25,'C25260407000354','548496','BATCH25_20260407_125144_24',0.75,'discount',7,'茶和天下 · 世界茶旅',1,'expired',NULL,NULL,NULL,'2026-05-07 12:51:44','2026-04-07 12:51:44',0);
INSERT INTO `coupon_code` VALUES (4776,26,'C26260407000109','820237','BATCH26_20260407_125144_25',0.90,'discount',NULL,NULL,0,'expired',NULL,NULL,NULL,'2026-05-07 12:51:44','2026-04-07 12:51:44',0);
INSERT INTO `coupon_code` VALUES (4777,26,'C26260407000282','648039','BATCH26_20260407_125144_25',0.90,'discount',NULL,NULL,0,'expired',NULL,NULL,NULL,'2026-05-07 12:51:44','2026-04-07 12:51:44',0);
INSERT INTO `coupon_code` VALUES (4778,26,'C26260407000377','930612','BATCH26_20260407_125144_25',0.90,'discount',NULL,NULL,0,'expired',NULL,NULL,NULL,'2026-05-07 12:51:44','2026-04-07 12:51:44',0);
INSERT INTO `coupon_code` VALUES (4779,27,'C27260407000132','849283','BATCH27_20260407_125144_26',0.85,'discount',NULL,NULL,0,'expired',NULL,NULL,NULL,'2026-05-07 12:51:44','2026-04-07 12:51:44',0);
INSERT INTO `coupon_code` VALUES (4780,27,'C27260407000226','760865','BATCH27_20260407_125144_26',0.85,'discount',NULL,NULL,0,'expired',NULL,NULL,NULL,'2026-05-07 12:51:44','2026-04-07 12:51:44',0);
INSERT INTO `coupon_code` VALUES (4781,27,'C27260407000301','812896','BATCH27_20260407_125144_26',0.85,'discount',NULL,NULL,0,'expired',NULL,NULL,NULL,'2026-05-07 12:51:44','2026-04-07 12:51:44',0);
INSERT INTO `coupon_code` VALUES (4805,27,'MS6KVA9KARKH','252464','BATCH1792765918325',0.85,'discount',NULL,NULL,0,'unclaimed',NULL,NULL,NULL,'2027-12-31 23:59:59','2026-10-23 22:31:58',0);
INSERT INTO `coupon_code` VALUES (4806,27,'MSBYLPULMJAR','652641','BATCH1792765918325',0.85,'discount',NULL,NULL,0,'unclaimed',NULL,NULL,NULL,'2027-12-31 23:59:59','2026-10-23 22:31:58',0);
INSERT INTO `coupon_code` VALUES (4807,27,'MS6EJY5JP7QZ','457021','BATCH1792765918325',0.85,'discount',NULL,NULL,0,'unclaimed',NULL,NULL,NULL,'2027-12-31 23:59:59','2026-10-23 22:31:58',0);
INSERT INTO `coupon_code` VALUES (4808,27,'MSMCVGNKJPJP','604172','BATCH1792765918325',0.85,'discount',NULL,NULL,0,'unclaimed',NULL,NULL,NULL,'2027-12-31 23:59:59','2026-10-23 22:31:58',0);
INSERT INTO `coupon_code` VALUES (4809,27,'MS3TCE83J5D7','012795','BATCH1792765918325',0.85,'discount',NULL,NULL,0,'unclaimed',NULL,NULL,NULL,'2027-12-31 23:59:59','2026-10-23 22:31:58',0);
INSERT INTO `coupon_code` VALUES (4810,27,'MSRLXUVTCDRX','411080','BATCH1792765918325',0.85,'discount',NULL,NULL,0,'unclaimed',NULL,NULL,NULL,'2027-12-31 23:59:59','2026-10-23 22:31:58',0);
INSERT INTO `coupon_code` VALUES (4811,27,'MS2SVYUFR2NS','333601','BATCH1792765918325',0.85,'discount',NULL,NULL,0,'unclaimed',NULL,NULL,NULL,'2027-12-31 23:59:59','2026-10-23 22:31:58',0);
INSERT INTO `coupon_code` VALUES (4812,27,'MSDX72ZNSL54','790441','BATCH1792765918325',0.85,'discount',NULL,NULL,0,'unclaimed',NULL,NULL,NULL,'2027-12-31 23:59:59','2026-10-23 22:31:58',0);
INSERT INTO `coupon_code` VALUES (4813,27,'MSVVBH43NXWA','078506','BATCH1792765918325',0.85,'discount',NULL,NULL,0,'unclaimed',NULL,NULL,NULL,'2027-12-31 23:59:59','2026-10-23 22:31:58',0);
INSERT INTO `coupon_code` VALUES (4814,27,'MSGR9WPGVQCU','860491','BATCH1792765918325',0.85,'discount',NULL,NULL,0,'unclaimed',NULL,NULL,NULL,'2027-12-31 23:59:59','2026-10-23 22:31:58',0);
/*!40000 ALTER TABLE `coupon_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupon_user`
--

DROP TABLE IF EXISTS `coupon_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon_user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `coupon_id` bigint NOT NULL COMMENT '优惠券ID',
  `coupon_code_id` bigint DEFAULT NULL COMMENT '兑换码ID',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '券号',
  `order_id` bigint DEFAULT NULL COMMENT '使用订单ID',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'claimed' COMMENT '状态 claimed-已领取 used-已使用 expired-已过期',
  `received_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '领取时间',
  `used_time` datetime DEFAULT NULL COMMENT '使用时间',
  `expire_time` datetime NOT NULL COMMENT '过期时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_user_coupon` (`user_id`,`coupon_id`,`status`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_coupon_id` (`coupon_id`) USING BTREE,
  KEY `idx_coupon_code_id` (`coupon_code_id`) USING BTREE,
  KEY `idx_code` (`code`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  CONSTRAINT `fk_coupon_user_code` FOREIGN KEY (`coupon_code_id`) REFERENCES `coupon_code` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_coupon_user_coupon` FOREIGN KEY (`coupon_id`) REFERENCES `coupon` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_coupon_user_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户优惠券表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupon_user`
--

LOCK TABLES `coupon_user` WRITE;
/*!40000 ALTER TABLE `coupon_user` DISABLE KEYS */;
INSERT INTO `coupon_user` VALUES (7,11,1,4701,'C1260407000149',NULL,'expired','2026-04-07 13:23:29',NULL,'2026-05-07 12:51:42');
INSERT INTO `coupon_user` VALUES (8,11,2,4704,'C2260407000197',NULL,'expired','2026-04-07 13:24:04',NULL,'2026-05-07 12:51:42');
INSERT INTO `coupon_user` VALUES (9,11,3,4709,'C3260407000316',NULL,'expired','2026-04-07 13:24:30',NULL,'2026-05-07 12:51:42');
INSERT INTO `coupon_user` VALUES (10,11,15,4745,'C15260407000370',NULL,'deleted','2026-04-07 13:24:57',NULL,'2026-05-07 12:51:43');
INSERT INTO `coupon_user` VALUES (19,11,18,NULL,NULL,NULL,'claimed','2026-10-23 20:37:10',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (20,11,17,NULL,NULL,NULL,'claimed','2026-10-23 21:16:24',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (21,11,16,NULL,NULL,NULL,'claimed','2026-10-23 21:16:25',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (22,11,15,NULL,NULL,NULL,'claimed','2026-10-23 22:39:44',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (23,11,26,NULL,NULL,NULL,'claimed','2026-10-23 22:39:44',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (24,11,14,NULL,NULL,NULL,'claimed','2026-10-23 22:40:07',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (25,11,4,NULL,NULL,NULL,'claimed','2026-10-23 22:40:13',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (26,11,6,NULL,NULL,NULL,'claimed','2026-10-23 22:40:41',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (27,11,13,NULL,NULL,NULL,'claimed','2026-10-23 22:40:41',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (28,11,10,NULL,NULL,NULL,'claimed','2026-10-23 22:40:42',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (29,11,2,NULL,NULL,NULL,'claimed','2026-10-23 22:40:42',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (30,11,8,NULL,NULL,NULL,'claimed','2026-10-23 22:40:43',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (31,11,12,NULL,NULL,NULL,'claimed','2026-10-23 22:40:43',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (32,11,3,NULL,NULL,NULL,'claimed','2026-10-23 22:40:44',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (33,11,5,NULL,NULL,NULL,'claimed','2026-10-23 22:40:44',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (34,11,9,NULL,NULL,NULL,'claimed','2026-10-23 22:40:45',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (35,11,27,NULL,NULL,NULL,'claimed','2026-10-23 22:50:04',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (36,11,1,NULL,NULL,NULL,'claimed','2026-10-23 22:50:13',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (37,11,7,NULL,NULL,NULL,'claimed','2026-10-23 22:50:14',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (38,11,11,NULL,NULL,NULL,'claimed','2026-10-23 22:50:14',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (39,11,24,NULL,NULL,NULL,'claimed','2026-10-23 22:50:14',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (40,11,22,NULL,NULL,NULL,'claimed','2026-10-23 22:50:14',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (41,11,21,NULL,NULL,NULL,'claimed','2026-10-23 22:50:14',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (42,11,19,NULL,NULL,NULL,'claimed','2026-10-23 22:50:14',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (43,11,23,NULL,NULL,NULL,'claimed','2026-10-23 22:50:15',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (44,11,20,NULL,NULL,NULL,'claimed','2026-10-23 22:50:15',NULL,'2027-12-31 23:59:59');
INSERT INTO `coupon_user` VALUES (45,11,25,NULL,NULL,NULL,'claimed','2026-10-23 22:50:15',NULL,'2027-12-31 23:59:59');
/*!40000 ALTER TABLE `coupon_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_log`
--

DROP TABLE IF EXISTS `event_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `event_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `executed_at` datetime NOT NULL,
  `affected_rows` int DEFAULT NULL,
  `remarks` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_event_name` (`event_name`) USING BTREE,
  KEY `idx_executed_at` (`executed_at`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='事件执行日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_log`
--

LOCK TABLES `event_log` WRITE;
/*!40000 ALTER TABLE `event_log` DISABLE KEYS */;
INSERT INTO `event_log` VALUES (1,'expire_coupon_codes','2026-03-08 00:00:00',0,NULL);
INSERT INTO `event_log` VALUES (2,'expire_coupon_codes','2026-03-09 09:24:10',0,NULL);
INSERT INTO `event_log` VALUES (3,'expire_coupon_codes','2026-03-10 13:53:24',0,NULL);
INSERT INTO `event_log` VALUES (4,'expire_coupon_codes','2026-03-11 09:19:21',0,NULL);
INSERT INTO `event_log` VALUES (5,'expire_coupon_codes','2026-03-12 15:13:43',0,NULL);
INSERT INTO `event_log` VALUES (6,'expire_coupon_codes','2026-03-13 09:25:13',0,NULL);
INSERT INTO `event_log` VALUES (7,'expire_coupon_codes','2026-03-14 12:58:42',0,NULL);
INSERT INTO `event_log` VALUES (8,'expire_coupon_codes','2026-03-15 00:00:00',0,NULL);
INSERT INTO `event_log` VALUES (9,'expire_coupon_codes','2026-03-16 00:00:00',933,NULL);
INSERT INTO `event_log` VALUES (10,'expire_coupon_codes','2026-03-17 09:23:15',0,NULL);
INSERT INTO `event_log` VALUES (11,'expire_coupon_codes','2026-03-18 10:09:17',0,NULL);
INSERT INTO `event_log` VALUES (12,'expire_coupon_codes','2026-03-19 10:55:52',0,NULL);
INSERT INTO `event_log` VALUES (13,'expire_coupon_codes','2026-03-20 09:18:54',0,NULL);
INSERT INTO `event_log` VALUES (14,'expire_coupon_codes','2026-03-21 00:25:28',0,NULL);
INSERT INTO `event_log` VALUES (15,'expire_coupon_codes','2026-03-22 20:43:33',0,NULL);
INSERT INTO `event_log` VALUES (16,'expire_coupon_codes','2026-03-23 08:55:13',0,NULL);
INSERT INTO `event_log` VALUES (17,'expire_coupon_codes','2026-03-24 09:30:47',0,NULL);
INSERT INTO `event_log` VALUES (18,'expire_coupon_codes','2026-03-25 10:08:39',0,NULL);
INSERT INTO `event_log` VALUES (19,'expire_coupon_codes','2026-03-26 10:18:21',0,NULL);
INSERT INTO `event_log` VALUES (20,'expire_coupon_codes','2026-03-27 13:24:19',0,NULL);
INSERT INTO `event_log` VALUES (21,'expire_coupon_codes','2026-03-28 00:00:00',0,NULL);
INSERT INTO `event_log` VALUES (22,'expire_coupon_codes','2026-03-29 19:02:38',0,NULL);
INSERT INTO `event_log` VALUES (23,'expire_coupon_codes','2026-03-30 13:13:11',0,NULL);
INSERT INTO `event_log` VALUES (24,'expire_coupon_codes','2026-03-31 09:28:53',0,NULL);
INSERT INTO `event_log` VALUES (25,'expire_coupon_codes','2026-04-01 09:25:12',0,NULL);
INSERT INTO `event_log` VALUES (26,'expire_coupon_codes','2026-04-02 11:07:38',0,NULL);
INSERT INTO `event_log` VALUES (27,'expire_coupon_codes','2026-04-03 14:08:31',0,NULL);
INSERT INTO `event_log` VALUES (28,'expire_coupon_codes','2026-04-04 00:00:00',0,NULL);
INSERT INTO `event_log` VALUES (29,'expire_coupon_codes','2026-04-06 11:55:12',5,NULL);
INSERT INTO `event_log` VALUES (30,'expire_coupon_codes','2026-04-08 11:43:33',0,NULL);
INSERT INTO `event_log` VALUES (31,'expire_coupon_codes','2026-04-09 10:28:53',0,NULL);
INSERT INTO `event_log` VALUES (32,'expire_coupon_codes','2026-04-13 00:00:00',0,NULL);
INSERT INTO `event_log` VALUES (33,'expire_coupon_codes','2026-05-28 11:51:41',85,NULL);
INSERT INTO `event_log` VALUES (34,'expire_coupon_codes','2026-05-31 00:00:00',0,NULL);
INSERT INTO `event_log` VALUES (35,'expire_coupon_codes','2026-07-04 00:00:00',0,NULL);
INSERT INTO `event_log` VALUES (36,'expire_coupon_codes','2026-07-11 00:00:00',0,NULL);
INSERT INTO `event_log` VALUES (37,'expire_coupon_codes','2026-07-22 00:00:00',0,NULL);
INSERT INTO `event_log` VALUES (38,'expire_coupon_codes','2026-10-04 00:00:00',0,NULL);
INSERT INTO `event_log` VALUES (39,'expire_coupon_codes','2026-10-05 00:35:21',0,NULL);
INSERT INTO `event_log` VALUES (40,'expire_coupon_codes','2026-10-06 00:00:00',0,NULL);
INSERT INTO `event_log` VALUES (41,'expire_coupon_codes','2026-10-07 00:00:00',0,NULL);
INSERT INTO `event_log` VALUES (42,'expire_coupon_codes','2026-10-09 10:12:37',0,NULL);
INSERT INTO `event_log` VALUES (43,'expire_coupon_codes','2026-10-10 00:00:00',0,NULL);
INSERT INTO `event_log` VALUES (44,'expire_coupon_codes','2026-10-11 00:47:59',0,NULL);
INSERT INTO `event_log` VALUES (45,'expire_coupon_codes','2026-10-12 00:00:00',0,NULL);
INSERT INTO `event_log` VALUES (46,'expire_coupon_codes','2026-10-13 00:00:00',0,NULL);
INSERT INTO `event_log` VALUES (47,'expire_coupon_codes','2026-10-14 00:00:00',0,NULL);
INSERT INTO `event_log` VALUES (48,'expire_coupon_codes','2026-10-18 00:00:00',0,NULL);
INSERT INTO `event_log` VALUES (49,'expire_coupon_codes','2026-10-22 18:57:34',0,NULL);
INSERT INTO `event_log` VALUES (50,'expire_coupon_codes','2026-10-23 14:05:44',0,NULL);
INSERT INTO `event_log` VALUES (51,'expire_coupon_codes','2026-10-24 00:00:00',0,NULL);
/*!40000 ALTER TABLE `event_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moment`
--

DROP TABLE IF EXISTS `moment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moment` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '动态ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '动态内容',
  `images` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '图片列表（JSON格式存储）',
  `tea_tag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '关联茶品标签',
  `tea_id` bigint DEFAULT NULL COMMENT '关联茶品ID',
  `location` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '发布位置',
  `topic` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '话题标签',
  `like_count` int DEFAULT '0' COMMENT '点赞数',
  `comment_count` int DEFAULT '0' COMMENT '评论数',
  `view_count` int DEFAULT '0' COMMENT '浏览数',
  `share_count` int DEFAULT '0' COMMENT '分享数',
  `is_top` tinyint(1) DEFAULT '0' COMMENT '是否置顶 0-否 1-是',
  `is_hot` tinyint(1) DEFAULT '0' COMMENT '是否热门 0-否 1-是',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态 0-隐藏 1-显示 2-审核中',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_tea_id` (`tea_id`) USING BTREE,
  KEY `idx_topic` (`topic`) USING BTREE,
  KEY `idx_created_at` (`created_at`) USING BTREE,
  KEY `idx_like_count` (`like_count`) USING BTREE,
  KEY `idx_is_top` (`is_top`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  CONSTRAINT `fk_moment_tea` FOREIGN KEY (`tea_id`) REFERENCES `product` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_moment_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='茶友圈动态表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moment`
--

LOCK TABLES `moment` WRITE;
/*!40000 ALTER TABLE `moment` DISABLE KEYS */;
INSERT INTO `moment` VALUES (1,1,'今日品鉴明前龙井，香气清高，滋味鲜爽，回甘持久。不负“绿茶皇后”之名。',NULL,'明前龙井',1,'杭州·西湖','绿茶品鉴',23,5,156,0,1,1,1,'2026-03-24 11:38:35','2026-03-24 11:38:35');
INSERT INTO `moment` VALUES (2,2,'新入手的建盏，油滴斑纹太美了。用它喝茶，感觉茶汤都更甜了。',NULL,'油滴建盏',38,'景德镇','茶具收藏',15,3,89,0,0,1,1,'2026-03-24 11:38:35','2026-03-24 11:43:51');
INSERT INTO `moment` VALUES (3,3,'周末茶会，和几位茶友一起品鉴了不同年份的白茶。2015年的白牡丹转化得真好，枣香明显，汤感醇厚。',NULL,'白牡丹',13,'福州·茶文化馆','白茶',32,7,234,0,0,1,1,'2026-03-24 11:38:35','2026-03-24 11:38:35');
INSERT INTO `moment` VALUES (4,4,'今日茶席，选用的是今年新采的狗牯脑茶。汤色清澈，香气独特，有淡淡的花香。',NULL,'狗牯脑茶',2,'吉安·井冈山','绿茶',8,2,45,0,0,0,1,'2026-03-24 11:38:35','2026-03-24 11:38:35');
INSERT INTO `moment` VALUES (5,5,'武夷岩茶的大红袍，果然名不虚传。岩韵明显，七泡有余香。',NULL,'大红袍',9,'武夷山','岩茶',18,4,112,0,0,1,1,'2026-03-24 11:38:35','2026-03-24 11:38:35');
INSERT INTO `moment` VALUES (6,6,'尝试了祁门红茶，独特的祁门香让人难忘。似花似果似蜜，层次丰富。',NULL,'祁门红茶',5,'黄山','红茶',12,3,78,0,0,0,1,'2026-03-24 11:38:35','2026-03-24 11:38:35');
INSERT INTO `moment` VALUES (7,7,'收到了期待已久的紫砂壶，做工精细，出水流畅。今晚就用它泡一壶好茶。',NULL,'紫砂石瓢',48,'宜兴','茶具',25,6,167,0,1,1,1,'2026-03-24 11:38:35','2026-03-24 11:44:15');
INSERT INTO `moment` VALUES (8,8,'福鼎白茶的清甜，是这个季节最好的慰藉。',NULL,'白毫银针',12,'福鼎','白茶',9,1,34,0,0,0,1,'2026-03-24 11:38:35','2026-03-24 11:38:35');
INSERT INTO `moment` VALUES (9,9,'普洱茶越陈越香，这饼2015年的生普，转化得很好。',NULL,'普洱茶',14,'昆明','普洱茶',14,3,56,0,0,0,1,'2026-03-24 11:38:35','2026-03-24 11:38:35');
INSERT INTO `moment` VALUES (10,10,'景德镇新买的品茗杯，薄如纸，声如磬。',NULL,'青花品茗杯',39,'景德镇','茶具',7,2,28,0,0,0,1,'2026-03-24 11:38:35','2026-03-24 11:44:52');
INSERT INTO `moment` VALUES (11,11,'今日试茶，凤凰单丛的鸭屎香，果然名不虚传。香气高扬，山韵独特。',NULL,'凤凰单丛',22,'潮州','乌龙茶',21,5,98,0,0,1,1,'2026-03-24 11:38:35','2026-03-24 11:38:35');
INSERT INTO `moment` VALUES (14,11,'正山小种，干茶紧结肥壮、乌黑油润，传统烟熏款兼具浓郁的松烟香与甜润的桂圆干香',NULL,'正山小种',7,NULL,NULL,0,0,0,0,0,0,1,'2026-03-25 15:27:49','2026-03-25 15:27:48');
INSERT INTO `moment` VALUES (18,11,'干茶条索紧细匀整，乌黑中带着金黄毫尖，光是看着就很有质感。',NULL,'金骏眉',8,NULL,NULL,0,0,0,0,0,0,1,'2026-03-25 15:50:56','2026-03-25 15:50:55');
/*!40000 ALTER TABLE `moment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moment_comment`
--

DROP TABLE IF EXISTS `moment_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moment_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `moment_id` bigint NOT NULL COMMENT '动态ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `parent_id` bigint DEFAULT NULL COMMENT '父评论ID（回复评论）',
  `reply_to` bigint DEFAULT NULL COMMENT '回复目标用户ID',
  `reply_to_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '回复目标用户昵称',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '评论内容',
  `like_count` int DEFAULT '0' COMMENT '点赞数',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态 0-隐藏 1-显示',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `user_nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户名称',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_moment_id` (`moment_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_parent_id` (`parent_id`) USING BTREE,
  KEY `idx_created_at` (`created_at`) USING BTREE,
  CONSTRAINT `fk_moment_comment_moment` FOREIGN KEY (`moment_id`) REFERENCES `moment` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_moment_comment_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='茶友圈评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moment_comment`
--

LOCK TABLES `moment_comment` WRITE;
/*!40000 ALTER TABLE `moment_comment` DISABLE KEYS */;
INSERT INTO `moment_comment` VALUES (16,1,2,NULL,NULL,NULL,'龙井确实不错，我也很喜欢，今年新茶真香！',0,1,'2026-03-24 22:45:49','茶友·悠然');
INSERT INTO `moment_comment` VALUES (17,1,3,NULL,NULL,NULL,'在哪买的？求推荐！想尝尝明前龙井的味道。',0,1,'2026-03-24 22:45:49','茶友·静心');
INSERT INTO `moment_comment` VALUES (18,1,4,NULL,NULL,NULL,'今年的明前茶确实好，我在西湖龙井村也买了一些。',0,1,'2026-03-24 22:45:49','茶友·雅集');
INSERT INTO `moment_comment` VALUES (19,1,5,2,2,'茶友·悠然','在西湖龙井村买的，有需要可以私信我，可以帮忙代购。',0,1,'2026-03-24 22:45:49','茶友·墨香');
INSERT INTO `moment_comment` VALUES (20,1,6,NULL,NULL,NULL,'明前龙井就是不一样，豆香明显，回甘持久。',0,1,'2026-03-24 22:45:49','茶友·听雨');
INSERT INTO `moment_comment` VALUES (21,1,7,NULL,NULL,NULL,'我每年都买明前龙井，今年的品质特别好。',0,1,'2026-03-24 22:45:49','茶友·观山');
INSERT INTO `moment_comment` VALUES (22,1,8,3,3,'茶友·静心','我也想知道在哪买的，可以分享下店铺吗？',0,1,'2026-03-24 22:45:49','茶友·寻香');
INSERT INTO `moment_comment` VALUES (23,1,9,NULL,NULL,NULL,'龙井茶真是绿茶中的极品，喝过一次就忘不了。',0,1,'2026-03-24 22:45:49','茶友·忘机');
INSERT INTO `moment_comment` VALUES (24,2,1,NULL,NULL,NULL,'这个建盏真漂亮，油滴斑纹很清晰！',0,1,'2026-03-24 22:45:49','茶友·清风');
INSERT INTO `moment_comment` VALUES (25,2,3,NULL,NULL,NULL,'在哪买的？我也想入手一个建盏。',0,1,'2026-03-24 22:45:49','茶友·静心');
INSERT INTO `moment_comment` VALUES (26,2,4,NULL,NULL,NULL,'建盏喝茶确实能提升口感，我也有一个。',0,1,'2026-03-24 22:45:49','茶友·雅集');
INSERT INTO `moment_comment` VALUES (27,2,5,3,3,'茶友·静心','在景德镇陶瓷城买的，有需要可以一起去看看。',0,1,'2026-03-24 22:45:49','茶友·墨香');
INSERT INTO `moment_comment` VALUES (28,2,6,NULL,NULL,NULL,'油滴建盏很难得，这个品相真好。',0,1,'2026-03-24 22:45:49','茶友·听雨');
INSERT INTO `moment_comment` VALUES (29,2,7,NULL,NULL,NULL,'用建盏喝茶，茶汤确实更醇厚，值得入手。',0,1,'2026-03-24 22:45:49','茶友·观山');
INSERT INTO `moment_comment` VALUES (30,2,8,NULL,NULL,NULL,'建盏需要养，养出来会更漂亮。',0,1,'2026-03-24 22:45:49','茶友·寻香');
INSERT INTO `moment_comment` VALUES (31,3,1,NULL,NULL,NULL,'下次茶会叫上我！我也想参加这样的品鉴活动。',0,1,'2026-03-24 22:45:49','茶友·清风');
INSERT INTO `moment_comment` VALUES (32,3,2,NULL,NULL,NULL,'白牡丹确实越陈越香，2015年的正是好时候。',0,1,'2026-03-24 22:45:49','茶友·悠然');
INSERT INTO `moment_comment` VALUES (33,3,4,NULL,NULL,NULL,'白茶转化真的很神奇，我也有几饼老白茶。',0,1,'2026-03-24 22:45:49','茶友·雅集');
INSERT INTO `moment_comment` VALUES (34,3,5,1,1,'茶友·清风','好的，下次茶会一定通知你，欢迎一起品茶。',0,1,'2026-03-24 22:45:49','茶友·墨香');
INSERT INTO `moment_comment` VALUES (35,3,6,NULL,NULL,NULL,'白牡丹的枣香确实迷人，我也喜欢喝老白茶。',0,1,'2026-03-24 22:45:49','茶友·听雨');
INSERT INTO `moment_comment` VALUES (36,3,7,NULL,NULL,NULL,'老白茶煮着喝更好喝，汤色更红亮。',0,1,'2026-03-24 22:45:49','茶友·观山');
INSERT INTO `moment_comment` VALUES (37,3,8,NULL,NULL,NULL,'白茶真是越喝越有味道，岁月沉淀的香气。',0,1,'2026-03-24 22:45:49','茶友·寻香');
INSERT INTO `moment_comment` VALUES (38,3,9,4,4,'茶友·雅集','你的老白茶是哪个年份的？一起交流下。',0,1,'2026-03-24 22:45:49','茶友·忘机');
INSERT INTO `moment_comment` VALUES (39,4,5,NULL,NULL,NULL,'狗牯脑茶确实不错，江西的名茶。',0,1,'2026-03-24 22:45:49','茶友·墨香');
INSERT INTO `moment_comment` VALUES (40,4,1,NULL,NULL,NULL,'这个茶我也喝过，花香很明显。',0,1,'2026-03-24 22:45:49','茶友·清风');
INSERT INTO `moment_comment` VALUES (41,4,2,NULL,NULL,NULL,'汤色真的很清澈，看起来就很舒服。',0,1,'2026-03-24 22:45:49','茶友·悠然');
INSERT INTO `moment_comment` VALUES (42,4,3,NULL,NULL,NULL,'狗牯脑茶是遂川的特产，高山茶品质好。',0,1,'2026-03-24 22:45:49','茶友·静心');
INSERT INTO `moment_comment` VALUES (43,4,6,1,1,'茶友·清风','你是在哪买的？我也想试试。',0,1,'2026-03-24 22:45:49','茶友·听雨');
INSERT INTO `moment_comment` VALUES (44,4,7,NULL,NULL,NULL,'今年新茶确实香，值得品尝。',0,1,'2026-03-24 22:45:49','茶友·观山');
INSERT INTO `moment_comment` VALUES (45,5,6,NULL,NULL,NULL,'大红袍是我的最爱，岩韵太迷人了！',0,1,'2026-03-24 22:45:49','茶友·听雨');
INSERT INTO `moment_comment` VALUES (46,5,2,NULL,NULL,NULL,'七泡有余香，大红袍果然名不虚传。',0,1,'2026-03-24 22:45:49','茶友·悠然');
INSERT INTO `moment_comment` VALUES (47,5,3,NULL,NULL,NULL,'岩茶就是要喝大红袍，经典中的经典。',0,1,'2026-03-24 22:45:49','茶友·静心');
INSERT INTO `moment_comment` VALUES (48,5,4,NULL,NULL,NULL,'正岩的大红袍确实不一样，香气层次丰富。',0,1,'2026-03-24 22:45:49','茶友·雅集');
INSERT INTO `moment_comment` VALUES (49,5,7,6,6,'茶友·听雨','你也喜欢大红袍？可以交流一下品鉴心得。',0,1,'2026-03-24 22:45:49','茶友·观山');
INSERT INTO `moment_comment` VALUES (50,5,8,NULL,NULL,NULL,'大红袍的岩韵是其他茶无法替代的。',0,1,'2026-03-24 22:45:49','茶友·寻香');
INSERT INTO `moment_comment` VALUES (51,5,9,NULL,NULL,NULL,'我更喜欢肉桂的辛辣感，但大红袍也不错。',0,1,'2026-03-24 22:45:49','茶友·忘机');
INSERT INTO `moment_comment` VALUES (52,5,10,9,9,'茶友·忘机','肉桂确实更有个性，但大红袍更醇和。',0,1,'2026-03-24 22:45:49','茶友·拾光');
INSERT INTO `moment_comment` VALUES (53,6,7,NULL,NULL,NULL,'祁门香真的很独特，似花似果似蜜。',0,1,'2026-03-24 22:45:49','茶友·观山');
INSERT INTO `moment_comment` VALUES (54,6,1,NULL,NULL,NULL,'祁门红茶是世界三大高香红茶之一。',0,1,'2026-03-24 22:45:49','茶友·清风');
INSERT INTO `moment_comment` VALUES (55,6,2,NULL,NULL,NULL,'喝祁红一定要用白瓷杯，才能看清汤色。',0,1,'2026-03-24 22:45:49','茶友·悠然');
INSERT INTO `moment_comment` VALUES (56,6,3,NULL,NULL,NULL,'我喜欢加奶喝祁红，别有一番风味。',0,1,'2026-03-24 22:45:49','茶友·静心');
INSERT INTO `moment_comment` VALUES (57,6,4,NULL,NULL,NULL,'纯饮才能体会祁门香的层次感。',0,1,'2026-03-24 22:45:49','茶友·雅集');
INSERT INTO `moment_comment` VALUES (58,6,5,3,3,'茶友·静心','确实，白瓷杯能更好观察汤色。',0,1,'2026-03-24 22:45:49','茶友·墨香');
INSERT INTO `moment_comment` VALUES (59,6,8,NULL,NULL,NULL,'祁红适合下午茶，配点心很搭。',0,1,'2026-03-24 22:45:49','茶友·寻香');
INSERT INTO `moment_comment` VALUES (60,7,8,NULL,NULL,NULL,'紫砂壶养出来才好看，好好养它！',0,1,'2026-03-24 22:45:49','茶友·寻香');
INSERT INTO `moment_comment` VALUES (61,7,1,NULL,NULL,NULL,'西施壶型圆润，出水应该很顺畅。',0,1,'2026-03-24 22:45:49','茶友·清风');
INSERT INTO `moment_comment` VALUES (62,7,2,NULL,NULL,NULL,'紫砂壶泡普洱最合适，能提升茶汤口感。',0,1,'2026-03-24 22:45:49','茶友·悠然');
INSERT INTO `moment_comment` VALUES (63,7,3,NULL,NULL,NULL,'我也有一把西施壶，用了三年了，越用越润。',0,1,'2026-03-24 22:45:49','茶友·静心');
INSERT INTO `moment_comment` VALUES (64,7,4,NULL,NULL,NULL,'新壶要开壶，你知道怎么开壶吗？',0,1,'2026-03-24 22:45:49','茶友·雅集');
INSERT INTO `moment_comment` VALUES (65,7,5,4,4,'茶友·雅集','用茶水煮半小时就行，去除土味。',0,1,'2026-03-24 22:45:49','茶友·墨香');
INSERT INTO `moment_comment` VALUES (66,7,6,NULL,NULL,NULL,'紫砂壶要一壶一茶，不要混泡。',0,1,'2026-03-24 22:45:49','茶友·听雨');
INSERT INTO `moment_comment` VALUES (67,7,9,NULL,NULL,NULL,'恭喜入手好壶，期待养出来的效果。',0,1,'2026-03-24 22:45:49','茶友·忘机');
INSERT INTO `moment_comment` VALUES (68,7,10,6,6,'茶友·听雨','对，紫砂有吸附性，一壶一茶才能养出好壶。',0,1,'2026-03-24 22:45:49','茶友·拾光');
INSERT INTO `moment_comment` VALUES (69,8,9,NULL,NULL,NULL,'白毫银针真的很清甜，毫香明显。',0,1,'2026-03-24 22:45:49','茶友·忘机');
INSERT INTO `moment_comment` VALUES (70,8,1,NULL,NULL,NULL,'白茶中的珍品，全是芽头。',0,1,'2026-03-24 22:45:49','茶友·清风');
INSERT INTO `moment_comment` VALUES (71,8,2,NULL,NULL,NULL,'喝白毫银针要用玻璃杯，可以看茶叶跳舞。',0,1,'2026-03-24 22:45:49','茶友·悠然');
INSERT INTO `moment_comment` VALUES (72,8,3,NULL,NULL,NULL,'福鼎白茶就是好，这个季节喝正合适。',0,1,'2026-03-24 22:45:49','茶友·静心');
INSERT INTO `moment_comment` VALUES (73,8,4,NULL,NULL,NULL,'白毫银针的毫香是其他茶没有的。',0,1,'2026-03-24 22:45:49','茶友·雅集');
INSERT INTO `moment_comment` VALUES (74,8,5,2,2,'茶友·悠然','确实，玻璃杯泡可以欣赏芽头挺立的样子。',0,1,'2026-03-24 22:45:49','茶友·墨香');
INSERT INTO `moment_comment` VALUES (75,9,10,NULL,NULL,NULL,'生普转化需要时间，2015年的现在喝正好。',0,1,'2026-03-24 22:45:49','茶友·拾光');
INSERT INTO `moment_comment` VALUES (76,9,1,NULL,NULL,NULL,'普洱茶越陈越香，值得收藏。',0,1,'2026-03-24 22:45:49','茶友·清风');
INSERT INTO `moment_comment` VALUES (77,9,2,NULL,NULL,NULL,'我也存了几饼普洱茶，期待十年后的味道。',0,1,'2026-03-24 22:45:49','茶友·悠然');
INSERT INTO `moment_comment` VALUES (78,9,3,NULL,NULL,NULL,'生普要干仓存放，不能受潮。',0,1,'2026-03-24 22:45:49','茶友·静心');
INSERT INTO `moment_comment` VALUES (79,9,4,NULL,NULL,NULL,'普洱茶的陈香很特别，新茶和老茶完全不同。',0,1,'2026-03-24 22:45:49','茶友·雅集');
INSERT INTO `moment_comment` VALUES (80,9,5,2,2,'茶友·悠然','你存的是什么茶？可以交流一下。',0,1,'2026-03-24 22:45:49','茶友·墨香');
INSERT INTO `moment_comment` VALUES (81,9,6,NULL,NULL,NULL,'大益的普洱茶不错，性价比高。',0,1,'2026-03-24 22:45:49','茶友·听雨');
INSERT INTO `moment_comment` VALUES (82,9,7,5,5,'茶友·墨香','我存的是下关沱茶，也是经典品牌。',0,1,'2026-03-24 22:45:49','茶友·观山');
INSERT INTO `moment_comment` VALUES (83,10,1,NULL,NULL,NULL,'景德镇的瓷器确实好，薄如纸声如磬。',0,1,'2026-03-24 22:45:49','茶友·清风');
INSERT INTO `moment_comment` VALUES (84,10,2,NULL,NULL,NULL,'品茗杯要选薄胎的，才能品味茶香。',0,1,'2026-03-24 22:45:49','茶友·悠然');
INSERT INTO `moment_comment` VALUES (85,10,3,NULL,NULL,NULL,'我也在景德镇买了一套，用着很舒服。',0,1,'2026-03-24 22:45:49','茶友·静心');
INSERT INTO `moment_comment` VALUES (86,10,4,NULL,NULL,NULL,'品茗杯也是茶席的重要组成部分。',0,1,'2026-03-24 22:45:49','茶友·雅集');
INSERT INTO `moment_comment` VALUES (87,10,5,1,1,'茶友·清风','是的，景德镇的工艺传承千年。',0,1,'2026-03-24 22:45:49','茶友·墨香');
INSERT INTO `moment_comment` VALUES (88,10,6,NULL,NULL,NULL,'影青釉的杯子很好看，透光性好。',0,1,'2026-03-24 22:45:49','茶友·听雨');
INSERT INTO `moment_comment` VALUES (89,11,2,NULL,NULL,NULL,'鸭屎香确实名不虚传，香气高扬。',0,1,'2026-03-24 22:45:49','茶友·悠然');
INSERT INTO `moment_comment` VALUES (90,11,3,NULL,NULL,NULL,'凤凰单丛的香型很多，各有特色。',0,1,'2026-03-24 22:45:49','茶友·静心');
INSERT INTO `moment_comment` VALUES (91,11,4,NULL,NULL,NULL,'单丛茶要用盖碗泡，才能激发香气。',0,1,'2026-03-24 22:45:49','茶友·雅集');
INSERT INTO `moment_comment` VALUES (92,11,5,NULL,NULL,NULL,'潮州工夫茶泡单丛，最讲究手法。',0,1,'2026-03-24 22:45:49','茶友·墨香');
INSERT INTO `moment_comment` VALUES (93,11,6,2,2,'茶友·悠然','你喝过蜜兰香吗？也很好喝。',0,1,'2026-03-24 22:45:49','茶友·听雨');
INSERT INTO `moment_comment` VALUES (94,11,7,NULL,NULL,NULL,'单丛茶回甘快，山韵明显。',0,1,'2026-03-24 22:45:49','茶友·观山');
INSERT INTO `moment_comment` VALUES (95,11,8,NULL,NULL,NULL,'我喜欢鸭屎香，香气特别有个性。',0,1,'2026-03-24 22:45:49','茶友·寻香');
INSERT INTO `moment_comment` VALUES (96,11,9,5,5,'茶友·墨香','潮州工夫茶确实讲究，有机会要学习一下。',0,1,'2026-03-24 22:45:49','茶友·忘机');
INSERT INTO `moment_comment` VALUES (97,11,10,NULL,NULL,NULL,'单丛茶的香气层次太丰富了，值得细细品味。',0,1,'2026-03-24 22:45:49','茶友·拾光');
INSERT INTO `moment_comment` VALUES (98,1,11,NULL,NULL,NULL,'有一股淡淡的清香~',0,1,'2026-03-25 13:46:57','古城·扶光');
INSERT INTO `moment_comment` VALUES (99,14,11,NULL,NULL,NULL,'大家快来评论啦',0,1,'2026-03-25 15:30:54','古城·扶光');
/*!40000 ALTER TABLE `moment_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moment_image`
--

DROP TABLE IF EXISTS `moment_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moment_image` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '图片ID',
  `moment_id` bigint NOT NULL COMMENT '动态ID',
  `emoji` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'emoji表情',
  `sort_order` int DEFAULT '0' COMMENT '排序',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_moment_id` (`moment_id`) USING BTREE,
  CONSTRAINT `fk_moment_image_moment` FOREIGN KEY (`moment_id`) REFERENCES `moment` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='茶友圈动态emoji图片表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moment_image`
--

LOCK TABLES `moment_image` WRITE;
/*!40000 ALTER TABLE `moment_image` DISABLE KEYS */;
INSERT INTO `moment_image` VALUES (1,1,'🍃',1,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (2,1,'🍵',2,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (3,1,'🌱',3,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (4,1,'💚',4,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (5,2,'🏺',1,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (6,2,'🍵',2,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (7,2,'✨',3,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (8,3,'🌸',1,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (9,3,'🍂',2,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (10,3,'🍵',3,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (11,3,'👥',4,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (12,4,'🌿',1,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (13,4,'🍃',2,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (14,4,'💚',3,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (15,5,'🌱',1,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (16,5,'🔥',2,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (17,5,'⛰️',3,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (18,5,'✨',4,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (19,6,'🍂',1,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (20,6,'🌸',2,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (21,6,'🍯',3,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (22,7,'🫖',1,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (23,7,'🏺',2,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (24,7,'✨',3,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (25,7,'💜',4,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (26,8,'🌱',1,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (27,8,'✨',2,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (28,9,'🌿',1,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (29,9,'🍂',2,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (30,9,'⏳',3,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (31,10,'🥃',1,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (32,10,'✨',2,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (33,11,'🍂',1,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (34,11,'🌸',2,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (35,11,'🔥',3,'2026-03-25 09:56:26');
INSERT INTO `moment_image` VALUES (36,11,'⛰️',4,'2026-03-25 09:56:26');
/*!40000 ALTER TABLE `moment_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moment_like`
--

DROP TABLE IF EXISTS `moment_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moment_like` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '点赞ID',
  `moment_id` bigint NOT NULL COMMENT '动态ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_moment_user` (`moment_id`,`user_id`) USING BTREE,
  KEY `idx_moment_id` (`moment_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  CONSTRAINT `fk_moment_like_moment` FOREIGN KEY (`moment_id`) REFERENCES `moment` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_moment_like_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='茶友圈点赞表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moment_like`
--

LOCK TABLES `moment_like` WRITE;
/*!40000 ALTER TABLE `moment_like` DISABLE KEYS */;
INSERT INTO `moment_like` VALUES (25,1,2,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (26,1,3,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (27,1,4,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (28,1,5,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (29,1,6,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (30,1,7,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (31,1,8,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (33,2,1,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (34,2,3,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (35,2,4,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (36,2,5,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (37,2,6,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (38,2,7,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (39,2,8,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (40,3,1,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (41,3,2,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (42,3,4,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (43,3,5,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (44,3,6,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (45,3,11,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (46,3,8,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (47,3,9,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (48,4,1,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (49,4,2,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (50,4,3,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (51,4,5,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (52,4,6,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (53,4,7,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (54,5,2,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (55,5,3,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (56,5,4,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (57,5,6,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (58,5,7,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (59,5,8,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (60,5,9,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (61,5,10,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (62,6,1,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (63,6,2,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (64,6,11,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (65,6,4,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (66,6,5,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (67,6,7,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (68,6,8,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (69,7,1,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (70,7,2,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (71,7,3,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (72,7,4,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (73,7,5,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (74,7,6,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (75,7,8,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (76,7,9,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (77,7,10,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (78,8,1,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (79,8,2,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (80,8,3,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (81,8,4,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (82,8,5,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (83,8,6,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (84,9,2,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (85,9,3,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (86,9,4,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (87,9,5,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (88,9,6,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (89,9,7,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (90,9,8,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (91,9,9,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (92,10,1,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (93,10,2,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (94,10,3,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (95,10,4,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (96,10,5,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (97,10,6,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (98,11,1,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (99,11,2,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (100,11,3,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (101,11,4,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (102,11,5,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (103,11,6,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (104,11,7,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (105,11,8,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (106,11,9,'2026-03-24 22:49:39');
INSERT INTO `moment_like` VALUES (108,1,11,'2026-03-25 11:38:35');
INSERT INTO `moment_like` VALUES (109,7,11,'2026-03-25 11:38:43');
INSERT INTO `moment_like` VALUES (110,2,11,'2026-03-25 11:38:46');
INSERT INTO `moment_like` VALUES (112,14,11,'2026-03-25 15:30:14');
/*!40000 ALTER TABLE `moment_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note`
--

DROP TABLE IF EXISTS `note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `note` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '笔记ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标题',
  `tea_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '茶品名称',
  `tea_id` bigint DEFAULT NULL COMMENT '关联茶品ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '笔记内容',
  `rating` tinyint(1) DEFAULT '0' COMMENT '评分 1-5',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '图片URL',
  `is_public` tinyint(1) DEFAULT '1' COMMENT '是否公开',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_tea_id` (`tea_id`) USING BTREE,
  KEY `idx_created_at` (`created_at`) USING BTREE,
  CONSTRAINT `fk_note_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='品茶笔记表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note`
--

LOCK TABLES `note` WRITE;
/*!40000 ALTER TABLE `note` DISABLE KEYS */;
INSERT INTO `note` VALUES (1,1,'初尝明前龙井','明前龙井',1,'香气清高，滋味鲜爽，回甘持久，确实不负盛名。',5,NULL,1,'2024-03-01 10:30:00','2026-03-05 16:56:44');
INSERT INTO `note` VALUES (2,1,'狗牯脑茶品鉴','狗牯脑茶',2,'汤色清澈，香气独特，有淡淡的花香，口感醇和。',4,NULL,1,'2024-02-25 14:20:00','2026-03-05 16:56:44');
INSERT INTO `note` VALUES (3,2,'祁门红茶初体验','祁门红茶',5,'独特的祁门香，似花似果似蜜，层次丰富。',5,NULL,1,'2024-02-20 09:15:00','2026-03-05 16:56:44');
INSERT INTO `note` VALUES (4,2,'正山小种对比','正山小种',6,'传统烟熏味，桂圆汤感，越陈越香。',4,NULL,0,'2024-02-15 16:30:00','2026-03-05 16:56:44');
INSERT INTO `note` VALUES (5,3,'武夷岩茶品鉴','大红袍',8,'岩韵明显，七泡有余香，茶汤橙黄明亮。',5,NULL,1,'2024-02-10 11:45:00','2026-03-05 16:56:44');
INSERT INTO `note` VALUES (6,3,'铁观音','铁观音',9,'兰花香明显，观音韵足，耐冲泡。',4,NULL,1,'2024-02-05 13:20:00','2026-03-05 16:56:44');
INSERT INTO `note` VALUES (7,4,'白毫银针','白毫银针',11,'毫香明显，汤色浅黄，滋味清甜。',5,NULL,1,'2024-01-30 15:10:00','2026-03-05 16:56:44');
INSERT INTO `note` VALUES (8,4,'白牡丹','白牡丹',12,'花香明显，茶汤柔和，回甘好。',4,NULL,0,'2024-01-25 10:40:00','2026-03-05 16:56:44');
INSERT INTO `note` VALUES (9,5,'普洱茶生茶','普洱茶',13,'青味已退，陈香初显，回甘生津。',4,NULL,1,'2024-01-20 14:50:00','2026-03-05 16:56:44');
INSERT INTO `note` VALUES (10,5,'安化黑茶','安化黑茶',14,'菌香明显，汤色橙红，口感醇厚。',4,NULL,1,'2024-01-15 09:30:00','2026-03-05 16:56:44');
INSERT INTO `note` VALUES (11,11,'初品大红袍','大红袍',9,'岩韵明显，香气馥郁，七泡有余香。不愧是岩茶之王。',4,NULL,1,'2026-03-16 08:00:00','2026-03-17 22:45:09');
INSERT INTO `note` VALUES (12,11,'观音赐福','铁观音',NULL,'条索卷曲，色泽砂绿；香气兰花香明显，观音韵足；汤色金黄明亮，滋味醇厚甘鲜，回甘生津；叶底肥厚软亮。',5,NULL,1,'2026-03-17 08:00:00','2026-03-17 22:46:39');
/*!40000 ALTER TABLE `note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单号',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `address_id` bigint DEFAULT NULL COMMENT '地址ID',
  `shop_id` int DEFAULT NULL COMMENT '店铺ID',
  `shop_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '店铺名称',
  `shop_badge` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '店铺标签',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'unpaid' COMMENT '订单状态 unpaid-待付款 unship-待发货 unreceive-待收货 unreview-待评价 completed-已完成 cancelled-已取消',
  `total_amount` decimal(10,2) NOT NULL COMMENT '商品总额',
  `discount_amount` decimal(10,2) DEFAULT '0.00' COMMENT '优惠金额',
  `points_discount` decimal(10,2) DEFAULT '0.00' COMMENT '积分抵扣',
  `coupon_discount` decimal(10,2) DEFAULT '0.00' COMMENT '优惠券抵扣',
  `delivery_fee` decimal(10,2) DEFAULT '0.00' COMMENT '运费',
  `pay_amount` decimal(10,2) NOT NULL COMMENT '实付金额',
  `coupon_id` bigint DEFAULT NULL COMMENT '使用的优惠券ID',
  `used_points` int DEFAULT '0' COMMENT '使用积分',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '订单备注',
  `delivery_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '送达时间',
  `delivery_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '配送方式',
  `invoice_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '发票类型',
  `payment_method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '支付方式',
  `payment_time` datetime DEFAULT NULL COMMENT '支付时间',
  `delivery_time_actual` datetime DEFAULT NULL COMMENT '发货时间',
  `receive_time` datetime DEFAULT NULL COMMENT '收货时间',
  `cancel_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消原因',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_order_no` (`order_no`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_created_at` (`created_at`) USING BTREE,
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'ORD202403051234',1,1,1,'漫思茶·官方旗舰店','官方','unpaid',792.00,30.00,0.00,30.00,20.00,762.00,1,0,'','今天 (16:00前下单，今日送达)','顺丰快递','不开发票',NULL,NULL,NULL,NULL,NULL,'2026-03-05 16:55:23','2026-10-23 14:24:59');
INSERT INTO `order` VALUES (2,'ORD202403041234',2,3,2,'井冈山·茶文化馆','精选','unship',228.00,0.00,0.00,0.00,10.00,228.00,NULL,0,'麻烦包装结实些，送人用','明天 (预计明天送达)','顺丰快递','不开发票','wechat','2024-03-04 10:20:00',NULL,NULL,NULL,'2026-03-05 16:55:23','2026-10-23 13:54:55');
INSERT INTO `order` VALUES (3,'ORD202403031234',1,1,1,'漫思茶·官方旗舰店','官方','unreceive',396.00,30.00,0.00,30.00,20.00,366.00,1,0,'','今天 (16:00前下单，今日送达)','顺丰快递','不开发票','wechat','2024-03-03 16:25:00','2024-03-04 09:15:00',NULL,NULL,'2026-03-05 16:55:23','2026-03-05 16:55:23');
INSERT INTO `order` VALUES (4,'ORD202403021234',3,5,2,'井冈山·茶文化馆','精选','unreview',228.00,0.00,0.00,0.00,10.00,228.00,NULL,0,'','明天 (预计明天送达)','圆通快递','不开发票','alipay','2024-03-02 09:35:00','2024-03-02 14:20:00','2024-03-04 10:30:00',NULL,'2026-03-05 16:55:23','2026-04-02 20:24:27');
INSERT INTO `order` VALUES (5,'ORD202402281234',4,7,1,'漫思茶·官方旗舰店','官方','completed',366.00,30.00,10.00,20.00,10.00,336.00,2,100,'','明天 (预计明天送达)','顺丰快递','个人发票','wechat','2024-02-28 11:50:00','2024-02-28 16:30:00','2024-03-01 14:20:00',NULL,'2026-03-05 16:55:23','2026-04-02 20:24:30');
INSERT INTO `order` VALUES (6,'ORD202402251234',5,9,3,'武夷岩茶·官方店','官方','completed',656.00,30.00,20.00,10.00,20.00,626.00,2,200,'','今天 (16:00前下单，今日送达)','顺丰快递','个人发票','wechat','2024-02-25 14:30:00','2024-02-26 10:15:00','2024-02-28 16:40:00',NULL,'2026-03-05 16:55:23','2026-04-02 20:24:58');
INSERT INTO `order` VALUES (7,'ORD202402201234',6,11,1,'漫思茶·官方旗舰店','官方','cancelled',564.00,0.00,0.00,0.00,20.00,564.00,NULL,0,'','今天 (16:00前下单，今日送达)','顺丰快递','不开发票',NULL,NULL,NULL,NULL,'不想要了','2026-03-05 16:55:23','2026-04-02 20:24:58');
INSERT INTO `order` VALUES (8,'ORD202402181234',7,12,4,'福鼎白茶·专卖店','精选','completed',516.00,10.00,0.00,10.00,20.00,506.00,2,0,'','今天 (16:00前下单，今日送达)','圆通快递','不开发票','alipay','2024-02-18 15:20:00','2024-02-19 09:30:00','2024-02-21 11:15:00',NULL,'2026-03-05 16:55:23','2026-04-02 20:25:07');
INSERT INTO `order` VALUES (9,'ORD202402151234',8,13,5,'普洱人家·专营店','官方','completed',398.00,0.00,0.00,0.00,10.00,398.00,NULL,0,'','明天 (预计明天送达)','顺丰快递','个人发票','wechat','2024-02-15 10:10:00','2024-02-15 16:45:00','2024-02-17 14:30:00',NULL,'2026-03-05 16:55:23','2026-04-02 20:24:42');
INSERT INTO `order` VALUES (10,'ORD202402121234',9,14,1,'漫思茶·官方旗舰店','官方','unpaid',448.00,20.00,0.00,20.00,10.00,428.00,3,0,'','明天 (预计明天送达)','顺丰快递','不开发票',NULL,NULL,NULL,NULL,NULL,'2026-03-05 16:55:23','2026-04-02 20:24:45');
INSERT INTO `order` VALUES (11,'ORD202402101234',10,15,6,'景德镇茶具·旗舰店','精品','unship',568.00,0.00,0.00,0.00,0.00,568.00,NULL,0,'请仔细包装，易碎品','后天 (预计后天送达)','顺丰快递','个人发票','wechat','2024-02-10 13:25:00','2024-02-11 09:20:00',NULL,NULL,'2026-03-05 16:55:23','2026-04-02 20:25:02');
INSERT INTO `order` VALUES (12,'ORD202402081234',1,2,2,'井冈山·茶文化馆','精选','unreview',228.00,0.00,0.00,0.00,0.00,228.00,NULL,0,'','后天 (预计后天送达)','顺丰快递','不开发票','wechat','2024-02-08 16:30:00','2024-02-09 10:15:00','2024-02-11 14:20:00',NULL,'2026-03-05 16:55:23','2026-04-02 20:25:04');
INSERT INTO `order` VALUES (13,'ORD202603160001',11,17,3,'武夷岩茶·专营店','旗舰店','unreview',656.00,30.00,10.00,20.00,10.00,626.00,NULL,100,'请用礼盒包装','明天 (预计明天送达)','顺丰快递','个人发票','wechat','2026-03-16 10:30:00',NULL,NULL,NULL,'2026-03-16 10:59:17','2026-10-23 16:20:10');
INSERT INTO `order` VALUES (14,'ORD202610067806',11,17,NULL,NULL,NULL,'cancelled',108.00,0.00,0.00,0.00,0.00,108.00,NULL,0,'','','','不开发票','wechat',NULL,NULL,NULL,NULL,'2026-10-06 00:49:48','2026-10-24 17:03:09');
INSERT INTO `order` VALUES (15,'ORD202610060238',11,17,NULL,NULL,NULL,'unpaid',108.00,0.00,0.00,0.00,0.00,108.00,NULL,0,'','','','不开发票','wechat',NULL,NULL,NULL,NULL,'2026-10-06 00:49:50','2026-10-06 00:49:50');
INSERT INTO `order` VALUES (16,'ORD202610061581',11,17,NULL,NULL,NULL,'unpaid',108.00,0.00,0.00,0.00,0.00,108.00,NULL,0,'','','','不开发票','wechat',NULL,NULL,NULL,NULL,'2026-10-06 00:49:52','2026-10-06 00:49:51');
INSERT INTO `order` VALUES (17,'ORD202610061742',11,17,NULL,NULL,NULL,'unpaid',108.00,0.00,0.00,0.00,0.00,108.00,NULL,0,'','','','不开发票','wechat',NULL,NULL,NULL,NULL,'2026-10-06 00:49:52','2026-10-06 00:49:51');
INSERT INTO `order` VALUES (18,'ORD202610061917',11,17,NULL,NULL,NULL,'unpaid',108.00,0.00,0.00,0.00,0.00,108.00,NULL,0,'','','','不开发票','wechat',NULL,NULL,NULL,NULL,'2026-10-06 00:49:52','2026-10-06 00:49:51');
INSERT INTO `order` VALUES (19,'ORD202610069702',11,18,NULL,NULL,NULL,'unpaid',108.00,0.00,0.00,0.00,0.00,108.00,NULL,0,'','','','不开发票','wechat',NULL,NULL,NULL,NULL,'2026-10-06 00:50:00','2026-10-06 00:49:59');
INSERT INTO `order` VALUES (20,'ORD202610069901',11,18,NULL,NULL,NULL,'cancelled',108.00,0.00,0.00,0.00,0.00,108.00,NULL,0,'','','','不开发票','wechat',NULL,NULL,NULL,NULL,'2026-10-06 00:50:00','2026-10-24 17:03:12');
INSERT INTO `order` VALUES (21,'ORD202610060094',11,18,NULL,NULL,NULL,'unpaid',108.00,0.00,0.00,0.00,0.00,108.00,NULL,0,'','','','不开发票','wechat',NULL,NULL,NULL,NULL,'2026-10-06 00:50:00','2026-10-06 00:50:00');
INSERT INTO `order` VALUES (22,'ORD202610068697',1,1,7,'西湖龙井·原产地',NULL,'cancelled',198.00,0.00,0.00,0.00,0.00,198.00,NULL,0,'Agent 确认流测试订单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-06 12:38:46','2026-10-24 17:00:04');
INSERT INTO `order` VALUES (23,'ORD202610069598',1,1,7,'西湖龙井·原产地',NULL,'unpaid',198.00,0.00,0.00,0.00,0.00,198.00,NULL,0,'Agent 确认流测试订单(完整)',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-06 12:41:10','2026-10-06 12:41:09');
INSERT INTO `order` VALUES (24,'ORD202610066868',1,1,7,'',NULL,'unpaid',198.00,0.00,0.00,0.00,0.00,198.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-06 12:59:36','2026-10-06 12:59:36');
INSERT INTO `order` VALUES (25,'ORD202610061464',1,1,7,'',NULL,'unpaid',198.00,0.00,0.00,0.00,0.00,198.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-06 13:00:45','2026-10-06 13:00:44');
INSERT INTO `order` VALUES (26,'ORD202610064385',11,18,NULL,NULL,NULL,'unpaid',108.00,0.00,0.00,0.00,0.00,108.00,NULL,0,'','','','不开发票',NULL,NULL,'2026-10-24 11:32:24','2026-10-24 11:32:24',NULL,'2026-10-06 20:10:04','2026-10-24 11:32:44');
INSERT INTO `order` VALUES (27,'ORD202610065384',11,18,NULL,NULL,NULL,'cancelled',108.00,0.00,0.00,0.00,0.00,108.00,NULL,0,'','','','不开发票','wechat',NULL,NULL,NULL,NULL,'2026-10-06 20:10:05','2026-10-23 17:02:37');
INSERT INTO `order` VALUES (28,'ORD202610068543',11,18,5,'普洱人家·专营店','精选','cancelled',1072.00,0.00,0.00,0.00,0.00,1072.00,NULL,0,'','','','不开发票','wechat',NULL,NULL,NULL,'不想要了','2026-10-06 23:02:49','2026-10-09 23:03:22');
INSERT INTO `order` VALUES (29,'ORD202610072504',1,23,7,'',NULL,'unpaid',198.00,0.00,0.00,0.00,0.00,198.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-07 17:03:07','2026-10-07 17:03:07');
INSERT INTO `order` VALUES (30,'ORD202610079021',12,NULL,7,'西湖龙井·原产地','官方','unpaid',368.00,0.00,0.00,0.00,0.00,368.00,NULL,0,'','','','不开发票','wechat',NULL,NULL,NULL,NULL,'2026-10-07 20:00:09','2026-10-07 20:00:09');
INSERT INTO `order` VALUES (31,'ORD202610077945',11,24,7,'',NULL,'unship',368.00,0.00,0.00,0.00,0.00,368.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-07 21:37:01','2026-10-07 21:37:00');
INSERT INTO `order` VALUES (32,'ORD202610083186',11,26,2,'',NULL,'unship',98.00,0.00,0.00,0.00,0.00,98.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-08 12:06:39','2026-10-08 12:06:38');
INSERT INTO `order` VALUES (33,'ORD202610080317',11,28,2,'',NULL,'unship',98.00,0.00,0.00,0.00,0.00,98.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-08 12:18:39','2026-10-08 12:18:39');
INSERT INTO `order` VALUES (34,'ORD202610088594',11,28,2,'',NULL,'unship',88.00,0.00,0.00,0.00,0.00,88.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-08 12:22:23','2026-10-08 12:22:23');
INSERT INTO `order` VALUES (35,'ORD202610088960',11,28,2,'',NULL,'unship',88.00,0.00,0.00,0.00,0.00,88.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-08 12:22:56','2026-10-08 12:22:56');
INSERT INTO `order` VALUES (36,'ORD202610085471',11,28,2,'',NULL,'unship',88.00,0.00,0.00,0.00,0.00,88.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-08 12:23:19','2026-10-08 12:23:18');
INSERT INTO `order` VALUES (37,'ORD202610083846',11,28,2,'',NULL,'unship',88.00,0.00,0.00,0.00,0.00,88.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-08 12:23:25','2026-10-08 12:23:25');
INSERT INTO `order` VALUES (38,'ORD202610084919',11,28,2,'',NULL,'unship',88.00,0.00,0.00,0.00,0.00,88.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-08 12:23:32','2026-10-08 12:23:31');
INSERT INTO `order` VALUES (39,'ORD202610080104',11,28,2,'',NULL,'unship',88.00,0.00,0.00,0.00,0.00,88.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-08 12:24:17','2026-10-08 12:24:16');
INSERT INTO `order` VALUES (40,'ORD202610087195',11,28,2,'',NULL,'unship',88.00,0.00,0.00,0.00,0.00,88.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-08 12:24:33','2026-10-08 12:24:32');
INSERT INTO `order` VALUES (41,'ORD202610089076',11,28,2,'',NULL,'unship',88.00,0.00,0.00,0.00,0.00,88.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-08 12:26:00','2026-10-08 12:26:00');
INSERT INTO `order` VALUES (42,'ORD202610083576',11,28,2,'',NULL,'unship',88.00,0.00,0.00,0.00,0.00,88.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-08 12:26:09','2026-10-08 12:26:09');
INSERT INTO `order` VALUES (43,'ORD202610084312',11,28,2,'',NULL,'unship',88.00,0.00,0.00,0.00,0.00,88.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-08 12:26:53','2026-10-08 12:26:53');
INSERT INTO `order` VALUES (44,'ORD202610080573',11,28,7,'',NULL,'cancelled',108.00,0.00,0.00,0.00,0.00,108.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,'测试取消待发货','2026-10-08 14:59:58','2026-10-09 23:04:17');
INSERT INTO `order` VALUES (45,'ORD202610086540',11,28,7,'',NULL,'unship',108.00,0.00,0.00,0.00,0.00,108.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-08 15:03:31','2026-10-08 15:03:30');
INSERT INTO `order` VALUES (46,'ORD202610085574',11,28,7,'',NULL,'unship',368.00,0.00,0.00,0.00,0.00,368.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-08 15:32:58','2026-10-08 15:32:57');
INSERT INTO `order` VALUES (47,'ORD202610086295',11,28,2,'',NULL,'unship',336.00,0.00,0.00,0.00,0.00,336.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-08 15:37:37','2026-10-08 15:37:37');
INSERT INTO `order` VALUES (48,'ORD202610082754',11,28,2,'',NULL,'unship',336.00,0.00,0.00,0.00,0.00,336.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-08 15:37:44','2026-10-08 15:37:44');
INSERT INTO `order` VALUES (49,'ORD202610087018',11,28,2,'',NULL,'unship',428.00,0.00,0.00,0.00,0.00,428.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-08 17:24:22','2026-10-08 17:24:22');
INSERT INTO `order` VALUES (50,'ORD202610088018',11,28,2,'',NULL,'unship',912.00,0.00,0.00,0.00,0.00,912.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-08 17:57:55','2026-10-08 17:57:55');
INSERT INTO `order` VALUES (51,'ORD202610086124',11,28,3,'',NULL,'unship',680.00,0.00,0.00,0.00,0.00,680.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-08 18:16:56','2026-10-08 18:16:55');
INSERT INTO `order` VALUES (52,'ORD202610087038',11,28,3,'',NULL,'unship',680.00,0.00,0.00,0.00,0.00,680.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-08 18:17:15','2026-10-08 18:17:14');
INSERT INTO `order` VALUES (53,'ORD202610087427',11,28,3,'',NULL,'unreceive',680.00,0.00,0.00,0.00,0.00,680.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,'2026-10-23 17:54:09',NULL,NULL,'2026-10-08 18:42:08','2026-10-24 10:50:35');
INSERT INTO `order` VALUES (54,'ORD202610081687',11,28,9,'',NULL,'unreview',228.00,0.00,0.00,0.00,0.00,228.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,'2026-10-23 17:32:08','2026-10-24 00:55:20',NULL,'2026-10-08 19:13:59','2026-10-24 00:55:20');
INSERT INTO `order` VALUES (55,'ORD202610095246',11,28,7,'西湖龙井·原产地','官方','cancelled',324.00,128.00,128.00,0.00,0.00,196.00,NULL,1280,'','','','不开发票','balance',NULL,NULL,NULL,'其他原因','2026-10-09 23:19:55','2026-10-09 23:20:10');
INSERT INTO `order` VALUES (56,'ORD202610109068',11,28,5,'',NULL,'completed',804.00,0.00,0.00,0.00,0.00,804.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,'2026-10-23 17:02:17','2026-10-23 17:02:47',NULL,'2026-10-10 12:55:27','2026-10-23 20:38:16');
INSERT INTO `order` VALUES (58,'ORD20261023295463c8f1',11,28,7,'',NULL,'unship',108.00,0.00,0.00,0.00,0.00,108.00,NULL,0,'漫思茶Agent确认流下单',NULL,'express',NULL,'wechat',NULL,NULL,NULL,NULL,'2026-10-23 21:16:12','2026-10-23 21:16:11');
INSERT INTO `order` VALUES (60,'ORD202610245423',11,28,7,'西湖龙井·原产地','官方','completed',108.00,0.00,0.00,0.00,12.00,120.00,NULL,0,'','预计1-2天送达，运费12元','顺丰快递','不开发票','wechat','2026-10-24 17:01:02','2026-10-24 17:01:26','2026-10-24 17:01:48',NULL,'2026-10-24 17:00:56','2026-10-24 17:02:01');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单项ID',
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `product_id` bigint NOT NULL COMMENT '商品ID',
  `product_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品名称',
  `product_spec` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '商品规格',
  `product_emoji` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '商品表情',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `quantity` int NOT NULL COMMENT '数量',
  `subtotal` decimal(10,2) NOT NULL COMMENT '小计',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_id` (`order_id`) USING BTREE,
  KEY `idx_product_id` (`product_id`) USING BTREE,
  CONSTRAINT `fk_order_item_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='订单项表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (1,1,1,'明前龙井','2024明前特级 100g','🍃',198.00,2,396.00,'2026-03-05 16:55:31');
INSERT INTO `order_item` VALUES (2,1,2,'狗牯脑茶','高山云雾 150g','🌿',168.00,1,168.00,'2026-03-05 16:55:31');
INSERT INTO `order_item` VALUES (3,2,3,'井冈翠绿','特级 200g','🍵',228.00,1,228.00,'2026-03-05 16:55:31');
INSERT INTO `order_item` VALUES (4,3,1,'明前龙井','2024明前特级 100g','🍃',198.00,2,396.00,'2026-03-05 16:55:31');
INSERT INTO `order_item` VALUES (5,4,3,'井冈翠绿','特级 200g','🍵',228.00,1,228.00,'2026-03-05 16:55:31');
INSERT INTO `order_item` VALUES (6,5,1,'明前龙井','2024明前特级 100g','🍃',198.00,1,198.00,'2026-03-05 16:55:31');
INSERT INTO `order_item` VALUES (7,5,2,'狗牯脑茶','高山云雾 150g','🌿',168.00,1,168.00,'2026-03-05 16:55:31');
INSERT INTO `order_item` VALUES (8,6,8,'大红袍','正岩 100g','🌱',358.00,1,358.00,'2026-03-05 16:55:31');
INSERT INTO `order_item` VALUES (9,6,9,'铁观音','清香型 250g','🍃',228.00,1,228.00,'2026-03-05 16:55:31');
INSERT INTO `order_item` VALUES (10,7,1,'明前龙井','2024明前特级 100g','🍃',198.00,2,396.00,'2026-03-05 16:55:31');
INSERT INTO `order_item` VALUES (11,7,2,'狗牯脑茶','高山云雾 150g','🌿',168.00,1,168.00,'2026-03-05 16:55:31');
INSERT INTO `order_item` VALUES (12,8,11,'白毫银针','特级 100g','🌱',328.00,1,328.00,'2026-03-05 16:55:31');
INSERT INTO `order_item` VALUES (13,8,12,'白牡丹','一级 150g','🌸',188.00,1,188.00,'2026-03-05 16:55:31');
INSERT INTO `order_item` VALUES (14,9,13,'普洱茶','357g 饼茶','🌿',268.00,1,268.00,'2026-03-05 16:55:31');
INSERT INTO `order_item` VALUES (15,10,5,'祁门红茶','特级 150g','🍂',268.00,1,268.00,'2026-03-05 16:55:31');
INSERT INTO `order_item` VALUES (16,10,6,'正山小种','传统 100g','🔥',198.00,1,198.00,'2026-03-05 16:55:31');
INSERT INTO `order_item` VALUES (17,11,15,'霍山黄芽','特级 100g','🌾',258.00,1,258.00,'2026-03-05 16:55:31');
INSERT INTO `order_item` VALUES (18,12,3,'井冈翠绿','特级 200g','🍵',228.00,1,228.00,'2026-03-05 16:55:31');
INSERT INTO `order_item` VALUES (19,4,2,'狗牯脑茶','高山云雾 150g','🌿',168.00,1,168.00,'2026-03-05 16:55:31');
INSERT INTO `order_item` VALUES (20,2,4,'武功山云雾','野生 100g','☁️',188.00,1,188.00,'2026-03-05 16:55:31');
INSERT INTO `order_item` VALUES (21,13,9,'大红袍','标准装 100g','🌱',358.00,1,358.00,'2026-03-16 10:59:24');
INSERT INTO `order_item` VALUES (22,13,11,'肉桂','标准装 100g','🌿',298.00,1,298.00,'2026-03-16 10:59:24');
INSERT INTO `order_item` VALUES (23,23,1,'明前龙井','标准装 100g','🍃',198.00,1,198.00,'2026-10-06 12:41:10');
INSERT INTO `order_item` VALUES (24,24,1,'明前龙井','标准装 100g','🍃',198.00,1,198.00,'2026-10-06 12:59:36');
INSERT INTO `order_item` VALUES (25,25,1,'明前龙井','标准装 100g','🍃',198.00,1,198.00,'2026-10-06 13:00:45');
INSERT INTO `order_item` VALUES (26,28,49,'普洱茶','标准装 357g','🌿',268.00,3,804.00,'2026-10-06 23:02:49');
INSERT INTO `order_item` VALUES (27,28,41,'洞庭碧螺春','标准装 100g','🌱',268.00,1,268.00,'2026-10-06 23:02:49');
INSERT INTO `order_item` VALUES (28,29,1,'明前龙井','标准装 100g','🍃',198.00,1,198.00,'2026-10-07 17:03:08');
INSERT INTO `order_item` VALUES (29,30,50,'明前龙井','礼盒装 200g','🍃',368.00,1,368.00,'2026-10-07 20:00:09');
INSERT INTO `order_item` VALUES (30,31,1,'明前龙井','礼盒装 200g','🍃',368.00,1,368.00,'2026-10-07 21:37:01');
INSERT INTO `order_item` VALUES (31,32,4,'武功山云雾','品鉴装 50g','☁️',98.00,1,98.00,'2026-10-08 12:06:39');
INSERT INTO `order_item` VALUES (32,33,4,'武功山云雾','品鉴装 50g','☁️',98.00,1,98.00,'2026-10-08 12:18:39');
INSERT INTO `order_item` VALUES (33,34,2,'狗牯脑茶','品鉴装 50g','🌿',88.00,1,88.00,'2026-10-08 12:22:23');
INSERT INTO `order_item` VALUES (34,35,2,'狗牯脑茶','品鉴装 50g','🌿',88.00,1,88.00,'2026-10-08 12:22:56');
INSERT INTO `order_item` VALUES (35,36,2,'狗牯脑茶','品鉴装 50g','🌿',88.00,1,88.00,'2026-10-08 12:23:19');
INSERT INTO `order_item` VALUES (36,37,2,'狗牯脑茶','品鉴装 50g','🌿',88.00,1,88.00,'2026-10-08 12:23:25');
INSERT INTO `order_item` VALUES (37,38,2,'狗牯脑茶','品鉴装 50g','🌿',88.00,1,88.00,'2026-10-08 12:23:32');
INSERT INTO `order_item` VALUES (38,39,2,'狗牯脑茶','品鉴装 50g','🌿',88.00,1,88.00,'2026-10-08 12:24:17');
INSERT INTO `order_item` VALUES (39,40,2,'狗牯脑茶','品鉴装 50g','🌿',88.00,1,88.00,'2026-10-08 12:24:33');
INSERT INTO `order_item` VALUES (40,41,2,'狗牯脑茶','品鉴装 50g','🌿',88.00,1,88.00,'2026-10-08 12:26:00');
INSERT INTO `order_item` VALUES (41,42,2,'狗牯脑茶','品鉴装 50g','🌿',88.00,1,88.00,'2026-10-08 12:26:09');
INSERT INTO `order_item` VALUES (42,43,2,'狗牯脑茶','品鉴装 50g','🌿',88.00,1,88.00,'2026-10-08 12:26:53');
INSERT INTO `order_item` VALUES (43,44,1,'明前龙井','品鉴装 50g','🍃',108.00,1,108.00,'2026-10-08 14:59:58');
INSERT INTO `order_item` VALUES (44,45,1,'明前龙井','品鉴装 50g','🍃',108.00,1,108.00,'2026-10-08 15:03:31');
INSERT INTO `order_item` VALUES (45,46,1,'明前龙井','礼盒装 200g','🍃',368.00,1,368.00,'2026-10-08 15:32:58');
INSERT INTO `order_item` VALUES (46,47,2,'狗牯脑茶','标准装 150g','🌿',168.00,2,336.00,'2026-10-08 15:37:37');
INSERT INTO `order_item` VALUES (47,48,2,'狗牯脑茶','标准装 150g','🌿',168.00,2,336.00,'2026-10-08 15:37:44');
INSERT INTO `order_item` VALUES (48,49,3,'井冈翠绿','礼盒装 400g','🍵',428.00,1,428.00,'2026-10-08 17:24:22');
INSERT INTO `order_item` VALUES (49,50,3,'井冈翠绿','标准装 200g','🍵',228.00,4,912.00,'2026-10-08 17:57:55');
INSERT INTO `order_item` VALUES (50,51,9,'大红袍','礼盒装 200g','🌱',680.00,1,680.00,'2026-10-08 18:16:56');
INSERT INTO `order_item` VALUES (51,52,9,'大红袍','礼盒装 200g','🌱',680.00,1,680.00,'2026-10-08 18:17:15');
INSERT INTO `order_item` VALUES (52,53,9,'大红袍','礼盒装 200g','🌱',680.00,1,680.00,'2026-10-08 18:42:08');
INSERT INTO `order_item` VALUES (53,54,10,'铁观音','标准装 250g','🍃',228.00,1,228.00,'2026-10-08 19:13:59');
INSERT INTO `order_item` VALUES (54,55,56,'明前龙井','品鉴装 50g','🍃',108.00,3,324.00,'2026-10-09 23:19:55');
INSERT INTO `order_item` VALUES (55,56,14,'普洱茶','标准装 357g','🌿',268.00,3,804.00,'2026-10-10 12:55:27');
INSERT INTO `order_item` VALUES (57,58,1,'明前龙井','品鉴装 50g','🍃',108.00,1,108.00,'2026-10-23 21:16:12');
INSERT INTO `order_item` VALUES (58,60,58,'明前龙井','品鉴装 50g','🍃',108.00,1,108.00,'2026-10-24 17:00:56');
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '支付ID',
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单号',
  `payment_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '支付流水号',
  `payment_method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '支付方式 wechat-微信 alipay-支付宝 balance-余额',
  `amount` decimal(10,2) NOT NULL COMMENT '支付金额',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'pending' COMMENT '支付状态 pending-处理中 success-成功 failed-失败',
  `transaction_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '第三方交易ID',
  `payment_time` datetime DEFAULT NULL COMMENT '支付时间',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_payment_no` (`payment_no`) USING BTREE,
  UNIQUE KEY `uk_transaction_id` (`transaction_id`) USING BTREE,
  KEY `idx_order_id` (`order_id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE,
  CONSTRAINT `fk_payment_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='支付表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,2,'ORD202403041234','PAY202403041234001','wechat',228.00,'success','WX2024030412345678','2024-03-04 10:20:00','2026-03-05 16:55:41','2026-03-05 16:55:41');
INSERT INTO `payment` VALUES (2,3,'ORD202403031234','PAY202403031234001','wechat',366.00,'success','WX2024030312345678','2024-03-03 16:25:00','2026-03-05 16:55:41','2026-03-05 16:55:41');
INSERT INTO `payment` VALUES (3,4,'ORD202403021234','PAY202403021234001','alipay',228.00,'success','ALI2024030212345678','2024-03-02 09:35:00','2026-03-05 16:55:41','2026-03-05 16:55:41');
INSERT INTO `payment` VALUES (4,5,'ORD202402281234','PAY202402281234001','wechat',336.00,'success','WX2024022812345678','2024-02-28 11:50:00','2026-03-05 16:55:41','2026-03-05 16:55:41');
INSERT INTO `payment` VALUES (5,6,'ORD202402251234','PAY202402251234001','wechat',626.00,'success','WX2024022512345678','2024-02-25 14:30:00','2026-03-05 16:55:41','2026-03-05 16:55:41');
INSERT INTO `payment` VALUES (6,8,'ORD202402181234','PAY202402181234001','alipay',506.00,'success','ALI2024021812345678','2024-02-18 15:20:00','2026-03-05 16:55:41','2026-03-05 16:55:41');
INSERT INTO `payment` VALUES (7,9,'ORD202402151234','PAY202402151234001','wechat',398.00,'success','WX2024021512345678','2024-02-15 10:10:00','2026-03-05 16:55:41','2026-03-05 16:55:41');
INSERT INTO `payment` VALUES (8,11,'ORD202402101234','PAY202402101234001','wechat',568.00,'success','WX2024021012345678','2024-02-10 13:25:00','2026-03-05 16:55:41','2026-03-05 16:55:41');
INSERT INTO `payment` VALUES (9,12,'ORD202402081234','PAY202402081234001','wechat',228.00,'success','WX2024020812345678','2024-02-08 16:30:00','2026-03-05 16:55:41','2026-03-05 16:55:41');
INSERT INTO `payment` VALUES (10,1,'ORD202403051234','PAY202403051234001','wechat',762.00,'pending',NULL,NULL,'2026-03-05 16:55:41','2026-03-05 16:55:41');
INSERT INTO `payment` VALUES (13,60,'ORD202610245423','PAY20261024542362936','wechat',120.00,'success',NULL,'2026-10-24 17:01:02','2026-10-24 17:01:02','2026-10-24 17:01:02');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `points_record`
--

DROP TABLE IF EXISTS `points_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `points_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `points` int NOT NULL COMMENT '积分变动数量(正增负减)',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '类型 order-订单支付 review-评价 sign-签到 share-分享 refund-退款',
  `order_id` bigint DEFAULT NULL COMMENT '关联订单ID',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '描述',
  `balance` int NOT NULL COMMENT '变动后余额',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_type` (`type`) USING BTREE,
  KEY `idx_order_id` (`order_id`) USING BTREE,
  CONSTRAINT `fk_points_record_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='积分记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `points_record`
--

LOCK TABLES `points_record` WRITE;
/*!40000 ALTER TABLE `points_record` DISABLE KEYS */;
INSERT INTO `points_record` VALUES (1,1,200,'order',1,'订单消费获得积分',200,'2026-03-05 16:56:03');
INSERT INTO `points_record` VALUES (2,1,50,'review',3,'评价订单获得积分',250,'2026-03-05 16:56:03');
INSERT INTO `points_record` VALUES (3,1,30,'sign',NULL,'连续签到7天获得积分',280,'2026-03-05 16:56:03');
INSERT INTO `points_record` VALUES (4,1,1000,'order',5,'订单消费获得积分',1280,'2026-03-05 16:56:03');
INSERT INTO `points_record` VALUES (5,2,150,'order',2,'订单消费获得积分',150,'2026-03-05 16:56:03');
INSERT INTO `points_record` VALUES (6,2,200,'order',4,'订单消费获得积分',350,'2026-03-05 16:56:03');
INSERT INTO `points_record` VALUES (7,2,500,'share',NULL,'分享商品获得积分',850,'2026-03-05 16:56:03');
INSERT INTO `points_record` VALUES (8,3,180,'order',3,'订单消费获得积分',180,'2026-03-05 16:56:03');
INSERT INTO `points_record` VALUES (9,3,120,'order',4,'订单消费获得积分',300,'2026-03-05 16:56:03');
INSERT INTO `points_record` VALUES (10,3,50,'sign',NULL,'连续签到5天获得积分',350,'2026-03-05 16:56:03');
INSERT INTO `points_record` VALUES (11,3,300,'review',4,'评价订单获得积分',650,'2026-03-05 16:56:03');
INSERT INTO `points_record` VALUES (12,4,250,'order',5,'订单消费获得积分',250,'2026-03-05 16:56:03');
INSERT INTO `points_record` VALUES (13,4,80,'sign',NULL,'连续签到3天获得积分',330,'2026-03-05 16:56:03');
INSERT INTO `points_record` VALUES (14,5,300,'order',6,'订单消费获得积分',300,'2026-03-05 16:56:03');
INSERT INTO `points_record` VALUES (15,5,150,'share',NULL,'分享商品获得积分',450,'2026-03-05 16:56:03');
INSERT INTO `points_record` VALUES (23,11,50,'review',NULL,'评价审核通过奖励',1550,'2026-10-24 12:00:15');
INSERT INTO `points_record` VALUES (24,11,50,'review',NULL,'评价审核通过奖励',1600,'2026-10-24 17:02:23');
/*!40000 ALTER TABLE `points_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `category_id` int NOT NULL COMMENT '分类ID',
  `shop_id` int DEFAULT NULL COMMENT '店铺ID',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品名称',
  `subtitle` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '副标题',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '商品描述',
  `tasting_notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '品鉴笔记',
  `year` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '年份（如：2025、2018年）',
  `craft` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '工艺（如：传统手工炒制、机制）',
  `origin` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '产地',
  `origin_detail` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '产地详情',
  `spec` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '规格',
  `price` decimal(10,2) NOT NULL COMMENT '价格',
  `original_price` decimal(10,2) DEFAULT NULL COMMENT '原价',
  `stock` int DEFAULT '0' COMMENT '库存',
  `sales` int DEFAULT '0' COMMENT '销量',
  `rating` decimal(2,1) DEFAULT '5.0' COMMENT '评分',
  `emoji` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '?' COMMENT '商品表情',
  `is_new` tinyint(1) DEFAULT '0' COMMENT '是否新品',
  `is_hot` tinyint(1) DEFAULT '0' COMMENT '是否热卖',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态 0-下架 1-上架',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_category_id` (`category_id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_is_hot` (`is_hot`) USING BTREE,
  KEY `idx_is_new` (`is_new`) USING BTREE,
  KEY `idx_shop_id` (`shop_id`) USING BTREE,
  CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_product_shop` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='商品表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,1,7,'明前龙井','明前特级','香气清高，滋味鲜爽，回甘持久','干茶扁平光滑，色泽嫩绿带黄；冲泡后香气清高，有豆香和兰花香；汤色清澈明亮，滋味鲜爽甘醇，回甘持久；叶底嫩匀成朵，色泽嫩绿。','2025','传统手工炒制','西湖','浙江·杭州','标准装 100g',198.00,298.00,100,99,4.9,'🍃',1,1,1,'2026-03-05 16:30:01','2026-10-23 17:06:42');
INSERT INTO `product` VALUES (2,1,2,'狗牯脑茶','高山云雾','汤色清澈，香气独特，有淡淡的花香','条索卷曲紧结，色泽翠绿；香气清高持久，有独特的花香；汤色清澈明亮，滋味鲜爽醇厚，回甘明显；叶底嫩匀完整。','2025','传统工艺','遂川','江西·遂川','标准装 150g',168.00,228.00,80,89,4.8,'🌿',0,1,1,'2026-03-05 16:30:01','2026-03-14 17:45:35');
INSERT INTO `product` VALUES (3,1,2,'井冈翠绿','特级绿茶','色泽翠绿，香气持久，滋味醇厚','外形条索紧结，色泽翠绿；香气清高持久，有豆香；汤色清澈明亮，滋味鲜爽醇厚，回甘悠长；叶底嫩匀成朵。','2025','传统手工','井冈山','江西·吉安','标准装 200g',228.00,328.00,60,143,4.9,'🍵',1,0,1,'2026-03-05 16:30:01','2026-10-24 11:24:46');
INSERT INTO `product` VALUES (4,1,2,'武功山云雾','野生绿茶','生长于海拔1000米以上，云雾滋养','条索紧结，色泽翠绿；香气清高，有高山韵；汤色清澈明亮，滋味鲜爽甘醇，山野气息明显；叶底嫩匀完整。','2025','野生传统工艺','武功山','江西·萍乡','标准装 100g',188.00,258.00,50,112,4.7,'☁️',0,1,1,'2026-03-05 16:30:01','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (5,2,1,'祁门红茶','特级祁红','似花似果似蜜，独特的祁门香','条索紧细，色泽乌润；香气高长，似花似果似蜜，独特的祁门香；汤色红艳明亮，滋味醇厚，回味隽永；叶底红亮匀齐。','2025','传统工夫红茶工艺','祁门','安徽·黄山','标准装 150g',268.00,368.00,70,87,4.8,'🍂',0,1,1,'2026-03-05 16:30:01','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (6,2,13,'武夷岩茶','野生红茶','香气馥郁悠长，兼具兰花香与岩骨花香','条索紧结，色泽乌褐；香气馥郁，有兰花香和岩韵；汤色橙黄明亮，滋味醇厚，岩韵明显；叶底软亮，红边明显。','2025','传统工艺','武夷山','福建·南平','标准装 100g',358.00,458.00,50,0,5.0,'🌱',1,0,1,'2026-03-05 16:30:01','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (7,2,3,'正山小种','传统烟熏','松烟香，桂圆汤，传统工艺','条索粗壮，色泽乌润；香气松烟香明显，带有桂圆汤香；汤色红浓明亮，滋味醇厚，有独特的松烟味；叶底红亮。','2025','传统松烟熏制','武夷山','福建·南平','标准装 100g',198.00,298.00,90,112,4.6,'🔥',0,0,1,'2026-03-05 20:43:40','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (8,2,3,'金骏眉','顶级红茶','金毫显露，滋味甘甜','条索紧细，金毫显露；香气蜜糖香明显，花香清雅；汤色金黄明亮，滋味甘甜醇厚，口感顺滑；叶底红亮匀齐。','2025','传统手工','武夷山','福建·南平','标准装 50g',398.00,598.00,40,45,4.9,'✨',1,1,1,'2026-03-05 20:43:40','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (9,2,3,'大红袍','岩茶之王','岩韵明显，香气馥郁','条索紧结，色泽乌褐；香气馥郁，兰花香明显，岩韵独特；汤色橙黄明亮，滋味醇厚甘爽，岩韵悠长；叶底软亮。','2025','传统岩茶工艺','武夷山','福建·南平','标准装 100g',358.00,458.00,55,78,4.8,'🌱',1,0,1,'2026-03-05 20:43:40','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (10,3,9,'铁观音','清香型','兰花香，观音韵','条索卷曲，色泽砂绿；香气兰花香明显，观音韵足；汤色金黄明亮，滋味醇厚甘鲜，回甘生津；叶底肥厚软亮。','2025','传统乌龙茶工艺','安溪','福建·泉州','标准装 250g',228.00,328.00,85,156,4.7,'🍃',0,1,1,'2026-03-05 20:43:40','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (11,3,3,'肉桂','岩茶','桂皮香，辛辣感','条索紧结，色泽乌褐；香气辛锐，桂皮香明显；汤色橙黄明亮，滋味醇厚，辛辣感强，岩韵明显；叶底软亮。','2025','传统岩茶工艺','武夷山','福建·南平','标准装 100g',298.00,398.00,45,67,4.8,'🌿',0,0,1,'2026-03-05 20:43:40','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (12,4,4,'白毫银针','白茶珍品','满披白毫，如银似雪','芽头肥壮，满披白毫；香气毫香明显，清雅；汤色浅黄明亮，滋味清甜鲜爽，毫味足；叶底嫩匀完整。','2025','传统白茶工艺','福鼎','福建·宁德','标准装 100g',328.00,428.00,40,34,4.9,'🌱',1,1,1,'2026-03-05 20:43:40','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (13,4,4,'白牡丹','白茶','一芽一叶，花香明显','一芽一二叶，色泽灰绿；香气花香明显，清雅；汤色杏黄明亮，滋味清甜醇和，花香入水；叶底嫩匀。','2025','传统白茶工艺','政和','福建·南平','标准装 150g',188.00,268.00,70,89,4.6,'🌸',0,0,1,'2026-03-05 20:43:40','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (14,5,5,'普洱茶','生茶','陈香显著，回甘生津','条索肥壮，色泽青褐；香气陈香明显，有蜜香；汤色橙黄明亮，滋味醇厚，回甘生津；叶底肥厚软亮。','2020','传统普洱生茶工艺','勐海','云南·西双版纳','标准装 357g',268.00,368.00,60,56,4.7,'🌿',0,1,1,'2026-03-05 20:43:40','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (15,5,15,'安化黑茶','茯砖','金花茂盛，菌香明显','砖面平整，金花茂盛；香气菌香明显，醇和；汤色橙红明亮，滋味醇厚甘甜，菌香入水；叶底肥厚。','2023','传统茯砖工艺','安化','湖南·益阳','收藏装 1000g',398.00,498.00,30,23,4.8,'🍂',1,0,1,'2026-03-05 20:43:40','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (16,6,1,'霍山黄芽','黄茶','黄叶黄汤，鲜爽甘醇','条索紧细，色泽黄绿；香气清高，有甜香；汤色黄亮清澈，滋味鲜爽甘醇，回味甘甜；叶底嫩匀。','2025','传统黄茶工艺','霍山','安徽·六安','标准装 100g',258.00,328.00,45,32,4.7,'🌾',0,0,1,'2026-03-05 20:43:40','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (17,1,11,'洞庭碧螺春','吓煞人香','条索纤细，卷曲成螺，满身披毫，银绿隐翠，香气浓郁','条索纤细，卷曲成螺，满身披毫；香气浓郁，花果香明显；汤色清澈明亮，滋味鲜爽甘醇，回甘持久；叶底嫩匀。','2025','传统手工炒制','洞庭山','江苏·苏州','标准装 100g',268.00,368.00,75,89,4.9,'🌱',1,1,1,'2026-03-05 20:56:37','2026-03-14 17:45:56');
INSERT INTO `product` VALUES (18,1,8,'黄山毛峰','云雾茶','形似雀舌，峰显毫露，色如象牙，鱼叶金黄，清香高长','形似雀舌，峰显毫露；香气清高，有兰花香；汤色清澈明亮，滋味醇厚甘甜，回甘明显；叶底嫩匀成朵。','2025','传统手工','黄山','安徽·黄山','标准装 150g',188.00,258.00,120,234,4.8,'⛰️',0,1,1,'2026-03-05 20:56:37','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (19,1,8,'六安瓜片','瓜子片','单片叶制成，无芽无梗，形似瓜子，宝绿带霜，滋味鲜醇','单片叶制成，形似瓜子；香气清高，有豆香；汤色清澈明亮，滋味鲜爽醇厚，回甘悠长；叶底嫩匀。','2025','传统工艺','六安','安徽·六安','标准装 100g',228.00,328.00,60,98,4.8,'🍃',1,0,1,'2026-03-05 20:56:37','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (20,2,14,'滇红工夫','金毫茶','条索肥硕，金毫显露，色泽乌润，汤色红艳，滋味浓厚','条索肥硕，金毫显露；香气麦芽糖香明显，浓郁；汤色红艳明亮，滋味浓厚鲜爽，回甘明显；叶底红亮。','2025','传统工夫红茶','凤庆','云南·临沧','标准装 150g',198.00,268.00,85,143,4.7,'🍂',1,1,1,'2026-03-05 20:56:37','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (21,2,14,'英德红茶','英红九号','条索紧结，色泽乌润，香气鲜纯，汤色红亮，滋味醇厚','条索紧结，色泽乌润；香气鲜纯，花果香明显；汤色红亮，滋味醇厚鲜爽，回甘快；叶底红亮匀齐。','2025','机制工艺','英德','广东·清远','标准装 100g',158.00,228.00,90,112,4.6,'🔥',0,0,1,'2026-03-05 20:56:37','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (22,3,13,'凤凰单丛','鸭屎香','条索紧结，色泽乌褐，香气高扬，汤色橙黄，山韵独特','条索紧结，色泽乌褐；香气高扬，蜜兰香明显；汤色橙黄明亮，滋味醇厚，山韵独特；叶底软亮。','2025','传统单丛工艺','潮州','广东·潮州','标准装 100g',328.00,428.00,45,67,4.9,'🍂',1,1,1,'2026-03-05 20:56:37','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (23,3,12,'冻顶乌龙','冻顶茶','半球形，色泽墨绿，清香扑鼻，汤色金黄，滋味醇厚','半球形，色泽墨绿；香气清香扑鼻，有花香；汤色金黄明亮，滋味醇厚甘爽，回甘生津；叶底软亮。','2025','传统冻顶工艺','鹿谷','台湾·南投','标准装 150g',258.00,358.00,55,78,4.7,'⛰️',0,1,1,'2026-03-05 20:56:37','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (24,3,12,'东方美人','白毫乌龙','五色茶，白毫显著，带有天然蜜香和果香，茶汤琥珀色','五色茶，白毫显著；香气天然蜜香和果香；汤色琥珀色明亮，滋味醇厚甘甜，蜜香入水；叶底红褐。','2025','传统东方美人工艺','新竹','台湾·新竹','标准装 75g',398.00,498.00,30,45,4.9,'🌺',1,1,1,'2026-03-05 20:56:37','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (25,3,3,'漳平水仙','水仙茶饼','方形茶饼，色泽乌褐，香气清雅，汤色橙黄，滋味甘醇','方形茶饼，色泽乌褐；香气清雅，有花香；汤色橙黄明亮，滋味甘醇爽口，回甘明显；叶底软亮。','2025','传统水仙工艺','漳平','福建·龙岩','标准装 100g',188.00,258.00,65,56,4.6,'🍃',0,0,1,'2026-03-05 20:56:37','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (26,3,9,'永春佛手','香橼茶','叶大如掌，形似佛手，香气浓郁，汤色金黄，滋味醇厚','叶大如掌，形似佛手；香气浓郁，香橼味明显；汤色金黄明亮，滋味醇厚甘甜，香橼入水；叶底肥厚。','2025','传统佛手工艺','永春','福建·泉州','标准装 100g',208.00,288.00,50,43,4.7,'🌿',1,0,1,'2026-03-05 20:56:37','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (27,4,4,'贡眉','寿眉','一芽二三叶，色泽灰绿，香气清纯，汤色杏黄，滋味甘甜','一芽二三叶，色泽灰绿；香气清纯，有毫香；汤色杏黄明亮，滋味甘甜清爽，回甘明显；叶底嫩匀。','2025','传统白茶工艺','建阳','福建·南平','标准装 200g',128.00,188.00,100,156,4.5,'🌾',0,1,1,'2026-03-05 20:56:37','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (28,4,4,'寿眉','老白茶','叶片肥大，色泽褐绿，陈香明显，汤色橙红，滋味醇和','叶片肥大，色泽褐绿；香气陈香明显，枣香；汤色橙红明亮，滋味醇和甘甜，枣香入水；叶底肥厚。','2018','传统白茶工艺','福鼎','福建·宁德','标准装 300g',198.00,298.00,70,89,4.7,'🍂',1,1,1,'2026-03-05 20:56:37','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (29,4,4,'新工艺白茶','新白茶','轻发酵工艺，外形卷缩，香气清鲜，汤色浅黄，滋味清爽','外形卷缩，色泽灰绿；香气清鲜，有花香；汤色浅黄明亮，滋味清爽甘甜，回甘快；叶底嫩匀。','2025','新工艺白茶','政和','福建·南平','标准装 100g',98.00,158.00,120,134,4.4,'🌱',0,0,1,'2026-03-05 20:56:37','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (30,5,5,'六堡茶','广西黑茶','条索紧结，色泽黑褐，汤色红浓，陈香明显，滋味醇厚','条索紧结，色泽黑褐；香气陈香明显，有槟榔香；汤色红浓明亮，滋味醇厚，槟榔香明显；叶底红褐。','2022','传统六堡工艺','梧州','广西·梧州','标准装 200g',268.00,368.00,55,67,4.7,'🍂',1,1,1,'2026-03-05 20:56:37','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (31,5,15,'青砖茶','湖北黑茶','长方形砖，色泽青褐，香气纯正，汤色橙红，滋味醇和','长方形砖，色泽青褐；香气纯正，有陈香；汤色橙红明亮，滋味醇和甘甜，回甘明显；叶底青褐。','2023','传统青砖工艺','赤壁','湖北·咸宁','标准装 500g',158.00,228.00,80,54,4.5,'🧱',0,0,1,'2026-03-05 20:56:37','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (32,5,15,'康砖茶','四川黑茶','圆角矩形，色泽棕褐，香气陈醇，汤色红亮，滋味醇厚','圆角矩形，色泽棕褐；香气陈醇，有菌香；汤色红亮，滋味醇厚甘甜，菌香明显；叶底棕褐。','2022','传统康砖工艺','雅安','四川·雅安','标准装 300g',188.00,258.00,65,43,4.6,'🏺',1,0,1,'2026-03-05 20:56:37','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (33,5,15,'茯砖茶','金花茯砖','砖面平整，金花茂盛，菌香明显，汤色橙红，滋味甘醇','砖面平整，金花茂盛；香气菌香明显，醇和；汤色橙红明亮，滋味甘醇爽口，菌香入水；叶底肥厚。','2024','传统茯砖工艺','泾阳','陕西·咸阳','收藏装 1000g',298.00,398.00,40,32,4.8,'🌿',1,1,1,'2026-03-05 20:56:37','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (34,6,1,'君山银针','黄茶之冠','芽头肥壮，满披茸毛，金黄光亮，汤色杏黄，滋味甘醇','芽头肥壮，满披茸毛；香气清高，有甜香；汤色杏黄明亮，滋味甘醇鲜爽，回甘明显；叶底嫩匀。','2025','传统黄茶工艺','岳阳','湖南·岳阳','标准装 50g',358.00,458.00,35,42,4.9,'🌱',1,1,1,'2026-03-05 20:56:37','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (35,6,1,'蒙顶黄芽','蒙顶茶','扁直芽型，色泽黄绿，甜香浓郁，汤色黄亮，滋味甘醇','扁直芽型，色泽黄绿；香气甜香浓郁，有花香；汤色黄亮，滋味甘醇爽口，甜香入水；叶底嫩匀。','2025','传统黄茶工艺','雅安','四川·雅安','标准装 100g',288.00,368.00,45,36,4.7,'⛰️',1,0,1,'2026-03-05 20:56:37','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (36,6,1,'远安黄茶','鹿苑茶','条索环状，色泽金黄，香气持久，汤色黄亮，滋味醇厚','条索环状，色泽金黄；香气持久，有花香；汤色黄亮，滋味醇厚甘甜，回甘明显；叶底嫩匀。','2025','传统黄茶工艺','远安','湖北·宜昌','标准装 100g',238.00,318.00,40,28,4.6,'🌾',0,0,1,'2026-03-05 20:56:37','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (37,7,6,'朱泥小壶','宜兴紫砂·朱泥','采用宜兴原矿朱泥，手工制作，容量150ml，适合冲泡乌龙茶、红茶。壶型圆润，出水顺畅，握持舒适。','朱泥壶适合冲泡乌龙茶、红茶，能很好地激发茶香。使用前需用温水温壶，冲泡时注意出水速度。','2024','全手工制作','宜兴','江苏·无锡','标准款 150ml',680.00,880.00,30,45,4.9,'🫖',1,1,1,'2026-03-07 22:52:15','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (38,7,6,'油滴建盏','宋代风格·油滴盏','仿宋建窑油滴盏，束口器型，釉面油滴斑纹清晰，银光闪烁。口径9cm，适合品茗各类茶汤。','建盏胎厚，保温性好，适合品饮各类茶汤。茶汤入盏，在油滴斑纹映衬下更显醇和。','2024','传统建窑烧制','建阳','福建·南平','标准款 9cm',580.00,780.00,25,38,4.8,'🏺',1,1,1,'2026-03-07 22:52:15','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (39,7,6,'青花品茗杯','景德镇手绘·青花','景德镇高白泥手绘青花，胎体轻薄，透光性好。容量50ml，青花发色纯正，图案典雅。','青花杯胎薄轻巧，透光性好，适合品饮绿茶、白茶，能很好地观察汤色。','2024','手绘青花','景德镇','江西·景德镇','单杯 50ml',280.00,380.00,50,67,4.7,'🥃',0,1,1,'2026-03-07 22:52:15','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (40,7,6,'紫砂西施','原矿紫泥·西施壶','经典西施壶型，选用宜兴原矿紫泥，容量200ml。壶身圆润，短嘴倒把，出水有力。','西施壶圆润饱满，出水流畅，适合冲泡普洱茶、黑茶等需要高温的茶类。','2023','全手工制作','宜兴','江苏·无锡','标准款 200ml',880.00,1080.00,20,32,4.9,'🫖',1,1,1,'2026-03-07 22:52:15','2026-03-11 10:22:26');
INSERT INTO `product` VALUES (41,7,6,'兔毫建盏','宋代风格·兔毫盏','仿宋建窑兔毫盏，敛口器型，釉面兔毫纹路清晰，银光闪烁。口径8.5cm，适合品茗。','兔毫盏釉面独特，茶汤入盏在兔毫纹路映衬下更显醇和，适合品饮各类茶。','2024','传统建窑烧制','建阳','福建·南平','标准款 8.5cm',620.00,820.00,22,29,4.8,'🏺',0,1,1,'2026-03-07 22:52:15','2026-03-11 10:22:27');
INSERT INTO `product` VALUES (42,7,6,'汝窑茶杯','天青色·汝窑','仿宋汝窑天青色，釉面开片自然，手感温润如玉。容量60ml，茶汤入杯，更显醇和。','汝窑茶杯釉面温润如玉，开片自然，适合品饮各类茶，尤其适合绿茶、白茶。','2024','传统汝窑工艺','汝州','河南·平顶山','单杯 60ml',380.00,480.00,40,53,4.7,'🥃',1,0,1,'2026-03-07 22:52:15','2026-03-11 10:22:27');
INSERT INTO `product` VALUES (43,7,6,'汉铎壶','紫泥·汉铎壶','传统汉铎壶型，宜兴原矿紫泥，容量220ml。壶身刻有茶诗，文人气息浓郁。','汉铎壶造型古朴，壶身刻有茶诗，文人气息浓郁，适合冲泡乌龙茶、红茶。','2023','全手工制作','宜兴','江苏·无锡','标准款 220ml',780.00,980.00,18,24,4.8,'🫖',0,0,1,'2026-03-07 22:52:15','2026-03-11 10:22:27');
INSERT INTO `product` VALUES (44,7,6,'玳瑁建盏','七彩曜变·玳瑁盏','仿宋建窑玳瑁盏，釉面呈现七彩曜变效果，色彩斑斓。口径9cm，收藏级建盏。','玳瑁建盏釉面七彩曜变，色彩斑斓，收藏级建盏，适合品饮各类名茶。','2023','传统建窑烧制','建阳','福建·南平','标准款 9cm',980.00,1280.00,10,15,4.9,'🏺',1,1,1,'2026-03-07 22:52:15','2026-03-11 10:22:27');
INSERT INTO `product` VALUES (45,7,6,'德化白瓷','羊脂玉·品茗杯','德化白瓷，胎质细腻，釉面如羊脂白玉。容量80ml，适合品饮各类茶。','德化白瓷胎质细腻，釉面如羊脂白玉，适合品饮各类茶，尤其适合白茶、绿茶。','2024','德化白瓷工艺','德化','福建·泉州','单杯 80ml',320.00,420.00,45,58,4.6,'🥃',0,0,1,'2026-03-07 22:52:15','2026-03-11 10:22:27');
INSERT INTO `product` VALUES (46,7,6,'供春壶','树瘿壶·供春','仿供春树瘿壶，宜兴紫砂，造型古朴自然，如树瘤天成。容量200ml，艺术收藏级。','供春壶造型古朴自然，如树瘤天成，艺术收藏级，适合冲泡普洱茶、黑茶。','2022','全手工制作','宜兴','江苏·无锡','标准款 200ml',1280.00,1680.00,8,12,4.9,'🫖',1,1,1,'2026-03-07 22:52:15','2026-03-11 10:22:27');
INSERT INTO `product` VALUES (47,7,6,'影青杯','景德镇·影青釉','景德镇影青釉茶杯，胎薄釉润，光影下呈现青白色。容量70ml，简约雅致。','影青杯胎薄釉润，光影下呈现青白色，简约雅致，适合品饮绿茶、白茶。','2024','影青釉工艺','景德镇','江西·景德镇','单杯 70ml',260.00,360.00,55,72,4.5,'🥃',0,0,1,'2026-03-07 22:52:15','2026-03-11 10:22:27');
INSERT INTO `product` VALUES (48,7,6,'紫砂石瓢','紫泥·石瓢壶','经典石瓢壶型，宜兴原矿紫泥，容量180ml。壶身三角造型，稳重端庄。','石瓢壶造型稳重端庄，三角造型经典，适合冲泡乌龙茶、普洱茶。','2023','全手工制作','宜兴','江苏·无锡','标准款 180ml',720.00,920.00,25,31,4.7,'🫖',1,0,1,'2026-03-07 22:52:15','2026-10-24 12:00:00');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_image`
--

DROP TABLE IF EXISTS `product_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_image` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '图片ID',
  `product_id` bigint NOT NULL COMMENT '商品ID',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图片URL',
  `sort_order` int DEFAULT '0' COMMENT '排序',
  `is_main` tinyint(1) DEFAULT '0' COMMENT '是否主图',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_product_id` (`product_id`) USING BTREE,
  CONSTRAINT `fk_product_image_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='商品图片表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_image`
--

LOCK TABLES `product_image` WRITE;
/*!40000 ALTER TABLE `product_image` DISABLE KEYS */;
INSERT INTO `product_image` VALUES (61,1,'https://example.com/products/longjing1.jpg',1,1,'2026-03-05 21:58:08');
INSERT INTO `product_image` VALUES (62,1,'https://example.com/products/longjing2.jpg',2,0,'2026-03-05 21:58:08');
INSERT INTO `product_image` VALUES (63,1,'https://example.com/products/longjing3.jpg',3,0,'2026-03-05 21:58:08');
INSERT INTO `product_image` VALUES (64,2,'https://example.com/products/gounao1.jpg',1,1,'2026-03-05 21:58:08');
INSERT INTO `product_image` VALUES (65,2,'https://example.com/products/gounao2.jpg',2,0,'2026-03-05 21:58:08');
INSERT INTO `product_image` VALUES (66,3,'https://example.com/products/jinggang1.jpg',1,1,'2026-03-05 21:58:08');
INSERT INTO `product_image` VALUES (67,3,'https://example.com/products/jinggang2.jpg',2,0,'2026-03-05 21:58:08');
INSERT INTO `product_image` VALUES (68,4,'https://example.com/products/wugong1.jpg',1,1,'2026-03-05 21:58:08');
INSERT INTO `product_image` VALUES (69,5,'https://example.com/products/qimen1.jpg',1,1,'2026-03-05 21:58:08');
INSERT INTO `product_image` VALUES (70,5,'https://example.com/products/qimen2.jpg',2,0,'2026-03-05 21:58:08');
INSERT INTO `product_image` VALUES (71,6,'https://example.com/products/lapsang1.jpg',1,1,'2026-03-05 21:58:08');
INSERT INTO `product_image` VALUES (72,7,'https://example.com/products/jinjunmei1.jpg',1,1,'2026-03-05 21:58:08');
INSERT INTO `product_image` VALUES (73,7,'https://example.com/products/jinjunmei2.jpg',2,0,'2026-03-05 21:58:08');
INSERT INTO `product_image` VALUES (74,8,'https://example.com/products/dahongpao1.jpg',1,1,'2026-03-05 21:58:08');
INSERT INTO `product_image` VALUES (75,9,'https://example.com/products/tieguanyin1.jpg',1,1,'2026-03-05 21:58:08');
INSERT INTO `product_image` VALUES (76,9,'https://example.com/products/tieguanyin2.jpg',2,0,'2026-03-05 21:58:08');
INSERT INTO `product_image` VALUES (77,10,'https://example.com/products/rougui1.jpg',1,1,'2026-03-05 21:58:08');
INSERT INTO `product_image` VALUES (78,11,'https://example.com/products/baihaoyinzhen1.jpg',1,1,'2026-03-05 21:58:08');
INSERT INTO `product_image` VALUES (79,12,'https://example.com/products/baimudan1.jpg',1,1,'2026-03-05 21:58:08');
INSERT INTO `product_image` VALUES (80,13,'https://example.com/products/puer1.jpg',1,1,'2026-03-05 21:58:08');
INSERT INTO `product_image` VALUES (81,37,'https://example.com/teaware/zhuni1.jpg',1,1,'2026-03-07 22:53:52');
INSERT INTO `product_image` VALUES (82,37,'https://example.com/teaware/zhuni2.jpg',2,0,'2026-03-07 22:53:52');
INSERT INTO `product_image` VALUES (83,38,'https://example.com/teaware/youdi1.jpg',1,1,'2026-03-07 22:53:52');
INSERT INTO `product_image` VALUES (84,38,'https://example.com/teaware/youdi2.jpg',2,0,'2026-03-07 22:53:52');
INSERT INTO `product_image` VALUES (85,39,'https://example.com/teaware/qinghua1.jpg',1,1,'2026-03-07 22:53:52');
INSERT INTO `product_image` VALUES (86,40,'https://example.com/teaware/xishi1.jpg',1,1,'2026-03-07 22:53:52');
INSERT INTO `product_image` VALUES (87,40,'https://example.com/teaware/xishi2.jpg',2,0,'2026-03-07 22:53:52');
INSERT INTO `product_image` VALUES (88,41,'https://example.com/teaware/tuhao1.jpg',1,1,'2026-03-07 22:53:52');
INSERT INTO `product_image` VALUES (89,42,'https://example.com/teaware/ruyao1.jpg',1,1,'2026-03-07 22:53:52');
INSERT INTO `product_image` VALUES (90,43,'https://example.com/teaware/handuo1.jpg',1,1,'2026-03-07 22:53:52');
INSERT INTO `product_image` VALUES (91,44,'https://example.com/teaware/daimao1.jpg',1,1,'2026-03-07 22:53:52');
INSERT INTO `product_image` VALUES (92,45,'https://example.com/teaware/dehua1.jpg',1,1,'2026-03-07 22:53:52');
INSERT INTO `product_image` VALUES (93,46,'https://example.com/teaware/gongchun1.jpg',1,1,'2026-03-07 22:53:52');
INSERT INTO `product_image` VALUES (94,46,'https://example.com/teaware/gongchun2.jpg',2,0,'2026-03-07 22:53:52');
INSERT INTO `product_image` VALUES (95,47,'https://example.com/teaware/yingqing1.jpg',1,1,'2026-03-07 22:53:52');
INSERT INTO `product_image` VALUES (96,48,'https://example.com/teaware/shipiao1.jpg',1,1,'2026-03-07 22:53:52');
/*!40000 ALTER TABLE `product_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_review`
--

DROP TABLE IF EXISTS `product_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_review` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `order_item_id` bigint NOT NULL COMMENT '订单项ID（评价到具体商品）',
  `product_id` bigint NOT NULL COMMENT '商品ID',
  `user_id` bigint NOT NULL COMMENT '评价用户',
  `rating` tinyint NOT NULL DEFAULT '5' COMMENT '评分 1-5',
  `content` varchar(1000) DEFAULT NULL COMMENT '评价内容',
  `images` json DEFAULT NULL COMMENT '图片URL数组',
  `is_anonymous` tinyint(1) DEFAULT '0' COMMENT '是否匿名',
  `status` varchar(20) NOT NULL DEFAULT 'pending' COMMENT 'pending待审/approved通过/rejected拒绝',
  `reply` varchar(500) DEFAULT NULL COMMENT '商家回复',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_order_item` (`order_item_id`) COMMENT '一个订单项只能评价一次',
  KEY `idx_product` (`product_id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_status` (`status`),
  KEY `fk_review_order` (`order_id`),
  CONSTRAINT `fk_review_item` FOREIGN KEY (`order_item_id`) REFERENCES `order_item` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_review_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='商品评价表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_review`
--

LOCK TABLES `product_review` WRITE;
/*!40000 ALTER TABLE `product_review` DISABLE KEYS */;
INSERT INTO `product_review` VALUES (14,56,55,14,11,4,'汤色清亮，回甘明显（自动化验证）',NULL,0,'approved',NULL,'2026-10-23 20:38:16','2026-10-24 16:43:15');
INSERT INTO `product_review` VALUES (15,60,58,58,11,5,'好好好',NULL,0,'approved',NULL,'2026-10-24 17:02:01','2026-10-24 17:02:23');
/*!40000 ALTER TABLE `product_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_spec`
--

DROP TABLE IF EXISTS `product_spec`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_spec` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '规格ID',
  `product_id` bigint NOT NULL COMMENT '商品ID',
  `spec_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '规格名称（包含名称和描述，如：品鉴装 50g）',
  `price` decimal(10,2) NOT NULL COMMENT '规格价格',
  `original_price` decimal(10,2) DEFAULT NULL COMMENT '规格原价',
  `stock` int DEFAULT '0' COMMENT '规格库存',
  `sales` int DEFAULT '0' COMMENT '规格销量',
  `is_default` tinyint(1) DEFAULT '0' COMMENT '是否默认规格',
  `sort_order` int DEFAULT '0' COMMENT '排序',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_product_id` (`product_id`) USING BTREE,
  CONSTRAINT `fk_product_spec_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='商品规格表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_spec`
--

LOCK TABLES `product_spec` WRITE;
/*!40000 ALTER TABLE `product_spec` DISABLE KEYS */;
INSERT INTO `product_spec` VALUES (1,1,'品鉴装 50g',108.00,158.00,49,78,0,1,'2026-03-10 09:03:57','2026-10-23 21:16:11');
INSERT INTO `product_spec` VALUES (2,1,'标准装 100g',198.00,298.00,100,234,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (3,1,'礼盒装 200g',368.00,498.00,30,56,0,3,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (4,2,'品鉴装 50g',88.00,128.00,40,65,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (5,2,'标准装 150g',168.00,228.00,80,189,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (6,2,'家庭装 300g',298.00,398.00,25,43,0,3,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (7,3,'标准装 200g',228.00,328.00,60,143,1,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (8,3,'礼盒装 400g',428.00,598.00,20,35,0,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (9,4,'品鉴装 50g',98.00,138.00,30,45,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (10,4,'标准装 100g',188.00,258.00,50,112,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (11,5,'品鉴装 50g',98.00,138.00,40,56,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (12,5,'标准装 150g',268.00,368.00,70,87,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (13,5,'礼盒装 300g',498.00,698.00,20,23,0,3,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (14,6,'标准装 100g',358.00,458.00,50,0,1,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (15,6,'礼盒装 200g',680.00,880.00,15,0,0,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (16,7,'品鉴装 50g',108.00,158.00,45,56,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (17,7,'标准装 100g',198.00,298.00,90,112,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (18,7,'家庭装 250g',458.00,598.00,25,34,0,3,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (19,8,'品鉴装 25g',218.00,298.00,30,28,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (20,8,'标准装 50g',398.00,598.00,40,45,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (21,9,'品鉴装 50g',198.00,258.00,35,42,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (22,9,'标准装 100g',358.00,458.00,55,78,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (23,9,'礼盒装 200g',680.00,880.00,18,23,0,3,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (24,10,'品鉴装 50g',68.00,98.00,60,89,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (25,10,'标准装 250g',228.00,328.00,85,156,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (26,10,'家庭装 500g',428.00,598.00,30,45,0,3,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (27,11,'标准装 100g',298.00,398.00,45,67,1,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (28,11,'礼盒装 200g',568.00,768.00,15,21,0,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (29,12,'品鉴装 50g',178.00,238.00,25,28,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (30,12,'标准装 100g',328.00,428.00,40,34,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (31,13,'品鉴装 50g',68.00,98.00,50,67,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (32,13,'标准装 150g',188.00,268.00,70,89,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (33,13,'家庭装 300g',358.00,498.00,25,34,0,3,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (34,14,'品鉴装 100g',98.00,138.00,40,45,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (35,14,'标准装 357g',268.00,368.00,60,56,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (36,14,'收藏装 1000g',680.00,880.00,15,12,0,3,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (37,15,'标准装 500g',218.00,298.00,25,18,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (38,15,'收藏装 1000g',398.00,498.00,30,23,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (39,16,'品鉴装 50g',138.00,178.00,30,21,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (40,16,'标准装 100g',258.00,328.00,45,32,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (41,17,'品鉴装 50g',148.00,198.00,40,67,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (42,17,'标准装 100g',268.00,368.00,75,189,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (43,17,'礼盒装 200g',498.00,698.00,25,34,0,3,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (44,18,'品鉴装 50g',68.00,98.00,60,89,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (45,18,'标准装 150g',188.00,258.00,120,234,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (46,18,'家庭装 300g',358.00,498.00,35,56,0,3,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (47,19,'品鉴装 50g',128.00,168.00,30,34,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (48,19,'标准装 100g',228.00,328.00,60,98,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (49,20,'品鉴装 50g',68.00,98.00,45,67,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (50,20,'标准装 150g',198.00,268.00,85,143,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (51,20,'家庭装 300g',378.00,498.00,25,34,0,3,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (52,21,'品鉴装 50g',58.00,88.00,45,56,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (53,21,'标准装 100g',158.00,228.00,90,112,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (54,22,'品鉴装 50g',178.00,238.00,25,34,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (55,22,'标准装 100g',328.00,428.00,45,67,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (56,22,'礼盒装 200g',628.00,828.00,15,21,0,3,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (57,23,'品鉴装 50g',88.00,128.00,35,45,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (58,23,'标准装 150g',258.00,358.00,55,78,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (59,24,'品鉴装 30g',168.00,218.00,20,23,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (60,24,'标准装 75g',398.00,498.00,30,45,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (61,25,'品鉴装 50g',98.00,138.00,35,28,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (62,25,'标准装 100g',188.00,258.00,65,56,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (63,26,'品鉴装 50g',118.00,158.00,30,21,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (64,26,'标准装 100g',208.00,288.00,50,43,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (65,27,'品鉴装 50g',38.00,58.00,60,78,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (66,27,'标准装 200g',128.00,188.00,100,156,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (67,27,'家庭装 500g',298.00,398.00,35,45,0,3,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (68,28,'标准装 300g',198.00,298.00,70,89,1,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (69,28,'收藏装 600g',378.00,498.00,25,23,0,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (70,29,'品鉴装 50g',38.00,68.00,60,78,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (71,29,'标准装 100g',98.00,158.00,120,134,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (72,30,'品鉴装 100g',148.00,198.00,30,34,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (73,30,'标准装 200g',268.00,368.00,55,67,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (74,31,'标准装 500g',158.00,228.00,80,54,1,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (75,31,'收藏装 1000g',298.00,398.00,30,21,0,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (76,32,'标准装 300g',188.00,258.00,65,43,1,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (77,32,'收藏装 600g',358.00,458.00,20,15,0,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (78,33,'标准装 500g',168.00,228.00,25,18,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (79,33,'收藏装 1000g',298.00,398.00,40,32,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (80,34,'品鉴装 25g',198.00,258.00,20,23,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (81,34,'标准装 50g',358.00,458.00,35,42,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (82,35,'品鉴装 50g',158.00,198.00,25,18,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (83,35,'标准装 100g',288.00,368.00,45,36,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (84,36,'品鉴装 50g',128.00,168.00,25,15,0,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (85,36,'标准装 100g',238.00,318.00,40,28,1,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (86,37,'标准款 150ml',680.00,880.00,30,45,1,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (87,37,'珍藏款 150ml 名家款',1280.00,1680.00,5,8,0,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (88,38,'标准款 9cm',580.00,780.00,25,38,1,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (89,38,'珍藏款 9cm 精品',980.00,1280.00,8,12,0,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (90,39,'单杯 50ml',280.00,380.00,50,67,1,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (91,39,'对杯 50ml×2',520.00,720.00,30,34,0,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (92,39,'套组 4杯套装',980.00,1280.00,15,21,0,3,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (93,40,'标准款 200ml',880.00,1080.00,20,32,1,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (94,40,'珍藏款 200ml 名家款',1680.00,2080.00,5,6,0,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (95,41,'标准款 8.5cm',620.00,820.00,22,29,1,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (96,41,'珍藏款 8.5cm 精品',1080.00,1380.00,6,8,0,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (97,42,'单杯 60ml',380.00,480.00,40,53,1,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (98,42,'对杯 60ml×2',720.00,920.00,25,28,0,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (99,42,'套组 4杯套装',1380.00,1680.00,10,12,0,3,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (100,43,'标准款 220ml',780.00,980.00,18,24,1,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (101,43,'珍藏款 220ml 名家款',1480.00,1880.00,4,5,0,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (102,44,'标准款 9cm',980.00,1280.00,10,15,1,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (103,44,'珍藏款 9cm 精品',1680.00,2080.00,3,4,0,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (104,45,'单杯 80ml',320.00,420.00,45,58,1,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (105,45,'对杯 80ml×2',600.00,800.00,30,32,0,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (106,45,'套组 6杯套装',1680.00,2080.00,12,15,0,3,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (107,46,'标准款 200ml',1280.00,1680.00,8,12,1,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (108,46,'珍藏款 200ml 名家款',2280.00,2880.00,2,3,0,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (109,47,'单杯 70ml',260.00,360.00,55,72,1,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (110,47,'对杯 70ml×2',500.00,680.00,35,38,0,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (111,47,'套组 6杯套装',1380.00,1680.00,15,18,0,3,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (112,48,'标准款 180ml',720.00,920.00,25,31,1,1,'2026-03-10 09:03:57','2026-03-10 09:03:57');
INSERT INTO `product_spec` VALUES (113,48,'珍藏款 180ml 名家款',1380.00,1780.00,6,7,0,2,'2026-03-10 09:03:57','2026-03-10 09:03:57');
/*!40000 ALTER TABLE `product_spec` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop`
--

DROP TABLE IF EXISTS `shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shop` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '店铺ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '店铺名称',
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '店铺LOGO',
  `logo_emoji` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '?' COMMENT 'LOGO表情',
  `badge` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '店铺标签 官方/精选/旗舰店等',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '店铺描述',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '店铺地址',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '联系电话',
  `business_hours` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '营业时间',
  `rating` decimal(2,1) DEFAULT '5.0' COMMENT '店铺评分',
  `sales_count` int DEFAULT '0' COMMENT '累计销量',
  `product_count` int DEFAULT '0' COMMENT '商品数量',
  `fans_count` int DEFAULT '0' COMMENT '粉丝数',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态 0-关闭 1-营业中',
  `sort_order` int DEFAULT '0' COMMENT '排序',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_rating` (`rating`) USING BTREE,
  KEY `idx_sort_order` (`sort_order`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='店铺表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop`
--

LOCK TABLES `shop` WRITE;
/*!40000 ALTER TABLE `shop` DISABLE KEYS */;
INSERT INTO `shop` VALUES (1,'漫思茶·官方旗舰店',NULL,'🏪','官方','漫思茶官方直营店，保证正品，品质保证','浙江省杭州市西湖区龙井路88号','400-888-1234','09:00 - 22:00',4.9,12500,5,35800,1,1,'2026-03-09 19:45:27','2026-03-11 21:39:41');
INSERT INTO `shop` VALUES (2,'井冈山·茶文化馆',NULL,'🏯','精选','专注井冈山地区茶叶，传承红色茶文化','江西省吉安市井冈山市茨坪镇天街8号','400-888-1235','09:00 - 21:00',4.8,8900,3,15600,1,2,'2026-03-09 19:45:27','2026-03-11 21:39:42');
INSERT INTO `shop` VALUES (3,'武夷岩茶·专营店',NULL,'⛰️','旗舰店','武夷山核心产区，正宗岩茶','福建省南平市武夷山市三姑度假区大王峰路18号','400-888-1236','09:30 - 21:30',4.9,15600,5,28900,1,3,'2026-03-09 19:45:27','2026-03-11 21:39:42');
INSERT INTO `shop` VALUES (4,'福鼎白茶·官方店',NULL,'🌱','官方','福鼎白茶原产地，传统工艺','福建省宁德市福鼎市太姥山镇玉池路66号','400-888-1237','09:00 - 20:30',4.8,7800,5,12300,1,4,'2026-03-09 19:45:27','2026-03-11 21:39:42');
INSERT INTO `shop` VALUES (5,'普洱人家·专营店',NULL,'🍂','精选','云南普洱茶，越陈越香','云南省西双版纳傣族自治州勐海县勐海镇茶乡路188号','400-888-1238','09:00 - 22:00',4.7,11200,2,18700,1,5,'2026-03-09 19:45:27','2026-03-11 21:39:42');
INSERT INTO `shop` VALUES (6,'景德镇茶具·旗舰店',NULL,'🏺','官方','景德镇陶瓷，匠心工艺','江西省景德镇市珠山区陶阳南路陶瓷城A区18号','400-888-1239','09:30 - 21:30',4.9,23500,12,42600,1,6,'2026-03-09 19:45:27','2026-03-11 21:39:42');
INSERT INTO `shop` VALUES (7,'西湖龙井·原产地',NULL,'🍃','官方','西湖产区，明前龙井','浙江省杭州市西湖区龙井村168号','400-888-1240','08:30 - 21:00',4.8,9800,1,14500,1,7,'2026-03-09 19:45:27','2026-03-11 21:39:42');
INSERT INTO `shop` VALUES (8,'黄山毛峰·专卖店',NULL,'⛰️','精选','黄山云雾茶，高山品质','安徽省黄山市黄山风景区汤口镇茶缘街28号','400-888-1241','09:00 - 20:00',4.7,5600,2,8900,1,8,'2026-03-09 19:45:27','2026-03-11 21:39:42');
INSERT INTO `shop` VALUES (9,'安溪铁观音·专营',NULL,'🌿','旗舰店','安溪原产地，传统工艺','福建省泉州市安溪县感德镇茶王街88号','400-888-1242','09:00 - 22:00',4.8,13400,2,21200,1,9,'2026-03-09 19:45:27','2026-03-11 21:39:42');
INSERT INTO `shop` VALUES (10,'宜兴紫砂·名家店',NULL,'🫖','精选','宜兴原矿紫砂，名家作品','江苏省无锡市宜兴市丁蜀镇紫砂路126号','400-888-1243','09:30 - 21:00',4.9,8900,0,32400,1,10,'2026-03-09 19:45:27','2026-03-11 21:39:42');
INSERT INTO `shop` VALUES (11,'洞庭碧螺春·专卖',NULL,'🌱','官方','洞庭山原产地，正宗碧螺春','江苏省苏州市吴中区东山镇碧螺村66号','400-888-1244','08:30 - 20:30',4.8,7200,1,11200,1,11,'2026-03-09 19:45:27','2026-03-11 21:39:42');
INSERT INTO `shop` VALUES (12,'台湾乌龙·体验店',NULL,'🍵','精选','台湾高山乌龙，冻顶乌龙','台湾省南投县鹿谷乡冻顶巷188号','400-888-1245','10:00 - 21:00',4.7,4300,2,6700,1,12,'2026-03-09 19:45:27','2026-03-11 21:39:42');
INSERT INTO `shop` VALUES (13,'广东单丛·老字号',NULL,'🏯','老字号','潮州凤凰单丛，百年传承','广东省潮州市潮安区凤凰镇乌岽村88号','400-888-1246','09:00 - 21:30',4.8,8900,1,14300,1,13,'2026-03-09 19:45:27','2026-03-11 21:39:42');
INSERT INTO `shop` VALUES (14,'云南滇红·专卖店',NULL,'🍂','精选','凤庆滇红，大叶种红茶','云南省临沧市凤庆县凤山镇滇红路66号','400-888-1247','09:00 - 22:00',4.7,5600,2,7800,1,14,'2026-03-09 19:45:27','2026-03-11 21:39:42');
INSERT INTO `shop` VALUES (15,'安化黑茶·体验馆',NULL,'🏺','精选','安化黑茶，金花茯砖','湖南省益阳市安化县东坪镇黑茶街188号','400-888-1248','09:00 - 20:30',4.6,3400,4,4500,1,15,'2026-03-09 19:45:27','2026-03-11 21:39:42');
/*!40000 ALTER TABLE `shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_theme`
--

DROP TABLE IF EXISTS `shop_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shop_theme` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '关联ID',
  `shop_id` int NOT NULL COMMENT '店铺ID',
  `theme_id` int NOT NULL COMMENT '主题ID',
  `sort_order` int DEFAULT '0' COMMENT '排序',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `spec_id` bigint DEFAULT NULL COMMENT ' 规格ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_shop_theme` (`shop_id`,`theme_id`) USING BTREE,
  KEY `idx_shop_id` (`shop_id`) USING BTREE,
  KEY `idx_theme_id` (`theme_id`) USING BTREE,
  CONSTRAINT `fk_shop_theme_shop` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_shop_theme_theme` FOREIGN KEY (`theme_id`) REFERENCES `theme` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='店铺主题关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_theme`
--

LOCK TABLES `shop_theme` WRITE;
/*!40000 ALTER TABLE `shop_theme` DISABLE KEYS */;
INSERT INTO `shop_theme` VALUES (1,7,1,1,'2026-03-09 19:46:52',17);
INSERT INTO `shop_theme` VALUES (2,11,1,2,'2026-03-09 19:46:52',27);
INSERT INTO `shop_theme` VALUES (3,8,1,3,'2026-03-09 19:46:52',19);
INSERT INTO `shop_theme` VALUES (4,1,1,4,'2026-03-09 19:46:52',2);
INSERT INTO `shop_theme` VALUES (5,2,2,1,'2026-03-09 19:46:52',5);
INSERT INTO `shop_theme` VALUES (6,3,2,2,'2026-03-09 19:46:52',7);
INSERT INTO `shop_theme` VALUES (7,12,2,3,'2026-03-09 19:46:52',30);
INSERT INTO `shop_theme` VALUES (8,14,2,4,'2026-03-09 19:46:52',34);
INSERT INTO `shop_theme` VALUES (9,3,3,1,'2026-03-09 19:46:52',8);
INSERT INTO `shop_theme` VALUES (10,5,3,2,'2026-03-09 19:46:52',12);
INSERT INTO `shop_theme` VALUES (11,15,3,3,'2026-03-09 19:46:52',37);
INSERT INTO `shop_theme` VALUES (12,13,3,4,'2026-03-09 19:46:52',32);
INSERT INTO `shop_theme` VALUES (13,7,4,1,'2026-03-09 19:46:52',18);
INSERT INTO `shop_theme` VALUES (14,4,4,2,'2026-03-09 19:46:52',10);
INSERT INTO `shop_theme` VALUES (15,12,4,3,'2026-03-09 19:46:52',29);
INSERT INTO `shop_theme` VALUES (16,5,4,4,'2026-03-09 19:46:52',11);
INSERT INTO `shop_theme` VALUES (17,15,4,5,'2026-03-09 19:46:52',38);
INSERT INTO `shop_theme` VALUES (18,9,5,1,'2026-03-09 19:46:52',23);
INSERT INTO `shop_theme` VALUES (19,4,5,2,'2026-03-09 19:46:52',9);
INSERT INTO `shop_theme` VALUES (20,1,5,3,'2026-03-09 19:46:52',1);
INSERT INTO `shop_theme` VALUES (21,15,5,4,'2026-03-09 19:46:52',NULL);
INSERT INTO `shop_theme` VALUES (22,9,6,1,'2026-03-09 19:46:52',NULL);
INSERT INTO `shop_theme` VALUES (23,13,6,2,'2026-03-09 19:46:52',NULL);
INSERT INTO `shop_theme` VALUES (24,12,6,3,'2026-03-09 19:46:52',NULL);
INSERT INTO `shop_theme` VALUES (25,4,6,4,'2026-03-09 19:46:52',NULL);
INSERT INTO `shop_theme` VALUES (26,1,6,5,'2026-03-09 19:46:52',NULL);
INSERT INTO `shop_theme` VALUES (27,1,7,1,'2026-03-09 19:46:52',NULL);
INSERT INTO `shop_theme` VALUES (28,3,7,2,'2026-03-09 19:46:52',NULL);
INSERT INTO `shop_theme` VALUES (29,12,7,3,'2026-03-09 19:46:52',NULL);
INSERT INTO `shop_theme` VALUES (30,5,7,4,'2026-03-09 19:46:52',NULL);
INSERT INTO `shop_theme` VALUES (31,7,7,5,'2026-03-09 19:46:52',NULL);
INSERT INTO `shop_theme` VALUES (32,11,7,6,'2026-03-09 19:46:52',NULL);
INSERT INTO `shop_theme` VALUES (33,4,7,7,'2026-03-09 19:46:52',NULL);
INSERT INTO `shop_theme` VALUES (34,6,7,8,'2026-03-09 19:46:52',NULL);
/*!40000 ALTER TABLE `shop_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teaware`
--

DROP TABLE IF EXISTS `teaware`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teaware` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '茶具ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '茶具名称',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '描述',
  `emoji` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '?' COMMENT '表情',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '图片URL',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '分类 紫砂壶/建盏/品茗杯',
  `acquire_date` date DEFAULT NULL COMMENT '获得日期',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  CONSTRAINT `fk_teaware_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='茶具表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teaware`
--

LOCK TABLES `teaware` WRITE;
/*!40000 ALTER TABLE `teaware` DISABLE KEYS */;
INSERT INTO `teaware` VALUES (1,1,'朱泥小壶','宜兴朱泥 150ml','🫖',NULL,'紫砂壶','2024-01-15','2024-01-15 10:30:00','2026-03-05 16:56:39');
INSERT INTO `teaware` VALUES (2,1,'油滴建盏','宋代风格 束口盏','🏺',NULL,'建盏','2024-02-20','2024-02-20 14:20:00','2026-03-05 16:56:39');
INSERT INTO `teaware` VALUES (3,2,'青花品茗杯','景德镇手绘 50ml','🥃',NULL,'品茗杯','2024-01-10','2024-01-10 09:15:00','2026-03-05 16:56:39');
INSERT INTO `teaware` VALUES (4,2,'紫砂西施','原矿紫泥 200ml','🫖',NULL,'紫砂壶','2023-12-05','2023-12-05 16:30:00','2026-03-05 16:56:39');
INSERT INTO `teaware` VALUES (5,3,'兔毫建盏','宋代风格 敛口盏','🏺',NULL,'建盏','2024-02-01','2024-02-01 11:45:00','2026-03-05 16:56:39');
INSERT INTO `teaware` VALUES (6,3,'汝窑茶杯','天青色 60ml','🥃',NULL,'品茗杯','2023-11-20','2023-11-20 13:20:00','2026-03-05 16:56:39');
INSERT INTO `teaware` VALUES (7,4,'石瓢壶','紫泥调砂 180ml','🫖',NULL,'紫砂壶','2024-01-25','2024-01-25 15:10:00','2026-03-05 16:56:39');
INSERT INTO `teaware` VALUES (8,4,'影青杯','景德镇 薄胎','🥃',NULL,'品茗杯','2024-02-10','2024-02-10 10:40:00','2026-03-05 16:56:39');
INSERT INTO `teaware` VALUES (9,5,'供春壶','树瘿壶 200ml','🫖',NULL,'紫砂壶','2023-12-15','2023-12-15 14:50:00','2026-03-05 16:56:39');
INSERT INTO `teaware` VALUES (10,5,'玳瑁建盏','七彩曜变','🏺',NULL,'建盏','2024-01-30','2024-01-30 09:30:00','2026-03-05 16:56:39');
INSERT INTO `teaware` VALUES (11,6,'德化白瓷','羊脂玉 80ml','🥃',NULL,'品茗杯','2024-02-05','2024-02-05 16:15:00','2026-03-05 16:56:39');
INSERT INTO `teaware` VALUES (12,7,'汉铎壶','紫泥 220ml','🫖',NULL,'紫砂壶','2023-11-10','2023-11-10 11:20:00','2026-03-05 16:56:39');
INSERT INTO `teaware` VALUES (14,11,'油滴建盏','宋代风格 束口盏','🏺',NULL,'建盏','2026-03-05','2026-03-16 11:02:44','2026-03-16 11:02:44');
/*!40000 ALTER TABLE `teaware` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `theme`
--

DROP TABLE IF EXISTS `theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `theme` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主题ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主题名称',
  `subtitle` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '主题副标题',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '主题介绍',
  `cover_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '主题封面图',
  `cover_emoji` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '主题封面表情',
  `product_count` int DEFAULT '0' COMMENT '包含商品数量',
  `tea_types` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '包含茶叶类型(如:绿茶,红茶,乌龙茶)',
  `min_price` decimal(10,2) DEFAULT NULL COMMENT '最低价格',
  `max_price` decimal(10,2) DEFAULT NULL COMMENT '最高价格',
  `view_count` int DEFAULT '0' COMMENT '浏览次数',
  `like_count` int DEFAULT '0' COMMENT '点赞次数',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态 0-隐藏 1-显示',
  `sort_order` int DEFAULT '0' COMMENT '排序',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `rating` decimal(10,1) DEFAULT NULL COMMENT '评分',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_sort_order` (`sort_order`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='茶文化主题表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `theme`
--

LOCK TABLES `theme` WRITE;
/*!40000 ALTER TABLE `theme` DISABLE KEYS */;
INSERT INTO `theme` VALUES (1,'江南春晓','品味江南文人的诗意生活','江南自古文风鼎盛，茶文化与诗词书画相得益彰。本主题精选江南四大名茶，融合绿茶、红茶、黄茶三种类型，再现文人雅士品茶论道的情怀。从太湖烟雨中的碧螺春，到黄山云雾间的毛峰，从洞庭湖畔的君山银针，到徽商雅韵中的祁门红茶，每一杯都是一首江南诗。','/static/login_back.png','🏯',6,'绿茶,红茶,黄茶',188.00,358.00,0,0,1,1,'2026-03-05 21:10:28','2026-03-08 14:55:30',4.9);
INSERT INTO `theme` VALUES (2,'高山流水','寻访高山云雾间的隐士情怀','高山云雾出好茶，隐士们择高山而居，与茶为伴。本主题精选五款高山茶，融合乌龙茶、白茶、绿茶、红茶四种类型，展现高山的清幽与隐士的超然。从海拔千米的武功山云雾，到武夷山的岩骨花香，从台湾冻顶的清香，到云南高原的滇红工夫，每一杯都承载着山野的气息。','/static/login_back.png','⛰️',7,'乌龙茶,白茶,绿茶,红茶',128.00,358.00,0,0,1,2,'2026-03-05 21:10:28','2026-03-08 14:55:52',4.6);
INSERT INTO `theme` VALUES (3,'丝路茶香','重走茶马古道的千年传奇','茶马古道和丝绸之路将中国茶传播到世界各地。本主题精选五款历史上曾远销海外的名茶，融合红茶、黑茶、乌龙茶、绿茶四种类型，再现万里茶道的辉煌。从正山小种的英伦风情，到六堡茶的南洋记忆，从安化黑茶的边疆故事，到凤凰单丛的潮汕工夫，每一杯都是一段历史。','/static/login_back.png','🐫',8,'红茶,黑茶,乌龙茶,绿茶',198.00,398.00,0,0,1,3,'2026-03-05 21:10:28','2026-03-08 14:55:59',4.7);
INSERT INTO `theme` VALUES (4,'四季流转','顺应天时的养生茶道','中国人讲究“不时不食”，饮茶也顺应节气变化。本主题精选八款茶，融合绿茶、红茶、乌龙茶、白茶、黑茶、黄茶六种类型，对应春夏秋冬四季，体验节气与茶的和谐。从清明前的明前龙井，到立夏的东方美人，从白露的铁观音，到大雪的茯砖茶，每一杯都蕴含着节气的智慧。','/static/login_back.png','🌸',11,'绿茶,红茶,乌龙茶,白茶,黑茶,黄茶',198.00,398.00,0,0,1,4,'2026-03-05 21:10:28','2026-03-08 14:56:05',3.9);
INSERT INTO `theme` VALUES (5,'茶禅一味','在茶汤中寻找内心的宁静','茶与禅的结合，是中国茶文化的最高境界。本主题精选六款茶，融合乌龙茶、白茶、黄茶、黑茶四种类型，每款茶都蕴含着禅宗的智慧与修行者的心境。从佛手拈花的永春佛手，到岁月沉淀的寿眉老茶，从蒙顶山上的黄芽，到康藏高原的康砖茶，每一杯都是一次心灵的修行。','/static/login_back.png','🧘',9,'乌龙茶,白茶,黄茶,黑茶',98.00,288.00,0,0,1,5,'2026-03-05 21:10:28','2026-03-08 14:56:11',4.2);
INSERT INTO `theme` VALUES (6,'花间茶语','品味花与茶的浪漫邂逅','花与茶，自古以来就是绝配。本主题精选七款带有天然花香的茶，融合乌龙茶、红茶、绿茶、白茶四种类型，品味花间茶语的诗意生活。从铁观音的兰花香，到凤凰单丛的蜜兰香，从东方美人的蜜香，到白牡丹的花香，每一杯都是一首花间词。','/static/login_back.png','🌸',9,'乌龙茶,红茶,绿茶,白茶',158.00,398.00,0,0,1,6,'2026-03-05 21:10:28','2026-03-08 14:56:19',4.5);
INSERT INTO `theme` VALUES (7,'茶和天下','一场跨越时空的茶文化之旅','中国茶走向世界，在每个地方都开出了独特的花朵。本主题精选八款具有代表性的中国茶，融合绿茶、红茶、乌龙茶、白茶、黑茶、黄茶六种类型，带您开启一场世界茶旅。从江南的碧螺春，到福建的大红袍，从台湾的冻顶乌龙，到云南的普洱茶，每一杯都是一个地域的文化符号。','/static/login_back.png','🌍',11,'绿茶,红茶,乌龙茶,白茶,黑茶,黄茶',198.00,358.00,0,0,1,7,'2026-03-05 21:10:28','2026-03-08 14:56:27',4.8);
/*!40000 ALTER TABLE `theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `theme_product`
--

DROP TABLE IF EXISTS `theme_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `theme_product` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '关联ID',
  `theme_id` int NOT NULL COMMENT '主题ID',
  `product_id` bigint NOT NULL COMMENT '商品ID',
  `sort_order` int DEFAULT '0' COMMENT '在主题中的排序',
  `recommend_note` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '推荐语',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_theme_product` (`theme_id`,`product_id`) USING BTREE,
  KEY `idx_theme_id` (`theme_id`) USING BTREE,
  KEY `idx_product_id` (`product_id`) USING BTREE,
  CONSTRAINT `fk_theme_product_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_theme_product_theme` FOREIGN KEY (`theme_id`) REFERENCES `theme` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='主题商品关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `theme_product`
--

LOCK TABLES `theme_product` WRITE;
/*!40000 ALTER TABLE `theme_product` DISABLE KEYS */;
INSERT INTO `theme_product` VALUES (1,1,17,1,'太湖烟雨中的江南春色，卷曲成螺的茶叶如同文人笔下的婉约词句','2026-03-05 21:10:37');
INSERT INTO `theme_product` VALUES (2,1,18,2,'黄山云雾滋养的灵芽，形似雀舌，清香高长，如同徽州文人的清雅风骨','2026-03-05 21:10:37');
INSERT INTO `theme_product` VALUES (3,1,34,3,'洞庭湖中的银针，芽头肥壮，金黄光亮，仿佛文人墨客笔下的明月','2026-03-05 21:10:37');
INSERT INTO `theme_product` VALUES (4,1,5,4,'徽商雅韵中的红茶皇后，似花似果似蜜的祁门香，如同徽州文化的醇厚底蕴','2026-03-05 21:10:37');
INSERT INTO `theme_product` VALUES (5,2,4,1,'海拔千米之上的云雾茶，山野韵味浓郁，如同隐士的超然物外','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (6,2,9,2,'武夷山的岩骨花香，七泡有余香，仿佛隐士的坚韧品格','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (7,2,23,3,'台湾冻顶的清香乌龙，半球形的茶叶如同山间的圆月','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (8,2,27,4,'高山白茶，一芽二三叶，香气清纯，如同隐士的质朴生活','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (9,2,20,5,'云南高原的红茶，条索肥硕，金毫显露，如同高原的壮丽景色','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (10,3,7,1,'世界红茶鼻祖，松烟香桂圆汤，承载着400年的海上丝路记忆','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (11,3,30,2,'南洋华人的乡愁之茶，祛湿养生，见证了华人下南洋的艰辛历程','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (12,3,15,3,'茶马古道的主角，茯砖金花茂盛，菌香明显，诉说着边疆的故事','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (13,3,22,4,'潮汕工夫茶代表，鸭屎香扬名海外，远销东南亚各国','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (14,3,19,5,'明清贡茶，单片叶制成，形似瓜子，曾是丝绸之路上的珍品','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (15,4,1,1,'清明前的绿茶皇后，鲜爽回甘，唤醒春天的味蕾','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (16,4,12,2,'谷雨前后的白茶珍品，毫香明显，清热解毒','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (17,4,24,3,'立夏时节的乌龙茶，天然蜜香，消暑解渴','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (18,4,16,4,'小暑前后的黄茶，黄叶黄汤，清热祛湿','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (19,4,10,5,'白露前后的乌龙茶，兰花香观音韵，润燥生津','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (20,4,8,6,'霜降时节的红茶，滋味甘甜，暖胃驱寒','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (21,4,14,7,'小雪前后的黑茶，陈香显著，消食解腻','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (22,4,33,8,'大雪时节的黑茶，金花茂盛，暖身驱寒','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (23,5,26,1,'佛手拈花，一笑拈茶，叶大如掌形似佛手，蕴含禅意','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (24,5,28,2,'岁月沉淀的老白茶，枣香明显，如同修行者的智慧积累','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (25,5,35,3,'蒙顶山上的黄芽，禅茶一味的发源地，品味千年禅意','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (26,5,32,4,'康藏高原的黑茶，茶佛一体，见证了藏传佛教的传播','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (27,5,25,5,'方寸之间的茶饼，自有天地，如同修行者的方寸之心','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (28,5,29,6,'破而后立的创新白茶，茶道新生，寓意修行者的破执','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (29,6,10,1,'兰花香明显，观音韵足，君子如兰，清雅高洁','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (30,6,22,2,'蜜兰香高扬，山韵独特，蜜香醉人，兰香清雅','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (31,6,24,3,'天然蜜香，五色茶白毫显著，美人如花，芳香四溢','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (32,6,13,4,'一芽一叶，花香明显，花中之王，雍容华贵','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (33,6,5,5,'似花似果似蜜，群芳之最，香气袭人','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (34,6,26,6,'香橼香明显，佛手香橼，禅意花香','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (35,6,21,7,'英红九号，花香馥郁，鲜纯爽口','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (36,7,7,1,'世界红茶鼻祖，风靡欧洲400年，开启世界茶旅第一站','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (37,7,5,2,'世界三大高香红茶之一，中国红茶的骄傲','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (38,7,9,3,'岩茶之王，享誉海内外，武夷山的名片','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (39,7,23,4,'台湾乌龙代表，风靡东南亚，宝岛茶香','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (40,7,14,5,'可喝的古董，收藏佳品，云南的瑰宝','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (41,7,34,6,'黄茶之冠，中国十大名茶，洞庭的骄傲','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (42,7,12,7,'白茶珍品，出口欧美，福鼎的荣耀','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (43,7,17,8,'中国十大名茶，享誉世界，江南的韵味','2026-03-05 21:11:18');
INSERT INTO `theme_product` VALUES (44,1,39,5,'景德镇手绘青花，胎薄如纸，青花发色淡雅，与江南文人的清雅相得益彰','2026-03-07 22:54:20');
INSERT INTO `theme_product` VALUES (45,1,47,6,'影青釉色如水如天，光影流转间尽显江南水乡的婉约韵味','2026-03-07 22:54:20');
INSERT INTO `theme_product` VALUES (46,2,46,6,'树瘿壶造型古朴自然，如山中老树天成，与隐士的超然物外相映成趣','2026-03-07 22:54:27');
INSERT INTO `theme_product` VALUES (47,2,41,7,'兔毫纹路如高山流水，银光闪烁间仿佛能听见山涧溪流之声','2026-03-07 22:54:27');
INSERT INTO `theme_product` VALUES (48,3,43,6,'壶身刻有茶诗，见证了茶马古道上文人墨客的足迹，承载着丝路的文化记忆','2026-03-07 22:54:33');
INSERT INTO `theme_product` VALUES (49,3,48,7,'石瓢壶型稳重端庄，如同丝路上的驼队，一步一个脚印，沉稳前行','2026-03-07 22:54:33');
INSERT INTO `theme_product` VALUES (50,3,44,8,'七彩曜变的建盏，如同丝绸之路上的多元文化交流，色彩斑斓，绚丽多彩','2026-03-07 22:54:33');
INSERT INTO `theme_product` VALUES (51,4,37,9,'朱泥温润，春茶配朱泥，更显茶汤鲜活，适合明前龙井等春茶的冲泡','2026-03-07 22:54:43');
INSERT INTO `theme_product` VALUES (52,4,42,10,'天青釉色如秋日晴空，开片自然如岁月痕迹，品味秋茶的醇厚','2026-03-07 22:54:43');
INSERT INTO `theme_product` VALUES (53,4,45,11,'羊脂玉般的白瓷，冬日暖阳下茶汤更显温润，适合冬茶的品饮','2026-03-07 22:54:43');
INSERT INTO `theme_product` VALUES (54,5,40,7,'西施壶圆润饱满，如佛家圆融无碍，一壶在手，心随茶静','2026-03-07 22:54:51');
INSERT INTO `theme_product` VALUES (55,5,38,8,'油滴斑纹如星空璀璨，盏中观茶，如观内心，禅意盎然','2026-03-07 22:54:51');
INSERT INTO `theme_product` VALUES (56,5,42,9,'汝窑开片如禅机，每一道裂纹都是时间的痕迹，品茶如参禅','2026-03-07 22:54:51');
INSERT INTO `theme_product` VALUES (57,6,39,8,'青花图案如花间蝴蝶，与花香茶韵相映成趣，杯中有花，茶中有香','2026-03-07 22:54:59');
INSERT INTO `theme_product` VALUES (58,6,45,9,'白瓷如花瓣般洁白无瑕，衬托花茶的清雅，让花香在杯中绽放','2026-03-07 22:54:59');
INSERT INTO `theme_product` VALUES (59,7,48,9,'宜兴紫砂，中国茶具的代表，世界茶文化的瑰宝','2026-03-07 22:55:04');
INSERT INTO `theme_product` VALUES (60,7,38,10,'建盏是宋代茶文化的巅峰之作，影响了日本天目盏的发展','2026-03-07 22:55:04');
INSERT INTO `theme_product` VALUES (61,7,45,11,'德化白瓷“中国白”，曾远销欧洲，是中国瓷器走向世界的见证','2026-03-07 22:55:04');
INSERT INTO `theme_product` VALUES (62,1,2,7,'汤色清澈，香气独特，有淡淡的花香','2026-03-14 16:34:28');
INSERT INTO `theme_product` VALUES (63,2,3,8,'色泽翠绿，香气持久，滋味醇厚','2026-03-14 16:36:11');
INSERT INTO `theme_product` VALUES (64,3,6,9,'香气馥郁悠长，兼具兰花香与岩骨花香','2026-03-14 16:36:58');
INSERT INTO `theme_product` VALUES (65,4,11,12,'条索紧结，色泽乌褐；香气辛锐，桂皮香明显；汤色橙黄明亮，滋味醇厚，辛辣感强，岩韵明显；叶底软亮。','2026-03-14 16:37:43');
/*!40000 ALTER TABLE `theme_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '邮箱',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '头像URL',
  `avatar_emoji` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '?' COMMENT '头像表情',
  `gender` tinyint(1) DEFAULT '0' COMMENT '性别 0-未知 1-男 2-女',
  `birthday` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '生日',
  `vip_level` tinyint DEFAULT '0' COMMENT '会员等级 0-普通 1-青铜 2-白银 3-黄金',
  `tea_age` int DEFAULT '0' COMMENT '茶龄(天)',
  `total_points` int DEFAULT '0' COMMENT '总积分',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态 0-禁用 1-正常',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '最后登录IP',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `signature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '个性标签',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_username` (`username`) USING BTREE,
  UNIQUE KEY `uk_phone` (`phone`) USING BTREE,
  UNIQUE KEY `uk_email` (`email`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_vip_level` (`vip_level`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'tea_friend1','13800138001','user1@example.com','e10adc3949ba59abbe56e057f20f883e','茶友·清风','https://example.com/avatar1.png','🍃',1,'1990-01-01',3,1095,1280,1,'2024-03-05 10:30:00','192.168.1.1','2026-03-05 16:54:20','2026-03-23 22:20:57','一杯龙井，品味春天的味道。茶如人生，淡中有味。');
INSERT INTO `user` VALUES (2,'tea_friend2','13800138002','user2@example.com','e10adc3949ba59abbe56e057f20f883e','茶友·悠然','https://example.com/avatar2.png','🍂',2,'1992-02-02',2,730,850,1,'2024-03-04 15:20:00','192.168.1.2','2026-03-05 16:54:20','2026-03-23 22:20:57','茶香袅袅，静心品茗。愿每一杯茶都能带来片刻安宁。');
INSERT INTO `user` VALUES (3,'tea_friend3','13800138003','user3@example.com','e10adc3949ba59abbe56e057f20f883e','茶友·静心','https://example.com/avatar3.png','🌿',2,'1988-03-03',2,800,920,1,'2024-03-03 09:15:00','192.168.1.3','2026-03-05 16:54:20','2026-03-23 22:20:57','茶禅一味，心静则明。以茶会友，以心相交。');
INSERT INTO `user` VALUES (4,'tea_friend4','13800138004','user4@example.com','e10adc3949ba59abbe56e057f20f883e','茶友·雅集','https://example.com/avatar4.png','🌺',1,'1995-04-04',1,365,450,1,'2024-03-02 14:45:00','192.168.1.4','2026-03-05 16:54:20','2026-10-23 15:10:28','云雾山中茶，清泉石上流。品茶即是品人生。');
INSERT INTO `user` VALUES (5,'tea_friend5','13800138005','user5@example.com','e10adc3949ba59abbe56e057f20f883e','茶友·墨香','https://example.com/avatar5.png','🍵',2,'1991-05-05',3,1000,1560,1,'2024-03-01 11:10:00','192.168.1.5','2026-03-05 16:54:20','2026-10-23 15:12:57','红茶暖心，乌龙醒神。一日不可无茶。');
INSERT INTO `user` VALUES (6,'tea_friend6','13800138006','user6@example.com','e10adc3949ba59abbe56e057f20f883e','茶友·听雨','https://example.com/avatar6.png','☁️',1,'1993-06-06',1,400,380,1,'2024-02-28 16:30:00','192.168.1.6','2026-03-05 16:54:20','2026-03-23 22:20:57','茶如故人，虽不常相见，却始终温暖如初。');
INSERT INTO `user` VALUES (7,'tea_friend7','13800138007','user7@example.com','e10adc3949ba59abbe56e057f20f883e','茶友·观山','https://example.com/avatar7.png','⛰️',1,'1989-07-07',2,850,780,1,'2024-02-27 10:20:00','192.168.1.7','2026-03-05 16:54:20','2026-03-23 22:20:57','喝茶是一种心情，品茶是一种心境。');
INSERT INTO `user` VALUES (8,'tea_friend8','13800138008','user8@example.com','e10adc3949ba59abbe56e057f20f883e','茶友·寻香','https://example.com/avatar8.png','🌸',2,'1994-08-08',1,300,290,1,'2024-02-26 13:40:00','192.168.1.8','2026-03-05 16:54:20','2026-03-23 22:20:57','白茶清欢无别事，我在等风也等你。');
INSERT INTO `user` VALUES (9,'tea_friend9','13800138009','user9@example.com','e10adc3949ba59abbe56e057f20f883e','茶友·忘机','https://example.com/avatar9.png','🌱',1,'1990-09-09',2,700,680,1,'2024-02-25 09:50:00','192.168.1.9','2026-03-05 16:54:20','2026-03-23 22:20:57','茶有三味：一苦，二甜，三回味。人生亦如是。');
INSERT INTO `user` VALUES (10,'tea_friend10','13800138010','user10@example.com','e10adc3949ba59abbe56e057f20f883e','茶友·拾光','https://example.com/avatar10.png','🍂',2,'1992-10-10',0,100,120,1,'2024-02-24 17:15:00','192.168.1.10','2026-03-05 16:54:20','2026-03-23 22:20:57','一壶好茶，三五好友，便是人间好时节。');
INSERT INTO `user` VALUES (11,'13900000011','13900000011','demo11@example.com','e10adc3949ba59abbe56e057f20f883e','推窗未见旧时雨','https://example.com/avatar11.png','🍃',1,'2017-3-24',3,1825,1600,1,'2026-03-15 10:12:15','192.168.1.11','2026-03-06 23:42:04','2026-10-24 17:02:23','茶香入心，岁月静好');
INSERT INTO `user` VALUES (12,'13900000012','13900000012',NULL,'e10adc3949ba59abbe56e057f20f883e','卡卡',NULL,'🌱',1,'2026-10-6',0,7300,0,1,NULL,NULL,'2026-10-06 23:04:05','2026-10-06 23:04:47','1');
INSERT INTO `user` VALUES (13,'favtest1792833532','19992833532',NULL,'47ec2dd791e31e2ef2076caf64ed9b3d',NULL,NULL,'?',0,NULL,0,0,0,1,NULL,NULL,'2026-10-24 17:18:53','2026-10-24 17:18:53',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_balance`
--

DROP TABLE IF EXISTS `user_balance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_balance` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '余额ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `wechat_balance` decimal(10,2) DEFAULT '0.00' COMMENT '微信余额',
  `alipay_balance` decimal(10,2) DEFAULT '0.00' COMMENT '支付宝余额',
  `total_balance` decimal(10,2) GENERATED ALWAYS AS ((`wechat_balance` + `alipay_balance`)) STORED COMMENT '总余额（计算字段）',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_user_id` (`user_id`) USING BTREE,
  KEY `idx_wechat_balance` (`wechat_balance`) USING BTREE,
  KEY `idx_alipay_balance` (`alipay_balance`) USING BTREE,
  CONSTRAINT `fk_user_balance_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户余额表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_balance`
--

LOCK TABLES `user_balance` WRITE;
/*!40000 ALTER TABLE `user_balance` DISABLE KEYS */;
INSERT INTO `user_balance` (`id`, `user_id`, `wechat_balance`, `alipay_balance`, `created_at`, `updated_at`) VALUES (1,1,128.50,58.00,'2026-03-15 09:55:18','2026-03-15 09:55:18');
INSERT INTO `user_balance` (`id`, `user_id`, `wechat_balance`, `alipay_balance`, `created_at`, `updated_at`) VALUES (2,2,356.80,120.50,'2026-03-15 09:55:18','2026-03-15 09:55:18');
INSERT INTO `user_balance` (`id`, `user_id`, `wechat_balance`, `alipay_balance`, `created_at`, `updated_at`) VALUES (3,3,200.00,88.80,'2026-03-15 09:55:18','2026-03-15 09:55:18');
INSERT INTO `user_balance` (`id`, `user_id`, `wechat_balance`, `alipay_balance`, `created_at`, `updated_at`) VALUES (4,4,45.30,99.90,'2026-03-15 09:55:18','2026-03-15 09:55:18');
INSERT INTO `user_balance` (`id`, `user_id`, `wechat_balance`, `alipay_balance`, `created_at`, `updated_at`) VALUES (5,5,320.00,156.00,'2026-03-15 09:55:18','2026-03-15 09:55:18');
INSERT INTO `user_balance` (`id`, `user_id`, `wechat_balance`, `alipay_balance`, `created_at`, `updated_at`) VALUES (6,6,67.50,30.00,'2026-03-15 09:55:18','2026-03-15 09:55:18');
INSERT INTO `user_balance` (`id`, `user_id`, `wechat_balance`, `alipay_balance`, `created_at`, `updated_at`) VALUES (7,7,88.80,45.30,'2026-03-15 09:55:18','2026-03-15 09:55:18');
INSERT INTO `user_balance` (`id`, `user_id`, `wechat_balance`, `alipay_balance`, `created_at`, `updated_at`) VALUES (8,8,99.90,67.50,'2026-03-15 09:55:18','2026-03-15 09:55:18');
INSERT INTO `user_balance` (`id`, `user_id`, `wechat_balance`, `alipay_balance`, `created_at`, `updated_at`) VALUES (9,9,120.50,88.80,'2026-03-15 09:55:18','2026-03-15 09:55:18');
INSERT INTO `user_balance` (`id`, `user_id`, `wechat_balance`, `alipay_balance`, `created_at`, `updated_at`) VALUES (10,10,156.00,128.50,'2026-03-15 09:55:18','2026-03-15 09:55:18');
INSERT INTO `user_balance` (`id`, `user_id`, `wechat_balance`, `alipay_balance`, `created_at`, `updated_at`) VALUES (11,11,256.00,538.50,'2026-03-15 10:07:20','2026-03-15 10:07:20');
/*!40000 ALTER TABLE `user_balance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_favorite`
--

DROP TABLE IF EXISTS `user_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_favorite` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `product_id` bigint NOT NULL COMMENT '商品ID',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_product` (`user_id`,`product_id`),
  KEY `idx_user` (`user_id`),
  KEY `fk_fav_product` (`product_id`),
  CONSTRAINT `fk_fav_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='商品收藏表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_favorite`
--

LOCK TABLES `user_favorite` WRITE;
/*!40000 ALTER TABLE `user_favorite` DISABLE KEYS */;
INSERT INTO `user_favorite` VALUES (2,11,1,'2026-10-24 16:02:00');
INSERT INTO `user_favorite` VALUES (4,11,2,'2026-10-24 17:20:10');
/*!40000 ALTER TABLE `user_favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_product`
--

DROP TABLE IF EXISTS `user_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_product` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `order_item_id` bigint NOT NULL COMMENT '订单项ID',
  `product_id` bigint NOT NULL COMMENT '商品ID',
  `spec_id` bigint DEFAULT NULL COMMENT '规格ID',
  `shop_id` int NOT NULL COMMENT '店铺ID',
  `product_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品名称（购买时的名称）',
  `product_emoji` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '商品表情',
  `spec_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '规格名称（购买时的规格）',
  `quantity` int NOT NULL COMMENT '购买数量',
  `price` decimal(10,2) NOT NULL COMMENT '购买单价',
  `total_amount` decimal(10,2) NOT NULL COMMENT '总金额',
  `payment_method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '支付方式',
  `purchase_time` datetime NOT NULL COMMENT '购买时间',
  `can_review` tinyint(1) DEFAULT '1' COMMENT '是否可以评价 0-否 1-是',
  `review_status` tinyint(1) DEFAULT '0' COMMENT '评价状态 0-未评价 1-已评价',
  `review_id` bigint DEFAULT NULL COMMENT '评价ID',
  `review_time` datetime DEFAULT NULL COMMENT '评价时间',
  `can_after_sale` tinyint(1) DEFAULT '1' COMMENT '是否可以售后 0-否 1-是',
  `after_sale_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '售后状态',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_order_item` (`order_item_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_order_id` (`order_id`) USING BTREE,
  KEY `idx_product_id` (`product_id`) USING BTREE,
  KEY `idx_shop_id` (`shop_id`) USING BTREE,
  KEY `idx_purchase_time` (`purchase_time`) USING BTREE,
  KEY `idx_review_status` (`review_status`) USING BTREE,
  KEY `idx_can_after_sale` (`can_after_sale`) USING BTREE,
  CONSTRAINT `fk_user_product_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_product_order_item` FOREIGN KEY (`order_item_id`) REFERENCES `order_item` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_product_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_product_shop` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_product_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户已购商品表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_product`
--

LOCK TABLES `user_product` WRITE;
/*!40000 ALTER TABLE `user_product` DISABLE KEYS */;
INSERT INTO `user_product` VALUES (46,1,1,1,1,2,7,'明前龙井','🍃','标准装 100g',2,198.00,396.00,'wechat','2026-03-05 14:30:00',1,0,NULL,NULL,1,NULL,'2026-03-16 10:55:27','2026-03-16 10:55:27');
INSERT INTO `user_product` VALUES (47,1,1,2,2,2,2,'狗牯脑茶','🌿','标准装 150g',1,168.00,168.00,'wechat','2026-03-05 14:30:00',1,0,NULL,NULL,1,NULL,'2026-03-16 10:55:27','2026-03-16 10:55:27');
INSERT INTO `user_product` VALUES (48,1,3,3,1,2,7,'明前龙井','🍃','标准装 100g',2,198.00,396.00,'wechat','2026-03-03 16:20:00',1,1,NULL,NULL,1,NULL,'2026-03-16 10:55:27','2026-03-16 10:55:27');
INSERT INTO `user_product` VALUES (49,1,3,4,5,2,1,'祁门红茶','🍂','标准装 150g',1,268.00,268.00,'wechat','2026-03-03 16:20:00',1,0,NULL,NULL,1,NULL,'2026-03-16 10:55:27','2026-03-16 10:55:27');
INSERT INTO `user_product` VALUES (50,2,2,5,3,1,2,'井冈翠绿','🍵','标准装 200g',1,228.00,228.00,'wechat','2026-03-04 10:15:00',1,0,NULL,NULL,1,NULL,'2026-03-16 10:55:27','2026-03-16 10:55:27');
INSERT INTO `user_product` VALUES (51,2,4,6,3,1,2,'井冈翠绿','🍵','标准装 200g',1,228.00,228.00,'alipay','2026-03-02 09:30:00',1,1,NULL,NULL,1,NULL,'2026-03-16 10:55:27','2026-03-16 10:55:27');
INSERT INTO `user_product` VALUES (52,3,4,7,2,2,2,'狗牯脑茶','🌿','标准装 150g',1,168.00,168.00,'alipay','2026-03-02 09:30:00',1,0,NULL,NULL,1,NULL,'2026-03-16 10:55:27','2026-03-16 10:55:27');
INSERT INTO `user_product` VALUES (53,4,5,8,1,2,7,'明前龙井','🍃','标准装 100g',1,198.00,198.00,'wechat','2026-02-28 11:45:00',1,0,NULL,NULL,1,NULL,'2026-03-16 10:55:27','2026-03-16 10:55:27');
INSERT INTO `user_product` VALUES (54,4,5,9,2,2,2,'狗牯脑茶','🌿','标准装 150g',1,168.00,168.00,'wechat','2026-02-28 11:45:00',1,1,NULL,NULL,1,NULL,'2026-03-16 10:55:27','2026-03-16 10:55:27');
INSERT INTO `user_product` VALUES (55,5,6,10,9,2,3,'大红袍','🌱','标准装 100g',1,358.00,358.00,'wechat','2026-02-25 14:30:00',1,0,NULL,NULL,1,NULL,'2026-03-16 10:55:27','2026-03-16 10:55:27');
INSERT INTO `user_product` VALUES (56,5,6,11,10,2,9,'铁观音','🍃','标准装 250g',1,228.00,228.00,'wechat','2026-02-25 14:30:00',1,0,NULL,NULL,1,NULL,'2026-03-16 10:55:27','2026-03-16 10:55:27');
INSERT INTO `user_product` VALUES (57,8,8,12,12,2,4,'白毫银针','🌱','标准装 100g',1,328.00,328.00,'alipay','2026-02-18 15:20:00',1,0,NULL,NULL,1,NULL,'2026-03-16 10:55:27','2026-03-16 10:55:27');
INSERT INTO `user_product` VALUES (58,8,8,13,13,2,4,'白牡丹','🌸','标准装 150g',1,188.00,188.00,'alipay','2026-02-18 15:20:00',1,0,NULL,NULL,1,NULL,'2026-03-16 10:55:27','2026-03-16 10:55:27');
INSERT INTO `user_product` VALUES (59,9,9,14,14,2,5,'普洱茶','🌿','标准装 357g',1,268.00,268.00,'wechat','2026-02-15 10:10:00',1,1,NULL,NULL,1,NULL,'2026-03-16 10:55:27','2026-03-16 10:55:27');
INSERT INTO `user_product` VALUES (60,10,11,15,16,2,1,'霍山黄芽','🌾','标准装 100g',1,258.00,258.00,'wechat','2026-02-10 13:25:00',1,0,NULL,NULL,1,NULL,'2026-03-16 10:55:27','2026-03-16 10:55:27');
INSERT INTO `user_product` VALUES (61,11,13,16,9,2,3,'大红袍','🌱','标准装 100g',1,358.00,358.00,'wechat','2026-03-16 10:30:00',1,0,NULL,NULL,1,NULL,'2026-03-16 10:59:36','2026-03-16 10:59:36');
INSERT INTO `user_product` VALUES (62,11,13,17,11,1,3,'肉桂','🌿','标准装 100g',1,298.00,298.00,'wechat','2026-03-16 10:30:00',1,0,NULL,NULL,1,NULL,'2026-03-16 10:59:36','2026-03-16 10:59:36');
/*!40000 ALTER TABLE `user_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_balance_statistics`
--

DROP TABLE IF EXISTS `v_balance_statistics`;
/*!50001 DROP VIEW IF EXISTS `v_balance_statistics`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_balance_statistics` AS SELECT 
 1 AS `user_count`,
 1 AS `total_wechat_balance`,
 1 AS `total_alipay_balance`,
 1 AS `total_balance`,
 1 AS `avg_wechat_balance`,
 1 AS `avg_alipay_balance`,
 1 AS `max_wechat_balance`,
 1 AS `max_alipay_balance`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_cart_detail_enhanced`
--

DROP TABLE IF EXISTS `v_cart_detail_enhanced`;
/*!50001 DROP VIEW IF EXISTS `v_cart_detail_enhanced`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_cart_detail_enhanced` AS SELECT 
 1 AS `cart_item_id`,
 1 AS `cart_id`,
 1 AS `quantity`,
 1 AS `checked`,
 1 AS `cart_item_created_at`,
 1 AS `cart_item_updated_at`,
 1 AS `theme_id`,
 1 AS `product_id`,
 1 AS `product_name`,
 1 AS `product_subtitle`,
 1 AS `product_emoji`,
 1 AS `spec_id`,
 1 AS `spec_name`,
 1 AS `spec_price`,
 1 AS `spec_original_price`,
 1 AS `spec_stock`,
 1 AS `spec_sales`,
 1 AS `shop_id`,
 1 AS `shop_name`,
 1 AS `shop_emoji`,
 1 AS `shop_badge`,
 1 AS `subtotal`,
 1 AS `original_subtotal`,
 1 AS `discount_amount`,
 1 AS `stock_status`,
 1 AS `shop_display_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_moment_detail`
--

DROP TABLE IF EXISTS `v_moment_detail`;
/*!50001 DROP VIEW IF EXISTS `v_moment_detail`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_moment_detail` AS SELECT 
 1 AS `id`,
 1 AS `user_id`,
 1 AS `user_name`,
 1 AS `user_avatar`,
 1 AS `user_signature`,
 1 AS `content`,
 1 AS `images`,
 1 AS `tea_tag`,
 1 AS `tea_id`,
 1 AS `tea_name`,
 1 AS `tea_emoji`,
 1 AS `location`,
 1 AS `topic`,
 1 AS `like_count`,
 1 AS `comment_count`,
 1 AS `view_count`,
 1 AS `share_count`,
 1 AS `is_top`,
 1 AS `is_hot`,
 1 AS `created_at`,
 1 AS `actual_like_count`,
 1 AS `actual_comment_count`,
 1 AS `time_ago`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_order_full`
--

DROP TABLE IF EXISTS `v_order_full`;
/*!50001 DROP VIEW IF EXISTS `v_order_full`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_order_full` AS SELECT 
 1 AS `order_id`,
 1 AS `order_no`,
 1 AS `order_status`,
 1 AS `total_amount`,
 1 AS `discount_amount`,
 1 AS `points_discount`,
 1 AS `coupon_discount`,
 1 AS `delivery_fee`,
 1 AS `pay_amount`,
 1 AS `used_points`,
 1 AS `order_remark`,
 1 AS `delivery_time`,
 1 AS `delivery_method`,
 1 AS `invoice_type`,
 1 AS `payment_method`,
 1 AS `payment_time`,
 1 AS `delivery_time_actual`,
 1 AS `receive_time`,
 1 AS `cancel_reason`,
 1 AS `order_created_at`,
 1 AS `order_updated_at`,
 1 AS `user_id`,
 1 AS `username`,
 1 AS `nickname`,
 1 AS `user_phone`,
 1 AS `user_avatar`,
 1 AS `vip_level`,
 1 AS `tea_age`,
 1 AS `address_id`,
 1 AS `receiver_name`,
 1 AS `receiver_phone`,
 1 AS `address_tag`,
 1 AS `province`,
 1 AS `city`,
 1 AS `district`,
 1 AS `address_detail`,
 1 AS `full_address`,
 1 AS `shop_id`,
 1 AS `shop_name`,
 1 AS `shop_logo`,
 1 AS `shop_badge`,
 1 AS `shop_phone`,
 1 AS `shop_address`,
 1 AS `product_ids`,
 1 AS `product_names`,
 1 AS `total_quantity`,
 1 AS `total_subtotal`,
 1 AS `order_items_json`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_order_item_detail`
--

DROP TABLE IF EXISTS `v_order_item_detail`;
/*!50001 DROP VIEW IF EXISTS `v_order_item_detail`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_order_item_detail` AS SELECT 
 1 AS `order_id`,
 1 AS `order_no`,
 1 AS `order_status`,
 1 AS `total_amount`,
 1 AS `discount_amount`,
 1 AS `points_discount`,
 1 AS `coupon_discount`,
 1 AS `delivery_fee`,
 1 AS `pay_amount`,
 1 AS `payment_method`,
 1 AS `payment_time`,
 1 AS `order_created_at`,
 1 AS `user_id`,
 1 AS `nickname`,
 1 AS `user_phone`,
 1 AS `receiver_name`,
 1 AS `receiver_phone`,
 1 AS `full_address`,
 1 AS `shop_id`,
 1 AS `shop_name`,
 1 AS `shop_badge`,
 1 AS `order_item_id`,
 1 AS `product_id`,
 1 AS `product_name`,
 1 AS `product_spec`,
 1 AS `order_item_emoji`,
 1 AS `unit_price`,
 1 AS `quantity`,
 1 AS `subtotal`,
 1 AS `current_price`,
 1 AS `original_price`,
 1 AS `current_stock`,
 1 AS `total_sales`,
 1 AS `product_rating`,
 1 AS `product_emoji`,
 1 AS `is_new`,
 1 AS `is_hot`,
 1 AS `tasting_notes`,
 1 AS `year`,
 1 AS `craft`,
 1 AS `origin`,
 1 AS `origin_detail`,
 1 AS `spec_id`,
 1 AS `current_spec_name`,
 1 AS `current_spec_price`,
 1 AS `current_spec_stock`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_order_statistics`
--

DROP TABLE IF EXISTS `v_order_statistics`;
/*!50001 DROP VIEW IF EXISTS `v_order_statistics`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_order_statistics` AS SELECT 
 1 AS `user_id`,
 1 AS `nickname`,
 1 AS `total_orders`,
 1 AS `unpaid_count`,
 1 AS `unship_count`,
 1 AS `unreceive_count`,
 1 AS `unreview_count`,
 1 AS `completed_count`,
 1 AS `cancelled_count`,
 1 AS `total_spent`,
 1 AS `avg_order_amount`,
 1 AS `last_payment_time`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_product_shop_full`
--

DROP TABLE IF EXISTS `v_product_shop_full`;
/*!50001 DROP VIEW IF EXISTS `v_product_shop_full`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_product_shop_full` AS SELECT 
 1 AS `id`,
 1 AS `category_name`,
 1 AS `shop_id`,
 1 AS `name`,
 1 AS `subtitle`,
 1 AS `description`,
 1 AS `tasting_notes`,
 1 AS `origin`,
 1 AS `origin_detail`,
 1 AS `spec`,
 1 AS `price`,
 1 AS `original_price`,
 1 AS `stock`,
 1 AS `sales`,
 1 AS `rating`,
 1 AS `emoji`,
 1 AS `year`,
 1 AS `craft`,
 1 AS `is_new`,
 1 AS `is_hot`,
 1 AS `status`,
 1 AS `created_at`,
 1 AS `updated_at`,
 1 AS `shop_name`,
 1 AS `logo`,
 1 AS `logo_emoji`,
 1 AS `shop_badge`,
 1 AS `shop_description`,
 1 AS `address`,
 1 AS `phone`,
 1 AS `business_hours`,
 1 AS `shop_rating`,
 1 AS `sales_count`,
 1 AS `shop_product_count`,
 1 AS `fans_count`,
 1 AS `shop_status`,
 1 AS `sort_order`,
 1 AS `shop_created_at`,
 1 AS `shop_updated_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_shop_products`
--

DROP TABLE IF EXISTS `v_shop_products`;
/*!50001 DROP VIEW IF EXISTS `v_shop_products`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_shop_products` AS SELECT 
 1 AS `shop_id`,
 1 AS `shop_name`,
 1 AS `logo_emoji`,
 1 AS `shop_badge`,
 1 AS `shop_rating`,
 1 AS `product_id`,
 1 AS `product_name`,
 1 AS `subtitle`,
 1 AS `price`,
 1 AS `original_price`,
 1 AS `emoji`,
 1 AS `sales`,
 1 AS `product_rating`,
 1 AS `is_new`,
 1 AS `is_hot`,
 1 AS `category_id`,
 1 AS `category_name`,
 1 AS `theme_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_shop_products_by_theme`
--

DROP TABLE IF EXISTS `v_shop_products_by_theme`;
/*!50001 DROP VIEW IF EXISTS `v_shop_products_by_theme`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_shop_products_by_theme` AS SELECT 
 1 AS `shop_id`,
 1 AS `shop_name`,
 1 AS `logo_emoji`,
 1 AS `shop_badge`,
 1 AS `shop_rating`,
 1 AS `theme_id`,
 1 AS `theme_name`,
 1 AS `theme_subtitle`,
 1 AS `theme_emoji`,
 1 AS `product_id`,
 1 AS `product_name`,
 1 AS `product_subtitle`,
 1 AS `product_spec`,
 1 AS `price`,
 1 AS `original_price`,
 1 AS `stock`,
 1 AS `sales`,
 1 AS `product_rating`,
 1 AS `product_emoji`,
 1 AS `is_new`,
 1 AS `is_hot`,
 1 AS `category_id`,
 1 AS `category_name`,
 1 AS `theme_sort_order`,
 1 AS `shop_sort_order`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_theme_product_category`
--

DROP TABLE IF EXISTS `v_theme_product_category`;
/*!50001 DROP VIEW IF EXISTS `v_theme_product_category`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_theme_product_category` AS SELECT 
 1 AS `theme_id`,
 1 AS `theme_name`,
 1 AS `theme_subtitle`,
 1 AS `theme_description`,
 1 AS `cover_image`,
 1 AS `cover_emoji`,
 1 AS `theme_product_count`,
 1 AS `tea_types`,
 1 AS `theme_min_price`,
 1 AS `theme_max_price`,
 1 AS `view_count`,
 1 AS `like_count`,
 1 AS `theme_status`,
 1 AS `theme_sort_order`,
 1 AS `theme_created_at`,
 1 AS `theme_updated_at`,
 1 AS `product_id`,
 1 AS `category_id`,
 1 AS `shop_id`,
 1 AS `product_name`,
 1 AS `product_subtitle`,
 1 AS `product_description`,
 1 AS `tasting_notes`,
 1 AS `year`,
 1 AS `craft`,
 1 AS `origin`,
 1 AS `origin_detail`,
 1 AS `product_spec`,
 1 AS `price`,
 1 AS `original_price`,
 1 AS `stock`,
 1 AS `sales`,
 1 AS `product_rating`,
 1 AS `product_emoji`,
 1 AS `is_new`,
 1 AS `is_hot`,
 1 AS `product_status`,
 1 AS `product_created_at`,
 1 AS `product_updated_at`,
 1 AS `category_name`,
 1 AS `category_icon`,
 1 AS `theme_product_sort_order`,
 1 AS `recommend_note`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_user_balance`
--

DROP TABLE IF EXISTS `v_user_balance`;
/*!50001 DROP VIEW IF EXISTS `v_user_balance`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_user_balance` AS SELECT 
 1 AS `user_id`,
 1 AS `username`,
 1 AS `nickname`,
 1 AS `phone`,
 1 AS `avatar_emoji`,
 1 AS `vip_level`,
 1 AS `tea_age`,
 1 AS `total_points`,
 1 AS `wechat_balance`,
 1 AS `alipay_balance`,
 1 AS `total_balance`,
 1 AS `balance_created_at`,
 1 AS `balance_updated_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_user_coupon`
--

DROP TABLE IF EXISTS `v_user_coupon`;
/*!50001 DROP VIEW IF EXISTS `v_user_coupon`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_user_coupon` AS SELECT 
 1 AS `user_id`,
 1 AS `username`,
 1 AS `nickname`,
 1 AS `user_avatar`,
 1 AS `vip_level`,
 1 AS `user_coupon_id`,
 1 AS `coupon_code_id`,
 1 AS `coupon_code`,
 1 AS `coupon_status`,
 1 AS `received_time`,
 1 AS `used_time`,
 1 AS `expire_time`,
 1 AS `coupon_id`,
 1 AS `coupon_name`,
 1 AS `coupon_type`,
 1 AS `coupon_value`,
 1 AS `coupon_condition`,
 1 AS `min_order_amount`,
 1 AS `max_discount`,
 1 AS `is_exclusive`,
 1 AS `theme_id`,
 1 AS `theme_name`,
 1 AS `theme_subtitle`,
 1 AS `theme_emoji`,
 1 AS `available_status`,
 1 AS `days_remaining`,
 1 AS `coupon_description`,
 1 AS `coupon_display_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_user_product`
--

DROP TABLE IF EXISTS `v_user_product`;
/*!50001 DROP VIEW IF EXISTS `v_user_product`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_user_product` AS SELECT 
 1 AS `record_id`,
 1 AS `user_id`,
 1 AS `order_id`,
 1 AS `product_id`,
 1 AS `spec_id`,
 1 AS `shop_id`,
 1 AS `product_name`,
 1 AS `product_emoji`,
 1 AS `spec_name`,
 1 AS `quantity`,
 1 AS `price`,
 1 AS `total_amount`,
 1 AS `payment_method`,
 1 AS `purchase_time`,
 1 AS `can_review`,
 1 AS `review_status`,
 1 AS `can_after_sale`,
 1 AS `categoryName`,
 1 AS `current_subtitle`,
 1 AS `description`,
 1 AS `tasting_notes`,
 1 AS `year`,
 1 AS `craft`,
 1 AS `origin`,
 1 AS `origin_detail`,
 1 AS `current_rating`,
 1 AS `is_new`,
 1 AS `is_hot`,
 1 AS `product_status`,
 1 AS `shop_name`,
 1 AS `logo_emoji`,
 1 AS `shop_badge`,
 1 AS `shop_rating`,
 1 AS `current_spec_name`,
 1 AS `current_price`,
 1 AS `current_stock`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'db_tear'
--
/*!50003 DROP FUNCTION IF EXISTS `is_coupon_code_valid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `is_coupon_code_valid`(p_code VARCHAR(50), p_password VARCHAR(50)) RETURNS varchar(100) CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE v_status VARCHAR(20);
    DECLARE v_expire_time DATETIME;
    DECLARE v_result VARCHAR(100);
    
    -- 查询兑换码状态和过期时间
    SELECT status, expire_time INTO v_status, v_expire_time
    FROM coupon_code
    WHERE code = p_code AND password = p_password;
    
    -- 判断结果
    IF v_status IS NULL THEN
        SET v_result = '无效的券号或密码';
    ELSEIF v_status = 'used' THEN
        SET v_result = '该兑换码已被使用';
    ELSEIF v_status = 'expired' OR v_expire_time < NOW() THEN
        SET v_result = '该兑换码已过期';
    ELSE
        SET v_result = '有效';
    END IF;
    
    RETURN v_result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `exchange_coupon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `exchange_coupon`(IN p_user_id BIGINT,      -- 用户ID
    IN p_code VARCHAR(50),     -- 券号
    IN p_password VARCHAR(50))
BEGIN
    DECLARE v_code_id BIGINT;
    DECLARE v_coupon_id BIGINT;
    DECLARE v_expire_time DATETIME;
    DECLARE v_current_status VARCHAR(20);
    DECLARE v_value DECIMAL(10,2);
    DECLARE v_type VARCHAR(20);
    DECLARE v_theme_id INT;
    DECLARE v_theme_name VARCHAR(100);
    
    -- 开始事务
    START TRANSACTION;
    
    -- 1. 检查兑换码是否存在且可用（加行锁防止并发）
    SELECT id, coupon_id, status, expire_time, value, type, theme_id, theme_name
    INTO v_code_id, v_coupon_id, v_current_status, v_expire_time, v_value, v_type, v_theme_id, v_theme_name
    FROM coupon_code 
    WHERE code = p_code AND password = p_password 
    FOR UPDATE;
    
    -- 2. 验证状态
    IF v_code_id IS NULL THEN
        SELECT '❌ 无效的券号或密码' AS result;
        ROLLBACK;
    ELSEIF v_current_status != 'unclaimed' THEN
        SELECT CONCAT('❌ 该兑换码状态为：', v_current_status, '，不可兑换') AS result;
        ROLLBACK;
    ELSEIF v_expire_time < NOW() THEN
        -- 过期处理
        UPDATE coupon_code SET status = 'expired' WHERE id = v_code_id;
        SELECT '❌ 该兑换码已过期' AS result;
        ROLLBACK;
    ELSE
        -- 3. 更新兑换码状态为已领取
        UPDATE coupon_code 
        SET status = 'claimed', 
            user_id = p_user_id, 
            claimed_time = NOW() 
        WHERE id = v_code_id;
        
        -- 4. 插入用户优惠券记录
        INSERT INTO coupon_user (
            user_id, coupon_id, coupon_code_id, code, 
            value, type, theme_id, theme_name,
            status, received_time, expire_time
        ) VALUES (
            p_user_id, v_coupon_id, v_code_id, p_code,
            v_value, v_type, v_theme_id, v_theme_name,
            'claimed', NOW(), v_expire_time
        );
        
        -- 5. 更新优惠券统计
        UPDATE coupon 
        SET received_count = received_count + 1 
        WHERE id = v_coupon_id;
        
        -- 6. 返回成功信息
        SELECT 
            '✅ 兑换成功' AS result,
            CONCAT('优惠券价值: ', 
                   CASE WHEN v_type = 'full' THEN CONCAT('¥', v_value)
                        ELSE CONCAT(v_value * 100, '% 折扣')
                   END) AS coupon_value,
            DATE_FORMAT(v_expire_time, '%Y-%m-%d') AS expire_date,
            COALESCE(v_theme_name, '通用券') AS theme_name;
        
        COMMIT;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `generate_coupon_codes_full` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `generate_coupon_codes_full`(IN p_coupon_id BIGINT,      -- 优惠券ID，NULL表示所有优惠券
    IN p_code_count INT,         -- 生成数量，每个优惠券的数量
    IN p_days_valid INT,         -- 有效天数，默认7天
    IN p_initial_status VARCHAR(20))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_coupon_id BIGINT;
    DECLARE v_coupon_name VARCHAR(100);
    DECLARE v_type VARCHAR(20);
    DECLARE v_value DECIMAL(10,2);
    DECLARE v_theme_id INT;
    DECLARE v_theme_name VARCHAR(100);
    DECLARE v_is_exclusive TINYINT;
    DECLARE v_expire_time DATETIME;
    DECLARE v_batch_no VARCHAR(50);
    DECLARE v_i INT;
    DECLARE v_count INT;
    DECLARE v_now DATETIME;
    DECLARE v_success_count INT DEFAULT 0;
    DECLARE v_processed_count INT DEFAULT 0;
    
    -- 游标：获取优惠券（不再获取end_time）
    DECLARE cur CURSOR FOR 
        SELECT id, name, type, value, theme_id, theme_name, is_exclusive
        FROM coupon 
        WHERE status = 1 
          AND (p_coupon_id IS NULL OR id = p_coupon_id);
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- 设置默认值
    IF p_code_count IS NULL OR p_code_count <= 0 THEN
        SET p_code_count = 20;
    END IF;
    
    -- 设置默认有效天数（7天）
    IF p_days_valid IS NULL OR p_days_valid <= 0 THEN
        SET p_days_valid = 7;
    END IF;
    
    -- 设置默认初始状态
    IF p_initial_status IS NULL OR p_initial_status NOT IN ('unclaimed', 'claimed', 'used', 'expired') THEN
        SET p_initial_status = 'unclaimed';
    END IF;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO v_coupon_id, v_coupon_name, v_type, v_value, v_theme_id, v_theme_name, v_is_exclusive;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- 获取当前时间
        SET v_now = NOW();
        
        -- 强制设置过期时间为当前时间 + 有效天数（忽略优惠券原有效期）
        SET v_expire_time = DATE_ADD(v_now, INTERVAL p_days_valid DAY);
        
        -- 生成批次号
        SET v_batch_no = CONCAT('BATCH', v_coupon_id, '_', DATE_FORMAT(v_now, '%Y%m%d_%H%i%s'), '_', v_processed_count);
        
        -- 批量插入
        SET v_i = 0;
        WHILE v_i < p_code_count DO
            INSERT INTO `coupon_code` (
                `coupon_id`, `code`, `password`, `batch_no`, 
                `value`, `type`, `theme_id`, `theme_name`, `is_exclusive`,
                `status`, `expire_time`, `created_at`
            ) VALUES (
                v_coupon_id,
                CONCAT('C', v_coupon_id, 
                       DATE_FORMAT(v_now, '%y%m%d'),
                       LPAD(v_i + 1, 4, '0'),
                       LPAD(FLOOR(RAND() * 100), 2, '0')),
                LPAD(FLOOR(RAND() * 1000000), 6, '0'),
                v_batch_no,
                v_value,
                v_type,
                v_theme_id,
                v_theme_name,
                v_is_exclusive,
                p_initial_status,
                v_expire_time,
                v_now
            );
            
            SET v_i = v_i + 1;
            SET v_success_count = v_success_count + 1;
        END WHILE;
        
        SET v_processed_count = v_processed_count + 1;
        
    END LOOP;
    
    CLOSE cur;
    
    -- 返回详细结果
    IF p_coupon_id IS NULL THEN
        SELECT 
            CONCAT('✅ 成功为 ', v_processed_count, ' 个优惠券生成 ', v_success_count, ' 个兑换码') AS result,
            CONCAT('初始状态: ', p_initial_status) AS status_info,
            CONCAT('生成数量: 每个优惠券 ', p_code_count, ' 个') AS count_info,
            CONCAT('有效期: ', p_days_valid, ' 天（从生成时间开始计算）') AS expire_info;
    ELSE
        SELECT 
            CONCAT('✅ 成功为优惠券ID ', p_coupon_id, ' 生成 ', v_success_count, ' 个兑换码') AS result,
            CONCAT('优惠券名称: ', v_coupon_name) AS coupon_info,
            CONCAT('初始状态: ', p_initial_status) AS status_info,
            CONCAT('有效期: ', p_days_valid, ' 天（从生成时间开始计算）') AS expire_info;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `generate_coupon_codes_simple` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `generate_coupon_codes_simple`(IN p_coupon_id BIGINT,      -- 优惠券ID
    IN p_code_count INT)
BEGIN
    DECLARE v_coupon_id BIGINT;
    DECLARE v_coupon_name VARCHAR(100);
    DECLARE v_type VARCHAR(20);
    DECLARE v_value DECIMAL(10,2);
    DECLARE v_theme_id INT;
    DECLARE v_theme_name VARCHAR(100);
    DECLARE v_is_exclusive TINYINT;
    DECLARE v_expire_time DATETIME;
    DECLARE v_batch_no VARCHAR(50);
    DECLARE v_i INT;
    DECLARE v_now DATETIME;
    DECLARE v_count INT;
    DECLARE v_success_count INT DEFAULT 0;
    
    -- 参数验证
    IF p_coupon_id IS NULL THEN
        SELECT '错误：优惠券ID不能为空' AS result;
        -- 直接退出，不使用LEAVE
    ELSE
        -- 设置默认生成数量
        IF p_code_count IS NULL OR p_code_count <= 0 THEN
            SET p_code_count = 20;
        END IF;
        
        -- 获取当前时间
        SET v_now = NOW();
        
        -- 过期时间 = 当前时间 + 7天（固定）
        SET v_expire_time = DATE_ADD(v_now, INTERVAL 7 DAY);
        
        -- 获取优惠券信息
        SELECT id, name, type, value, theme_id, theme_name, is_exclusive
        INTO v_coupon_id, v_coupon_name, v_type, v_value, v_theme_id, v_theme_name, v_is_exclusive
        FROM coupon
        WHERE id = p_coupon_id AND status = 1;
        
        -- 检查优惠券是否存在
        IF v_coupon_id IS NULL THEN
            SELECT CONCAT('错误：优惠券ID ', p_coupon_id, ' 不存在或已失效') AS result;
        ELSE
            -- 生成批次号
            SET v_batch_no = CONCAT('BATCH', v_coupon_id, '_', DATE_FORMAT(v_now, '%Y%m%d_%H%i%s'));
            
            -- 批量插入
            SET v_i = 0;
            WHILE v_i < p_code_count DO
                INSERT INTO `coupon_code` (
                    `coupon_id`, `code`, `password`, `batch_no`, 
                    `value`, `type`, `theme_id`, `theme_name`, `is_exclusive`,
                    `status`, `expire_time`, `created_at`
                ) VALUES (
                    v_coupon_id,
                    CONCAT('C', v_coupon_id, 
                           DATE_FORMAT(v_now, '%y%m%d'),
                           LPAD(v_i + 1, 4, '0'),
                           LPAD(FLOOR(RAND() * 100), 2, '0')),
                    LPAD(FLOOR(RAND() * 1000000), 6, '0'),
                    v_batch_no,
                    v_value,
                    v_type,
                    v_theme_id,
                    v_theme_name,
                    v_is_exclusive,
                    'unclaimed',  -- 新状态：未领取
                    v_expire_time,
                    v_now
                );
                
                SET v_i = v_i + 1;
                SET v_success_count = v_success_count + 1;
            END WHILE;
            
            -- 返回结果
            SELECT 
                CONCAT('✅ 成功为优惠券ID ', p_coupon_id, ' 生成 ', v_success_count, ' 个兑换码') AS result,
                CONCAT('优惠券名称: ', v_coupon_name) AS coupon_info,
                CONCAT('有效期: 7天 (至 ', DATE_FORMAT(v_expire_time, '%Y-%m-%d'), ')') AS expire_info,
                CONCAT('初始状态: 未领取') AS status_info;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_balance_statistics`
--

/*!50001 DROP VIEW IF EXISTS `v_balance_statistics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_balance_statistics` AS select count(0) AS `user_count`,sum(`user_balance`.`wechat_balance`) AS `total_wechat_balance`,sum(`user_balance`.`alipay_balance`) AS `total_alipay_balance`,sum(`user_balance`.`total_balance`) AS `total_balance`,avg(`user_balance`.`wechat_balance`) AS `avg_wechat_balance`,avg(`user_balance`.`alipay_balance`) AS `avg_alipay_balance`,max(`user_balance`.`wechat_balance`) AS `max_wechat_balance`,max(`user_balance`.`alipay_balance`) AS `max_alipay_balance` from `user_balance` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_cart_detail_enhanced`
--

/*!50001 DROP VIEW IF EXISTS `v_cart_detail_enhanced`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_cart_detail_enhanced` AS select `ci`.`id` AS `cart_item_id`,`ci`.`cart_id` AS `cart_id`,`ci`.`quantity` AS `quantity`,`ci`.`checked` AS `checked`,`ci`.`created_at` AS `cart_item_created_at`,`ci`.`updated_at` AS `cart_item_updated_at`,`t`.`theme_id` AS `theme_id`,`p`.`id` AS `product_id`,`p`.`name` AS `product_name`,`p`.`subtitle` AS `product_subtitle`,`p`.`emoji` AS `product_emoji`,`ps`.`id` AS `spec_id`,`ps`.`spec_name` AS `spec_name`,`ps`.`price` AS `spec_price`,`ps`.`original_price` AS `spec_original_price`,`ps`.`stock` AS `spec_stock`,`ps`.`sales` AS `spec_sales`,`s`.`id` AS `shop_id`,`s`.`name` AS `shop_name`,`s`.`logo_emoji` AS `shop_emoji`,`s`.`badge` AS `shop_badge`,(`ps`.`price` * `ci`.`quantity`) AS `subtotal`,(`ps`.`original_price` * `ci`.`quantity`) AS `original_subtotal`,((`ps`.`original_price` - `ps`.`price`) * `ci`.`quantity`) AS `discount_amount`,(case when (`ps`.`stock` >= `ci`.`quantity`) then '有货' else '库存不足' end) AS `stock_status`,concat(`s`.`name`,' ',`s`.`badge`) AS `shop_display_name` from ((((`cart_item` `ci` left join `product_spec` `ps` on((`ci`.`spec_id` = `ps`.`id`))) left join `product` `p` on((`ps`.`product_id` = `p`.`id`))) left join `shop` `s` on((`p`.`shop_id` = `s`.`id`))) left join `theme_product` `t` on((`p`.`id` = `t`.`product_id`))) order by `ci`.`created_at` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_moment_detail`
--

/*!50001 DROP VIEW IF EXISTS `v_moment_detail`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_moment_detail` AS select `m`.`id` AS `id`,`m`.`user_id` AS `user_id`,`u`.`nickname` AS `user_name`,`u`.`avatar_emoji` AS `user_avatar`,`u`.`signature` AS `user_signature`,`m`.`content` AS `content`,`m`.`images` AS `images`,`m`.`tea_tag` AS `tea_tag`,`m`.`tea_id` AS `tea_id`,`p`.`name` AS `tea_name`,`p`.`emoji` AS `tea_emoji`,`m`.`location` AS `location`,`m`.`topic` AS `topic`,`m`.`like_count` AS `like_count`,`m`.`comment_count` AS `comment_count`,`m`.`view_count` AS `view_count`,`m`.`share_count` AS `share_count`,`m`.`is_top` AS `is_top`,`m`.`is_hot` AS `is_hot`,`m`.`created_at` AS `created_at`,(select count(0) from `moment_like` `ml` where (`ml`.`moment_id` = `m`.`id`)) AS `actual_like_count`,(select count(0) from `moment_comment` `mc` where (`mc`.`moment_id` = `m`.`id`)) AS `actual_comment_count`,(case when (timestampdiff(MINUTE,`m`.`created_at`,now()) < 60) then concat(timestampdiff(MINUTE,`m`.`created_at`,now()),'分钟前') when (timestampdiff(HOUR,`m`.`created_at`,now()) < 24) then concat(timestampdiff(HOUR,`m`.`created_at`,now()),'小时前') when (timestampdiff(DAY,`m`.`created_at`,now()) < 7) then concat(timestampdiff(DAY,`m`.`created_at`,now()),'天前') else date_format(`m`.`created_at`,'%Y-%m-%d') end) AS `time_ago` from ((`moment` `m` left join `user` `u` on((`m`.`user_id` = `u`.`id`))) left join `product` `p` on((`m`.`tea_id` = `p`.`id`))) where (`m`.`status` = 1) order by `m`.`is_top` desc,`m`.`created_at` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_order_full`
--

/*!50001 DROP VIEW IF EXISTS `v_order_full`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_order_full` AS select `o`.`id` AS `order_id`,`o`.`order_no` AS `order_no`,`o`.`status` AS `order_status`,`o`.`total_amount` AS `total_amount`,`o`.`discount_amount` AS `discount_amount`,`o`.`points_discount` AS `points_discount`,`o`.`coupon_discount` AS `coupon_discount`,`o`.`delivery_fee` AS `delivery_fee`,`o`.`pay_amount` AS `pay_amount`,`o`.`used_points` AS `used_points`,`o`.`remark` AS `order_remark`,`o`.`delivery_time` AS `delivery_time`,`o`.`delivery_method` AS `delivery_method`,`o`.`invoice_type` AS `invoice_type`,`o`.`payment_method` AS `payment_method`,`o`.`payment_time` AS `payment_time`,`o`.`delivery_time_actual` AS `delivery_time_actual`,`o`.`receive_time` AS `receive_time`,`o`.`cancel_reason` AS `cancel_reason`,`o`.`created_at` AS `order_created_at`,`o`.`updated_at` AS `order_updated_at`,`u`.`id` AS `user_id`,`u`.`username` AS `username`,`u`.`nickname` AS `nickname`,`u`.`phone` AS `user_phone`,`u`.`avatar_emoji` AS `user_avatar`,`u`.`vip_level` AS `vip_level`,`u`.`tea_age` AS `tea_age`,`a`.`id` AS `address_id`,`a`.`name` AS `receiver_name`,`a`.`phone` AS `receiver_phone`,`a`.`tag` AS `address_tag`,`a`.`province` AS `province`,`a`.`city` AS `city`,`a`.`district` AS `district`,`a`.`detail` AS `address_detail`,`a`.`full_address` AS `full_address`,`s`.`id` AS `shop_id`,`s`.`name` AS `shop_name`,`s`.`logo_emoji` AS `shop_logo`,`s`.`badge` AS `shop_badge`,`s`.`phone` AS `shop_phone`,`s`.`address` AS `shop_address`,`oi`.`product_ids` AS `product_ids`,`oi`.`product_names` AS `product_names`,`oi`.`total_quantity` AS `total_quantity`,`oi`.`total_subtotal` AS `total_subtotal`,`oi`.`order_items_json` AS `order_items_json` from ((((`order` `o` left join `user` `u` on((`o`.`user_id` = `u`.`id`))) left join `address` `a` on((`o`.`address_id` = `a`.`id`))) left join `shop` `s` on((`o`.`shop_id` = `s`.`id`))) left join (select `order_item`.`order_id` AS `order_id`,group_concat(distinct `order_item`.`product_id` order by `order_item`.`id` ASC separator ',') AS `product_ids`,group_concat(distinct `order_item`.`product_name` order by `order_item`.`id` ASC separator '、') AS `product_names`,sum(`order_item`.`quantity`) AS `total_quantity`,sum(`order_item`.`subtotal`) AS `total_subtotal`,json_arrayagg(json_object('order_item_id',`order_item`.`id`,'product_id',`order_item`.`product_id`,'product_name',`order_item`.`product_name`,'product_spec',`order_item`.`product_spec`,'product_emoji',`order_item`.`product_emoji`,'price',`order_item`.`price`,'quantity',`order_item`.`quantity`,'subtotal',`order_item`.`subtotal`)) AS `order_items_json` from `order_item` group by `order_item`.`order_id`) `oi` on((`o`.`id` = `oi`.`order_id`))) order by `o`.`created_at` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_order_item_detail`
--

/*!50001 DROP VIEW IF EXISTS `v_order_item_detail`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_order_item_detail` AS select `o`.`id` AS `order_id`,`o`.`order_no` AS `order_no`,`o`.`status` AS `order_status`,`o`.`total_amount` AS `total_amount`,`o`.`discount_amount` AS `discount_amount`,`o`.`points_discount` AS `points_discount`,`o`.`coupon_discount` AS `coupon_discount`,`o`.`delivery_fee` AS `delivery_fee`,`o`.`pay_amount` AS `pay_amount`,`o`.`payment_method` AS `payment_method`,`o`.`payment_time` AS `payment_time`,`o`.`created_at` AS `order_created_at`,`u`.`id` AS `user_id`,`u`.`nickname` AS `nickname`,`u`.`phone` AS `user_phone`,`a`.`name` AS `receiver_name`,`a`.`phone` AS `receiver_phone`,`a`.`full_address` AS `full_address`,`s`.`id` AS `shop_id`,`s`.`name` AS `shop_name`,`s`.`badge` AS `shop_badge`,`oi`.`id` AS `order_item_id`,`oi`.`product_id` AS `product_id`,`oi`.`product_name` AS `product_name`,`oi`.`product_spec` AS `product_spec`,`oi`.`product_emoji` AS `order_item_emoji`,`oi`.`price` AS `unit_price`,`oi`.`quantity` AS `quantity`,`oi`.`subtotal` AS `subtotal`,`p`.`price` AS `current_price`,`p`.`original_price` AS `original_price`,`p`.`stock` AS `current_stock`,`p`.`sales` AS `total_sales`,`p`.`rating` AS `product_rating`,`p`.`emoji` AS `product_emoji`,`p`.`is_new` AS `is_new`,`p`.`is_hot` AS `is_hot`,`p`.`tasting_notes` AS `tasting_notes`,`p`.`year` AS `year`,`p`.`craft` AS `craft`,`p`.`origin` AS `origin`,`p`.`origin_detail` AS `origin_detail`,`ps`.`id` AS `spec_id`,`ps`.`spec_name` AS `current_spec_name`,`ps`.`price` AS `current_spec_price`,`ps`.`stock` AS `current_spec_stock` from ((((((`order` `o` left join `user` `u` on((`o`.`user_id` = `u`.`id`))) left join `address` `a` on((`o`.`address_id` = `a`.`id`))) left join `shop` `s` on((`o`.`shop_id` = `s`.`id`))) join `order_item` `oi` on((`o`.`id` = `oi`.`order_id`))) left join `product` `p` on((`oi`.`product_id` = `p`.`id`))) left join `product_spec` `ps` on(((`oi`.`product_id` = `ps`.`product_id`) and (`ps`.`is_default` = 1)))) order by `o`.`created_at` desc,`oi`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_order_statistics`
--

/*!50001 DROP VIEW IF EXISTS `v_order_statistics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_order_statistics` AS select `o`.`user_id` AS `user_id`,`u`.`nickname` AS `nickname`,count(0) AS `total_orders`,sum((case when (`o`.`status` = 'unpaid') then 1 else 0 end)) AS `unpaid_count`,sum((case when (`o`.`status` = 'unship') then 1 else 0 end)) AS `unship_count`,sum((case when (`o`.`status` = 'unreceive') then 1 else 0 end)) AS `unreceive_count`,sum((case when (`o`.`status` = 'unreview') then 1 else 0 end)) AS `unreview_count`,sum((case when (`o`.`status` = 'completed') then 1 else 0 end)) AS `completed_count`,sum((case when (`o`.`status` = 'cancelled') then 1 else 0 end)) AS `cancelled_count`,sum(`o`.`pay_amount`) AS `total_spent`,avg(`o`.`pay_amount`) AS `avg_order_amount`,max(`o`.`payment_time`) AS `last_payment_time` from (`order` `o` left join `user` `u` on((`o`.`user_id` = `u`.`id`))) group by `o`.`user_id`,`u`.`nickname` order by `total_spent` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_product_shop_full`
--

/*!50001 DROP VIEW IF EXISTS `v_product_shop_full`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_product_shop_full` AS select `p`.`id` AS `id`,`c`.`name` AS `category_name`,`p`.`shop_id` AS `shop_id`,`p`.`name` AS `name`,`p`.`subtitle` AS `subtitle`,`p`.`description` AS `description`,`p`.`tasting_notes` AS `tasting_notes`,`p`.`origin` AS `origin`,`p`.`origin_detail` AS `origin_detail`,`p`.`spec` AS `spec`,`p`.`price` AS `price`,`p`.`original_price` AS `original_price`,`p`.`stock` AS `stock`,`p`.`sales` AS `sales`,`p`.`rating` AS `rating`,`p`.`emoji` AS `emoji`,`p`.`year` AS `year`,`p`.`craft` AS `craft`,`p`.`is_new` AS `is_new`,`p`.`is_hot` AS `is_hot`,`p`.`status` AS `status`,`p`.`created_at` AS `created_at`,`p`.`updated_at` AS `updated_at`,`s`.`name` AS `shop_name`,`s`.`logo` AS `logo`,`s`.`logo_emoji` AS `logo_emoji`,`s`.`badge` AS `shop_badge`,`s`.`description` AS `shop_description`,`s`.`address` AS `address`,`s`.`phone` AS `phone`,`s`.`business_hours` AS `business_hours`,`s`.`rating` AS `shop_rating`,`s`.`sales_count` AS `sales_count`,`s`.`product_count` AS `shop_product_count`,`s`.`fans_count` AS `fans_count`,`s`.`status` AS `shop_status`,`s`.`sort_order` AS `sort_order`,`s`.`created_at` AS `shop_created_at`,`s`.`updated_at` AS `shop_updated_at` from ((`product` `p` left join `shop` `s` on((`p`.`shop_id` = `s`.`id`))) join `category` `c` on((`p`.`category_id` = `c`.`id`))) where (`p`.`status` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_shop_products`
--

/*!50001 DROP VIEW IF EXISTS `v_shop_products`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_shop_products` AS select `s`.`id` AS `shop_id`,`s`.`name` AS `shop_name`,`s`.`logo_emoji` AS `logo_emoji`,`s`.`badge` AS `shop_badge`,`s`.`rating` AS `shop_rating`,`p`.`id` AS `product_id`,`p`.`name` AS `product_name`,`p`.`subtitle` AS `subtitle`,`p`.`price` AS `price`,`p`.`original_price` AS `original_price`,`p`.`emoji` AS `emoji`,`p`.`sales` AS `sales`,`p`.`rating` AS `product_rating`,`p`.`is_new` AS `is_new`,`p`.`is_hot` AS `is_hot`,`c`.`id` AS `category_id`,`c`.`name` AS `category_name`,`t`.`theme_id` AS `theme_id` from (((`shop` `s` join `product` `p` on((`s`.`id` = `p`.`shop_id`))) join `category` `c` on((`p`.`category_id` = `c`.`id`))) join `theme_product` `t` on((`p`.`id` = `t`.`product_id`))) where (`p`.`status` = 1) order by `s`.`sort_order`,`p`.`sales` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_shop_products_by_theme`
--

/*!50001 DROP VIEW IF EXISTS `v_shop_products_by_theme`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_shop_products_by_theme` AS select `s`.`id` AS `shop_id`,`s`.`name` AS `shop_name`,`s`.`logo_emoji` AS `logo_emoji`,`s`.`badge` AS `shop_badge`,`s`.`rating` AS `shop_rating`,`t`.`id` AS `theme_id`,`t`.`name` AS `theme_name`,`t`.`subtitle` AS `theme_subtitle`,`t`.`cover_emoji` AS `theme_emoji`,`p`.`id` AS `product_id`,`p`.`name` AS `product_name`,`p`.`subtitle` AS `product_subtitle`,`p`.`spec` AS `product_spec`,`p`.`price` AS `price`,`p`.`original_price` AS `original_price`,`p`.`stock` AS `stock`,`p`.`sales` AS `sales`,`p`.`rating` AS `product_rating`,`p`.`emoji` AS `product_emoji`,`p`.`is_new` AS `is_new`,`p`.`is_hot` AS `is_hot`,`c`.`id` AS `category_id`,`c`.`name` AS `category_name`,`tp`.`sort_order` AS `theme_sort_order`,`s`.`sort_order` AS `shop_sort_order` from (((((`shop` `s` join `shop_theme` `st` on((`s`.`id` = `st`.`shop_id`))) join `theme` `t` on((`st`.`theme_id` = `t`.`id`))) join `theme_product` `tp` on((`t`.`id` = `tp`.`theme_id`))) join `product` `p` on((`tp`.`product_id` = `p`.`id`))) join `category` `c` on((`p`.`category_id` = `c`.`id`))) where (`p`.`status` = 1) order by `s`.`sort_order`,`t`.`sort_order`,`tp`.`sort_order` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_theme_product_category`
--

/*!50001 DROP VIEW IF EXISTS `v_theme_product_category`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_theme_product_category` AS select `t`.`id` AS `theme_id`,`t`.`name` AS `theme_name`,`t`.`subtitle` AS `theme_subtitle`,`t`.`description` AS `theme_description`,`t`.`cover_image` AS `cover_image`,`t`.`cover_emoji` AS `cover_emoji`,`t`.`product_count` AS `theme_product_count`,`t`.`tea_types` AS `tea_types`,`t`.`min_price` AS `theme_min_price`,`t`.`max_price` AS `theme_max_price`,`t`.`view_count` AS `view_count`,`t`.`like_count` AS `like_count`,`t`.`status` AS `theme_status`,`t`.`sort_order` AS `theme_sort_order`,`t`.`created_at` AS `theme_created_at`,`t`.`updated_at` AS `theme_updated_at`,`p`.`id` AS `product_id`,`p`.`category_id` AS `category_id`,`p`.`shop_id` AS `shop_id`,`p`.`name` AS `product_name`,`p`.`subtitle` AS `product_subtitle`,`p`.`description` AS `product_description`,`p`.`tasting_notes` AS `tasting_notes`,`p`.`year` AS `year`,`p`.`craft` AS `craft`,`p`.`origin` AS `origin`,`p`.`origin_detail` AS `origin_detail`,`p`.`spec` AS `product_spec`,`p`.`price` AS `price`,`p`.`original_price` AS `original_price`,`p`.`stock` AS `stock`,`p`.`sales` AS `sales`,`p`.`rating` AS `product_rating`,`p`.`emoji` AS `product_emoji`,`p`.`is_new` AS `is_new`,`p`.`is_hot` AS `is_hot`,`p`.`status` AS `product_status`,`p`.`created_at` AS `product_created_at`,`p`.`updated_at` AS `product_updated_at`,`c`.`name` AS `category_name`,`c`.`icon` AS `category_icon`,`tp`.`sort_order` AS `theme_product_sort_order`,`tp`.`recommend_note` AS `recommend_note` from (((`theme` `t` join `theme_product` `tp` on((`t`.`id` = `tp`.`theme_id`))) join `product` `p` on((`tp`.`product_id` = `p`.`id`))) left join `category` `c` on((`p`.`category_id` = `c`.`id`))) where ((`t`.`status` = 1) and (`p`.`status` = 1)) order by `t`.`sort_order`,`tp`.`sort_order` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_user_balance`
--

/*!50001 DROP VIEW IF EXISTS `v_user_balance`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_balance` AS select `u`.`id` AS `user_id`,`u`.`username` AS `username`,`u`.`nickname` AS `nickname`,`u`.`phone` AS `phone`,`u`.`avatar_emoji` AS `avatar_emoji`,`u`.`vip_level` AS `vip_level`,`u`.`tea_age` AS `tea_age`,`u`.`total_points` AS `total_points`,`ub`.`wechat_balance` AS `wechat_balance`,`ub`.`alipay_balance` AS `alipay_balance`,`ub`.`total_balance` AS `total_balance`,`ub`.`created_at` AS `balance_created_at`,`ub`.`updated_at` AS `balance_updated_at` from (`user` `u` left join `user_balance` `ub` on((`u`.`id` = `ub`.`user_id`))) where (`u`.`status` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_user_coupon`
--

/*!50001 DROP VIEW IF EXISTS `v_user_coupon`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_coupon` AS select `u`.`id` AS `user_id`,`u`.`username` AS `username`,`u`.`nickname` AS `nickname`,`u`.`avatar_emoji` AS `user_avatar`,`u`.`vip_level` AS `vip_level`,`cu`.`id` AS `user_coupon_id`,`cu`.`coupon_code_id` AS `coupon_code_id`,`cu`.`code` AS `coupon_code`,`cu`.`status` AS `coupon_status`,`cu`.`received_time` AS `received_time`,`cu`.`used_time` AS `used_time`,`cu`.`expire_time` AS `expire_time`,`c`.`id` AS `coupon_id`,`c`.`name` AS `coupon_name`,`c`.`type` AS `coupon_type`,`c`.`value` AS `coupon_value`,`c`.`condition` AS `coupon_condition`,`c`.`min_order_amount` AS `min_order_amount`,`c`.`max_discount` AS `max_discount`,`c`.`is_exclusive` AS `is_exclusive`,`t`.`id` AS `theme_id`,`t`.`name` AS `theme_name`,`t`.`subtitle` AS `theme_subtitle`,`t`.`cover_emoji` AS `theme_emoji`,(case when ((`cu`.`status` = 'claimed') and (`cu`.`expire_time` > now())) then '可用' when (`cu`.`status` = 'used') then '已使用' when (`cu`.`expire_time` <= now()) then '已过期' else '不可用' end) AS `available_status`,(to_days(`cu`.`expire_time`) - to_days(now())) AS `days_remaining`,(case when (`c`.`type` = 'full') then concat('满',`c`.`min_order_amount`,'减',`c`.`value`) when (`c`.`type` = 'discount') then concat((`c`.`value` * 100),'折') else `c`.`condition` end) AS `coupon_description`,concat((case when (`c`.`type` = 'full') then concat('¥',`c`.`value`) when (`c`.`type` = 'discount') then concat((`c`.`value` * 100),'%') else `c`.`condition` end),' ',`c`.`name`) AS `coupon_display_name` from (((`coupon_user` `cu` join `user` `u` on((`cu`.`user_id` = `u`.`id`))) join `coupon` `c` on((`cu`.`coupon_id` = `c`.`id`))) left join `theme` `t` on((`c`.`theme_id` = `t`.`id`))) where (`u`.`status` = 1) order by `cu`.`received_time` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_user_product`
--

/*!50001 DROP VIEW IF EXISTS `v_user_product`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_product` AS select `up`.`id` AS `record_id`,`up`.`user_id` AS `user_id`,`up`.`order_id` AS `order_id`,`up`.`product_id` AS `product_id`,`up`.`spec_id` AS `spec_id`,`up`.`shop_id` AS `shop_id`,`up`.`product_name` AS `product_name`,`up`.`product_emoji` AS `product_emoji`,`up`.`spec_name` AS `spec_name`,`up`.`quantity` AS `quantity`,`up`.`price` AS `price`,`up`.`total_amount` AS `total_amount`,`up`.`payment_method` AS `payment_method`,`up`.`purchase_time` AS `purchase_time`,`up`.`can_review` AS `can_review`,`up`.`review_status` AS `review_status`,`up`.`can_after_sale` AS `can_after_sale`,`c`.`name` AS `categoryName`,`p`.`subtitle` AS `current_subtitle`,`p`.`description` AS `description`,`p`.`tasting_notes` AS `tasting_notes`,`p`.`year` AS `year`,`p`.`craft` AS `craft`,`p`.`origin` AS `origin`,`p`.`origin_detail` AS `origin_detail`,`p`.`rating` AS `current_rating`,`p`.`is_new` AS `is_new`,`p`.`is_hot` AS `is_hot`,`p`.`status` AS `product_status`,`s`.`name` AS `shop_name`,`s`.`logo_emoji` AS `logo_emoji`,`s`.`badge` AS `shop_badge`,`s`.`rating` AS `shop_rating`,`ps`.`spec_name` AS `current_spec_name`,`ps`.`price` AS `current_price`,`ps`.`stock` AS `current_stock` from ((((`user_product` `up` left join `product` `p` on((`up`.`product_id` = `p`.`id`))) left join `category` `c` on((`p`.`category_id` = `c`.`id`))) left join `shop` `s` on((`up`.`shop_id` = `s`.`id`))) left join `product_spec` `ps` on((`up`.`spec_id` = `ps`.`id`))) order by `up`.`purchase_time` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-24 18:49:50
