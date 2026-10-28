-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: db_agent
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
-- Table structure for table `agent_tool_call`
--

DROP TABLE IF EXISTS `agent_tool_call`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agent_tool_call` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `trace_id` varchar(64) NOT NULL,
  `tool_name` varchar(64) NOT NULL,
  `request_body` json DEFAULT NULL,
  `response_code` int DEFAULT NULL,
  `latency_ms` int DEFAULT NULL,
  `idempotent_key` varchar(128) DEFAULT NULL COMMENT '写操作幂等键 traceId:toolName',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_idem` (`idempotent_key`),
  KEY `idx_trace` (`trace_id`),
  KEY `idx_tool` (`tool_name`),
  KEY `idx_created` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=380 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Agent 工具调用审计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agent_tool_call`
--

LOCK TABLES `agent_tool_call` WRITE;
/*!40000 ALTER TABLE `agent_tool_call` DISABLE KEYS */;
INSERT INTO `agent_tool_call` VALUES (1,'3f3b833f201a449cb28f3ee9e9ce1d94','search_tea','{\"keyword\": \"龙井\"}',NULL,128,NULL,'2026-10-04 00:32:34');
INSERT INTO `agent_tool_call` VALUES (2,'358aded3a943404abd6be1d231934681','search_tea','{\"keyword\": \"龙井\"}',NULL,111,NULL,'2026-10-04 00:37:00');
INSERT INTO `agent_tool_call` VALUES (3,'227d8a70804d48eea1d56d6e71aad5d7','search_tea','{\"keyword\": \"龙井\"}',NULL,39,NULL,'2026-10-04 00:37:24');
INSERT INTO `agent_tool_call` VALUES (4,'71a4cf61d0724ac0ae61d4645910715c','search_tea','{\"keyword\": \"龙井\"}',NULL,157,NULL,'2026-10-04 11:40:49');
INSERT INTO `agent_tool_call` VALUES (5,'333c93604a45489fa40f2a4d13cde9e6','search_tea','{\"keyword\": \"龙井\"}',NULL,15,NULL,'2026-10-04 11:41:12');
INSERT INTO `agent_tool_call` VALUES (6,'f303693d697d4503b46f6803a5c880c8','search_tea','{\"keyword\": \"龙井\"}',NULL,170,NULL,'2026-10-05 23:44:21');
INSERT INTO `agent_tool_call` VALUES (7,'4d1af249ab29400c887da41c50825802','search_tea','{\"keyword\": \"绿茶\"}',NULL,16,NULL,'2026-10-06 00:10:21');
INSERT INTO `agent_tool_call` VALUES (8,'3d534a6b487541a897bd28ab7dbf4eb5','search_tea','{\"keyword\": \"绿茶\"}',NULL,140,NULL,'2026-10-06 00:36:29');
INSERT INTO `agent_tool_call` VALUES (9,'4957b310d65448819b0119ec26e14bbf','search_tea','{\"keyword\": \"龙井\"}',NULL,29,NULL,'2026-10-06 00:37:37');
INSERT INTO `agent_tool_call` VALUES (10,'a27ed0cdd44443578700652d8edc22d7','search_tea','{\"keyword\": \"绿茶\"}',NULL,25,NULL,'2026-10-06 00:46:20');
INSERT INTO `agent_tool_call` VALUES (11,'4a59a4cff2174906b3fbe8af53ac4ecc','search_tea','{\"keyword\": \"龙井\"}',NULL,444,NULL,'2026-10-06 12:11:47');
INSERT INTO `agent_tool_call` VALUES (12,'7be99f1a1e9c40fe9fd6d2bee6a0524e','search_tea','{\"keyword\": \"明前龙井\"}',NULL,162,NULL,'2026-10-06 12:51:42');
INSERT INTO `agent_tool_call` VALUES (13,'7be99f1a1e9c40fe9fd6d2bee6a0524e','list_addresses','{}',NULL,18,NULL,'2026-10-06 12:51:42');
INSERT INTO `agent_tool_call` VALUES (14,'7be99f1a1e9c40fe9fd6d2bee6a0524e','prepare_order','{\"specId\": 1, \"quantity\": 1, \"addressId\": 1, \"productId\": 1}',NULL,61,NULL,'2026-10-06 12:51:43');
INSERT INTO `agent_tool_call` VALUES (15,'5d999360e97848118388f6d655e3043a','confirm_order','{\"confirmToken\": \"ffe59bed8f9e450ca9f06edb17c8cafd\"}',NULL,4,'5d999360e97848118388f6d655e3043a:confirm_order','2026-10-06 12:51:46');
INSERT INTO `agent_tool_call` VALUES (16,'3972323a7e634d28a56d9122251a3400','search_tea','{\"keyword\": \"明前龙井\"}',NULL,145,NULL,'2026-10-06 12:54:25');
INSERT INTO `agent_tool_call` VALUES (17,'3972323a7e634d28a56d9122251a3400','list_addresses','{}',NULL,16,NULL,'2026-10-06 12:54:25');
INSERT INTO `agent_tool_call` VALUES (18,'3972323a7e634d28a56d9122251a3400','prepare_order','{\"specId\": 1, \"quantity\": 1, \"addressId\": 1, \"productId\": 1}',NULL,58,NULL,'2026-10-06 12:54:27');
INSERT INTO `agent_tool_call` VALUES (19,'82451f33f32d4a83bf727eafc42a4221','search_tea','{\"keyword\": \"明前龙井\"}',NULL,18,NULL,'2026-10-06 12:55:32');
INSERT INTO `agent_tool_call` VALUES (20,'82451f33f32d4a83bf727eafc42a4221','get_tea_detail','{\"productId\": 1}',NULL,15,NULL,'2026-10-06 12:55:34');
INSERT INTO `agent_tool_call` VALUES (21,'82451f33f32d4a83bf727eafc42a4221','list_addresses','{}',NULL,11,NULL,'2026-10-06 12:55:34');
INSERT INTO `agent_tool_call` VALUES (22,'82451f33f32d4a83bf727eafc42a4221','prepare_order','{\"specId\": 2, \"quantity\": 1, \"addressId\": 1, \"productId\": 1}',NULL,37,NULL,'2026-10-06 12:55:36');
INSERT INTO `agent_tool_call` VALUES (23,'ff9df59497a048feba8ae7f28c2be0a0','search_tea','{\"keyword\": \"明前龙井\"}',NULL,14,NULL,'2026-10-06 12:55:40');
INSERT INTO `agent_tool_call` VALUES (24,'ff9df59497a048feba8ae7f28c2be0a0','get_tea_detail','{\"productId\": 1}',NULL,17,NULL,'2026-10-06 12:55:41');
INSERT INTO `agent_tool_call` VALUES (25,'ff9df59497a048feba8ae7f28c2be0a0','list_addresses','{}',NULL,9,NULL,'2026-10-06 12:55:43');
INSERT INTO `agent_tool_call` VALUES (26,'ff9df59497a048feba8ae7f28c2be0a0','prepare_order','{\"specId\": 2, \"quantity\": 1, \"addressId\": 1, \"productId\": 1}',NULL,34,NULL,'2026-10-06 12:55:45');
INSERT INTO `agent_tool_call` VALUES (27,'51b77a807703491184f28f1d4f2b4521','search_tea','{\"keyword\": \"明前龙井\"}',NULL,16,NULL,'2026-10-06 12:59:30');
INSERT INTO `agent_tool_call` VALUES (28,'51b77a807703491184f28f1d4f2b4521','list_addresses','{}',NULL,20,NULL,'2026-10-06 12:59:30');
INSERT INTO `agent_tool_call` VALUES (29,'51b77a807703491184f28f1d4f2b4521','prepare_order','{\"quantity\": 1, \"addressId\": 1, \"productId\": 1}',NULL,51,NULL,'2026-10-06 12:59:31');
INSERT INTO `agent_tool_call` VALUES (30,'c07ab008cfdd48609890de2987f7e37c','confirm_order','{\"confirmToken\": \"bdc8eb2807d34539b1361fa0835304c7\"}',NULL,149,'c07ab008cfdd48609890de2987f7e37c:confirm_order','2026-10-06 12:59:36');
INSERT INTO `agent_tool_call` VALUES (31,'77f274af5bd3482c9a370f362b140436','search_tea','{\"keyword\": \"明前龙井\"}',NULL,12,NULL,'2026-10-06 13:00:37');
INSERT INTO `agent_tool_call` VALUES (32,'77f274af5bd3482c9a370f362b140436','list_addresses','{}',NULL,13,NULL,'2026-10-06 13:00:37');
INSERT INTO `agent_tool_call` VALUES (33,'77f274af5bd3482c9a370f362b140436','get_tea_detail','{\"productId\": 1}',NULL,17,NULL,'2026-10-06 13:00:39');
INSERT INTO `agent_tool_call` VALUES (34,'77f274af5bd3482c9a370f362b140436','prepare_order','{\"specId\": 2, \"quantity\": 1, \"addressId\": 1, \"productId\": 1}',NULL,51,NULL,'2026-10-06 13:00:41');
INSERT INTO `agent_tool_call` VALUES (35,'b67e42d079ed4c51b13d532b0623bd7e','confirm_order','{\"confirmToken\": \"e645a7fb4c164a149988626a345c3816\"}',NULL,108,'b67e42d079ed4c51b13d532b0623bd7e:confirm_order','2026-10-06 13:00:45');
INSERT INTO `agent_tool_call` VALUES (36,'991b98212136419ba3ee95a20b200afd','search_tea','{\"keyword\": \"龙井\"}',NULL,37,NULL,'2026-10-06 14:07:05');
INSERT INTO `agent_tool_call` VALUES (37,'a1d09bd2a5b9410092dbd0205fa30cb1','search_tea','{\"keyword\": \"明前龙井\"}',NULL,13,NULL,'2026-10-06 14:07:35');
INSERT INTO `agent_tool_call` VALUES (38,'a1d09bd2a5b9410092dbd0205fa30cb1','get_tea_detail','{\"productId\": 1}',NULL,25,NULL,'2026-10-06 14:07:36');
INSERT INTO `agent_tool_call` VALUES (39,'a8ce5f6c077f43809b79408f17f39d2d','search_tea','{\"keyword\": \"明前龙井\"}',NULL,18,NULL,'2026-10-06 14:08:05');
INSERT INTO `agent_tool_call` VALUES (40,'a8ce5f6c077f43809b79408f17f39d2d','get_tea_detail','{\"productId\": 1}',NULL,14,NULL,'2026-10-06 14:08:07');
INSERT INTO `agent_tool_call` VALUES (41,'31eb8f55a1bd486db8fc28242a67b457','search_tea','{\"keyword\": \"明前龙井\"}',NULL,21,NULL,'2026-10-06 14:09:47');
INSERT INTO `agent_tool_call` VALUES (42,'31eb8f55a1bd486db8fc28242a67b457','add_to_cart','{\"specId\": 1, \"quantity\": 1, \"productId\": 1}',NULL,322,'31eb8f55a1bd486db8fc28242a67b457:add_to_cart','2026-10-06 14:09:49');
INSERT INTO `agent_tool_call` VALUES (43,'bdedac9cb58e4475ac2e71c82c107a9a','search_tea','{\"keyword\": \"明前龙井\"}',NULL,17,NULL,'2026-10-06 14:09:53');
INSERT INTO `agent_tool_call` VALUES (44,'02f5d4d7172045e489acd121e86eed98','search_tea','{\"keyword\": \"绿茶\"}',NULL,19,NULL,'2026-10-06 14:11:20');
INSERT INTO `agent_tool_call` VALUES (45,'5ccd3faed9d2490e955c61bf3cb1041d','search_tea','{\"keyword\": \"明前龙井\"}',NULL,144,NULL,'2026-10-06 14:14:57');
INSERT INTO `agent_tool_call` VALUES (46,'5ccd3faed9d2490e955c61bf3cb1041d','get_tea_detail','{\"productId\": 1}',NULL,19,NULL,'2026-10-06 14:14:58');
INSERT INTO `agent_tool_call` VALUES (47,'5ccd3faed9d2490e955c61bf3cb1041d','add_to_cart','{\"specId\": 2, \"quantity\": 1, \"productId\": 1}',NULL,33,'5ccd3faed9d2490e955c61bf3cb1041d:add_to_cart','2026-10-06 14:14:59');
INSERT INTO `agent_tool_call` VALUES (48,'b8e03c41939d41aab4aa11bd9d1dac84','search_tea','{\"keyword\": \"绿茶\"}',NULL,20,NULL,'2026-10-06 14:15:04');
INSERT INTO `agent_tool_call` VALUES (49,'d048c340e4bc47b6a0595a79f9437323','list_categories','{}',NULL,17,NULL,'2026-10-06 14:15:58');
INSERT INTO `agent_tool_call` VALUES (50,'7f40aaa2d852426687d691f54bd7fa0b','list_themes','{}',NULL,10,NULL,'2026-10-06 14:16:01');
INSERT INTO `agent_tool_call` VALUES (51,'7c2193a2e1f246eba413a557c020e29b','list_orders','{}',NULL,25,NULL,'2026-10-06 14:16:06');
INSERT INTO `agent_tool_call` VALUES (52,'16f02ac2ee1b4cfe8abab00565e2bba6','list_coupons','{}',NULL,9,NULL,'2026-10-06 14:16:11');
INSERT INTO `agent_tool_call` VALUES (53,'ab026637277044259d7eb278c68afd50','list_addresses','{}',NULL,10,NULL,'2026-10-06 14:16:14');
INSERT INTO `agent_tool_call` VALUES (54,'23410038743a40cbbe7e418cac83ea96','view_cart','{}',NULL,14,NULL,'2026-10-06 14:16:18');
INSERT INTO `agent_tool_call` VALUES (55,'ddd119bddf8f48049e108efe1b369475','search_tea','{\"keyword\": \"绿茶\"}',NULL,23,NULL,'2026-10-06 14:29:30');
INSERT INTO `agent_tool_call` VALUES (56,'bb437949e6ee481da07ca603fcfb68cc','search_tea','{\"keyword\": \"绿茶\"}',NULL,32,NULL,'2026-10-06 14:29:30');
INSERT INTO `agent_tool_call` VALUES (57,'cb4c6620a00047ae9cf089cc4bd17f0b','search_tea','{\"keyword\": \"绿茶\"}',NULL,22,NULL,'2026-10-06 14:37:42');
INSERT INTO `agent_tool_call` VALUES (58,'c40ab19c297241b09e206ee8cf42df04','search_tea','{\"keyword\": \"绿茶\"}',NULL,158,NULL,'2026-10-06 23:19:56');
INSERT INTO `agent_tool_call` VALUES (59,'e4890dcfc6fa419d8aa5f6e1f2bbe50f','search_tea','{\"keyword\": \"绿茶\"}',NULL,571,NULL,'2026-10-06 23:56:50');
INSERT INTO `agent_tool_call` VALUES (60,'73fa031b0e714b439f881f3228a3d394','search_tea','{\"keyword\": \"绿茶\"}',NULL,31,NULL,'2026-10-06 23:56:51');
INSERT INTO `agent_tool_call` VALUES (61,'78b0c2ce349347578b44a210e01258e4','search_tea','{\"keyword\": \"绿茶\"}',NULL,8,NULL,'2026-10-07 00:01:34');
INSERT INTO `agent_tool_call` VALUES (62,'33b25b9b6a4a48e1a3c3ca0ecd70663b','search_tea','{\"keyword\": \"绿茶\"}',NULL,3,NULL,'2026-10-07 00:01:51');
INSERT INTO `agent_tool_call` VALUES (63,'b9f9c37d08a2413eaf16a353acdb7a38','search_tea','{\"keyword\": \"绿茶\"}',NULL,6,NULL,'2026-10-07 00:04:41');
INSERT INTO `agent_tool_call` VALUES (64,'e0910f29fdf9439082f109ec3b0c074f','search_tea','{\"keyword\": \"绿茶\"}',NULL,357,NULL,'2026-10-07 00:07:56');
INSERT INTO `agent_tool_call` VALUES (65,'9cedec4c357142e7bc7ebbd2d7c74a02','search_tea','{\"keyword\": \"绿茶\"}',NULL,29,NULL,'2026-10-07 00:20:04');
INSERT INTO `agent_tool_call` VALUES (66,'23d4fbbc3db24b398695c62529f1fd24','search_tea','{\"keyword\": \"绿茶\"}',NULL,5,NULL,'2026-10-07 00:20:16');
INSERT INTO `agent_tool_call` VALUES (67,'bf18083f772640c8aebdd0a280062a82','search_tea','{\"keyword\": \"绿茶\"}',NULL,252,NULL,'2026-10-07 00:21:06');
INSERT INTO `agent_tool_call` VALUES (68,'f58238b1788e4c44bf9ab4af87353e46','get_tea_detail','{\"productId\": 2002}',NULL,56,NULL,'2026-10-07 00:21:34');
INSERT INTO `agent_tool_call` VALUES (69,'8995025f182241b1a1335d2336e69651','list_categories','{}',NULL,21,NULL,'2026-10-07 00:25:01');
INSERT INTO `agent_tool_call` VALUES (70,'8995025f182241b1a1335d2336e69651','search_tea','{\"keyword\": \"绿茶\"}',NULL,32,NULL,'2026-10-07 00:25:01');
INSERT INTO `agent_tool_call` VALUES (71,'08696fa9070d41c890628dd15a4b803e','search_tea','{\"keyword\": \"武功山云雾\"}',NULL,20,NULL,'2026-10-07 00:25:06');
INSERT INTO `agent_tool_call` VALUES (72,'41077ad6e1484714beae55da5ac7135f','get_tea_detail','{\"productId\": 2002}',NULL,35,NULL,'2026-10-07 00:26:41');
INSERT INTO `agent_tool_call` VALUES (73,'2c4b2629f5ce4b768f811c9c16bc3a86','get_tea_detail','{\"productId\": 2002}',NULL,152,NULL,'2026-10-07 00:28:25');
INSERT INTO `agent_tool_call` VALUES (74,'0bd588c3d5a14970b642f5e93e749121','search_tea','{\"keyword\": \"明前龙井\"}',NULL,25,NULL,'2026-10-07 00:37:10');
INSERT INTO `agent_tool_call` VALUES (75,'0bd588c3d5a14970b642f5e93e749121','search_tea','{\"keyword\": \"狗牯脑茶\"}',NULL,18,NULL,'2026-10-07 00:37:10');
INSERT INTO `agent_tool_call` VALUES (76,'0bd588c3d5a14970b642f5e93e749121','search_tea','{\"keyword\": \"井冈翠绿\"}',NULL,17,NULL,'2026-10-07 00:37:10');
INSERT INTO `agent_tool_call` VALUES (77,'dd15cac7d6f54477a99a8d4a6b59e74b','search_tea','{\"keyword\": \"绿茶\"}',NULL,70,NULL,'2026-10-07 15:08:20');
INSERT INTO `agent_tool_call` VALUES (78,'a79474c1a6cd41bfb76e12984a08856f','list_addresses','{}',NULL,44,NULL,'2026-10-07 15:09:30');
INSERT INTO `agent_tool_call` VALUES (79,'43c7ce28a2f94b83aa6e75e9c45378f2','search_tea','{\"keyword\": \"龙井\"}',NULL,31,NULL,'2026-10-07 15:14:57');
INSERT INTO `agent_tool_call` VALUES (80,'b5fc01225add4950b85ad80fe05bc934','search_tea','{\"keyword\": \"龙井\"}',NULL,3,NULL,'2026-10-07 15:54:31');
INSERT INTO `agent_tool_call` VALUES (81,'7923ccbbc28040e0bb9af50b16b9914a','search_tea','{\"keyword\": \"大红袍\"}',NULL,48,NULL,'2026-10-07 16:14:47');
INSERT INTO `agent_tool_call` VALUES (82,'7923ccbbc28040e0bb9af50b16b9914a','search_tea','{\"keyword\": \"普洱茶\"}',NULL,40,NULL,'2026-10-07 16:14:47');
INSERT INTO `agent_tool_call` VALUES (83,'7923ccbbc28040e0bb9af50b16b9914a','search_tea','{\"keyword\": \"碧螺春\"}',NULL,29,NULL,'2026-10-07 16:14:47');
INSERT INTO `agent_tool_call` VALUES (84,'3e7eb5ae76144cf98a7991bb67631f64','search_tea','{\"keyword\": \"明前龙井\"}',NULL,34,NULL,'2026-10-07 16:39:14');
INSERT INTO `agent_tool_call` VALUES (85,'3e7eb5ae76144cf98a7991bb67631f64','get_tea_detail','{\"productId\": 1}',NULL,97,NULL,'2026-10-07 16:39:16');
INSERT INTO `agent_tool_call` VALUES (86,'3e7eb5ae76144cf98a7991bb67631f64','list_addresses','{}',NULL,15,NULL,'2026-10-07 16:39:16');
INSERT INTO `agent_tool_call` VALUES (87,'6039f14f4f504d0383b5309909548a3d','list_addresses','{}',NULL,14,NULL,'2026-10-07 16:40:42');
INSERT INTO `agent_tool_call` VALUES (88,'6039f14f4f504d0383b5309909548a3d','search_tea','{\"keyword\": \"明前龙井\"}',NULL,28,NULL,'2026-10-07 16:40:42');
INSERT INTO `agent_tool_call` VALUES (89,'6039f14f4f504d0383b5309909548a3d','get_tea_detail','{\"productId\": 1}',NULL,38,NULL,'2026-10-07 16:40:44');
INSERT INTO `agent_tool_call` VALUES (90,'54c98c447ef34d4e85c222972538c38d','add_to_cart','{\"specId\": 3, \"quantity\": 1, \"productId\": 1}',NULL,135,'54c98c447ef34d4e85c222972538c38d:add_to_cart','2026-10-07 16:42:04');
INSERT INTO `agent_tool_call` VALUES (91,'3dcd0d8daf124cab8591884c203f8854','search_tea','{\"keyword\": \"明前龙井 礼盒\"}',NULL,6,NULL,'2026-10-07 16:47:13');
INSERT INTO `agent_tool_call` VALUES (92,'de92a7a1755c432f9dac725497ac5d66','add_address','{\"city\": \"南昌市\", \"name\": \"qq\", \"phone\": \"13900000012\", \"detail\": \"南昌大学\", \"district\": \"南昌大学\", \"province\": \"江西省\"}',NULL,106,'de92a7a1755c432f9dac725497ac5d66:add_address','2026-10-07 16:49:24');
INSERT INTO `agent_tool_call` VALUES (93,'de92a7a1755c432f9dac725497ac5d66','search_tea','{\"keyword\": \"明前龙井 礼盒\"}',NULL,51,NULL,'2026-10-07 16:49:24');
INSERT INTO `agent_tool_call` VALUES (94,'de92a7a1755c432f9dac725497ac5d66','search_tea','{\"keyword\": \"明前龙井\"}',NULL,24,NULL,'2026-10-07 16:49:26');
INSERT INTO `agent_tool_call` VALUES (95,'de92a7a1755c432f9dac725497ac5d66','search_tea','{\"keyword\": \"龙井 礼盒装\"}',NULL,27,NULL,'2026-10-07 16:49:26');
INSERT INTO `agent_tool_call` VALUES (96,'de92a7a1755c432f9dac725497ac5d66','get_tea_detail','{\"productId\": 1}',NULL,51,NULL,'2026-10-07 16:49:28');
INSERT INTO `agent_tool_call` VALUES (97,'1e93c3dce2104977a156c93d100b62a3','add_address','{\"city\": \"南昌市\", \"name\": \"qq\", \"phone\": \"13900000012\", \"detail\": \"南昌大学\", \"district\": \"南昌大学\", \"province\": \"江西省\"}',NULL,85,'1e93c3dce2104977a156c93d100b62a3:add_address','2026-10-07 16:51:06');
INSERT INTO `agent_tool_call` VALUES (98,'1e93c3dce2104977a156c93d100b62a3','search_tea','{\"keyword\": \"明前龙井 礼盒\"}',NULL,171,NULL,'2026-10-07 16:51:06');
INSERT INTO `agent_tool_call` VALUES (99,'1e93c3dce2104977a156c93d100b62a3','search_tea','{\"keyword\": \"明前龙井\"}',NULL,28,NULL,'2026-10-07 16:51:07');
INSERT INTO `agent_tool_call` VALUES (100,'1e93c3dce2104977a156c93d100b62a3','list_addresses','{}',NULL,22,NULL,'2026-10-07 16:51:07');
INSERT INTO `agent_tool_call` VALUES (101,'1e93c3dce2104977a156c93d100b62a3','get_tea_detail','{\"productId\": 1}',NULL,44,NULL,'2026-10-07 16:51:09');
INSERT INTO `agent_tool_call` VALUES (102,'1e93c3dce2104977a156c93d100b62a3','prepare_order','{\"specId\": 3, \"quantity\": 1, \"addressId\": 22, \"productId\": 1}',NULL,72,NULL,'2026-10-07 16:51:11');
INSERT INTO `agent_tool_call` VALUES (103,'7f7a6b462f45419ea89d7fd9348b8a92','confirm_order','{\"confirmToken\": \"ec1a8197d5364798bd465ca648a790e7\"}',NULL,367,'7f7a6b462f45419ea89d7fd9348b8a92:confirm_order','2026-10-07 16:51:44');
INSERT INTO `agent_tool_call` VALUES (104,'6a0731bd84204130b68624aba9f8fadf','search_tea','{\"keyword\": \"明前龙井\"}',NULL,152,NULL,'2026-10-07 16:55:03');
INSERT INTO `agent_tool_call` VALUES (105,'9be9205007fb4cb8a7bdf073f2b39ca5','search_tea','{\"keyword\": \"明前龙井\"}',NULL,35,NULL,'2026-10-07 16:55:25');
INSERT INTO `agent_tool_call` VALUES (106,'9be9205007fb4cb8a7bdf073f2b39ca5','add_address','{\"city\": \"南昌市\", \"name\": \"qq\", \"phone\": \"13900000012\", \"detail\": \"南昌大学\", \"district\": \"红谷滩区\", \"province\": \"江西省\"}',NULL,56,'9be9205007fb4cb8a7bdf073f2b39ca5:add_address','2026-10-07 16:55:25');
INSERT INTO `agent_tool_call` VALUES (107,'9be9205007fb4cb8a7bdf073f2b39ca5','get_tea_detail','{\"productId\": 1}',NULL,46,NULL,'2026-10-07 16:55:27');
INSERT INTO `agent_tool_call` VALUES (108,'9be9205007fb4cb8a7bdf073f2b39ca5','list_addresses','{}',NULL,17,NULL,'2026-10-07 16:55:27');
INSERT INTO `agent_tool_call` VALUES (109,'9be9205007fb4cb8a7bdf073f2b39ca5','prepare_order','{\"specId\": 3, \"quantity\": 1, \"addressId\": 23, \"productId\": 1}',NULL,53,NULL,'2026-10-07 16:55:30');
INSERT INTO `agent_tool_call` VALUES (110,'5b2cb8caf8654d3eba4bd54712a9316f','search_tea','{\"keyword\": \"明前龙井 礼盒\"}',NULL,20,NULL,'2026-10-07 16:55:35');
INSERT INTO `agent_tool_call` VALUES (111,'5b2cb8caf8654d3eba4bd54712a9316f','list_addresses','{}',NULL,22,NULL,'2026-10-07 16:55:35');
INSERT INTO `agent_tool_call` VALUES (112,'5b2cb8caf8654d3eba4bd54712a9316f','search_tea','{\"keyword\": \"明前龙井\"}',NULL,21,NULL,'2026-10-07 16:55:38');
INSERT INTO `agent_tool_call` VALUES (113,'5b2cb8caf8654d3eba4bd54712a9316f','get_tea_detail','{\"productId\": 1}',NULL,38,NULL,'2026-10-07 16:55:40');
INSERT INTO `agent_tool_call` VALUES (114,'5b2cb8caf8654d3eba4bd54712a9316f','prepare_order','{\"specId\": 3, \"quantity\": 1, \"addressId\": 23, \"productId\": 1}',NULL,53,NULL,'2026-10-07 16:55:43');
INSERT INTO `agent_tool_call` VALUES (115,'92dd0641b1a54e9a80efbb9a7e75d13d','search_tea','{\"keyword\": \"明前龙井\"}',NULL,177,NULL,'2026-10-07 16:58:48');
INSERT INTO `agent_tool_call` VALUES (116,'92dd0641b1a54e9a80efbb9a7e75d13d','list_addresses','{}',NULL,27,NULL,'2026-10-07 16:58:48');
INSERT INTO `agent_tool_call` VALUES (117,'82fb12052fdc430784a5978a292de475','prepare_order','{\"quantity\": 1, \"addressId\": 23, \"productId\": 1001}',NULL,159,NULL,'2026-10-07 17:03:00');
INSERT INTO `agent_tool_call` VALUES (118,'82fb12052fdc430784a5978a292de475','search_tea','{\"keyword\": \"明前龙井\"}',NULL,30,NULL,'2026-10-07 17:03:01');
INSERT INTO `agent_tool_call` VALUES (119,'82fb12052fdc430784a5978a292de475','prepare_order','{\"quantity\": 1, \"addressId\": 23, \"productId\": 1}',NULL,64,NULL,'2026-10-07 17:03:03');
INSERT INTO `agent_tool_call` VALUES (120,'eaaad5eb489c4c56899c017d6353c96f','confirm_order','{\"confirmToken\": \"5daed53f4e034f6ebaaaee2d92a04120\"}',NULL,0,'eaaad5eb489c4c56899c017d6353c96f:confirm_order','2026-10-07 17:03:07');
INSERT INTO `agent_tool_call` VALUES (121,'c3a8481cc0a14a3284d1dbf497c90d40','add_address','{\"city\": \"厦门市\", \"name\": \"测试\", \"phone\": \"13800138000\", \"detail\": \"软件园二期\", \"district\": \"思明区\", \"province\": \"福建省\"}',NULL,74,'c3a8481cc0a14a3284d1dbf497c90d40:add_address','2026-10-07 21:35:15');
INSERT INTO `agent_tool_call` VALUES (122,'c3a8481cc0a14a3284d1dbf497c90d40','search_tea','{\"keyword\": \"明前龙井\"}',NULL,33,NULL,'2026-10-07 21:35:15');
INSERT INTO `agent_tool_call` VALUES (123,'c3a8481cc0a14a3284d1dbf497c90d40','get_tea_detail','{\"productId\": 1}',NULL,44,NULL,'2026-10-07 21:35:17');
INSERT INTO `agent_tool_call` VALUES (124,'c3a8481cc0a14a3284d1dbf497c90d40','list_addresses','{}',NULL,14,NULL,'2026-10-07 21:35:17');
INSERT INTO `agent_tool_call` VALUES (125,'a1e6e66297f145a9b427ae25cd2d445e','search_tea','{\"keyword\": \"明前龙井\"}',NULL,17,NULL,'2026-10-07 21:35:57');
INSERT INTO `agent_tool_call` VALUES (126,'a1e6e66297f145a9b427ae25cd2d445e','get_tea_detail','{\"productId\": 1}',NULL,26,NULL,'2026-10-07 21:35:58');
INSERT INTO `agent_tool_call` VALUES (127,'a1e6e66297f145a9b427ae25cd2d445e','add_address','{\"city\": \"厦门市\", \"name\": \"测试\", \"phone\": \"13800138000\", \"detail\": \"软件园二期\", \"district\": \"思明区\", \"province\": \"福建省\"}',NULL,185,'a1e6e66297f145a9b427ae25cd2d445e:add_address','2026-10-07 21:36:00');
INSERT INTO `agent_tool_call` VALUES (128,'a1e6e66297f145a9b427ae25cd2d445e','prepare_order','{\"specId\": 3, \"quantity\": 1, \"addressId\": 24, \"productId\": 1}',NULL,45,NULL,'2026-10-07 21:36:02');
INSERT INTO `agent_tool_call` VALUES (129,'4afbcd9edb0343a385882f905f57a713','confirm_order','{\"confirmToken\": \"e59f3529e141445fb372159a284fb2d8\"}',NULL,0,'4afbcd9edb0343a385882f905f57a713:confirm_order','2026-10-07 21:37:01');
INSERT INTO `agent_tool_call` VALUES (130,'6d64e56929cb41b8b7225887276b90d9','search_tea','{\"keyword\": \"绿茶\"}',NULL,84,NULL,'2026-10-08 11:34:15');
INSERT INTO `agent_tool_call` VALUES (131,'e4287191bc684cd6b339941325e472fc','get_tea_detail','{\"productId\": 101}',NULL,26,NULL,'2026-10-08 11:34:52');
INSERT INTO `agent_tool_call` VALUES (132,'e4287191bc684cd6b339941325e472fc','list_addresses','{}',NULL,51,NULL,'2026-10-08 11:34:52');
INSERT INTO `agent_tool_call` VALUES (133,'e4287191bc684cd6b339941325e472fc','search_tea','{\"keyword\": \"武功山云雾\"}',NULL,40,NULL,'2026-10-08 11:34:54');
INSERT INTO `agent_tool_call` VALUES (134,'e4287191bc684cd6b339941325e472fc','get_tea_detail','{\"productId\": 4}',NULL,96,NULL,'2026-10-08 11:34:56');
INSERT INTO `agent_tool_call` VALUES (135,'3ac85aa5e5fc4f0fb7870d1de87c7ab8','add_address','{\"city\": \"南昌市\", \"name\": \"qq\", \"phone\": \"13900000012\", \"detail\": \"南昌大学\", \"district\": \"南昌大学\", \"province\": \"江西省\"}',NULL,204,'3ac85aa5e5fc4f0fb7870d1de87c7ab8:add_address','2026-10-08 11:50:22');
INSERT INTO `agent_tool_call` VALUES (136,'389de585098e453ebe7abfae5fffe573','prepare_order','{\"specId\": 3, \"quantity\": 1, \"addressId\": 1, \"productId\": 2}',NULL,71,NULL,'2026-10-08 11:50:32');
INSERT INTO `agent_tool_call` VALUES (137,'389de585098e453ebe7abfae5fffe573','get_tea_detail','{\"productId\": 2}',NULL,52,NULL,'2026-10-08 11:50:33');
INSERT INTO `agent_tool_call` VALUES (138,'389de585098e453ebe7abfae5fffe573','prepare_order','{\"specId\": 4, \"quantity\": 1, \"addressId\": 1, \"productId\": 2}',NULL,75,NULL,'2026-10-08 11:50:35');
INSERT INTO `agent_tool_call` VALUES (139,'389de585098e453ebe7abfae5fffe573','prepare_order','{\"specId\": 4, \"quantity\": 1, \"productId\": 2}',NULL,60,NULL,'2026-10-08 11:50:37');
INSERT INTO `agent_tool_call` VALUES (140,'42bba884ce20431bace1f63c509f609f','prepare_order','{\"specId\": 301, \"quantity\": 1, \"addressId\": 1, \"productId\": 3}',NULL,51,NULL,'2026-10-08 11:51:06');
INSERT INTO `agent_tool_call` VALUES (141,'42bba884ce20431bace1f63c509f609f','search_tea','{\"keyword\": \"武功山云雾\"}',NULL,22,NULL,'2026-10-08 11:51:08');
INSERT INTO `agent_tool_call` VALUES (142,'42bba884ce20431bace1f63c509f609f','search_tea','{\"keyword\": \"狗牯脑\"}',NULL,26,NULL,'2026-10-08 11:51:08');
INSERT INTO `agent_tool_call` VALUES (143,'10164ebaf9b1431dbd63bf4e98134458','search_tea','{\"keyword\": \"武功山云雾\"}',NULL,59,NULL,'2026-10-08 12:05:29');
INSERT INTO `agent_tool_call` VALUES (144,'119c3052ad2749599506048b341dc158','add_address','{\"city\": \"南昌市\", \"name\": \"qq\", \"phone\": \"13900000012\", \"detail\": \"南昌大学\", \"district\": \"南昌大学\", \"province\": \"江西省\"}',NULL,78,'119c3052ad2749599506048b341dc158:add_address','2026-10-08 12:05:58');
INSERT INTO `agent_tool_call` VALUES (145,'119c3052ad2749599506048b341dc158','search_tea','{\"keyword\": \"武功山云雾\"}',NULL,29,NULL,'2026-10-08 12:05:59');
INSERT INTO `agent_tool_call` VALUES (146,'119c3052ad2749599506048b341dc158','prepare_order','{\"specId\": 9, \"quantity\": 1, \"addressId\": 1, \"productId\": 4}',NULL,50,NULL,'2026-10-08 12:06:01');
INSERT INTO `agent_tool_call` VALUES (147,'119c3052ad2749599506048b341dc158','list_addresses','{}',NULL,27,NULL,'2026-10-08 12:06:03');
INSERT INTO `agent_tool_call` VALUES (148,'f911477690c642a895d07381b563e03b','add_address','{\"city\": \"南昌市\", \"name\": \"qq\", \"phone\": \"13900000012\", \"detail\": \"南昌大学\", \"district\": \"南昌大学\", \"province\": \"江西省\"}',NULL,11,'f911477690c642a895d07381b563e03b:add_address','2026-10-08 12:06:20');
INSERT INTO `agent_tool_call` VALUES (149,'f911477690c642a895d07381b563e03b','prepare_order','{\"quantity\": 1, \"addressId\": 26, \"productId\": 0}',NULL,0,NULL,'2026-10-08 12:06:22');
INSERT INTO `agent_tool_call` VALUES (150,'f911477690c642a895d07381b563e03b','search_tea','{\"keyword\": \"武功山云雾\"}',NULL,16,NULL,'2026-10-08 12:06:24');
INSERT INTO `agent_tool_call` VALUES (151,'f911477690c642a895d07381b563e03b','prepare_order','{\"specId\": 9, \"quantity\": 1, \"addressId\": 26, \"productId\": 4}',NULL,52,NULL,'2026-10-08 12:06:26');
INSERT INTO `agent_tool_call` VALUES (152,'7a726bee6aca4ede8cd611e1f748310c','confirm_order','{\"confirmToken\": \"fdfbfe27ec684a2ba10f79f83724618d\"}',NULL,0,'7a726bee6aca4ede8cd611e1f748310c:confirm_order','2026-10-08 12:06:38');
INSERT INTO `agent_tool_call` VALUES (153,'df8f84b43b224cbd8fc20fcc40271e96','add_address','{\"city\": \"南昌市\", \"name\": \"qq\", \"phone\": \"13900000012\", \"detail\": \"南昌大学\", \"district\": \"红谷滩区\", \"province\": \"江西省\"}',NULL,170,'df8f84b43b224cbd8fc20fcc40271e96:add_address','2026-10-08 12:10:29');
INSERT INTO `agent_tool_call` VALUES (154,'df8f84b43b224cbd8fc20fcc40271e96','search_tea','{\"keyword\": \"武功山云雾\"}',NULL,51,NULL,'2026-10-08 12:10:31');
INSERT INTO `agent_tool_call` VALUES (155,'df8f84b43b224cbd8fc20fcc40271e96','list_addresses','{}',NULL,15,NULL,'2026-10-08 12:10:33');
INSERT INTO `agent_tool_call` VALUES (156,'02cd87db4c324a10b0aff4203e305102','search_tea','{\"keyword\": \"武功山云雾\"}',NULL,42,NULL,'2026-10-08 12:13:13');
INSERT INTO `agent_tool_call` VALUES (157,'02cd87db4c324a10b0aff4203e305102','list_addresses','{}',NULL,18,NULL,'2026-10-08 12:13:15');
INSERT INTO `agent_tool_call` VALUES (158,'dc37b483518942309392d4f1257c0b47','search_tea','{\"keyword\": \"武功山云雾\"}',NULL,23,NULL,'2026-10-08 12:13:19');
INSERT INTO `agent_tool_call` VALUES (159,'dc37b483518942309392d4f1257c0b47','list_addresses','{}',NULL,51,NULL,'2026-10-08 12:13:21');
INSERT INTO `agent_tool_call` VALUES (160,'818b6f74c92e4f3dab2c0ee5870d6eb5','list_addresses','{}',NULL,13,NULL,'2026-10-08 12:14:47');
INSERT INTO `agent_tool_call` VALUES (161,'c9f765d0b77a40bbb4efb9ad43bd9bb4','add_address','{\"city\": \"南昌市\", \"name\": \"qq\", \"phone\": \"13900000012\", \"detail\": \"南昌大学\", \"district\": \"南昌大学\", \"province\": \"江西省\"}',NULL,10,'c9f765d0b77a40bbb4efb9ad43bd9bb4:add_address','2026-10-08 12:17:45');
INSERT INTO `agent_tool_call` VALUES (162,'c9f765d0b77a40bbb4efb9ad43bd9bb4','search_tea','{\"keyword\": \"武功山云雾\"}',NULL,49,NULL,'2026-10-08 12:17:45');
INSERT INTO `agent_tool_call` VALUES (163,'c9f765d0b77a40bbb4efb9ad43bd9bb4','prepare_order','{\"specId\": 9, \"quantity\": 1, \"addressId\": 26, \"productId\": 4}',NULL,60,NULL,'2026-10-08 12:17:47');
INSERT INTO `agent_tool_call` VALUES (164,'f8cd26cba7d7452ebb9907949a2c9c61','cancel_order','{\"confirmToken\": \"prepare_order\"}',NULL,3,'f8cd26cba7d7452ebb9907949a2c9c61:cancel_order','2026-10-08 12:17:51');
INSERT INTO `agent_tool_call` VALUES (165,'f8cd26cba7d7452ebb9907949a2c9c61','search_tea','{\"keyword\": \"武功山云雾\"}',NULL,15,NULL,'2026-10-08 12:17:53');
INSERT INTO `agent_tool_call` VALUES (166,'f8cd26cba7d7452ebb9907949a2c9c61','list_addresses','{}',NULL,20,NULL,'2026-10-08 12:17:53');
INSERT INTO `agent_tool_call` VALUES (167,'35566b3b940549cf85cd94b8fe8c8ecf','search_tea','{\"keyword\": \"武功山云雾\"}',NULL,22,NULL,'2026-10-08 12:17:55');
INSERT INTO `agent_tool_call` VALUES (168,'35566b3b940549cf85cd94b8fe8c8ecf','add_address','{\"city\": \"南昌市\", \"name\": \"qq\", \"phone\": \"13900000012\", \"detail\": \"南昌大学\", \"district\": \"青山湖区\", \"province\": \"江西省\"}',NULL,50,'35566b3b940549cf85cd94b8fe8c8ecf:add_address','2026-10-08 12:17:57');
INSERT INTO `agent_tool_call` VALUES (169,'35566b3b940549cf85cd94b8fe8c8ecf','list_addresses','{}',NULL,11,NULL,'2026-10-08 12:17:58');
INSERT INTO `agent_tool_call` VALUES (170,'3cb0a25febb94ea1bf6d72b5af814413','search_tea','{\"keyword\": \"武功山云雾\"}',NULL,13,NULL,'2026-10-08 12:18:00');
INSERT INTO `agent_tool_call` VALUES (171,'3cb0a25febb94ea1bf6d72b5af814413','add_address','{\"city\": \"南昌市\", \"name\": \"qq\", \"phone\": \"13900000012\", \"detail\": \"南昌大学\", \"district\": \"青山湖区\", \"province\": \"江西省\"}',NULL,53,'3cb0a25febb94ea1bf6d72b5af814413:add_address','2026-10-08 12:18:02');
INSERT INTO `agent_tool_call` VALUES (172,'3cb0a25febb94ea1bf6d72b5af814413','prepare_order','{\"specId\": 9, \"quantity\": 1, \"addressId\": 28, \"productId\": 4}',NULL,35,NULL,'2026-10-08 12:18:04');
INSERT INTO `agent_tool_call` VALUES (173,'fc6d4558af80433893e4559a50096d26','search_tea','{\"keyword\": \"武功山云雾\"}',NULL,13,NULL,'2026-10-08 12:18:08');
INSERT INTO `agent_tool_call` VALUES (174,'fc6d4558af80433893e4559a50096d26','add_address','{\"city\": \"南昌市\", \"name\": \"qq\", \"phone\": \"13900000012\", \"detail\": \"南昌大学\", \"district\": \"青山湖区\", \"province\": \"江西省\"}',NULL,10,'fc6d4558af80433893e4559a50096d26:add_address','2026-10-08 12:18:10');
INSERT INTO `agent_tool_call` VALUES (175,'fc6d4558af80433893e4559a50096d26','prepare_order','{\"specId\": 9, \"quantity\": 1, \"addressId\": 28, \"productId\": 4}',NULL,48,NULL,'2026-10-08 12:18:12');
INSERT INTO `agent_tool_call` VALUES (176,'fd45fec505294702840814586bcd0fd6','search_tea','{\"keyword\": \"武功山云雾\"}',NULL,12,NULL,'2026-10-08 12:18:34');
INSERT INTO `agent_tool_call` VALUES (177,'fd45fec505294702840814586bcd0fd6','prepare_order','{\"specId\": 9, \"quantity\": 1, \"productId\": 4}',NULL,87,NULL,'2026-10-08 12:18:36');
INSERT INTO `agent_tool_call` VALUES (178,'44ac9c3abe924035b4013585c4886883','confirm_order','{\"confirmToken\": \"146e641a29a1461e863ddafc9437612b\"}',NULL,0,'44ac9c3abe924035b4013585c4886883:confirm_order','2026-10-08 12:18:39');
INSERT INTO `agent_tool_call` VALUES (179,'c189439a48e54a8381427c3ac49123e1','search_tea','{\"keyword\": \"狗牯脑\"}',NULL,36,NULL,'2026-10-08 12:19:20');
INSERT INTO `agent_tool_call` VALUES (180,'5d974da8ced14b5ea96833881546c93f','search_tea','{\"keyword\": \"狗牯脑\"}',NULL,10,NULL,'2026-10-08 12:19:47');
INSERT INTO `agent_tool_call` VALUES (181,'5d974da8ced14b5ea96833881546c93f','list_addresses','{}',NULL,10,NULL,'2026-10-08 12:19:49');
INSERT INTO `agent_tool_call` VALUES (182,'64c12bc665784a9e92b017fc2fd40b74','search_tea','{\"keyword\": \"狗牯脑\"}',NULL,11,NULL,'2026-10-08 12:20:01');
INSERT INTO `agent_tool_call` VALUES (183,'64c12bc665784a9e92b017fc2fd40b74','list_addresses','{}',NULL,9,NULL,'2026-10-08 12:20:03');
INSERT INTO `agent_tool_call` VALUES (184,'ac649bdb1c664de6a4412d305920c2b1','search_tea','{\"keyword\": \"狗牯脑\"}',NULL,62,NULL,'2026-10-08 12:22:13');
INSERT INTO `agent_tool_call` VALUES (185,'ac649bdb1c664de6a4412d305920c2b1','list_addresses','{}',NULL,10,NULL,'2026-10-08 12:22:15');
INSERT INTO `agent_tool_call` VALUES (186,'2f6d7d4729f74829b61a51619ba289bd','search_tea','{\"keyword\": \"狗牯脑\"}',NULL,29,NULL,'2026-10-08 12:22:18');
INSERT INTO `agent_tool_call` VALUES (187,'2f6d7d4729f74829b61a51619ba289bd','prepare_order','{\"specId\": 4, \"quantity\": 1, \"productId\": 2}',NULL,45,NULL,'2026-10-08 12:22:20');
INSERT INTO `agent_tool_call` VALUES (188,'51b9007574f640a1aeb034ab94a9e2aa','confirm_order','{\"confirmToken\": \"6d67d58ddbd94101b577742e09b88bab\"}',NULL,0,'51b9007574f640a1aeb034ab94a9e2aa:confirm_order','2026-10-08 12:22:23');
INSERT INTO `agent_tool_call` VALUES (189,'8a582fd99b3b40758c0d1882dd25cf49','search_tea','{\"keyword\": \"普洱茶 品鉴装 50g\"}',NULL,14,NULL,'2026-10-08 12:22:36');
INSERT INTO `agent_tool_call` VALUES (190,'8a582fd99b3b40758c0d1882dd25cf49','search_tea','{\"keyword\": \"普洱茶\"}',NULL,69,NULL,'2026-10-08 12:22:38');
INSERT INTO `agent_tool_call` VALUES (191,'178cefeb64fe41878337d491d39dcc43','search_tea','{\"keyword\": \"狗牯脑\"}',NULL,11,NULL,'2026-10-08 12:22:52');
INSERT INTO `agent_tool_call` VALUES (192,'178cefeb64fe41878337d491d39dcc43','prepare_order','{\"specId\": 4, \"quantity\": 1, \"productId\": 2}',NULL,35,NULL,'2026-10-08 12:22:54');
INSERT INTO `agent_tool_call` VALUES (193,'d1e762e298864390970013850c4786d4','confirm_order','{\"confirmToken\": \"343d03f2278c49f39e37c22161ae1113\"}',NULL,0,'d1e762e298864390970013850c4786d4:confirm_order','2026-10-08 12:22:56');
INSERT INTO `agent_tool_call` VALUES (194,'49ccb0c221ab4b5b86a7fe57eb45db09','search_tea','{\"keyword\": \"狗牯脑\"}',NULL,11,NULL,'2026-10-08 12:23:15');
INSERT INTO `agent_tool_call` VALUES (195,'49ccb0c221ab4b5b86a7fe57eb45db09','prepare_order','{\"specId\": 4, \"quantity\": 1, \"productId\": 2}',NULL,39,NULL,'2026-10-08 12:23:16');
INSERT INTO `agent_tool_call` VALUES (196,'f2baff7f981c4b89aaea25c571af9e9b','confirm_order','{\"confirmToken\": \"6aa768d1f47148eeab8a04fb368cebf7\"}',NULL,0,'f2baff7f981c4b89aaea25c571af9e9b:confirm_order','2026-10-08 12:23:18');
INSERT INTO `agent_tool_call` VALUES (197,'3da8fd7ded6846428cdf91856311f293','search_tea','{\"keyword\": \"狗牯脑茶\"}',NULL,10,NULL,'2026-10-08 12:23:20');
INSERT INTO `agent_tool_call` VALUES (198,'3da8fd7ded6846428cdf91856311f293','prepare_order','{\"specId\": 4, \"quantity\": 1, \"productId\": 2}',NULL,42,NULL,'2026-10-08 12:23:23');
INSERT INTO `agent_tool_call` VALUES (199,'31b9299106d94832aeb3d04fb16bd296','confirm_order','{\"confirmToken\": \"14e71286d6624f72985ab9045204c87c\"}',NULL,0,'31b9299106d94832aeb3d04fb16bd296:confirm_order','2026-10-08 12:23:25');
INSERT INTO `agent_tool_call` VALUES (200,'2bed8a938d34425eb6e017b81ba2351c','search_tea','{\"keyword\": \"狗牯脑\"}',NULL,129,NULL,'2026-10-08 12:23:27');
INSERT INTO `agent_tool_call` VALUES (201,'2bed8a938d34425eb6e017b81ba2351c','prepare_order','{\"specId\": 4, \"quantity\": 1, \"productId\": 2}',NULL,38,NULL,'2026-10-08 12:23:29');
INSERT INTO `agent_tool_call` VALUES (202,'82aad1c64ada4542ab90e06dc04261b0','confirm_order','{\"confirmToken\": \"7e721f78c71f4ae9b02ccc2495fa0d75\"}',NULL,0,'82aad1c64ada4542ab90e06dc04261b0:confirm_order','2026-10-08 12:23:31');
INSERT INTO `agent_tool_call` VALUES (203,'c6e82c379c314b25900e3541df3a6eed','search_tea','{\"keyword\": \"狗牯脑\"}',NULL,14,NULL,'2026-10-08 12:23:43');
INSERT INTO `agent_tool_call` VALUES (204,'c6e82c379c314b25900e3541df3a6eed','list_addresses','{}',NULL,13,NULL,'2026-10-08 12:23:45');
INSERT INTO `agent_tool_call` VALUES (205,'34b55c6767b74f05b768cf1b1a99a172','search_tea','{\"keyword\": \"狗牯脑\"}',NULL,11,NULL,'2026-10-08 12:23:59');
INSERT INTO `agent_tool_call` VALUES (206,'34b55c6767b74f05b768cf1b1a99a172','list_addresses','{}',NULL,12,NULL,'2026-10-08 12:24:01');
INSERT INTO `agent_tool_call` VALUES (207,'b48d32511a4649b6a647c9bf424cf6fe','search_tea','{\"keyword\": \"狗牯脑\"}',NULL,16,NULL,'2026-10-08 12:24:05');
INSERT INTO `agent_tool_call` VALUES (208,'b48d32511a4649b6a647c9bf424cf6fe','list_addresses','{}',NULL,9,NULL,'2026-10-08 12:24:07');
INSERT INTO `agent_tool_call` VALUES (209,'7b5ea3a7d6fa406e992ff84c400da38d','search_tea','{\"keyword\": \"狗牯脑\"}',NULL,9,NULL,'2026-10-08 12:24:12');
INSERT INTO `agent_tool_call` VALUES (210,'7b5ea3a7d6fa406e992ff84c400da38d','prepare_order','{\"specId\": 4, \"quantity\": 1, \"productId\": 2}',NULL,32,NULL,'2026-10-08 12:24:14');
INSERT INTO `agent_tool_call` VALUES (211,'dd9783a29b1940ab81b6a08510e9973f','confirm_order','{\"confirmToken\": \"797e2f9a013a43e1912436fcfa5d33a5\"}',NULL,0,'dd9783a29b1940ab81b6a08510e9973f:confirm_order','2026-10-08 12:24:16');
INSERT INTO `agent_tool_call` VALUES (212,'a049723b11554b3fa06fbbac6df43a0f','search_tea','{\"keyword\": \"狗牯脑\"}',NULL,10,NULL,'2026-10-08 12:24:28');
INSERT INTO `agent_tool_call` VALUES (213,'a049723b11554b3fa06fbbac6df43a0f','prepare_order','{\"specId\": 4, \"quantity\": 1, \"productId\": 2}',NULL,33,NULL,'2026-10-08 12:24:30');
INSERT INTO `agent_tool_call` VALUES (214,'be1c29e63d174d8489b3842173c43fb2','confirm_order','{\"confirmToken\": \"69c1f71b8eac47acadd2a215d63e128a\"}',NULL,0,'be1c29e63d174d8489b3842173c43fb2:confirm_order','2026-10-08 12:24:32');
INSERT INTO `agent_tool_call` VALUES (215,'724668bd57a84978bda6baabb6b28c72','search_tea','{\"keyword\": \"狗牯脑\"}',NULL,42,NULL,'2026-10-08 12:25:54');
INSERT INTO `agent_tool_call` VALUES (216,'724668bd57a84978bda6baabb6b28c72','list_addresses','{}',NULL,13,NULL,'2026-10-08 12:25:55');
INSERT INTO `agent_tool_call` VALUES (217,'724668bd57a84978bda6baabb6b28c72','prepare_order','{\"specId\": 4, \"quantity\": 1, \"addressId\": 28, \"productId\": 2}',NULL,33,NULL,'2026-10-08 12:25:57');
INSERT INTO `agent_tool_call` VALUES (218,'36a90a170285483090784fbcac841f75','confirm_order','{\"confirmToken\": \"6b16db59d2974952adb0d899c75b2b99\"}',NULL,0,'36a90a170285483090784fbcac841f75:confirm_order','2026-10-08 12:26:00');
INSERT INTO `agent_tool_call` VALUES (219,'87ccdb2e05cb4841adda95163996f597','search_tea','{\"keyword\": \"狗牯脑\"}',NULL,17,NULL,'2026-10-08 12:26:02');
INSERT INTO `agent_tool_call` VALUES (220,'87ccdb2e05cb4841adda95163996f597','list_addresses','{}',NULL,10,NULL,'2026-10-08 12:26:04');
INSERT INTO `agent_tool_call` VALUES (221,'87ccdb2e05cb4841adda95163996f597','prepare_order','{\"specId\": 4, \"quantity\": 1, \"addressId\": 28, \"productId\": 2}',NULL,31,NULL,'2026-10-08 12:26:06');
INSERT INTO `agent_tool_call` VALUES (222,'50ca92d1c5584614922e9f2a87a773a3','confirm_order','{\"confirmToken\": \"cda242d35b234c63a38582e7f50a012c\"}',NULL,0,'50ca92d1c5584614922e9f2a87a773a3:confirm_order','2026-10-08 12:26:09');
INSERT INTO `agent_tool_call` VALUES (223,'059b078eb54549c3afa3fd795d4c4a26','search_tea','{\"keyword\": \"狗牯脑\"}',NULL,11,NULL,'2026-10-08 12:26:11');
INSERT INTO `agent_tool_call` VALUES (224,'059b078eb54549c3afa3fd795d4c4a26','list_addresses','{}',NULL,10,NULL,'2026-10-08 12:26:13');
INSERT INTO `agent_tool_call` VALUES (225,'10e76745280b40658f7746fd2b0db316','search_tea','{\"keyword\": \"狗牯脑\"}',NULL,9,NULL,'2026-10-08 12:26:48');
INSERT INTO `agent_tool_call` VALUES (226,'10e76745280b40658f7746fd2b0db316','prepare_order','{\"specId\": 4, \"quantity\": 1, \"productId\": 2}',NULL,28,NULL,'2026-10-08 12:26:50');
INSERT INTO `agent_tool_call` VALUES (227,'d2360a6bb1b44af09ca24a68c609e390','confirm_order','{\"confirmToken\": \"493875446b6046a992cd25aa298e1686\"}',NULL,0,'d2360a6bb1b44af09ca24a68c609e390:confirm_order','2026-10-08 12:26:53');
INSERT INTO `agent_tool_call` VALUES (228,'abf3504c17f5436bbb588da4ee076f4a','search_tea','{\"keyword\": \"雨前龙井\"}',NULL,40,NULL,'2026-10-08 14:43:24');
INSERT INTO `agent_tool_call` VALUES (229,'2db323f6d7844cc3b256e249b5fc49a0','search_tea','{\"keyword\": \"雨前龙井\"}',NULL,114,NULL,'2026-10-08 14:55:44');
INSERT INTO `agent_tool_call` VALUES (230,'563e542915c640f293f8cf4a640ba329','search_tea','{\"keyword\": \"明前龙井 品鉴装 50g\"}',NULL,28,NULL,'2026-10-08 14:56:00');
INSERT INTO `agent_tool_call` VALUES (231,'563e542915c640f293f8cf4a640ba329','search_tea','{\"keyword\": \"明前龙井\"}',NULL,20,NULL,'2026-10-08 14:56:09');
INSERT INTO `agent_tool_call` VALUES (232,'563e542915c640f293f8cf4a640ba329','request_address_pick','{}',NULL,19,NULL,'2026-10-08 14:56:11');
INSERT INTO `agent_tool_call` VALUES (233,'9757437af16a4538b0849c4ad9f3970e','search_tea','{\"keyword\": \"明前龙井\"}',NULL,18,NULL,'2026-10-08 14:56:29');
INSERT INTO `agent_tool_call` VALUES (234,'9757437af16a4538b0849c4ad9f3970e','request_address_pick','{}',NULL,13,NULL,'2026-10-08 14:56:31');
INSERT INTO `agent_tool_call` VALUES (235,'4fe521f4ed0f4066bf74cacfba24cd49','list_addresses','{}',NULL,18,NULL,'2026-10-08 14:56:36');
INSERT INTO `agent_tool_call` VALUES (236,'4fe521f4ed0f4066bf74cacfba24cd49','search_tea','{\"keyword\": \"明前龙井\"}',NULL,17,NULL,'2026-10-08 14:56:38');
INSERT INTO `agent_tool_call` VALUES (237,'4fe521f4ed0f4066bf74cacfba24cd49','prepare_order','{\"specId\": 1, \"quantity\": 1, \"addressId\": 28, \"productId\": 1}',NULL,68,NULL,'2026-10-08 14:56:41');
INSERT INTO `agent_tool_call` VALUES (238,'05f2724937ee4ee4abbc6ef9a40f9e7a','search_tea','{\"keyword\": \"明前龙井\"}',NULL,12,NULL,'2026-10-08 14:57:00');
INSERT INTO `agent_tool_call` VALUES (239,'05f2724937ee4ee4abbc6ef9a40f9e7a','request_address_pick','{}',NULL,34,NULL,'2026-10-08 14:57:02');
INSERT INTO `agent_tool_call` VALUES (240,'7b77a99e0ee74f139aa97ec759206305','list_addresses','{}',NULL,13,NULL,'2026-10-08 14:57:07');
INSERT INTO `agent_tool_call` VALUES (241,'aa6ddb3091fa4d92ae29c6c16b41e202','search_tea','{\"keyword\": \"明前龙井\"}',NULL,16,NULL,'2026-10-08 14:57:30');
INSERT INTO `agent_tool_call` VALUES (242,'aa6ddb3091fa4d92ae29c6c16b41e202','request_address_pick','{}',NULL,13,NULL,'2026-10-08 14:57:32');
INSERT INTO `agent_tool_call` VALUES (243,'e5abe8d967974c348653d6699b71b6fb','list_addresses','{}',NULL,22,NULL,'2026-10-08 14:57:36');
INSERT INTO `agent_tool_call` VALUES (244,'e7f408938406416f90d96e1b23c2d5e0','search_tea','{\"keyword\": \"明前龙井 品鉴装 50g\"}',NULL,40,NULL,'2026-10-08 14:59:47');
INSERT INTO `agent_tool_call` VALUES (245,'e7f408938406416f90d96e1b23c2d5e0','search_tea','{\"keyword\": \"明前龙井\"}',NULL,48,NULL,'2026-10-08 14:59:48');
INSERT INTO `agent_tool_call` VALUES (246,'e7f408938406416f90d96e1b23c2d5e0','search_tea','{\"keyword\": \"龙井\"}',NULL,21,NULL,'2026-10-08 14:59:48');
INSERT INTO `agent_tool_call` VALUES (247,'e9d89de4748b46c093d09829795c38d7','prepare_order','{\"specId\": 1, \"quantity\": 1, \"addressId\": 28, \"productId\": 1}',NULL,40,NULL,'2026-10-08 14:59:54');
INSERT INTO `agent_tool_call` VALUES (248,'d7f207ab98ff401a840f3d0335ed3614','confirm_order','{\"confirmToken\": \"b5f56e2124214fcdb6a282848d4fa057\"}',NULL,0,'d7f207ab98ff401a840f3d0335ed3614:confirm_order','2026-10-08 14:59:58');
INSERT INTO `agent_tool_call` VALUES (249,'770341d8c1ac486f92132ed05d3a3914','search_tea','{\"keyword\": \"明前龙井\"}',NULL,49,NULL,'2026-10-08 15:03:02');
INSERT INTO `agent_tool_call` VALUES (250,'770341d8c1ac486f92132ed05d3a3914','request_address_pick','{}',NULL,11,NULL,'2026-10-08 15:03:04');
INSERT INTO `agent_tool_call` VALUES (251,'d37f729065574a9780f36c89d158a6b9','prepare_order','{\"specId\": 101, \"quantity\": 1, \"addressId\": 28, \"productId\": 1001}',NULL,17,NULL,'2026-10-08 15:03:14');
INSERT INTO `agent_tool_call` VALUES (252,'d37f729065574a9780f36c89d158a6b9','search_tea','{\"keyword\": \"明前龙井 品鉴装 50g\"}',NULL,20,NULL,'2026-10-08 15:03:16');
INSERT INTO `agent_tool_call` VALUES (253,'d37f729065574a9780f36c89d158a6b9','search_tea','{\"keyword\": \"明前龙井\"}',NULL,14,NULL,'2026-10-08 15:03:18');
INSERT INTO `agent_tool_call` VALUES (254,'d37f729065574a9780f36c89d158a6b9','prepare_order','{\"specId\": 1, \"quantity\": 1, \"addressId\": 28, \"productId\": 1}',NULL,38,NULL,'2026-10-08 15:03:21');
INSERT INTO `agent_tool_call` VALUES (255,'217bee758dbc4fccb91124c3f33aabce','confirm_order','{\"confirmToken\": \"90d0d4e3d1114d2bbcdf950ff9a16863\"}',NULL,0,'217bee758dbc4fccb91124c3f33aabce:confirm_order','2026-10-08 15:03:30');
INSERT INTO `agent_tool_call` VALUES (256,'9936d7a9e62342af8a47c07fd6ae8ab4','search_tea','{\"keyword\": \"明前龙井 品鉴装 50g\"}',NULL,74,NULL,'2026-10-08 15:03:32');
INSERT INTO `agent_tool_call` VALUES (257,'9936d7a9e62342af8a47c07fd6ae8ab4','search_tea','{\"keyword\": \"明前龙井\"}',NULL,10,NULL,'2026-10-08 15:03:34');
INSERT INTO `agent_tool_call` VALUES (258,'9936d7a9e62342af8a47c07fd6ae8ab4','request_address_pick','{}',NULL,9,NULL,'2026-10-08 15:03:37');
INSERT INTO `agent_tool_call` VALUES (259,'fa1eac081e154d64bac3c1336f1b7aa1','search_tea','{\"keyword\": \"明前龙井\"}',NULL,33,NULL,'2026-10-08 15:09:08');
INSERT INTO `agent_tool_call` VALUES (260,'5bdbd5c129ad4f739a8045ce8b323886','request_address_pick','{}',NULL,12,NULL,'2026-10-08 15:09:47');
INSERT INTO `agent_tool_call` VALUES (261,'33a932a0bf3444ef9726b60f705279c0','search_tea','{\"keyword\": \"明前龙井\"}',NULL,14,NULL,'2026-10-08 15:10:24');
INSERT INTO `agent_tool_call` VALUES (262,'33a932a0bf3444ef9726b60f705279c0','prepare_order','{\"specId\": 3, \"quantity\": 1, \"addressId\": 25, \"productId\": 1}',NULL,14,NULL,'2026-10-08 15:10:27');
INSERT INTO `agent_tool_call` VALUES (263,'04e0981bcad043ffb2b778f46fe7880f','search_tea','{\"keyword\": \"明前龙井\"}',NULL,53,NULL,'2026-10-08 15:32:00');
INSERT INTO `agent_tool_call` VALUES (264,'04e0981bcad043ffb2b778f46fe7880f','prepare_order','{\"specId\": 3, \"quantity\": 1, \"productId\": 1}',NULL,76,NULL,'2026-10-08 15:32:02');
INSERT INTO `agent_tool_call` VALUES (265,'6c76053c8c834142ab1911f878240655','search_tea','{\"keyword\": \"明前龙井 礼盒装 200g\"}',NULL,20,NULL,'2026-10-08 15:32:33');
INSERT INTO `agent_tool_call` VALUES (266,'6c76053c8c834142ab1911f878240655','search_tea','{\"keyword\": \"明前龙井\"}',NULL,12,NULL,'2026-10-08 15:32:35');
INSERT INTO `agent_tool_call` VALUES (267,'6c76053c8c834142ab1911f878240655','prepare_order','{\"specId\": 3, \"quantity\": 1, \"productId\": 1}',NULL,42,NULL,'2026-10-08 15:32:37');
INSERT INTO `agent_tool_call` VALUES (268,'03710eb561284a398f7d76fbf3a39bd4','confirm_order','{\"confirmToken\": \"11a191de62e54972b1813420feaee7cf\"}',NULL,0,'03710eb561284a398f7d76fbf3a39bd4:confirm_order','2026-10-08 15:32:57');
INSERT INTO `agent_tool_call` VALUES (269,'7ccbfd06c44e4b61919e5852cdf4f3bb','search_tea','{\"keyword\": \"狗牯脑\"}',NULL,35,NULL,'2026-10-08 15:37:32');
INSERT INTO `agent_tool_call` VALUES (270,'7ccbfd06c44e4b61919e5852cdf4f3bb','prepare_order','{\"specId\": 5, \"quantity\": 2, \"productId\": 2}',NULL,48,NULL,'2026-10-08 15:37:34');
INSERT INTO `agent_tool_call` VALUES (271,'3b00cb30c1ce424a8caebdb85432b27b','confirm_order','{\"confirmToken\": \"091697c698084fe29497c3636ba7c7e7\"}',NULL,0,'3b00cb30c1ce424a8caebdb85432b27b:confirm_order','2026-10-08 15:37:37');
INSERT INTO `agent_tool_call` VALUES (272,'cdf2e200e7e64d4088a63b1e4407c549','search_tea','{\"keyword\": \"狗牯脑茶\"}',NULL,12,NULL,'2026-10-08 15:37:39');
INSERT INTO `agent_tool_call` VALUES (273,'cdf2e200e7e64d4088a63b1e4407c549','prepare_order','{\"specId\": 5, \"quantity\": 2, \"productId\": 2}',NULL,48,NULL,'2026-10-08 15:37:41');
INSERT INTO `agent_tool_call` VALUES (274,'63536cd6497a48989228710d2fdcedd1','confirm_order','{\"confirmToken\": \"b98c063d59394f50894e848ae9ae3035\"}',NULL,0,'63536cd6497a48989228710d2fdcedd1:confirm_order','2026-10-08 15:37:44');
INSERT INTO `agent_tool_call` VALUES (275,'d94c4190be284456b0261c5dc4ec97cf','search_tea','{\"keyword\": \"洞庭碧螺春\"}',NULL,89,NULL,'2026-10-08 17:04:01');
INSERT INTO `agent_tool_call` VALUES (276,'d94c4190be284456b0261c5dc4ec97cf','search_tea','{\"keyword\": \"普洱茶\"}',NULL,265,NULL,'2026-10-08 17:04:01');
INSERT INTO `agent_tool_call` VALUES (277,'d94c4190be284456b0261c5dc4ec97cf','search_tea','{\"keyword\": \"大红袍\"}',NULL,109,NULL,'2026-10-08 17:04:01');
INSERT INTO `agent_tool_call` VALUES (278,'ec0917a510b34913a3cfbc772b67367f','search_tea','{\"keyword\": \"洞庭碧螺春\"}',NULL,80,NULL,'2026-10-08 17:17:14');
INSERT INTO `agent_tool_call` VALUES (279,'ec0917a510b34913a3cfbc772b67367f','add_to_cart','{\"specId\": 42, \"quantity\": 1, \"productId\": 17}',NULL,423,'ec0917a510b34913a3cfbc772b67367f:add_to_cart','2026-10-08 17:17:16');
INSERT INTO `agent_tool_call` VALUES (280,'3f450d8f9ea040e79e6596beec4224a0','search_tea','{\"keyword\": \"洞庭碧螺春\"}',NULL,48,NULL,'2026-10-08 17:19:11');
INSERT INTO `agent_tool_call` VALUES (281,'3f450d8f9ea040e79e6596beec4224a0','add_to_cart','{\"specId\": 43, \"quantity\": 1, \"productId\": 17}',NULL,49,'3f450d8f9ea040e79e6596beec4224a0:add_to_cart','2026-10-08 17:19:13');
INSERT INTO `agent_tool_call` VALUES (282,'0e5c616e927c409cbeb91cc15e7cc240','search_tea','{\"keyword\": \"洞庭碧螺春\"}',NULL,17,NULL,'2026-10-08 17:19:37');
INSERT INTO `agent_tool_call` VALUES (283,'0e5c616e927c409cbeb91cc15e7cc240','add_to_cart','{\"specId\": 43, \"quantity\": 1, \"productId\": 17}',NULL,62,'0e5c616e927c409cbeb91cc15e7cc240:add_to_cart','2026-10-08 17:19:38');
INSERT INTO `agent_tool_call` VALUES (284,'f7a0be8eae004635829019fd48b5c361','search_tea','{\"keyword\": \"绿茶\"}',NULL,17,NULL,'2026-10-08 17:23:39');
INSERT INTO `agent_tool_call` VALUES (285,'1c137bf3817f4b0384ca8391ae7b6f82','get_tea_detail','{\"productId\": 103}',NULL,25,NULL,'2026-10-08 17:24:07');
INSERT INTO `agent_tool_call` VALUES (286,'1c137bf3817f4b0384ca8391ae7b6f82','search_tea','{\"keyword\": \"井冈翠绿\"}',NULL,39,NULL,'2026-10-08 17:24:09');
INSERT INTO `agent_tool_call` VALUES (287,'1c137bf3817f4b0384ca8391ae7b6f82','prepare_order','{\"specId\": 8, \"quantity\": 1, \"productId\": 3}',NULL,59,NULL,'2026-10-08 17:24:11');
INSERT INTO `agent_tool_call` VALUES (288,'3d4bb86a925145009752ff53e49dea1b','confirm_order','{\"confirmToken\": \"e53f09d20f494d7292d670fb03d372a1\"}',NULL,0,'3d4bb86a925145009752ff53e49dea1b:confirm_order','2026-10-08 17:24:22');
INSERT INTO `agent_tool_call` VALUES (289,'df97f06184d74f0b8adb9a2c6c9fd551','search_tea','{\"keyword\": \"绿茶\"}',NULL,34,NULL,'2026-10-08 17:47:15');
INSERT INTO `agent_tool_call` VALUES (290,'df97f06184d74f0b8adb9a2c6c9fd551','recommend_tea','{\"productIds\": [3, 4]}',NULL,120,NULL,'2026-10-08 17:47:17');
INSERT INTO `agent_tool_call` VALUES (291,'f38e57998598431995dff830f0dbd66c','prepare_order','{\"specId\": 8, \"quantity\": 2, \"productId\": 3}',NULL,0,NULL,'2026-10-08 17:47:40');
INSERT INTO `agent_tool_call` VALUES (292,'ddded94da1734c2ba2530e7730398db3','prepare_order','{\"specId\": 8, \"quantity\": 2, \"productId\": 3}',NULL,0,NULL,'2026-10-08 17:47:58');
INSERT INTO `agent_tool_call` VALUES (293,'1502ced165804700bab13d11a1927dc4','search_tea','{\"keyword\": \"绿茶\"}',NULL,15,NULL,'2026-10-08 17:48:17');
INSERT INTO `agent_tool_call` VALUES (294,'1502ced165804700bab13d11a1927dc4','recommend_tea','{\"productIds\": [3, 4]}',NULL,23,NULL,'2026-10-08 17:48:20');
INSERT INTO `agent_tool_call` VALUES (295,'bad9351d7c1b454ba74deb6020f41047','search_tea','{\"keyword\": \"绿茶\"}',NULL,30,NULL,'2026-10-08 17:56:39');
INSERT INTO `agent_tool_call` VALUES (296,'bad9351d7c1b454ba74deb6020f41047','recommend_tea','{\"productIds\": [3, 4]}',NULL,291,NULL,'2026-10-08 17:56:41');
INSERT INTO `agent_tool_call` VALUES (297,'aa73804807654a00835f91ebb45ab488','prepare_order','{\"specId\": 7, \"quantity\": 4, \"productId\": 3}',NULL,0,NULL,'2026-10-08 17:56:50');
INSERT INTO `agent_tool_call` VALUES (298,'7433d2b6192a4d77809d35297c6fd4b0','confirm_order','{\"confirmToken\": \"f920be6cdcc340b9a50e20a4d5b0c099\"}',NULL,0,'7433d2b6192a4d77809d35297c6fd4b0:confirm_order','2026-10-08 17:57:55');
INSERT INTO `agent_tool_call` VALUES (299,'dabe3cc7895b41f283d50e925de7696b','search_tea','{\"keyword\": \"大红袍\"}',NULL,34,NULL,'2026-10-08 18:02:02');
INSERT INTO `agent_tool_call` VALUES (300,'dabe3cc7895b41f283d50e925de7696b','prepare_order','{\"productId\": 9}',NULL,31,NULL,'2026-10-08 18:02:04');
INSERT INTO `agent_tool_call` VALUES (301,'b9c84cef8ab64a64a0b5a54770d90674','search_tea','{\"keyword\": \"大红袍\"}',NULL,34,NULL,'2026-10-08 18:14:48');
INSERT INTO `agent_tool_call` VALUES (302,'b9c84cef8ab64a64a0b5a54770d90674','search_tea','{\"keyword\": \"普洱\"}',NULL,136,NULL,'2026-10-08 18:14:48');
INSERT INTO `agent_tool_call` VALUES (303,'b9c84cef8ab64a64a0b5a54770d90674','search_tea','{\"keyword\": \"碧螺春\"}',NULL,40,NULL,'2026-10-08 18:14:48');
INSERT INTO `agent_tool_call` VALUES (304,'b9c84cef8ab64a64a0b5a54770d90674','recommend_tea','{\"productIds\": [9, 14, 17]}',NULL,28,NULL,'2026-10-08 18:14:50');
INSERT INTO `agent_tool_call` VALUES (305,'1be153e4bb684356af319cb3b1304dae','search_tea','{\"keyword\": \"大红袍\"}',NULL,15,NULL,'2026-10-08 18:15:13');
INSERT INTO `agent_tool_call` VALUES (306,'15f71c112a274b6a91006f8a73aae230','prepare_order','{\"specId\": 23, \"quantity\": 1, \"productId\": 9}',NULL,0,NULL,'2026-10-08 18:16:55');
INSERT INTO `agent_tool_call` VALUES (307,'0dd94218f5bd4bd789eedc9cb0344012','confirm_order','{\"confirmToken\": \"5243467b621c47ddb950d392015fcac7\"}',NULL,0,'0dd94218f5bd4bd789eedc9cb0344012:confirm_order','2026-10-08 18:16:55');
INSERT INTO `agent_tool_call` VALUES (308,'3271acffe12743089567581f45d69fca','prepare_order','{\"specId\": 23, \"quantity\": 1, \"productId\": 9}',NULL,0,NULL,'2026-10-08 18:17:14');
INSERT INTO `agent_tool_call` VALUES (309,'05db09694176470f8eb2a03b6ee94237','confirm_order','{\"confirmToken\": \"ceb3efca9907438bab5651df14e4e8d8\"}',NULL,0,'05db09694176470f8eb2a03b6ee94237:confirm_order','2026-10-08 18:17:14');
INSERT INTO `agent_tool_call` VALUES (310,'11836302c2e948ae93b613c3dcac01bb','search_tea','{\"keyword\": \"送长辈 茶\"}',NULL,41,NULL,'2026-10-08 18:28:04');
INSERT INTO `agent_tool_call` VALUES (311,'5b81ca0181df4a0296eba649e610cbb2','search_tea','{\"keyword\": \"送长辈 茶礼盒\"}',NULL,27,NULL,'2026-10-08 18:28:35');
INSERT INTO `agent_tool_call` VALUES (312,'5b81ca0181df4a0296eba649e610cbb2','search_tea','{\"keyword\": \"红茶\"}',NULL,24,NULL,'2026-10-08 18:28:35');
INSERT INTO `agent_tool_call` VALUES (313,'5b81ca0181df4a0296eba649e610cbb2','search_tea','{\"keyword\": \"乌龙茶\"}',NULL,79,NULL,'2026-10-08 18:28:37');
INSERT INTO `agent_tool_call` VALUES (314,'5b81ca0181df4a0296eba649e610cbb2','search_tea','{\"keyword\": \"龙井\"}',NULL,46,NULL,'2026-10-08 18:28:37');
INSERT INTO `agent_tool_call` VALUES (315,'5b81ca0181df4a0296eba649e610cbb2','recommend_tea','{\"productIds\": [8, 5, 1, 10, 20]}',NULL,98,NULL,'2026-10-08 18:28:39');
INSERT INTO `agent_tool_call` VALUES (316,'5ba3beb0fce64fed958a38f7891fb1fe','search_tea','{\"keyword\": \"送长辈 茶叶礼盒\"}',NULL,47,NULL,'2026-10-08 18:41:13');
INSERT INTO `agent_tool_call` VALUES (317,'5ba3beb0fce64fed958a38f7891fb1fe','search_tea','{\"keyword\": \"普洱茶\"}',NULL,374,NULL,'2026-10-08 18:41:15');
INSERT INTO `agent_tool_call` VALUES (318,'5ba3beb0fce64fed958a38f7891fb1fe','search_tea','{\"keyword\": \"大红袍\"}',NULL,29,NULL,'2026-10-08 18:41:15');
INSERT INTO `agent_tool_call` VALUES (319,'5ba3beb0fce64fed958a38f7891fb1fe','search_tea','{\"keyword\": \"碧螺春\"}',NULL,35,NULL,'2026-10-08 18:41:15');
INSERT INTO `agent_tool_call` VALUES (320,'5ba3beb0fce64fed958a38f7891fb1fe','recommend_tea','{\"productIds\": [14, 9, 17]}',NULL,30,NULL,'2026-10-08 18:41:17');
INSERT INTO `agent_tool_call` VALUES (321,'9560438ef22646e198fbeab2f17e0a27','prepare_order','{\"specId\": 23, \"quantity\": 1, \"productId\": 9}',NULL,0,NULL,'2026-10-08 18:42:07');
INSERT INTO `agent_tool_call` VALUES (322,'9ef6d0e75775412598e44094e3825d7f','confirm_order','{\"confirmToken\": \"64d8b84c6db347a4986885b612fe4a5c\"}',NULL,0,'9ef6d0e75775412598e44094e3825d7f:confirm_order','2026-10-08 18:42:08');
INSERT INTO `agent_tool_call` VALUES (323,'dd533e0ee61840c58ed217c588c15ee6','search_tea','{\"keyword\": \"铁观音\"}',NULL,41,NULL,'2026-10-08 18:59:05');
INSERT INTO `agent_tool_call` VALUES (324,'370731425c144067a60f2c63bd162a2b','search_tea','{\"keyword\": \"绿茶\"}',NULL,31,NULL,'2026-10-08 19:01:08');
INSERT INTO `agent_tool_call` VALUES (325,'370731425c144067a60f2c63bd162a2b','recommend_tea','{\"productIds\": [3, 4]}',NULL,58,NULL,'2026-10-08 19:01:10');
INSERT INTO `agent_tool_call` VALUES (326,'8269c4d8eac6420683d58d7f038e173d','search_tea','{\"keyword\": \"铁观音\"}',NULL,24,NULL,'2026-10-08 19:01:36');
INSERT INTO `agent_tool_call` VALUES (327,'8269c4d8eac6420683d58d7f038e173d','recommend_tea','{\"productIds\": [10]}',NULL,14,NULL,'2026-10-08 19:01:37');
INSERT INTO `agent_tool_call` VALUES (328,'45b7ffe4afcc4eb8a23edc2d11e40bc1','search_tea','{\"keyword\": \"绿茶\"}',NULL,23,NULL,'2026-10-08 19:06:30');
INSERT INTO `agent_tool_call` VALUES (329,'45b7ffe4afcc4eb8a23edc2d11e40bc1','recommend_tea','{\"productIds\": [3, 4]}',NULL,63,NULL,'2026-10-08 19:06:32');
INSERT INTO `agent_tool_call` VALUES (330,'db1f62f03db84f74b8f3f723420ca6ef','search_tea','{\"keyword\": \"铁观音\"}',NULL,25,NULL,'2026-10-08 19:06:37');
INSERT INTO `agent_tool_call` VALUES (331,'75b710117b74493a972409255cdec6e0','search_tea','{\"keyword\": \"绿茶\"}',NULL,13,NULL,'2026-10-08 19:06:41');
INSERT INTO `agent_tool_call` VALUES (332,'75b710117b74493a972409255cdec6e0','search_tea','{\"keyword\": \"碧螺春\"}',NULL,31,NULL,'2026-10-08 19:06:43');
INSERT INTO `agent_tool_call` VALUES (333,'75b710117b74493a972409255cdec6e0','search_tea','{\"keyword\": \"龙井\"}',NULL,23,NULL,'2026-10-08 19:06:43');
INSERT INTO `agent_tool_call` VALUES (334,'75b710117b74493a972409255cdec6e0','recommend_tea','{\"productIds\": [17, 1, 3]}',NULL,24,NULL,'2026-10-08 19:06:45');
INSERT INTO `agent_tool_call` VALUES (335,'24212d9775864b0a8584be2ab72a8059','search_tea','{\"keyword\": \"绿茶\"}',NULL,11,NULL,'2026-10-08 19:06:51');
INSERT INTO `agent_tool_call` VALUES (336,'24212d9775864b0a8584be2ab72a8059','get_tea_detail','{\"productId\": 3}',NULL,19,NULL,'2026-10-08 19:06:53');
INSERT INTO `agent_tool_call` VALUES (337,'24212d9775864b0a8584be2ab72a8059','get_tea_detail','{\"productId\": 4}',NULL,20,NULL,'2026-10-08 19:06:53');
INSERT INTO `agent_tool_call` VALUES (338,'24212d9775864b0a8584be2ab72a8059','recommend_tea','{\"productIds\": [3, 4]}',NULL,14,NULL,'2026-10-08 19:06:55');
INSERT INTO `agent_tool_call` VALUES (339,'6fa54714504142a9805e1350df4473ae','search_tea','{\"keyword\": \"红茶\"}',NULL,11,NULL,'2026-10-08 19:07:00');
INSERT INTO `agent_tool_call` VALUES (340,'6fa54714504142a9805e1350df4473ae','recommend_tea','{\"productIds\": [5, 20, 8]}',NULL,79,NULL,'2026-10-08 19:07:02');
INSERT INTO `agent_tool_call` VALUES (341,'42d8bf77b5c347ff94e64885de29cf7e','search_tea','{\"keyword\": \"绿茶\"}',NULL,57,NULL,'2026-10-08 19:12:50');
INSERT INTO `agent_tool_call` VALUES (342,'42d8bf77b5c347ff94e64885de29cf7e','search_tea','{\"keyword\": \"碧螺春\"}',NULL,33,NULL,'2026-10-08 19:12:52');
INSERT INTO `agent_tool_call` VALUES (343,'42d8bf77b5c347ff94e64885de29cf7e','search_tea','{\"keyword\": \"龙井\"}',NULL,34,NULL,'2026-10-08 19:12:52');
INSERT INTO `agent_tool_call` VALUES (344,'42d8bf77b5c347ff94e64885de29cf7e','recommend_tea','{\"productIds\": [1, 17, 3]}',NULL,41,NULL,'2026-10-08 19:12:54');
INSERT INTO `agent_tool_call` VALUES (345,'ce70ce304f6f4477b7b04a28b0fd9ac6','search_tea','{\"keyword\": \"铁观音\"}',NULL,23,NULL,'2026-10-08 19:12:58');
INSERT INTO `agent_tool_call` VALUES (346,'ce70ce304f6f4477b7b04a28b0fd9ac6','recommend_tea','{\"productIds\": [10]}',NULL,8,NULL,'2026-10-08 19:13:01');
INSERT INTO `agent_tool_call` VALUES (347,'785c2a278dd9452b94f00c16deac1766','search_tea','{\"keyword\": \"绿茶\"}',NULL,13,NULL,'2026-10-08 19:13:04');
INSERT INTO `agent_tool_call` VALUES (348,'785c2a278dd9452b94f00c16deac1766','recommend_tea','{\"productIds\": [3, 4]}',NULL,23,NULL,'2026-10-08 19:13:07');
INSERT INTO `agent_tool_call` VALUES (349,'211f8ddda44149f197e896b567638fa3','search_tea','{\"keyword\": \"绿茶\"}',NULL,11,NULL,'2026-10-08 19:13:13');
INSERT INTO `agent_tool_call` VALUES (350,'211f8ddda44149f197e896b567638fa3','recommend_tea','{\"productIds\": [3, 4]}',NULL,21,NULL,'2026-10-08 19:13:15');
INSERT INTO `agent_tool_call` VALUES (351,'580de191d32d453688d5677183905daa','search_tea','{\"keyword\": \"红茶\"}',NULL,9,NULL,'2026-10-08 19:13:19');
INSERT INTO `agent_tool_call` VALUES (352,'580de191d32d453688d5677183905daa','recommend_tea','{\"productIds\": [5, 8, 20]}',NULL,65,NULL,'2026-10-08 19:13:21');
INSERT INTO `agent_tool_call` VALUES (353,'933f077df8bb43538e902768525e2c9b','search_tea','{\"keyword\": \"绿茶\"}',NULL,10,NULL,'2026-10-08 19:13:48');
INSERT INTO `agent_tool_call` VALUES (354,'933f077df8bb43538e902768525e2c9b','recommend_tea','{\"productIds\": [3, 4]}',NULL,16,NULL,'2026-10-08 19:13:50');
INSERT INTO `agent_tool_call` VALUES (355,'3d4be1acf6954b85a036d14475912a11','search_tea','{\"keyword\": \"铁观音\"}',NULL,9,NULL,'2026-10-08 19:13:54');
INSERT INTO `agent_tool_call` VALUES (356,'3d4be1acf6954b85a036d14475912a11','recommend_tea','{\"productIds\": [10]}',NULL,7,NULL,'2026-10-08 19:13:56');
INSERT INTO `agent_tool_call` VALUES (357,'f1de367038634cf8b41bdf317fd00e2b','prepare_order','{\"specId\": 25, \"quantity\": 1, \"productId\": 10}',NULL,0,NULL,'2026-10-08 19:13:58');
INSERT INTO `agent_tool_call` VALUES (358,'6a28246f647f4cd3b596128c5a220ac4','confirm_order','{\"confirmToken\": \"8817e06ca42a4dbbb8a4695d5521e0a9\"}',NULL,0,'6a28246f647f4cd3b596128c5a220ac4:confirm_order','2026-10-08 19:13:58');
INSERT INTO `agent_tool_call` VALUES (359,'d18861476e2342b8ad08fd521dbd57f0','search_tea','{\"keyword\": \"送长辈 茶叶 礼盒\"}',NULL,70,NULL,'2026-10-10 12:54:35');
INSERT INTO `agent_tool_call` VALUES (360,'d18861476e2342b8ad08fd521dbd57f0','search_tea','{\"keyword\": \"普洱\"}',NULL,142,NULL,'2026-10-10 12:54:37');
INSERT INTO `agent_tool_call` VALUES (361,'d18861476e2342b8ad08fd521dbd57f0','search_tea','{\"keyword\": \"大红袍\"}',NULL,39,NULL,'2026-10-10 12:54:37');
INSERT INTO `agent_tool_call` VALUES (362,'d18861476e2342b8ad08fd521dbd57f0','search_tea','{\"keyword\": \"红茶\"}',NULL,26,NULL,'2026-10-10 12:54:37');
INSERT INTO `agent_tool_call` VALUES (363,'d18861476e2342b8ad08fd521dbd57f0','recommend_tea','{\"productIds\": [14, 9, 5]}',NULL,88,NULL,'2026-10-10 12:54:39');
INSERT INTO `agent_tool_call` VALUES (364,'c0be8871c8a14b9a988d61949ef7ba2f','search_tea','{\"keyword\": \"普洱茶\"}',NULL,18,NULL,'2026-10-10 12:55:04');
INSERT INTO `agent_tool_call` VALUES (365,'c4f306cff6be4c99bd81840f7133758b','prepare_order','{\"specId\": 35, \"quantity\": 3, \"productId\": 14}',NULL,0,NULL,'2026-10-10 12:55:14');
INSERT INTO `agent_tool_call` VALUES (366,'e779bfcb9c0949b6a23948509d1ef741','request_address_pick','{}',NULL,13,NULL,'2026-10-10 12:55:24');
INSERT INTO `agent_tool_call` VALUES (367,'ad282aceadcc4500a24ffd8e56decef9','confirm_order','{\"confirmToken\": \"ff701d2119c449bda36b682393d5224b\"}',NULL,0,'ad282aceadcc4500a24ffd8e56decef9:confirm_order','2026-10-10 12:55:27');
INSERT INTO `agent_tool_call` VALUES (368,'a5614844914b49b998f4c1591827d949','view_cart','{}',200,72,NULL,'2026-10-23 13:30:25');
INSERT INTO `agent_tool_call` VALUES (369,'93212693619f4374b37d0a62fc1d4572','search_tea','{\"keyword\": \"绿茶\"}',200,44,NULL,'2026-10-23 13:38:14');
INSERT INTO `agent_tool_call` VALUES (370,'93212693619f4374b37d0a62fc1d4572','recommend_tea','{\"productIds\": [3, 4]}',200,182,NULL,'2026-10-23 13:38:20');
INSERT INTO `agent_tool_call` VALUES (371,'5d2fcbac10774f10b52c8027630bd422','search_tea','{\"keyword\": \"绿茶\"}',500,143,NULL,'2026-10-23 20:33:54');
INSERT INTO `agent_tool_call` VALUES (372,'98cd9d5ee80f4fb98c910664eecc24e8','search_tea','{\"keyword\": \"绿茶\"}',200,99,NULL,'2026-10-23 20:34:13');
INSERT INTO `agent_tool_call` VALUES (373,'98cd9d5ee80f4fb98c910664eecc24e8','list_categories','{}',200,36,NULL,'2026-10-23 20:34:13');
INSERT INTO `agent_tool_call` VALUES (374,'98cd9d5ee80f4fb98c910664eecc24e8','search_tea','{\"keyword\": \"龙井\"}',200,114,NULL,'2026-10-23 20:34:15');
INSERT INTO `agent_tool_call` VALUES (375,'98cd9d5ee80f4fb98c910664eecc24e8','search_tea','{\"keyword\": \"狗牯脑\"}',200,63,NULL,'2026-10-23 20:34:15');
INSERT INTO `agent_tool_call` VALUES (376,'98cd9d5ee80f4fb98c910664eecc24e8','recommend_tea','{\"productIds\": [1, 2, 3, 4]}',200,158,NULL,'2026-10-23 20:34:17');
INSERT INTO `agent_tool_call` VALUES (377,'0cf6963f925f48c0a28394bae72d1b43','search_tea','{\"keyword\": \"明前龙井\"}',200,22,NULL,'2026-10-23 20:34:31');
INSERT INTO `agent_tool_call` VALUES (378,'9eac6a962b8a4328850c9afcde2a1319','prepare_order','{\"specId\": 1, \"quantity\": 1, \"productId\": 1}',200,0,NULL,'2026-10-23 21:15:58');
INSERT INTO `agent_tool_call` VALUES (379,'a859e4d3cb534964a68c93ca878901ae','confirm_order','{\"confirmToken\": \"19334f6888ff4895a8d650d8bf8fb708\"}',200,0,'a859e4d3cb534964a68c93ca878901ae:confirm_order','2026-10-23 21:16:12');
/*!40000 ALTER TABLE `agent_tool_call` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agent_trace`
--

