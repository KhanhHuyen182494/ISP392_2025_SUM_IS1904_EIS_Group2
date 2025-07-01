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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'Việt Nam','Hà Nội','Hà Đông','Văn Quán',NULL,'2025-06-17 04:48:51','U-87fbb6d15ad548318110b60b797f84da',NULL),(2,'Việt Nam','Tỉnh Cao Bằng','Huyện Quảng Hòa','Xã Tự Do','teste','2025-06-24 04:56:29','U-87fbb6d15ad548318110b60b797f84da',NULL),(3,'Việt Nam','Tỉnh Bến Tre','Huyện Chợ Lách','Xã Long Thới','Test 2','2025-06-27 08:04:09','U-87fbb6d15ad548318110b60b797f84da',NULL),(4,'Việt Nam','Tỉnh Bình Dương','Thị xã Bến Cát','Xã An Điền','123','2025-06-27 08:08:42','U-87fbb6d15ad548318110b60b797f84da',NULL),(5,'Việt Nam','Tỉnh Bình Dương','Thị xã Bến Cát','Xã An Điền','123','2025-06-27 08:10:32','U-87fbb6d15ad548318110b60b797f84da',NULL),(6,'Việt Nam','Tỉnh Bình Định','Huyện Hoài Ân','Xã Ân Hữu','123123','2025-06-28 02:53:07','U-87fbb6d15ad548318110b60b797f84da',NULL),(7,'Việt Nam','Tỉnh Gia Lai','Huyện Phú Thiện','Xã Ia Hiao','Yêu 5','2025-06-28 03:29:22','U-87fbb6d15ad548318110b60b797f84da','2025-06-28 23:48:05'),(8,'Việt Nam','Tỉnh Bà Rịa - Vũng Tàu','Huyện Long Điền','Thị trấn Long Hải','123123','2025-06-28 04:21:16','U-87fbb6d15ad548318110b60b797f84da','2025-06-28 23:44:31');
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
INSERT INTO `booking` VALUES ('BOOK-179d2625f2e14c3591df2ce8feca0d3','U-2bbd072d35884688ae41aa716475b5fa','HOUSE-f6502276ce6b4697b4173a16ae2962',NULL,'2025-06-30','2025-07-03',606306,121261,36937,200000,8,'2025-06-30 12:31:52',NULL,NULL),('BOOK-30d45ce91ef7e4457a520b26ec27100','U-2bbd072d35884688ae41aa716475b5fa','HOUSE-0d45ce91ef7e4457a520b26ec27100',NULL,'2025-07-14','2025-07-17',1000000,20000,0,0,12,'2025-06-30 06:59:00',NULL,NULL),('BOOK-a995021411e145f2b95649255ee32bc','U-2bbd072d35884688ae41aa716475b5fa','HOUSE-f6502276ce6b4697b4173a16ae2962',NULL,'2025-07-11','2025-07-18',1148047,229609,86186,200000,8,'2025-06-30 12:34:01',NULL,NULL),('BOOK-e819f3e8da9f408f894553db89a9efd','U-2bbd072d35884688ae41aa716475b5fa','HOUSE-f6502276ce6b4697b4173a16ae2962',NULL,'2025-08-05','2025-10-10',9138730,1827746,812612,200000,8,'2025-06-30 14:14:38',NULL,NULL);
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
INSERT INTO `comment` VALUES ('COMMENT-4f0e3d911f90485b9d47a8e3203a','U-2bbd072d35884688ae41aa716475b5fa','POST-98daafdc1fd645eba1e3e4d400ba70c',NULL,'asdf','2025-06-30 14:12:34',NULL,NULL);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_feature_name` (`name`),
  UNIQUE KEY `ux_feature_path` (`path`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature`
--

