-- MySQL dump 10.13  Distrib 5.7.36, for Linux (x86_64)
--
-- Host: localhost    Database: chumo_db
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
INSERT INTO `data` VALUES (1,'bot_token','5294600311:AAHh0OEYOM2wDspAuawA6nYgZuYs39HJY_s'),(2,'password','goldlog'),(4,'admin_name','админ'),(5,'support','По этому адресу можете связаться с разработчиком: '),(7,'start_button_response_in_private','Бот - помощник, публикует посты с заданными интервалами.');
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
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (74,'-1001735597589','hello2_test','hello2'),(82,'-1001648755164','truckingdispatching','GOLD Trucking Dispatching'),(83,'-1001730877604','all_about_truckers','GOLD All About TRUCKS'),(84,'-1001389029920','GroupTruckers','GOLD TruckersGroup'),(85,'-1001409478844','logistics_truckers','GOLD Logistics Trucking');
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
  `hours` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mailing_text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `term` date NOT NULL,
  `image` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_id` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_chat_id` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`timetable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_table`
--

LOCK TABLES `time_table` WRITE;
/*!40000 ALTER TABLE `time_table` DISABLE KEYS */;
INSERT INTO `time_table` VALUES (128171,'Agera 1','-1001389029920,-1001409478844,-1001648755164,-1001730877604','16,5','Maximize your earning potential with our Support Pro Dispatch services\n\n⭐️ We Analyze the market of all kinds, including DAT, Amazon, JB Hunt and book the best freight load possible with the highest prices\n\n⭐️ We Provide 24/7 high quality dispatch and update service\n\n⭐️ We Take care of back-office tasks, from customer support to billing and payment collections, and even maintain motor carrier compliance\n\n⭐️ We Set up with new brokerage companies and improve a close and friendly bond with existing ones and to be in prior to take the best load offers from the partners; \n\n\n⭐️  We Have Dedicated Lanes from Amazon and FedEx\n\n\n? You pick the areas you want to drive and we negotiate hard for the best paying rates and quality routes\n\n? Service fee: 3 % of the gross\n\n? Please feel free to contact for more details\n\n@agera_r','2022-07-06','images/128171.jpg',NULL,''),(142767,'Silk 4','-1001648755164,-1001730877604,-1001389029920,-1001409478844','04:05, 10:05','SILKROAD GROUP\n\n     ELD SERVICE\n\nEvery second of life is voluable.So save it☝️ Actually 5 minutes is too much to open a new shift?\n\nYou deserve the highest quality.Make the right choice\n\nFor details, contact us !!!\n? ??+1(267)8444148\n? ??+1(267)6252414\n\nTelegram @ELD_Team7  @ELD_Team07','2022-11-23','images/142767.jpg',NULL,'5121414539'),(178738,'Eudk','-1001735597589','15:55','Bvgggddduioovc','2022-11-17',NULL,NULL,'5121414539'),(191370,'Silk3','-1001648755164,-1001730877604,-1001409478844,-1001389029920','6,2','◾️◾️◾️SILKROAD GROUP◾️◾️◾️\n                   ELD SERVICE\n\n✅- Monitoring 24/7;\n\n✅- Consultation;\n\n✅- Audit;\n\n✅- Individual approach with every driver;\n\n✅- Strong sence of responsibility;\n\n✅- 4 years of experience;\n\n✅- Guaranteed high quality service.\n\nIf you are interested, contact us!!!\n? ??+1(267)8444148\n? ??+1(267)6252414\n\nTelegram @ELD_Team7  @ELD_Team07','2022-10-16','images/191370.jpg',NULL,'5121414539'),(325505,'Unn','-1001409478844,-1001389029920,-1001730877604,-1001648755164','0,8,10,2,18,16','??US Dispatch Corporation ??\n\nWhy you have to Choose Our Dispatch Services?\n\n✅We negotiate the Best rates ✅Experienced and dedicated personal dispatchers \n✅True route planning\n✅Verify credit of brokers or shippers\n✅Handle all necessary faxes and paperwork, including broker setup, insurance certificates and rate confirmations\n✅Competitive dispatching rate \n✅We will also develop your MC \n\n✅We work with:Amazon,XPO,J.B Hunt,ITS,UPS,DAT, Truckstop and other huge brokers.\n\n✅We assist Dry Van, PO, Flatbed,Step Deck, Reefer \n?24 / 7 dispatch support\n\nWe speak Russian,English, Turkish,Uzbek \n✅Our staff is multilingual.\n✅Excellent communication with brokers  \n?For 1 driver will assist Dispatcher, updators, supervisors,\n\nWe guaranteed weekly gross\n Solo + 10K$\n Team +15K$\n\n✅We offer an affordable fee only\n3%                                               \nWhat\'s app:+1815-907-1273\nTelegram: @Usdispatch_corporation\n\nweb: www.usdiscorp.com\nIf you are Interested, contact us!\n☎️ +1815-907-1273','2022-10-29','images/325505.jpg',NULL,'5121414539'),(328913,'Agera 2','-1001648755164,-1001730877604,-1001389029920,-1001409478844','19,0','⭐️GoldenELD offers you its resonable and high-quality services. ⭐️\n\n⭐️Now you can acquire a better service for a low price, i.e. 24/7 safety support, faster response and speedy fulfillment of requests, being ready for an audit in any situation, preparation for an audit and great deal of other amazing conveniences are propounded to you by GoldenELD.\n\nPrice list:\n\n?ELD Subscription: 45$ Monthly per unit \n\n?ELD Service: 115$ Monthly per unit\n\n?overall: 160$ Monthly \n\n?Free trial 7 days \n\n✅High-quality and fast service of the employees of our company is now at affordable and low prices. \n\n✅Be on the safe side of the road with GoldenELD !\n\n??‍?Full time monitoring to avoid potential HOS Violations. \n\n?Close relationship with dispatchers. \n\n?Preparation for Audit.\n\n✅Perfect Safety\n\n?For more details and discussions please feel free to contact ?: \n☎️ +1 831 400 8888\n☎️ +1 646 477 7070\n? info@ GoldenEld. com\nTelegram @agera_r','2022-07-06','images/328913.jpg',NULL,''),(338953,'Dirilis','-1001648755164,-1001730877604,-1001389029920,-1001409478844','0,3,11,8,16,19','Please register on our below link for auto-booking and benefit from many cool features of the platform: \n\nhttps://dirilisgroup.com/app','2022-10-12','images/338953.jpg',NULL,'5121414539'),(488992,'Dirilis 2','-1001648755164,-1001730877604,-1001409478844,-1001409478844,-1001389029920','4,14,21','Please register on our below link for auto-booking and benefit from many cool features of the platform: \n\nhttps://dirilisgroup.com/app','2022-10-12','images/488992.jpg',NULL,'5121414539'),(495388,'carg','-1001648755164,-1001389029920,-1001409478844,-1001730877604','17,7,19,22','⚡️High level ELD service ⚡️\n\n?We have experience⏱, cheap service?, polite staff ?‍??‍?\n\nOur Services:\n\n•24/7 eLOG BOOK support\n•We provide support in English, Russian, Uzbek.\n•Monitoring\n•Audit\n•IFTA\n•Fast service \n\n\nWe work with all programs ?‍? (GPS tab, bluestar , tt eld etc.)\n\nContact us today to sign up or if you have any questions ?\n\n\n@Cargo_Eld_Service\n\nELD SERVICE ?','2022-11-11','images/495388.jpg',NULL,'5121414539'),(697201,'Silk2','-1001730877604,-1001389029920,-1001409478844,-1001648755164','20,0','The Best ELD Service\n\n- Quick response;\n\n- 24/7 monitoring;\n\n- Being worned when having less than 1 hour;\n\n- Guarantee for being confidence;\n\nContact us!!!\n? ??+1(267)8444148\n? ??+1(267)6252414\n\nTelegram @ELD_Team7  @ELD_Team07','2022-10-16','images/697201.jpg',NULL,'5121414539'),(721547,'ADAM','-1001648755164,-1001730877604,-1001389029920,-1001409478844','16,18,21,0,2,4','✅Strong, Qualified The Consolidator Team Offers Following Services: \n\n✅ DISPATCH SERVICE!\n\n✅ Dispatch support 24/7\n\n✅ Individual approach to each driver! \n\n✅ We work with: UTXL, Coyote, Jbhunt, Amazon, FedEx, UPS, Target, Allenlund etc.\n\n\n✅✅✅SAFETY TEAM OFFERS:\n\n- MC / US DOT Registration\n- EIN Registration \n- IFTA Registration \n- IFTA Quarterly Returns  \n- IRP Registration / Vehicle registration. \n- IRP Apportioned License Plates\n- IRP Transfer / Renewal  \n- BOC 3 (Process Agents) filling\n- UCR Registration \n- HWY Use Tax (Form 2290)\n- KY, NM, NY, OR Permits \n- MCS 150 updates\n- Vehicle inspection record\n- Support during accident\n- Prepass (EZpass) / fuel card registration\n- Driver Qualification Files (MEC, MVR, PSP, Clearing House, Drug Test results)\n- Drug test compliance monitoring (Pre-employment, random)\n- Monitoring and improvement of company\'s Safety scores / CSA control (Data /Q). \n- Support and document preparation for Safety Audit. \n- Insurance support (Quotes, Binding coverages)\n- Factoring account setup\n- EXPERIENCED ELD DEPARTMENT can work with platforms: GPS Tab, ELDorado, Blue Star, Keep Trucking, etc. \n\n✅WE Also OFFER Recruiting drivers for your company! Own database of drivers! \n\n?  Strong solo drivers\n\n?? Team drivers\n\nFOR MORE INFO PLEASE DM: @AdamTheConsolidator','2022-11-17',NULL,NULL,''),(773746,'Silk 5','-1001648755164,-1001730877604,-1001389029920,-1001409478844','06:05, 13:08','SILKROAD GROUP\n\n     ELD SERVICE\n\nEvery second of life is voluable.So save it☝️ Actually 5 minutes is too much to open a new shift?\n\nYou deserve the highest quality.Make the right choice\n\nFor details, contact us !!!\n? ??+1(267)8444148\n? ??+1(267)6252414\n\nTelegram @ELD_Team7  @ELD_Team07','2022-11-23','images/773746.jpg',NULL,'5121414539'),(788335,'Agera 3','-1001648755164,-1001409478844,-1001730877604,-1001389029920','22,1','⭐️GoldenELD offers you its resonable and high-quality services. ⭐️\n\n⭐️Now you can acquire a better service for a low price, i.e. 24/7 safety support, faster response and speedy fulfillment of requests, being ready for an audit in any situation, preparation for an audit and great deal of other amazing conveniences are propounded to you by GoldenELD.\n\nPrice list:\n\n?ELD Subscription: 45$ Monthly per unit \n\n?ELD Service: 115$ Monthly per unit\n\n?overall: 160$ Monthly \n\n?Free trial 7 days \n\n✅High-quality and fast service of the employees of our company is now at affordable and low prices. \n\n✅Be on the safe side of the road with GoldenELD !\n\n??‍?Full time monitoring to avoid potential HOS Violations. \n\n?Close relationship with dispatchers. \n\n?Preparation for Audit.\n\n✅Perfect Safety\n\n?For more details and discussions please feel free to contact ?: \n☎️ +1 831 400 8888\n☎️ +1 646 477 7070\n? info@ GoldenEld. com\nTelegram @agera_r','2022-07-06','images/788335.jpg',NULL,''),(902235,'Qzalo','-1001730877604','00:50, 05:45, 19:37','https://t.me/logisticsvacancycity\n\n? Logistics Vacancy City channel is offering its ?logistic advertising 24/7? service for vacancies for logistic jobs, workers for logistic jobs and trucking companies and all kinds of logistic sphere people in Uzbekistan \n\n❗️What we are offering: \n\n✔️Professional content;\n\n✔️Best rate for advertising ;\n\n✔️Fast service ;\n\n✔️Approach customers with good manner. \n\n???The best thing is giving advertisement is free in JUMA days ???\n\nChannel link https://t.me/logisticsvacancycity\nFor more info PM\n@missDispatcher','2022-08-28',NULL,NULL,'5121414539'),(913570,'Silk1','-1001730877604,-1001389029920,-1001409478844,-1001648755164','18,22','◾️◾️◾️SILKROAD GROUP◾️◾️◾️\n                   ELD SERVICE\n\n✅- Monitoring 24/7;\n\n✅- Consultation;\n\n✅- Audit;\n\n✅- Individual approach with every driver;\n\n✅- Strong sence of responsibility;\n\n✅- 4 years of experience;\n\n✅- Guaranteed high quality service.\n\nIf you are interested, contact us!!!\n? ??+1(267)8444148\n? ??+1(267)6252414\n\nTelegram @ELD_Team7  @ELD_Team07','2022-10-16','images/913570.jpg',NULL,'5121414539'),(923852,'das','-1001735597589','21','??USA DISPATCHERS??\n\nWhy choose us?\n\n ?<b>ALL in 1 -  IN-HOUSE</b> PROFESSIONAL EXPERTS\n- Head office in <b>US;</b>\n- <b>Easy</b> payments: <b>Zelle/ACH/Wire</b>\n\n??‍?- DISPATCHERS & UPDATERS:\n\n✅ Working with Only with HOT?  loads, <b>50+</b> reputable Brokers\n✅ Finding the right load that fits your expectations.\n✅ <b>2-3 day ahead</b> strategic planing\n\n⏱- SAFETY MANAGERS\n\n✅ Helping you plan for and deal with weather delays, traffic congestion\n✅ E-books Full-management\n\n?- ACCOUNTING & BOOKKEEPING (extra fee)\n\n✅ Handling invoicing-billing paperwork, collection, Factoring, <b>IFTA</b> and all others\n\n?- FLEET MANAGEMENT\n\n✅ <b>FAST</b> solutions with <b>Truck & Trailer</b> repairs, find Best towing companies, maintenance arrangements with shops.\n\n\n?- <b>AUTHORITY</b>\n\n✅ We have OWN MC or can use YOUR MC\n\nGUARANTEED weekly GROSS:\nWith reliable drivers\n? SOLO $10-18K+\n? TEAM $18-25K+\n\n?MARCH PROMO RATES?\n<b>- 2.99%</b> with your MC\n<b>- 13.99%</b> under our MC\n\nIf you are Interested, contact us\n\n<b>call: <u>+14074774444</u></b>\n\n@bosa_boss\n@bosaboss_ceo','2022-04-01','images/bob.jpg',NULL,'5121414539'),(983590,'mirkom','-1001735597589','14:50','6+4565','2022-08-16',NULL,NULL,'5121414539');
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

-- Dump completed on 2022-08-23 20:38:57
