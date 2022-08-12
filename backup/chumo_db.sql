-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 12, 2022 at 02:48 PM
-- Server version: 5.7.36-0ubuntu0.18.04.1
-- PHP Version: 7.2.34-30+ubuntu18.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `chumo_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `data`
--

CREATE TABLE `data` (
  `id` int(11) NOT NULL,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `data`
--

INSERT INTO `data` (`id`, `name`, `value`) VALUES
(1, 'bot_token', '5294600311:AAHh0OEYOM2wDspAuawA6nYgZuYs39HJY_s'),
(2, 'password', 'goldlog'),
(4, 'admin_name', 'админ'),
(5, 'support', 'По этому адресу можете связаться с разработчиком: '),
(7, 'start_button_response_in_private', 'Бот - помощник, публикует посты с заданными интервалами.');

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(11) NOT NULL,
  `chat_id` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `chat_id`, `username`, `title`) VALUES
(74, '-1001735597589', 'hello2_test', 'hello2'),
(82, '-1001648755164', 'truckingdispatching', 'GOLD Trucking Dispatching'),
(83, '-1001730877604', 'all_about_truckers', 'GOLD All About TRUCKS'),
(84, '-1001389029920', 'GroupTruckers', 'GOLD TruckersGroup'),
(85, '-1001409478844', 'logistics_truckers', 'GOLD Logistics Trucking');

-- --------------------------------------------------------

--
-- Table structure for table `time_table`
--

CREATE TABLE `time_table` (
  `timetable_id` int(11) NOT NULL,
  `timetable_name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `groups_id` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hours` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mailing_text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `term` date NOT NULL,
  `image` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_id` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_chat_id` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `time_table`
--

INSERT INTO `time_table` (`timetable_id`, `timetable_name`, `groups_id`, `hours`, `mailing_text`, `term`, `image`, `video_id`, `admin_chat_id`) VALUES
(104572, 'SINAN 1.6', '-1001730877604,-1001648755164,-1001409478844,-1001389029920', '21', 'NEED TO HIRE CDL-A DRIVERS FOR YOUR FLEET? \nWANT TO EXPAND YOUR COMPANY? \n\nWe will help you with finding and recruiting hard working, qualified, and experienced drivers based on your needs. \n\nYOUR BENEFITS OF WORKING WITH US: \n✅ Lower your cost per hire! \n✅ Save time and money on advertising!\n✅ Exceptional support throughout the hiring process! \n \n👉LET US GET YOU THE BEST DRIVERS TO GROW YOUR BUSINESS! 👈\n\nContact us: \n203 626 4433\n@sinanrecruiting', '2022-11-09', 'images/104572.jpg', NULL, '5121414539'),
(110179, 'axis2', '-1001648755164,-1001730877604,-1001389029920,-1001409478844', '20', '🚛 Are you looking for a TMS to keep your business profitable 💵🧾📈💰\nAxis TMS offers the most comprehensive and reliable cloud based TMS available🚚\n\n         Axis TMS offers the following:\n 🔥 💵Convenient Pricing Tiers Optimized for small to mid-size trucking companies\n 🔥 🧾 Invoice Factoring with just 1 click of a button on the Axis TMS platform \n 🔥 🚛 Load board access that is integrated with Our preferred partner 123loadboard  \n 🔥 📡 Hardware through one of our preferred partners Keeptruckin/Motive & TruckX we will get you the best deals on ELD’s GPS trackers & Dash Cams \n\nStart using 🚚💻Axis TMS📲 🚛 using the link below & signup for a DEMO:\nhttps://pro.axistms.com/htt-start\n\nStart Factoring your 🧾 invoices with 💵triumph 💵 using the link below:\n\nhttps://bit.ly/3o1GAfr\n\nStart using 🚛123loadboard🚚 with the link below:\n\nhttps://bit.ly/3yZneyb\n\nHardware for ELD’s links below:\n🚛Keeptruckin/Motive📡\n\nhttps://bit.ly/3yYFDes\n\n🚚TruckX📡\nhttps://truckx.com/axis-tms/', '2022-10-19', NULL, 'BAACAgEAAxkBAAIJB2LNwXPwX6yndU0DFfLv8JuE_q0TAAK2AgACeEFwRjRugovIoDkmKQQ', ''),
(128171, 'Agera 1', '-1001389029920,-1001409478844,-1001648755164,-1001730877604', '16,5', 'Maximize your earning potential with our Support Pro Dispatch services\n\n⭐️ We Analyze the market of all kinds, including DAT, Amazon, JB Hunt and book the best freight load possible with the highest prices\n\n⭐️ We Provide 24/7 high quality dispatch and update service\n\n⭐️ We Take care of back-office tasks, from customer support to billing and payment collections, and even maintain motor carrier compliance\n\n⭐️ We Set up with new brokerage companies and improve a close and friendly bond with existing ones and to be in prior to take the best load offers from the partners; \n\n\n⭐️  We Have Dedicated Lanes from Amazon and FedEx\n\n\n🚍 You pick the areas you want to drive and we negotiate hard for the best paying rates and quality routes\n\n💸 Service fee: 3 % of the gross\n\n📌 Please feel free to contact for more details\n\n@agera_r', '2022-07-06', 'images/128171.jpg', NULL, ''),
(170096, 'Axis1', '-1001648755164,-1001730877604,-1001389029920,-1001409478844', '0', 'Start using 🚚💻Axis TMS📲 🚛 using the link below & signup for a DEMO:\nhttps://pro.axistms.com/htt-start\n\n\nStart using 🚛123loadboard🚚 with the link below:\n https://www.123loadboard.com/signup/?promocode=82055\n\n\n🚚TruckX📡\nhttps://truckx.com/axis-tms/', '2022-10-19', 'images/170096.jpg', NULL, ''),
(178738, 'Eudk', '-1001735597589', '15:55', 'Bvgggddduioovc', '2022-11-17', NULL, NULL, '5121414539'),
(191370, 'Silk3', '-1001648755164,-1001730877604,-1001409478844,-1001389029920', '6,2', '◾️◾️◾️SILKROAD GROUP◾️◾️◾️\n                   ELD SERVICE\n\n✅- Monitoring 24/7;\n\n✅- Consultation;\n\n✅- Audit;\n\n✅- Individual approach with every driver;\n\n✅- Strong sence of responsibility;\n\n✅- 4 years of experience;\n\n✅- Guaranteed high quality service.\n\nIf you are interested, contact us!!!\n📞 🇺🇸+1(267)8444148\n📞 🇺🇸+1(267)6252414\n\nTelegram @ELD_Team7  @ELD_Team07', '2022-10-16', 'images/191370.jpg', NULL, '5121414539'),
(231275, 'Axs5', '-1001409478844,-1001389029920,-1001730877604,-1001648755164', '2', 'Start using 🚚💻Axis TMS📲 🚛 using the link below & signup for a DEMO:\nhttps://pro.axistms.com/htt-start\n\nStart Factoring your 🧾 invoices with 💵triumph 💵 using the link below:\n\nhttps://bit.ly/3o1GAfr\n\nStart using 🚛123loadboard🚚 with the link below:\n\nhttps://bit.ly/3yZneyb\n\nHardware links below:\n🚛Keeptruckin/Motive📡\n\nhttps://bit.ly/3yYFDes\n\n🚚TruckX📡\nhttps://truckx.com/axis-tms/', '2022-10-19', 'images/231275.jpg', NULL, ''),
(272363, 'Silk5', '-1001730877604,-1001389029920,-1001409478844,-1001648755164', '6,13', 'The Best ELD Service \n\n- Quick response;\n- Monitoring 24/7; \n- Individual approach with every driver; \n- Strong sense of responsibility;\n- Being worned when having less than 1 hour;\n\nKeep calm and let\'s grow togather!\n\nIf you are interested, contact us!!!\n📞 🇺🇸+1(267)8444148\n📞 🇺🇸+1(267)6252414\n\nTelegram @ELD_Team7  @ELD_Team07', '2022-10-16', 'images/272363.jpg', NULL, '5121414539'),
(298262, 'MARUF ELD', '-1001648755164,-1001389029920,-1001730877604,-1001409478844', '2,3,4,5,6,7,9,10,11,1,23,22,21,20,0,19,18,17,16', '🔥 We offer you our cheap and quality LOGBOOK service (24/7)\n\n🤝 The company helps everyone who wants to have a high-quality ELD service\n\n     🌎 Companies we cooperate with:\n- TT ELD;\n- GPS tag;\n- SAMSARA;\n- TFM ELD;\n- Master ELD;\n- MONITORING;\n- Blue Star ELD\n\n✅ Types of services we offer:\n- tracking all logs;\n- consulting service;\n- training of new drivers;\n- Provide individual and high-quality service to each driver;\n- preparation of documents for audit / report\n\n💯 Safety rules are your best tool!\n\n🚨 IF YOU ARE INTERESTED IN OUR SERVICE WE WOULD LOVE TO WORK WITH YOU!\n======================================================================\n✅ @manoeldservice                                \n\n📳+998(33) 117-77-00  \n                                                                         📳+998(90) 008-66-67', '2022-11-04', 'images/298262.jpg', NULL, '5121414539'),
(318542, 'SINAN 1.5', '-1001409478844,-1001730877604,-1001648755164,-1001389029920', '21', 'Got a truck 🚚? \nNeed an honest company to drive with ❤️? \nTired of being idle 😞? Underpaid 💰 ? \n\nCome join us for partnership! \nWe will keep your wheels running  🚚 and pockets full 💰💰💰! \n\n@sinanrecruiting\n203-626-4433', '2022-11-09', 'images/318542.jpg', NULL, '5121414539'),
(325505, 'Unn', '-1001409478844,-1001389029920,-1001730877604,-1001648755164', '0,8,10,2,18,16', '🇺🇸US Dispatch Corporation 🇺🇸\n\nWhy you have to Choose Our Dispatch Services?\n\n✅We negotiate the Best rates ✅Experienced and dedicated personal dispatchers \n✅True route planning\n✅Verify credit of brokers or shippers\n✅Handle all necessary faxes and paperwork, including broker setup, insurance certificates and rate confirmations\n✅Competitive dispatching rate \n✅We will also develop your MC \n\n✅We work with:Amazon,XPO,J.B Hunt,ITS,UPS,DAT, Truckstop and other huge brokers.\n\n✅We assist Dry Van, PO, Flatbed,Step Deck, Reefer \n🕒24 / 7 dispatch support\n\nWe speak Russian,English, Turkish,Uzbek \n✅Our staff is multilingual.\n✅Excellent communication with brokers  \n👆For 1 driver will assist Dispatcher, updators, supervisors,\n\nWe guaranteed weekly gross\n Solo + 10K$\n Team +15K$\n\n✅We offer an affordable fee only\n3%                                               \nWhat\'s app:+1815-907-1273\nTelegram: @Usdispatch_corporation\n\nweb: www.usdiscorp.com\nIf you are Interested, contact us!\n☎️ +1815-907-1273', '2022-10-29', 'images/325505.jpg', NULL, '5121414539'),
(328913, 'Agera 2', '-1001648755164,-1001730877604,-1001389029920,-1001409478844', '19,0', '⭐️GoldenELD offers you its resonable and high-quality services. ⭐️\n\n⭐️Now you can acquire a better service for a low price, i.e. 24/7 safety support, faster response and speedy fulfillment of requests, being ready for an audit in any situation, preparation for an audit and great deal of other amazing conveniences are propounded to you by GoldenELD.\n\nPrice list:\n\n💰ELD Subscription: 45$ Monthly per unit \n\n💰ELD Service: 115$ Monthly per unit\n\n💰overall: 160$ Monthly \n\n💰Free trial 7 days \n\n✅High-quality and fast service of the employees of our company is now at affordable and low prices. \n\n✅Be on the safe side of the road with GoldenELD !\n\n👨🏻‍💻Full time monitoring to avoid potential HOS Violations. \n\n📊Close relationship with dispatchers. \n\n📃Preparation for Audit.\n\n✅Perfect Safety\n\n💬For more details and discussions please feel free to contact 📞: \n☎️ +1 831 400 8888\n☎️ +1 646 477 7070\n📧 info@ GoldenEld. com\nTelegram @agera_r', '2022-07-06', 'images/328913.jpg', NULL, ''),
(338953, 'Dirilis', '-1001648755164,-1001730877604,-1001389029920,-1001409478844', '0,3,11,8,16,19', 'Please register on our below link for auto-booking and benefit from many cool features of the platform: \n\nhttps://dirilisgroup.com/app', '2022-10-12', 'images/338953.jpg', NULL, '5121414539'),
(385765, 'Axis4', '-1001730877604,-1001389029920,-1001409478844,-1001648755164', '18', 'Start using 🚚💻Axis TMS📲 🚛 using the link below & signup for a DEMO:\nhttps://pro.axistms.com/htt-start\n\n\nStart using 🚛123loadboard🚚 with the link below:\n https://www.123loadboard.com/signup/?promocode=82055\n\n\n🚚TruckX📡\nhttps://truckx.com/axis-tms/', '2022-10-19', 'images/385765.jpg', NULL, ''),
(392187, 'Livia', '-1001409478844,-1001389029920,-1001730877604,-1001648755164', '2,6', 'Hello everyone 🗽\n🚨If y\'all tired of slow-hand eld services, then we will help you. Livia Safety service offers you fast and guaranteed Eld services.\nThese are:\n- 24/7 ELD support\n- Consulting service\n- Team members communicate in 3 languages ( English🇺🇸, Russian🇷🇺, Uzbek🇺🇿)\n- Perfect communication with drivers\n\nDont forget, Safety first!!!\n\nFor more info: @abdulloh_safety\nPhone number:  +99898 1727067', '2022-10-29', 'images/392187.jpg', NULL, '5121414539'),
(437814, 'SINAN 2.4', '-1001389029920,-1001730877604,-1001648755164,-1001409478844', '9', 'Got a truck? \nNeed CDL-A drivers? \nWant to expand your company? \n\nLet us help you with recruiting! \n\n@sinanrecruiting\n203 626 4433', '2022-11-09', 'images/437814.jpg', NULL, '5121414539'),
(459345, 'SINAN 1.4', '-1001409478844,-1001730877604,-1001648755164,-1001389029920', '20', 'Got a truck? \nNeed CDL-A drivers? \nWant to expand your company? \n\nLet us help you with recruiting! \n\n@sinanrecruiting\n203 626 4433', '2022-11-09', 'images/459345.jpg', NULL, '5121414539'),
(488992, 'Dirilis 2', '-1001648755164,-1001730877604,-1001409478844,-1001409478844,-1001389029920', '4,14,21', 'Please register on our below link for auto-booking and benefit from many cool features of the platform: \n\nhttps://dirilisgroup.com/app', '2022-10-12', 'images/488992.jpg', NULL, '5121414539'),
(495388, 'carg', '-1001648755164,-1001389029920,-1001409478844,-1001730877604', '17,7,19,22', '⚡️High level ELD service ⚡️\n\n🛑We have experience⏱, cheap service🧍, polite staff 👨‍💻👩‍💻\n\nOur Services:\n\n•24/7 eLOG BOOK support\n•We provide support in English, Russian, Uzbek.\n•Monitoring\n•Audit\n•IFTA\n•Fast service \n\n\nWe work with all programs 👨‍💻 (GPS tab, bluestar , tt eld etc.)\n\nContact us today to sign up or if you have any questions 📞\n\n\n@Cargo_Eld_Service\n\nELD SERVICE 🚚', '2022-11-11', 'images/495388.jpg', NULL, '5121414539'),
(500075, 'SINAN 2.5', '-1001409478844,-1001389029920,-1001648755164,-1001730877604', '9', 'Got a truck 🚚? \nNeed an honest company to drive with ❤️? \nTired of being idle 😞? Underpaid 💰 ? \n\nCome join us for partnership! \nWe will keep your wheels running  🚚 and pockets full 💰💰💰! \n\n@sinanrecruiting\n203-626-4433', '2022-11-09', 'images/500075.jpg', NULL, '5121414539'),
(523636, 'livia', '-1001648755164,-1001730877604,-1001389029920,-1001409478844', '21,22,4,10,5', 'Hello everyone 🗽\n🚨If y\'all tired of slow-hand eld services, then we will help you. Livia Safety service offers you fast and guaranteed Eld services.\nThese are:\n- 24/7 ELD support\n- Consulting service\n- Team members communicate in 3 languages ( English🇺🇸, Russian🇷🇺, Uzbek🇺🇿)\n- Perfect communication with drivers\n\nDont forget, Safety first!!!\n\nFor more info: @abdulloh_safety\nPhone number:  +99898 1727067', '2022-11-03', 'images/523636.jpg', NULL, '5121414539'),
(578816, 'SINAN 1.3', '-1001730877604,-1001648755164,-1001389029920,-1001409478844', '20,23', 'WE\'RE HAVE AN IMMEDIATE NEED FOR OTR COMPANY DRIVERS! \n🚚 Great trucks: Volvo, Mack, FHL Cascadia in mint conditions! \n💵 Weekly pay: $2,200-3,500 \n✅ Percentage or CPM options available! \n\nREQUIREMENTS\n✅ 1 year of verifiable OTR experience \n✅ Clean driving record \n✅ Able to pass drug and background check \n\n😉 Truck availability is limited! \nDON\'T WAIT, CONTACT US NOW! \n203-626-4433\n@sinanrecruiting', '2022-11-09', 'images/578816.jpg', NULL, '5121414539'),
(623331, 'Axs3', '-1001730877604,-1001389029920,-1001409478844,-1001648755164', '22', 'Start using 🚚💻Axis TMS📲 🚛 using the link below & signup for a DEMO:\nhttps://pro.axistms.com/htt-start\n\n\nStart using 🚛123loadboard🚚 with the link below:\n https://www.123loadboard.com/signup/?promocode=82055\n\n\n🚚TruckX📡\nhttps://truckx.com/axis-tms/', '2022-10-19', 'images/623331.jpg', NULL, ''),
(649638, 'SINAN 1.1', '-1001648755164,-1001389029920,-1001409478844,-1001730877604', '19,22', 'Got a truck? \nNeed CDL-A drivers? \nWant to expand your company? \n\nLet us help you with recruiting! \n\n@sinanrecruiting\n203 626 4433', '2022-11-09', 'images/649638.jpg', NULL, '5121414539'),
(668673, 'Silk4', '-1001648755164,-1001730877604,-1001389029920,-1001409478844', '4,10', 'SILKROAD GROUP\n\n     ELD SERVICE\n\nEvery second of life is voluable.So save it☝️ Actually 5 minutes is too much to open a new shift😉\n\nYou deserve the highest quality.Make the right choice\n\nFor details, contact us !!!\n📞 🇺🇸+1(267)8444148\n📞 🇺🇸+1(267)6252414\n\nTelegram @ELD_Team7  @ELD_Team07', '2022-10-16', 'images/668673.jpg', NULL, '5121414539'),
(674026, 'SINAN 1.2', '-1001648755164,-1001730877604,-1001389029920,-1001409478844', '19,22', 'Got a truck 🚚? \nNeed an honest company to drive with ❤️? \nTired of being idle 😞? Underpaid 💰 ? \n\nCome join us for partnership! \nWe will keep your wheels running  🚚 and pockets full 💰💰💰! \n\n@sinanrecruiting\n203-626-4433', '2022-11-09', 'images/674026.jpg', NULL, '5121414539'),
(697201, 'Silk2', '-1001730877604,-1001389029920,-1001409478844,-1001648755164', '20,0', 'The Best ELD Service\n\n- Quick response;\n\n- 24/7 monitoring;\n\n- Being worned when having less than 1 hour;\n\n- Guarantee for being confidence;\n\nContact us!!!\n📞 🇺🇸+1(267)8444148\n📞 🇺🇸+1(267)6252414\n\nTelegram @ELD_Team7  @ELD_Team07', '2022-10-16', 'images/697201.jpg', NULL, '5121414539'),
(721547, 'ADAM', '-1001648755164,-1001730877604,-1001389029920,-1001409478844', '16,18,21,0,2,4', '✅Strong, Qualified The Consolidator Team Offers Following Services: \n\n✅ DISPATCH SERVICE!\n\n✅ Dispatch support 24/7\n\n✅ Individual approach to each driver! \n\n✅ We work with: UTXL, Coyote, Jbhunt, Amazon, FedEx, UPS, Target, Allenlund etc.\n\n\n✅✅✅SAFETY TEAM OFFERS:\n\n- MC / US DOT Registration\n- EIN Registration \n- IFTA Registration \n- IFTA Quarterly Returns  \n- IRP Registration / Vehicle registration. \n- IRP Apportioned License Plates\n- IRP Transfer / Renewal  \n- BOC 3 (Process Agents) filling\n- UCR Registration \n- HWY Use Tax (Form 2290)\n- KY, NM, NY, OR Permits \n- MCS 150 updates\n- Vehicle inspection record\n- Support during accident\n- Prepass (EZpass) / fuel card registration\n- Driver Qualification Files (MEC, MVR, PSP, Clearing House, Drug Test results)\n- Drug test compliance monitoring (Pre-employment, random)\n- Monitoring and improvement of company\'s Safety scores / CSA control (Data /Q). \n- Support and document preparation for Safety Audit. \n- Insurance support (Quotes, Binding coverages)\n- Factoring account setup\n- EXPERIENCED ELD DEPARTMENT can work with platforms: GPS Tab, ELDorado, Blue Star, Keep Trucking, etc. \n\n✅WE Also OFFER Recruiting drivers for your company! Own database of drivers! \n\n🚛  Strong solo drivers\n\n🚚🚚 Team drivers\n\nFOR MORE INFO PLEASE DM: @AdamTheConsolidator', '2022-11-17', NULL, NULL, ''),
(768977, 'Livia 2', '-1001409478844,-1001389029920,-1001730877604,-1001648755164', '23', 'Hello everyone 🗽\n🚨If y\'all tired of slow-hand eld services, then we will help you. Livia Safety service offers you fast and guaranteed Eld services.\nThese are:\n- 24/7 ELD support\n- Consulting service\n- Team members communicate in 3 languages ( English🇺🇸, Russian🇷🇺, Uzbek🇺🇿)\n- Perfect communication with drivers\n\nDont forget, Safety first!!!\n\nFor more info: @abdulloh_safety\nPhone number:  +99898 1727067', '2022-10-29', 'images/768977.jpg', NULL, '5121414539'),
(775684, 'SINAN 2..6', '-1001648755164,-1001730877604,-1001389029920,-1001409478844', '10', 'NEED TO HIRE CDL-A DRIVERS FOR YOUR FLEET? \nWANT TO EXPAND YOUR COMPANY? \n\nWe will help you with finding and recruiting hard working, qualified, and experienced drivers based on your needs. \n\nYOUR BENEFITS OF WORKING WITH US: \n✅ Lower your cost per hire! \n✅ Save time and money on advertising!\n✅ Exceptional support throughout the hiring process! \n \n👉LET US GET YOU THE BEST DRIVERS TO GROW YOUR BUSINESS! 👈\n\nContact us: \n203 626 4433\n@sinanrecruiting', '2022-11-09', 'images/775684.jpg', NULL, '5121414539'),
(788335, 'Agera 3', '-1001648755164,-1001409478844,-1001730877604,-1001389029920', '22,1', '⭐️GoldenELD offers you its resonable and high-quality services. ⭐️\n\n⭐️Now you can acquire a better service for a low price, i.e. 24/7 safety support, faster response and speedy fulfillment of requests, being ready for an audit in any situation, preparation for an audit and great deal of other amazing conveniences are propounded to you by GoldenELD.\n\nPrice list:\n\n💰ELD Subscription: 45$ Monthly per unit \n\n💰ELD Service: 115$ Monthly per unit\n\n💰overall: 160$ Monthly \n\n💰Free trial 7 days \n\n✅High-quality and fast service of the employees of our company is now at affordable and low prices. \n\n✅Be on the safe side of the road with GoldenELD !\n\n👨🏻‍💻Full time monitoring to avoid potential HOS Violations. \n\n📊Close relationship with dispatchers. \n\n📃Preparation for Audit.\n\n✅Perfect Safety\n\n💬For more details and discussions please feel free to contact 📞: \n☎️ +1 831 400 8888\n☎️ +1 646 477 7070\n📧 info@ GoldenEld. com\nTelegram @agera_r', '2022-07-06', 'images/788335.jpg', NULL, ''),
(862343, 'Axs6', '-1001409478844,-1001389029920,-1001730877604,-1001648755164', '4', '🚛 Are you looking for a TMS to keep your business profitable 💵🧾📈💰\nAxis TMS offers the most comprehensive and reliable cloud based TMS available🚚\n\n         Axis TMS offers the following:\n 🔥 💵Convenient Pricing Tiers Optimized for small to mid-size trucking companies\n 🔥 🧾 Invoice Factoring with just 1 click of a button on the Axis TMS platform \n 🔥 🚛 Load board access that is integrated with Our preferred partner 123loadboard  \n 🔥 📡 Hardware through one of our preferred partners Keeptruckin/Motive & TruckX we will get you the best deals on ELD’s GPS trackers & Dash Cams \n\nStart using 🚚💻Axis TMS📲 🚛 using the link below & signup for a DEMO:\nhttps://pro.axistms.com/htt-start\n\nStart Factoring your 🧾 invoices with 💵triumph 💵 using the link below:\n\nhttps://bit.ly/3o1GAfr\n\nStart using 🚛123loadboard🚚 with the link below:\n\nhttps://bit.ly/3yZneyb\n\nHardware for ELD’s links below:\n🚛Keeptruckin/Motive📡\n\nhttps://bit.ly/3yYFDes\n\n🚚TruckX📡\nhttps://truckx.com/axis-tms/', '2022-10-19', NULL, 'BAACAgIAAxkBAAIJSmLNwt4o9XujuovGqejABEVXSuTbAAKmJAAC8tRwSvsvp4MoBpnHKQQ', ''),
(913570, 'Silk1', '-1001730877604,-1001389029920,-1001409478844,-1001648755164', '18,22', '◾️◾️◾️SILKROAD GROUP◾️◾️◾️\n                   ELD SERVICE\n\n✅- Monitoring 24/7;\n\n✅- Consultation;\n\n✅- Audit;\n\n✅- Individual approach with every driver;\n\n✅- Strong sence of responsibility;\n\n✅- 4 years of experience;\n\n✅- Guaranteed high quality service.\n\nIf you are interested, contact us!!!\n📞 🇺🇸+1(267)8444148\n📞 🇺🇸+1(267)6252414\n\nTelegram @ELD_Team7  @ELD_Team07', '2022-10-16', 'images/913570.jpg', NULL, '5121414539'),
(923852, 'das', '-1001735597589', '21', '🇺🇸USA DISPATCHERS🇺🇿\n\nWhy choose us?\n\n 🏆<b>ALL in 1 -  IN-HOUSE</b> PROFESSIONAL EXPERTS\n- Head office in <b>US;</b>\n- <b>Easy</b> payments: <b>Zelle/ACH/Wire</b>\n\n👨🏻‍💻- DISPATCHERS & UPDATERS:\n\n✅ Working with Only with HOT🔥  loads, <b>50+</b> reputable Brokers\n✅ Finding the right load that fits your expectations.\n✅ <b>2-3 day ahead</b> strategic planing\n\n⏱- SAFETY MANAGERS\n\n✅ Helping you plan for and deal with weather delays, traffic congestion\n✅ E-books Full-management\n\n🏦- ACCOUNTING & BOOKKEEPING (extra fee)\n\n✅ Handling invoicing-billing paperwork, collection, Factoring, <b>IFTA</b> and all others\n\n🚍- FLEET MANAGEMENT\n\n✅ <b>FAST</b> solutions with <b>Truck & Trailer</b> repairs, find Best towing companies, maintenance arrangements with shops.\n\n\n🏪- <b>AUTHORITY</b>\n\n✅ We have OWN MC or can use YOUR MC\n\nGUARANTEED weekly GROSS:\nWith reliable drivers\n💵 SOLO $10-18K+\n💵 TEAM $18-25K+\n\n🔥MARCH PROMO RATES🔥\n<b>- 2.99%</b> with your MC\n<b>- 13.99%</b> under our MC\n\nIf you are Interested, contact us\n\n<b>call: <u>+14074774444</u></b>\n\n@bosa_boss\n@bosaboss_ceo', '2022-04-01', 'images/bob.jpg', NULL, '5121414539'),
(983590, 'mirkom', '-1001735597589', '14:50', '6+4565', '2022-08-16', NULL, NULL, '5121414539');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `data`
--
ALTER TABLE `data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `time_table`
--
ALTER TABLE `time_table`
  ADD PRIMARY KEY (`timetable_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `data`
--
ALTER TABLE `data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
