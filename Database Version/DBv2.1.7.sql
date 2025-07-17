CREATE DATABASE  IF NOT EXISTS `fuhousefinder_homestay` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `fuhousefinder_homestay`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: fuhousefinder_homestay
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `country` varchar(256) NOT NULL,
  `province` varchar(256) NOT NULL,
  `district` varchar(256) NOT NULL,
  `ward` varchar(256) NOT NULL,
  `detail` varchar(512) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(36) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_address_created_by` (`created_by`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'Việt Nam','Hà Nội','Hà Đông','Văn Quán',NULL,'2025-06-17 04:48:51','U-87fbb6d15ad548318110b60b797f84da',NULL),(2,'Việt Nam','Tỉnh Cao Bằng','Huyện Quảng Hòa','Xã Tự Do','teste','2025-06-24 04:56:29','U-87fbb6d15ad548318110b60b797f84da',NULL),(3,'Việt Nam','Tỉnh Bến Tre','Huyện Chợ Lách','Xã Long Thới','Test 2','2025-06-27 08:04:09','U-87fbb6d15ad548318110b60b797f84da',NULL),(4,'Việt Nam','Tỉnh Bình Dương','Thị xã Bến Cát','Xã An Điền','123','2025-06-27 08:08:42','U-87fbb6d15ad548318110b60b797f84da',NULL),(5,'Việt Nam','Tỉnh Bình Dương','Thị xã Bến Cát','Xã An Điền','123','2025-06-27 08:10:32','U-87fbb6d15ad548318110b60b797f84da',NULL),(6,'Việt Nam','Tỉnh Bình Định','Huyện Hoài Ân','Xã Ân Hữu','123123','2025-06-28 02:53:07','U-87fbb6d15ad548318110b60b797f84da',NULL),(7,'Việt Nam','Tỉnh Gia Lai','Huyện Phú Thiện','Xã Ia Hiao','Yêu 5','2025-06-28 03:29:22','U-87fbb6d15ad548318110b60b797f84da','2025-06-28 23:48:05'),(8,'Việt Nam','Tỉnh Bến Tre','Huyện Châu Thành','Xã Sơn Hòa',' Test Update','2025-06-28 04:21:16','U-87fbb6d15ad548318110b60b797f84da','2025-07-02 15:09:12'),(9,'Việt Nam','Tỉnh Cao Bằng','Huyện Bảo Lâm','Xã Nam Cao','Test 5','2025-07-02 14:26:28','U-87fbb6d15ad548318110b60b797f84da',NULL),(10,'Việt Nam','Tỉnh An Giang','Huyện Châu Phú','Xã Bình Mỹ','','2025-07-02 14:57:54','U-87fbb6d15ad548318110b60b797f84da',NULL),(11,'Việt Nam','Tỉnh Bắc Kạn','Huyện Chợ Đồn','Xã Bình Trung','','2025-07-02 15:01:17','U-87fbb6d15ad548318110b60b797f84da',NULL),(12,'Việt Nam','Tỉnh Bắc Kạn','Huyện Chợ Đồn','Xã Bình Trung','','2025-07-02 15:01:58','U-87fbb6d15ad548318110b60b797f84da',NULL),(13,'Việt Nam','Tỉnh Bắc Kạn','Huyện Bạch Thông','Xã Cao Sơn','Test 6','2025-07-02 15:02:59','U-87fbb6d15ad548318110b60b797f84da',NULL),(14,'Việt Nam','Tỉnh Gia Lai','Huyện Đăk Pơ','Xã Hà Tam','','2025-07-03 17:21:26','U-bc094ab05844450190f60b3fa20211c6',NULL),(15,'Việt Nam','Tỉnh Hà Giang','Huyện Vị Xuyên','Xã Phú Linh','','2025-07-03 17:49:46','U-bc094ab05844450190f60b3fa20211c6',NULL),(16,'Việt Nam','Tỉnh An Giang','Huyện Châu Phú','Xã Bình Mỹ','','2025-07-03 17:50:56','U-bc094ab05844450190f60b3fa20211c6',NULL),(17,'Việt Nam','Tỉnh Bình Dương','Huyện Phú Giáo','Xã Phước Hoà','','2025-07-03 17:51:44','U-bc094ab05844450190f60b3fa20211c6',NULL),(18,'Việt Nam','Thành phố Cần Thơ','Quận Cái Răng','Phường Hưng Thạnh','','2025-07-03 17:52:19','U-87fbb6d15ad548318110b60b797f84da',NULL),(19,'Việt Nam','Thành phố Cần Thơ','Huyện Thới Lai','Xã Trường Xuân B','','2025-07-03 17:53:01','U-87fbb6d15ad548318110b60b797f84da',NULL),(20,'Việt Nam','Thành phố Cần Thơ','Quận Ninh Kiều','Phường Cái Khế','','2025-07-03 17:54:51','U-87fbb6d15ad548318110b60b797f84da',NULL),(21,'Việt Nam','Tỉnh Bình Thuận','Thành phố Phan Thiết','Phường Phú Thủy','','2025-07-03 17:57:04','U-87fbb6d15ad548318110b60b797f84da',NULL);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `id` varchar(36) NOT NULL,
  `tenant_id` varchar(36) NOT NULL,
  `homestay_id` varchar(36) NOT NULL,
  `room_id` varchar(36) DEFAULT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `total_price` double NOT NULL,
  `deposit` double DEFAULT NULL,
  `service_fee` double NOT NULL,
  `cleaning_fee` double NOT NULL,
  `status_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `note` text,
  PRIMARY KEY (`id`),
  KEY `idx_booking_tenant` (`tenant_id`),
  KEY `idx_booking_homestay` (`homestay_id`),
  KEY `idx_booking_room` (`room_id`),
  KEY `idx_booking_status` (`status_id`),
  CONSTRAINT `booking_fk_homestay` FOREIGN KEY (`homestay_id`) REFERENCES `homestay` (`id`),
  CONSTRAINT `booking_fk_room` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`),
  CONSTRAINT `booking_fk_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`),
  CONSTRAINT `booking_fk_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES ('BOOK-0874288ac2f742c2bbf8830738c3beb','U-ab0c71c0b2fa412ea760eeb459dfab6e','HOUSE-59d99761bde341f8928003e50e66a5',NULL,'2025-08-07','2025-09-05',255400000,51080000,23200000,200000,34,'2025-07-11 14:34:31',NULL,''),('BOOK-0eec5202b22f4a1a8e812cfff5ce013','U-ab0c71c0b2fa412ea760eeb459dfab6e','HOUSE-a168118c1d6242969e012b9ee7b4f8',NULL,'2025-07-10','2025-07-12',22200000,4440000,2000000,200000,10,'2025-07-10 13:18:20',NULL,''),('BOOK-500ac89f05504c70b9cc76715db85f3','U-ab0c71c0b2fa412ea760eeb459dfab6e','HOUSE-a168118c1d6242969e012b9ee7b4f8',NULL,'2026-01-12','2026-01-14',22200000,4440000,2000000,200000,34,'2025-07-12 15:19:04',NULL,''),('BOOK-90630385ed534b598757e85862b976a','U-ab0c71c0b2fa412ea760eeb459dfab6e','HOUSE-a168118c1d6242969e012b9ee7b4f8',NULL,'2026-07-12','2026-07-15',33200000,6640000,3000000,200000,10,'2025-07-12 15:21:02',NULL,''),('BOOK-9227e1b9f74d48f4aa04aae543b1893','U-ab0c71c0b2fa412ea760eeb459dfab6e','HOUSE-59d99761bde341f8928003e50e66a5',NULL,'2025-07-10','2025-07-19',79400000,15880000,7200000,200000,9,'2025-07-10 13:21:20',NULL,''),('BOOK-b23696adcdcd4a2c849e1391da635eb','U-ab0c71c0b2fa412ea760eeb459dfab6e','HOUSE-a168118c1d6242969e012b9ee7b4f8',NULL,'2027-01-01','2027-01-03',22200000,4440000,2000000,200000,34,'2025-07-12 15:17:25',NULL,''),('BOOK-b3b9d99f40e3430f95d69f0ef17401b','U-ab0c71c0b2fa412ea760eeb459dfab6e','HOUSE-2917ed6ad5804a6da4651f7d24f9ab','ROOM-ffc00fb0725a46b5ae3a43e0c75cf63','2025-07-11','2025-07-18',23150000,4630000,2100000,50000,34,'2025-07-11 15:02:39',NULL,'');
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `post_id` varchar(36) NOT NULL,
  `parent_comment_id` varchar(36) DEFAULT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_comment_user` (`user_id`),
  KEY `idx_comment_post` (`post_id`),
  KEY `idx_comment_parent` (`parent_comment_id`),
  CONSTRAINT `comment_fk_parent` FOREIGN KEY (`parent_comment_id`) REFERENCES `comment` (`id`),
  CONSTRAINT `comment_fk_post` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`),
  CONSTRAINT `comment_fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES ('COMMENT-513f910622514a55af2bd5843f7e','U-ab0c71c0b2fa412ea760eeb459dfab6e','POST-ea032857dff943cbbba17a744360514',NULL,'test','2025-07-17 04:37:29',NULL,NULL),('COMMENT-a8c84090c0aa4a5e9b6d12d2706d','U-87fbb6d15ad548318110b60b797f84da','POST-033c11e4574e4e7e9a9b6a2d6f0f813',NULL,'asdf','2025-07-16 14:28:09','2025-07-16 14:32:10','2025-07-16 14:32:10'),('COMMENT-d52117da1d254d0f993744e793fa','U-ab0c71c0b2fa412ea760eeb459dfab6e','POST-687d5728c5f44fbfa4c2ad0ea6a500b',NULL,'test','2025-07-17 04:37:45',NULL,NULL),('COMMENT-e2be493046bb4dfa9a164900bec7','U-87fbb6d15ad548318110b60b797f84da','POST-cc38ec0c29c545afae940200d7eede5',NULL,'Nha dep','2025-07-16 14:35:09',NULL,NULL),('COMMENT-ecb12aba02ee484098f4e16b50db','U-ab0c71c0b2fa412ea760eeb459dfab6e','POST-033c11e4574e4e7e9a9b6a2d6f0f813',NULL,'Help me sos','2025-07-03 18:42:34',NULL,NULL);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract`
