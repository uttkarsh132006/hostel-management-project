CREATE DATABASE  IF NOT EXISTS `chenab_hostel_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `chenab_hostel_db`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: chenab_hostel_db
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance` (
  `attendance_id` bigint NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `attendance_date` date NOT NULL,
  `check_in_time` time DEFAULT NULL,
  `check_out_time` time DEFAULT NULL,
  `attendance_status` enum('PRESENT','ABSENT','LEAVE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `marked_by` int DEFAULT NULL,
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`attendance_id`),
  UNIQUE KEY `student_id` (`student_id`,`attendance_date`),
  KEY `marked_by` (`marked_by`),
  CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`marked_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES (1,1,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(2,2,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(3,3,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(4,4,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(5,5,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(6,6,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(7,7,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(8,8,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(9,9,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(10,10,'2025-09-10',NULL,NULL,'ABSENT',2,'Sample attendance data'),(11,11,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(12,12,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(13,13,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(14,14,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(15,15,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(16,16,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(17,17,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(18,18,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(19,19,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(20,20,'2025-09-10',NULL,NULL,'ABSENT',2,'Sample attendance data'),(21,21,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(22,22,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(23,23,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(24,24,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(25,25,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(26,26,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(27,27,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(28,28,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(29,29,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(30,30,'2025-09-10',NULL,NULL,'ABSENT',2,'Sample attendance data'),(31,31,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(32,32,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(33,33,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(34,34,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(35,35,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(36,36,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(37,37,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(38,38,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(39,39,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(40,40,'2025-09-10',NULL,NULL,'ABSENT',2,'Sample attendance data'),(41,41,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(42,42,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(43,43,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(44,44,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(45,45,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(46,46,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(47,47,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(48,48,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(49,49,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(50,50,'2025-09-10',NULL,NULL,'ABSENT',2,'Sample attendance data'),(51,51,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(52,52,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(53,53,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(54,54,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(55,55,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(56,56,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(57,57,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(58,58,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(59,59,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(60,60,'2025-09-10',NULL,NULL,'ABSENT',2,'Sample attendance data'),(61,61,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(62,62,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(63,63,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(64,64,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(65,65,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(66,66,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(67,67,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(68,68,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(69,69,'2025-09-10','21:00:00','06:30:00','PRESENT',2,'Sample attendance data'),(70,70,'2025-09-10',NULL,NULL,'ABSENT',2,'Sample attendance data'),(128,1,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(129,2,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(130,3,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(131,4,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(132,5,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(133,6,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(134,7,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(135,8,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(136,9,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(137,10,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(138,11,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(139,12,'2025-09-11',NULL,NULL,'LEAVE',2,'Sample attendance data'),(140,13,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(141,14,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(142,15,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(143,16,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(144,17,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(145,18,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(146,19,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(147,20,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(148,21,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(149,22,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(150,23,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(151,24,'2025-09-11',NULL,NULL,'LEAVE',2,'Sample attendance data'),(152,25,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(153,26,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(154,27,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(155,28,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(156,29,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(157,30,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(158,31,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(159,32,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(160,33,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(161,34,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(162,35,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(163,36,'2025-09-11',NULL,NULL,'LEAVE',2,'Sample attendance data'),(164,37,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(165,38,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(166,39,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(167,40,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(168,41,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(169,42,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(170,43,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(171,44,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(172,45,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(173,46,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(174,47,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(175,48,'2025-09-11',NULL,NULL,'LEAVE',2,'Sample attendance data'),(176,49,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(177,50,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(178,51,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(179,52,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(180,53,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(181,54,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(182,55,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(183,56,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(184,57,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(185,58,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(186,59,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(187,60,'2025-09-11',NULL,NULL,'LEAVE',2,'Sample attendance data'),(188,61,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(189,62,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(190,63,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(191,64,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(192,65,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(193,66,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(194,67,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(195,68,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(196,69,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data'),(197,70,'2025-09-11','21:15:00','06:45:00','PRESENT',2,'Sample attendance data');
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complaints`
--

DROP TABLE IF EXISTS `complaints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `complaints` (
  `complaint_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `assigned_staff_id` int DEFAULT NULL,
  `complaint_title` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `complaint_category` enum('ELECTRICAL','PLUMBING','CLEANLINESS','FURNITURE','INTERNET','OTHER') COLLATE utf8mb4_unicode_ci NOT NULL,
  `complaint_status` enum('OPEN','IN_PROGRESS','RESOLVED','REJECTED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'OPEN',
  `submitted_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `resolved_at` datetime DEFAULT NULL,
  PRIMARY KEY (`complaint_id`),
  KEY `student_id` (`student_id`),
  KEY `assigned_staff_id` (`assigned_staff_id`),
  CONSTRAINT `complaints_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  CONSTRAINT `complaints_ibfk_2` FOREIGN KEY (`assigned_staff_id`) REFERENCES `staff` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complaints`
--

LOCK TABLES `complaints` WRITE;
/*!40000 ALTER TABLE `complaints` DISABLE KEYS */;
INSERT INTO `complaints` VALUES (1,1,5,'Room light not working','Please inspect and resolve this hostel maintenance issue.','ELECTRICAL','IN_PROGRESS','2025-09-02 00:00:00',NULL),(2,2,2,'Wi-Fi connectivity issue','Please inspect and resolve this hostel maintenance issue.','INTERNET','OPEN','2025-09-03 00:00:00',NULL),(3,3,5,'Desk repair required','Please inspect and resolve this hostel maintenance issue.','FURNITURE','RESOLVED','2025-09-04 00:00:00','2025-09-08 00:00:00'),(4,4,2,'Room cleaning request','Please inspect and resolve this hostel maintenance issue.','CLEANLINESS','IN_PROGRESS','2025-09-05 00:00:00',NULL),(5,5,5,'Electrical socket issue','Please inspect and resolve this hostel maintenance issue.','ELECTRICAL','OPEN','2025-09-06 00:00:00',NULL),(6,6,2,'Bathroom tap leakage','Please inspect and resolve this hostel maintenance issue.','PLUMBING','RESOLVED','2025-09-07 00:00:00','2025-09-11 00:00:00'),(7,7,5,'Room light not working','Please inspect and resolve this hostel maintenance issue.','ELECTRICAL','IN_PROGRESS','2025-09-08 00:00:00',NULL),(8,8,2,'Wi-Fi connectivity issue','Please inspect and resolve this hostel maintenance issue.','INTERNET','OPEN','2025-09-09 00:00:00',NULL),(9,9,5,'Desk repair required','Please inspect and resolve this hostel maintenance issue.','FURNITURE','RESOLVED','2025-09-10 00:00:00','2025-09-14 00:00:00'),(10,10,2,'Room cleaning request','Please inspect and resolve this hostel maintenance issue.','CLEANLINESS','IN_PROGRESS','2025-09-11 00:00:00',NULL),(11,11,5,'Electrical socket issue','Please inspect and resolve this hostel maintenance issue.','ELECTRICAL','OPEN','2025-09-12 00:00:00',NULL),(12,12,2,'Bathroom tap leakage','Please inspect and resolve this hostel maintenance issue.','PLUMBING','RESOLVED','2025-09-13 00:00:00','2025-09-17 00:00:00'),(13,13,5,'Room light not working','Please inspect and resolve this hostel maintenance issue.','ELECTRICAL','IN_PROGRESS','2025-09-14 00:00:00',NULL),(14,14,2,'Wi-Fi connectivity issue','Please inspect and resolve this hostel maintenance issue.','INTERNET','OPEN','2025-09-15 00:00:00',NULL),(15,15,5,'Desk repair required','Please inspect and resolve this hostel maintenance issue.','FURNITURE','RESOLVED','2025-09-16 00:00:00','2025-09-20 00:00:00'),(16,16,2,'Room cleaning request','Please inspect and resolve this hostel maintenance issue.','CLEANLINESS','IN_PROGRESS','2025-09-17 00:00:00',NULL),(17,17,5,'Electrical socket issue','Please inspect and resolve this hostel maintenance issue.','ELECTRICAL','OPEN','2025-09-18 00:00:00',NULL),(18,18,2,'Bathroom tap leakage','Please inspect and resolve this hostel maintenance issue.','PLUMBING','RESOLVED','2025-09-19 00:00:00','2025-09-23 00:00:00');
/*!40000 ALTER TABLE `complaints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fee_records`
--

DROP TABLE IF EXISTS `fee_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fee_records` (
  `fee_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `academic_year` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fee_type` enum('HOSTEL','MESS','SECURITY_DEPOSIT','OTHER') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'HOSTEL',
  `amount_due` decimal(10,2) NOT NULL,
  `due_date` date NOT NULL,
  `fee_status` enum('UNPAID','PARTIAL','PAID') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'UNPAID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`fee_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `fee_records_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  CONSTRAINT `fee_records_chk_1` CHECK ((`amount_due` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fee_records`
--

LOCK TABLES `fee_records` WRITE;
/*!40000 ALTER TABLE `fee_records` DISABLE KEYS */;
INSERT INTO `fee_records` VALUES (1,1,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(2,2,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(3,3,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(4,4,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(5,5,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(6,6,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(7,7,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(8,8,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(9,9,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(10,10,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(11,11,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(12,12,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(13,13,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(14,14,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(15,15,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(16,16,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(17,17,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(18,18,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(19,19,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(20,20,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(21,21,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(22,22,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(23,23,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(24,24,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(25,25,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(26,26,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(27,27,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(28,28,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(29,29,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(30,30,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(31,31,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(32,32,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(33,33,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(34,34,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(35,35,'2025-2026','HOSTEL',42000.00,'2025-09-15','PARTIAL','2026-11-06 19:29:20'),(36,36,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(37,37,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(38,38,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(39,39,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(40,40,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(41,41,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(42,42,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(43,43,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(44,44,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(45,45,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(46,46,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(47,47,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(48,48,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(49,49,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(50,50,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(51,51,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(52,52,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(53,53,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(54,54,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(55,55,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(56,56,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(57,57,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(58,58,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(59,59,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(60,60,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(61,61,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(62,62,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(63,63,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(64,64,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(65,65,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(66,66,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(67,67,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(68,68,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(69,69,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20'),(70,70,'2025-2026','HOSTEL',42000.00,'2025-09-15','UNPAID','2026-11-06 19:29:20');
/*!40000 ALTER TABLE `fee_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hostels`
--

DROP TABLE IF EXISTS `hostels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hostels` (
  `hostel_id` int NOT NULL AUTO_INCREMENT,
  `hostel_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_number` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`hostel_id`),
  UNIQUE KEY `hostel_name` (`hostel_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostels`
--

LOCK TABLES `hostels` WRITE;
/*!40000 ALTER TABLE `hostels` DISABLE KEYS */;
INSERT INTO `hostels` VALUES (1,'Chenab Hostel','NIT Srinagar, Hazratbal, Srinagar','0194-XXXXXXX','2026-11-06 19:29:20');
/*!40000 ALTER TABLE `hostels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `fee_id` int NOT NULL,
  `amount_paid` decimal(10,2) NOT NULL,
  `payment_date` date NOT NULL,
  `payment_method` enum('CASH','UPI','BANK_TRANSFER','CARD') COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_reference` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `received_by` int DEFAULT NULL,
  `payment_status` enum('SUCCESS','PENDING','FAILED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'SUCCESS',
  PRIMARY KEY (`payment_id`),
  UNIQUE KEY `transaction_reference` (`transaction_reference`),
  KEY `fee_id` (`fee_id`),
  KEY `received_by` (`received_by`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`fee_id`) REFERENCES `fee_records` (`fee_id`),
  CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`received_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `payments_chk_1` CHECK ((`amount_paid` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,21000.00,'2025-09-10','BANK_TRANSFER','CHN202500001',2,'SUCCESS'),(2,2,21000.00,'2025-09-10','CASH','CHN202500002',2,'SUCCESS'),(3,3,21000.00,'2025-09-10','UPI','CHN202500003',2,'SUCCESS'),(4,4,21000.00,'2025-09-10','BANK_TRANSFER','CHN202500004',2,'SUCCESS'),(5,5,21000.00,'2025-09-10','CASH','CHN202500005',2,'SUCCESS'),(6,6,21000.00,'2025-09-10','UPI','CHN202500006',2,'SUCCESS'),(7,7,21000.00,'2025-09-10','BANK_TRANSFER','CHN202500007',2,'SUCCESS'),(8,8,21000.00,'2025-09-10','CASH','CHN202500008',2,'SUCCESS'),(9,9,21000.00,'2025-09-10','UPI','CHN202500009',2,'SUCCESS'),(10,10,21000.00,'2025-09-10','BANK_TRANSFER','CHN202500010',2,'SUCCESS'),(11,11,21000.00,'2025-09-10','CASH','CHN202500011',2,'SUCCESS'),(12,12,21000.00,'2025-09-10','UPI','CHN202500012',2,'SUCCESS'),(13,13,21000.00,'2025-09-10','BANK_TRANSFER','CHN202500013',2,'SUCCESS'),(14,14,21000.00,'2025-09-10','CASH','CHN202500014',2,'SUCCESS'),(15,15,21000.00,'2025-09-10','UPI','CHN202500015',2,'SUCCESS'),(16,16,21000.00,'2025-09-10','BANK_TRANSFER','CHN202500016',2,'SUCCESS'),(17,17,21000.00,'2025-09-10','CASH','CHN202500017',2,'SUCCESS'),(18,18,21000.00,'2025-09-10','UPI','CHN202500018',2,'SUCCESS'),(19,19,21000.00,'2025-09-10','BANK_TRANSFER','CHN202500019',2,'SUCCESS'),(20,20,21000.00,'2025-09-10','CASH','CHN202500020',2,'SUCCESS'),(21,21,21000.00,'2025-09-10','UPI','CHN202500021',2,'SUCCESS'),(22,22,21000.00,'2025-09-10','BANK_TRANSFER','CHN202500022',2,'SUCCESS'),(23,23,21000.00,'2025-09-10','CASH','CHN202500023',2,'SUCCESS'),(24,24,21000.00,'2025-09-10','UPI','CHN202500024',2,'SUCCESS'),(25,25,21000.00,'2025-09-10','BANK_TRANSFER','CHN202500025',2,'SUCCESS'),(26,26,21000.00,'2025-09-10','CASH','CHN202500026',2,'SUCCESS'),(27,27,21000.00,'2025-09-10','UPI','CHN202500027',2,'SUCCESS'),(28,28,21000.00,'2025-09-10','BANK_TRANSFER','CHN202500028',2,'SUCCESS'),(29,29,21000.00,'2025-09-10','CASH','CHN202500029',2,'SUCCESS'),(30,30,21000.00,'2025-09-10','UPI','CHN202500030',2,'SUCCESS'),(31,31,21000.00,'2025-09-10','BANK_TRANSFER','CHN202500031',2,'SUCCESS'),(32,32,21000.00,'2025-09-10','CASH','CHN202500032',2,'SUCCESS'),(33,33,21000.00,'2025-09-10','UPI','CHN202500033',2,'SUCCESS'),(34,34,21000.00,'2025-09-10','BANK_TRANSFER','CHN202500034',2,'SUCCESS'),(35,35,21000.00,'2025-09-10','CASH','CHN202500035',2,'SUCCESS');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_update_fee_status_after_payment` AFTER INSERT ON `payments` FOR EACH ROW BEGIN
    IF NEW.payment_status = 'SUCCESS' THEN
        UPDATE fee_records f
        SET f.fee_status = CASE
            WHEN (SELECT COALESCE(SUM(p.amount_paid), 0)
                  FROM payments p
                  WHERE p.fee_id = NEW.fee_id
                    AND p.payment_status = 'SUCCESS') >= f.amount_due
                THEN 'PAID'
            WHEN (SELECT COALESCE(SUM(p.amount_paid), 0)
                  FROM payments p
                  WHERE p.fee_id = NEW.fee_id
                    AND p.payment_status = 'SUCCESS') > 0
                THEN 'PARTIAL'
            ELSE 'UNPAID'
        END
        WHERE f.fee_id = NEW.fee_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `room_allocations`
--

DROP TABLE IF EXISTS `room_allocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_allocations` (
  `allocation_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `room_id` int NOT NULL,
  `allocated_by` int DEFAULT NULL,
  `allocation_date` date NOT NULL,
  `vacated_date` date DEFAULT NULL,
  `allocation_status` enum('ACTIVE','COMPLETED','CANCELLED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `active_student_id` int GENERATED ALWAYS AS ((case when (`allocation_status` = _utf8mb4'ACTIVE') then `student_id` else NULL end)) STORED,
  PRIMARY KEY (`allocation_id`),
  UNIQUE KEY `active_student_id` (`active_student_id`),
  KEY `student_id` (`student_id`),
  KEY `room_id` (`room_id`),
  KEY `allocated_by` (`allocated_by`),
  CONSTRAINT `room_allocations_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  CONSTRAINT `room_allocations_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`),
  CONSTRAINT `room_allocations_ibfk_3` FOREIGN KEY (`allocated_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `room_allocations_chk_1` CHECK (((`vacated_date` is null) or (`vacated_date` >= `allocation_date`)))
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_allocations`
--

LOCK TABLES `room_allocations` WRITE;
/*!40000 ALTER TABLE `room_allocations` DISABLE KEYS */;
INSERT INTO `room_allocations` (`allocation_id`, `student_id`, `room_id`, `allocated_by`, `allocation_date`, `vacated_date`, `allocation_status`) VALUES (1,1,1,2,'2025-08-05',NULL,'ACTIVE'),(2,2,1,2,'2025-08-05',NULL,'ACTIVE'),(3,3,1,2,'2025-08-05',NULL,'ACTIVE'),(4,4,2,2,'2025-08-05',NULL,'ACTIVE'),(5,5,2,2,'2025-08-05',NULL,'ACTIVE'),(6,6,2,2,'2025-08-05',NULL,'ACTIVE'),(7,7,3,2,'2025-08-05',NULL,'ACTIVE'),(8,8,3,2,'2025-08-05',NULL,'ACTIVE'),(9,9,3,2,'2025-08-05',NULL,'ACTIVE'),(10,10,4,2,'2025-08-05',NULL,'ACTIVE'),(11,11,4,2,'2025-08-05',NULL,'ACTIVE'),(12,12,4,2,'2025-08-05',NULL,'ACTIVE'),(13,13,5,2,'2025-08-05',NULL,'ACTIVE'),(14,14,5,2,'2025-08-05',NULL,'ACTIVE'),(15,15,5,2,'2025-08-05',NULL,'ACTIVE'),(16,16,6,2,'2025-08-05',NULL,'ACTIVE'),(17,17,6,2,'2025-08-05',NULL,'ACTIVE'),(18,18,6,2,'2025-08-05',NULL,'ACTIVE'),(19,19,7,2,'2025-08-05',NULL,'ACTIVE'),(20,20,7,2,'2025-08-05',NULL,'ACTIVE'),(21,21,7,2,'2025-08-05',NULL,'ACTIVE'),(22,22,8,2,'2025-08-05',NULL,'ACTIVE'),(23,23,8,2,'2025-08-05',NULL,'ACTIVE'),(24,24,8,2,'2025-08-05',NULL,'ACTIVE'),(25,25,9,2,'2025-08-05',NULL,'ACTIVE'),(26,26,9,2,'2025-08-05',NULL,'ACTIVE'),(27,27,9,2,'2025-08-05',NULL,'ACTIVE'),(28,28,10,2,'2025-08-05',NULL,'ACTIVE'),(29,29,10,2,'2025-08-05',NULL,'ACTIVE'),(30,30,10,2,'2025-08-05',NULL,'ACTIVE'),(31,31,11,2,'2025-08-05',NULL,'ACTIVE'),(32,32,11,2,'2025-08-05',NULL,'ACTIVE'),(33,33,11,2,'2025-08-05',NULL,'ACTIVE'),(34,34,12,2,'2025-08-05',NULL,'ACTIVE'),(35,35,12,2,'2025-08-05',NULL,'ACTIVE'),(36,36,12,2,'2025-08-05',NULL,'ACTIVE'),(37,37,13,2,'2025-08-05',NULL,'ACTIVE'),(38,38,13,2,'2025-08-05',NULL,'ACTIVE'),(39,39,13,2,'2025-08-05',NULL,'ACTIVE'),(40,40,14,2,'2025-08-05',NULL,'ACTIVE'),(41,41,14,2,'2025-08-05',NULL,'ACTIVE'),(42,42,14,2,'2025-08-05',NULL,'ACTIVE'),(43,43,15,2,'2025-08-05',NULL,'ACTIVE'),(44,44,15,2,'2025-08-05',NULL,'ACTIVE'),(45,45,15,2,'2025-08-05',NULL,'ACTIVE'),(46,46,16,2,'2025-08-05',NULL,'ACTIVE'),(47,47,16,2,'2025-08-05',NULL,'ACTIVE'),(48,48,16,2,'2025-08-05',NULL,'ACTIVE'),(49,49,17,2,'2025-08-05',NULL,'ACTIVE'),(50,50,17,2,'2025-08-05',NULL,'ACTIVE'),(51,51,17,2,'2025-08-05',NULL,'ACTIVE'),(52,52,18,2,'2025-08-05',NULL,'ACTIVE'),(53,53,18,2,'2025-08-05',NULL,'ACTIVE'),(54,54,18,2,'2025-08-05',NULL,'ACTIVE'),(55,55,19,2,'2025-08-05',NULL,'ACTIVE'),(56,56,19,2,'2025-08-05',NULL,'ACTIVE'),(57,57,19,2,'2025-08-05',NULL,'ACTIVE'),(58,58,20,2,'2025-08-05',NULL,'ACTIVE'),(59,59,20,2,'2025-08-05',NULL,'ACTIVE'),(60,60,20,2,'2025-08-05',NULL,'ACTIVE'),(61,61,21,2,'2025-08-05',NULL,'ACTIVE'),(62,62,21,2,'2025-08-05',NULL,'ACTIVE'),(63,63,21,2,'2025-08-05',NULL,'ACTIVE'),(64,64,22,2,'2025-08-05',NULL,'ACTIVE'),(65,65,22,2,'2025-08-05',NULL,'ACTIVE'),(66,66,22,2,'2025-08-05',NULL,'ACTIVE'),(67,67,23,2,'2025-08-05',NULL,'ACTIVE'),(68,68,23,2,'2025-08-05',NULL,'ACTIVE'),(69,69,23,2,'2025-08-05',NULL,'ACTIVE'),(70,70,24,2,'2025-08-05',NULL,'ACTIVE');
/*!40000 ALTER TABLE `room_allocations` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_check_room_capacity` BEFORE INSERT ON `room_allocations` FOR EACH ROW BEGIN
    DECLARE current_count INT DEFAULT 0;
    DECLARE room_capacity INT DEFAULT 0;

    IF NEW.allocation_status = 'ACTIVE' THEN
        SELECT capacity INTO room_capacity
        FROM rooms WHERE room_id = NEW.room_id;

        SELECT COUNT(*) INTO current_count
        FROM room_allocations
        WHERE room_id = NEW.room_id
          AND allocation_status = 'ACTIVE';

        IF current_count >= room_capacity THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Room capacity exceeded';
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_check_room_capacity_update` BEFORE UPDATE ON `room_allocations` FOR EACH ROW BEGIN
    DECLARE current_count INT DEFAULT 0;
    DECLARE room_capacity INT DEFAULT 0;

    IF NEW.allocation_status = 'ACTIVE'
       AND (OLD.allocation_status <> 'ACTIVE' OR OLD.room_id <> NEW.room_id) THEN
        SELECT capacity INTO room_capacity
        FROM rooms WHERE room_id = NEW.room_id;

        SELECT COUNT(*) INTO current_count
        FROM room_allocations
        WHERE room_id = NEW.room_id
          AND allocation_status = 'ACTIVE'
          AND allocation_id <> OLD.allocation_id;

        IF current_count >= room_capacity THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Room capacity exceeded';
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `room_id` int NOT NULL AUTO_INCREMENT,
  `hostel_id` int NOT NULL,
  `room_number` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `floor_number` tinyint NOT NULL,
  `capacity` tinyint NOT NULL,
  `room_type` enum('STANDARD','DELUXE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'STANDARD',
  `monthly_fee` decimal(10,2) NOT NULL DEFAULT '3500.00',
  `room_status` enum('AVAILABLE','MAINTENANCE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'AVAILABLE',
  PRIMARY KEY (`room_id`),
  UNIQUE KEY `hostel_id` (`hostel_id`,`room_number`),
  CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`hostel_id`) REFERENCES `hostels` (`hostel_id`),
  CONSTRAINT `rooms_chk_1` CHECK ((`capacity` between 1 and 6)),
  CONSTRAINT `rooms_chk_2` CHECK ((`monthly_fee` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (1,1,'C101',1,4,'STANDARD',3500.00,'AVAILABLE'),(2,1,'C102',1,4,'STANDARD',3500.00,'AVAILABLE'),(3,1,'C103',1,3,'STANDARD',3500.00,'AVAILABLE'),(4,1,'C104',1,4,'STANDARD',3500.00,'AVAILABLE'),(5,1,'C105',1,4,'STANDARD',3500.00,'AVAILABLE'),(6,1,'C106',1,3,'STANDARD',3500.00,'AVAILABLE'),(7,1,'C107',1,4,'STANDARD',3500.00,'AVAILABLE'),(8,1,'C108',1,4,'DELUXE',4000.00,'AVAILABLE'),(9,1,'C109',2,3,'STANDARD',3500.00,'AVAILABLE'),(10,1,'C110',2,4,'STANDARD',3500.00,'AVAILABLE'),(11,1,'C111',2,4,'STANDARD',3500.00,'AVAILABLE'),(12,1,'C112',2,3,'STANDARD',3500.00,'AVAILABLE'),(13,1,'C113',2,4,'STANDARD',3500.00,'AVAILABLE'),(14,1,'C114',2,4,'STANDARD',3500.00,'AVAILABLE'),(15,1,'C115',2,3,'STANDARD',3500.00,'AVAILABLE'),(16,1,'C116',2,4,'DELUXE',4000.00,'AVAILABLE'),(17,1,'C117',3,4,'STANDARD',3500.00,'AVAILABLE'),(18,1,'C118',3,3,'STANDARD',3500.00,'AVAILABLE'),(19,1,'C119',3,4,'STANDARD',3500.00,'AVAILABLE'),(20,1,'C120',3,4,'STANDARD',3500.00,'AVAILABLE'),(21,1,'C121',3,3,'STANDARD',3500.00,'AVAILABLE'),(22,1,'C122',3,4,'STANDARD',3500.00,'AVAILABLE'),(23,1,'C123',3,4,'STANDARD',3500.00,'AVAILABLE'),(24,1,'C124',3,3,'DELUXE',4000.00,'AVAILABLE'),(25,1,'C125',4,4,'STANDARD',3500.00,'AVAILABLE');
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `hostel_id` int NOT NULL,
  `full_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `designation` enum('WARDEN','CARETAKER','SECURITY','CLEANER','ELECTRICIAN','OTHER') COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_joined` date NOT NULL,
  `employment_status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `hostel_id` (`hostel_id`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `staff_ibfk_2` FOREIGN KEY (`hostel_id`) REFERENCES `hostels` (`hostel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,2,1,'Mr. Imtiyaz Ahmad','WARDEN','9900000001','warden.chenab@example.edu','2024-04-01','ACTIVE'),(2,NULL,1,'Bilal Ahmed','CARETAKER','9900000002','bilal.chenab@example.edu','2024-05-10','ACTIVE'),(3,NULL,1,'Rafiq Hussain','SECURITY','9900000003','rafiq.chenab@example.edu','2024-06-15','ACTIVE'),(4,NULL,1,'Shabir Dar','CLEANER','9900000004','shabir.chenab@example.edu','2024-06-15','ACTIVE'),(5,NULL,1,'Aamir Bhat','ELECTRICIAN','9900000005','aamir.chenab@example.edu','2024-07-01','ACTIVE');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `student_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `enrolment_no` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch` enum('CSE','MME','MEC','ITE','CIV','ECE','ELE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_phone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admission_date` date NOT NULL,
  `hostel_id` int NOT NULL,
  `student_status` enum('ACTIVE','INACTIVE','GRADUATED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `enrolment_no` (`enrolment_no`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_student_hostel` (`hostel_id`),
  CONSTRAINT `fk_student_hostel` FOREIGN KEY (`hostel_id`) REFERENCES `hostels` (`hostel_id`),
  CONSTRAINT `fk_student_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `chk_enrolment_format` CHECK (regexp_like(`enrolment_no`,_utf8mb4'^2025B(CSE|MME|MEC|ITE|CIV|ECE|ELE)[0-9]{4}$'))
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,3,'2025BCSE0994','Soaib Khan','CSE','2025bcse0994@student.nitsri.ac.in','9786579303','9726563708','2025-08-01',1,'ACTIVE'),(2,4,'2025BMME0002','Vivek Lone','MME','2025bmme0002@student.nitsri.ac.in','9126855092','9528853029','2025-08-03',1,'ACTIVE'),(3,5,'2025BMEC0003','Aisha Kumar','MEC','2025bmec0003@student.nitsri.ac.in','9395310485','9488690725','2025-08-01',1,'ACTIVE'),(4,6,'2025BITE0004','Ira Singh','ITE','2025bite0004@student.nitsri.ac.in','9339670711','9335493870','2025-08-01',1,'ACTIVE'),(5,7,'2025BCIV0005','Riya Verma','CIV','2025bciv0005@student.nitsri.ac.in','9890779946','9248532577','2025-08-01',1,'ACTIVE'),(6,8,'2025BECE0006','Farhan Qureshi','ECE','2025bece0006@student.nitsri.ac.in','9826600539','9647099690','2025-08-03',1,'ACTIVE'),(7,9,'2025BELE0007','Umar Bhat','ELE','2025bele0007@student.nitsri.ac.in','9685582861','9629908599','2025-08-01',1,'ACTIVE'),(8,10,'2025BCSE0008','Imran Raina','CSE','2025bcse0008@student.nitsri.ac.in','9734036506','9197613238','2025-08-02',1,'ACTIVE'),(9,11,'2025BMME0009','Taha Rathore','MME','2025bmme0009@student.nitsri.ac.in','9134126396','9911514914','2025-08-01',1,'ACTIVE'),(10,12,'2025BMEC0010','Kavya Dar','MEC','2025bmec0010@student.nitsri.ac.in','9200604502','9150590821','2025-08-01',1,'ACTIVE'),(11,13,'2025BITE0011','Sahil Wani','ITE','2025bite0011@student.nitsri.ac.in','9349817734','9217734861','2025-08-03',1,'ACTIVE'),(12,14,'2025BCIV0012','Arif Sofi','CIV','2025bciv0012@student.nitsri.ac.in','9746412689','9264112119','2025-08-01',1,'ACTIVE'),(13,15,'2025BECE0013','Ayaan Mir','ECE','2025bece0013@student.nitsri.ac.in','9702632297','9773715057','2025-08-01',1,'ACTIVE'),(14,16,'2025BELE0014','Ishaan Hussain','ELE','2025bele0014@student.nitsri.ac.in','9868820204','9271779360','2025-08-03',1,'ACTIVE'),(15,17,'2025BCSE0015','Rohan Sharma','CSE','2025bcse0015@student.nitsri.ac.in','9853041955','9950488739','2025-08-03',1,'ACTIVE'),(16,18,'2025BMME0016','Ananya Ahmed','MME','2025bmme0016@student.nitsri.ac.in','9550455977','9830661141','2025-08-01',1,'ACTIVE'),(17,19,'2025BMEC0017','Sneha Malik','MEC','2025bmec0017@student.nitsri.ac.in','9582334538','9553290810','2025-08-03',1,'ACTIVE'),(18,20,'2025BITE0018','Sana Khan','ITE','2025bite0018@student.nitsri.ac.in','9398704996','9740389325','2025-08-01',1,'ACTIVE'),(19,21,'2025BCIV0019','Zoya Rather','CIV','2025bciv0019@student.nitsri.ac.in','9914763202','9168212356','2025-08-01',1,'ACTIVE'),(20,22,'2025BECE0020','Sameer Chopra','ECE','2025bece0020@student.nitsri.ac.in','9849621470','9513140753','2025-08-02',1,'ACTIVE'),(21,23,'2025BELE0021','Rehan Gupta','ELE','2025bele0021@student.nitsri.ac.in','9465341213','9509760584','2025-08-02',1,'ACTIVE'),(22,24,'2025BCSE0022','Bilal Lone','CSE','2025bcse0022@student.nitsri.ac.in','9266944844','9739830322','2025-08-01',1,'ACTIVE'),(23,25,'2025BMME0023','Pooja Kumar','MME','2025bmme0023@student.nitsri.ac.in','9919795579','9602564736','2025-08-02',1,'ACTIVE'),(24,26,'2025BMEC0024','Ibrahim Singh','MEC','2025bmec0024@student.nitsri.ac.in','9209747451','9668132202','2025-08-01',1,'ACTIVE'),(25,27,'2025BITE0025','Musa Verma','ITE','2025bite0025@student.nitsri.ac.in','9507943839','9369953851','2025-08-01',1,'ACTIVE'),(26,28,'2025BCIV0026','Aarav Qureshi','CIV','2025bciv0026@student.nitsri.ac.in','9485451171','9694021782','2025-08-02',1,'ACTIVE'),(27,29,'2025BECE0027','Arjun Bhat','ECE','2025bece0027@student.nitsri.ac.in','9748245888','9112327652','2025-08-02',1,'ACTIVE'),(28,30,'2025BELE0028','Rahul Raina','ELE','2025bele0028@student.nitsri.ac.in','9966647391','9830448745','2025-08-01',1,'ACTIVE'),(29,31,'2025BCSE0029','Karan Rathore','CSE','2025bcse0029@student.nitsri.ac.in','9883543540','9873869166','2025-08-02',1,'ACTIVE'),(30,32,'2025BMME0030','Priya Dar','MME','2025bmme0030@student.nitsri.ac.in','9675770529','9222998994','2025-08-01',1,'ACTIVE'),(31,33,'2025BMEC0031','Meera Wani','MEC','2025bmec0031@student.nitsri.ac.in','9506448196','9831980933','2025-08-01',1,'ACTIVE'),(32,34,'2025BITE0032','Nisha Sofi','ITE','2025bite0032@student.nitsri.ac.in','9692749116','9676567501','2025-08-02',1,'ACTIVE'),(33,35,'2025BCIV0033','Danish Mir','CIV','2025bciv0033@student.nitsri.ac.in','9990566476','9906248900','2025-08-03',1,'ACTIVE'),(34,36,'2025BECE0034','Hamza Hussain','ECE','2025bece0034@student.nitsri.ac.in','9764130526','9386501362','2025-08-02',1,'ACTIVE'),(35,37,'2025BELE0035','Yusuf Sharma','ELE','2025bele0035@student.nitsri.ac.in','9719927151','9925276600','2025-08-01',1,'ACTIVE'),(36,38,'2025BCSE0036','Neha Ahmed','CSE','2025bcse0036@student.nitsri.ac.in','9856528252','9788227492','2025-08-01',1,'ACTIVE'),(37,39,'2025BMME0037','Simran Malik','MME','2025bmme0037@student.nitsri.ac.in','9149203558','9465260635','2025-08-03',1,'ACTIVE'),(38,40,'2025BMEC0038','Faizan Khan','MEC','2025bmec0038@student.nitsri.ac.in','9344703907','9219778234','2025-08-02',1,'ACTIVE'),(39,41,'2025BITE0039','Zain Rather','ITE','2025bite0039@student.nitsri.ac.in','9185675980','9415143362','2025-08-01',1,'ACTIVE'),(40,42,'2025BCIV0040','Aditya Chopra','CIV','2025bciv0040@student.nitsri.ac.in','9208449460','9566825638','2025-08-02',1,'ACTIVE'),(41,43,'2025BECE0041','Kabir Gupta','ECE','2025bece0041@student.nitsri.ac.in','9398471886','9269820594','2025-08-02',1,'ACTIVE'),(42,44,'2025BELE0042','Vivek Lone','ELE','2025bele0042@student.nitsri.ac.in','9782560971','9587182120','2025-08-02',1,'ACTIVE'),(43,45,'2025BCSE0043','Aisha Kumar','CSE','2025bcse0043@student.nitsri.ac.in','9274648506','9103484630','2025-08-02',1,'ACTIVE'),(44,46,'2025BMME0044','Ira Singh','MME','2025bmme0044@student.nitsri.ac.in','9481469012','9875340444','2025-08-01',1,'ACTIVE'),(45,47,'2025BMEC0045','Riya Verma','MEC','2025bmec0045@student.nitsri.ac.in','9819595113','9872751234','2025-08-02',1,'ACTIVE'),(46,48,'2025BITE0046','Farhan Qureshi','ITE','2025bite0046@student.nitsri.ac.in','9853573823','9382811832','2025-08-03',1,'ACTIVE'),(47,49,'2025BCIV0047','Umar Bhat','CIV','2025bciv0047@student.nitsri.ac.in','9795822698','9637500247','2025-08-01',1,'ACTIVE'),(48,50,'2025BECE0048','Imran Raina','ECE','2025bece0048@student.nitsri.ac.in','9754049436','9918150683','2025-08-03',1,'ACTIVE'),(49,51,'2025BELE0049','Taha Rathore','ELE','2025bele0049@student.nitsri.ac.in','9283758720','9291825997','2025-08-03',1,'ACTIVE'),(50,52,'2025BCSE0050','Kavya Dar','CSE','2025bcse0050@student.nitsri.ac.in','9882893941','9645119047','2025-08-01',1,'ACTIVE'),(51,53,'2025BMME0051','Sahil Wani','MME','2025bmme0051@student.nitsri.ac.in','9275452091','9214257751','2025-08-02',1,'ACTIVE'),(52,54,'2025BMEC0052','Arif Sofi','MEC','2025bmec0052@student.nitsri.ac.in','9507437181','9771410971','2025-08-02',1,'ACTIVE'),(53,55,'2025BITE0053','Ayaan Mir','ITE','2025bite0053@student.nitsri.ac.in','9787194506','9420452650','2025-08-03',1,'ACTIVE'),(54,56,'2025BCIV0054','Ishaan Hussain','CIV','2025bciv0054@student.nitsri.ac.in','9698020238','9786066793','2025-08-01',1,'ACTIVE'),(55,57,'2025BECE0055','Rohan Sharma','ECE','2025bece0055@student.nitsri.ac.in','9835098955','9645098869','2025-08-02',1,'ACTIVE'),(56,58,'2025BELE0056','Ananya Ahmed','ELE','2025bele0056@student.nitsri.ac.in','9924970419','9753876785','2025-08-01',1,'ACTIVE'),(57,59,'2025BCSE0057','Sneha Malik','CSE','2025bcse0057@student.nitsri.ac.in','9345938494','9313579170','2025-08-01',1,'ACTIVE'),(58,60,'2025BMME0058','Sana Khan','MME','2025bmme0058@student.nitsri.ac.in','9964411347','9264109919','2025-08-02',1,'ACTIVE'),(59,61,'2025BMEC0059','Zoya Rather','MEC','2025bmec0059@student.nitsri.ac.in','9530747414','9501486939','2025-08-02',1,'ACTIVE'),(60,62,'2025BITE0060','Sameer Chopra','ITE','2025bite0060@student.nitsri.ac.in','9171069472','9918739736','2025-08-01',1,'ACTIVE'),(61,63,'2025BCIV0061','Rehan Gupta','CIV','2025bciv0061@student.nitsri.ac.in','9709004943','9273461957','2025-08-03',1,'ACTIVE'),(62,64,'2025BECE0062','Bilal Lone','ECE','2025bece0062@student.nitsri.ac.in','9437882805','9679153816','2025-08-01',1,'ACTIVE'),(63,65,'2025BELE0063','Pooja Kumar','ELE','2025bele0063@student.nitsri.ac.in','9803771909','9936043811','2025-08-02',1,'ACTIVE'),(64,66,'2025BCSE0064','Ibrahim Singh','CSE','2025bcse0064@student.nitsri.ac.in','9524806516','9669462919','2025-08-03',1,'ACTIVE'),(65,67,'2025BMME0065','Musa Verma','MME','2025bmme0065@student.nitsri.ac.in','9592688426','9100614068','2025-08-01',1,'ACTIVE'),(66,68,'2025BMEC0066','Aarav Qureshi','MEC','2025bmec0066@student.nitsri.ac.in','9384412919','9743111853','2025-08-01',1,'ACTIVE'),(67,69,'2025BITE0067','Arjun Bhat','ITE','2025bite0067@student.nitsri.ac.in','9364814270','9448059918','2025-08-03',1,'ACTIVE'),(68,70,'2025BCIV0068','Rahul Raina','CIV','2025bciv0068@student.nitsri.ac.in','9702764446','9624636385','2025-08-03',1,'ACTIVE'),(69,71,'2025BECE0069','Karan Rathore','ECE','2025bece0069@student.nitsri.ac.in','9382116655','9120912992','2025-08-03',1,'ACTIVE'),(70,72,'2025BELE0070','Priya Dar','ELE','2025bele0070@student.nitsri.ac.in','9727694430','9220117054','2025-08-02',1,'ACTIVE');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('ADMIN','STUDENT','WARDEN') COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2b$10$xOX/plIzxZ8MIobc6wrmXenUljyQ17iygDI2F5wNKYsP0pNkKOYYu','ADMIN',1,'2026-11-06 19:29:20'),(2,'warden','REPLACE_WITH_BCRYPT_HASH','WARDEN',1,'2026-11-06 19:29:20'),(3,'2025bcse0994','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(4,'2025bmme0002','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(5,'2025bmec0003','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(6,'2025bite0004','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(7,'2025bciv0005','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(8,'2025bece0006','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(9,'2025bele0007','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(10,'2025bcse0008','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(11,'2025bmme0009','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(12,'2025bmec0010','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(13,'2025bite0011','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(14,'2025bciv0012','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(15,'2025bece0013','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(16,'2025bele0014','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(17,'2025bcse0015','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(18,'2025bmme0016','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(19,'2025bmec0017','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(20,'2025bite0018','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(21,'2025bciv0019','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(22,'2025bece0020','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(23,'2025bele0021','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(24,'2025bcse0022','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(25,'2025bmme0023','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(26,'2025bmec0024','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(27,'2025bite0025','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(28,'2025bciv0026','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(29,'2025bece0027','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(30,'2025bele0028','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(31,'2025bcse0029','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(32,'2025bmme0030','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(33,'2025bmec0031','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(34,'2025bite0032','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(35,'2025bciv0033','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(36,'2025bece0034','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(37,'2025bele0035','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(38,'2025bcse0036','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(39,'2025bmme0037','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(40,'2025bmec0038','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(41,'2025bite0039','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(42,'2025bciv0040','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(43,'2025bece0041','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(44,'2025bele0042','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(45,'2025bcse0043','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(46,'2025bmme0044','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(47,'2025bmec0045','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(48,'2025bite0046','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(49,'2025bciv0047','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(50,'2025bece0048','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(51,'2025bele0049','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(52,'2025bcse0050','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(53,'2025bmme0051','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(54,'2025bmec0052','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(55,'2025bite0053','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(56,'2025bciv0054','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(57,'2025bece0055','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(58,'2025bele0056','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(59,'2025bcse0057','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(60,'2025bmme0058','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(61,'2025bmec0059','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(62,'2025bite0060','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(63,'2025bciv0061','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(64,'2025bece0062','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(65,'2025bele0063','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(66,'2025bcse0064','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(67,'2025bmme0065','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(68,'2025bmec0066','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(69,'2025bite0067','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(70,'2025bciv0068','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(71,'2025bece0069','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20'),(72,'2025bele0070','REPLACE_WITH_BCRYPT_HASH','STUDENT',1,'2026-11-06 19:29:20');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_fee_balance`
--

DROP TABLE IF EXISTS `v_fee_balance`;
/*!50001 DROP VIEW IF EXISTS `v_fee_balance`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_fee_balance` AS SELECT 
 1 AS `fee_id`,
 1 AS `enrolment_no`,
 1 AS `full_name`,
 1 AS `academic_year`,
 1 AS `fee_type`,
 1 AS `amount_due`,
 1 AS `amount_paid`,
 1 AS `balance`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_student_room_details`
--

DROP TABLE IF EXISTS `v_student_room_details`;
/*!50001 DROP VIEW IF EXISTS `v_student_room_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_student_room_details` AS SELECT 
 1 AS `student_id`,
 1 AS `enrolment_no`,
 1 AS `full_name`,
 1 AS `branch`,
 1 AS `hostel_name`,
 1 AS `room_number`,
 1 AS `allocation_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'chenab_hostel_db'
--

--
-- Dumping routines for database 'chenab_hostel_db'
--
/*!50003 DROP PROCEDURE IF EXISTS `AllocateStudentToRoom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AllocateStudentToRoom`(
    IN p_enrolment_no VARCHAR(20),
    IN p_room_number VARCHAR(10),
    IN p_allocated_by INT
)
BEGIN
    DECLARE v_student_id INT DEFAULT NULL;
    DECLARE v_room_id INT DEFAULT NULL;

    SELECT student_id INTO v_student_id
    FROM students
    WHERE enrolment_no = p_enrolment_no
    LIMIT 1;

    SELECT room_id INTO v_room_id
    FROM rooms
    WHERE room_number = p_room_number
      AND hostel_id = 1
    LIMIT 1;

    IF v_student_id IS NULL OR v_room_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student or room not found';
    END IF;

    INSERT INTO room_allocations
    (student_id, room_id, allocated_by, allocation_date, allocation_status)
    VALUES
    (v_student_id, v_room_id, p_allocated_by, CURDATE(), 'ACTIVE');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_fee_balance`
--

/*!50001 DROP VIEW IF EXISTS `v_fee_balance`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_fee_balance` AS select `f`.`fee_id` AS `fee_id`,`s`.`enrolment_no` AS `enrolment_no`,`s`.`full_name` AS `full_name`,`f`.`academic_year` AS `academic_year`,`f`.`fee_type` AS `fee_type`,`f`.`amount_due` AS `amount_due`,coalesce(sum((case when (`p`.`payment_status` = 'SUCCESS') then `p`.`amount_paid` else 0 end)),0) AS `amount_paid`,(`f`.`amount_due` - coalesce(sum((case when (`p`.`payment_status` = 'SUCCESS') then `p`.`amount_paid` else 0 end)),0)) AS `balance` from ((`fee_records` `f` join `students` `s` on((`s`.`student_id` = `f`.`student_id`))) left join `payments` `p` on((`p`.`fee_id` = `f`.`fee_id`))) group by `f`.`fee_id`,`s`.`enrolment_no`,`s`.`full_name`,`f`.`academic_year`,`f`.`fee_type`,`f`.`amount_due` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_student_room_details`
--

/*!50001 DROP VIEW IF EXISTS `v_student_room_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_student_room_details` AS select `s`.`student_id` AS `student_id`,`s`.`enrolment_no` AS `enrolment_no`,`s`.`full_name` AS `full_name`,`s`.`branch` AS `branch`,`h`.`hostel_name` AS `hostel_name`,`r`.`room_number` AS `room_number`,`ra`.`allocation_date` AS `allocation_date` from (((`students` `s` join `hostels` `h` on((`h`.`hostel_id` = `s`.`hostel_id`))) left join `room_allocations` `ra` on(((`ra`.`student_id` = `s`.`student_id`) and (`ra`.`allocation_status` = 'ACTIVE')))) left join `rooms` `r` on((`r`.`room_id` = `ra`.`room_id`))) */;
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

-- Dump completed on 2026-11-07 16:20:08