DROP TABLE IF EXISTS `agent_trace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agent_trace` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `trace_id` varchar(64) NOT NULL COMMENT '一次请求的全局追踪 ID',
  `session_id` varchar(64) DEFAULT NULL COMMENT '会话 ID',
  `span_name` varchar(64) NOT NULL COMMENT '阶段名 agent.run/rag.retrieve/llm.chat',
  `intent` varchar(64) DEFAULT NULL COMMENT '路由出的意图',
  `prompt_tokens` int DEFAULT '0',
  `completion_tokens` int DEFAULT '0',
  `cost_yuan` decimal(10,6) DEFAULT '0.000000' COMMENT '本次成本（元）',
  `latency_ms` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_trace` (`trace_id`),
  KEY `idx_session` (`session_id`),
  KEY `idx_span` (`span_name`),
  KEY `idx_created` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Agent 链路追踪表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agent_trace`
--

LOCK TABLES `agent_trace` WRITE;
/*!40000 ALTER TABLE `agent_trace` DISABLE KEYS */;
INSERT INTO `agent_trace` VALUES (1,'eaa83b206d62424f91ecde2ededf8957','w2-sse-test','agent.run',NULL,120,66,0.000252,924,'2026-10-03 23:37:03');
INSERT INTO `agent_trace` VALUES (2,'2459e0aa3c9149c880f6bcbd1b54d35f','w2-sse-test','agent.run',NULL,120,66,0.000252,439,'2026-10-03 23:41:59');
INSERT INTO `agent_trace` VALUES (3,'e960d7b444794b65adb9fde4ed441003','w2-sse-test','agent.run',NULL,120,66,0.000252,824,'2026-10-03 23:44:57');
INSERT INTO `agent_trace` VALUES (4,'cca4ed385a264585b5f611eb9b3505d0','web-e056vi','agent.run',NULL,120,66,0.000252,188,'2026-10-03 23:45:36');
INSERT INTO `agent_trace` VALUES (5,'f10d8867cdf844acaae8605fc06b7f74','resume-probe','agent.run',NULL,120,66,0.000252,184,'2026-10-04 00:08:46');
INSERT INTO `agent_trace` VALUES (6,'99055423a0c74d37b9272c08d04915b8','w2-real-llm','agent.run',NULL,537,47,0.000631,2497,'2026-10-04 00:10:30');
INSERT INTO `agent_trace` VALUES (7,'6110683044bd4ccaa3a5a40321a08393','web-real-check','agent.run',NULL,537,47,0.000631,1576,'2026-10-04 00:11:49');
INSERT INTO `agent_trace` VALUES (8,'e3ee7e6166b344db8803ec6fe8899647','web-39k5li','agent.run',NULL,538,92,0.000722,2297,'2026-10-04 00:15:56');
INSERT INTO `agent_trace` VALUES (9,'c06ca6c2b6f94ee384812c28204c2fb2','w2-real-1','agent.run',NULL,546,143,0.000832,2707,'2026-10-04 00:16:54');
INSERT INTO `agent_trace` VALUES (10,'195b286a61974122a655dc3cdca17f89','web-wfbrxz','agent.run',NULL,536,33,0.000602,1498,'2026-10-04 00:17:13');
INSERT INTO `agent_trace` VALUES (11,'e3cc17c9def3438caa9479fd6e7ef8b8','w2-real-1','agent.run',NULL,706,100,0.000906,2991,'2026-10-04 00:18:20');
INSERT INTO `agent_trace` VALUES (12,'dd3d75e57eca4f4dac4e7e5b6b7b3ed6','final-check','agent.run',NULL,537,60,0.000657,2402,'2026-10-04 00:19:38');
INSERT INTO `agent_trace` VALUES (13,'79566b0621b446fead78aed9f0fc22c6','w2-real-1','agent.run',NULL,823,164,0.001151,3054,'2026-10-04 00:19:58');
INSERT INTO `agent_trace` VALUES (14,'0f63797ddaed4e169fab78ef8417e234','fc-test-1','agent.run',NULL,540,49,0.000638,1714,'2026-10-04 00:20:59');
INSERT INTO `agent_trace` VALUES (15,'6ebb007faebb46d19a0f375e0aac12fc','web-0u2klx','agent.run',NULL,536,40,0.000616,2309,'2026-10-04 00:25:27');
INSERT INTO `agent_trace` VALUES (16,'358aded3a943404abd6be1d231934681','fc-fix-3','agent.run',NULL,1181,121,0.001423,4665,'2026-10-04 00:37:01');
INSERT INTO `agent_trace` VALUES (17,'227d8a70804d48eea1d56d6e71aad5d7','fc-fix-3','agent.run',NULL,3161,228,0.003617,4767,'2026-10-04 00:37:27');
INSERT INTO `agent_trace` VALUES (18,'71a4cf61d0724ac0ae61d4645910715c','verify-normal','agent.run',NULL,3007,208,0.003423,5001,'2026-10-04 11:40:52');
INSERT INTO `agent_trace` VALUES (19,'333c93604a45489fa40f2a4d13cde9e6','verify-degrade','agent.run',NULL,1177,111,0.001399,3855,'2026-10-04 11:41:14');
INSERT INTO `agent_trace` VALUES (20,'f303693d697d4503b46f6803a5c880c8','smoke-1005','agent.run',NULL,3005,209,0.003423,6159,'2026-10-05 23:44:23');
INSERT INTO `agent_trace` VALUES (21,'4d1af249ab29400c887da41c50825802','nonstream-test','agent.run',NULL,2997,362,0.003721,5068,'2026-10-06 00:10:24');
INSERT INTO `agent_trace` VALUES (22,'3d534a6b487541a897bd28ab7dbf4eb5','mp-verify','agent.run',NULL,1169,113,0.001395,4570,'2026-10-06 00:36:31');
INSERT INTO `agent_trace` VALUES (23,'4957b310d65448819b0119ec26e14bbf','mp-token-test','agent.run',NULL,3005,245,0.003495,4351,'2026-10-06 00:37:40');
INSERT INTO `agent_trace` VALUES (24,'a27ed0cdd44443578700652d8edc22d7','mp-ajircu','agent.run',NULL,2995,347,0.003689,4995,'2026-10-06 00:46:24');
INSERT INTO `agent_trace` VALUES (25,'4a59a4cff2174906b3fbe8af53ac4ecc','searchfix-1','agent.run',NULL,1413,184,0.001781,5249,'2026-10-06 12:11:48');
INSERT INTO `agent_trace` VALUES (26,'1fd911a7785d486ead21e66204c38de4','mp-xiswzu','agent.run',NULL,647,175,0.000997,3109,'2026-10-06 12:27:46');
INSERT INTO `agent_trace` VALUES (27,'cde4530f45254ac8b0a6f8a0101ab930','mp-xiswzu','agent.run',NULL,647,190,0.001027,3685,'2026-10-06 12:27:46');
INSERT INTO `agent_trace` VALUES (28,'7be99f1a1e9c40fe9fd6d2bee6a0524e','p1-accept','agent.run',NULL,4241,342,0.004925,6190,'2026-10-06 12:51:45');
INSERT INTO `agent_trace` VALUES (29,'5d999360e97848118388f6d655e3043a','p1-accept','agent.run',NULL,2248,179,0.002606,3508,'2026-10-06 12:51:48');
INSERT INTO `agent_trace` VALUES (30,'3972323a7e634d28a56d9122251a3400','p1-accept','agent.run',NULL,5312,348,0.006008,7210,'2026-10-06 12:54:29');
INSERT INTO `agent_trace` VALUES (31,'82451f33f32d4a83bf727eafc42a4221','p1-accept','agent.run',NULL,9341,373,0.010087,7948,'2026-10-06 12:55:38');
INSERT INTO `agent_trace` VALUES (32,'ff9df59497a048feba8ae7f28c2be0a0','p1-accept','agent.run',NULL,12360,349,0.013058,9202,'2026-10-06 12:55:48');
INSERT INTO `agent_trace` VALUES (33,'51b77a807703491184f28f1d4f2b4521','p1-accept2','agent.run',NULL,4274,253,0.004780,5657,'2026-10-06 12:59:34');
INSERT INTO `agent_trace` VALUES (34,'c07ab008cfdd48609890de2987f7e37c','p1-accept2','agent.run',NULL,2224,137,0.002498,3740,'2026-10-06 12:59:37');
INSERT INTO `agent_trace` VALUES (35,'77f274af5bd3482c9a370f362b140436','p1-accept3','agent.run',NULL,7411,334,0.008079,7680,'2026-10-06 13:00:43');
INSERT INTO `agent_trace` VALUES (36,'b67e42d079ed4c51b13d532b0623bd7e','p1-accept3','agent.run',NULL,2197,124,0.002445,3700,'2026-10-06 13:00:47');
INSERT INTO `agent_trace` VALUES (37,'991b98212136419ba3ee95a20b200afd','bugcheck-1','agent.run',NULL,1737,185,0.002107,4120,'2026-10-06 14:07:08');
INSERT INTO `agent_trace` VALUES (38,'a1d09bd2a5b9410092dbd0205fa30cb1','order-test-1','agent.run',NULL,3587,198,0.003983,5505,'2026-10-06 14:07:39');
INSERT INTO `agent_trace` VALUES (39,'a8ce5f6c077f43809b79408f17f39d2d','order-test-2','agent.run',NULL,4137,228,0.004593,6003,'2026-10-06 14:08:09');
INSERT INTO `agent_trace` VALUES (40,'31eb8f55a1bd486db8fc28242a67b457','route-a','agent.run',NULL,2992,208,0.003408,5636,'2026-10-06 14:09:51');
INSERT INTO `agent_trace` VALUES (41,'bdedac9cb58e4475ac2e71c82c107a9a','route-b','agent.run',NULL,2142,232,0.002606,4162,'2026-10-06 14:09:55');
INSERT INTO `agent_trace` VALUES (42,'02f5d4d7172045e489acd121e86eed98','route-c','agent.run',NULL,3037,292,0.003621,4926,'2026-10-06 14:11:23');
INSERT INTO `agent_trace` VALUES (43,'5ccd3faed9d2490e955c61bf3cb1041d','fix-a','agent.run',NULL,5462,236,0.005934,7909,'2026-10-06 14:15:02');
INSERT INTO `agent_trace` VALUES (44,'b8e03c41939d41aab4aa11bd9d1dac84','fix-b','agent.run',NULL,2800,317,0.003434,4981,'2026-10-06 14:15:07');
INSERT INTO `agent_trace` VALUES (45,'d048c340e4bc47b6a0595a79f9437323','scan-分类','agent.run',NULL,1658,131,0.001920,3911,'2026-10-06 14:16:00');
INSERT INTO `agent_trace` VALUES (46,'7f40aaa2d852426687d691f54bd7fa0b','scan-主题','agent.run',NULL,2629,360,0.003349,4871,'2026-10-06 14:16:04');
INSERT INTO `agent_trace` VALUES (47,'7c2193a2e1f246eba413a557c020e29b','scan-订单','agent.run',NULL,2564,371,0.003306,5674,'2026-10-06 14:16:10');
INSERT INTO `agent_trace` VALUES (48,'16f02ac2ee1b4cfe8abab00565e2bba6','scan-优惠券','agent.run',NULL,1126,46,0.001218,2806,'2026-10-06 14:16:13');
INSERT INTO `agent_trace` VALUES (49,'ab026637277044259d7eb278c68afd50','scan-地址','agent.run',NULL,1263,115,0.001493,3510,'2026-10-06 14:16:17');
INSERT INTO `agent_trace` VALUES (50,'23410038743a40cbbe7e418cac83ea96','scan-购物车','agent.run',NULL,1726,144,0.002014,3520,'2026-10-06 14:16:20');
INSERT INTO `agent_trace` VALUES (51,'62b87c245aca410fab1fb8d47bd05c86','scan-用户','agent.run',NULL,707,68,0.000843,2022,'2026-10-06 14:16:22');
INSERT INTO `agent_trace` VALUES (52,'594dbe6cc37b46169f495818356ba32d','scan-知识(RAG)','agent.run',NULL,931,139,0.001209,2890,'2026-10-06 14:16:25');
INSERT INTO `agent_trace` VALUES (53,'8a0fda1e50994742b59245f5303a3d61','scan-无意图','agent.run',NULL,704,91,0.000886,1861,'2026-10-06 14:16:27');
INSERT INTO `agent_trace` VALUES (54,'ddd119bddf8f48049e108efe1b369475','mp-jxawdi','agent.run',NULL,2796,303,0.003402,4682,'2026-10-06 14:29:33');
INSERT INTO `agent_trace` VALUES (55,'bb437949e6ee481da07ca603fcfb68cc','mp-jxawdi','agent.run',NULL,2796,324,0.003444,4908,'2026-10-06 14:29:33');
INSERT INTO `agent_trace` VALUES (56,'cb4c6620a00047ae9cf089cc4bd17f0b','mp-gry6y7','agent.run',NULL,2796,272,0.003340,5084,'2026-10-06 14:37:45');
INSERT INTO `agent_trace` VALUES (57,'c40ab19c297241b09e206ee8cf42df04','mp-r39kei','agent.run',NULL,1509,131,0.001771,4498,'2026-10-06 23:19:58');
INSERT INTO `agent_trace` VALUES (58,'e4890dcfc6fa419d8aa5f6e1f2bbe50f','mp-kkuwz5','agent.run',NULL,2796,280,0.003356,158505,'2026-10-06 23:56:54');
INSERT INTO `agent_trace` VALUES (59,'e0910f29fdf9439082f109ec3b0c074f','authverify-1007b','agent.run',NULL,707,47,0.000801,4194,'2026-10-07 00:07:56');
INSERT INTO `agent_trace` VALUES (60,'9cedec4c357142e7bc7ebbd2d7c74a02','web-tyn66x','agent.run',NULL,707,47,0.000801,1881,'2026-10-07 00:20:04');
INSERT INTO `agent_trace` VALUES (61,'23d4fbbc3db24b398695c62529f1fd24','web-2k7qiy','agent.run',NULL,707,47,0.000801,1576,'2026-10-07 00:20:16');
INSERT INTO `agent_trace` VALUES (62,'bf18083f772640c8aebdd0a280062a82','mp-jn2aod','agent.run',NULL,2796,323,0.003442,5094,'2026-10-07 00:21:09');
INSERT INTO `agent_trace` VALUES (63,'f58238b1788e4c44bf9ab4af87353e46','mp-jn2aod','agent.run',NULL,2109,132,0.002373,4102,'2026-10-07 00:21:36');
INSERT INTO `agent_trace` VALUES (64,'8995025f182241b1a1335d2336e69651','authverify-1007b','agent.run',NULL,3459,345,0.004149,5730,'2026-10-07 00:25:04');
INSERT INTO `agent_trace` VALUES (65,'08696fa9070d41c890628dd15a4b803e','idcheck-1007','agent.run',NULL,1747,142,0.002031,3895,'2026-10-07 00:25:09');
INSERT INTO `agent_trace` VALUES (66,'41077ad6e1484714beae55da5ac7135f','idcheck-1007b','agent.run',NULL,1526,144,0.001814,3993,'2026-10-07 00:26:43');
INSERT INTO `agent_trace` VALUES (67,'2c4b2629f5ce4b768f811c9c16bc3a86','idcheck-1007b','agent.run',NULL,1812,144,0.002100,4939,'2026-10-07 00:28:27');
INSERT INTO `agent_trace` VALUES (68,'abeb4679f8e54f9ab634f971efa9e737','memA-1','agent.run',NULL,823,51,0.000925,4460,'2026-10-07 00:37:05');
INSERT INTO `agent_trace` VALUES (69,'4ca96640aa8d4e9cb1f8e226c7f9f37c','memB-1','agent.run',NULL,888,170,0.001228,2711,'2026-10-07 00:37:07');
INSERT INTO `agent_trace` VALUES (70,'0bd588c3d5a14970b642f5e93e749121','memC-1','agent.run',NULL,3440,449,0.004338,5479,'2026-10-07 00:37:13');
INSERT INTO `agent_trace` VALUES (71,'dd15cac7d6f54477a99a8d4a6b59e74b','mp-znpstq','agent.run',NULL,2994,336,0.003666,7936,'2026-10-07 15:08:23');
INSERT INTO `agent_trace` VALUES (72,'a79474c1a6cd41bfb76e12984a08856f','mp-znpstq','agent.run',NULL,1302,63,0.001428,1831,'2026-10-07 15:09:30');
INSERT INTO `agent_trace` VALUES (73,'43c7ce28a2f94b83aa6e75e9c45378f2','authtest','agent.run',NULL,730,49,0.000828,2691,'2026-10-07 15:14:58');
INSERT INTO `agent_trace` VALUES (74,'b5fc01225add4950b85ad80fe05bc934','final-auth','agent.run',NULL,730,54,0.000838,1723,'2026-10-07 15:54:31');
INSERT INTO `agent_trace` VALUES (75,'7923ccbbc28040e0bb9af50b16b9914a','mp-8p2qyw','agent.run',NULL,3850,463,0.004776,6944,'2026-10-07 16:14:50');
INSERT INTO `agent_trace` VALUES (76,'ee53467f9eba4814b6f0ffc41ddcc3dd','mp-8p2qyw','agent.run',NULL,1423,115,0.001653,2560,'2026-10-07 16:15:17');
INSERT INTO `agent_trace` VALUES (77,'5813a9b326d34bc7974252cf9dcb782d','mp-t6txnu','agent.run',NULL,1742,181,0.002104,3686,'2026-10-07 16:15:58');
INSERT INTO `agent_trace` VALUES (78,'a882ea18e19f4379861d91222e3f1b18','rag-1007','agent.run',NULL,953,119,0.001191,3606,'2026-10-07 16:35:20');
INSERT INTO `agent_trace` VALUES (79,'4e625a486cec41c68f980c7da1e3ef6e','mp-dkjag8','agent.run',NULL,951,162,0.001275,2664,'2026-10-07 16:38:49');
INSERT INTO `agent_trace` VALUES (80,'3e7eb5ae76144cf98a7991bb67631f64','mp-dkjag8','agent.run',NULL,4727,236,0.005199,6551,'2026-10-07 16:39:18');
INSERT INTO `agent_trace` VALUES (81,'6039f14f4f504d0383b5309909548a3d','mp-dkjag8','agent.run',NULL,5265,344,0.005953,6592,'2026-10-07 16:40:47');
INSERT INTO `agent_trace` VALUES (82,'54c98c447ef34d4e85c222972538c38d','mp-dkjag8','agent.run',NULL,2612,139,0.002890,3626,'2026-10-07 16:42:06');
INSERT INTO `agent_trace` VALUES (83,'3dcd0d8daf124cab8591884c203f8854','addr-1007','agent.run',NULL,946,58,0.001062,2105,'2026-10-07 16:47:13');
INSERT INTO `agent_trace` VALUES (84,'de92a7a1755c432f9dac725497ac5d66','addr-1007b','agent.run',NULL,7378,434,0.008246,9220,'2026-10-07 16:49:30');
INSERT INTO `agent_trace` VALUES (85,'1e93c3dce2104977a156c93d100b62a3','addr-1007c','agent.run',NULL,11935,511,0.012957,11450,'2026-10-07 16:51:13');
INSERT INTO `agent_trace` VALUES (86,'7f7a6b462f45419ea89d7fd9348b8a92','addr-1007c','agent.run',NULL,2953,200,0.003353,5103,'2026-10-07 16:51:47');
INSERT INTO `agent_trace` VALUES (87,'6a0731bd84204130b68624aba9f8fadf','addr-final','agent.run',NULL,1574,170,0.001914,3589,'2026-10-07 16:55:03');
INSERT INTO `agent_trace` VALUES (88,'9be9205007fb4cb8a7bdf073f2b39ca5','addr-final','agent.run',NULL,11052,498,0.012048,9497,'2026-10-07 16:55:32');
INSERT INTO `agent_trace` VALUES (89,'5b2cb8caf8654d3eba4bd54712a9316f','addr-final','agent.run',NULL,15714,650,0.017014,12545,'2026-10-07 16:55:45');
INSERT INTO `agent_trace` VALUES (90,'92dd0641b1a54e9a80efbb9a7e75d13d','addr-final','agent.run',NULL,4893,367,0.005627,6693,'2026-10-07 16:58:52');
INSERT INTO `agent_trace` VALUES (91,'82fb12052fdc430784a5978a292de475','addr-final2','agent.run',NULL,10491,340,0.011171,9571,'2026-10-07 17:03:06');
INSERT INTO `agent_trace` VALUES (92,'c3a8481cc0a14a3284d1dbf497c90d40','order-flow-test','agent.run',NULL,3057,253,0.003563,5309,'2026-10-07 21:35:17');
INSERT INTO `agent_trace` VALUES (93,'a1e6e66297f145a9b427ae25cd2d445e','flow2','agent.run',NULL,11085,477,0.012039,10319,'2026-10-07 21:36:05');
INSERT INTO `agent_trace` VALUES (94,'6d64e56929cb41b8b7225887276b90d9','mp-nrr3gb','agent.run',NULL,3216,278,0.003772,6024,'2026-10-08 11:34:17');
INSERT INTO `agent_trace` VALUES (95,'e4287191bc684cd6b339941325e472fc','mp-nrr3gb','agent.run',NULL,7688,265,0.008218,7942,'2026-10-08 11:34:58');
INSERT INTO `agent_trace` VALUES (96,'3ac85aa5e5fc4f0fb7870d1de87c7ab8','mp-nrr3gb','agent.run',NULL,2455,224,0.002903,4116,'2026-10-08 11:50:24');
INSERT INTO `agent_trace` VALUES (97,'389de585098e453ebe7abfae5fffe573','mp-nrr3gb','agent.run',NULL,10973,548,0.012069,10058,'2026-10-08 11:50:40');
INSERT INTO `agent_trace` VALUES (98,'42bba884ce20431bace1f63c509f609f','mp-nrr3gb','agent.run',NULL,5847,429,0.006705,7411,'2026-10-08 11:51:11');
INSERT INTO `agent_trace` VALUES (99,'10164ebaf9b1431dbd63bf4e98134458','test-spec-1','agent.run',NULL,3007,194,0.003395,4485,'2026-10-08 12:05:31');
INSERT INTO `agent_trace` VALUES (100,'3e9d6cb63f03463a88c6063744480d88','test-spec-3','agent.run',NULL,1457,66,0.001589,1909,'2026-10-08 12:05:48');
INSERT INTO `agent_trace` VALUES (101,'119c3052ad2749599506048b341dc158','test-e2e-1','agent.run',NULL,9065,289,0.009643,6693,'2026-10-08 12:06:03');
INSERT INTO `agent_trace` VALUES (102,'f911477690c642a895d07381b563e03b','test-e2e-2','agent.run',NULL,12071,481,0.013033,10130,'2026-10-08 12:06:28');
INSERT INTO `agent_trace` VALUES (103,'d49a7196f3e94da1a67a903bb14e2c35','test-bare-2','agent.run',NULL,2177,83,0.002343,2335,'2026-10-08 12:06:55');
INSERT INTO `agent_trace` VALUES (104,'6cebd7485d504d09adc4a4345b8b4f87','test-bare-3','agent.run',NULL,2275,119,0.002513,2388,'2026-10-08 12:07:04');
INSERT INTO `agent_trace` VALUES (105,'b142723499514fb88001fb9c228e90e5','verify-final-1','agent.run',NULL,2431,117,0.002665,3366,'2026-10-08 12:09:02');
INSERT INTO `agent_trace` VALUES (106,'08c06260e2c2443986afa637b30e7c18','verify-final-2','agent.run',NULL,2530,118,0.002766,3008,'2026-10-08 12:09:20');
INSERT INTO `agent_trace` VALUES (107,'df8f84b43b224cbd8fc20fcc40271e96','verify-final-3','agent.run',NULL,8649,217,0.009083,7169,'2026-10-08 12:10:34');
INSERT INTO `agent_trace` VALUES (108,'deb207d9626f4bba88b8c6b892002904','verify-final-4','agent.run',NULL,2681,39,0.002759,2475,'2026-10-08 12:11:29');
INSERT INTO `agent_trace` VALUES (109,'ed90a253550f4a3e80f6a31c99b02de2','verify-live-1','agent.run',NULL,2600,110,0.002820,2348,'2026-10-08 12:11:41');
INSERT INTO `agent_trace` VALUES (110,'2883a853d0ca46b9b273e38d026914d9','stab-1','agent.run',NULL,2736,62,0.002860,2614,'2026-10-08 12:13:11');
INSERT INTO `agent_trace` VALUES (111,'02cd87db4c324a10b0aff4203e305102','stab-2','agent.run',NULL,5979,70,0.006119,3881,'2026-10-08 12:13:17');
INSERT INTO `agent_trace` VALUES (112,'dc37b483518942309392d4f1257c0b47','stab-3','agent.run',NULL,5808,82,0.005972,4089,'2026-10-08 12:13:23');
INSERT INTO `agent_trace` VALUES (113,'ca8e06b781394a5d91e5413dd534f3b5','inspect-1','agent.run',NULL,2680,51,0.002782,2086,'2026-10-08 12:14:36');
INSERT INTO `agent_trace` VALUES (114,'818b6f74c92e4f3dab2c0ee5870d6eb5','addr-check-1','agent.run',NULL,2079,29,0.002137,1616,'2026-10-08 12:14:49');
INSERT INTO `agent_trace` VALUES (115,'ae00cf55f737406495fb9bf874a916a4','chk-55318029','agent.run',NULL,1968,18,0.002004,1903,'2026-10-08 12:15:10');
INSERT INTO `agent_trace` VALUES (116,'c9f765d0b77a40bbb4efb9ad43bd9bb4','final-1','agent.run',NULL,6709,388,0.007485,7206,'2026-10-08 12:17:49');
INSERT INTO `agent_trace` VALUES (117,'f8cd26cba7d7452ebb9907949a2c9c61','final-1','agent.run',NULL,3726,152,0.004030,3986,'2026-10-08 12:17:53');
INSERT INTO `agent_trace` VALUES (118,'35566b3b940549cf85cd94b8fe8c8ecf','final-2','agent.run',NULL,6592,200,0.006992,5386,'2026-10-08 12:17:59');
INSERT INTO `agent_trace` VALUES (119,'3cb0a25febb94ea1bf6d72b5af814413','final-3','agent.run',NULL,9424,387,0.010198,7603,'2026-10-08 12:18:06');
INSERT INTO `agent_trace` VALUES (120,'fc6d4558af80433893e4559a50096d26','final-3','agent.run',NULL,9872,426,0.010724,8878,'2026-10-08 12:18:15');
INSERT INTO `agent_trace` VALUES (121,'fd45fec505294702840814586bcd0fd6','v2-1','agent.run',NULL,7517,253,0.008023,6723,'2026-10-08 12:18:39');
INSERT INTO `agent_trace` VALUES (122,'db105a7f19224412a3a589a8a8eb7c7a','v2-2','agent.run',NULL,2360,101,0.002562,2362,'2026-10-08 12:18:41');
INSERT INTO `agent_trace` VALUES (123,'a6f63d40ca5b4559b980e38047259e52','v2-3','agent.run',NULL,2498,78,0.002654,2362,'2026-10-08 12:18:44');
INSERT INTO `agent_trace` VALUES (124,'f83e287662dd4798851355fee25d1f23','dbg-1','agent.run',NULL,2613,168,0.002949,2608,'2026-10-08 12:18:57');
INSERT INTO `agent_trace` VALUES (125,'094dfb5313be4c8684a369472c4a4096','dbg-1','agent.run',NULL,2585,97,0.002779,2588,'2026-10-08 12:19:00');
INSERT INTO `agent_trace` VALUES (126,'c189439a48e54a8381427c3ac49123e1','clean-1-723527649','agent.run',NULL,5870,126,0.006122,4761,'2026-10-08 12:19:23');
INSERT INTO `agent_trace` VALUES (127,'c66568fa4c0c4d8488192e38b4559120','clean-2-1981281706','agent.run',NULL,2797,122,0.003041,2746,'2026-10-08 12:19:26');
INSERT INTO `agent_trace` VALUES (128,'ecffc36dd36e449082d74b5f28bb15ce','clean-3-1515387867','agent.run',NULL,2797,106,0.003009,2380,'2026-10-08 12:19:28');
INSERT INTO `agent_trace` VALUES (129,'5d974da8ced14b5ea96833881546c93f','fresh-1475921821','agent.run',NULL,3897,93,0.004083,3203,'2026-10-08 12:19:49');
INSERT INTO `agent_trace` VALUES (130,'64c12bc665784a9e92b017fc2fd40b74','say-170616520','agent.run',NULL,3888,100,0.004088,3384,'2026-10-08 12:20:03');
INSERT INTO `agent_trace` VALUES (131,'ac649bdb1c664de6a4412d305920c2b1','fix-1-1215261601','agent.run',NULL,7058,157,0.007372,6461,'2026-10-08 12:22:16');
INSERT INTO `agent_trace` VALUES (132,'2f6d7d4729f74829b61a51619ba289bd','fix-2-1845102037','agent.run',NULL,6520,215,0.006950,6003,'2026-10-08 12:22:23');
INSERT INTO `agent_trace` VALUES (133,'df9842dc36f24e038482249a936d937b','fix-3-215655316','agent.run',NULL,1978,95,0.002168,1815,'2026-10-08 12:22:25');
INSERT INTO `agent_trace` VALUES (134,'8a582fd99b3b40758c0d1882dd25cf49','trace-1304371219','agent.run',NULL,6663,190,0.007043,6093,'2026-10-08 12:22:41');
INSERT INTO `agent_trace` VALUES (135,'178cefeb64fe41878337d491d39dcc43','ok-1150518867','agent.run',NULL,6386,266,0.006918,5720,'2026-10-08 12:22:56');
INSERT INTO `agent_trace` VALUES (136,'49ccb0c221ab4b5b86a7fe57eb45db09','stab-1-2082943298','agent.run',NULL,6354,250,0.006854,4867,'2026-10-08 12:23:18');
INSERT INTO `agent_trace` VALUES (137,'3da8fd7ded6846428cdf91856311f293','stab-2-211888743','agent.run',NULL,6388,275,0.006938,6084,'2026-10-08 12:23:25');
INSERT INTO `agent_trace` VALUES (138,'2bed8a938d34425eb6e017b81ba2351c','stab-3-1488929635','agent.run',NULL,6358,251,0.006860,6001,'2026-10-08 12:23:31');
INSERT INTO `agent_trace` VALUES (139,'c6e82c379c314b25900e3541df3a6eed','diag-132576696','agent.run',NULL,7072,194,0.007460,6401,'2026-10-08 12:23:48');
INSERT INTO `agent_trace` VALUES (140,'34b55c6767b74f05b768cf1b1a99a172','R1-2096979342','agent.run',NULL,7086,449,0.007984,6763,'2026-10-08 12:24:04');
INSERT INTO `agent_trace` VALUES (141,'b48d32511a4649b6a647c9bf424cf6fe','R2-587841070','agent.run',NULL,7038,316,0.007670,6224,'2026-10-08 12:24:10');
INSERT INTO `agent_trace` VALUES (142,'7b5ea3a7d6fa406e992ff84c400da38d','R3-176856116','agent.run',NULL,6331,224,0.006779,6203,'2026-10-08 12:24:16');
INSERT INTO `agent_trace` VALUES (143,'a049723b11554b3fa06fbbac6df43a0f','X-643607385','agent.run',NULL,6372,253,0.006878,5610,'2026-10-08 12:24:32');
INSERT INTO `agent_trace` VALUES (144,'724668bd57a84978bda6baabb6b28c72','F1-1480159895','agent.run',NULL,10468,281,0.011030,8687,'2026-10-08 12:26:00');
INSERT INTO `agent_trace` VALUES (145,'87ccdb2e05cb4841adda95163996f597','F2-1882349966','agent.run',NULL,10483,287,0.011057,8539,'2026-10-08 12:26:09');
INSERT INTO `agent_trace` VALUES (146,'059b078eb54549c3afa3fd795d4c4a26','F3-397601099','agent.run',NULL,7040,324,0.007688,6540,'2026-10-08 12:26:16');
INSERT INTO `agent_trace` VALUES (147,'10e76745280b40658f7746fd2b0db316','T-1938028666','agent.run',NULL,6368,261,0.006890,6327,'2026-10-08 12:26:53');
INSERT INTO `agent_trace` VALUES (148,'abf3504c17f5436bbb588da4ee076f4a','mp-8hir8v','agent.run',NULL,3514,123,0.003760,4712,'2026-10-08 14:43:26');
INSERT INTO `agent_trace` VALUES (149,'2db323f6d7844cc3b256e249b5fc49a0','search-1395158568','agent.run',NULL,4648,216,0.005080,5984,'2026-10-08 14:55:46');
INSERT INTO `agent_trace` VALUES (150,'563e542915c640f293f8cf4a640ba329','addr-285645159','agent.run',NULL,10651,299,0.011249,14772,'2026-10-08 14:56:13');
INSERT INTO `agent_trace` VALUES (151,'9757437af16a4538b0849c4ad9f3970e','full-1569154003','agent.run',NULL,8082,372,0.008826,7638,'2026-10-08 14:56:34');
INSERT INTO `agent_trace` VALUES (152,'4fe521f4ed0f4066bf74cacfba24cd49','full-1569154003','agent.run',NULL,10457,369,0.011195,8682,'2026-10-08 14:56:43');
INSERT INTO `agent_trace` VALUES (153,'05f2724937ee4ee4abbc6ef9a40f9e7a','E2E-420782461','agent.run',NULL,8075,192,0.008459,7068,'2026-10-08 14:57:05');
INSERT INTO `agent_trace` VALUES (154,'7b77a99e0ee74f139aa97ec759206305','E2E-420782461','agent.run',NULL,3710,83,0.003876,4090,'2026-10-08 14:57:09');
INSERT INTO `agent_trace` VALUES (155,'a968164e0f86442781e4dab77c6c2eec','E2E-420782461','agent.run',NULL,2192,76,0.002344,2725,'2026-10-08 14:57:12');
INSERT INTO `agent_trace` VALUES (156,'aa6ddb3091fa4d92ae29c6c16b41e202','D-536842420','agent.run',NULL,8078,181,0.008440,6357,'2026-10-08 14:57:35');
INSERT INTO `agent_trace` VALUES (157,'e5abe8d967974c348653d6699b71b6fb','D-536842420','agent.run',NULL,3688,132,0.003952,4504,'2026-10-08 14:57:39');
INSERT INTO `agent_trace` VALUES (158,'e7f408938406416f90d96e1b23c2d5e0','FIN-131875476','agent.run',NULL,7385,208,0.007801,9210,'2026-10-08 14:59:52');
INSERT INTO `agent_trace` VALUES (159,'e9d89de4748b46c093d09829795c38d7','FIN-131875476','agent.run',NULL,4055,185,0.004425,5078,'2026-10-08 14:59:57');
INSERT INTO `agent_trace` VALUES (160,'770341d8c1ac486f92132ed05d3a3914','V1-1651698305','agent.run',NULL,8069,349,0.008767,13355,'2026-10-08 15:03:12');
INSERT INTO `agent_trace` VALUES (161,'d37f729065574a9780f36c89d158a6b9','V1-1651698305','agent.run',NULL,12543,405,0.013353,18023,'2026-10-08 15:03:30');
INSERT INTO `agent_trace` VALUES (162,'9936d7a9e62342af8a47c07fd6ae8ab4','V2-1095199480','agent.run',NULL,10583,237,0.011057,13391,'2026-10-08 15:03:44');
INSERT INTO `agent_trace` VALUES (163,'e1c92f0171cd4a34be9f3bd8a2ae500a','V2-1095199480','agent.run',NULL,1798,159,0.002116,3761,'2026-10-08 15:03:48');
INSERT INTO `agent_trace` VALUES (164,'627639f5a4444f46bdda9a41ec95e379','V2-1095199480','agent.run',NULL,2195,212,0.002619,3677,'2026-10-08 15:03:51');
INSERT INTO `agent_trace` VALUES (165,'1aa993db60334752a7fe016683a48f40','mp-8wny11','agent.run',NULL,1650,207,0.002064,3473,'2026-10-08 15:08:08');
INSERT INTO `agent_trace` VALUES (166,'f326d64524084ce3bb7c2bd03a1c795e','mp-8wny11','agent.run',NULL,2319,130,0.002579,2943,'2026-10-08 15:08:37');
INSERT INTO `agent_trace` VALUES (167,'fa1eac081e154d64bac3c1336f1b7aa1','mp-8wny11','agent.run',NULL,4495,206,0.004907,4621,'2026-10-08 15:09:11');
INSERT INTO `agent_trace` VALUES (168,'5bdbd5c129ad4f739a8045ce8b323886','mp-8wny11','agent.run',NULL,4491,92,0.004675,4020,'2026-10-08 15:09:50');
INSERT INTO `agent_trace` VALUES (169,'5543127c8e0d45cb9fac81c63eaf9c18','mp-8wny11','agent.run',NULL,2237,71,0.002379,2187,'2026-10-08 15:10:10');
INSERT INTO `agent_trace` VALUES (170,'33a932a0bf3444ef9726b60f705279c0','mp-8wny11','agent.run',NULL,8146,232,0.008610,6513,'2026-10-08 15:10:29');
INSERT INTO `agent_trace` VALUES (171,'34d022d9a6004187a50b315c72d541b0','ONE-975729239','agent.run',NULL,0,0,0.000000,31249,'2026-10-08 15:28:33');
INSERT INTO `agent_trace` VALUES (172,'04e0981bcad043ffb2b778f46fe7880f','S1-48395389','agent.run',NULL,7535,276,0.008087,15891,'2026-10-08 15:32:04');
INSERT INTO `agent_trace` VALUES (173,'6c76053c8c834142ab1911f878240655','S2-1893147757','agent.run',NULL,10043,271,0.010585,29465,'2026-10-08 15:32:57');
INSERT INTO `agent_trace` VALUES (174,'7ccbfd06c44e4b61919e5852cdf4f3bb','F1-410879023','agent.run',NULL,7463,229,0.007921,6643,'2026-10-08 15:37:36');
INSERT INTO `agent_trace` VALUES (175,'cdf2e200e7e64d4088a63b1e4407c549','F2-227659435','agent.run',NULL,7467,203,0.007873,6470,'2026-10-08 15:37:44');
INSERT INTO `agent_trace` VALUES (176,'d94c4190be284456b0261c5dc4ec97cf','mp-8po00o','agent.run',NULL,6403,368,0.007139,5343,'2026-10-08 17:04:04');
INSERT INTO `agent_trace` VALUES (177,'163ddaf92f484aa09d3a400ed2b89aad','mp-8po00o','agent.run',NULL,2006,63,0.002132,2285,'2026-10-08 17:04:57');
INSERT INTO `agent_trace` VALUES (178,'517209409ff44e11b102a8c0e86ff784','mp-8po00o','agent.run',NULL,2037,54,0.002145,2000,'2026-10-08 17:05:05');
INSERT INTO `agent_trace` VALUES (179,'ec0917a510b34913a3cfbc772b67367f','CART-1578470329','agent.run',NULL,6907,182,0.007271,7278,'2026-10-08 17:17:18');
INSERT INTO `agent_trace` VALUES (180,'3f450d8f9ea040e79e6596beec4224a0','T1-1004595575','agent.run',NULL,6863,150,0.007163,6223,'2026-10-08 17:19:15');
INSERT INTO `agent_trace` VALUES (181,'0e5c616e927c409cbeb91cc15e7cc240','T2-1000565223','agent.run',NULL,6979,139,0.007257,5624,'2026-10-08 17:19:41');
INSERT INTO `agent_trace` VALUES (182,'f7a0be8eae004635829019fd48b5c361','mp-aolo77','agent.run',NULL,5331,215,0.005761,4568,'2026-10-08 17:23:41');
INSERT INTO `agent_trace` VALUES (183,'1c137bf3817f4b0384ca8391ae7b6f82','mp-aolo77','agent.run',NULL,11402,229,0.011860,7803,'2026-10-08 17:24:13');
INSERT INTO `agent_trace` VALUES (184,'df97f06184d74f0b8adb9a2c6c9fd551','REC-296286144','agent.run',NULL,9625,180,0.009985,7168,'2026-10-08 17:47:19');
INSERT INTO `agent_trace` VALUES (185,'1502ced165804700bab13d11a1927dc4','H-1173253276','agent.run',NULL,9611,159,0.009929,6101,'2026-10-08 17:48:22');
INSERT INTO `agent_trace` VALUES (186,'bad9351d7c1b454ba74deb6020f41047','mp-cszpyzzp','agent.run',NULL,9818,149,0.010116,6174,'2026-10-08 17:56:43');
INSERT INTO `agent_trace` VALUES (187,'914a8c38f2134be082f97440c9bef162','mp-cszpyzzp','agent.run',NULL,2464,70,0.002604,2427,'2026-10-08 18:01:45');
INSERT INTO `agent_trace` VALUES (188,'dabe3cc7895b41f283d50e925de7696b','mp-cszpyzzp','agent.run',NULL,8806,192,0.009190,6739,'2026-10-08 18:02:06');
INSERT INTO `agent_trace` VALUES (189,'b9c84cef8ab64a64a0b5a54770d90674','FIX-1594773158','agent.run',NULL,11448,278,0.012004,8150,'2026-10-08 18:14:53');
INSERT INTO `agent_trace` VALUES (190,'1be153e4bb684356af319cb3b1304dae','FIX-1594773158','agent.run',NULL,7918,136,0.008190,5766,'2026-10-08 18:15:17');
INSERT INTO `agent_trace` VALUES (191,'11836302c2e948ae93b613c3dcac01bb','mp-cszpyzzp','agent.run',NULL,2099,52,0.002203,2516,'2026-10-08 18:28:05');
INSERT INTO `agent_trace` VALUES (192,'5b81ca0181df4a0296eba649e610cbb2','mp-cszpyzzp','agent.run',NULL,18138,275,0.018688,8936,'2026-10-08 18:28:42');
INSERT INTO `agent_trace` VALUES (193,'5ba3beb0fce64fed958a38f7891fb1fe','2P-1032489355','agent.run',NULL,14460,329,0.015118,9863,'2026-10-08 18:41:20');
INSERT INTO `agent_trace` VALUES (194,'137a5f70d56e4a54824ef8df0ae7498e','2P-1032489355','agent.run',NULL,2396,12,0.002420,1806,'2026-10-08 18:41:48');
INSERT INTO `agent_trace` VALUES (195,'dd533e0ee61840c58ed217c588c15ee6','chk-1762379999','agent.run',NULL,5556,154,0.005864,4808,'2026-10-08 18:59:08');
INSERT INTO `agent_trace` VALUES (196,'370731425c144067a60f2c63bd162a2b','FULL-1866477959','agent.run',NULL,9893,201,0.010295,7591,'2026-10-08 19:01:13');
INSERT INTO `agent_trace` VALUES (197,'8269c4d8eac6420683d58d7f038e173d','FULL-1866477959','agent.run',NULL,8277,131,0.008539,5342,'2026-10-08 19:01:39');
INSERT INTO `agent_trace` VALUES (198,'92cad1f2db0d4c7196c249cc10516443','FULL-1866477959','agent.run',NULL,2419,31,0.002481,2066,'2026-10-08 19:02:09');
INSERT INTO `agent_trace` VALUES (199,'45b7ffe4afcc4eb8a23edc2d11e40bc1','T-1179179767','agent.run',NULL,9884,196,0.010276,7245,'2026-10-08 19:06:35');
INSERT INTO `agent_trace` VALUES (200,'db1f62f03db84f74b8f3f723420ca6ef','T-1179179767','agent.run',NULL,5217,120,0.005457,4277,'2026-10-08 19:06:39');
INSERT INTO `agent_trace` VALUES (201,'75b710117b74493a972409255cdec6e0','T-431924571','agent.run',NULL,15589,301,0.016191,8267,'2026-10-08 19:06:47');
INSERT INTO `agent_trace` VALUES (202,'8de0924bc9374763ab43c9943465c646','T-431924571','agent.run',NULL,2395,16,0.002427,1859,'2026-10-08 19:06:49');
INSERT INTO `agent_trace` VALUES (203,'24212d9775864b0a8584be2ab72a8059','T-1140557788','agent.run',NULL,16116,282,0.016680,8499,'2026-10-08 19:06:58');
INSERT INTO `agent_trace` VALUES (204,'6fa54714504142a9805e1350df4473ae','T-1140557788','agent.run',NULL,10823,230,0.011283,6671,'2026-10-08 19:07:05');
INSERT INTO `agent_trace` VALUES (205,'42d8bf77b5c347ff94e64885de29cf7e','U-77181420','agent.run',NULL,15611,302,0.016215,9591,'2026-10-08 19:12:56');
INSERT INTO `agent_trace` VALUES (206,'ce70ce304f6f4477b7b04a28b0fd9ac6','U-77181420','agent.run',NULL,8423,208,0.008839,6339,'2026-10-08 19:13:02');
INSERT INTO `agent_trace` VALUES (207,'785c2a278dd9452b94f00c16deac1766','U-1503244195','agent.run',NULL,9896,205,0.010306,6431,'2026-10-08 19:13:09');
INSERT INTO `agent_trace` VALUES (208,'fcc7603d7540446eabce104051260acc','U-1503244195','agent.run',NULL,2375,59,0.002493,1960,'2026-10-08 19:13:11');
INSERT INTO `agent_trace` VALUES (209,'211f8ddda44149f197e896b567638fa3','U-666641182','agent.run',NULL,9897,199,0.010295,5716,'2026-10-08 19:13:17');
INSERT INTO `agent_trace` VALUES (210,'580de191d32d453688d5677183905daa','U-666641182','agent.run',NULL,10778,196,0.011170,6097,'2026-10-08 19:13:23');
INSERT INTO `agent_trace` VALUES (211,'933f077df8bb43538e902768525e2c9b','E-665415600','agent.run',NULL,9992,288,0.010568,6358,'2026-10-08 19:13:52');
INSERT INTO `agent_trace` VALUES (212,'3d4be1acf6954b85a036d14475912a11','E-665415600','agent.run',NULL,8280,172,0.008624,5437,'2026-10-08 19:13:58');
INSERT INTO `agent_trace` VALUES (213,'d18861476e2342b8ad08fd521dbd57f0','mp-cszpyzzp','agent.run',NULL,16707,376,0.017459,9823,'2026-10-10 12:54:42');
INSERT INTO `agent_trace` VALUES (214,'c0be8871c8a14b9a988d61949ef7ba2f','mp-cszpyzzp','agent.run',NULL,6585,143,0.006871,4418,'2026-10-10 12:55:06');
INSERT INTO `agent_trace` VALUES (215,'e779bfcb9c0949b6a23948509d1ef741','mp-cszpyzzp','agent.run',NULL,5040,51,0.005142,3539,'2026-10-10 12:55:26');
INSERT INTO `agent_trace` VALUES (216,'3d540bb3c6dc46a485716cae7f3b935b','mp-2giilno9','agent.run',NULL,2664,286,0.003236,5938,'2026-10-10 15:20:37');
INSERT INTO `agent_trace` VALUES (217,'a5614844914b49b998f4c1591827d949','llm-verify-001','agent.run','cart',4399,85,0.004569,6631,'2026-10-23 13:30:27');
INSERT INTO `agent_trace` VALUES (218,'cfg-1792733871768','admin','config.model_switch','switch:glm-5.3-flash',0,0,0.000000,0,'2026-10-23 13:37:51');
INSERT INTO `agent_trace` VALUES (219,'93212693619f4374b37d0a62fc1d4572','glm-verify-001','agent.run','fallback',9719,144,0.010007,23862,'2026-10-23 13:38:26');
INSERT INTO `agent_trace` VALUES (220,'cfg-1792733916195','admin','config.model_switch','switch:deepseek-v4.1-flash',0,0,0.000000,0,'2026-10-23 13:38:36');
INSERT INTO `agent_trace` VALUES (221,'cfg-1792736840306','admin','config.model_switch','switch:deepseek-v4.1-flash',0,0,0.000000,0,'2026-10-23 14:27:20');
INSERT INTO `agent_trace` VALUES (222,'5d2fcbac10774f10b52c8027630bd422','director-smoke-1','agent.run','fallback',2212,78,0.002368,4296,'2026-10-23 20:33:54');
INSERT INTO `agent_trace` VALUES (223,'98cd9d5ee80f4fb98c910664eecc24e8','director-smoke-2','agent.run','fallback',17587,500,0.018587,9234,'2026-10-23 20:34:20');
INSERT INTO `agent_trace` VALUES (224,'0cf6963f925f48c0a28394bae72d1b43','director-smoke-3','agent.run','fallback',5411,133,0.005677,3644,'2026-10-23 20:34:33');
INSERT INTO `agent_trace` VALUES (225,'4e115d73eaf449cf80ff5c159effd63e','fix-verify-2','agent.run','fallback',0,0,0.000000,9351,'2026-10-23 21:40:43');
INSERT INTO `agent_trace` VALUES (226,'cfg-1792815113549','admin','config.model_switch','switch:qwen-plus',0,0,0.000000,0,'2026-10-24 12:11:53');
INSERT INTO `agent_trace` VALUES (227,'cfg-1792815121362','admin','config.model_switch','switch:deepseek-v4.1-flash',0,0,0.000000,0,'2026-10-24 12:12:01');
/*!40000 ALTER TABLE `agent_trace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eval_case`
--

DROP TABLE IF EXISTS `eval_case`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eval_case` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `question` text NOT NULL COMMENT '测试问题',
  `ground_truth` text NOT NULL COMMENT '标准答案',
  `expected_chunk_ids` varchar(500) DEFAULT NULL COMMENT '期望命中的 chunk',
  `category` varchar(32) DEFAULT NULL COMMENT '分类：茶知识/商品/多轮指代',
  `difficulty` varchar(16) DEFAULT 'normal',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_category` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='RAG 评估集';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eval_case`
--

LOCK TABLES `eval_case` WRITE;
/*!40000 ALTER TABLE `eval_case` DISABLE KEYS */;
INSERT INTO `eval_case` VALUES (1,'明前龙井和雨前龙井有什么区别？','采摘时间不同：明前为清明前，芽叶细嫩、滋味鲜爽、价高；雨前为清明后谷雨前，叶稍大、滋味更浓、价相对低。','1,2,157','茶知识','normal','2026-10-03 23:03:12');
INSERT INTO `eval_case` VALUES (2,'绿茶应该用多少度的水冲泡？','建议 80-85℃，避免沸水烫熟茶叶导致苦涩。','5,130,141','茶知识','easy','2026-10-03 23:03:12');
INSERT INTO `eval_case` VALUES (3,'白茶有哪些分类？','白毫银针、白牡丹、贡眉、寿眉四类。','4,108','茶知识','easy','2026-10-03 23:03:12');
INSERT INTO `eval_case` VALUES (10,'明前龙井和雨前龙井有什么区别？','采摘时间不同：明前为清明前，芽叶细嫩、氨基酸高、鲜爽甘甜、价高；雨前为清明后谷雨前，叶稍大、茶多酚略高、滋味更浓、价格亲民。','1,2,157','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (11,'西湖龙井的产地和品质特征是什么？','产于杭州西湖区，扁平挺直、色翠略黄似糙米色，香气清高带豆香或兰花香，滋味鲜爽甘醇；核心产区为狮峰、龙井、云栖、虎跑、梅家坞。','102,156','茶知识','easy','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (12,'洞庭碧螺春的品质特点是什么？','产于江苏苏州太湖洞庭山，条索纤细卷曲如螺、满披白毫，清香持久，有\"一嫩三鲜\"之誉，常带天然花果香。','103','茶知识','easy','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (13,'白毫银针是什么茶？','白茶中最高等级，产于福建福鼎、政和，全由肥壮单芽制成，满披白毫、挺直如针，汤色浅杏黄，毫香显露，滋味清鲜醇和。','109','茶知识','easy','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (14,'金骏眉为什么价格昂贵？','2005 年创制的顶级红茶，全由单芽制成，数万颗芽头才得一斤干茶，原料珍稀、产量少，故价格高昂且市面仿品极多。','122','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (15,'祁门红茶的香气有什么特点？','香气浓郁带玫瑰花香，称\"祁门香\"，是世界三大高香红茶之一；滋味鲜醇甘厚，汤色红艳明亮，适合清饮与调饮。','123','茶知识','easy','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (16,'武夷岩茶的\"岩韵\"是什么？','因茶树生长于岩缝之中形成的独特韵味：香气辛锐、滋味醇厚、回甘明显、喉韵深长。代表品种有大红袍、肉桂、水仙等。','116','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (17,'凤凰单丛有哪些香型？','按香型分蜜兰香、黄枝香、芝兰香、桂花香、玉兰香、姜花香、夜来香、茉莉香、杏仁香、肉桂香十大香型，香气高锐持久。','118','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (18,'普洱茶生茶和熟茶有什么区别？','生茶以晒青毛茶为原料自然陈化，新茶汤色黄绿、滋味强烈带青味，随年份转化；熟茶经人工渥堆发酵，汤色红浓、滋味醇厚顺滑带陈香，可即时饮用。','126','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (19,'六堡茶的槟榔香是怎么来的？','六堡茶产于广西梧州苍梧县六堡镇，属黑茶，以\"红浓陈醇\"著称并带独特槟榔香；历史上经茶船古道远销南洋，因耐储存、解暑祛湿而流行。','127','茶知识','hard','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (20,'安化黑茶里的\"金花\"是什么？','指茯砖茶渥堆后\"发花\"生长的冠突散囊菌，使茶汤更醇和并带独特菌花香。安化黑茶传统品类有三尖、三砖、一卷。','128','茶知识','hard','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (21,'君山银针冲泡时为什么\"三起三落\"？','君山银针属黄芽茶，芽头肥壮挺直、满披茸毛；冲泡时芽尖冲向水面悬空竖立、继而徐徐下沉，形成三起三落的茶中奇观。','113','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (22,'太平猴魁的外形有什么特点？','属烘青绿茶，产于安徽黄山太平猴坑一带，两叶抱芽、扁平挺直、自然舒展，白毫隐伏，有\"猴魁两头尖，不散不翘不卷边\"之称。','106','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (23,'安吉白茶是白茶吗？','不是。安吉白茶实为绿茶——因茶树品种\"白叶一号\"在低温期叶色玉白而得名，加工工艺是杀青绿茶工艺；氨基酸含量高达 6% 以上，故滋味特别鲜爽。','107','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (24,'信阳毛尖的品质特征是什么？','产于河南信阳，属炒青绿茶，外形细圆光直多白毫、色泽翠绿，香气清高带熟栗子香，滋味醇厚鲜爽，汤色嫩绿明亮。','105','茶知识','easy','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (25,'黄山毛峰的\"黄金片\"是什么？','黄山毛峰属烘青绿茶，色如象牙，带金黄色鱼叶，俗称\"黄金片\"；香气清鲜高长，滋味醇厚回甘，特级采一芽一叶初展。','104','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (30,'怎么泡茶才不苦？','控制水温与出汤时间：绿茶 80-85℃ 忌沸水直冲；普洱生茶快出汤避免闷出苦涩；红茶 90-95℃ 且 3-5 秒出汤。','130,137,141','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (31,'为什么喝茶提神但不像喝咖啡那么亢奋？','茶叶中的茶氨酸能促进 α 脑波产生、放松神经，并拮抗咖啡碱的过度兴奋，二者协同形成茶特有的\"清醒的平静\"。','208','茶知识','hard','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (32,'晚上喝茶会不会睡不着？','取决于咖啡因摄入：建议睡前 3 小时不饮浓茶；冷泡可显著降低咖啡碱析出量；茶氨酸的放松作用也有一定缓冲。','210,207','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (33,'喝茶能减肥吗？','茶多酚与咖啡碱可协同促进脂肪氧化、提高基础代谢率（研究显示约 3-4%），但长期减重效果有限，需配合饮食与运动；含泻药成分的\"减肥茶\"不宜长期饮用。','213','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (34,'缺铁性贫血的人能喝茶吗？','应限制：茶中鞣酸会与非血红素铁（植物性铁）结合抑制吸收，建议餐后 1 小时再饮，可选发酵度较高的红茶。','212','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (35,'孕妇能喝茶吗？','建议限制：咖啡因可通过胎盘与乳汁，孕期每日咖啡因摄入宜低于 200 毫克并选淡茶。','211','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (36,'茶叶放冰箱要注意什么？','必须密封避免串味；分装小份避免反复取用造成温差结露；绿茶与清香乌龙适合冷藏，红茶、黑茶、白茶不宜冷藏；取出后需回温再开封。','166,162','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (37,'茶叶为什么会串味？','茶叶为多孔结构、吸附性极强，极易吸附周围气味（樟脑、调料、化妆品等）。储存需避光、密封、防潮、远离异味。','161','茶知识','easy','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (38,'怎么判断茶叶是不是坏了？','闻有无霉味酸味油哈味；看干茶是否发暗、长白霜绿毛；摸是否发软成团；泡后汤色是否浑浊发暗、滋味寡淡。霉变茶必须丢弃。','168','茶知识','easy','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (39,'茶汤为什么会有苦涩味？','苦味来自咖啡碱、茶皂素与黄酮类，涩感来自茶多酚与唾液蛋白结合的收敛作用。关键看能否\"化得开\"：优质茶苦涩后迅速回甘。','145','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (40,'什么是回甘？','指饮后口腔由苦转甜的转化感，源于茶多酚与唾液蛋白结合后的收敛消退；与\"生津\"\"喉韵\"共同构成好茶的体感层次。','144','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (41,'陈香和霉味怎么区分？','陈香是良好仓储中缓慢转化产生的醇和香气（木香、药香、枣香），闻之舒适；霉味是受潮霉变的刺鼻闷浊土腥味，茶汤浑浊发暗。前者是价值，后者是变质。','146','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (42,'茶叶能放多久？','绿茶常温约 12 个月（冷藏可延至 18 个月）；红茶 2-3 年；清香乌龙 18 个月、浓香岩茶 2-3 年；白茶与黑茶条件合适可长期存放。注意\"保质期\"与\"最佳品饮期\"不同。','167','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (43,'白茶的新茶和老茶有什么区别？','以白茶为例：新白茶性凉、毫香清鲜；陈放 3 年以上转化出枣香药香、茶性转平，适合煮饮；7 年以上汤色橙红、滋味醇厚。需注意辨别做旧茶。','158,108,109,110,111','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (44,'怎么挑绿茶？','一看外形（条索紧结匀整、色泽嫩绿有光泽）；二闻香气（清高纯正无异味）；三看汤色（清亮不浑浊）；四品滋味（鲜爽回甘不苦涩）。新茶香气最佳。','155','茶知识','easy','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (45,'网上买茶怎么避坑？','警惕价格背离成本的\"9.9 元古树茶\"；看生产日期而非保质期；要求检测报告；注意\"明前特级\"等标签是否有标准支撑；优先可退换商家并收到后立即试泡。','169','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (46,'送长辈什么茶合适？','不常喝茶者宜红茶或白茶（接受度高）；老茶客宜岩茶、普洱；绿茶需冷藏不宜长途送礼。绿茶礼盒适合春季与长辈，红茶礼盒四季皆宜、商务稳妥。','174','茶知识','easy','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (47,'紫砂壶怎么养？','专壶专用（一把壶只泡一类茶）；用后及时清水冲洗、忌洗洁精；自然阴干忌暴晒；泡茶时用茶汤淋壶身，长期使用形成温润包浆。','176','茶知识','easy','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (48,'紫砂壶能泡绿茶吗？','不推荐。紫砂双气孔结构会吸附绿茶清扬的香气并闷熟茶叶；紫砂更适合乌龙、普洱。绿茶宜用玻璃杯或白瓷盖碗。','139','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (49,'新买的紫砂壶怎么处理？','需要\"开壶\"：清水洗净后放入锅中加水没过壶身，小火煮沸后加少量日后要泡的茶叶，继续煮 20-30 分钟，取出自然冷却晾干。切忌骤冷骤热。','175','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (50,'茶具能用洗洁精洗吗？','不能。洗洁精残留会污染茶味，紫砂还会吸附化学气味。也不宜用钢丝球刮擦。白瓷茶垢可用小苏打或牙膏轻擦，紫砂包浆应保留。','184','茶知识','easy','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (51,'紫砂壶为什么会裂开？','\"惊裂\"由温差骤变引起：冬季冷水壶直接注沸水、开壶时沸水投冷水、清洗后立即冲烫。预防方法是使用前先用温水\"温壶\"逐步升温。','188','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (52,'泡茶用什么水比较好？','首选山泉水（矿物质适中、活性好），次选纯净水；硬水会使茶汤浑浊发涩、香气沉闷。理想 TDS 为 30-80 mg/L，过高建议先用净水器过滤。','140,154','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (53,'乌龙茶为什么一定要用沸水泡？','乌龙茶发酵度较高、叶片厚实，低温无法激发香气，必须用 100℃ 沸水；且投茶量大（约占壶容 1/3 至 1/2），快冲快出可冲泡七次以上。','133','茶知识','easy','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (54,'绿茶能用开水泡吗？','不建议。绿茶应用 80-85℃ 水，沸水会烫熟茶叶、破坏叶绿素，使茶汤发黄发苦。投茶量约 3 克配 150 毫升水，宜用玻璃杯或白瓷盖碗。','130','茶知识','easy','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (55,'冬天适合喝什么茶？','从茶性看：红茶全发酵性温、黑茶后发酵性温和，适合冬季与虚寒体质；绿茶性寒、白茶性凉，更适合夏季或燥热体质。','129,216','茶知识','easy','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (56,'体寒的人适合喝什么茶？','阳虚/虚寒体质（手脚冰凉、怕冷）宜温性茶：红茶、熟普、重焙火乌龙；阴虚燥热体质宜凉性茶：绿茶、新白茶、黄茶。','216,129','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (57,'什么是茶禅一味？','源于宋代禅宗，指茶道与禅修在精神上相通——茶的清苦回甘与静心品饮契合\"明心见性\"的修行；唐代赵州从谂\"吃茶去\"公案为经典表达。','196','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (58,'陆羽是谁？','唐代人，被尊为\"茶圣\"，著《茶经》（约 780 年）——世界第一部茶学专著，系统论述茶的起源、采制、煮饮与产区，标志中国茶文化正式形成。','191','茶知识','easy','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (59,'宋代人是怎么喝茶的？','流行点茶法与斗茶：茶末置盏中注入少量沸水调膏，用茶筅击拂形成细腻白色沫饽，以\"咬盏\"为佳；斗茶比较沫饽颜色与持久度，后传入日本演变为抹茶道。','193','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (70,'工夫茶的\"四宝\"指什么？','潮汕工夫茶器具四宝：玉书碨（烧水壶）、潮汕炉（风炉）、孟臣罐（紫砂小壶）、若琛瓯（小茶杯）；讲究高冲低斟、刮沫淋盖、关公巡城、韩信点兵。','199','茶文化','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (71,'岩茶和铁观音有什么区别？','铁观音属闽南乌龙、发酵度较低（15-30%）、清香型、香气清高带兰花香、汤色金黄；武夷岩茶属闽北乌龙、发酵度较高（30-60%）、焙火重、讲究\"岩骨花香\"、汤色橙红、滋味更醇厚带火功香。','119','茶知识','hard','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (72,'白茶按采摘标准分哪几类？','分白毫银针（单芽）、白牡丹（一芽一二叶）、贡眉与寿眉（一芽二三叶及叶片）。工艺极简，仅萎凋与干燥。','108,4','茶知识','easy','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (73,'黑茶为什么能长期存放？','黑茶属后发酵茶，渥堆使微生物参与转化，且需\"呼吸\"继续陈化。宜用透气材质包装，存于阴凉干燥通风处（湿度 60-70%、温度 20-28℃），避免密封死与异味。','164,125','茶知识','normal','2026-10-07 17:53:45');
INSERT INTO `eval_case` VALUES (100,'铁观音和大红袍哪个发酵程度更高？','大红袍（武夷岩茶，闽北乌龙）发酵度约 30-60%，高于铁观音（闽南乌龙）的 15-30%；岩茶焙火重、汤色橙红，铁观音清香、汤色金黄。','119,115,117','茶知识','hard','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (101,'安吉白茶和白毫银针是同一种茶吗？','不是。安吉白茶是绿茶（茶树品种白叶一号，杀青工艺）；白毫银针是白茶（微发酵，仅萎凋干燥，单芽制成）。','107,109','茶知识','hard','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (102,'碧螺春和龙井的产地有什么区别？','碧螺春产于江苏苏州太湖洞庭山；龙井产于浙江杭州西湖区。两者都是炒青绿茶，但碧螺春卷曲如螺、龙井扁平挺直。','103,102','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (103,'大红袍母树在哪里？','母树仅存六株，位于武夷山九龙窠绝壁；市售大红袍多为无性繁殖的纯种或以肉桂、水仙拼配的商品大红袍。','117','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (104,'寿眉和贡眉有什么区别？','两者都属白茶，采一芽二三叶或抽针后叶片；贡眉传统指菜茶品种制成的，寿眉产量最大、梗叶相间，陈化后易出枣香药香，是老白茶与煮茶主要原料。','111,108','茶知识','hard','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (105,'君山银针属于哪一类茶？','属黄茶中的黄芽茶，产于湖南岳阳洞庭湖君山岛；冲泡时芽尖竖立、三起三落。','113,112','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (106,'正山小种和金骏眉都产自哪里？','都产自福建武夷山桐木关。正山小种是世界最早的红茶（约 16 世纪末），传统用松柴熏焙带松烟香；金骏眉 2005 年创制，全由单芽制成。','121,122','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (107,'滇红和祁红哪个更适合做奶茶？','滇红更适合：云南大叶种内含物质丰富、滋味浓强、刺激性较强、耐冲泡，加奶后茶味仍足；祁红香气高锐带玫瑰花香，更适合清饮。','124,123','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (108,'六堡茶和普洱茶有什么共同点？','都属黑茶（后发酵茶），都可长期存放、越陈越香，都经渥堆发酵，汤色红浓、滋味醇厚。区别在于六堡茶带独特槟榔香，产于广西梧州。','127,125,126','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (109,'太平猴魁和黄山毛峰都是安徽茶吗？','都是。太平猴魁产于黄山太平县（今黄山区）猴坑一带，属烘青绿茶，两叶抱芽、扁平挺直；黄山毛峰产于黄山，带金黄色鱼叶\"黄金片\"。','106,104','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (110,'白牡丹为什么叫这个名字？','取一芽一二叶制成，绿叶夹银白色毫心，冲泡后绿叶托嫩芽形似花朵，故名白牡丹；汤色杏黄，毫香显且带花香，滋味清甜醇爽。','110','茶知识','easy','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (111,'茯砖茶的\"发花\"是什么工艺？','指渥堆后生长冠突散囊菌（俗称\"金花\"）的过程，使茶汤更醇和并带独特菌花香。属安化黑茶\"三砖\"之一。','128','茶知识','hard','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (112,'凤凰单丛的\"十大香型\"包括哪些？','蜜兰香、黄枝香、芝兰香、桂花香、玉兰香、姜花香、夜来香、茉莉香、杏仁香、肉桂香。','118','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (113,'为什么紫砂壶要\"一壶一茶\"？','紫砂双气孔结构会吸附茶香，混用会串味；专壶专用才能保持每类茶的本味，并逐步养出温润包浆。','139,176','茶知识','easy','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (114,'盖碗和紫砂壶泡茶哪个更能反映茶的本味？','盖碗。白瓷不吸香不串味，能真实反映茶叶本味，且便于闻香观色看叶底；紫砂会吸附香气。','138,139','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (115,'公道杯为什么必须用？','用于均匀茶汤浓度（避免先倒的淡、后倒的浓）、沉淀茶渣、便于观色闻香；玻璃材质最佳以便观察汤色。','179','茶知识','easy','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (116,'铁壶和银壶煮水有什么区别？','铁壶煮水可提升水温并释放微量铁离子使水质更\"软\"，适合老茶与普洱；银壶导热极快、水质清甜、抑菌性好，适合煮水与煮茶，但价格昂贵。','182','茶知识','hard','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (117,'什么是\"惊裂\"？怎么避免？','指紫砂壶因温差骤变而开裂。避免方法：使用前先用温水\"温壶\"逐步升温，冬季尤须注意，忌冷水壶直接注沸水。','188','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (118,'茶巾为什么要分干湿两块？','湿巾用于擦拭茶汤，干巾用于擦干杯底、防止水渍；混用会弄脏茶具，且茶巾需每日清洗晾干以免滋生细菌。','187','茶知识','easy','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (119,'煮茶适合哪些茶？','适合黑茶（茯砖、六堡）、老白茶（寿眉、贡眉）、陈年普洱与陈皮茶；投茶 5-8 克配 500-800 毫升水，冷水入壶同煮，沸后小火 3-5 分钟。','149,136','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (120,'冷泡茶为什么没那么苦？','低温萃取使咖啡碱与茶多酚析出减少，因此苦涩度低、甘甜感突出、咖啡因含量较低；冷水浸泡 4-8 小时，茶水比约 1:100。','148','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (121,'为什么说\"水为茶之母\"？','水质直接影响茶汤表现：山泉水矿物质适中活性好最佳，硬水会使茶汤浑浊发涩、香气沉闷；理想 TDS 为 30-80 mg/L。','140,154','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (122,'茶汤的\"喉韵\"是什么感觉？','指茶汤下咽后喉部持久的甘润感，与回甘、生津共同构成好茶的体感层次。','144','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (123,'为什么好茶苦涩能\"化得开\"？','优质茶苦涩入口后迅速转化为回甘，因为茶多酚与唾液蛋白结合的收敛作用会消退；劣质茶苦涩滞留、化不开。','145','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (124,'为什么有的茶要\"洗茶\"？','洗茶（温润泡）可去除表面浮尘、降低仓储陈味、唤醒茶性，对黑茶、老白茶、陈年乌龙尤为必要；但细嫩绿茶与高等级白茶建议跳过以免流失氨基酸与香气。','142','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (125,'绿茶的三种投茶法是什么？','上投法（先注水后投茶，适合碧螺春等细嫩名茶）、中投法（先注三分之一水、投茶、再注满，适合龙井）、下投法（先投茶后注水，适合普通绿茶）。','131','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (126,'乌龙茶的\"工夫泡法\"有几个步骤？','七步：温壶烫杯、投茶、洗茶、高冲注水、刮沫淋壶、出汤、分茶入杯（先闻香后品味）；首泡约 15-30 秒，之后逐泡延长。','134','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (127,'为什么乌龙茶投茶量这么大？','乌龙茶需多次冲泡且讲究香气层次，投茶量约 7-8 克配 100 毫升水（占壶容 1/3 至 1/2），快冲快出可冲泡七次以上。','133,134','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (128,'茶点的搭配口诀是什么？','\"甜配绿、酸配红、瓜子配乌龙\"——绿茶配清淡微甜茶点，红茶配带酸味点心，乌龙茶配咸香坚果。','151','茶文化','easy','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (129,'审评茶叶看哪几项？','四项因子：香气（热嗅辨纯异、温嗅辨香型、冷嗅辨持久）、汤色（色度亮度清浊）、滋味（浓淡醇涩鲜爽回甘喉韵）、叶底（嫩度匀整色泽活性）。','143','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (130,'我买了个壶，卖家说要先煮一下去土味，这是什么步骤？','指紫砂壶\"开壶\"：清水洗净后加水没过壶身，小火煮沸后加少量日后要泡的茶叶，继续煮 20-30 分钟，取出自然冷却晾干。','175','茶知识','hard','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (131,'我泡的绿茶总是又黄又苦，可能哪里做错了？','大概率水温过高：绿茶应用 80-85℃ 水，沸水会烫熟茶叶、破坏叶绿素，使茶汤发黄发苦；同时注意投茶量约 3 克配 150 毫升水。','130','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (132,'为什么我泡的茶第二泡就没味道了？','可能是茶类本身耐泡度有限（细嫩绿茶仅 2-3 泡）或投茶量不足；耐泡度与内含物丰富度、投茶量、水温相关，黑茶与普洱可达 8-15 泡。','147,153','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (133,'我的茶放在厨房半年，现在有股怪味还能喝吗？','不能。茶叶多孔结构极易吸附异味，且厨房潮湿高温会加速变质；出现霉味酸味或霉斑的茶必须丢弃，霉菌毒素耐高温冲泡无法去除。','161,168','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (134,'我胃不好，是不是不能喝茶？','不必完全戒断，但应避免空腹饮浓茶（刺激胃酸分泌）与浓茶；可选发酵度高的红茶、熟普（茶性温和），并避免睡前与餐前饮用。','210,211,216','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (135,'我每天喝很多浓茶，会不会有问题？','需注意：过量咖啡因可能导致失眠、心悸；鞣酸影响铁吸收；长期大量饮用高氟砖茶有氟斑牙与氟骨症风险。建议控制浓度与总量。','210,214,212','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (136,'朋友送了一饼茶，说越放越值钱，所有茶都这样吗？','不是。只有白茶与黑茶（含普洱）在合适条件下可长期存放、越陈越香；绿茶、清香乌龙、红茶有最佳品饮期，久放香气衰减。','167,164','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (137,'我要送茶给一个不常喝茶的客户，选什么比较好？','宜选接受度高的红茶或白茶（性温和、不挑人）；绿茶需冷藏不宜长途送礼。红茶礼盒四季皆宜、商务场合稳妥。','174','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (138,'同一款茶，为什么茶店泡的比我泡的香？','可能差在水质、水温、器皿与手法：山泉水与合适水温更出香；盖碗或紫砂的聚香性不同；出汤时间控制也影响香气释放。','140,138,134','茶知识','hard','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (139,'我想喝甜一点的茶，有什么推荐？','可选滋味甘甜的品类：白茶（白牡丹、寿眉陈化后带枣香）、红茶（带蜜香）、或氨基酸含量高的安吉白茶（鲜爽甘甜几乎无苦涩）。','110,107,120','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (140,'为什么有的茶要放冰箱有的不能放？','取决于是否需后发酵转化：绿茶与清香乌龙需低温抑制氧化，应冷藏冷冻；红茶、黑茶、白茶需常温\"呼吸\"转化，冷藏会抑制陈化。','162,163,164,166','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (141,'喝茶能解酒吗？','不能。茶中的咖啡碱会加重心脏负担，且茶汤利尿可能使未分解的乙醛过早进入肾脏；解酒应补充水分与休息，不宜靠浓茶。','210,205','茶知识','hard','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (142,'我用自来水泡茶总觉得不好喝，怎么办？','自来水含氯且硬度可能偏高：可煮沸后静置去氯，或用净水器过滤降低 TDS；理想 TDS 为 30-80 mg/L，过高会使茶汤浑浊发涩。','140,154','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (143,'茶汤表面那层\"沫\"是什么？要撇掉吗？','茶汤浮沫主要是茶皂素与蛋白质等形成的，无毒无害，不需撇掉；宋代点茶反而追求细腻持久的沫饽（\"咬盏\"为佳）。','193,205','茶知识','hard','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (144,'我想把茶放在办公室慢慢喝，怎么存比较好？','建议分装成小份密封避光，避免频繁开合；若为绿茶或清香乌龙可放公司冰箱冷藏；红茶、白茶常温密封即可，注意远离异味源。','162,163,161','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (145,'为什么有些茶要用小杯子喝？','品茗杯容量宜小（30-50 毫升），便于小口品饮、让茶汤在口腔铺开充分接触味蕾以感受香气与回甘；持杯称\"三龙护鼎\"。','180','茶知识','easy','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (146,'哪些茶不适合用紫砂壶泡？','绿茶与清香型乌龙不适合——紫砂会吸附其清扬香气并闷熟茶叶；紫砂更适合乌龙（浓香/岩茶）与普洱。','139','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (147,'哪些茶不需要冷藏保存？','红茶、黑茶（含普洱）、白茶不需冷藏：它们需常温\"呼吸\"转化，冷藏反而抑制后发酵；只需密封、避光、干燥、无异味。','163,164','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (148,'哪些情况不应该喝茶？','空腹时不宜饮浓茶（刺激胃酸）；睡前 3 小时不宜饮浓茶（影响入睡）；服药时不宜用茶送服（鞣酸与生物碱影响吸收）；霉变茶绝对不能喝。','210,168','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (149,'哪些人不适合大量饮茶？','孕妇与哺乳期女性（咖啡因）、缺铁性贫血者（鞣酸抑制铁吸收）、严重失眠与焦虑者、胃溃疡与胃食管反流者。','211','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (150,'隔夜茶能不能喝？','若密封冷藏且无浑浊异味，加热后一般无健康风险，但不推荐——微生物繁殖、营养氧化、口感变差；常温放置的隔夜茶应丢弃。','215','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (151,'洗茶会不会把营养洗掉？','会流失部分：细嫩绿茶与高等级白茶的氨基酸与香气易被洗掉，建议跳过或仅用极快的一冲；黑茶、老白茶、陈年乌龙则建议洗茶以去陈味唤醒茶性。','142','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (152,'是不是所有茶都越陈越香？','不是。只有白茶与黑茶在合适仓储下可长期陈化并提升品质；绿茶、清香乌龙、红茶有最佳品饮期，久放香气与鲜爽度下降。','167,164,158','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (153,'茶汤浑浊一定是因为茶叶不好吗？','不一定。可能原因：水质过硬（钙镁离子）、茶毫较多（如碧螺春、白毫银针的毫浑属正常）、茶碎末过多、或水温过高；需结合具体茶类判断。','140,154,6','茶知识','hard','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (154,'是不是越贵的茶就越适合我？','不一定。选茶应看体质与口味：虚寒体质宜红茶熟普，燥热体质宜绿茶白茶；明前茶贵但滋味偏淡，雨前茶性价比更高、滋味更浓。','216,129,157','茶知识','normal','2026-10-07 18:22:17');
INSERT INTO `eval_case` VALUES (155,'不加奶的红茶是不是更高级？','不能一概而论。清饮（不加奶）更能体现高香红茶的品种香（如祁门香），是品鉴方式；加奶是调饮方式，适合滋味浓强的滇红等，两者无高低之分，取决于场合与茶类。','123,124,150','茶知识','hard','2026-10-07 18:22:17');
/*!40000 ALTER TABLE `eval_case` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eval_run`
--

DROP TABLE IF EXISTS `eval_run`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eval_run` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `run_name` varchar(64) NOT NULL COMMENT '实验名：vector_only / hybrid / hybrid_rerank',
  `config` json DEFAULT NULL COMMENT '本次实验的配置快照',
  `case_id` bigint NOT NULL,
  `hit_at_5` tinyint(1) DEFAULT '0' COMMENT 'Top-5 是否命中期望 chunk',
  `answer_correct` tinyint(1) DEFAULT '0' COMMENT '答案是否正确',
  `latency_ms` int DEFAULT NULL,
  `recall` decimal(5,4) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_run` (`run_name`),
  KEY `idx_case` (`case_id`),
  CONSTRAINT `fk_eval_case` FOREIGN KEY (`case_id`) REFERENCES `eval_case` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1285 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='RAG 评估运行结果';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eval_run`
--

LOCK TABLES `eval_run` WRITE;
/*!40000 ALTER TABLE `eval_run` DISABLE KEYS */;
INSERT INTO `eval_run` VALUES (849,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',1,1,0,2,1.0000,'2026-10-07 18:22:52');
INSERT INTO `eval_run` VALUES (850,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',1,1,0,178,1.0000,'2026-10-07 18:22:52');
INSERT INTO `eval_run` VALUES (851,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',1,1,0,164,1.0000,'2026-10-07 18:22:53');
INSERT INTO `eval_run` VALUES (852,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',1,1,0,306,1.0000,'2026-10-07 18:22:53');
INSERT INTO `eval_run` VALUES (853,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',2,0,0,2,0.0000,'2026-10-07 18:22:53');
INSERT INTO `eval_run` VALUES (854,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',2,1,0,158,1.0000,'2026-10-07 18:22:53');
INSERT INTO `eval_run` VALUES (855,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',2,1,0,149,1.0000,'2026-10-07 18:22:53');
INSERT INTO `eval_run` VALUES (856,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',2,1,0,441,1.0000,'2026-10-07 18:22:54');
INSERT INTO `eval_run` VALUES (857,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',3,0,0,2,0.0000,'2026-10-07 18:22:54');
INSERT INTO `eval_run` VALUES (858,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',3,1,0,157,1.0000,'2026-10-07 18:22:54');
INSERT INTO `eval_run` VALUES (859,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',3,1,0,161,1.0000,'2026-10-07 18:22:54');
INSERT INTO `eval_run` VALUES (860,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',3,1,0,295,1.0000,'2026-10-07 18:22:54');
INSERT INTO `eval_run` VALUES (861,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',10,1,0,2,1.0000,'2026-10-07 18:22:54');
INSERT INTO `eval_run` VALUES (862,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',10,1,0,137,1.0000,'2026-10-07 18:22:54');
INSERT INTO `eval_run` VALUES (863,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',10,1,0,148,1.0000,'2026-10-07 18:22:55');
INSERT INTO `eval_run` VALUES (864,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',10,1,0,297,1.0000,'2026-10-07 18:22:55');
INSERT INTO `eval_run` VALUES (865,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',11,1,0,2,1.0000,'2026-10-07 18:22:55');
INSERT INTO `eval_run` VALUES (866,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',11,1,0,385,1.0000,'2026-10-07 18:22:56');
INSERT INTO `eval_run` VALUES (867,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',11,1,0,141,1.0000,'2026-10-07 18:22:56');
INSERT INTO `eval_run` VALUES (868,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',11,1,0,330,1.0000,'2026-10-07 18:22:56');
INSERT INTO `eval_run` VALUES (869,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',12,1,0,1,1.0000,'2026-10-07 18:22:56');
INSERT INTO `eval_run` VALUES (870,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',12,1,0,142,1.0000,'2026-10-07 18:22:56');
INSERT INTO `eval_run` VALUES (871,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',12,1,0,400,1.0000,'2026-10-07 18:22:57');
INSERT INTO `eval_run` VALUES (872,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',12,1,0,315,1.0000,'2026-10-07 18:22:57');
INSERT INTO `eval_run` VALUES (873,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',13,1,0,1,1.0000,'2026-10-07 18:22:57');
INSERT INTO `eval_run` VALUES (874,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',13,1,0,194,1.0000,'2026-10-07 18:22:57');
INSERT INTO `eval_run` VALUES (875,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',13,1,0,153,1.0000,'2026-10-07 18:22:57');
INSERT INTO `eval_run` VALUES (876,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',13,1,0,288,1.0000,'2026-10-07 18:22:58');
INSERT INTO `eval_run` VALUES (877,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',14,1,0,2,1.0000,'2026-10-07 18:22:58');
INSERT INTO `eval_run` VALUES (878,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',14,1,0,206,1.0000,'2026-10-07 18:22:58');
INSERT INTO `eval_run` VALUES (879,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',14,1,0,152,1.0000,'2026-10-07 18:22:58');
INSERT INTO `eval_run` VALUES (880,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',14,1,0,541,1.0000,'2026-10-07 18:22:59');
INSERT INTO `eval_run` VALUES (881,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',15,1,0,4,1.0000,'2026-10-07 18:22:59');
INSERT INTO `eval_run` VALUES (882,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',15,1,0,166,1.0000,'2026-10-07 18:22:59');
INSERT INTO `eval_run` VALUES (883,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',15,1,0,150,1.0000,'2026-10-07 18:22:59');
INSERT INTO `eval_run` VALUES (884,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',15,1,0,360,1.0000,'2026-10-07 18:22:59');
INSERT INTO `eval_run` VALUES (885,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',16,1,0,1,1.0000,'2026-10-07 18:22:59');
INSERT INTO `eval_run` VALUES (886,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',16,1,0,143,1.0000,'2026-10-07 18:22:59');
INSERT INTO `eval_run` VALUES (887,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',16,1,0,162,1.0000,'2026-10-07 18:23:00');
INSERT INTO `eval_run` VALUES (888,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',16,1,0,432,1.0000,'2026-10-07 18:23:00');
INSERT INTO `eval_run` VALUES (889,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',17,1,0,2,1.0000,'2026-10-07 18:23:00');
INSERT INTO `eval_run` VALUES (890,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',17,1,0,392,1.0000,'2026-10-07 18:23:00');
INSERT INTO `eval_run` VALUES (891,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',17,1,0,255,1.0000,'2026-10-07 18:23:01');
INSERT INTO `eval_run` VALUES (892,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',17,1,0,295,1.0000,'2026-10-07 18:23:01');
INSERT INTO `eval_run` VALUES (893,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',18,1,0,1,1.0000,'2026-10-07 18:23:01');
INSERT INTO `eval_run` VALUES (894,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',18,1,0,342,1.0000,'2026-10-07 18:23:01');
INSERT INTO `eval_run` VALUES (895,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',18,1,0,234,1.0000,'2026-10-07 18:23:02');
INSERT INTO `eval_run` VALUES (896,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',18,1,0,282,1.0000,'2026-10-07 18:23:02');
INSERT INTO `eval_run` VALUES (897,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',19,1,0,2,1.0000,'2026-10-07 18:23:02');
INSERT INTO `eval_run` VALUES (898,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',19,1,0,257,1.0000,'2026-10-07 18:23:02');
INSERT INTO `eval_run` VALUES (899,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',19,1,0,142,1.0000,'2026-10-07 18:23:02');
INSERT INTO `eval_run` VALUES (900,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',19,1,0,314,1.0000,'2026-10-07 18:23:03');
INSERT INTO `eval_run` VALUES (901,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',20,1,0,2,1.0000,'2026-10-07 18:23:03');
INSERT INTO `eval_run` VALUES (902,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',20,1,0,277,1.0000,'2026-10-07 18:23:03');
INSERT INTO `eval_run` VALUES (903,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',20,1,0,167,1.0000,'2026-10-07 18:23:03');
INSERT INTO `eval_run` VALUES (904,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',20,1,0,334,1.0000,'2026-10-07 18:23:04');
INSERT INTO `eval_run` VALUES (905,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',21,1,0,2,1.0000,'2026-10-07 18:23:04');
INSERT INTO `eval_run` VALUES (906,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',21,1,0,185,1.0000,'2026-10-07 18:23:04');
INSERT INTO `eval_run` VALUES (907,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',21,1,0,218,1.0000,'2026-10-07 18:23:04');
INSERT INTO `eval_run` VALUES (908,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',21,1,0,333,1.0000,'2026-10-07 18:23:04');
INSERT INTO `eval_run` VALUES (909,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',22,1,0,2,1.0000,'2026-10-07 18:23:04');
INSERT INTO `eval_run` VALUES (910,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',22,1,0,145,1.0000,'2026-10-07 18:23:04');
INSERT INTO `eval_run` VALUES (911,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',22,1,0,145,1.0000,'2026-10-07 18:23:05');
INSERT INTO `eval_run` VALUES (912,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',22,1,0,314,1.0000,'2026-10-07 18:23:05');
INSERT INTO `eval_run` VALUES (913,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',23,1,0,1,1.0000,'2026-10-07 18:23:05');
INSERT INTO `eval_run` VALUES (914,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',23,1,0,145,1.0000,'2026-10-07 18:23:05');
INSERT INTO `eval_run` VALUES (915,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',23,1,0,130,1.0000,'2026-10-07 18:23:05');
INSERT INTO `eval_run` VALUES (916,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',23,1,0,285,1.0000,'2026-10-07 18:23:06');
INSERT INTO `eval_run` VALUES (917,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',24,1,0,1,1.0000,'2026-10-07 18:23:06');
INSERT INTO `eval_run` VALUES (918,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',24,1,0,148,1.0000,'2026-10-07 18:23:06');
INSERT INTO `eval_run` VALUES (919,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',24,1,0,148,1.0000,'2026-10-07 18:23:06');
INSERT INTO `eval_run` VALUES (920,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',24,1,0,282,1.0000,'2026-10-07 18:23:06');
INSERT INTO `eval_run` VALUES (921,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',25,1,0,1,1.0000,'2026-10-07 18:23:06');
INSERT INTO `eval_run` VALUES (922,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',25,1,0,140,1.0000,'2026-10-07 18:23:06');
INSERT INTO `eval_run` VALUES (923,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',25,1,0,140,1.0000,'2026-10-07 18:23:06');
INSERT INTO `eval_run` VALUES (924,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',25,1,0,283,1.0000,'2026-10-07 18:23:07');
INSERT INTO `eval_run` VALUES (925,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',30,0,0,1,0.0000,'2026-10-07 18:23:07');
INSERT INTO `eval_run` VALUES (926,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',30,1,0,557,1.0000,'2026-10-07 18:23:07');
INSERT INTO `eval_run` VALUES (927,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',30,1,0,161,1.0000,'2026-10-07 18:23:07');
INSERT INTO `eval_run` VALUES (928,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',30,1,0,308,1.0000,'2026-10-07 18:23:08');
INSERT INTO `eval_run` VALUES (929,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',31,1,0,2,1.0000,'2026-10-07 18:23:08');
INSERT INTO `eval_run` VALUES (930,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',31,1,0,385,1.0000,'2026-10-07 18:23:08');
INSERT INTO `eval_run` VALUES (931,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',31,1,0,367,1.0000,'2026-10-07 18:23:09');
INSERT INTO `eval_run` VALUES (932,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',31,1,0,537,1.0000,'2026-10-07 18:23:09');
INSERT INTO `eval_run` VALUES (933,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',32,0,0,1,0.0000,'2026-10-07 18:23:09');
INSERT INTO `eval_run` VALUES (934,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',32,1,0,142,1.0000,'2026-10-07 18:23:09');
INSERT INTO `eval_run` VALUES (935,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',32,1,0,244,1.0000,'2026-10-07 18:23:10');
INSERT INTO `eval_run` VALUES (936,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',32,1,0,610,1.0000,'2026-10-07 18:23:10');
INSERT INTO `eval_run` VALUES (937,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',33,1,0,2,1.0000,'2026-10-07 18:23:10');
INSERT INTO `eval_run` VALUES (938,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',33,1,0,299,1.0000,'2026-10-07 18:23:11');
INSERT INTO `eval_run` VALUES (939,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',33,1,0,373,1.0000,'2026-10-07 18:23:11');
INSERT INTO `eval_run` VALUES (940,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',33,1,0,608,1.0000,'2026-10-07 18:23:12');
INSERT INTO `eval_run` VALUES (941,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',34,1,0,0,1.0000,'2026-10-07 18:23:12');
INSERT INTO `eval_run` VALUES (942,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',34,1,0,269,1.0000,'2026-10-07 18:23:12');
INSERT INTO `eval_run` VALUES (943,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',34,1,0,153,1.0000,'2026-10-07 18:23:12');
INSERT INTO `eval_run` VALUES (944,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',34,1,0,289,1.0000,'2026-10-07 18:23:12');
INSERT INTO `eval_run` VALUES (945,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',35,1,0,2,1.0000,'2026-10-07 18:23:12');
INSERT INTO `eval_run` VALUES (946,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',35,1,0,158,1.0000,'2026-10-07 18:23:12');
INSERT INTO `eval_run` VALUES (947,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',35,1,0,261,1.0000,'2026-10-07 18:23:13');
INSERT INTO `eval_run` VALUES (948,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',35,1,0,596,1.0000,'2026-10-07 18:23:13');
INSERT INTO `eval_run` VALUES (949,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',36,1,0,2,1.0000,'2026-10-07 18:23:13');
INSERT INTO `eval_run` VALUES (950,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',36,1,0,213,1.0000,'2026-10-07 18:23:14');
INSERT INTO `eval_run` VALUES (951,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',36,1,0,150,1.0000,'2026-10-07 18:23:14');
INSERT INTO `eval_run` VALUES (952,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',36,1,0,331,1.0000,'2026-10-07 18:23:14');
INSERT INTO `eval_run` VALUES (953,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',37,0,0,1,0.0000,'2026-10-07 18:23:14');
INSERT INTO `eval_run` VALUES (954,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',37,1,0,199,1.0000,'2026-10-07 18:23:14');
INSERT INTO `eval_run` VALUES (955,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',37,1,0,158,1.0000,'2026-10-07 18:23:14');
INSERT INTO `eval_run` VALUES (956,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',37,1,0,641,1.0000,'2026-10-07 18:23:15');
INSERT INTO `eval_run` VALUES (957,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',38,1,0,2,1.0000,'2026-10-07 18:23:15');
INSERT INTO `eval_run` VALUES (958,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',38,1,0,234,1.0000,'2026-10-07 18:23:15');
INSERT INTO `eval_run` VALUES (959,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',38,1,0,168,1.0000,'2026-10-07 18:23:15');
INSERT INTO `eval_run` VALUES (960,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',38,1,0,527,1.0000,'2026-10-07 18:23:16');
INSERT INTO `eval_run` VALUES (961,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',39,1,0,2,1.0000,'2026-10-07 18:23:16');
INSERT INTO `eval_run` VALUES (962,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',39,1,0,311,1.0000,'2026-10-07 18:23:16');
INSERT INTO `eval_run` VALUES (963,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',39,1,0,221,1.0000,'2026-10-07 18:23:17');
INSERT INTO `eval_run` VALUES (964,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',39,1,0,607,1.0000,'2026-10-07 18:23:17');
INSERT INTO `eval_run` VALUES (965,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',40,1,0,1,1.0000,'2026-10-07 18:23:17');
INSERT INTO `eval_run` VALUES (966,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',40,1,0,224,1.0000,'2026-10-07 18:23:17');
INSERT INTO `eval_run` VALUES (967,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',40,1,0,484,1.0000,'2026-10-07 18:23:18');
INSERT INTO `eval_run` VALUES (968,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',40,1,0,486,1.0000,'2026-10-07 18:23:18');
INSERT INTO `eval_run` VALUES (969,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',41,1,0,1,1.0000,'2026-10-07 18:23:18');
INSERT INTO `eval_run` VALUES (970,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',41,1,0,231,1.0000,'2026-10-07 18:23:19');
INSERT INTO `eval_run` VALUES (971,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',41,1,0,741,1.0000,'2026-10-07 18:23:19');
INSERT INTO `eval_run` VALUES (972,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',41,1,0,620,1.0000,'2026-10-07 18:23:20');
INSERT INTO `eval_run` VALUES (973,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',42,0,0,2,0.0000,'2026-10-07 18:23:20');
INSERT INTO `eval_run` VALUES (974,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',42,1,0,175,1.0000,'2026-10-07 18:23:20');
INSERT INTO `eval_run` VALUES (975,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',42,0,0,164,0.0000,'2026-10-07 18:23:20');
INSERT INTO `eval_run` VALUES (976,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',42,1,0,295,1.0000,'2026-10-07 18:23:21');
INSERT INTO `eval_run` VALUES (977,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',43,1,0,2,1.0000,'2026-10-07 18:23:21');
INSERT INTO `eval_run` VALUES (978,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',43,1,0,182,1.0000,'2026-10-07 18:23:21');
INSERT INTO `eval_run` VALUES (979,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',43,1,0,227,1.0000,'2026-10-07 18:23:21');
INSERT INTO `eval_run` VALUES (980,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',43,1,0,404,1.0000,'2026-10-07 18:23:22');
INSERT INTO `eval_run` VALUES (981,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',44,0,0,1,0.0000,'2026-10-07 18:23:22');
INSERT INTO `eval_run` VALUES (982,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',44,1,0,251,1.0000,'2026-10-07 18:23:22');
INSERT INTO `eval_run` VALUES (983,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',44,1,0,165,1.0000,'2026-10-07 18:23:22');
INSERT INTO `eval_run` VALUES (984,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',44,1,0,433,1.0000,'2026-10-07 18:23:22');
INSERT INTO `eval_run` VALUES (985,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',45,1,0,1,1.0000,'2026-10-07 18:23:22');
INSERT INTO `eval_run` VALUES (986,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',45,1,0,264,1.0000,'2026-10-07 18:23:23');
INSERT INTO `eval_run` VALUES (987,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',45,1,0,147,1.0000,'2026-10-07 18:23:23');
INSERT INTO `eval_run` VALUES (988,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',45,1,0,662,1.0000,'2026-10-07 18:23:24');
INSERT INTO `eval_run` VALUES (989,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',46,1,0,1,1.0000,'2026-10-07 18:23:24');
INSERT INTO `eval_run` VALUES (990,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',46,1,0,209,1.0000,'2026-10-07 18:23:24');
INSERT INTO `eval_run` VALUES (991,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',46,1,0,157,1.0000,'2026-10-07 18:23:24');
INSERT INTO `eval_run` VALUES (992,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',46,1,0,302,1.0000,'2026-10-07 18:23:24');
INSERT INTO `eval_run` VALUES (993,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',47,0,0,1,0.0000,'2026-10-07 18:23:24');
INSERT INTO `eval_run` VALUES (994,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',47,1,0,381,1.0000,'2026-10-07 18:23:25');
INSERT INTO `eval_run` VALUES (995,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',47,1,0,208,1.0000,'2026-10-07 18:23:25');
INSERT INTO `eval_run` VALUES (996,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',47,1,0,424,1.0000,'2026-10-07 18:23:25');
INSERT INTO `eval_run` VALUES (997,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',48,1,0,2,1.0000,'2026-10-07 18:23:25');
INSERT INTO `eval_run` VALUES (998,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',48,1,0,480,1.0000,'2026-10-07 18:23:26');
INSERT INTO `eval_run` VALUES (999,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',48,1,0,260,1.0000,'2026-10-07 18:23:26');
INSERT INTO `eval_run` VALUES (1000,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',48,1,0,487,1.0000,'2026-10-07 18:23:27');
INSERT INTO `eval_run` VALUES (1001,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',49,0,0,2,0.0000,'2026-10-07 18:23:27');
INSERT INTO `eval_run` VALUES (1002,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',49,1,0,357,1.0000,'2026-10-07 18:23:27');
INSERT INTO `eval_run` VALUES (1003,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',49,1,0,245,1.0000,'2026-10-07 18:23:27');
INSERT INTO `eval_run` VALUES (1004,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',49,1,0,417,1.0000,'2026-10-07 18:23:28');
INSERT INTO `eval_run` VALUES (1005,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',50,1,0,2,1.0000,'2026-10-07 18:23:28');
INSERT INTO `eval_run` VALUES (1006,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',50,1,0,222,1.0000,'2026-10-07 18:23:28');
INSERT INTO `eval_run` VALUES (1007,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',50,1,0,207,1.0000,'2026-10-07 18:23:28');
INSERT INTO `eval_run` VALUES (1008,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',50,1,0,319,1.0000,'2026-10-07 18:23:28');
INSERT INTO `eval_run` VALUES (1009,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',51,0,0,1,0.0000,'2026-10-07 18:23:28');
INSERT INTO `eval_run` VALUES (1010,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',51,1,0,143,1.0000,'2026-10-07 18:23:28');
INSERT INTO `eval_run` VALUES (1011,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',51,1,0,148,1.0000,'2026-10-07 18:23:29');
INSERT INTO `eval_run` VALUES (1012,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',51,1,0,509,1.0000,'2026-10-07 18:23:29');
INSERT INTO `eval_run` VALUES (1013,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',52,0,0,1,0.0000,'2026-10-07 18:23:29');
INSERT INTO `eval_run` VALUES (1014,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',52,1,0,144,1.0000,'2026-10-07 18:23:29');
INSERT INTO `eval_run` VALUES (1015,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',52,1,0,247,1.0000,'2026-10-07 18:23:30');
INSERT INTO `eval_run` VALUES (1016,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',52,1,0,291,1.0000,'2026-10-07 18:23:30');
INSERT INTO `eval_run` VALUES (1017,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',53,1,0,2,1.0000,'2026-10-07 18:23:30');
INSERT INTO `eval_run` VALUES (1018,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',53,1,0,167,1.0000,'2026-10-07 18:23:30');
INSERT INTO `eval_run` VALUES (1019,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',53,1,0,146,1.0000,'2026-10-07 18:23:30');
INSERT INTO `eval_run` VALUES (1020,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',53,1,0,329,1.0000,'2026-10-07 18:23:31');
INSERT INTO `eval_run` VALUES (1021,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',54,0,0,2,0.0000,'2026-10-07 18:23:31');
INSERT INTO `eval_run` VALUES (1022,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',54,1,0,279,1.0000,'2026-10-07 18:23:31');
INSERT INTO `eval_run` VALUES (1023,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',54,0,0,444,0.0000,'2026-10-07 18:23:31');
INSERT INTO `eval_run` VALUES (1024,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',54,1,0,461,1.0000,'2026-10-07 18:23:32');
INSERT INTO `eval_run` VALUES (1025,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',55,0,0,1,0.0000,'2026-10-07 18:23:32');
INSERT INTO `eval_run` VALUES (1026,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',55,1,0,424,1.0000,'2026-10-07 18:23:32');
INSERT INTO `eval_run` VALUES (1027,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',55,0,0,144,0.0000,'2026-10-07 18:23:32');
INSERT INTO `eval_run` VALUES (1028,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',55,1,0,416,1.0000,'2026-10-07 18:23:33');
INSERT INTO `eval_run` VALUES (1029,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',56,0,0,1,0.0000,'2026-10-07 18:23:33');
INSERT INTO `eval_run` VALUES (1030,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',56,1,0,289,1.0000,'2026-10-07 18:23:33');
INSERT INTO `eval_run` VALUES (1031,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',56,0,0,468,0.0000,'2026-10-07 18:23:34');
INSERT INTO `eval_run` VALUES (1032,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',56,1,0,322,1.0000,'2026-10-07 18:23:34');
INSERT INTO `eval_run` VALUES (1033,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',57,1,0,1,1.0000,'2026-10-07 18:23:34');
INSERT INTO `eval_run` VALUES (1034,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',57,1,0,158,1.0000,'2026-10-07 18:23:34');
INSERT INTO `eval_run` VALUES (1035,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',57,1,0,316,1.0000,'2026-10-07 18:23:34');
INSERT INTO `eval_run` VALUES (1036,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',57,1,0,372,1.0000,'2026-10-07 18:23:35');
INSERT INTO `eval_run` VALUES (1037,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',58,1,0,2,1.0000,'2026-10-07 18:23:35');
INSERT INTO `eval_run` VALUES (1038,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',58,1,0,149,1.0000,'2026-10-07 18:23:35');
INSERT INTO `eval_run` VALUES (1039,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',58,1,0,157,1.0000,'2026-10-07 18:23:35');
INSERT INTO `eval_run` VALUES (1040,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',58,1,0,336,1.0000,'2026-10-07 18:23:36');
INSERT INTO `eval_run` VALUES (1041,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',59,1,0,2,1.0000,'2026-10-07 18:23:36');
INSERT INTO `eval_run` VALUES (1042,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',59,1,0,172,1.0000,'2026-10-07 18:23:36');
INSERT INTO `eval_run` VALUES (1043,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',59,1,0,152,1.0000,'2026-10-07 18:23:36');
INSERT INTO `eval_run` VALUES (1044,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',59,1,0,310,1.0000,'2026-10-07 18:23:36');
INSERT INTO `eval_run` VALUES (1045,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',70,1,0,1,1.0000,'2026-10-07 18:23:36');
INSERT INTO `eval_run` VALUES (1046,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',70,1,0,426,1.0000,'2026-10-07 18:23:37');
INSERT INTO `eval_run` VALUES (1047,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',70,1,0,152,1.0000,'2026-10-07 18:23:37');
INSERT INTO `eval_run` VALUES (1048,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',70,1,0,444,1.0000,'2026-10-07 18:23:37');
INSERT INTO `eval_run` VALUES (1049,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',71,1,0,2,1.0000,'2026-10-07 18:23:37');
INSERT INTO `eval_run` VALUES (1050,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',71,1,0,138,1.0000,'2026-10-07 18:23:37');
INSERT INTO `eval_run` VALUES (1051,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',71,1,0,158,1.0000,'2026-10-07 18:23:38');
INSERT INTO `eval_run` VALUES (1052,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',71,1,0,303,1.0000,'2026-10-07 18:23:38');
INSERT INTO `eval_run` VALUES (1053,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',72,1,0,1,1.0000,'2026-10-07 18:23:38');
INSERT INTO `eval_run` VALUES (1054,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',72,1,0,187,1.0000,'2026-10-07 18:23:38');
INSERT INTO `eval_run` VALUES (1055,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',72,1,0,228,1.0000,'2026-10-07 18:23:38');
INSERT INTO `eval_run` VALUES (1056,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',72,1,0,305,1.0000,'2026-10-07 18:23:39');
INSERT INTO `eval_run` VALUES (1057,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',73,1,0,2,1.0000,'2026-10-07 18:23:39');
INSERT INTO `eval_run` VALUES (1058,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',73,1,0,159,1.0000,'2026-10-07 18:23:39');
INSERT INTO `eval_run` VALUES (1059,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',73,1,0,142,1.0000,'2026-10-07 18:23:39');
INSERT INTO `eval_run` VALUES (1060,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',73,1,0,298,1.0000,'2026-10-07 18:23:39');
INSERT INTO `eval_run` VALUES (1061,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',100,1,0,2,1.0000,'2026-10-07 18:23:39');
INSERT INTO `eval_run` VALUES (1062,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',100,1,0,147,1.0000,'2026-10-07 18:23:39');
INSERT INTO `eval_run` VALUES (1063,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',100,1,0,146,1.0000,'2026-10-07 18:23:40');
INSERT INTO `eval_run` VALUES (1064,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',100,1,0,301,1.0000,'2026-10-07 18:23:40');
INSERT INTO `eval_run` VALUES (1065,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',101,1,0,1,1.0000,'2026-10-07 18:23:40');
INSERT INTO `eval_run` VALUES (1066,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',101,1,0,161,1.0000,'2026-10-07 18:23:40');
INSERT INTO `eval_run` VALUES (1067,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',101,1,0,149,1.0000,'2026-10-07 18:23:40');
INSERT INTO `eval_run` VALUES (1068,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',101,1,0,287,1.0000,'2026-10-07 18:23:41');
INSERT INTO `eval_run` VALUES (1069,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',102,0,0,2,0.0000,'2026-10-07 18:23:41');
INSERT INTO `eval_run` VALUES (1070,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',102,1,0,180,1.0000,'2026-10-07 18:23:41');
INSERT INTO `eval_run` VALUES (1071,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',102,1,0,163,1.0000,'2026-10-07 18:23:41');
INSERT INTO `eval_run` VALUES (1072,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',102,1,0,285,1.0000,'2026-10-07 18:23:41');
INSERT INTO `eval_run` VALUES (1073,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',103,1,0,1,1.0000,'2026-10-07 18:23:41');
INSERT INTO `eval_run` VALUES (1074,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',103,1,0,143,1.0000,'2026-10-07 18:23:41');
INSERT INTO `eval_run` VALUES (1075,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',103,1,0,141,1.0000,'2026-10-07 18:23:42');
INSERT INTO `eval_run` VALUES (1076,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',103,1,0,306,1.0000,'2026-10-07 18:23:42');
INSERT INTO `eval_run` VALUES (1077,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',104,1,0,2,1.0000,'2026-10-07 18:23:42');
INSERT INTO `eval_run` VALUES (1078,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',104,1,0,382,1.0000,'2026-10-07 18:23:42');
INSERT INTO `eval_run` VALUES (1079,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',104,1,0,158,1.0000,'2026-10-07 18:23:43');
INSERT INTO `eval_run` VALUES (1080,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',104,1,0,275,1.0000,'2026-10-07 18:23:43');
INSERT INTO `eval_run` VALUES (1081,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',105,1,0,1,1.0000,'2026-10-07 18:23:43');
INSERT INTO `eval_run` VALUES (1082,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',105,1,0,130,1.0000,'2026-10-07 18:23:43');
INSERT INTO `eval_run` VALUES (1083,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',105,1,0,330,1.0000,'2026-10-07 18:23:43');
INSERT INTO `eval_run` VALUES (1084,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',105,1,0,328,1.0000,'2026-10-07 18:23:44');
INSERT INTO `eval_run` VALUES (1085,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',106,1,0,1,1.0000,'2026-10-07 18:23:44');
INSERT INTO `eval_run` VALUES (1086,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',106,1,0,149,1.0000,'2026-10-07 18:23:44');
INSERT INTO `eval_run` VALUES (1087,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',106,1,0,147,1.0000,'2026-10-07 18:23:44');
INSERT INTO `eval_run` VALUES (1088,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',106,1,0,354,1.0000,'2026-10-07 18:23:44');
INSERT INTO `eval_run` VALUES (1089,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',107,1,0,1,1.0000,'2026-10-07 18:23:44');
INSERT INTO `eval_run` VALUES (1090,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',107,1,0,166,1.0000,'2026-10-07 18:23:44');
INSERT INTO `eval_run` VALUES (1091,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',107,1,0,155,1.0000,'2026-10-07 18:23:45');
INSERT INTO `eval_run` VALUES (1092,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',107,1,0,595,1.0000,'2026-10-07 18:23:45');
INSERT INTO `eval_run` VALUES (1093,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',108,1,0,1,1.0000,'2026-10-07 18:23:45');
INSERT INTO `eval_run` VALUES (1094,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',108,1,0,235,1.0000,'2026-10-07 18:23:45');
INSERT INTO `eval_run` VALUES (1095,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',108,1,0,157,1.0000,'2026-10-07 18:23:46');
INSERT INTO `eval_run` VALUES (1096,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',108,1,0,308,1.0000,'2026-10-07 18:23:46');
INSERT INTO `eval_run` VALUES (1097,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',109,1,0,1,1.0000,'2026-10-07 18:23:46');
INSERT INTO `eval_run` VALUES (1098,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',109,1,0,140,1.0000,'2026-10-07 18:23:46');
INSERT INTO `eval_run` VALUES (1099,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',109,1,0,139,1.0000,'2026-10-07 18:23:46');
INSERT INTO `eval_run` VALUES (1100,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',109,1,0,339,1.0000,'2026-10-07 18:23:47');
INSERT INTO `eval_run` VALUES (1101,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',110,1,0,1,1.0000,'2026-10-07 18:23:47');
INSERT INTO `eval_run` VALUES (1102,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',110,1,0,156,1.0000,'2026-10-07 18:23:47');
INSERT INTO `eval_run` VALUES (1103,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',110,1,0,150,1.0000,'2026-10-07 18:23:47');
INSERT INTO `eval_run` VALUES (1104,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',110,1,0,309,1.0000,'2026-10-07 18:23:47');
INSERT INTO `eval_run` VALUES (1105,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',111,1,0,1,1.0000,'2026-10-07 18:23:47');
INSERT INTO `eval_run` VALUES (1106,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',111,1,0,145,1.0000,'2026-10-07 18:23:47');
INSERT INTO `eval_run` VALUES (1107,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',111,1,0,152,1.0000,'2026-10-07 18:23:48');
INSERT INTO `eval_run` VALUES (1108,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',111,1,0,283,1.0000,'2026-10-07 18:23:48');
INSERT INTO `eval_run` VALUES (1109,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',112,1,0,2,1.0000,'2026-10-07 18:23:48');
INSERT INTO `eval_run` VALUES (1110,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',112,1,0,523,1.0000,'2026-10-07 18:23:48');
INSERT INTO `eval_run` VALUES (1111,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',112,1,0,143,1.0000,'2026-10-07 18:23:49');
INSERT INTO `eval_run` VALUES (1112,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',112,1,0,280,1.0000,'2026-10-07 18:23:49');
INSERT INTO `eval_run` VALUES (1113,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',113,1,0,2,1.0000,'2026-10-07 18:23:49');
INSERT INTO `eval_run` VALUES (1114,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',113,1,0,152,1.0000,'2026-10-07 18:23:49');
INSERT INTO `eval_run` VALUES (1115,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',113,1,0,166,1.0000,'2026-10-07 18:23:49');
INSERT INTO `eval_run` VALUES (1116,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',113,1,0,408,1.0000,'2026-10-07 18:23:50');
INSERT INTO `eval_run` VALUES (1117,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',114,1,0,1,1.0000,'2026-10-07 18:23:50');
INSERT INTO `eval_run` VALUES (1118,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',114,1,0,150,1.0000,'2026-10-07 18:23:50');
INSERT INTO `eval_run` VALUES (1119,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',114,1,0,173,1.0000,'2026-10-07 18:23:50');
INSERT INTO `eval_run` VALUES (1120,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',114,1,0,302,1.0000,'2026-10-07 18:23:50');
INSERT INTO `eval_run` VALUES (1121,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',115,1,0,1,1.0000,'2026-10-07 18:23:50');
INSERT INTO `eval_run` VALUES (1122,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',115,1,0,155,1.0000,'2026-10-07 18:23:50');
INSERT INTO `eval_run` VALUES (1123,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',115,1,0,157,1.0000,'2026-10-07 18:23:51');
INSERT INTO `eval_run` VALUES (1124,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',115,1,0,591,1.0000,'2026-10-07 18:23:51');
INSERT INTO `eval_run` VALUES (1125,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',116,1,0,1,1.0000,'2026-10-07 18:23:51');
INSERT INTO `eval_run` VALUES (1126,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',116,1,0,695,1.0000,'2026-10-07 18:23:52');
INSERT INTO `eval_run` VALUES (1127,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',116,1,0,147,1.0000,'2026-10-07 18:23:52');
INSERT INTO `eval_run` VALUES (1128,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',116,1,0,351,1.0000,'2026-10-07 18:23:52');
INSERT INTO `eval_run` VALUES (1129,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',117,1,0,2,1.0000,'2026-10-07 18:23:52');
INSERT INTO `eval_run` VALUES (1130,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',117,1,0,296,1.0000,'2026-10-07 18:23:53');
INSERT INTO `eval_run` VALUES (1131,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',117,1,0,150,1.0000,'2026-10-07 18:23:53');
INSERT INTO `eval_run` VALUES (1132,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',117,1,0,420,1.0000,'2026-10-07 18:23:53');
INSERT INTO `eval_run` VALUES (1133,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',118,1,0,1,1.0000,'2026-10-07 18:23:53');
INSERT INTO `eval_run` VALUES (1134,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',118,1,0,146,1.0000,'2026-10-07 18:23:53');
INSERT INTO `eval_run` VALUES (1135,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',118,1,0,199,1.0000,'2026-10-07 18:23:54');
INSERT INTO `eval_run` VALUES (1136,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',118,1,0,281,1.0000,'2026-10-07 18:23:54');
INSERT INTO `eval_run` VALUES (1137,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',119,1,0,1,1.0000,'2026-10-07 18:23:54');
INSERT INTO `eval_run` VALUES (1138,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',119,1,0,143,1.0000,'2026-10-07 18:23:54');
INSERT INTO `eval_run` VALUES (1139,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',119,1,0,171,1.0000,'2026-10-07 18:23:54');
INSERT INTO `eval_run` VALUES (1140,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',119,1,0,311,1.0000,'2026-10-07 18:23:55');
INSERT INTO `eval_run` VALUES (1141,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',120,1,0,1,1.0000,'2026-10-07 18:23:55');
INSERT INTO `eval_run` VALUES (1142,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',120,1,0,188,1.0000,'2026-10-07 18:23:55');
INSERT INTO `eval_run` VALUES (1143,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',120,1,0,138,1.0000,'2026-10-07 18:23:55');
INSERT INTO `eval_run` VALUES (1144,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',120,1,0,290,1.0000,'2026-10-07 18:23:55');
INSERT INTO `eval_run` VALUES (1145,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',121,1,0,1,1.0000,'2026-10-07 18:23:55');
INSERT INTO `eval_run` VALUES (1146,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',121,1,0,142,1.0000,'2026-10-07 18:23:55');
INSERT INTO `eval_run` VALUES (1147,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',121,1,0,141,1.0000,'2026-10-07 18:23:56');
INSERT INTO `eval_run` VALUES (1148,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',121,1,0,388,1.0000,'2026-10-07 18:23:56');
INSERT INTO `eval_run` VALUES (1149,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',122,1,0,2,1.0000,'2026-10-07 18:23:56');
INSERT INTO `eval_run` VALUES (1150,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',122,1,0,132,1.0000,'2026-10-07 18:23:56');
INSERT INTO `eval_run` VALUES (1151,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',122,1,0,166,1.0000,'2026-10-07 18:23:56');
INSERT INTO `eval_run` VALUES (1152,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',122,1,0,306,1.0000,'2026-10-07 18:23:57');
INSERT INTO `eval_run` VALUES (1153,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',123,1,0,2,1.0000,'2026-10-07 18:23:57');
INSERT INTO `eval_run` VALUES (1154,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',123,1,0,309,1.0000,'2026-10-07 18:23:57');
INSERT INTO `eval_run` VALUES (1155,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',123,1,0,161,1.0000,'2026-10-07 18:23:57');
INSERT INTO `eval_run` VALUES (1156,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',123,1,0,377,1.0000,'2026-10-07 18:23:57');
INSERT INTO `eval_run` VALUES (1157,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',124,1,0,1,1.0000,'2026-10-07 18:23:57');
INSERT INTO `eval_run` VALUES (1158,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',124,1,0,162,1.0000,'2026-10-07 18:23:58');
INSERT INTO `eval_run` VALUES (1159,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',124,1,0,145,1.0000,'2026-10-07 18:23:58');
INSERT INTO `eval_run` VALUES (1160,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',124,1,0,272,1.0000,'2026-10-07 18:23:58');
INSERT INTO `eval_run` VALUES (1161,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',125,1,0,2,1.0000,'2026-10-07 18:23:58');
INSERT INTO `eval_run` VALUES (1162,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',125,1,0,134,1.0000,'2026-10-07 18:23:58');
INSERT INTO `eval_run` VALUES (1163,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',125,1,0,175,1.0000,'2026-10-07 18:23:58');
INSERT INTO `eval_run` VALUES (1164,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',125,1,0,270,1.0000,'2026-10-07 18:23:59');
INSERT INTO `eval_run` VALUES (1165,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',126,1,0,1,1.0000,'2026-10-07 18:23:59');
INSERT INTO `eval_run` VALUES (1166,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',126,1,0,161,1.0000,'2026-10-07 18:23:59');
INSERT INTO `eval_run` VALUES (1167,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',126,1,0,217,1.0000,'2026-10-07 18:23:59');
INSERT INTO `eval_run` VALUES (1168,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',126,1,0,710,1.0000,'2026-10-07 18:24:00');
INSERT INTO `eval_run` VALUES (1169,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',127,1,0,2,1.0000,'2026-10-07 18:24:00');
INSERT INTO `eval_run` VALUES (1170,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',127,1,0,248,1.0000,'2026-10-07 18:24:00');
INSERT INTO `eval_run` VALUES (1171,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',127,1,0,137,1.0000,'2026-10-07 18:24:00');
INSERT INTO `eval_run` VALUES (1172,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',127,1,0,289,1.0000,'2026-10-07 18:24:01');
INSERT INTO `eval_run` VALUES (1173,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',128,1,0,1,1.0000,'2026-10-07 18:24:01');
INSERT INTO `eval_run` VALUES (1174,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',128,1,0,153,1.0000,'2026-10-07 18:24:01');
INSERT INTO `eval_run` VALUES (1175,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',128,1,0,150,1.0000,'2026-10-07 18:24:01');
INSERT INTO `eval_run` VALUES (1176,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',128,1,0,279,1.0000,'2026-10-07 18:24:01');
INSERT INTO `eval_run` VALUES (1177,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',129,1,0,1,1.0000,'2026-10-07 18:24:01');
INSERT INTO `eval_run` VALUES (1178,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',129,1,0,162,1.0000,'2026-10-07 18:24:01');
INSERT INTO `eval_run` VALUES (1179,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',129,1,0,202,1.0000,'2026-10-07 18:24:02');
INSERT INTO `eval_run` VALUES (1180,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',129,1,0,344,1.0000,'2026-10-07 18:24:02');
INSERT INTO `eval_run` VALUES (1181,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',130,1,0,1,1.0000,'2026-10-07 18:24:02');
INSERT INTO `eval_run` VALUES (1182,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',130,1,0,142,1.0000,'2026-10-07 18:24:02');
INSERT INTO `eval_run` VALUES (1183,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',130,1,0,146,1.0000,'2026-10-07 18:24:02');
INSERT INTO `eval_run` VALUES (1184,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',130,1,0,291,1.0000,'2026-10-07 18:24:02');
INSERT INTO `eval_run` VALUES (1185,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',131,0,0,1,0.0000,'2026-10-07 18:24:03');
INSERT INTO `eval_run` VALUES (1186,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',131,1,0,302,1.0000,'2026-10-07 18:24:03');
INSERT INTO `eval_run` VALUES (1187,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',131,1,0,403,1.0000,'2026-10-07 18:24:03');
INSERT INTO `eval_run` VALUES (1188,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',131,1,0,716,1.0000,'2026-10-07 18:24:04');
INSERT INTO `eval_run` VALUES (1189,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',132,0,0,1,0.0000,'2026-10-07 18:24:04');
INSERT INTO `eval_run` VALUES (1190,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',132,0,0,141,0.0000,'2026-10-07 18:24:04');
INSERT INTO `eval_run` VALUES (1191,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',132,0,0,213,0.0000,'2026-10-07 18:24:04');
INSERT INTO `eval_run` VALUES (1192,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',132,0,0,311,0.0000,'2026-10-07 18:24:05');
INSERT INTO `eval_run` VALUES (1193,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',133,0,0,2,0.0000,'2026-10-07 18:24:05');
INSERT INTO `eval_run` VALUES (1194,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',133,1,0,191,1.0000,'2026-10-07 18:24:05');
INSERT INTO `eval_run` VALUES (1195,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',133,1,0,205,1.0000,'2026-10-07 18:24:05');
INSERT INTO `eval_run` VALUES (1196,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',133,1,0,338,1.0000,'2026-10-07 18:24:05');
INSERT INTO `eval_run` VALUES (1197,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',134,0,0,2,0.0000,'2026-10-07 18:24:05');
INSERT INTO `eval_run` VALUES (1198,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',134,1,0,191,1.0000,'2026-10-07 18:24:06');
INSERT INTO `eval_run` VALUES (1199,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',134,1,0,153,1.0000,'2026-10-07 18:24:06');
INSERT INTO `eval_run` VALUES (1200,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',134,1,0,344,1.0000,'2026-10-07 18:24:06');
INSERT INTO `eval_run` VALUES (1201,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',135,1,0,1,1.0000,'2026-10-07 18:24:06');
INSERT INTO `eval_run` VALUES (1202,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',135,1,0,159,1.0000,'2026-10-07 18:24:06');
INSERT INTO `eval_run` VALUES (1203,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',135,1,0,881,1.0000,'2026-10-07 18:24:07');
INSERT INTO `eval_run` VALUES (1204,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',135,1,0,323,1.0000,'2026-10-07 18:24:08');
INSERT INTO `eval_run` VALUES (1205,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',136,0,0,1,0.0000,'2026-10-07 18:24:08');
INSERT INTO `eval_run` VALUES (1206,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',136,1,0,208,1.0000,'2026-10-07 18:24:08');
INSERT INTO `eval_run` VALUES (1207,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',136,0,0,150,0.0000,'2026-10-07 18:24:08');
INSERT INTO `eval_run` VALUES (1208,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',136,1,0,310,1.0000,'2026-10-07 18:24:08');
INSERT INTO `eval_run` VALUES (1209,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',137,1,0,2,1.0000,'2026-10-07 18:24:08');
INSERT INTO `eval_run` VALUES (1210,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',137,1,0,142,1.0000,'2026-10-07 18:24:08');
INSERT INTO `eval_run` VALUES (1211,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',137,1,0,154,1.0000,'2026-10-07 18:24:09');
INSERT INTO `eval_run` VALUES (1212,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',137,1,0,369,1.0000,'2026-10-07 18:24:09');
INSERT INTO `eval_run` VALUES (1213,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',138,0,0,2,0.0000,'2026-10-07 18:24:09');
INSERT INTO `eval_run` VALUES (1214,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',138,0,0,250,0.0000,'2026-10-07 18:24:09');
INSERT INTO `eval_run` VALUES (1215,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',138,0,0,394,0.0000,'2026-10-07 18:24:10');
INSERT INTO `eval_run` VALUES (1216,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',138,0,0,280,0.0000,'2026-10-07 18:24:10');
INSERT INTO `eval_run` VALUES (1217,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',139,0,0,2,0.0000,'2026-10-07 18:24:10');
INSERT INTO `eval_run` VALUES (1218,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',139,0,0,144,0.0000,'2026-10-07 18:24:10');
INSERT INTO `eval_run` VALUES (1219,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',139,0,0,140,0.0000,'2026-10-07 18:24:10');
INSERT INTO `eval_run` VALUES (1220,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',139,0,0,303,0.0000,'2026-10-07 18:24:11');
INSERT INTO `eval_run` VALUES (1221,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',140,1,0,2,1.0000,'2026-10-07 18:24:11');
INSERT INTO `eval_run` VALUES (1222,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',140,1,0,146,1.0000,'2026-10-07 18:24:11');
INSERT INTO `eval_run` VALUES (1223,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',140,1,0,244,1.0000,'2026-10-07 18:24:11');
INSERT INTO `eval_run` VALUES (1224,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',140,1,0,284,1.0000,'2026-10-07 18:24:12');
INSERT INTO `eval_run` VALUES (1225,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',141,0,0,1,0.0000,'2026-10-07 18:24:12');
INSERT INTO `eval_run` VALUES (1226,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',141,1,0,394,1.0000,'2026-10-07 18:24:12');
INSERT INTO `eval_run` VALUES (1227,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',141,1,0,184,1.0000,'2026-10-07 18:24:12');
INSERT INTO `eval_run` VALUES (1228,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',141,1,0,280,1.0000,'2026-10-07 18:24:13');
INSERT INTO `eval_run` VALUES (1229,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',142,1,0,1,1.0000,'2026-10-07 18:24:13');
INSERT INTO `eval_run` VALUES (1230,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',142,1,0,313,1.0000,'2026-10-07 18:24:13');
INSERT INTO `eval_run` VALUES (1231,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',142,1,0,240,1.0000,'2026-10-07 18:24:13');
INSERT INTO `eval_run` VALUES (1232,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',142,1,0,261,1.0000,'2026-10-07 18:24:13');
INSERT INTO `eval_run` VALUES (1233,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',143,1,0,1,1.0000,'2026-10-07 18:24:13');
INSERT INTO `eval_run` VALUES (1234,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',143,0,0,144,0.0000,'2026-10-07 18:24:14');
INSERT INTO `eval_run` VALUES (1235,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',143,1,0,131,1.0000,'2026-10-07 18:24:14');
INSERT INTO `eval_run` VALUES (1236,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',143,0,0,281,0.0000,'2026-10-07 18:24:14');
INSERT INTO `eval_run` VALUES (1237,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',144,0,0,1,0.0000,'2026-10-07 18:24:14');
INSERT INTO `eval_run` VALUES (1238,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',144,1,0,212,1.0000,'2026-10-07 18:24:14');
INSERT INTO `eval_run` VALUES (1239,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',144,1,0,158,1.0000,'2026-10-07 18:24:14');
INSERT INTO `eval_run` VALUES (1240,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',144,1,0,271,1.0000,'2026-10-07 18:24:15');
INSERT INTO `eval_run` VALUES (1241,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',145,0,0,1,0.0000,'2026-10-07 18:24:15');
INSERT INTO `eval_run` VALUES (1242,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',145,1,0,139,1.0000,'2026-10-07 18:24:15');
INSERT INTO `eval_run` VALUES (1243,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',145,1,0,145,1.0000,'2026-10-07 18:24:15');
INSERT INTO `eval_run` VALUES (1244,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',145,1,0,336,1.0000,'2026-10-07 18:24:15');
INSERT INTO `eval_run` VALUES (1245,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',146,1,0,1,1.0000,'2026-10-07 18:24:15');
INSERT INTO `eval_run` VALUES (1246,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',146,1,0,139,1.0000,'2026-10-07 18:24:16');
INSERT INTO `eval_run` VALUES (1247,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',146,1,0,139,1.0000,'2026-10-07 18:24:16');
INSERT INTO `eval_run` VALUES (1248,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',146,1,0,308,1.0000,'2026-10-07 18:24:16');
INSERT INTO `eval_run` VALUES (1249,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',147,1,0,1,1.0000,'2026-10-07 18:24:16');
INSERT INTO `eval_run` VALUES (1250,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',147,1,0,152,1.0000,'2026-10-07 18:24:16');
INSERT INTO `eval_run` VALUES (1251,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',147,1,0,129,1.0000,'2026-10-07 18:24:16');
INSERT INTO `eval_run` VALUES (1252,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',147,1,0,398,1.0000,'2026-10-07 18:24:17');
INSERT INTO `eval_run` VALUES (1253,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',148,0,0,1,0.0000,'2026-10-07 18:24:17');
INSERT INTO `eval_run` VALUES (1254,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',148,1,0,448,1.0000,'2026-10-07 18:24:17');
INSERT INTO `eval_run` VALUES (1255,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',148,1,0,168,1.0000,'2026-10-07 18:24:17');
INSERT INTO `eval_run` VALUES (1256,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',148,1,0,292,1.0000,'2026-10-07 18:24:18');
INSERT INTO `eval_run` VALUES (1257,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',149,1,0,1,1.0000,'2026-10-07 18:24:18');
INSERT INTO `eval_run` VALUES (1258,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',149,1,0,142,1.0000,'2026-10-07 18:24:18');
INSERT INTO `eval_run` VALUES (1259,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',149,1,0,140,1.0000,'2026-10-07 18:24:18');
INSERT INTO `eval_run` VALUES (1260,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',149,1,0,299,1.0000,'2026-10-07 18:24:18');
INSERT INTO `eval_run` VALUES (1261,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',150,1,0,1,1.0000,'2026-10-07 18:24:18');
INSERT INTO `eval_run` VALUES (1262,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',150,1,0,149,1.0000,'2026-10-07 18:24:18');
INSERT INTO `eval_run` VALUES (1263,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',150,1,0,231,1.0000,'2026-10-07 18:24:19');
INSERT INTO `eval_run` VALUES (1264,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',150,1,0,349,1.0000,'2026-10-07 18:24:19');
INSERT INTO `eval_run` VALUES (1265,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',151,1,0,3,1.0000,'2026-10-07 18:24:19');
INSERT INTO `eval_run` VALUES (1266,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',151,1,0,186,1.0000,'2026-10-07 18:24:19');
INSERT INTO `eval_run` VALUES (1267,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',151,1,0,141,1.0000,'2026-10-07 18:24:19');
INSERT INTO `eval_run` VALUES (1268,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',151,1,0,561,1.0000,'2026-10-07 18:24:20');
INSERT INTO `eval_run` VALUES (1269,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',152,1,0,1,1.0000,'2026-10-07 18:24:20');
INSERT INTO `eval_run` VALUES (1270,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',152,1,0,209,1.0000,'2026-10-07 18:24:20');
INSERT INTO `eval_run` VALUES (1271,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',152,1,0,155,1.0000,'2026-10-07 18:24:20');
INSERT INTO `eval_run` VALUES (1272,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',152,1,0,273,1.0000,'2026-10-07 18:24:21');
INSERT INTO `eval_run` VALUES (1273,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',153,1,0,2,1.0000,'2026-10-07 18:24:21');
INSERT INTO `eval_run` VALUES (1274,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',153,1,0,143,1.0000,'2026-10-07 18:24:21');
INSERT INTO `eval_run` VALUES (1275,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',153,1,0,130,1.0000,'2026-10-07 18:24:21');
INSERT INTO `eval_run` VALUES (1276,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',153,1,0,745,1.0000,'2026-10-07 18:24:22');
INSERT INTO `eval_run` VALUES (1277,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',154,0,0,2,0.0000,'2026-10-07 18:24:22');
INSERT INTO `eval_run` VALUES (1278,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',154,1,0,153,1.0000,'2026-10-07 18:24:22');
INSERT INTO `eval_run` VALUES (1279,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',154,1,0,134,1.0000,'2026-10-07 18:24:22');
INSERT INTO `eval_run` VALUES (1280,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',154,1,0,253,1.0000,'2026-10-07 18:24:22');
INSERT INTO `eval_run` VALUES (1281,'bm25_only','{\"mode\": \"BM25_ONLY\", \"topK\": 5}',155,1,0,1,1.0000,'2026-10-07 18:24:22');
INSERT INTO `eval_run` VALUES (1282,'vector_only','{\"mode\": \"VECTOR_ONLY\", \"topK\": 5}',155,1,0,132,1.0000,'2026-10-07 18:24:22');
INSERT INTO `eval_run` VALUES (1283,'hybrid_rrf_only','{\"mode\": \"HYBRID_RRF_ONLY\", \"topK\": 5}',155,1,0,134,1.0000,'2026-10-07 18:24:23');
INSERT INTO `eval_run` VALUES (1284,'hybrid','{\"mode\": \"HYBRID\", \"topK\": 5}',155,1,0,269,1.0000,'2026-10-07 18:24:23');
/*!40000 ALTER TABLE `eval_run` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kb_chunk`
--

DROP TABLE IF EXISTS `kb_chunk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kb_chunk` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `document_id` bigint NOT NULL,
  `parent_id` bigint DEFAULT NULL COMMENT '父块，实现父子块检索',
  `content` text NOT NULL,
  `token_count` int DEFAULT '0',
  `vector_id` varchar(64) DEFAULT NULL COMMENT 'Qdrant/Milvus 中的点 ID',
  `chunk_index` int DEFAULT '0' COMMENT '在原文档中的顺序',
  `metadata` json DEFAULT NULL COMMENT '茶类/主题等过滤字段',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_doc` (`document_id`),
  KEY `idx_parent` (`parent_id`),
  FULLTEXT KEY `ft_content` (`content`) /*!50100 WITH PARSER `ngram` */ ,
  CONSTRAINT `fk_chunk_doc` FOREIGN KEY (`document_id`) REFERENCES `kb_document` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='知识块表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kb_chunk`
--

LOCK TABLES `kb_chunk` WRITE;
/*!40000 ALTER TABLE `kb_chunk` DISABLE KEYS */;
INSERT INTO `kb_chunk` VALUES (1,1,NULL,'明前龙井指清明节前采摘的龙井茶，芽叶细嫩，氨基酸含量高，滋味鲜爽回甘，产量稀少因而价格较高。',45,NULL,0,NULL,'2026-10-03 23:03:12');
INSERT INTO `kb_chunk` VALUES (2,1,NULL,'雨前龙井指清明后谷雨前采摘的龙井茶，叶片稍大，茶多酚含量略高，滋味较明前更浓，价格相对亲民。',48,NULL,1,NULL,'2026-10-03 23:03:12');
INSERT INTO `kb_chunk` VALUES (3,1,NULL,'碧螺春产于江苏苏州太湖洞庭山，条索纤细卷曲如螺，白毫显露，冲泡后清香持久，有\"一嫩三鲜\"之说。',47,NULL,2,NULL,'2026-10-03 23:03:12');
INSERT INTO `kb_chunk` VALUES (4,1,NULL,'白茶按采摘标准分为白毫银针、白牡丹、贡眉、寿眉四类。白茶工艺极简，仅萎凋与干燥，越陈越香。',45,NULL,3,NULL,'2026-10-03 23:03:12');
INSERT INTO `kb_chunk` VALUES (5,2,NULL,'冲泡绿茶建议水温 80-85℃，避免沸水烫熟茶叶导致苦涩。玻璃杯冲泡可观赏茶叶舒展，投茶量约 3 克配 150ml 水。',52,NULL,4,NULL,'2026-10-03 23:03:12');
INSERT INTO `kb_chunk` VALUES (6,2,NULL,'紫砂壶适合冲泡乌龙茶、普洱茶，因其双气孔结构能吸附茶香，一壶一茶避免串味。新壶需开壶去土腥味。',48,NULL,5,NULL,'2026-10-03 23:03:12');
INSERT INTO `kb_chunk` VALUES (100,3,NULL,'中国茶叶按加工工艺与发酵程度分为六大茶类：绿茶（不发酵）、白茶（微发酵）、黄茶（轻发酵）、青茶/乌龙茶（半发酵）、红茶（全发酵）、黑茶（后发酵）。发酵程度决定茶多酚氧化程度，进而决定汤色、香气与滋味走向。',60,NULL,0,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (101,3,NULL,'绿茶属不发酵茶，鲜叶经杀青、揉捻、干燥而成。杀青通过高温钝化多酚氧化酶，保留大量茶多酚与叶绿素，因此汤色清绿、滋味鲜爽。代表茶有西湖龙井、洞庭碧螺春、黄山毛峰、信阳毛尖、太平猴魁。',62,NULL,1,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (102,3,NULL,'西湖龙井属炒青绿茶，产于杭州西湖区。外形扁平挺直、光滑匀齐，色翠略黄似糙米色，香气清高持久带豆香或兰花香，滋味鲜爽甘醇，汤色清澈明亮，叶底嫩绿成朵。以狮峰、龙井、云栖、虎跑、梅家坞五地所产品质最佳，号称\"狮龙云虎梅\"。',78,NULL,2,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (103,3,NULL,'洞庭碧螺春产于江苏苏州太湖洞庭东山与西山，属炒青绿茶。外形条索纤细卷曲如螺，满披白毫，冲泡后清香持久，滋味鲜醇甘厚，有\"一嫩（芽叶嫩）三鲜（色鲜艳、香鲜浓、味鲜醇）\"之誉。因茶树与果树间种，常带天然花果香。',72,NULL,3,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (104,3,NULL,'黄山毛峰属烘青绿茶，产于安徽黄山。外形微卷似雀舌，色如象牙，带金黄色鱼叶（俗称\"黄金片\"），香气清鲜高长，滋味醇厚回甘，汤色清碧微黄。特级毛峰采一芽一叶初展，清明前后开采。',62,NULL,4,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (105,3,NULL,'信阳毛尖产于河南信阳，属炒青绿茶。外形细、圆、光、直、多白毫，色泽翠绿，香气清高带熟栗子香，滋味醇厚鲜爽，汤色嫩绿明亮。以\"细圆光直多白毫，香高味浓汤色绿\"为品质特征，谷雨前采制的\"明前\"\"雨前\"品质最优。',70,NULL,5,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (106,3,NULL,'太平猴魁属烘青绿茶，产于安徽黄山太平县（今黄山区）猴坑一带。外形两叶抱芽、扁平挺直、自然舒展，白毫隐伏，有\"猴魁两头尖，不散不翘不卷边\"之称。香气高爽持久带兰花香，滋味鲜爽醇厚回甘，叶底嫩匀肥厚。',66,NULL,6,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (107,3,NULL,'安吉白茶虽名为\"白茶\"，实为绿茶——因茶树品种\"白叶一号\"在低温期叶绿素缺失、叶色玉白而得名，加工工艺是杀青绿茶工艺。氨基酸含量高达 6% 以上（普通绿茶约 2-3%），因此滋味特别鲜爽，几乎无苦涩。',66,NULL,7,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (108,3,NULL,'白茶属微发酵茶，工艺极简，仅萎凋与干燥两步，不炒不揉。按采摘标准分为白毫银针（单芽）、白牡丹（一芽一二叶）、贡眉与寿眉（一芽二三叶及叶片）。新白茶毫香清鲜、汤色杏黄；陈放后转化出枣香、药香，有\"一年茶三年药七年宝\"之说。',76,NULL,8,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (109,3,NULL,'白毫银针产于福建福鼎、政和，全由肥壮单芽制成，满披白毫、挺直如针、色白如银。汤色浅杏黄清澈，毫香显露，滋味清鲜醇和。因产量稀少、采摘期短（清明前后十余天），为白茶中最高等级。',62,NULL,9,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (110,3,NULL,'白牡丹取一芽一二叶，绿叶夹银白色毫心，冲泡后绿叶托嫩芽，形似花朵故名。汤色杏黄或橙黄清澈，毫香显且带花香，滋味清甜醇爽，是白茶中性价比较高的品类。',56,NULL,10,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (111,3,NULL,'寿眉与贡眉采一芽二三叶或抽针后的叶片制成，叶张稍肥嫩、芽叶连枝，梗叶相间。汤色橙黄，滋味醇厚，陈化后易出枣香与药香，是老白茶与煮茶的主要原料。寿眉产量最大，价格亲民。',60,NULL,11,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (112,3,NULL,'黄茶属轻发酵茶，关键工艺是\"闷黄\"——杀青后趁热堆积或用纸包裹，使茶多酚轻度氧化、叶绿素破坏，形成\"黄汤黄叶\"特征。按鲜叶老嫩分黄芽茶（君山银针、蒙顶黄芽）、黄小茶、黄大茶（霍山黄大茶）。',68,NULL,12,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (113,3,NULL,'君山银针产于湖南岳阳洞庭湖君山岛，属黄芽茶。外形芽头肥壮挺直、满披茸毛、色金黄光亮。冲泡时芽尖冲向水面，悬空竖立，继而徐徐下沉，三起三落，为茶中奇观。汤色橙黄明亮，香气清鲜，滋味甜爽。',70,NULL,13,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (114,3,NULL,'乌龙茶（青茶）属半发酵茶，工艺为萎凋、做青、炒青、揉捻、烘焙。做青是形成乌龙茶品质的关键——通过摇青与晾青交替，使叶片边缘摩擦破损、发生酶促氧化，形成\"绿叶红镶边\"。香气馥郁，兼具绿茶清香与红茶醇厚。',76,NULL,14,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (115,3,NULL,'铁观音原产福建安溪，属闽南乌龙。传统清香型铁观音外形卷曲紧结、沉重似铁，色泽砂绿，有\"蜻蜓头、螺旋体、青蛙腿\"之说。香气清高带兰花香（\"观音韵\"），滋味醇厚甘鲜，七泡有余香。浓香型经烘焙，带火香与米香。',78,NULL,15,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (116,3,NULL,'武夷岩茶属闽北乌龙，产于福建武夷山。因茶树生长于岩缝之中，形成独特\"岩韵\"——香气辛锐、滋味醇厚、回甘明显、喉韵深长。代表品种有大红袍、肉桂、水仙、白鸡冠、铁罗汉、水金龟、半天妖。',70,NULL,16,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (117,3,NULL,'大红袍是武夷岩茶中最著名的名丛，母树仅存六株于武夷山九龙窠绝壁。现市售大红袍多为母树无性繁殖（纯种）或以肉桂、水仙拼配（商品大红袍）。品质特征为香气馥郁带兰花香、岩韵明显、汤色橙黄明亮、耐冲泡。',72,NULL,17,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (118,3,NULL,'凤凰单丛产于广东潮州凤凰山，属广东乌龙。按香型分为蜜兰香、黄枝香、芝兰香、桂花香、玉兰香、姜花香、夜来香、茉莉香、杏仁香、肉桂香十大香型。香气高锐持久，滋味浓醇鲜爽，回甘力强，极耐冲泡。',70,NULL,18,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (119,3,NULL,'铁观音与武夷岩茶的区别：铁观音属闽南乌龙，发酵度较低（约 15-30%），清香型为主，香气清高带兰花香，汤色金黄；武夷岩茶属闽北乌龙，发酵度较高（约 30-60%），焙火重，讲究\"岩骨花香\"，汤色橙红，滋味更醇厚且带火功香。',80,NULL,19,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (120,3,NULL,'红茶属全发酵茶，鲜叶经萎凋、揉捻、发酵、干燥而成。发酵使茶多酚氧化生成茶黄素、茶红素，形成\"红汤红叶\"特征。香气甜醇带花果香或蜜香，滋味醇厚甘甜，性温，适合冬季饮用与调饮。',66,NULL,20,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (121,3,NULL,'正山小种产于福建武夷山桐木关，是世界最早的红茶（约 16 世纪末），被称为\"红茶鼻祖\"。传统工艺用松柴熏焙，形成独特的松烟香与桂圆汤味。现分烟小种（传统熏焙）与无烟小种（近年主流）。',68,NULL,21,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (122,3,NULL,'金骏眉是 2005 年创制的顶级红茶，产于武夷山桐木关。全由单芽制成，数万颗芽头才得一斤干茶。外形细小紧密、金毫显露，汤色金黄，香气带花果香、蜜香与桂圆香，滋味鲜活甘爽。因原料珍稀，价格昂贵，市面仿品极多。',76,NULL,22,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (123,3,NULL,'祁门红茶简称\"祁红\"，产于安徽祁门一带，是世界三大高香红茶之一。外形条索紧细苗秀，色泽乌润，香气浓郁带玫瑰花香（\"祁门香\"），滋味鲜醇甘厚，汤色红艳明亮。适合清饮，加奶后香气不减，为英式下午茶常用茶。',74,NULL,23,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (124,3,NULL,'滇红产于云南，以大叶种茶树鲜叶制成。芽叶肥壮、金毫显露，汤色红浓明亮，香气高锐带蜜香，滋味浓强鲜爽、刺激性较强。因内含物质丰富，极耐冲泡，常用于调饮奶茶。代表有滇红工夫、金针、金螺。',68,NULL,24,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (125,3,NULL,'黑茶属后发酵茶，关键工序是渥堆——通过微生物参与发酵，使茶叶内含物发生深刻转化。特征为色泽黑褐、汤色红浓、滋味醇厚陈香。主要品类有湖南安化黑茶、广西六堡茶、云南普洱茶（熟茶）、湖北青砖、四川边茶。',72,NULL,25,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (126,3,NULL,'普洱茶分生茶与熟茶。生茶以云南大叶种晒青毛茶为原料，自然陈化，新茶汤色黄绿、滋味强烈、带青味，随年份转化出陈香、汤色转红。熟茶经人工渥堆发酵，汤色红浓、滋味醇厚顺滑、带陈香，可即时饮用。',70,NULL,26,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (127,3,NULL,'六堡茶产于广西梧州苍梧县六堡镇，属黑茶。以\"红、浓、陈、醇\"著称，带独特槟榔香。历史上通过\"茶船古道\"远销南洋，因耐储存、解暑祛湿，成为东南亚华人矿工的日常饮品。',60,NULL,27,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (128,3,NULL,'安化黑茶产于湖南安化，传统品类有\"三尖\"（天尖、贡尖、生尖）、\"三砖\"（茯砖、黑砖、花砖）、\"一卷\"（千两茶）。其中茯砖茶在渥堆后需\"发花\"——生长冠突散囊菌（俗称\"金花\"），使茶汤更醇和并带独特菌花香。',72,NULL,28,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (129,3,NULL,'六大茶类发酵度与茶性对照：绿茶不发酵、性寒；白茶微发酵、性凉（老白茶转平）；黄茶轻发酵、性凉；乌龙茶半发酵、性平；红茶全发酵、性温；黑茶后发酵、性温和。体质偏寒宜红茶与黑茶，体质偏热宜绿茶与白茶。',76,NULL,29,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (130,4,NULL,'绿茶冲泡要点：水温 80-85℃，切忌沸水直冲——高温会烫熟茶叶、破坏叶绿素，使茶汤发黄发苦。投茶量约 3 克配 150 毫升水。建议用玻璃杯或白瓷盖碗，便于观赏茶叶舒展与汤色。第一泡约 1 分钟即可饮用。',74,NULL,0,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (131,4,NULL,'绿茶三种投茶法：①上投法——先注水后投茶，适合细嫩名茶（碧螺春、信阳毛尖），茶叶徐徐下沉、观赏性最佳；②中投法——先注三分之一水、投茶、再注满，适合龙井等扁平茶；③下投法——先投茶后注水，适合普通绿茶与老叶茶。',78,NULL,1,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (132,4,NULL,'红茶冲泡要点：水温 90-95℃，投茶量约 3-5 克配 150 毫升水，冲泡时间 3-5 秒出汤（工夫红茶宜快出汤，避免苦涩）。宜用白瓷盖碗或紫砂壶。清饮可品其花果蜜香；调饮可加牛奶、柠檬、蜂蜜。',70,NULL,2,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (133,4,NULL,'乌龙茶冲泡要点：必须用沸水（100℃），因为乌龙茶发酵度较高、叶片厚实，低温无法激发香气。投茶量大（约 7-8 克配 100 毫升水，约占壶容三分之一至二分之一）。用紫砂壶或盖碗，快冲快出，可冲泡七次以上。',74,NULL,3,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (134,4,NULL,'乌龙茶\"工夫泡法\"步骤：①温壶烫杯；②投茶（壶容 1/3 至 1/2）；③洗茶（快速注水后立即倒出，唤醒茶叶）；④高冲注水；⑤刮沫淋壶；⑥出汤（首泡约 15-30 秒，之后逐泡延长 5-10 秒）；⑦分茶入杯，先闻香后品味。',80,NULL,4,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (135,4,NULL,'白茶冲泡要点：新白茶（白毫银针、白牡丹）水温 85-90℃，用玻璃杯或盖碗，可观赏芽叶舒展。老白茶（寿眉、老贡眉）宜用沸水冲泡或煮饮，煮茶时投茶 5 克配 500 毫升水，煮沸后转小火慢煮 3-5 分钟，可充分释放陈香与药香。',80,NULL,5,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (136,4,NULL,'黑茶冲泡要点：必须用沸水（100℃），且建议先\"洗茶\"两次以去除渥堆陈味、唤醒茶性。投茶量约 5-8 克配 150 毫升水，可用紫砂壶或盖碗。老茶、紧压茶（茶砖、千两茶）适合煮饮，煮出的茶汤更醇厚顺滑。',72,NULL,6,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (137,4,NULL,'普洱茶冲泡要点：生茶水温 95-100℃，投茶 5-7 克，快出汤（前几泡 5-10 秒），避免闷出苦涩；熟茶水温 100℃，可适当闷泡（10-20 秒）以激发陈香。建议用紫砂壶（熟茶）或盖碗（生茶，便于观察汤色变化与判断年份）。',76,NULL,7,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (138,4,NULL,'盖碗泡茶的优势：①材质为白瓷，不吸香不串味，能真实反映茶叶本味；②碗口宽阔便于闻香、观汤色、看叶底；③出汤快、易控制时间；④适合评审与日常冲泡，六大茶类通用。缺点是需练习手法，避免烫手。',70,NULL,8,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (139,4,NULL,'紫砂壶泡茶的优势与局限：双气孔结构使其透气而不透水，能吸附茶香并\"养壶\"，长期使用后即使注白水也有茶香。因吸附性强，必须\"一壶一茶\"避免串味。局限：不适合冲泡绿茶与清香型乌龙（会吸附其清扬香气、闷熟茶叶）。',74,NULL,9,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (140,4,NULL,'水质对茶汤的影响：古人云\"水为茶之母\"。首选山泉水（矿物质含量适中、活性好）；次选纯净水（稳定但略平）；自来水需煮沸后静置去氯。硬水（钙镁离子高）会使茶汤浑浊、滋味发涩、香气沉闷；软水泡茶汤色明亮、香气清扬。',74,NULL,10,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (141,4,NULL,'泡茶水温通则：芽叶细嫩的名优绿茶 80-85℃；普通绿茶 85-90℃；黄茶 85-90℃；白茶（新）85-90℃、（老）100℃；乌龙茶 100℃；红茶 90-95℃；黑茶与普洱 100℃。判断水温可看水沸状态：蟹眼（80℃）、鱼眼（90℃）、腾波鼓浪（100℃）。',86,NULL,11,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (142,4,NULL,'茶叶\"洗茶\"的作用与争议：洗茶（温润泡）可去除表面浮尘、降低仓储陈味、唤醒茶性，对黑茶、老白茶、陈年乌龙尤为必要。但对细嫩绿茶与高等级白茶，洗茶会流失氨基酸与香气，建议跳过或仅用极快的一冲。',74,NULL,12,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (143,4,NULL,'茶汤审评的四项因子：①香气——热嗅辨纯异、温嗅辨香型、冷嗅辨持久性；②汤色——看色度、亮度、清浊；③滋味——品浓淡、醇涩、鲜爽、回甘与喉韵；④叶底——看嫩度、匀整度、色泽与活性。专业审评还需加\"外形\"一项。',78,NULL,13,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (144,4,NULL,'茶汤\"回甘\"与\"生津\"：回甘指饮后口腔由苦转甜的转化感，源于茶多酚与唾液蛋白结合后的收敛消退；生津指两颊、舌底分泌唾液，是茶汤中糖类、氨基酸与有机酸共同刺激的结果。二者与\"喉韵\"（茶汤下咽后喉部持久的甘润感）共同构成好茶的体感层次。',88,NULL,14,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (145,4,NULL,'茶叶\"苦涩\"的来源：苦味主要来自咖啡碱、茶皂素与部分黄酮类；涩感来自茶多酚（儿茶素类）与唾液蛋白结合产生的收敛作用。苦涩本身不是缺点——关键在于能否\"化得开\"：优质茶苦涩入口后迅速转化为回甘，劣质茶则苦涩滞留、化不开。',82,NULL,15,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (146,4,NULL,'陈香与霉味的区别：陈香是茶叶在良好仓储中经缓慢氧化与微生物转化产生的醇和香气（带木香、药香、枣香），闻之舒适；霉味是受潮霉变产生的刺鼻、闷浊、带土腥或酸腐的气味，茶汤浑浊发暗。前者是价值，后者是变质，务必区分。',82,NULL,16,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (147,4,NULL,'不同茶类的耐泡次数参考：细嫩绿茶 2-3 泡；黄茶 2-3 泡；新白茶 3-5 泡、老白茶（煮）可 8 泡以上；清香乌龙 5-7 泡；浓香/岩茶 7-10 泡；红茶 3-5 泡；黑茶与普洱 8-15 泡（古树茶可达 20 泡）。耐泡度与茶叶内含物丰富度、投茶量、水温相关。',86,NULL,17,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (148,4,NULL,'冷泡茶的做法与特点：用常温水或冷水（约 4-10℃）浸泡茶叶 4-8 小时（冷藏过夜更佳），茶水比约 1:100。低温萃取使咖啡碱与茶多酚析出减少，因此苦涩度低、甘甜感突出、咖啡因含量较低，适合夏季与对咖啡因敏感人群。绿茶、白茶、乌龙茶均适合冷泡。',92,NULL,18,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (149,4,NULL,'煮茶的适用茶类与方法：适合黑茶（茯砖、六堡）、老白茶（寿眉、贡眉）、陈年普洱与陈皮茶。方法：投茶 5-8 克配 500-800 毫升水，冷水入壶同煮，水沸后转小火煮 3-5 分钟即可出汤；可续煮 2-3 次。注意不宜久煮，否则茶汤过浓发苦。',82,NULL,19,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (150,4,NULL,'调饮茶常见搭配：红茶 + 牛奶（奶茶）、红茶 + 柠檬（柠檬红茶）、绿茶 + 薄荷、乌龙茶 + 蜂蜜、普洱茶 + 菊花/陈皮/玫瑰。注意：加奶会掩盖细嫩茶的香气，因此调饮宜选滋味浓强的滇红、祁红或碎茶，不宜用名优绿茶。',74,NULL,20,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (151,4,NULL,'茶点的搭配原则：\"甜配绿、酸配红、瓜子配乌龙\"。绿茶清鲜，宜配清淡微甜的茶点（绿豆糕、龙须酥）以免盖过茶香；红茶醇厚，宜配带酸味的点心（柠檬派、果酱饼干）以平衡口感；乌龙茶香气高，宜配咸香坚果（瓜子、花生）以衬茶香。',84,NULL,21,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (152,4,NULL,'品茶的环境与心境：古人讲究\"茶宜精舍、宜云林、宜松月、宜晏坐\"（明·许次纾《茶疏》）。品茶环境宜安静、通风、无异味，避免香水、烟味、油烟干扰嗅觉。器皿宜素雅（白瓷、青瓷、紫砂），光线宜柔和自然，便于观察汤色与叶底。',82,NULL,22,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (153,4,NULL,'茶汤浓度与投茶量换算：日常冲泡茶水比参考——绿茶 1:50（3g/150ml）；红茶 1:50 至 1:60；乌龙茶 1:15 至 1:20（7g/100-140ml，因需多次冲泡）；白茶 1:20 至 1:30；黑茶/普洱 1:20 至 1:25。口味浓淡可在此基础上增减 20%。',82,NULL,23,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (154,4,NULL,'水质硬度与茶汤表现的实测结论：用 TDS 检测笔测量，泡茶理想 TDS 为 30-80 mg/L。TDS 低于 10（纯净水）茶汤清亮但香气偏薄；TDS 高于 150（硬水）茶汤易浑浊、滋味发涩、香气沉闷，且易在茶具上结水垢。若本地自来水 TDS 过高，建议用净水器过滤后再泡。',96,NULL,24,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (155,5,NULL,'绿茶选购要点：一看外形——条索紧结匀整、色泽嫩绿或翠绿有光泽；二闻香气——清高纯正、无异味；三看汤色——清亮不浑浊；四品滋味——鲜爽回甘、不苦涩。新茶（当年春茶）香气最佳，隔年绿茶香气明显衰减。',70,NULL,0,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (156,5,NULL,'龙井茶的等级与产区：按产区分为西湖产区（核心，狮龙云虎梅）、钱塘产区、越州产区。只有西湖产区的才能叫\"西湖龙井\"，其余为\"龙井茶\"。按采摘时间分\"明前\"（清明前，最贵）、\"雨前\"（谷雨前）、\"雨后\"。明前茶芽叶细嫩、产量少、价格高；雨前茶滋味更浓、性价比更好。',92,NULL,1,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (157,5,NULL,'明前茶与雨前茶的区别：明前茶为清明节前采制，气温低、芽叶细嫩、氨基酸含量高、茶多酚相对低，因此滋味鲜爽甘甜、几乎无苦涩，但产量稀少、价格高昂；雨前茶为清明至谷雨间采制，气温回升、芽叶稍大、茶多酚含量略高，滋味更浓醇、耐泡度更好，价格相对亲民。',96,NULL,2,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (158,5,NULL,'白茶的年份与价值：白茶有\"一年茶、三年药、七年宝\"之说。新白茶性凉、毫香清鲜；陈放 3 年以上转化出枣香、药香，茶性转平和，适合煮饮；7 年以上为稀有老茶，汤色橙红透亮、滋味醇厚顺滑。选购老白茶需注意辨别做旧茶——做旧茶色泽死黑、香气闷浊、汤色暗沉。',96,NULL,3,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (159,5,NULL,'普洱茶选购：①看原料——古树茶（树龄百年以上）与台地茶（密植茶园）品质与价格差距大；②看年份——生茶需陈化，熟茶可即时饮；③看仓储——干仓（湿度低、转化慢、香气纯正）优于湿仓（湿度高、转化快但易霉变）；④看外形——条索肥壮、色泽油润、无霉斑。',86,NULL,4,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (160,5,NULL,'如何辨别染色茶与加香茶：染色绿茶（常见于劣质碧螺春）用湿纸巾擦拭会掉色；加香茶（如加香铁观音）干茶香气刺鼻浓烈、不自然，冲泡 2-3 泡后香气骤减甚至出现水味。天然茶叶香气是内源性的，随冲泡次数递减平缓，且冷嗅（茶汤冷却后）仍有留香。',88,NULL,5,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (161,5,NULL,'茶叶储存的五大敌人：①光线——紫外线加速叶绿素与脂类氧化；②高温——每升高 10℃ 氧化速率约翻倍；③氧气——氧化茶多酚与香气物质；④潮湿——含水率超过 7% 易霉变；⑤异味——茶叶多孔结构极易吸附周围气味（如樟脑、调料、化妆品）。',84,NULL,6,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (162,5,NULL,'绿茶与清香型乌龙的储存：必须密封、避光、防潮、低温。最佳方式是分装成小份（约 50-100 克）抽真空或加脱氧剂，放入冰箱冷冻室（-18℃）或冷藏室（0-5℃）。注意：从冰箱取出后需等茶罐恢复至室温再开封，否则冷凝水会使茶叶受潮。',84,NULL,7,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (163,5,NULL,'红茶与浓香型乌龙的储存：常温、密封、避光、干燥即可，无需冷藏。红茶全发酵、内含物相对稳定，常温可存 1-2 年；浓香型乌龙（武夷岩茶、炭焙铁观音）经焙火后水分低，常温密封可存 2-3 年，且隔年\"退火\"后滋味更醇和。',76,NULL,8,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (164,5,NULL,'黑茶与白茶的储存：与绿茶相反，这两类需要\"呼吸\"与后发酵转化。宜用透气材质（棉纸、竹篓、陶罐）包装，存放于阴凉、干燥、通风、无异味处，避免密封死。适宜湿度 60-70%、温度 20-28℃。注意避免与有异味物品同放，且定期检查有无霉变。',84,NULL,9,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (165,5,NULL,'茶叶含水率的判断与标准：国标要求绿茶含水率 ≤7%，黑茶 ≤14%。简易判断法：抓一把茶叶紧握，松手后若能自然散开且有清脆\"沙沙\"声，说明较干；若成团不散、手感柔软，说明含水率偏高、易霉变。含水率高的茶应尽快烘干或优先饮用。',76,NULL,10,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (166,5,NULL,'冰箱存茶的注意事项：①必须密封——茶叶吸附性极强，与食物同放会串味；②分装小份——避免反复取用造成温差结露；③绿茶、清香乌龙适合冷藏，红茶、黑茶、白茶不宜冷藏（低温会抑制后发酵转化）；④从冰箱取出的茶需回温后再开袋。',78,NULL,11,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (167,5,NULL,'茶叶保质期的真相：绿茶常温约 12 个月（冷藏可延至 18 个月）；红茶 2-3 年；乌龙茶（清香）18 个月、（浓香/岩茶）2-3 年；白茶与黑茶在合适条件下可长期存放（越陈越香，但需定期检查）。\"保质期\"与\"最佳品饮期\"不同——绿茶过期后香气衰减但仍可饮用（只要无霉变）。',96,NULL,12,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (168,5,NULL,'如何判断茶叶是否变质：①闻——出现霉味、酸味、油哈味（脂肪氧化）；②看——干茶发暗、长白霜或绿毛（霉斑）；③摸——手感发软、成团；④泡——茶汤浑浊发暗、滋味寡淡或有异味。出现霉变的茶必须丢弃，不可饮用（霉菌毒素耐高温，冲泡无法去除）。',88,NULL,13,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (169,5,NULL,'网购茶叶的避坑要点：①警惕\"9.9 元包邮古树茶\"等价格背离成本的产品；②看生产日期而非\"保质期\"，绿茶尤重新鲜度；③要求提供检测报告（农残、重金属）；④注意\"明前特级\"等标签是否有产区与等级标准支撑；⑤优先选择可退换的商家，收到后立即试泡验证。',88,NULL,14,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (170,5,NULL,'茶叶价格的影响因素：①产区（核心产区 vs 外围）；②采摘时间（明前 > 雨前 > 雨后）；③采摘标准（单芽 > 一芽一叶 > 一芽二叶）；④工艺（手工 vs 机制）；⑤产量与稀有度；⑥品牌与包装。同样叫\"龙井\"，核心产区明前手工茶与外围产区雨前机制茶价差可达数十倍。',92,NULL,15,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (171,5,NULL,'春茶、夏茶、秋茶的区别：春茶（3-5 月）内含物丰富、滋味鲜爽，品质最佳；夏茶（6-7 月）气温高、生长快，茶多酚含量高、氨基酸低，滋味苦涩，多用于制作红茶与大宗茶；秋茶（8-10 月）香气高长但滋味较薄，铁观音的\"秋香\"即指此特点。',82,NULL,16,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (172,5,NULL,'茶叶的\"回潮\"与复焙：茶叶受潮后可通过复焙（低温烘干）挽救，温度控制在 60-80℃、时间 20-40 分钟，中途翻动。但复焙会损失部分香气，且仅适用于含水率轻度超标、尚未霉变的茶。已霉变的茶无法通过复焙挽救。',74,NULL,17,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (173,5,NULL,'散茶与紧压茶的选择：散茶取用方便、转化快（与空气接触面积大），但占空间、易受潮；紧压茶（茶饼、茶砖、沱茶）体积小、利于长期陈化与运输，且内部转化缓慢均匀，是黑茶与普洱的传统形态。选购时注意茶饼是否松紧适度（过紧不利转化，过松易碎）。',86,NULL,18,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (174,5,NULL,'送礼选茶的考虑因素：①收礼人饮茶习惯（不常喝茶者宜选红茶或白茶，接受度高；老茶客宜选岩茶、普洱）；②保质与储存难度（绿茶需冷藏，不宜长途送礼）；③包装体面度；④预算与性价比。搭配建议：绿茶礼盒适合春季、长辈；红茶礼盒四季皆宜、商务场合稳妥。',90,NULL,19,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (175,6,NULL,'紫砂壶的\"开壶\"方法：新壶需去除烧制残留的土腥味与窑灰。步骤：①清水洗净壶内外；②放入锅中加清水没过壶身，小火煮沸后加入少量茶叶（与日后泡的茶类相同），继续煮 20-30 分钟；③取出自然冷却、晾干。切忌骤冷骤热，以免惊裂。',82,NULL,0,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (176,6,NULL,'紫砂壶的日常养护（养壶）：①专壶专用——一把壶只泡一类茶，避免串味；②用后及时清理——倒净茶渣，用清水冲洗，切勿用洗洁精；③自然晾干——倒扣于通风处阴干，忌暴晒或用布用力擦拭；④定期\"淋壶\"——泡茶时用茶汤浇淋壶身，长期使用形成温润包浆。',88,NULL,1,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (177,6,NULL,'紫砂泥料的主要类型：①紫泥（紫砂）——最常见，透气性好，适泡普洱、乌龙；②红泥（朱泥）——收缩率大、成品小，适合乌龙茶，聚香性好；③段泥（团泥）——颜色浅黄，透气性最佳，适合绿茶、白茶、黄茶等轻发酵茶；④绿泥——产量稀少，质地较嫩。',82,NULL,2,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (178,6,NULL,'盖碗的选择：①材质——白瓷最佳（不吸香、易观察汤色），青瓷次之，玻璃便于观赏；②容量——日常 110-150 毫升，评审用 150 毫升标准碗；③器型——碗口外撇便于出汤、不易烫手；④盖与碗的贴合度——过松易漏，过紧易卡。新手建议选厚胎盖碗，散热慢、不易烫手。',92,NULL,3,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (179,6,NULL,'公道杯（茶海）的作用：将盖碗或壶中的茶汤先倒入公道杯，再分入各品茗杯。作用有三：①均匀茶汤浓度——避免先倒的淡、后倒的浓；②沉淀茶渣；③便于观色闻香。材质以玻璃为佳（可观汤色），白瓷次之，避免使用有色的内壁影响观色。',82,NULL,4,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (180,6,NULL,'品茗杯的选择与用法：容量宜小（30-50 毫升），便于小口品饮、感受香气与回甘。材质以白瓷、青瓷为佳，内壁必须为白色以便观察汤色。持杯方式：拇指与食指捏杯沿，中指托杯底，称\"三龙护鼎\"；饮时小口啜入，让茶汤在口腔中铺开以充分接触味蕾。',88,NULL,5,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (181,6,NULL,'茶滤（滤网）的使用与取舍：用于过滤茶汤中的碎末，使茶汤清澈。材质有金属（不锈钢、银）、陶瓷、棉麻、竹制。注意：细密滤网会过滤掉部分茶毫与内含物质，影响口感层次，因此高等级名优茶（白毫银针、碧螺春）通常不用滤网，直接出汤。',78,NULL,6,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (182,6,NULL,'铁壶与银壶的适用性：①铁壶——煮水可提升水温并释放微量铁离子，使水质更\"软\"，适合冲泡老茶与普洱，但不宜煮茶（易生锈、影响茶味）；②银壶——导热极快、水质清甜，适合煮水与煮茶，抑菌性好，但价格昂贵、需定期擦拭保养。',82,NULL,7,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (183,6,NULL,'玻璃茶具的优势与适用茶类：透明材质便于观赏茶叶在水中舒展、沉浮与汤色变化，特别适合冲泡名优绿茶（龙井、碧螺春）、白茶（白毫银针）与花草茶。缺点是保温性差（水温下降快），因此不适合需要高温冲泡的乌龙茶与黑茶。',76,NULL,8,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (184,6,NULL,'茶具的清洁禁忌：①忌用洗洁精——残留会污染茶味，且紫砂会吸附化学气味；②忌用钢丝球——会刮伤釉面与紫砂表面；③忌用开水长时间浸泡紫砂——可能致裂；④茶垢不宜过度清洗——白瓷上的茶垢可用小苏打或牙膏轻擦，紫砂的\"包浆\"应保留。',82,NULL,9,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (185,6,NULL,'陶瓷茶具的分类：①白瓷——胎质细腻、釉色洁白，不吸香、便于观色，六大茶类通用；②青瓷——釉色青翠温润，以龙泉青瓷、汝窑为代表，适合绿茶与白茶；③青花瓷——白地蓝花，兼具实用与观赏价值；④汝窑/哥窑——开片纹理，讲究\"雨过天青色\"。',86,NULL,10,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (186,6,NULL,'茶盘的选择：①材质——竹木（电木、乌金石、紫檀）最常见，石质（端砚石、黑金石）稳重大气，陶瓷便于清洁；②排水方式——嵌入式（盘面开槽排水）整洁但需接管，明式（盘面斜坡直接排入下方水桶）简单实用；③尺寸——按常用茶具数量选择，单人 30×20cm 即可。',90,NULL,11,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (187,6,NULL,'茶巾的使用与更换：茶巾用于擦拭茶具与桌面，应选吸水性好的棉麻材质。使用时区分\"湿巾\"（擦拭茶汤）与\"干巾\"（擦干杯底、防止水渍），避免混用。茶巾需每日清洗晾干，否则易滋生细菌并产生异味，反而污染茶具。',74,NULL,12,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (188,6,NULL,'紫砂壶\"惊裂\"的原因与预防：惊裂指壶体因温差骤变而开裂。常见诱因：①冬季用冷水壶直接注入沸水；②开壶时从沸水直接投入冷水；③清洗后立即用高温水冲烫。预防：使用前先用温水\"温壶\"（内外淋浇温水，再逐步升温），冬季尤须注意。',82,NULL,13,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (189,6,NULL,'茶具的\"养\"与\"净\"的平衡：紫砂讲究养出包浆（茶汤滋养形成的温润光泽），但\"养\"不等于\"脏\"——茶垢堆积过厚会滋生细菌、影响茶味。正确做法：每次用后清水冲洗、阴干，让包浆自然累积；若出现异味，可用清水煮沸后自然冷却，恢复茶壶\"呼吸\"。',84,NULL,14,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (190,7,NULL,'茶的起源：中国是茶的故乡，饮茶始于神农氏（传说\"神农尝百草，日遇七十二毒，得荼而解之\"）。茶最初作药用，后为食用（羹饮），至唐代转为清饮并形成文化。陆羽《茶经》（约 780 年）是世界第一部茶学专著，标志着中国茶文化的正式形成。',84,NULL,0,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (191,7,NULL,'陆羽与《茶经》：陆羽被尊为\"茶圣\"，《茶经》共三卷十节，系统论述茶的起源、采制工具、制茶方法、煮茶器具、煮茶方法、饮茶方式、茶事史料、茶叶产区与茶具省略等，是世界茶学开山之作。书中提出\"茶之为饮，发乎神农氏，闻于鲁周公\"。',84,NULL,1,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (192,7,NULL,'唐代煎茶法：将茶饼碾成末，水沸后先加盐调味，再投入茶末，用竹夹搅动，待\"沫饽\"（茶汤表面浮沫）生成后分盛饮用。讲究\"三沸\"——一沸如鱼目、二沸如涌泉连珠、三沸如腾波鼓浪，认为三沸之后水老不可食。',78,NULL,2,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (193,7,NULL,'宋代点茶法与斗茶：将茶末置于盏中，注入少量沸水调成膏状，再用茶筅击拂（快速搅拌）使茶汤表面形成细腻持久的白色沫饽，以\"咬盏\"（沫饽紧贴盏壁不散）为佳。斗茶比较沫饽的颜色与持久度，是宋代文人的流行雅事，后传入日本演变为抹茶道。',92,NULL,3,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (194,7,NULL,'明清泡茶法的确立：明太祖朱元璋于洪武二十四年（1391 年）\"罢造龙团，惟采芽茶以进\"，废除饼茶进贡、改贡散茶，使饮茶方式从碾末煮饮转向沸水冲泡散茶。这一变革奠定了现代泡茶法的基础，也促进了紫砂壶与盖碗的兴起。',82,NULL,4,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (195,7,NULL,'中国茶文化的四大流派：①文人茶——重精神意境，讲究\"精行俭德\"；②宫廷茶——重礼仪排场，如宋代贡茶与清代三清茶宴；③宗教茶——禅宗\"茶禅一味\"、道家\"天人合一\"；④民间茶——重实用与社交，如潮汕工夫茶、成都盖碗茶、北京大碗茶。',88,NULL,5,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (196,7,NULL,'\"茶禅一味\"的含义：源于宋代禅宗，指茶道与禅修在精神上的相通——茶的清苦、回甘与静心品饮的过程，契合禅宗\"明心见性\"的修行方式。唐代赵州从谂禅师\"吃茶去\"的公案，成为禅茶文化的经典表达。日本茶道（千利休\"和敬清寂\"）亦源于此。',88,NULL,6,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (197,7,NULL,'茶马古道：起于唐宋、盛于明清，以云南、四川为起点，经青藏高原至印度、尼泊尔，用茶叶交换马匹的贸易通道。因藏区以肉食为主、需茶助消化，而内地需马匹，形成\"茶马互市\"。这条古道促进了民族交流与茶文化传播，也是黑茶（砖茶）压制成型的动因之一。',92,NULL,7,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (198,7,NULL,'海上茶路与茶传世界：中国茶在唐宋时期传入日本、朝鲜；17 世纪经荷兰东印度公司传入欧洲，1657 年伦敦出现首家茶馆。英国因茶叶贸易逆差发动鸦片战争，并在印度阿萨姆、锡兰（斯里兰卡）开辟茶园。如今茶是世界三大无酒精饮料之一。',90,NULL,8,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (199,7,NULL,'潮汕工夫茶：流行于广东潮汕地区，是中国茶道的代表流派之一。特点：①器具精巧——\"四宝\"为玉书碨（烧水壶）、潮汕炉（风炉）、孟臣罐（紫砂小壶）、若琛瓯（小茶杯）；②高冲低斟、刮沫淋盖、关公巡城、韩信点兵；③选用凤凰单丛，小壶小杯、浓香耐泡。',92,NULL,9,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (200,7,NULL,'潮汕工夫茶\"关公巡城\"与\"韩信点兵\"：前者指分茶时按顺序循环向各杯注汤，使每杯茶汤浓淡一致（如关公巡视城池）；后者指最后将壶中残余茶汤逐滴均匀分配至各杯（如韩信点兵，多多益善），确保每杯茶汤分量与浓度均衡。',84,NULL,10,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (201,7,NULL,'成都盖碗茶：流行于四川成都，以盖碗冲泡，配竹椅、方桌与茶馆文化。盖碗由茶盖、茶碗、茶托组成，寓意\"天、地、人\"三才。成都茶馆兼具饮茶、社交、听书、掏耳朵等功能，是市井文化的代表。',76,NULL,11,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (202,7,NULL,'日本茶道（茶之汤）：由宋代点茶法传入后发展而成，集大成者千利休提出\"和敬清寂\"四字精神。以抹茶为主，仪式严谨（含怀石料理、炭点前、浓茶、薄茶等程序），强调\"一期一会\"——每次相聚都独一无二，应当珍惜。',82,NULL,12,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (203,7,NULL,'英式下午茶：源于 19 世纪英国贝德福德公爵夫人安娜，因午餐与晚餐间隔过长而在下午 4-5 点加餐，逐渐演变为社交风尚。分 Low Tea（矮桌，以茶与点心为主）与 High Tea（高桌，含肉食，实为工人阶级晚餐）。传统饮用祁门、大吉岭、阿萨姆等红茶，加奶或柠檬。',96,NULL,13,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (204,7,NULL,'中国四大茶区：①江南茶区（长江中下游，产绿茶、黄茶、黑茶，如龙井、碧螺春、黄山毛峰）；②江北茶区（长江以北，产绿茶，如信阳毛尖）；③西南茶区（云贵川，产红茶、黑茶、普洱，茶树资源最丰富）；④华南茶区（闽粤桂台，产乌龙茶、红茶、白茶，如铁观音、大红袍、白毫银针）。',98,NULL,14,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (205,8,NULL,'茶叶的主要功能成分：①茶多酚（占干重 18-36%）——抗氧化、清除自由基；②咖啡碱（2-5%）——提神、促进代谢；③茶氨酸（1-2%）——放松神经、改善注意力；④茶多糖——调节血糖；⑤维生素 C、E 与矿物质（钾、氟、锰）。这些成分共同构成茶的保健基础。',90,NULL,0,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (206,8,NULL,'茶多酚的抗氧化作用：茶多酚中的儿茶素类（尤其是 EGCG）具有强抗氧化活性，能清除自由基、抑制脂质过氧化、螯合金属离子。体外与动物实验显示其对心血管、代谢与肿瘤有一定保护作用。但需注意：人体临床试验证据尚不充分，不可替代药物治疗。',92,NULL,1,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (207,8,NULL,'咖啡碱的提神机理与含量差异：咖啡碱通过阻断腺苷受体（腺苷是促进睡眠的神经递质）来提升警觉性。含量受茶类与冲泡影响：红茶与普洱熟茶（发酵后咖啡碱与茶黄素络合）刺激性较低；绿茶与新白茶咖啡碱析出较快。冷泡可显著降低咖啡碱析出量。',88,NULL,2,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (208,8,NULL,'茶氨酸的独特作用：茶氨酸是茶叶特有的游离氨基酸，能通过血脑屏障，促进 α 脑波产生（与放松而清醒的状态相关），并可拮抗咖啡碱的过度兴奋。这就是\"喝茶提神却不亢奋\"的原因——咖啡碱与茶氨酸的协同，形成茶特有的\"清醒的平静\"。',86,NULL,3,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (209,8,NULL,'不同茶类的咖啡因含量参考（每 200 毫升，约 2-3 克干茶）：绿茶约 20-45 毫克；红茶约 40-70 毫克；乌龙茶约 30-50 毫克；白茶（新）约 15-30 毫克；普洱熟茶约 30-50 毫克。对比：一杯咖啡（200 毫升）约 80-120 毫克。茶因需冲泡析出，通常低于同体积咖啡。',98,NULL,4,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (210,8,NULL,'饮茶的适宜时间与禁忌：①不宜空腹饮浓茶——刺激胃酸分泌，易致胃部不适；②不宜睡前 3 小时饮浓茶——影响入睡；③不宜用茶送服药物——鞣酸与生物碱可能与药物结合影响吸收（尤其铁剂、镇静剂、部分抗生素）；④不宜饮隔夜茶与过浓茶。',84,NULL,5,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (211,8,NULL,'哪些人群应限制饮茶：①孕妇与哺乳期女性——咖啡因可通过胎盘与乳汁，建议每日咖啡因摄入低于 200 毫克并选淡茶；②缺铁性贫血者——鞣酸抑制非血红素铁吸收，应餐后 1 小时再饮；③严重失眠与焦虑者——减少咖啡因摄入；④胃溃疡与胃食管反流者——避免浓茶与空腹饮茶。',92,NULL,6,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (212,8,NULL,'茶叶与铁吸收的关系：茶中的鞣酸（单宁）会与非血红素铁（植物性铁源，如菠菜、豆类）结合形成不溶性复合物，抑制其吸收。但对血红素铁（肉类中的铁）影响较小。建议：贫血者服药或进食富铁食物前后 1 小时内避免饮茶，且可选发酵度高的红茶（鞣酸相对较低）。',92,NULL,7,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (213,8,NULL,'喝茶减肥的科学依据与局限：茶多酚与咖啡碱可协同促进脂肪氧化、提高基础代谢率（有研究显示可提升 3-4%），但对体重的长期影响有限，且需配合饮食控制与运动。市售\"减肥茶\"多含泻药成分（如番泻叶），通过脱水造成体重下降的假象，不宜长期饮用。',90,NULL,8,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (214,8,NULL,'氟与牙齿健康：茶叶是天然富氟植物，尤其老叶与砖茶含氟量高（可达 100-300 mg/kg）。适量氟可增强牙釉质抗酸能力、预防龋齿；但长期大量饮用高氟砖茶（如某些边茶）可能导致氟斑牙甚至氟骨症。建议避免长期以浓砖茶为日常主要饮品。',90,NULL,9,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (215,8,NULL,'隔夜茶能不能喝：隔夜茶的主要问题是①微生物繁殖（尤其未加盖、夏季高温）；②营养成分氧化（维生素 C 损失、茶多酚氧化导致汤色变深）；③口感变差。若隔夜茶密封冷藏、无浑浊异味，加热后饮用一般无健康风险，但不推荐——营养与风味已明显下降。',90,NULL,10,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (216,8,NULL,'不同体质如何选茶（中医视角）：①阳虚/虚寒体质——手脚冰凉、怕冷，宜温性茶（红茶、熟普、重焙火乌龙）；②阴虚/燥热体质——易口干、便秘，宜凉性茶（绿茶、新白茶、黄茶）；③痰湿体质——肥胖、舌苔厚腻，宜黑茶、普洱熟茶助消化；④气郁体质——宜花茶（茉莉花茶、玫瑰花茶）疏肝解郁。',100,NULL,11,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (217,8,NULL,'花草茶与茶叶的区别：花草茶（如玫瑰花茶、菊花茶、洛神花茶）严格说不属于\"茶\"（非茶树 Camellia sinensis 的叶），而是代用茶或草本饮品。它们通常不含咖啡因，功效侧重特定作用（菊花清肝明目、玫瑰疏肝解郁、洛神花降血压），适合晚间或对咖啡因敏感人群。',92,NULL,12,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (218,8,NULL,'茶叶的农残与安全：正规渠道的茶叶应符合 GB 2763 农残限量标准。降低风险的做法：①选购有检测报告的品牌茶；②首泡快速倒掉（可去除部分表面残留，但脂溶性农药效果有限）；③优先选择春茶（春季气温低、虫害少、用药少）。需注意：茶汤中农残的实际浸出率通常远低于干茶含量。',98,NULL,13,NULL,'2026-10-07 17:33:13');
INSERT INTO `kb_chunk` VALUES (219,8,NULL,'茶与药膳的常见搭配：①陈皮普洱——理气健脾、助消化；②菊花枸杞茶——清肝明目；③姜茶（红茶 + 生姜）——驱寒暖胃；④桂花乌龙——温中散寒、化痰；⑤薄荷绿茶——清热解暑。注意药膳茶属日常保健范畴，不能替代药物治疗，慢性病患者应咨询医师。',92,NULL,14,NULL,'2026-10-07 17:33:13');
/*!40000 ALTER TABLE `kb_chunk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kb_document`
--

DROP TABLE IF EXISTS `kb_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kb_document` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '文档标题',
  `source_type` varchar(20) NOT NULL COMMENT '来源类型 xlsx/docx/pdf/image/manual',
  `source_path` varchar(500) DEFAULT NULL COMMENT '原始文件路径',
  `chunk_count` int DEFAULT '0' COMMENT '切分出的知识块数',
  `status` varchar(20) DEFAULT 'pending' COMMENT 'pending/parsed/embedded/failed',
  `error_msg` varchar(500) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_source_type` (`source_type`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='知识库文档表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kb_document`
--

LOCK TABLES `kb_document` WRITE;
/*!40000 ALTER TABLE `kb_document` DISABLE KEYS */;
INSERT INTO `kb_document` VALUES (1,'茶叶基础知识手册','xlsx',NULL,4,'embedded',NULL,'2026-10-03 23:03:12','2026-10-23 12:51:41');
INSERT INTO `kb_document` VALUES (2,'茶具与冲泡工艺','docx',NULL,2,'embedded',NULL,'2026-10-03 23:03:12','2026-10-23 12:51:41');
INSERT INTO `kb_document` VALUES (3,'六大茶类详解','manual',NULL,30,'embedded',NULL,'2026-10-07 17:33:13','2026-10-23 12:51:41');
INSERT INTO `kb_document` VALUES (4,'冲泡技艺与品鉴','manual',NULL,25,'embedded',NULL,'2026-10-07 17:33:13','2026-10-23 12:51:41');
INSERT INTO `kb_document` VALUES (5,'茶叶选购与储存','manual',NULL,20,'embedded',NULL,'2026-10-07 17:33:13','2026-10-23 12:51:41');
INSERT INTO `kb_document` VALUES (6,'茶器与养护','manual',NULL,15,'embedded',NULL,'2026-10-07 17:33:13','2026-10-23 12:51:41');
INSERT INTO `kb_document` VALUES (7,'茶文化与历史','manual',NULL,15,'embedded',NULL,'2026-10-07 17:33:13','2026-10-23 12:51:41');
INSERT INTO `kb_document` VALUES (8,'茶与健康','manual',NULL,15,'embedded',NULL,'2026-10-07 17:33:13','2026-10-23 13:57:08');
/*!40000 ALTER TABLE `kb_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vector_benchmark`
--

DROP TABLE IF EXISTS `vector_benchmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vector_benchmark` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `backend` varchar(16) NOT NULL COMMENT 'qdrant / milvus',
  `index_type` varchar(32) DEFAULT NULL COMMENT 'HNSW / IVF_FLAT',
  `dimension` int DEFAULT NULL,
  `point_count` int DEFAULT NULL,
  `top_k` int DEFAULT NULL,
  `recall_at_k` decimal(5,4) DEFAULT NULL,
  `p50_latency_ms` int DEFAULT NULL,
  `p99_latency_ms` int DEFAULT NULL,
  `memory_mb` int DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_backend` (`backend`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='向量库选型对比基准';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vector_benchmark`
--

LOCK TABLES `vector_benchmark` WRITE;
/*!40000 ALTER TABLE `vector_benchmark` DISABLE KEYS */;
INSERT INTO `vector_benchmark` VALUES (17,'bm25_only','retrieval-strategy',1024,126,5,0.7523,NULL,NULL,NULL,'RAG 检索策略对照（hit-rate 口径），评测集 109 条','2026-10-07 18:24:23');
INSERT INTO `vector_benchmark` VALUES (18,'vector_only','retrieval-strategy',1024,126,5,0.9633,NULL,NULL,NULL,'RAG 检索策略对照（hit-rate 口径），评测集 109 条','2026-10-07 18:24:23');
INSERT INTO `vector_benchmark` VALUES (19,'hybrid_rrf_only','retrieval-strategy',1024,126,5,0.9266,NULL,NULL,NULL,'RAG 检索策略对照（hit-rate 口径），评测集 109 条','2026-10-07 18:24:23');
INSERT INTO `vector_benchmark` VALUES (20,'hybrid','retrieval-strategy',1024,126,5,0.9633,NULL,NULL,NULL,'RAG 检索策略对照（hit-rate 口径），评测集 109 条','2026-10-07 18:24:23');
/*!40000 ALTER TABLE `vector_benchmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_agent'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-24 18:49:50