LOCK TABLES `feature` WRITE;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` VALUES (1,'View Homepage','/feeds'),(2,'View Feedback House','/feedback/house'),(3,'View Feedback Room','/feedback/house-room'),(4,'View User Profile','/profile'),(5,'View Owner House','/owner-house'),(6,'Change Password','/change-password'),(7,'Send OTP','/send-otp'),(8,'View Verify OTP Page','/get-verify-otp'),(9,'Do Verify OTP','/verify-otp'),(10,'Search','/search'),(11,'Get Image','/image'),(12,'Change Avatar','/change-avatar'),(13,'Change Cover','/change-cover'),(14,'Get Comments','/comment'),(15,'New post','/post'),(16,'Get All Homestay For Owner','/homestay/get'),(17,'Get All Room for Homestay','/homestay/room/get'),(18,'Add New House','/owner-house/add'),(19,'Edit House','/owner-house/edit'),(20,'Detail House','/owner-house/detail'),(21,'Add New Room','/room/add'),(22,'Edit Room','/room/edit'),(23,'Delete Room','/room/delete'),(24,'Detail Room','/room'),(25,'Edit Profile','/profile-edit'),(26,'View List Available House','/house/available'),(27,'View List Available Room','/house/room/available'),(28,'Admin List User','/manage/user'),(29,'Admin Add User','/manage/user/add'),(30,'Admin Edit User','/manage/user/edit'),(31,'Admin Update User','/manage/user/update'),(32,'Admin Delete User','/manage/user/delete'),(33,'View Reviews','/review'),(34,'Send Review','/review/add'),(35,'Update Review','/review/update'),(36,'Delete Review','/review/delete'),(37,'View Booking Page','/booking'),(38,'Get Avalable Room API','/homestay/room/available'),(39,'Get Room Detail API','/homestay/room'),(40,'View Booking Contract','/booking/contract'),(41,'Confirm Booking','/booking/confirm'),(42,'View Booking History','/booking/history');
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
INSERT INTO `homestay` VALUES ('HOUSE-0d45ce91ef7e4457a520b26ec27100','Hơn cả yêu test 5','Yêu cả hơn test 6',0,1,2100003,'U-87fbb6d15ad548318110b60b797f84da',5,7,'2025-06-28 03:29:22','2025-06-28 23:48:05'),('HOUSE-ceba29ae2440479085e22bac728678','Dòng thời gian','Thời gian',0,0,0,'U-87fbb6d15ad548318110b60b797f84da',6,8,'2025-06-28 04:21:16','2025-06-28 23:44:31'),('HOUSE-f6502276ce6b4697b4173a16ae2962','Thiên Đường','Đây đích thị là thiên đường, không sai không kém',4,1,123123,'U-87fbb6d15ad548318110b60b797f84da',6,6,'2025-06-28 02:53:07',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `like_post`
--

LOCK TABLES `like_post` WRITE;
/*!40000 ALTER TABLE `like_post` DISABLE KEYS */;
INSERT INTO `like_post` VALUES (6,'U-87fbb6d15ad548318110b60b797f84da','POST-98daafdc1fd645eba1e3e4d400ba70c',1,'2025-06-28 05:05:29',NULL);
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
INSERT INTO `media` VALUES ('MEDIA-0294fcde8a044631b44c799dd609d0','Post','POST-98daafdc1fd645eba1e3e4d400ba70c','image','MEDIA-0294fcde8a044631b44c799dd609d0',21,'2025-06-28 03:15:48','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-0713940c6e334e3f91b6c3b67c0976','Room','ROOM-913e90f2560e44718aff70306c9de49','image','MEDIA-0713940c6e334e3f91b6c3b67c0976',21,'2025-06-28 04:21:16','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-0f9fe8ffdf80401a9e55d672073821','Homestay','HOUSE-ceba29ae2440479085e22bac728678','image','MEDIA-0f9fe8ffdf80401a9e55d672073821',21,'2025-06-28 23:44:31','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-19c983bb3384481b86316b84357216','Homestay','HOUSE-0d45ce91ef7e4457a520b26ec27100','image','MEDIA-19c983bb3384481b86316b84357216',21,'2025-06-28 03:29:22','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-29d73c2eb16e4ad2b86da260c5111f','Homestay','HOUSE-0d45ce91ef7e4457a520b26ec27100','image','MEDIA-29d73c2eb16e4ad2b86da260c5111f',21,'2025-06-28 03:29:22','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-33f8f916572b4048b92652ab141386','Homestay','HOUSE-0d45ce91ef7e4457a520b26ec27100','image','MEDIA-33f8f916572b4048b92652ab141386',21,'2025-06-28 23:46:29','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-38574d3e31f34589ada3679e918795','Homestay','HOUSE-ceba29ae2440479085e22bac728678','image','MEDIA-38574d3e31f34589ada3679e918795',21,'2025-06-28 04:21:16','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-48766e8dd6224c09b1df6dd987df96','Homestay','HOUSE-ceba29ae2440479085e22bac728678','image','MEDIA-48766e8dd6224c09b1df6dd987df96',21,'2025-06-28 04:21:15','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-570c257a72674639b38619ebbad8f1','Room','ROOM-274d6b2a66fe419db0ed1b2585549e6','image','MEDIA-570c257a72674639b38619ebbad8f1',21,'2025-06-29 02:58:44','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-5af6266e867b450abd4ddc7e3d8154','Homestay','HOUSE-0d45ce91ef7e4457a520b26ec27100','image','MEDIA-5af6266e867b450abd4ddc7e3d8154',21,'2025-06-28 23:46:29','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-5f79fa31d4e64db0bf0667c418554b','Room','ROOM-913e90f2560e44718aff70306c9de49','image','MEDIA-5f79fa31d4e64db0bf0667c418554b',21,'2025-06-28 04:21:16','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-6b15434c98dd46618dfe5b77a0a1c3','Homestay','HOUSE-0d45ce91ef7e4457a520b26ec27100','image','MEDIA-6b15434c98dd46618dfe5b77a0a1c3',21,'2025-06-28 23:46:29','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-70d90ae7010345429b296ebc917481','Homestay','HOUSE-ceba29ae2440479085e22bac728678','image','MEDIA-70d90ae7010345429b296ebc917481',21,'2025-06-28 04:21:16','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-745d234fa14d4c7c9b6685d4019593','Homestay','HOUSE-ceba29ae2440479085e22bac728678','image','MEDIA-745d234fa14d4c7c9b6685d4019593',21,'2025-06-28 04:21:15','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-8034766e536c40cfbca3c5fc4ae9e9','Room','ROOM-274d6b2a66fe419db0ed1b2585549e6','image','MEDIA-8034766e536c40cfbca3c5fc4ae9e9',21,'2025-06-29 01:08:12','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-85b15247b9534b439b0599531c4622','Room','ROOM-913e90f2560e44718aff70306c9de49','image','MEDIA-85b15247b9534b439b0599531c4622',21,'2025-06-28 04:21:16','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-90433004eed346faa125e5a96fce31','Homestay','HOUSE-ceba29ae2440479085e22bac728678','image','MEDIA-90433004eed346faa125e5a96fce31',21,'2025-06-28 04:21:15','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-905a8fa80a3b4c47b931b53d368805','Homestay','HOUSE-f6502276ce6b4697b4173a16ae2962','image','MEDIA-905a8fa80a3b4c47b931b53d368805',21,'2025-06-28 02:53:07','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-a4fa9a5595944e339c1846ff06e64c','Homestay','HOUSE-ceba29ae2440479085e22bac728678','image','MEDIA-a4fa9a5595944e339c1846ff06e64c',21,'2025-06-28 04:21:15','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-af3b26bd0cab437abc2388e758409b','Room','ROOM-274d6b2a66fe419db0ed1b2585549e6','image','MEDIA-af3b26bd0cab437abc2388e758409b',21,'2025-06-29 02:58:50','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-b00fa23294524a1ba6e0a42bfb697b','Room','ROOM-913e90f2560e44718aff70306c9de49','image','MEDIA-b00fa23294524a1ba6e0a42bfb697b',21,'2025-06-28 04:21:16','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-bbf1b50cfbf24e6ea9e907df21910a','Room','ROOM-913e90f2560e44718aff70306c9de49','image','MEDIA-bbf1b50cfbf24e6ea9e907df21910a',21,'2025-06-28 04:21:16','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-bd284bacfa3340389088a8dd4dcba8','Homestay','HOUSE-0d45ce91ef7e4457a520b26ec27100','image','MEDIA-bd284bacfa3340389088a8dd4dcba8',21,'2025-06-28 23:46:29','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-dc110b3b852f4031a89d06ece11a4b','Room','ROOM-913e90f2560e44718aff70306c9de49','image','MEDIA-dc110b3b852f4031a89d06ece11a4b',21,'2025-06-28 04:21:16','U-87fbb6d15ad548318110b60b797f84da',NULL),('MEDIA-f9ed6271400d4831a9fa7ac386172f','Homestay','HOUSE-f6502276ce6b4697b4173a16ae2962','image','MEDIA-f9ed6271400d4831a9fa7ac386172f',21,'2025-06-28 02:53:07','U-87fbb6d15ad548318110b60b797f84da',NULL);
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
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
INSERT INTO `post` VALUES ('POST-4a0fd3d965a2465ea19ab2569219e3b','Advertise','2025-06-28 03:14:15',NULL,NULL,'U-87fbb6d15ad548318110b60b797f84da',1,14,NULL,'HOUSE-f6502276ce6b4697b4173a16ae2962',NULL),('POST-98daafdc1fd645eba1e3e4d400ba70c','Advertise 2','2025-06-28 03:15:48',NULL,NULL,'U-87fbb6d15ad548318110b60b797f84da',1,14,NULL,'HOUSE-f6502276ce6b4697b4173a16ae2962',NULL);
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
INSERT INTO `post_type` VALUES (3,'Admin Announcement'),(2,'Find Homestay'),(1,'Homestay Advertise'),(4,'Normal'),(5,'Share Post');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remember_tokens`
--

