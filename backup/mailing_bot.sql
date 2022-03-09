-- MySQL dump 10.13  Distrib 5.7.36, for Linux (x86_64)
--
-- Host: localhost    Database: algo
-- ------------------------------------------------------
-- Server version	5.7.36-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `data`
--

DROP TABLE IF EXISTS `data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data`
--

LOCK TABLES `data` WRITE;
/*!40000 ALTER TABLE `data` DISABLE KEYS */;
INSERT INTO `data` VALUES (1,'bot_token','5057786112:AAH5lK3Ud9qs2nvRaeQhF--Y6iIf78gmKNw'),(2,'password','mouffim'),(4,'admin_name','админ'),(5,'support','По этому адресу можете связаться с разработчиком: @rig_admin'),(7,'start_button_response_in_private','Salom bu bot avto post tashlovchi bot guruhlar kanallar uchun juda ham qulay bot registratsiyadsn otiw ucun admin blan boglaning: @rig_admin');
/*!40000 ALTER TABLE `data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chat_id` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (60,'-522514567',NULL,'test algo'),(64,'-1001709359629','BMT_truckers','RIG Trucking&D'),(65,'-1001279009032','uz_brokers','?UZBroker-chat?'),(67,'-1001385628227','all_about_truck','All About Trucks'),(68,'-1001738818400','dispatchers_truckers','Dispatchers Truckers Brokers Rig'),(71,'-1001461660790','USAdispatching_trucking','Trucking Dispatching Brokers');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_table`
--

DROP TABLE IF EXISTS `time_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_table` (
  `timetable_id` int(11) NOT NULL,
  `timetable_name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `groups_id` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hours` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mailing_text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `term` date NOT NULL,
  `image` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_id` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`timetable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_table`
--

LOCK TABLES `time_table` WRITE;
/*!40000 ALTER TABLE `time_table` DISABLE KEYS */;
INSERT INTO `time_table` VALUES (104976,'Bob 4.1','-1001738818400','19,21,4','<b>??USA DISPATCHERS??</b>\n\n?<b>ALL in 1 -  IN-HOUSE</b> PROFESSIONAL EXPERTS\n\n<b>??‍?- DISPATCHERS & UPDATERS:</b>\n\n✅ Working with Amazon, DAT, FEDEX, UPS hot loads and <b>50+</b> reputable <b>Brokers</b>\n✅ Finding the right load that fits your expectations perfectly\n✅ 2-3 day ahead strategic planing\n\n<b>⏱- SAFETY MANAGERS</b>\n\n✅ Helping you plan for and deal with weather delays, traffic congestion\n✅ E-books Full-management\n\n<b>?- ACCOUNTING & BOOKKEEPING (extra fee)</b>\n\n✅ Handling invoicing-billing paperwork, collection, Factoring, IFTA and all others\n\n<b>?- FLEET MANAGEMENT</b>\n\n✅ FAST solutions with Truck & Trailer repairs, find Best towing companies, maintenance arrangements with shops.\n✅ Best fuel cards with discounts up to 55c.\n\n<b>?- AUTHORITY</b>\n\n✅ We have <b>OWN MC</b> or can use <b>YOUR MC</b>\n\n<b>GUARANTEED</b> weekly <b>GROSS:</b>\nWith reliable drivers\n? SOLO <b>$12-18K+</b>\n? TEAM <b>$18-25K+</b>\n\n<b>?MARCH PROMO RATES?</b>\n<b>- 2.99% with your MC</b>\n<b>- 14.99% under our MC</b>\n\n<i>If you are Interested, contact us</i>\n\n<i>call: 407 477 4444</i>\n\n<i>@BosaBoss</i>','2022-03-18',NULL,'BAACAgEAAxkBAAINJWIgML8DGLD-QTcg5Q0Y5Jh2CCr8AAJkAgAClZIAAUV9e0LtLJMkZSME'),(119325,'Bob 5.1','-1001461660790','20,0,4','<b>??USA DISPATCHERS??</b>\n\n?<b>ALL in 1 -  IN-HOUSE</b> PROFESSIONAL EXPERTS\n\n<b>??‍?- DISPATCHERS & UPDATERS:</b>\n\n✅ Working with Amazon, DAT, FEDEX, UPS hot loads and <b>50+</b> reputable <b>Brokers</b>\n✅ Finding the right load that fits your expectations perfectly\n✅ 2-3 day ahead strategic planing\n\n<b>⏱- SAFETY MANAGERS</b>\n\n✅ Helping you plan for and deal with weather delays, traffic congestion\n✅ E-books Full-management\n\n<b>?- ACCOUNTING & BOOKKEEPING (extra fee)</b>\n\n✅ Handling invoicing-billing paperwork, collection, Factoring, IFTA and all others\n\n<b>?- FLEET MANAGEMENT</b>\n\n✅ FAST solutions with Truck & Trailer repairs, find Best towing companies, maintenance arrangements with shops.\n✅ Best fuel cards with discounts up to 55c.\n\n<b>?- AUTHORITY</b>\n\n✅ We have <b>OWN MC</b> or can use <b>YOUR MC</b>\n\n<b>GUARANTEED</b> weekly <b>GROSS:</b>\nWith reliable drivers\n? SOLO <b>$12-18K+</b>\n? TEAM <b>$18-25K+</b>\n\n<b>?MARCH PROMO RATES?</b>\n<b>- 2.99% with your MC</b>\n<b>- 14.99% under our MC</b>\n\n<i>If you are Interested, contact us</i>\n\n<i>call: 407 477 4444</i>\n\n<i>@BosaBoss</i>','2022-03-18',NULL,'BAACAgEAAxkBAAINMGIgMOHOmw1MfzQVCBbcp9ChfCZEAAJkAgAClZIAAUV9e0LtLJMkZSME'),(143153,'Circle','-1001709359629,-1001279009032,-1001385628227,-1001461660790,-1001738818400','0,2,22,20','Lease rental \n85% from gross, \n$900-950 trucks, \n$0.13 cpm \n$250 weekly for 53 trailers!\n\nTry best dispatch system! 4k-5k miles every week.\n\nGross weekly $10,000-$20,000+\n\nSolo/Teams\n\nDry VAN / Power Only Amazon\n\nWe hire asap - within 48 hours!\n\nMain office in Chicago IL.\n\nText us on Telegram or call:\n \n440-397-56-96 @tom_hrdep \n513-297-31-41 @daniel_hrdep','2022-03-26','images/143153.jpg',NULL),(294902,'Bob 4.2','-1001738818400','15,6,7','<b>??USA DISPATCHERS??</b>\n\n?<b>ALL in 1 -  IN-HOUSE</b> PROFESSIONAL EXPERTS\n\n<b>??‍?- DISPATCHERS & UPDATERS:</b>\n\n✅ Working with Amazon, DAT, FEDEX, UPS hot loads and <b>50+</b> reputable <b>Brokers</b>\n✅ Finding the right load that fits your expectations perfectly\n✅ 2-3 day ahead strategic planing\n\n<b>⏱- SAFETY MANAGERS</b>\n\n✅ Helping you plan for and deal with weather delays, traffic congestion\n✅ E-books Full-management\n\n<b>?- ACCOUNTING & BOOKKEEPING (extra fee)</b>\n\n✅ Handling invoicing-billing paperwork, collection, Factoring, IFTA and all others\n\n<b>?- FLEET MANAGEMENT</b>\n\n✅ FAST solutions with Truck & Trailer repairs, find Best towing companies, maintenance arrangements with shops.\n✅ Best fuel cards with discounts up to 55c.\n\n<b>?- AUTHORITY</b>\n\n✅ We have <b>OWN MC</b> or can use <b>YOUR MC</b>\n\n<b>GUARANTEED</b> weekly <b>GROSS:</b>\nWith reliable drivers\n? SOLO <b>$12-18K+</b>\n? TEAM <b>$18-25K+</b>\n\n<b>?MARCH PROMO RATES?</b>\n<b>- 2.99% with your MC</b>\n<b>- 14.99% under our MC</b>\n\n<i>If you are Interested, contact us</i>\n\n<i>call: 407 477 4444</i>\n\n<i>@BosaBoss</i>','2022-03-18','images/294902.jpg',NULL),(302744,'Bob 2.2','-1001279009032','4,7,9','<b>??USA DISPATCHERS??</b>\n\n?<b>ALL in 1 -  IN-HOUSE</b> PROFESSIONAL EXPERTS\n\n<b>??‍?- DISPATCHERS & UPDATERS:</b>\n\n✅ Working with Amazon, DAT, FEDEX, UPS hot loads and <b>50+</b> reputable <b>Brokers</b>\n✅ Finding the right load that fits your expectations perfectly\n✅ 2-3 day ahead strategic planing\n\n<b>⏱- SAFETY MANAGERS</b>\n\n✅ Helping you plan for and deal with weather delays, traffic congestion\n✅ E-books Full-management\n\n<b>?- ACCOUNTING & BOOKKEEPING (extra fee)</b>\n\n✅ Handling invoicing-billing paperwork, collection, Factoring, IFTA and all others\n\n<b>?- FLEET MANAGEMENT</b>\n\n✅ FAST solutions with Truck & Trailer repairs, find Best towing companies, maintenance arrangements with shops.\n✅ Best fuel cards with discounts up to 55c.\n\n<b>?- AUTHORITY</b>\n\n✅ We have <b>OWN MC</b> or can use <b>YOUR MC</b>\n\n<b>GUARANTEED</b> weekly <b>GROSS:</b>\nWith reliable drivers\n? SOLO <b>$12-18K+</b>\n? TEAM <b>$18-25K+</b>\n\n<b>?MARCH PROMO RATES?</b>\n<b>- 2.99% with your MC</b>\n<b>- 14.99% under our MC</b>\n\n<i>If you are Interested, contact us</i>\n\n<i>call: 407 477 4444</i>\n\n<i>@BosaBoss</i>','2022-03-18','images/302744.jpg',NULL),(316604,'123','-522514567','4,5,6,7,3,2,8,9,11,15,14,21,20,13,12,0,19,16,17,23,22,18,1','zfkjzshdasfdasdfashfgzfkjzshdasfdasdfashfgzfkjzshdasfdasdfashfgzfkjzshdasfdasdfashfgzfkjzshdasfdasdfashfgzfkjzshdasfdasdfashfgzfkjzshdasfdasdfashfgzfkjzshdasfdasdfashfgzfkjzshdasfdasdfashfgzfkjzshdasfdasdfashfgzfkjzshdasfdasdfashfgzfkjzshdasfdasdfashfgzfkjzshdasfdasdfashfg','2022-02-09',NULL,NULL),(342671,'Algo free ad','-1001385628227,-1001279009032','4,11','.','2022-05-29','images/342671.jpg',NULL),(402609,'Bob 1.2','-1001709359629','3,6,8','<b>??USA DISPATCHERS??</b>\n\n?<b>ALL in 1 -  IN-HOUSE</b> PROFESSIONAL EXPERTS\n\n<b>??‍?- DISPATCHERS & UPDATERS:</b>\n\n✅ Working with Amazon, DAT, FEDEX, UPS hot loads and <b>50+</b> reputable <b>Brokers</b>\n✅ Finding the right load that fits your expectations perfectly\n✅ 2-3 day ahead strategic planing\n\n<b>⏱- SAFETY MANAGERS</b>\n\n✅ Helping you plan for and deal with weather delays, traffic congestion\n✅ E-books Full-management\n\n<b>?- ACCOUNTING & BOOKKEEPING (extra fee)</b>\n\n✅ Handling invoicing-billing paperwork, collection, Factoring, IFTA and all others\n\n<b>?- FLEET MANAGEMENT</b>\n\n✅ FAST solutions with Truck & Trailer repairs, find Best towing companies, maintenance arrangements with shops.\n✅ Best fuel cards with discounts up to 55c.\n\n<b>?- AUTHORITY</b>\n\n✅ We have <b>OWN MC</b> or can use <b>YOUR MC</b>\n\n<b>GUARANTEED</b> weekly <b>GROSS:</b>\nWith reliable drivers\n? SOLO <b>$12-18K+</b>\n? TEAM <b>$18-25K+</b>\n\n<b>?MARCH PROMO RATES?</b>\n<b>- 2.99% with your MC</b>\n<b>- 14.99% under our MC</b>\n\n<i>If you are Interested, contact us</i>\n\n<i>call: 407 477 4444</i>\n\n<i>@BosaBoss</i>','2022-03-18','images/402609.jpg',NULL),(422863,'Bob 5.2','-1001461660790','6,8,9','<b>??USA DISPATCHERS??</b>\n\n?<b>ALL in 1 -  IN-HOUSE</b> PROFESSIONAL EXPERTS\n\n<b>??‍?- DISPATCHERS & UPDATERS:</b>\n\n✅ Working with Amazon, DAT, FEDEX, UPS hot loads and <b>50+</b> reputable <b>Brokers</b>\n✅ Finding the right load that fits your expectations perfectly\n✅ 2-3 day ahead strategic planing\n\n<b>⏱- SAFETY MANAGERS</b>\n\n✅ Helping you plan for and deal with weather delays, traffic congestion\n✅ E-books Full-management\n\n<b>?- ACCOUNTING & BOOKKEEPING (extra fee)</b>\n\n✅ Handling invoicing-billing paperwork, collection, Factoring, IFTA and all others\n\n<b>?- FLEET MANAGEMENT</b>\n\n✅ FAST solutions with Truck & Trailer repairs, find Best towing companies, maintenance arrangements with shops.\n✅ Best fuel cards with discounts up to 55c.\n\n<b>?- AUTHORITY</b>\n\n✅ We have <b>OWN MC</b> or can use <b>YOUR MC</b>\n\n<b>GUARANTEED</b> weekly <b>GROSS:</b>\nWith reliable drivers\n? SOLO <b>$12-18K+</b>\n? TEAM <b>$18-25K+</b>\n\n<b>?MARCH PROMO RATES?</b>\n<b>- 2.99% with your MC</b>\n<b>- 14.99% under our MC</b>\n\n<i>If you are Interested, contact us</i>\n\n<i>call: 407 477 4444</i>\n\n<i>@BosaBoss</i>','2022-03-18','images/422863.jpg',NULL),(596956,'Bob 3.1','-1001385628227','17,18,23','<b>??USA DISPATCHERS??</b>\n\n?<b>ALL in 1 -  IN-HOUSE</b> PROFESSIONAL EXPERTS\n\n<b>??‍?- DISPATCHERS & UPDATERS:</b>\n\n✅ Working with Amazon, DAT, FEDEX, UPS hot loads and <b>50+</b> reputable <b>Brokers</b>\n✅ Finding the right load that fits your expectations perfectly\n✅ 2-3 day ahead strategic planing\n\n<b>⏱- SAFETY MANAGERS</b>\n\n✅ Helping you plan for and deal with weather delays, traffic congestion\n✅ E-books Full-management\n\n<b>?- ACCOUNTING & BOOKKEEPING (extra fee)</b>\n\n✅ Handling invoicing-billing paperwork, collection, Factoring, IFTA and all others\n\n<b>?- FLEET MANAGEMENT</b>\n\n✅ FAST solutions with Truck & Trailer repairs, find Best towing companies, maintenance arrangements with shops.\n✅ Best fuel cards with discounts up to 55c.\n\n<b>?- AUTHORITY</b>\n\n✅ We have <b>OWN MC</b> or can use <b>YOUR MC</b>\n\n<b>GUARANTEED</b> weekly <b>GROSS:</b>\nWith reliable drivers\n? SOLO <b>$12-18K+</b>\n? TEAM <b>$18-25K+</b>\n\n<b>?MARCH PROMO RATES?</b>\n<b>- 2.99% with your MC</b>\n<b>- 14.99% under our MC</b>\n\n<i>If you are Interested, contact us</i>\n\n<i>call: 407 477 4444</i>\n\n<i>@BosaBoss</i>','2022-03-18',NULL,'BAACAgEAAxkBAAINGmIgMJcT9TGn1w49vTjUfY_fov68AAJkAgAClZIAAUV9e0LtLJMkZSME'),(625464,'Jdjdjd','-522514567','22','.','2022-02-25',NULL,'BAACAgIAAxkBAAII9WIIG0n__yilcRjsEiWf75UhDMJuAAI1FQAC0i5BSFQn-gU3eshgIwQ'),(665205,'Algo','-1001709359629,-1001279009032,-1001385628227,-1001738818400,-1001461660790','1,3,5,7,9,11,13,15,21,17,19,23','? ALGO service offers his own logbook service for truck owners, drivers and trucking companies in USA\n\n? The company helps everyone who wants to have a high quality ELD service\n\n?  We have more than 4 years experience in this fields\n\n✅ Types of services we offer:\n\n- Preparing monthly audit/report (history)\n- Monitoring; (driver\'s current status, logs, location and etc) \n- Individual work with every driver;\n- Consulting service for new companies;\n- 24/7 ELD Support;\n\nBusiness Tax, Professional CPA, Accounting services available\n\n? Platforms we work with; \n\n? Blue Star ELD;\n? TT ELD;\n?Track ensure;\n?GPS Tab;\n?Ezlogz;\n?TFM ELD;\n?Master ELD;\n\n? Safety rules are your best tools\n\nFor more info: @algo_manager\nPhone: +1773-377-8167','2022-05-29','images/665205.jpg',NULL),(762357,'Job chanel','-1001709359629,-1001279009032,-1001385628227,-1001461660790,-1001738818400','20,23,5,3','HuntMe Growing\n\nAre you ready to find WELL PAID JOB??\n\n• Send your resume\n\n• Pick up your phone\n\n• Grow with us\n\nSincerely\nHuntME team','2022-03-10','images/762357.jpg',NULL),(775604,'Bob 2.1','-1001279009032','19,22,0','<b>??USA DISPATCHERS??</b>\n\n?<b>ALL in 1 -  IN-HOUSE</b> PROFESSIONAL EXPERTS\n\n<b>??‍?- DISPATCHERS & UPDATERS:</b>\n\n✅ Working with Amazon, DAT, FEDEX, UPS hot loads and <b>50+</b> reputable <b>Brokers</b>\n✅ Finding the right load that fits your expectations perfectly\n✅ 2-3 day ahead strategic planing\n\n<b>⏱- SAFETY MANAGERS</b>\n\n✅ Helping you plan for and deal with weather delays, traffic congestion\n✅ E-books Full-management\n\n<b>?- ACCOUNTING & BOOKKEEPING (extra fee)</b>\n\n✅ Handling invoicing-billing paperwork, collection, Factoring, IFTA and all others\n\n<b>?- FLEET MANAGEMENT</b>\n\n✅ FAST solutions with Truck & Trailer repairs, find Best towing companies, maintenance arrangements with shops.\n✅ Best fuel cards with discounts up to 55c.\n\n<b>?- AUTHORITY</b>\n\n✅ We have <b>OWN MC</b> or can use <b>YOUR MC</b>\n\n<b>GUARANTEED</b> weekly <b>GROSS:</b>\nWith reliable drivers\n? SOLO <b>$12-18K+</b>\n? TEAM <b>$18-25K+</b>\n\n<b>?MARCH PROMO RATES?</b>\n<b>- 2.99% with your MC</b>\n<b>- 14.99% under our MC</b>\n\n<i>If you are Interested, contact us</i>\n\n<i>call: 407 477 4444</i>\n\n<i>@BosaBoss</i>','2022-03-18',NULL,'BAACAgEAAxkBAAINDGIgMG_RyEcR9nFfkAtsOoPIzq_WAAJkAgAClZIAAUV9e0LtLJMkZSME'),(791131,'Bob 1.1','-1001709359629','18,21,23','<b>??USA DISPATCHERS??</b>\n\n?<b>ALL in 1 -  IN-HOUSE</b> PROFESSIONAL EXPERTS\n\n<b>??‍?- DISPATCHERS & UPDATERS:</b>\n\n✅ Working with Amazon, DAT, FEDEX, UPS hot loads and <b>50+</b> reputable <b>Brokers</b>\n✅ Finding the right load that fits your expectations perfectly\n✅ 2-3 day ahead strategic planing\n\n<b>⏱- SAFETY MANAGERS</b>\n\n✅ Helping you plan for and deal with weather delays, traffic congestion\n✅ E-books Full-management\n\n<b>?- ACCOUNTING & BOOKKEEPING (extra fee)</b>\n\n✅ Handling invoicing-billing paperwork, collection, Factoring, IFTA and all others\n\n<b>?- FLEET MANAGEMENT</b>\n\n✅ FAST solutions with Truck & Trailer repairs, find Best towing companies, maintenance arrangements with shops.\n✅ Best fuel cards with discounts up to 55c.\n\n<b>?- AUTHORITY</b>\n\n✅ We have <b>OWN MC</b> or can use <b>YOUR MC</b>\n\n<b>GUARANTEED</b> weekly <b>GROSS:</b>\nWith reliable drivers\n? SOLO <b>$12-18K+</b>\n? TEAM <b>$18-25K+</b>\n\n<b>?MARCH PROMO RATES?</b>\n<b>- 2.99% with your MC</b>\n<b>- 14.99% under our MC</b>\n\n<i>If you are Interested, contact us</i>\n\n<i>call: 407 477 4444</i>\n\n<i>@BosaBoss</i>','2022-03-18',NULL,'BAACAgEAAxkBAAINAWIgMDz3or1HlC09Y0d_B5rzKCsmAAJkAgAClZIAAUV9e0LtLJMkZSME'),(883355,'Test','-522514567','2,3,4,5,6,19,16,18,22,9,23,10,11,1,0,8,12,13,14,15,21,20','.','2022-01-15','images/883355.jpg',NULL),(983661,'Bob 3.2','-1001385628227','14,5,8','<b>??USA DISPATCHERS??</b>\n\n?<b>ALL in 1 -  IN-HOUSE</b> PROFESSIONAL EXPERTS\n\n<b>??‍?- DISPATCHERS & UPDATERS:</b>\n\n✅ Working with Amazon, DAT, FEDEX, UPS hot loads and <b>50+</b> reputable <b>Brokers</b>\n✅ Finding the right load that fits your expectations perfectly\n✅ 2-3 day ahead strategic planing\n\n<b>⏱- SAFETY MANAGERS</b>\n\n✅ Helping you plan for and deal with weather delays, traffic congestion\n✅ E-books Full-management\n\n<b>?- ACCOUNTING & BOOKKEEPING (extra fee)</b>\n\n✅ Handling invoicing-billing paperwork, collection, Factoring, IFTA and all others\n\n<b>?- FLEET MANAGEMENT</b>\n\n✅ FAST solutions with Truck & Trailer repairs, find Best towing companies, maintenance arrangements with shops.\n✅ Best fuel cards with discounts up to 55c.\n\n<b>?- AUTHORITY</b>\n\n✅ We have <b>OWN MC</b> or can use <b>YOUR MC</b>\n\n<b>GUARANTEED</b> weekly <b>GROSS:</b>\nWith reliable drivers\n? SOLO <b>$12-18K+</b>\n? TEAM <b>$18-25K+</b>\n\n<b>?MARCH PROMO RATES?</b>\n<b>- 2.99% with your MC</b>\n<b>- 14.99% under our MC</b>\n\n<i>If you are Interested, contact us</i>\n\n<i>call: 407 477 4444</i>\n\n<i>@BosaBoss</i>','2022-03-18','images/983661.jpg',NULL);
/*!40000 ALTER TABLE `time_table` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-09 21:49:54
