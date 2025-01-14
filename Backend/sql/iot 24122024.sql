CREATE DATABASE  IF NOT EXISTS `sensori_iot` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `sensori_iot`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sensori_iot
-- ------------------------------------------------------
-- Server version	8.0.40

-- Table structure for table `sensori`

DROP TABLE IF EXISTS `sensori`;
CREATE TABLE `sensori` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `posizione` varchar(255) DEFAULT NULL,
  `data_installazione` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `sensori`

INSERT INTO `sensori` VALUES
(0,'0','terrazza','2024-01-01 11:12:12'),
(1,'1','camera','2024-01-01 11:12:12'),
(2,'2','bagno','2024-12-14 12:08:40'),
(3,'3','soggiorno','2024-12-14 12:08:40');

-- Table structure for table `letture`

DROP TABLE IF EXISTS `letture`;
CREATE TABLE `letture` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sensore_id` int NOT NULL,
  `temperatura` decimal(4,2) NOT NULL,
  `umidita` decimal(4,2) NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `sensore_id` (`sensore_id`),
  CONSTRAINT `letture_ibfk_1` FOREIGN KEY (`sensore_id`) REFERENCES `sensori` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=344 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