LOCK TABLES `remember_tokens` WRITE;
/*!40000 ALTER TABLE `remember_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `remember_tokens` ENABLE KEYS */;
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
INSERT INTO `review` VALUES ('REVIEW-87fbb6d15ad548318110b60b797',4,'Nhà cực đẹp, ở siêu mê','2025-06-30 03:25:37',NULL,23,'U-ab0c71c0b2fa412ea760eeb459dfab6e','HOUSE-0d45ce91ef7e4457a520b26ec27100',NULL),('REVIEW-87fbb6d15ad548318110b60b798',4,'Nhà cực đẹp, ở siêu mê','2025-06-30 03:25:37',NULL,23,'U-ab0c71c0b2fa412ea760eeb459dfab6e','HOUSE-0d45ce91ef7e4457a520b26ec27100',NULL),('REVIEW-87fbb6d15ad548318110b60b799',4,'Nhà cực đẹp, ở siêu mê','2025-06-30 03:25:37',NULL,23,'U-ab0c71c0b2fa412ea760eeb459dfab6e','HOUSE-0d45ce91ef7e4457a520b26ec27100',NULL),('REVIEW-87fbb6d15ad548318110b60b800',5,'Nhà cực đẹp, ở siêu mê','2025-06-30 03:25:37',NULL,23,'U-ab0c71c0b2fa412ea760eeb459dfab6e','HOUSE-ceba29ae2440479085e22bac728678','ROOM-274d6b2a66fe419db0ed1b2585549e6'),('REVIEW-87fbb6d15ad548318110b60b801',3,'Tạm được','2025-06-30 03:25:37',NULL,23,'U-87fbb6d15ad548318110b60b797f84da','HOUSE-ceba29ae2440479085e22bac728678','ROOM-274d6b2a66fe419db0ed1b2585549e6'),('REVIEW-87fbb6d15ad548318110b60b802',4,'Nhà cực đẹp, ở siêu mê','2025-06-30 03:25:37',NULL,23,'U-87fbb6d15ad548318110b60b797f84da','HOUSE-ceba29ae2440479085e22bac728678','ROOM-913e90f2560e44718aff70306c9de49'),('REVIEW-87fbb6d15ad548318110b60b803',2,'Tồi tệ kinh khủng','2025-06-30 03:25:37',NULL,23,'U-87fbb6d15ad548318110b60b797f84da','HOUSE-f6502276ce6b4697b4173a16ae2962',NULL),('REVIEW-87fbb6d15ad548318110b60b804',4,'Nhà cực đẹp, ở siêu mê','2025-06-30 03:25:37',NULL,23,'U-87fbb6d15ad548318110b60b797f84da','HOUSE-f6502276ce6b4697b4173a16ae2962',NULL);
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
INSERT INTO `role_feature` VALUES (1,1,14),(1,2,14),(1,3,14),(1,4,14),(1,5,14),(1,6,14),(1,7,14),(1,8,14),(1,9,14),(1,10,14),(1,11,14),(1,12,14),(1,13,14),(1,14,14),(1,15,14),(1,16,14),(1,17,14),(1,18,14),(1,19,14),(1,20,14),(1,21,14),(1,22,14),(1,23,14),(1,24,14),(1,25,14),(1,26,14),(1,27,14),(1,28,14),(1,29,14),(1,30,14),(1,31,14),(1,32,14),(1,33,14),(1,34,14),(1,35,14),(1,36,14),(1,37,14),(1,38,14),(1,39,14),(1,42,14),(2,1,14),(2,2,14),(2,3,14),(2,4,14),(2,5,14),(2,10,14),(2,11,14),(2,14,14),(2,20,14),(2,24,14),(2,26,14),(2,27,14),(3,1,14),(3,2,14),(3,3,14),(3,4,14),(3,5,14),(3,6,14),(3,7,14),(3,8,14),(3,9,14),(3,10,14),(3,11,14),(3,12,14),(3,13,14),(3,14,14),(3,15,14),(3,16,14),(3,17,14),(3,18,14),(3,19,14),(3,20,14),(3,21,14),(3,22,14),(3,23,14),(3,24,14),(3,25,14),(3,26,14),(3,27,14),(3,33,14),(3,38,14),(3,39,14),(3,42,14),(5,1,14),(5,2,14),(5,3,14),(5,4,14),(5,5,14),(5,6,14),(5,7,14),(5,8,14),(5,9,14),(5,10,14),(5,11,14),(5,12,14),(5,13,14),(5,14,14),(5,15,14),(5,20,14),(5,24,14),(5,25,14),(5,26,14),(5,27,14),(5,33,14),(5,34,14),(5,37,14),(5,38,14),(5,39,14),(5,40,14),(5,41,14),(5,42,14);
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
INSERT INTO `room` VALUES ('ROOM-274d6b2a66fe419db0ed1b2585549e6','Thời gian Y','Y thời gian',4,2000000,'2025-06-29 01:08:12',NULL,'View biển','HOUSE-ceba29ae2440479085e22bac728678',26,4,10),('ROOM-913e90f2560e44718aff70306c9de49','Thời gian X','X thời gian',0,4000000,'2025-06-28 04:21:16',NULL,'View Biển','HOUSE-ceba29ae2440479085e22bac728678',26,10,12);
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
INSERT INTO `status` VALUES (21,'Active','image'),(1,'Active','user'),(6,'Available','homestay'),(26,'Available','room'),(4,'Banned','user'),(103,'Booked','room'),(10,'Cancelled','booking'),(28,'Cleaning','room'),(17,'Closed','event'),(5,'Closed','homestay'),(11,'Completed','booking'),(9,'Confirmed','booking'),(15,'Deleted','post'),(19,'Disabled','feature'),(18,'Enabled','feature'),(24,'Hidden','review'),(12,'In Vacation','booking'),(22,'Inactive','image'),(2,'Inactive','user'),(29,'On Used','room'),(16,'Open','event'),(8,'Pending','booking'),(3,'Pending Verification','user'),(20,'Private','post'),(25,'Private','review'),(23,'Public','review'),(14,'Published','post'),(7,'Unavailable','homestay'),(27,'Unavailable','room');
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
INSERT INTO `user` VALUES ('U-2bbd072d35884688ae41aa716475b5fa','Trong','Hien','2024-03-04','','TrongHien4032024','fcfbcf9b3e76ccfb6e3639d0758e44ccf74d0c0f946f23f7cfd10da5b38cb028','','hotronghien2k5@gmail.com','male','default-avatar.jpg','default-cover.jpg',NULL,'2025-06-30 05:53:26','2025-06-30 05:54:51',NULL,1,NULL,NULL,NULL,5,NULL,1),('U-87fbb6d15ad548318110b60b797f84da','Tam','Mai','2024-01-01','Hi Im Tam','TamMai1012024','fcfbcf9b3e76ccfb6e3639d0758e44ccf74d0c0f946f23f7cfd10da5b38cb028','','tammshe186670@fpt.edu.vn','male','1750298425624_U-87fbb6d15ad548318110b60b797f84da_avatar','default-cover.jpg',NULL,'2025-06-17 04:13:20','2025-06-19 02:00:26',NULL,1,'TOKEN-0a7874388fbf4d849355b1fc3b77e2e1','2025-06-17 04:13:21',NULL,3,NULL,1),('U-ab0c71c0b2fa412ea760eeb459dfab6e','Khanh','Huyen2','2025-01-01','','KhanhHuyen1012025','fcfbcf9b3e76ccfb6e3639d0758e44ccf74d0c0f946f23f7cfd10da5b38cb028','','huyennkhe182494@fpt.edu.vn','female','default-avatar.jpg','default-cover.jpg',NULL,'2025-06-16 02:25:20',NULL,NULL,1,'TOKEN-20cd9700899b4931a03f352d70a2f6b1','2025-06-16 02:25:20',NULL,5,NULL,1);
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

-- Dump completed on 2025-07-01  7:51:36