--

DROP TABLE IF EXISTS `contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contract` (
  `id` varchar(150) NOT NULL,
  `filename` varchar(150) NOT NULL,
  `file_path` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `bookId` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `filename_UNIQUE` (`filename`),
  UNIQUE KEY `bookId_UNIQUE` (`bookId`),
  KEY `contract_book_fk1_idx` (`bookId`),
  CONSTRAINT `contract_book_fk1` FOREIGN KEY (`bookId`) REFERENCES `booking` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract`
--

LOCK TABLES `contract` WRITE;
/*!40000 ALTER TABLE `contract` DISABLE KEYS */;
INSERT INTO `contract` VALUES ('Contract_BK-BOOK-0874288ac2f742c2bbf8830738c3beb','Contract_BK-BOOK-0874288ac2f742c2bbf8830738c3beb.pdf','Asset/Contract/Contract_BK-BOOK-0874288ac2f742c2bbf8830738c3beb.pdf','2025-07-11 14:44:39','BOOK-0874288ac2f742c2bbf8830738c3beb'),('Contract_BK-BOOK-90630385ed534b598757e85862b976a','Contract_BK-BOOK-90630385ed534b598757e85862b976a.pdf','Asset/Contract/Contract_BK-BOOK-90630385ed534b598757e85862b976a.pdf','2025-07-12 16:03:35','BOOK-90630385ed534b598757e85862b976a');
/*!40000 ALTER TABLE `contract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `id` varchar(36) NOT NULL,
  `title` varchar(256) NOT NULL,
  `description` text,
  `host_user_id` varchar(36) NOT NULL,
  `homestay_id` varchar(36) DEFAULT NULL,
  `location` varchar(512) DEFAULT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `status_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_event_host` (`host_user_id`),
  KEY `idx_event_homestay` (`homestay_id`),
  KEY `idx_event_status` (`status_id`),
  CONSTRAINT `event_fk_homestay` FOREIGN KEY (`homestay_id`) REFERENCES `homestay` (`id`),
  CONSTRAINT `event_fk_host` FOREIGN KEY (`host_user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `event_fk_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_participant`
--

DROP TABLE IF EXISTS `event_participant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_participant` (
  `id` varchar(36) NOT NULL,
  `event_id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `status` varchar(50) DEFAULT 'pending',
  `joined_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_event_participant` (`event_id`,`user_id`),
  KEY `idx_ep_event` (`event_id`),
  KEY `idx_ep_user` (`user_id`),
  CONSTRAINT `ep_fk_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`),
  CONSTRAINT `ep_fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_participant`
--

LOCK TABLES `event_participant` WRITE;
/*!40000 ALTER TABLE `event_participant` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_participant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feature`
--

DROP TABLE IF EXISTS `feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feature` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `path` varchar(100) NOT NULL,
  `category` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_feature_name` (`name`),
  UNIQUE KEY `ux_feature_path` (`path`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature`
--

LOCK TABLES `feature` WRITE;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` VALUES (1,'View Homepage','/feeds',''),(2,'View Feedback House','/feedback/house',''),(3,'View Feedback Room','/feedback/house-room',''),(4,'View User Profile','/profile',''),(5,'View Owner House','/owner-house',''),(6,'Change Password','/change-password',''),(7,'Send OTP','/send-otp',''),(8,'View Verify OTP Page','/get-verify-otp',''),(9,'Do Verify OTP','/verify-otp',''),(10,'Search','/search',''),(11,'Get Image','/image',''),(12,'Change Avatar','/change-avatar',''),(13,'Change Cover','/change-cover',''),(14,'Get Comments','/comment',''),(15,'New post','/post',''),(16,'Get All Homestay For Owner','/homestay/get',''),(17,'Get All Room for Homestay','/homestay/room/get',''),(18,'Add New House','/owner-house/add',''),(19,'Edit House','/owner-house/edit',''),(20,'Detail House','/owner-house/detail',''),(21,'Add New Room','/room/add',''),(22,'Edit Room','/room/edit',''),(23,'Delete Room','/room/delete',''),(24,'Detail Room','/room',''),(25,'Edit Profile','/profile-edit',''),(26,'View List Available House','/house/available',''),(27,'View List Available Room','/house/room/available',''),(28,'Admin List User','/manage/user',''),(29,'Admin Add User','/manage/user/add',''),(30,'Admin Edit User','/manage/user/edit',''),(31,'Admin View Detail User','/manage/user/detail',''),(32,'Admin Delete User','/manage/user/delete',''),(33,'View Reviews','/review',''),(34,'Send Review','/review/add',''),(35,'Update Review','/review/update',''),(36,'Delete Review','/review/delete',''),(37,'View Booking Page','/booking',''),(38,'Get Avalable Room API','/homestay/room/available',''),(39,'Get Room Detail API','/homestay/room',''),(40,'View Booking Contract','/booking/contract',''),(41,'Confirm Booking','/booking/confirm',''),(42,'View Booking History','/booking/history',''),(43,'View Preview Contract and Download','/booking/contract/preview',''),(44,'View Booking Detail','/booking/detail',''),(45,'Do Payment','/payment',''),(46,'Generate Contract','/contract/generate',''),(47,'View Booking List (Homestay Owner, Admin)','/manage/booking',''),(48,'View Booking Detail (Homestay Owner, Admin)','/manage/booking/detail',''),(49,'View Post Management Page','/manage/post',''),(50,'View Post Detail Management Page','/manage/post/update',''),(51,'Update Post Manage','/manage/post/detail',''),(52,'View Post Control','/manage/post/control',''),(53,'Load More Feeds','/loadmorefeeds',''),(54,'Load More Post Profile','/loadmorepostprofile',''),(55,'View All Reviews','/manage/reviews',''),(56,'View Review Detail','/manage/reviews/detail',''),(57,'Update review Status','/manage/reviews/update',''),(58,'View Post Request','/post-request',''),(59,'Edit Post','/post-request/update',''),(60,'View Post Detail','/post-request/detail',''),(61,'View Authorization List','/manage/authorization',NULL),(62,'Edit Authorization','/manage/authorization/edit',NULL),(63,'Add Authorization','/manage/authorization/add',NULL),(64,'View Payment History','/payment/history',NULL),(65,'View Payment Detail','/payment/detail',NULL),(66,'Update Payment','/payment/update',NULL);
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `homestay`
--

DROP TABLE IF EXISTS `homestay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `homestay` (
  `id` varchar(36) NOT NULL,
  `name` varchar(258) NOT NULL,
  `description` text NOT NULL,
  `star` float NOT NULL DEFAULT '0',
  `is_whole_house` tinyint NOT NULL DEFAULT '1',
  `price_per_night` double NOT NULL,
  `owner_id` varchar(36) NOT NULL,
  `status_id` int NOT NULL,
  `address_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_homestay_owner` (`owner_id`),
  KEY `idx_homestay_status` (`status_id`),
  KEY `idx_homestay_address` (`address_id`),
  CONSTRAINT `homestay_fk_address` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `homestay_fk_owner` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`),
  CONSTRAINT `homestay_fk_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `homestay`
--

LOCK TABLES `homestay` WRITE;
/*!40000 ALTER TABLE `homestay` DISABLE KEYS */;
INSERT INTO `homestay` VALUES ('HOUSE-1a8f3eccaf5941a5914e7e29b7f8be','Casa Bloom','Bright and airy with a lush garden view, this homestay is designed for rest, creativity, and blooming new memories.',0,0,0,'U-bc094ab05844450190f60b3fa20211c6',6,15,'2025-07-03 17:49:46',NULL),('HOUSE-2917ed6ad5804a6da4651f7d24f9ab','The Nest Hideaway','A peaceful little retreat tucked away in nature—perfect for slow mornings, warm drinks, and starry nights.',0,0,0,'U-bc094ab05844450190f60b3fa20211c6',6,14,'2025-07-03 17:21:26',NULL),('HOUSE-45f6b3c2263e4cc9a847be1a1658bc','Golden Hour Retreat','Floor-to-ceiling windows capture the golden glow of every sunrise and sunset. A stay filled with warmth and light.',0,1,7000000,'U-87fbb6d15ad548318110b60b797f84da',6,18,'2025-07-03 17:52:19',NULL),('HOUSE-4d7165cb29cd473a8fad7620270127','Maple & Stone Cabin','Wooden beams, stone walls, and a fireplace—this forest-side cabin is the ultimate escape for cozy getaways.',0,1,6000000,'U-87fbb6d15ad548318110b60b797f84da',6,19,'2025-07-03 17:53:01',NULL),('HOUSE-59d99761bde341f8928003e50e66a5','Driftwood Dreams','Inspired by the coast, this beachy homestay offers breezy interiors, soft linens, and the sound of waves nearby.',0,1,8000000,'U-bc094ab05844450190f60b3fa20211c6',36,16,'2025-07-03 17:50:56',NULL),('HOUSE-703257033dcf4ea1a3a9e2b965d105','Azure Sky Loft','A modern city-view loft with dreamy blue tones and airy vibes. Ideal for urban explorers and digital nomads.',0,1,12000000,'U-87fbb6d15ad548318110b60b797f84da',6,20,'2025-07-03 17:54:51',NULL),('HOUSE-8868c75074d14d829602ad57208712','Luna & Leaf Cottage','A cozy, plant-filled home that blends rustic charm with boho elegance. Great for nature lovers and quiet thinkers.',0,0,0,'U-87fbb6d15ad548318110b60b797f84da',6,21,'2025-07-03 17:57:04',NULL),('HOUSE-a168118c1d6242969e012b9ee7b4f8','The Wabi-Sabi Nook','Minimalist and soulful—this Japanese-inspired homestay invites simplicity, stillness, and mindful living.',0,1,10000000,'U-bc094ab05844450190f60b3fa20211c6',36,17,'2025-07-03 17:51:44',NULL);
/*!40000 ALTER TABLE `homestay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `like_post`
--

DROP TABLE IF EXISTS `like_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `like_post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(36) NOT NULL,
  `post_id` varchar(36) NOT NULL,
  `is_like` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_like_user_post` (`user_id`,`post_id`),
  KEY `idx_like_user` (`user_id`),
  KEY `idx_like_post` (`post_id`),
  CONSTRAINT `like_post_fk_post` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`),
  CONSTRAINT `like_post_fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `like_post`
--

LOCK TABLES `like_post` WRITE;
/*!40000 ALTER TABLE `like_post` DISABLE KEYS */;
INSERT INTO `like_post` VALUES (8,'U-bc094ab05844450190f60b3fa20211c6','POST-316b32fa91874fa2b68010a349a28c3',1,'2025-07-03 18:13:07',NULL),(9,'U-c9e2596cc51d448fb337abd55ec77494','POST-d5579bafbfb546cd943b11f29fffd5b',1,'2025-07-16 01:04:24',NULL),(10,'U-87fbb6d15ad548318110b60b797f84da','POST-7684298f20b6430894382e89841a83c',1,'2025-07-16 13:52:23',NULL),(11,'U-ab0c71c0b2fa412ea760eeb459dfab6e','POST-ea032857dff943cbbba17a744360514',1,'2025-07-17 04:37:24',NULL),(12,'U-ab0c71c0b2fa412ea760eeb459dfab6e','POST-687d5728c5f44fbfa4c2ad0ea6a500b',1,'2025-07-17 04:37:38',NULL);
/*!40000 ALTER TABLE `like_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `id` varchar(36) NOT NULL,
  `object_type` varchar(50) NOT NULL,
  `object_id` varchar(36) NOT NULL,
  `media_type` varchar(50) NOT NULL,
  `path` text NOT NULL,
  `status_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(36) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_media_object` (`object_type`,`object_id`),
  KEY `idx_media_status` (`status_id`),
  KEY `idx_media_created_by` (`created_by`),
  CONSTRAINT `media_fk_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`),
  CONSTRAINT `media_fk_user` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES ('MEDIA-05522de97d934d4591bf98465817ec','Homestay','HOUSE-1a8f3eccaf5941a5914e7e29b7f8be','image','MEDIA-05522de97d934d4591bf98465817ec',21,'2025-07-03 17:49:46','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-06d1f23697294baa9d787ba2e9352f','Homestay','HOUSE-45f6b3c2263e4cc9a847be1a1658bc','image','MEDIA-06d1f23697294baa9d787ba2e9352f',21,'2025-07-03 17:52:19','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-09b0935c678745e88387e29b7940c7','Homestay','HOUSE-45f6b3c2263e4cc9a847be1a1658bc','image','MEDIA-09b0935c678745e88387e29b7940c7',21,'2025-07-03 17:52:19','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-0bf58e7e1c6d4fe295ba1481fd07aa','Room','ROOM-cab35c55c4614596a0fc6786bd06171','image','MEDIA-0bf58e7e1c6d4fe295ba1481fd07aa',21,'2025-07-03 17:57:04','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-10cb7b2d48c842119a47d4f0ef8fae','Homestay','HOUSE-703257033dcf4ea1a3a9e2b965d105','image','MEDIA-10cb7b2d48c842119a47d4f0ef8fae',21,'2025-07-03 17:54:51','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-142ce37058ef4028907d7a72dd43e1','Homestay','HOUSE-59d99761bde341f8928003e50e66a5','image','MEDIA-142ce37058ef4028907d7a72dd43e1',21,'2025-07-03 17:50:56','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-16e34949605d4d2fb6cf5e2f9bd029','Homestay','HOUSE-1a8f3eccaf5941a5914e7e29b7f8be','image','MEDIA-16e34949605d4d2fb6cf5e2f9bd029',21,'2025-07-03 17:49:46','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-18e5be01b241494b97bf3ce78373f8','Room','ROOM-d885ec4f801c499aa7ec2e9482aaf80','image','MEDIA-18e5be01b241494b97bf3ce78373f8',21,'2025-07-03 17:49:46','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-1b6d5ac3404e404985ac90d1ea1ffa','Room','ROOM-cab35c55c4614596a0fc6786bd06171','image','MEDIA-1b6d5ac3404e404985ac90d1ea1ffa',21,'2025-07-03 17:57:04','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-223315e4085b41c7a04c831ed383bb','Room','ROOM-d885ec4f801c499aa7ec2e9482aaf80','image','MEDIA-223315e4085b41c7a04c831ed383bb',21,'2025-07-03 17:49:46','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-22424dc0b42048b1818e406a66128b','Room','ROOM-33890f1ac6cc43ecac83a95ba33479a','image','MEDIA-22424dc0b42048b1818e406a66128b',21,'2025-07-03 17:21:26','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-2374d6b3fce54601a463a680c2838b','Homestay','HOUSE-703257033dcf4ea1a3a9e2b965d105','image','MEDIA-2374d6b3fce54601a463a680c2838b',21,'2025-07-03 17:54:51','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-25ad31102d934cda9cc26dd8ca5088','Homestay','HOUSE-4d7165cb29cd473a8fad7620270127','image','MEDIA-25ad31102d934cda9cc26dd8ca5088',21,'2025-07-03 17:53:01','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-2605b9aa0c504f7687c83a04337e81','Room','ROOM-7a80e397d7ac40ed831c7a8a5088aed','image','MEDIA-2605b9aa0c504f7687c83a04337e81',21,'2025-07-03 17:49:46','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-2cfa6d968e3742a49979a153d6dd53','Homestay','HOUSE-59d99761bde341f8928003e50e66a5','image','MEDIA-2cfa6d968e3742a49979a153d6dd53',21,'2025-07-03 17:50:56','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-2dd0d9cbe4894409835ee45761bc87','Homestay','HOUSE-8868c75074d14d829602ad57208712','image','MEDIA-2dd0d9cbe4894409835ee45761bc87',21,'2025-07-03 17:57:04','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-2e806983578c47a69d2430d3bbe93d','Room','ROOM-5171c934ae7a436db92252d43cf8c91','image','MEDIA-2e806983578c47a69d2430d3bbe93d',21,'2025-07-03 17:57:04','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-30161287ee64484ab56bcd06453453','Homestay','HOUSE-59d99761bde341f8928003e50e66a5','image','MEDIA-30161287ee64484ab56bcd06453453',21,'2025-07-03 17:50:56','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-31d1d3418063409f8ac5262be3ad1b','Room','ROOM-92fbf927f85744f69c27203487440f4','image','MEDIA-31d1d3418063409f8ac5262be3ad1b',21,'2025-07-03 17:42:24','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-32f10e887b054fd6995c28b4467dd2','Homestay','HOUSE-a168118c1d6242969e012b9ee7b4f8','image','MEDIA-32f10e887b054fd6995c28b4467dd2',21,'2025-07-03 17:51:44','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-3efa6eae8f8c426880e05c8034793c','Homestay','HOUSE-703257033dcf4ea1a3a9e2b965d105','image','MEDIA-3efa6eae8f8c426880e05c8034793c',21,'2025-07-03 17:54:51','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-42dde1b33e3d4c2fbd176dde1cf3dc','Homestay','HOUSE-8868c75074d14d829602ad57208712','image','MEDIA-42dde1b33e3d4c2fbd176dde1cf3dc',21,'2025-07-03 17:57:04','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-431e3bb6944b4c51b42086f538f1d0','Post','POST-3e637dc8a4354f13a6f54af70523a79','image','MEDIA-431e3bb6944b4c51b42086f538f1d0',21,'2025-07-10 12:28:47','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-433363ef28664fe69a0d7ce57fb417','Homestay','HOUSE-8868c75074d14d829602ad57208712','image','MEDIA-433363ef28664fe69a0d7ce57fb417',21,'2025-07-03 17:57:04','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-4375e05f79c0401e9e9a21dd26b95a','Homestay','HOUSE-59d99761bde341f8928003e50e66a5','image','MEDIA-4375e05f79c0401e9e9a21dd26b95a',21,'2025-07-03 17:50:56','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-46b17b98220b45e588e4a28a92f596','Room','ROOM-ffc00fb0725a46b5ae3a43e0c75cf63','image','MEDIA-46b17b98220b45e588e4a28a92f596',21,'2025-07-03 17:42:24','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-4d9c9bf308944674afa166b345ace5','Room','ROOM-96aed71fd01f459a93a53129a8dfc65','image','MEDIA-4d9c9bf308944674afa166b345ace5',21,'2025-07-03 17:29:08','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-4ee7edea867c4e949f3104ee0d9936','Room','ROOM-5171c934ae7a436db92252d43cf8c91','image','MEDIA-4ee7edea867c4e949f3104ee0d9936',21,'2025-07-03 17:57:04','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-53d68cfa8963489e8cac3e3bb69862','Homestay','HOUSE-4d7165cb29cd473a8fad7620270127','image','MEDIA-53d68cfa8963489e8cac3e3bb69862',21,'2025-07-03 17:53:01','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-5408a57eef5847cca060002507cd22','Room','ROOM-7a80e397d7ac40ed831c7a8a5088aed','image','MEDIA-5408a57eef5847cca060002507cd22',21,'2025-07-03 17:49:46','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-54a5427fa78b4e958ae9c7acde5c27','Room','ROOM-4e4d654dc46d425e99e9de7634bf719','image','MEDIA-54a5427fa78b4e958ae9c7acde5c27',21,'2025-07-03 17:42:24','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-5648de45a9aa41d789770a11697db6','Homestay','HOUSE-703257033dcf4ea1a3a9e2b965d105','image','MEDIA-5648de45a9aa41d789770a11697db6',21,'2025-07-03 17:54:51','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-5b3c59855e0043e1bea2ea748c2dd8','Homestay','HOUSE-45f6b3c2263e4cc9a847be1a1658bc','image','MEDIA-5b3c59855e0043e1bea2ea748c2dd8',21,'2025-07-03 17:52:19','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-5be46ca7c3fa47b09ff0bea4bb5ff7','Homestay','HOUSE-2917ed6ad5804a6da4651f7d24f9ab','image','MEDIA-5be46ca7c3fa47b09ff0bea4bb5ff7',21,'2025-07-03 17:21:26','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-5f12cd61d3d14ef59c54fd46d056a5','Room','ROOM-96aed71fd01f459a93a53129a8dfc65','image','MEDIA-5f12cd61d3d14ef59c54fd46d056a5',21,'2025-07-03 17:29:08','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-609e808d5c29445e86ca665f151075','Room','ROOM-cab35c55c4614596a0fc6786bd06171','image','MEDIA-609e808d5c29445e86ca665f151075',21,'2025-07-03 17:57:04','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-627c37bdb64541cbbb18156ebd6825','Homestay','HOUSE-59d99761bde341f8928003e50e66a5','image','MEDIA-627c37bdb64541cbbb18156ebd6825',21,'2025-07-03 17:50:56','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-640396d49e08493a8056c42e9a2456','Homestay','HOUSE-45f6b3c2263e4cc9a847be1a1658bc','image','MEDIA-640396d49e08493a8056c42e9a2456',21,'2025-07-03 17:52:19','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-68870713e20246aca458bcf6b4bf72','Homestay','HOUSE-1a8f3eccaf5941a5914e7e29b7f8be','image','MEDIA-68870713e20246aca458bcf6b4bf72',21,'2025-07-03 17:49:46','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-6b328f291e7d4cd8a616b3835b0bb6','Room','ROOM-cab35c55c4614596a0fc6786bd06171','image','MEDIA-6b328f291e7d4cd8a616b3835b0bb6',21,'2025-07-03 17:57:04','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-6bf8df7571354c31bbcab236969f34','Room','ROOM-33890f1ac6cc43ecac83a95ba33479a','image','MEDIA-6bf8df7571354c31bbcab236969f34',21,'2025-07-03 17:21:26','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-70956c4c66fb4b18a1836c8770bbb5','Homestay','HOUSE-2917ed6ad5804a6da4651f7d24f9ab','image','MEDIA-70956c4c66fb4b18a1836c8770bbb5',21,'2025-07-03 17:21:26','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-735effe6243e4c8a95e7ed56eaea9d','Room','ROOM-60886955e8ca4012808299322248aad','image','MEDIA-735effe6243e4c8a95e7ed56eaea9d',21,'2025-07-03 17:57:04','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-754a15e681cc40eb9a862d1f22a733','Homestay','HOUSE-4d7165cb29cd473a8fad7620270127','image','MEDIA-754a15e681cc40eb9a862d1f22a733',21,'2025-07-03 17:53:01','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-757ad4fffab6403c90f43d621e56fa','Post','POST-dfb6223f3ea44f918f89913132def4a','image','MEDIA-757ad4fffab6403c90f43d621e56fa',21,'2025-07-10 12:29:30','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-789a411ad4e44faf9e4e651fe44db9','Homestay','HOUSE-a168118c1d6242969e012b9ee7b4f8','image','MEDIA-789a411ad4e44faf9e4e651fe44db9',21,'2025-07-03 17:51:44','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-78c9ad5f43594443b15839c5d34f1f','Homestay','HOUSE-45f6b3c2263e4cc9a847be1a1658bc','image','MEDIA-78c9ad5f43594443b15839c5d34f1f',21,'2025-07-03 17:52:19','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-7cded01b22354a5fa5b5ba60490b00','Homestay','HOUSE-59d99761bde341f8928003e50e66a5','image','MEDIA-7cded01b22354a5fa5b5ba60490b00',21,'2025-07-03 17:50:56','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-7e5c712ab88c4c7a85ae8c584428d7','Homestay','HOUSE-45f6b3c2263e4cc9a847be1a1658bc','image','MEDIA-7e5c712ab88c4c7a85ae8c584428d7',21,'2025-07-03 17:52:19','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-849abbc18eaf41e7a523764b5c09e2','Room','ROOM-7a80e397d7ac40ed831c7a8a5088aed','image','MEDIA-849abbc18eaf41e7a523764b5c09e2',21,'2025-07-03 17:49:46','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-880788e8a52b44cbb35430d8089837','Homestay','HOUSE-45f6b3c2263e4cc9a847be1a1658bc','image','MEDIA-880788e8a52b44cbb35430d8089837',21,'2025-07-03 17:52:19','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-889740ea97d441e1889a76278ce2f5','Room','ROOM-ffc00fb0725a46b5ae3a43e0c75cf63','image','MEDIA-889740ea97d441e1889a76278ce2f5',21,'2025-07-03 17:42:24','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-8a82399f47ed4f48a510883e47bcbf','Homestay','HOUSE-703257033dcf4ea1a3a9e2b965d105','image','MEDIA-8a82399f47ed4f48a510883e47bcbf',21,'2025-07-03 17:54:51','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-9023ddf8e7bb4aa4aa5e565855ea1f','Homestay','HOUSE-a168118c1d6242969e012b9ee7b4f8','image','MEDIA-9023ddf8e7bb4aa4aa5e565855ea1f',21,'2025-07-03 17:51:44','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-9168fffc11ba43e1bc742f26ac0c74','Homestay','HOUSE-59d99761bde341f8928003e50e66a5','image','MEDIA-9168fffc11ba43e1bc742f26ac0c74',21,'2025-07-03 17:50:56','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-970abcd68f644a5c800adeed10a78c','Room','ROOM-33890f1ac6cc43ecac83a95ba33479a','image','MEDIA-970abcd68f644a5c800adeed10a78c',21,'2025-07-03 17:21:26','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-97434d71ad994ffca41ce854d9fba9','Homestay','HOUSE-59d99761bde341f8928003e50e66a5','image','MEDIA-97434d71ad994ffca41ce854d9fba9',21,'2025-07-03 17:50:56','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-99a04d15dcb64e1eb15f8f4b15760f','Room','ROOM-4e4d654dc46d425e99e9de7634bf719','image','MEDIA-99a04d15dcb64e1eb15f8f4b15760f',21,'2025-07-03 17:42:24','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-9a7d1cc2053243b1a16d24e32ebf68','Room','ROOM-052d8403805d4c5daac4867ca28452a','image','MEDIA-9a7d1cc2053243b1a16d24e32ebf68',21,'2025-07-03 17:49:46','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-9b0ebf6bd8b940208c4e53b9538c2d','Room','ROOM-ffc00fb0725a46b5ae3a43e0c75cf63','image','MEDIA-9b0ebf6bd8b940208c4e53b9538c2d',21,'2025-07-03 17:42:24','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-9b704b96fc30400fafe7d6b1dd048e','Homestay','HOUSE-a168118c1d6242969e012b9ee7b4f8','image','MEDIA-9b704b96fc30400fafe7d6b1dd048e',21,'2025-07-03 17:51:44','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-a2762b713c024a9e94d460c714847c','Room','ROOM-92fbf927f85744f69c27203487440f4','image','MEDIA-a2762b713c024a9e94d460c714847c',21,'2025-07-03 17:42:24','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-a56f4ccbdd734485bc24d609d93530','Room','ROOM-92fbf927f85744f69c27203487440f4','image','MEDIA-a56f4ccbdd734485bc24d609d93530',21,'2025-07-03 17:42:24','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-a62279a744484de4a6b957c6de1b6f','Room','ROOM-60886955e8ca4012808299322248aad','image','MEDIA-a62279a744484de4a6b957c6de1b6f',21,'2025-07-03 17:57:04','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-aef6b5e4c54445c1ba61d9ec25fb7d','Room','ROOM-33890f1ac6cc43ecac83a95ba33479a','image','MEDIA-aef6b5e4c54445c1ba61d9ec25fb7d',21,'2025-07-03 17:21:26','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-b0fd1e0dda9245ca893d3b905381b9','Room','ROOM-60886955e8ca4012808299322248aad','image','MEDIA-b0fd1e0dda9245ca893d3b905381b9',21,'2025-07-03 17:57:04','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-b2e8f91030cc4841a6e4a2fd9b86b7','Homestay','HOUSE-4d7165cb29cd473a8fad7620270127','image','MEDIA-b2e8f91030cc4841a6e4a2fd9b86b7',21,'2025-07-03 17:53:01','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-be69689ccca540c39a5a14e01f3d3d','Homestay','HOUSE-1a8f3eccaf5941a5914e7e29b7f8be','image','MEDIA-be69689ccca540c39a5a14e01f3d3d',21,'2025-07-03 17:49:45','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-c29e89d904a5436280e32da6603317','Room','ROOM-60886955e8ca4012808299322248aad','image','MEDIA-c29e89d904a5436280e32da6603317',21,'2025-07-03 17:57:04','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-c4bd6cc57f5a4cc2bd446ab342feab','Homestay','HOUSE-45f6b3c2263e4cc9a847be1a1658bc','image','MEDIA-c4bd6cc57f5a4cc2bd446ab342feab',21,'2025-07-03 17:52:19','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-c5f664af76bd453189966d57257b35','Room','ROOM-7a80e397d7ac40ed831c7a8a5088aed','image','MEDIA-c5f664af76bd453189966d57257b35',21,'2025-07-03 17:49:46','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-c958c36efca24adca38aeca3ca711e','Homestay','HOUSE-45f6b3c2263e4cc9a847be1a1658bc','image','MEDIA-c958c36efca24adca38aeca3ca711e',21,'2025-07-03 17:52:19','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-c9f82b75a99f4afea6c76449cefb8b','Room','ROOM-96aed71fd01f459a93a53129a8dfc65','image','MEDIA-c9f82b75a99f4afea6c76449cefb8b',21,'2025-07-03 17:29:08','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-cebc4ba707084725bfd7595daca30b','Room','ROOM-052d8403805d4c5daac4867ca28452a','image','MEDIA-cebc4ba707084725bfd7595daca30b',21,'2025-07-03 17:49:46','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-d183caf8635544d8acdbf99fb2d3d2','Homestay','HOUSE-2917ed6ad5804a6da4651f7d24f9ab','image','MEDIA-d183caf8635544d8acdbf99fb2d3d2',21,'2025-07-03 17:21:26','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-d2672b5045c7401d8dd0d928297e6b','Homestay','HOUSE-a168118c1d6242969e012b9ee7b4f8','image','MEDIA-d2672b5045c7401d8dd0d928297e6b',21,'2025-07-03 17:51:44','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-d5bf35085b9d4a73a7a446a5c26277','Room','ROOM-60886955e8ca4012808299322248aad','image','MEDIA-d5bf35085b9d4a73a7a446a5c26277',21,'2025-07-03 17:57:04','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-d9d17624091641f092fca0207adac0','Room','ROOM-052d8403805d4c5daac4867ca28452a','image','MEDIA-d9d17624091641f092fca0207adac0',21,'2025-07-03 17:49:46','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-dba12e044a5a439e892d4e063bf753','Homestay','HOUSE-4d7165cb29cd473a8fad7620270127','image','MEDIA-dba12e044a5a439e892d4e063bf753',21,'2025-07-03 17:53:01','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-e0e5409560ee40e98aef6daeefd925','Homestay','HOUSE-8868c75074d14d829602ad57208712','image','MEDIA-e0e5409560ee40e98aef6daeefd925',21,'2025-07-03 17:57:04','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-e240c8926b004c839ee1803d1f3728','Homestay','HOUSE-59d99761bde341f8928003e50e66a5','image','MEDIA-e240c8926b004c839ee1803d1f3728',21,'2025-07-03 17:50:56','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-e3d590b01ed343f7912c1c7347c756','Homestay','HOUSE-2917ed6ad5804a6da4651f7d24f9ab','image','MEDIA-e3d590b01ed343f7912c1c7347c756',21,'2025-07-03 17:21:26','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-e7af66d9a8fe4116ab7647c72a5c72','Homestay','HOUSE-a168118c1d6242969e012b9ee7b4f8','image','MEDIA-e7af66d9a8fe4116ab7647c72a5c72',21,'2025-07-03 17:51:44','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-f09028cc4a8144498317a4c2609185','Room','ROOM-4e4d654dc46d425e99e9de7634bf719','image','MEDIA-f09028cc4a8144498317a4c2609185',21,'2025-07-03 17:42:24','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-f15147cdd9bc4151859ca901d68e4c','Homestay','HOUSE-1a8f3eccaf5941a5914e7e29b7f8be','image','MEDIA-f15147cdd9bc4151859ca901d68e4c',21,'2025-07-03 17:49:46','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-f1e1a128b7304d97b071aa2a7d09b2','Homestay','HOUSE-59d99761bde341f8928003e50e66a5','image','MEDIA-f1e1a128b7304d97b071aa2a7d09b2',21,'2025-07-03 17:50:56','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-f405fa29fb464e5e828d308b09af0f','Homestay','HOUSE-2917ed6ad5804a6da4651f7d24f9ab','image','MEDIA-f405fa29fb464e5e828d308b09af0f',21,'2025-07-03 17:21:26','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-f5e2ac387a504967bdf69796701bd9','Post','POST-16a79f833d214439b5c2d12d825f77f','image','MEDIA-f5e2ac387a504967bdf69796701bd9',21,'2025-07-03 18:04:03','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-f7305b4d2bf64438b57dba8b8af224','Room','ROOM-5171c934ae7a436db92252d43cf8c91','image','MEDIA-f7305b4d2bf64438b57dba8b8af224',21,'2025-07-03 17:57:04','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-f7365f3f91a54762bf02174df32c98','Room','ROOM-33890f1ac6cc43ecac83a95ba33479a','image','MEDIA-f7365f3f91a54762bf02174df32c98',21,'2025-07-03 17:21:26','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-fa2f144b8a004b01b214426520db1a','Homestay','HOUSE-a168118c1d6242969e012b9ee7b4f8','image','MEDIA-fa2f144b8a004b01b214426520db1a',21,'2025-07-03 17:51:44','U-bc094ab05844450190f60b3fa20211c6',NULL),('MEDIA-fddf0ce06e494a06bd5cae59ccc42f','Room','ROOM-5171c934ae7a436db92252d43cf8c91','image','MEDIA-fddf0ce06e494a06bd5cae59ccc42f',21,'2025-07-03 17:57:04','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-fef064cbeeaf4f99a14002402cb273','Homestay','HOUSE-2917ed6ad5804a6da4651f7d24f9ab','image','MEDIA-fef064cbeeaf4f99a14002402cb273',21,'2025-07-03 17:21:26','U-bc094ab05844450190f60b3fa20211c6',NULL);
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `booking_id` varchar(36) NOT NULL,
  `amount` double NOT NULL,
  `status_id` int NOT NULL,
  `method` varchar(45) NOT NULL,
  `transaction_id` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `bank_code` varchar(45) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_booking_fk1_idx` (`booking_id`),
  KEY `payment_booking_fk2_idx` (`user_id`),
  KEY `payment_status_fk3_idx` (`status_id`),
  CONSTRAINT `payment_booking_fk1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`),
  CONSTRAINT `payment_status_fk3` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`),
  CONSTRAINT `payment_user_fk2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES ('PAYMENT-2218e9d8b8474a2385793724bf89','U-ab0c71c0b2fa412ea760eeb459dfab6e','BOOK-500ac89f05504c70b9cc76715db85f3',4440000,32,'vnpay','15070463','2025-07-12 15:19:09','NCB','2025-07-12 15:19:44'),('PAYMENT-a4fe04b89aa848eb8e22f9c571a2','U-ab0c71c0b2fa412ea760eeb459dfab6e','BOOK-b23696adcdcd4a2c849e1391da635eb',4440000,32,'vnpay','15070461','2025-07-12 15:17:32','NCB','2025-07-12 15:17:58'),('PAYMENT-b2ae4f9b91ed4b53843fd2f0b0b5','U-ab0c71c0b2fa412ea760eeb459dfab6e','BOOK-b3b9d99f40e3430f95d69f0ef17401b',4630000,32,'vnpay','15070452','2025-07-12 15:14:19','NCB','2025-07-12 15:15:04'),('PAYMENT-db6968556d934e738a4006b8ea9c','U-ab0c71c0b2fa412ea760eeb459dfab6e','BOOK-0eec5202b22f4a1a8e812cfff5ce013',4440000,39,'vnpay','0','2025-07-10 13:19:53','VNPAY','2025-07-17 08:58:44'),('PAYMENT-df95e6c558784c1590d5d7d79394','U-ab0c71c0b2fa412ea760eeb459dfab6e','BOOK-90630385ed534b598757e85862b976a',6640000,39,'vnpay','0','2025-07-12 15:21:08','VNPAY','2025-07-12 15:24:55'),('PAYMENT-fe583e4515af4385895c236145a1','U-ab0c71c0b2fa412ea760eeb459dfab6e','BOOK-0874288ac2f742c2bbf8830738c3beb',51080000,32,'vnpay','15068883','2025-07-11 14:47:33','NCB','2025-07-11 14:51:05');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `id` varchar(36) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `user_id` varchar(36) NOT NULL,
  `post_type_id` int NOT NULL,
  `status_id` int NOT NULL,
  `target_room_id` varchar(36) DEFAULT NULL,
  `target_homestay_id` varchar(36) DEFAULT NULL,
  `parent_post_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_post_user` (`user_id`),
  KEY `idx_post_type` (`post_type_id`),
  KEY `idx_post_target_homestay` (`target_homestay_id`),
  KEY `idx_post_status` (`status_id`),
  KEY `idx_post_parent` (`parent_post_id`),
  KEY `post_fk_room_idx` (`target_room_id`),
  CONSTRAINT `post_fk_homestay` FOREIGN KEY (`target_homestay_id`) REFERENCES `homestay` (`id`),
  CONSTRAINT `post_fk_parent_post` FOREIGN KEY (`parent_post_id`) REFERENCES `post` (`id`),
  CONSTRAINT `post_fk_post_type` FOREIGN KEY (`post_type_id`) REFERENCES `post_type` (`id`),
  CONSTRAINT `post_fk_room` FOREIGN KEY (`target_room_id`) REFERENCES `room` (`id`),
  CONSTRAINT `post_fk_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`),
  CONSTRAINT `post_fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES ('POST-033c11e4574e4e7e9a9b6a2d6f0f813','Hi i would like to find a homestay that can make my dream come true!','2025-07-03 18:42:22',NULL,NULL,'U-ab0c71c0b2fa412ea760eeb459dfab6e',4,14,NULL,NULL,NULL),('POST-16a79f833d214439b5c2d12d825f77f','A warm, vintage-inspired home with local decor, soft lighting, and a peaceful garden. Ideal for relaxing evenings after exploring.','2025-07-03 18:04:03',NULL,NULL,'U-87fbb6d15ad548318110b60b797f84da',1,14,NULL,'HOUSE-4d7165cb29cd473a8fad7620270127',NULL),('POST-316b32fa91874fa2b68010a349a28c3','Rustic yet comfy cabin surrounded by pine trees. Fireplace, books, and nature trails just outside the door.','2025-07-03 18:12:13',NULL,NULL,'U-bc094ab05844450190f60b3fa20211c6',1,14,NULL,'HOUSE-a168118c1d6242969e012b9ee7b4f8',NULL),('POST-687d5728c5f44fbfa4c2ad0ea6a500b','','2025-07-16 14:38:34',NULL,NULL,'U-87fbb6d15ad548318110b60b797f84da',5,14,NULL,NULL,'POST-7684298f20b6430894382e89841a83c'),('POST-7684298f20b6430894382e89841a83c','Eco-friendly homestay made from bamboo and natural materials. Private, serene, and surrounded by trees and birdsong.','2025-07-03 18:08:24',NULL,NULL,'U-87fbb6d15ad548318110b60b797f84da',1,14,NULL,'HOUSE-8868c75074d14d829602ad57208712',NULL),('POST-8984247d9541480f9899c635d0de071','Modern comfort in the heart of the city. Walk to cafes, markets, and museums. Great for digital nomads and short-term stays.','2025-07-03 18:09:32',NULL,NULL,'U-bc094ab05844450190f60b3fa20211c6',1,14,NULL,'HOUSE-1a8f3eccaf5941a5914e7e29b7f8be',NULL),('POST-9291ccc3be684b9d95f68a566f1e662','Feel at home with homemade breakfast, a vegetable garden, and traditional wooden interiors. Warm vibes all around.','2025-07-03 18:11:43',NULL,NULL,'U-bc094ab05844450190f60b3fa20211c6',1,14,NULL,'HOUSE-2917ed6ad5804a6da4651f7d24f9ab',NULL),('POST-a0899347aa614457a4d8c7e9a8de6a0','Wake up to mountain views in this charming 2-bedroom retreat, perfect for couples or small families. Quiet, clean, and close to nature.','2025-07-03 18:00:06',NULL,NULL,'U-87fbb6d15ad548318110b60b797f84da',1,14,NULL,'HOUSE-45f6b3c2263e4cc9a847be1a1658bc',NULL),('POST-a2b13f3a7d4043df924bebcf4719f16','Hello guys i am a house owner ^^','2025-07-03 18:05:20',NULL,NULL,'U-87fbb6d15ad548318110b60b797f84da',4,14,NULL,NULL,NULL),('POST-b3bf07f64f984ea388907a18fac0520','Test 2','2025-07-12 15:51:42',NULL,NULL,'U-87fbb6d15ad548318110b60b797f84da',4,15,NULL,NULL,NULL),('POST-cc38ec0c29c545afae940200d7eede5','Steps from the beach, this airy 3-bedroom homestay offers ocean views, hammocks, and sunsets you won’t forget.','2025-07-03 18:08:09',NULL,NULL,'U-87fbb6d15ad548318110b60b797f84da',1,14,NULL,'HOUSE-703257033dcf4ea1a3a9e2b965d105',NULL),('POST-d5579bafbfb546cd943b11f29fffd5b','A stylish, studio-style homestay tucked in an old town alley. Artistic touches and a rooftop view of the skyline.','2025-07-03 18:11:59',NULL,NULL,'U-bc094ab05844450190f60b3fa20211c6',1,14,NULL,'HOUSE-59d99761bde341f8928003e50e66a5',NULL),('POST-ea032857dff943cbbba17a744360514','Test','2025-07-17 03:42:56',NULL,NULL,'U-ab0c71c0b2fa412ea760eeb459dfab6e',4,14,NULL,NULL,NULL),('POST-f31607a795b84e44a6b6bc7adc3d31e','Test ','2025-07-12 15:43:23',NULL,NULL,'U-87fbb6d15ad548318110b60b797f84da',4,15,NULL,NULL,NULL),('POST-ffd4a38625ef4f23be1338773af9045','','2025-07-16 14:38:21',NULL,NULL,'U-87fbb6d15ad548318110b60b797f84da',5,14,NULL,NULL,'POST-033c11e4574e4e7e9a9b6a2d6f0f813');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_type`
--

DROP TABLE IF EXISTS `post_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_post_type_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_type`
--

LOCK TABLES `post_type` WRITE;
/*!40000 ALTER TABLE `post_type` DISABLE KEYS */;
INSERT INTO `post_type` VALUES (3,'Admin Announcement'),(1,'Homestay Advertise'),(4,'Normal'),(5,'Share Post');
/*!40000 ALTER TABLE `post_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remember_tokens`
--

DROP TABLE IF EXISTS `remember_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `remember_tokens` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` varchar(36) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `expiration_date` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_rt_token` (`token`),
  KEY `idx_rt_user` (`user_id`),
  CONSTRAINT `rt_fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remember_tokens`
--

LOCK TABLES `remember_tokens` WRITE;
/*!40000 ALTER TABLE `remember_tokens` DISABLE KEYS */;
INSERT INTO `remember_tokens` VALUES (11,'U-bc094ab05844450190f60b3fa20211c6','TaReBarm-gxZqx-XRSpPMrOSWGZscEck_9nF77N-QG4','2025-07-17 04:49:38','2025-08-16 04:49:38'),(12,'U-c9e2596cc51d448fb337abd55ec77494','_dsz8jmAEK_DT29pbpFLD_0m34qp61lOJXUQyYzeg0Q','2025-07-17 04:49:39','2025-08-16 04:49:39'),(16,'U-87fbb6d15ad548318110b60b797f84da','aT-OjqiER8aWmqH6MU2YeN3pkrbeCLuwAyb4iGyYQzE','2025-07-17 07:22:02','2025-08-16 07:22:02'),(32,'U-c9e2596cc51d448fb337abd55ec77494','TlPnMc3UOf0WJlwjfVn4MWmu-EC89-b34rNQsqWOHfM','2025-07-17 08:41:37','2025-08-16 08:41:37'),(36,'U-ab0c71c0b2fa412ea760eeb459dfab6e','Wl7wT1WWnQ8gaHrpMU2_HtaovMLlyRRCiLRPIOwBk0A','2025-07-17 09:28:17','2025-08-16 09:28:17'),(39,'U-c9e2596cc51d448fb337abd55ec77494','m210z6ol_WS-IGYXb3gRv39jIBIAH6Nmu2kIVYPZ8Ns','2025-07-17 13:16:56','2025-08-16 13:16:56'),(50,'U-c9e2596cc51d448fb337abd55ec77494','S2wukY2I3aFj4faJXS1I-ykthk8oLXR0eQVlHxafgFs','2025-07-17 14:54:09','2025-08-16 14:54:09');
/*!40000 ALTER TABLE `remember_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `representative_booking`
--

DROP TABLE IF EXISTS `representative_booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `representative_booking` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `full_name` varchar(150) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `relationship` varchar(45) NOT NULL,
  `additional_notes` text,
  `booking_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `representative_booking_fk1_idx` (`booking_id`),
  CONSTRAINT `representative_booking_fk1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `representative_booking`
--

LOCK TABLES `representative_booking` WRITE;
/*!40000 ALTER TABLE `representative_booking` DISABLE KEYS */;
/*!40000 ALTER TABLE `representative_booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `id` varchar(36) NOT NULL,
  `star` int NOT NULL,
  `content` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status_id` int NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `homestay_id` varchar(36) NOT NULL,
  `room_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_review_user` (`user_id`),
  KEY `idx_review_homestay` (`homestay_id`),
  KEY `idx_review_room` (`room_id`),
  KEY `review_fk_status_idx` (`status_id`),
  CONSTRAINT `review_fk_homestay` FOREIGN KEY (`homestay_id`) REFERENCES `homestay` (`id`),
  CONSTRAINT `review_fk_room` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`),
  CONSTRAINT `review_fk_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`),
  CONSTRAINT `review_fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `review_chk_star` CHECK (((`star` >= 0) and (`star` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES ('REVIEW-6dccb99be3b5433ab908c4ad128a4',5,'Hello','2025-07-03 19:00:08',NULL,23,'U-ab0c71c0b2fa412ea760eeb459dfab6e','HOUSE-a168118c1d6242969e012b9ee7b4f8',NULL),('REVIEW-8d28364b70324c828b9c5d9b64360',3,'Nice','2025-07-12 15:12:07',NULL,23,'U-ab0c71c0b2fa412ea760eeb459dfab6e','HOUSE-59d99761bde341f8928003e50e66a5',NULL);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_role_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Administrator'),(2,'Guest'),(3,'Homestay Onwer'),(4,'Moderator'),(5,'Tenant');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_feature`
--

DROP TABLE IF EXISTS `role_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_feature` (
  `role_id` int NOT NULL,
  `feature_id` int NOT NULL,
  `status_id` int NOT NULL,
  PRIMARY KEY (`role_id`,`feature_id`),
  KEY `idx_rf_status` (`status_id`),
  KEY `rf_fk_feature` (`feature_id`),
  CONSTRAINT `rf_fk_feature` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`id`),
  CONSTRAINT `rf_fk_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `rf_fk_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_feature`
--

LOCK TABLES `role_feature` WRITE;
/*!40000 ALTER TABLE `role_feature` DISABLE KEYS */;
INSERT INTO `role_feature` VALUES (1,1,18),(1,2,18),(1,3,18),(1,4,18),(1,5,18),(1,6,18),(1,7,18),(1,8,18),(1,9,18),(1,10,18),(1,11,18),(1,12,18),(1,13,18),(1,14,18),(1,15,18),(1,16,18),(1,17,18),(1,18,18),(1,19,18),(1,20,18),(1,21,18),(1,22,18),(1,23,18),(1,24,18),(1,25,18),(1,26,18),(1,27,18),(1,28,18),(1,29,18),(1,30,18),(1,31,18),(1,32,18),(1,33,18),(1,34,18),(1,35,18),(1,36,18),(1,37,18),(1,38,18),(1,39,18),(1,42,18),(1,43,18),(1,44,18),(1,46,18),(1,47,18),(1,48,18),(1,49,18),(1,50,18),(1,51,18),(1,52,18),(1,53,18),(1,54,18),(1,55,18),(1,56,18),(1,57,18),(1,60,18),(1,61,18),(1,62,18),(1,63,18),(2,1,18),(2,2,18),(2,3,18),(2,4,18),(2,5,18),(2,10,18),(2,11,18),(2,14,18),(2,20,18),(2,24,18),(2,26,18),(2,27,18),(2,53,18),(2,54,18),(2,60,18),(3,1,18),(3,2,18),(3,3,18),(3,4,18),(3,5,18),(3,6,18),(3,7,18),(3,8,18),(3,9,18),(3,10,18),(3,11,18),(3,12,18),(3,13,18),(3,14,18),(3,15,18),(3,16,18),(3,17,18),(3,18,18),(3,19,18),(3,20,18),(3,21,18),(3,22,18),(3,23,18),(3,24,18),(3,25,18),(3,26,18),(3,27,18),(3,33,18),(3,38,18),(3,39,18),(3,42,18),(3,43,18),(3,44,18),(3,46,18),(3,47,18),(3,48,18),(3,53,18),(3,54,18),(3,58,18),(3,59,18),(3,60,18),(4,1,18),(4,49,18),(4,50,18),(4,51,18),(4,52,18),(4,53,18),(4,54,18),(4,55,18),(4,56,18),(4,57,18),(4,60,18),(5,1,18),(5,2,18),(5,3,18),(5,4,18),(5,5,18),(5,6,18),(5,7,18),(5,8,18),(5,9,18),(5,10,18),(5,11,18),(5,12,18),(5,13,18),(5,14,18),(5,15,18),(5,20,18),(5,24,18),(5,25,18),(5,26,18),(5,27,18),(5,33,18),(5,34,18),(5,37,18),(5,38,18),(5,39,18),(5,40,18),(5,41,18),(5,42,18),(5,43,18),(5,44,18),(5,45,18),(5,46,18),(5,53,18),(5,54,18),(5,58,18),(5,59,18),(5,60,18),(5,64,18),(5,65,18),(5,66,18),(2,63,19);
/*!40000 ALTER TABLE `role_feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `id` varchar(36) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `description` text NOT NULL,
  `star` float NOT NULL DEFAULT '0',
  `price_per_night` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `rome_position` varchar(100) NOT NULL,
  `homestay_id` varchar(36) NOT NULL,
  `status_id` int NOT NULL DEFAULT '23',
  `room_type_id` int NOT NULL,
  `max_guests` int NOT NULL,
  PRIMARY KEY (`id`,`homestay_id`),
  KEY `idx_room_homestay` (`homestay_id`),
  KEY `idx_room_status` (`status_id`),
  KEY `room_fk_room_type_idx` (`room_type_id`),
  CONSTRAINT `room_fk_homestay` FOREIGN KEY (`homestay_id`) REFERENCES `homestay` (`id`),
  CONSTRAINT `room_fk_roomtype` FOREIGN KEY (`room_type_id`) REFERENCES `room_type` (`id`),
  CONSTRAINT `room_fk_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES ('ROOM-052d8403805d4c5daac4867ca28452a','Rose Suite','Romantic and elegant, with soft drapes and garden-view windows.',0,3000000,'2025-07-03 17:49:46',NULL,'Upper Floor','HOUSE-1a8f3eccaf5941a5914e7e29b7f8be',26,5,4),('ROOM-33890f1ac6cc43ecac83a95ba33479a','Forest Gump Dex','The best mountain view deluxe room in the world',0,1500000,'2025-07-03 17:21:26',NULL,'Mountain View','HOUSE-2917ed6ad5804a6da4651f7d24f9ab',26,10,4),('ROOM-4e4d654dc46d425e99e9de7634bf719','Sparrow Loft','Bright and compact with a cozy reading nook and tree canopy views.',0,1100000,'2025-07-03 17:42:24',NULL,'Upper Floor, Corner','HOUSE-2917ed6ad5804a6da4651f7d24f9ab',26,4,4),('ROOM-5171c934ae7a436db92252d43cf8c91','Ivy Loft','Lofted ceiling, climbing ivy décor, and full-length windows.',0,12000000,'2025-07-03 17:57:04',NULL,'Upper Floor, Front Facing','HOUSE-8868c75074d14d829602ad57208712',26,10,5),('ROOM-60886955e8ca4012808299322248aad','Fern Room','Wooden décor, indoor plants, and forest breeze through open windows.',0,2000000,'2025-07-03 17:57:04',NULL,'Ground Floor, Forest Facing','HOUSE-8868c75074d14d829602ad57208712',26,10,6),('ROOM-7a80e397d7ac40ed831c7a8a5088aed','Daisy Nook','A cozy nook with minimalist design and a touch of country charm.',0,4000000,'2025-07-03 17:49:46',NULL,'Ground Floor','HOUSE-1a8f3eccaf5941a5914e7e29b7f8be',26,11,6),('ROOM-92fbf927f85744f69c27203487440f4','Sky Nest','Airy and bright, with a private balcony overlooking the surrounding hills.',0,4000000,'2025-07-03 17:42:24',NULL,'Top Floor, Front Bal','HOUSE-2917ed6ad5804a6da4651f7d24f9ab',26,7,5),('ROOM-96aed71fd01f459a93a53129a8dfc65','Robin Room','A warm and earthy room with natural tones and soft lighting, surrounded by greenery.',0,2000000,'2025-07-03 17:29:08',NULL,'Ground Floor, Garden','HOUSE-2917ed6ad5804a6da4651f7d24f9ab',26,10,2),('ROOM-cab35c55c4614596a0fc6786bd06171','Monstera Corner','Boho-chic with rattan furniture and leafy prints, tucked into a peaceful corner.',0,3000000,'2025-07-03 17:57:04',NULL,'Ground Floor, Shaded Side','HOUSE-8868c75074d14d829602ad57208712',26,7,4),('ROOM-d885ec4f801c499aa7ec2e9482aaf80','Lily Room','Pastel accents and floral prints, perfect for a light and cheerful mood.',0,2000000,'2025-07-03 17:49:46',NULL,'Ground Floor','HOUSE-1a8f3eccaf5941a5914e7e29b7f8be',26,10,5),('ROOM-ffc00fb0725a46b5ae3a43e0c75cf63','Owl’s Hollow','Quiet and shaded, ideal for afternoon naps or work-from-nature getaways.',0,3000000,'2025-07-03 17:42:24',NULL,'Ground Floor, Rear','HOUSE-2917ed6ad5804a6da4651f7d24f9ab',30,10,4);
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_type`
--

DROP TABLE IF EXISTS `room_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_type`
--

LOCK TABLES `room_type` WRITE;
/*!40000 ALTER TABLE `room_type` DISABLE KEYS */;
INSERT INTO `room_type` VALUES (10,'Deluxe'),(2,'Double'),(6,'King'),(11,'Presidential'),(4,'Quad'),(7,'Queen'),(1,'Single'),(9,'Studio'),(5,'Suit'),(3,'Triple'),(8,'Twin');
/*!40000 ALTER TABLE `room_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `category` varchar(258) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_status_name_category` (`name`,`category`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (21,'Active','image'),(1,'Active','user'),(6,'Available','homestay'),(26,'Available','room'),(4,'Banned','user'),(36,'Booked','homestay'),(30,'Booked','room'),(33,'canceled','payment'),(10,'Cancelled','booking'),(28,'Cleaning','room'),(17,'Closed','event'),(5,'Closed','homestay'),(11,'Completed','booking'),(32,'completed','payment'),(8,'Confirm Pending','booking'),(15,'Deleted','post'),(19,'Disabled','feature'),(18,'Enabled','feature'),(39,'Force Cancel','payment'),(24,'Hidden','review'),(12,'In Vacation','booking'),(22,'Inactive','image'),(2,'Inactive','user'),(29,'On Used','room'),(16,'Open','event'),(34,'Paid','booking'),(9,'Payment Pending','booking'),(31,'pending','payment'),(3,'Pending Verification','user'),(20,'Private','post'),(25,'Private','review'),(23,'Public','review'),(14,'Published','post'),(38,'Rejected','post'),(35,'Timeout','payment'),(7,'Unavailable','homestay'),(27,'Unavailable','room'),(37,'Wait for approval','post');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_tag_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (2,'cheap'),(1,'homestay'),(3,'hot');
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag_map`
--

DROP TABLE IF EXISTS `tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag_map` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tag_id` int NOT NULL,
  `object_type` varchar(50) NOT NULL,
  `object_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_tag_map_tag` (`tag_id`),
  CONSTRAINT `tag_map_fk_tag` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_map`
--

LOCK TABLES `tag_map` WRITE;
/*!40000 ALTER TABLE `tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` varchar(36) NOT NULL DEFAULT (uuid()),
  `first_name` varchar(256) NOT NULL,
  `last_name` varchar(256) NOT NULL,
  `birthdate` date DEFAULT NULL,
  `description` text,
  `username` varchar(100) NOT NULL,
  `password` varchar(256) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `avatar` varchar(512) NOT NULL DEFAULT 'default-avatar.jpg',
  `cover` varchar(512) NOT NULL DEFAULT 'default-cover.jpg',
  `social_links` json DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deactivated_at` timestamp NULL DEFAULT NULL,
  `is_verified` tinyint NOT NULL DEFAULT '0',
  `verification_token` varchar(64) DEFAULT NULL,
  `token_created` timestamp NULL DEFAULT NULL,
  `last_verification_sent` timestamp NULL DEFAULT NULL,
  `role_id` int NOT NULL,
  `address_id` int DEFAULT NULL,
  `status_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_user_username` (`username`),
  UNIQUE KEY `ux_user_email` (`email`),
  KEY `idx_user_address` (`address_id`),
  KEY `idx_user_role` (`role_id`),
  KEY `idx_user_status` (`status_id`),
  CONSTRAINT `user_fk_address` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `user_fk_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `user_fk_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`),
  CONSTRAINT `user_chk_gender` CHECK ((`gender` in (_utf8mb4'Male',_utf8mb4'Female',_utf8mb4'Other')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('U-2bbd072d35884688ae41aa716475b5fa','Trong','Hien','2024-03-04','','TrongHien4032024','fcfbcf9b3e76ccfb6e3639d0758e44ccf74d0c0f946f23f7cfd10da5b38cb028','','hotronghien2k5@gmail.com','male','default-avatar.jpg','default-cover.jpg',NULL,'2025-06-30 05:53:26','2025-06-30 05:54:51',NULL,1,NULL,NULL,NULL,5,NULL,1),('U-87fbb6d15ad548318110b60b797f84da','Tam','Mai','2024-01-01','Hi Im Tam','TamMai1012024','fcfbcf9b3e76ccfb6e3639d0758e44ccf74d0c0f946f23f7cfd10da5b38cb028','','tammshe186670@fpt.edu.vn','male','1750298425624_U-87fbb6d15ad548318110b60b797f84da_avatar','default-cover.jpg',NULL,'2025-06-17 04:13:20','2025-06-19 02:00:26',NULL,1,'TOKEN-0a7874388fbf4d849355b1fc3b77e2e1','2025-06-17 04:13:21',NULL,3,NULL,1),('U-9986993a919d489b9bffcc95f5d08ce7','Test','Test','2025-07-16',NULL,'test.test','495b7c8f6f20f75d2cba450be80b3ac4ec760498e349b7f9c931f6e08410549b',NULL,'hoanganh220104@gmail.com','male','default-avatar.jpg','default-cover.jpg',NULL,'2025-07-16 09:28:35','2025-07-17 13:57:26',NULL,1,'TOKEN-570dc3a65bd247409c3736a6097a5556','2025-07-16 09:31:16','2025-07-16 09:31:16',1,NULL,1),('U-ab0c71c0b2fa412ea760eeb459dfab6e','Khanh','Huyen2','2025-01-01','','KhanhHuyen1012025','fcfbcf9b3e76ccfb6e3639d0758e44ccf74d0c0f946f23f7cfd10da5b38cb028','','huyennkhe182494@fpt.edu.vn','female','default-avatar.jpg','default-cover.jpg',NULL,'2025-06-16 02:25:20',NULL,NULL,1,'TOKEN-20cd9700899b4931a03f352d70a2f6b1','2025-06-16 02:25:20',NULL,5,NULL,1),('U-bc094ab05844450190f60b3fa20211c6','Ha','LP','2025-01-18',NULL,'HaLP1012025','fcfbcf9b3e76ccfb6e3639d0758e44ccf74d0c0f946f23f7cfd10da5b38cb028','0966641037','halphe186730@fpt.edu.vn','male','default-avatar.jpg','default-cover.jpg',NULL,'2025-07-03 17:15:37','2025-07-17 14:58:23',NULL,1,'TOKEN-8c748361546d415ab60e1bf92fec6765','2025-07-03 17:15:37',NULL,3,NULL,1),('U-c9e2596cc51d448fb337abd55ec77494','Dai','ND','2000-01-01',NULL,'DaiND1012000','fcfbcf9b3e76ccfb6e3639d0758e44ccf74d0c0f946f23f7cfd10da5b38cb028',NULL,'daindhe173583@fpt.edu.vn','male','default-avatar.jpg','default-cover.jpg',NULL,'2025-07-03 07:28:06',NULL,NULL,1,'TOKEN-4e1bfca222e5422dbb582618edb49973','2025-07-03 07:28:07',NULL,1,NULL,1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_follow`
--

DROP TABLE IF EXISTS `user_follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_follow` (
  `id` varchar(36) NOT NULL,
  `follower_id` varchar(36) NOT NULL,
  `followee_id` varchar(36) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_follow_pair` (`follower_id`,`followee_id`),
  KEY `idx_follow_follower` (`follower_id`),
  KEY `idx_follow_followee` (`followee_id`),
  CONSTRAINT `follow_fk_followee` FOREIGN KEY (`followee_id`) REFERENCES `user` (`id`),
  CONSTRAINT `follow_fk_follower` FOREIGN KEY (`follower_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_follow`
--

LOCK TABLES `user_follow` WRITE;
/*!40000 ALTER TABLE `user_follow` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'fuhousefinder_homestay'
--

--
-- Dumping routines for database 'fuhousefinder_homestay'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-17 22:00:41
