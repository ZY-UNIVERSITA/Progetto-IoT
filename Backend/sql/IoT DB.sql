CREATE DATABASE  IF NOT EXISTS `sensori_iot` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sensori_iot`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sensori_iot
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `letture`
--

DROP TABLE IF EXISTS `letture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `letture` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sensore_id` int NOT NULL,
  `temperatura` decimal(4,2) NOT NULL,
  `umidita` decimal(4,2) NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `sensore_id` (`sensore_id`),
  CONSTRAINT `letture_ibfk_1` FOREIGN KEY (`sensore_id`) REFERENCES `sensori` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=877 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `letture`
--

LOCK TABLES `letture` WRITE;
/*!40000 ALTER TABLE `letture` DISABLE KEYS */;
INSERT INTO `letture` VALUES (615,0,24.00,4.50,'2025-01-08 09:47:32'),(616,1,24.00,30.00,'2025-01-08 09:47:33'),(617,0,24.00,4.50,'2025-01-08 09:47:34'),(618,1,24.00,30.00,'2025-01-08 09:47:35'),(619,0,24.00,4.50,'2025-01-08 09:47:37'),(620,1,24.00,30.00,'2025-01-08 09:47:37'),(621,0,24.00,4.50,'2025-01-08 09:47:39'),(622,1,24.00,30.00,'2025-01-08 09:47:39'),(623,0,24.00,4.50,'2025-01-08 09:47:41'),(624,1,24.00,30.00,'2025-01-08 09:47:41'),(625,0,24.00,4.50,'2025-01-08 09:47:43'),(626,1,8.30,61.00,'2025-01-08 09:47:43'),(627,0,24.00,4.50,'2025-01-08 09:47:45'),(628,1,8.30,61.00,'2025-01-08 09:47:45'),(629,0,24.00,4.50,'2025-01-08 09:47:47'),(630,1,8.30,61.00,'2025-01-08 09:47:47'),(631,0,24.00,4.50,'2025-01-08 09:47:49'),(632,1,8.30,61.00,'2025-01-08 09:47:49'),(633,0,24.00,4.50,'2025-01-08 09:47:51'),(634,1,8.30,61.00,'2025-01-08 09:47:51'),(635,0,-3.70,4.50,'2025-01-08 09:47:53'),(636,1,8.30,61.00,'2025-01-08 09:47:53'),(637,0,-3.70,31.50,'2025-01-08 09:47:55'),(638,1,8.30,61.00,'2025-01-08 09:47:55'),(639,0,-3.70,31.50,'2025-01-08 09:47:57'),(640,1,8.30,61.00,'2025-01-08 09:47:58'),(641,0,-3.70,31.50,'2025-01-08 09:47:59'),(642,1,8.30,61.00,'2025-01-08 09:48:00'),(643,0,-20.00,31.50,'2025-01-08 09:48:01'),(644,1,8.30,61.00,'2025-01-08 09:48:02'),(645,0,-20.00,31.50,'2025-01-08 09:48:03'),(646,1,8.30,33.50,'2025-01-08 09:48:04'),(647,0,-20.00,31.50,'2025-01-08 09:48:06'),(648,1,8.30,33.50,'2025-01-08 09:48:06'),(649,0,44.30,83.00,'2025-01-08 09:48:08'),(650,1,8.30,33.50,'2025-01-08 09:48:08'),(651,0,44.30,83.00,'2025-01-08 09:48:10'),(652,1,8.30,33.50,'2025-01-08 09:48:10'),(653,0,25.50,73.00,'2025-01-08 09:48:12'),(654,1,8.30,33.50,'2025-01-08 09:48:12'),(655,0,40.00,73.00,'2025-01-08 09:48:14'),(656,1,8.30,33.50,'2025-01-08 09:48:14'),(657,0,40.00,73.00,'2025-01-08 09:48:16'),(658,1,8.30,33.50,'2025-01-08 09:48:16'),(659,0,40.00,73.00,'2025-01-08 09:48:18'),(660,1,8.30,33.50,'2025-01-08 09:48:18'),(661,0,40.00,73.00,'2025-01-08 09:48:20'),(662,1,8.30,33.50,'2025-01-08 09:48:20'),(663,0,17.70,52.00,'2025-01-08 09:48:22'),(664,1,8.30,33.50,'2025-01-08 09:48:23'),(665,0,17.70,2.00,'2025-01-08 09:48:24'),(666,1,8.30,33.50,'2025-01-08 09:48:25'),(667,0,17.70,2.00,'2025-01-08 09:48:26'),(668,1,8.30,33.50,'2025-01-08 09:48:27'),(669,0,17.70,2.00,'2025-01-08 09:48:28'),(670,1,8.30,33.50,'2025-01-08 09:48:29'),(671,0,6.60,9.50,'2025-01-08 09:48:31'),(672,1,8.30,33.50,'2025-01-08 09:48:31'),(673,0,6.60,9.50,'2025-01-08 09:48:33'),(674,1,8.30,33.50,'2025-01-08 09:48:33'),(675,0,6.60,9.50,'2025-01-08 09:48:35'),(676,1,8.30,33.50,'2025-01-08 09:48:35'),(677,0,6.60,9.50,'2025-01-08 09:48:37'),(678,1,8.30,33.50,'2025-01-08 09:48:37'),(679,0,6.60,28.00,'2025-01-08 09:48:39'),(680,1,8.30,33.50,'2025-01-08 09:48:39'),(681,0,25.50,28.00,'2025-01-08 09:48:41'),(682,1,8.30,33.50,'2025-01-08 09:48:41'),(683,0,21.20,31.00,'2025-01-08 09:48:43'),(684,1,8.30,33.50,'2025-01-08 09:48:43'),(685,0,21.20,36.00,'2025-01-08 09:48:45'),(686,1,8.30,33.50,'2025-01-08 09:48:45'),(687,0,21.20,41.00,'2025-01-08 09:48:47'),(688,1,8.30,33.50,'2025-01-08 09:48:47'),(689,0,21.20,41.00,'2025-01-08 09:48:49'),(690,1,8.30,33.50,'2025-01-08 09:48:49'),(691,0,24.00,40.00,'2025-01-16 22:02:49'),(692,1,24.00,40.00,'2025-01-16 22:02:49'),(693,0,24.00,40.00,'2025-01-16 22:02:51'),(694,1,24.00,40.00,'2025-01-16 22:02:51'),(695,0,24.00,40.00,'2025-01-16 22:02:53'),(696,1,24.00,40.00,'2025-01-16 22:02:53'),(697,0,24.00,40.00,'2025-01-16 22:02:55'),(698,1,24.00,40.00,'2025-01-16 22:02:55'),(699,0,24.00,40.00,'2025-01-16 22:02:57'),(700,1,24.00,40.00,'2025-01-16 22:02:57'),(701,0,24.00,40.00,'2025-01-16 22:02:59'),(702,1,24.00,40.00,'2025-01-16 22:02:59'),(703,0,24.00,40.00,'2025-01-16 22:03:01'),(704,1,24.00,40.00,'2025-01-16 22:03:02'),(705,0,24.00,40.00,'2025-01-16 22:03:03'),(706,1,24.00,40.00,'2025-01-16 22:03:04'),(707,0,24.00,40.00,'2025-01-16 22:03:05'),(708,1,24.00,40.00,'2025-01-16 22:03:06'),(709,0,24.00,40.00,'2025-01-16 22:03:08'),(710,1,24.00,40.00,'2025-01-16 22:03:08'),(711,0,24.00,40.00,'2025-01-16 22:03:10'),(712,1,24.00,40.00,'2025-01-16 22:03:10'),(713,0,24.00,40.00,'2025-01-16 22:03:12'),(714,1,24.00,40.00,'2025-01-16 22:03:12'),(715,0,24.00,40.00,'2025-01-16 22:03:14'),(716,1,24.00,40.00,'2025-01-16 22:03:14'),(717,0,24.00,40.00,'2025-01-16 22:03:16'),(718,1,24.00,40.00,'2025-01-16 22:03:16'),(719,0,24.00,40.00,'2025-01-16 22:03:18'),(720,1,24.00,40.00,'2025-01-16 22:03:18'),(721,0,24.00,40.00,'2025-01-16 22:03:20'),(722,1,24.00,40.00,'2025-01-16 22:03:20'),(723,0,24.00,40.00,'2025-01-16 22:03:22'),(724,1,24.00,40.00,'2025-01-16 22:03:22'),(725,0,24.00,40.00,'2025-01-16 22:03:24'),(726,1,24.00,40.00,'2025-01-16 22:03:24'),(727,0,24.00,40.00,'2025-01-16 22:03:26'),(728,1,24.00,40.00,'2025-01-16 22:03:27'),(729,0,24.00,40.00,'2025-01-16 22:03:28'),(730,1,24.00,40.00,'2025-01-16 22:03:29'),(731,0,24.00,40.00,'2025-01-16 22:03:30'),(732,1,24.00,40.00,'2025-01-16 22:03:31'),(733,0,24.00,40.00,'2025-01-16 22:03:33'),(734,1,24.00,40.00,'2025-01-16 22:03:33'),(735,0,24.00,40.00,'2025-01-16 22:03:35'),(736,1,24.00,40.00,'2025-01-16 22:03:35'),(737,0,24.00,40.00,'2025-01-16 22:03:37'),(738,1,24.00,40.00,'2025-01-16 22:03:37'),(739,0,24.00,40.00,'2025-01-16 22:03:39'),(740,1,24.00,40.00,'2025-01-16 22:03:39'),(741,0,24.00,40.00,'2025-01-16 22:03:41'),(742,1,24.00,40.00,'2025-01-16 22:03:41'),(743,0,24.00,40.00,'2025-01-16 22:03:43'),(744,1,24.00,40.00,'2025-01-16 22:03:43'),(745,0,24.00,40.00,'2025-01-16 22:03:45'),(746,1,24.00,40.00,'2025-01-16 22:03:45'),(747,0,24.00,40.00,'2025-01-16 22:03:47'),(748,1,2.30,40.00,'2025-01-16 22:03:47'),(749,0,24.00,40.00,'2025-01-16 22:03:49'),(750,1,2.30,40.00,'2025-01-16 22:03:49'),(751,0,24.00,40.00,'2025-01-16 22:03:51'),(752,1,2.30,25.00,'2025-01-16 22:03:52'),(753,0,24.00,40.00,'2025-01-16 22:03:53'),(754,1,2.30,25.00,'2025-01-16 22:03:54'),(755,0,24.00,40.00,'2025-01-16 22:03:55'),(756,1,2.30,25.00,'2025-01-16 22:03:56'),(757,0,24.00,40.00,'2025-01-16 22:03:58'),(758,1,2.30,25.00,'2025-01-16 22:03:58'),(759,0,24.00,40.00,'2025-01-16 22:04:00'),(760,1,2.30,25.00,'2025-01-16 22:04:00'),(761,0,4.00,40.00,'2025-01-16 22:04:02'),(762,1,2.30,25.00,'2025-01-16 22:04:02'),(763,0,46.90,40.00,'2025-01-16 22:04:04'),(764,1,2.30,25.00,'2025-01-16 22:04:04'),(765,0,46.90,66.50,'2025-01-16 22:04:06'),(766,1,2.30,25.00,'2025-01-16 22:04:06'),(767,0,46.90,0.00,'2025-01-16 22:04:08'),(768,1,2.30,25.00,'2025-01-16 22:04:08'),(769,0,80.00,0.00,'2025-01-16 22:04:10'),(770,1,2.30,25.00,'2025-01-16 22:04:10'),(771,0,-12.30,26.00,'2025-01-16 22:04:12'),(772,1,2.30,25.00,'2025-01-16 22:04:12'),(773,0,21.20,26.50,'2025-01-16 22:04:14'),(774,1,2.30,25.00,'2025-01-16 22:04:14'),(775,0,21.20,6.00,'2025-01-16 22:04:16'),(776,1,2.30,25.00,'2025-01-16 22:04:17'),(777,0,21.20,6.00,'2025-01-16 22:04:18'),(778,1,2.30,25.00,'2025-01-16 22:04:19'),(779,0,21.20,6.00,'2025-01-16 22:04:20'),(780,1,2.30,25.00,'2025-01-16 22:04:21'),(781,0,21.20,6.00,'2025-01-16 22:04:23'),(782,1,2.30,25.00,'2025-01-16 22:04:23'),(783,0,21.20,6.00,'2025-01-16 22:04:25'),(784,1,2.30,25.00,'2025-01-16 22:04:25'),(785,0,21.20,6.00,'2025-01-16 22:04:27'),(786,1,2.30,25.00,'2025-01-16 22:04:27'),(787,0,21.20,6.00,'2025-01-16 22:04:29'),(788,1,2.30,25.00,'2025-01-16 22:04:29'),(789,0,21.20,6.00,'2025-01-16 22:04:31'),(790,1,2.30,25.00,'2025-01-16 22:04:31'),(791,0,21.20,6.00,'2025-01-16 22:04:33'),(792,1,2.30,25.00,'2025-01-16 22:04:33'),(793,0,21.20,6.00,'2025-01-16 22:04:35'),(794,1,2.30,25.00,'2025-01-16 22:04:35'),(795,0,21.20,6.00,'2025-01-16 22:04:37'),(796,1,2.30,25.00,'2025-01-16 22:04:37'),(797,0,21.20,6.00,'2025-01-16 22:04:39'),(798,1,2.30,25.00,'2025-01-16 22:04:39'),(799,0,21.20,6.00,'2025-01-16 22:04:41'),(800,1,2.30,25.00,'2025-01-16 22:04:41'),(801,0,21.20,6.00,'2025-01-16 22:04:43'),(802,1,2.30,25.00,'2025-01-16 22:04:44'),(803,0,21.20,6.00,'2025-01-16 22:04:45'),(804,1,2.30,25.00,'2025-01-16 22:04:46'),(805,0,21.20,6.00,'2025-01-16 22:04:47'),(806,1,2.30,25.00,'2025-01-16 22:04:48'),(807,0,21.20,6.00,'2025-01-16 22:04:49'),(808,1,2.30,25.00,'2025-01-16 22:04:50'),(809,0,21.20,6.00,'2025-01-16 22:04:52'),(810,1,2.30,25.00,'2025-01-16 22:04:52'),(811,0,21.20,7.00,'2025-01-16 22:04:54'),(812,1,2.30,25.00,'2025-01-16 22:04:54'),(813,0,21.20,13.00,'2025-01-16 22:04:56'),(814,1,2.30,25.00,'2025-01-16 22:04:56'),(815,0,16.90,13.00,'2025-01-16 22:04:58'),(816,1,2.30,25.00,'2025-01-16 22:04:58'),(817,0,16.90,13.00,'2025-01-16 22:05:00'),(818,1,2.30,25.00,'2025-01-16 22:05:00'),(819,0,16.90,13.00,'2025-01-16 22:05:02'),(820,1,2.30,25.00,'2025-01-16 22:05:02'),(821,0,16.90,13.00,'2025-01-16 22:05:04'),(822,1,2.30,25.00,'2025-01-16 22:05:04'),(823,0,16.90,13.00,'2025-01-16 22:05:06'),(824,1,9.20,25.00,'2025-01-16 22:05:06'),(825,0,16.90,13.00,'2025-01-16 22:05:08'),(826,1,9.20,13.50,'2025-01-16 22:05:08'),(827,0,16.90,13.00,'2025-01-16 22:05:10'),(828,1,9.20,13.50,'2025-01-16 22:05:10'),(829,0,16.90,13.00,'2025-01-16 22:05:12'),(830,1,9.20,13.50,'2025-01-16 22:05:13'),(831,0,16.90,13.00,'2025-01-16 22:05:14'),(832,1,9.20,13.50,'2025-01-16 22:05:15'),(833,0,16.90,13.00,'2025-01-16 22:05:16'),(834,1,9.20,13.50,'2025-01-16 22:05:17'),(835,0,16.90,13.00,'2025-01-16 22:05:18'),(836,1,9.20,13.50,'2025-01-16 22:05:19'),(837,0,16.90,13.00,'2025-01-16 22:05:21'),(838,1,9.20,13.50,'2025-01-16 22:05:21'),(839,0,16.90,13.00,'2025-01-16 22:05:23'),(840,1,9.20,13.50,'2025-01-16 22:05:23'),(841,0,16.90,13.00,'2025-01-16 22:05:25'),(842,1,9.20,13.50,'2025-01-16 22:05:25'),(843,0,16.90,13.00,'2025-01-16 22:05:27'),(844,1,9.20,13.50,'2025-01-16 22:05:27'),(845,0,16.90,13.00,'2025-01-16 22:05:29'),(846,1,9.20,13.50,'2025-01-16 22:05:29'),(847,0,16.90,13.00,'2025-01-16 22:05:31'),(848,1,9.20,13.50,'2025-01-16 22:05:31'),(849,0,16.90,13.00,'2025-01-16 22:05:33'),(850,1,9.20,13.50,'2025-01-16 22:05:33'),(851,0,16.90,13.00,'2025-01-16 22:05:35'),(852,1,9.20,13.50,'2025-01-16 22:05:35'),(853,0,16.90,13.00,'2025-01-16 22:05:37'),(854,1,9.20,13.50,'2025-01-16 22:05:37'),(855,0,16.90,13.00,'2025-01-16 22:05:39'),(856,1,9.20,13.50,'2025-01-16 22:05:39'),(857,0,16.90,13.00,'2025-01-16 22:05:41'),(858,1,9.20,13.50,'2025-01-16 22:05:41'),(859,0,16.90,13.00,'2025-01-16 22:05:43'),(860,1,9.20,13.50,'2025-01-16 22:05:43'),(861,0,16.90,13.00,'2025-01-16 22:05:45'),(862,1,9.20,13.50,'2025-01-16 22:05:46'),(863,0,16.90,13.00,'2025-01-16 22:05:47'),(864,1,9.20,13.50,'2025-01-16 22:05:48'),(865,0,16.90,13.00,'2025-01-16 22:05:49'),(866,1,9.20,13.50,'2025-01-16 22:05:50'),(867,0,16.90,13.00,'2025-01-16 22:05:51'),(868,1,9.20,13.50,'2025-01-16 22:05:52'),(869,0,16.90,13.00,'2025-01-16 22:05:54'),(870,1,9.20,13.50,'2025-01-16 22:05:54'),(871,0,16.90,13.00,'2025-01-16 22:05:56'),(872,1,9.20,13.50,'2025-01-16 22:05:56'),(873,0,16.90,13.00,'2025-01-16 22:05:58'),(874,1,9.20,13.50,'2025-01-16 22:05:58'),(875,0,16.90,13.00,'2025-01-16 22:06:00'),(876,1,9.20,13.50,'2025-01-16 22:06:00');
/*!40000 ALTER TABLE `letture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sensori`
--

DROP TABLE IF EXISTS `sensori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sensori` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `posizione` varchar(255) DEFAULT NULL,
  `data_installazione` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensori`
--

LOCK TABLES `sensori` WRITE;
/*!40000 ALTER TABLE `sensori` DISABLE KEYS */;
INSERT INTO `sensori` VALUES (0,'0','terrazza','2024-01-01 11:12:12'),(1,'1','camera','2024-01-01 11:12:12'),(2,'2','bagno','2024-12-14 12:08:40'),(3,'3','soggiorno','2024-12-14 12:08:40');
/*!40000 ALTER TABLE `sensori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'sensori_iot'
--

--
-- Dumping routines for database 'sensori_iot'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-16 23:57:05
