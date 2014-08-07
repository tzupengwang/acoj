-- MySQL dump 10.13  Distrib 5.5.32, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: acoj
-- ------------------------------------------------------
-- Server version	5.5.32-0ubuntu0.13.04.1

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
-- Table structure for table `problems`
--

DROP TABLE IF EXISTS `problems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `problems` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(128) DEFAULT NULL,
  `source` varchar(128) DEFAULT NULL,
  `story` text,
  `problem` text,
  `explain_input` text,
  `explain_output` text,
  `example_input` text,
  `example_output` text,
  `hint` text,
  `time_limit` int(10) NOT NULL DEFAULT '0',
  `memory_limit` int(10) NOT NULL DEFAULT '0',
  `stack_limit` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `problems`
--

LOCK TABLES `problems` WRITE;
/*!40000 ALTER TABLE `problems` DISABLE KEYS */;
INSERT INTO `problems` VALUES (1,'2012-11-08 03:42:51','Hello World','Brian Wilson Kernighan','A \"Hello world\" program is a computer program that outputs \"Hello, world\" on a display device. Because it is typically one of the simplest programs possible in most programming languages, it is by tradition often used to illustrate to beginners the most basic syntax of a programming language, or to verify that a language or system is operating correctly.\r\n\r\nWhile small test programs existed since the development of programmable computers, the tradition of using the phrase \"Hello, world!\" as a test message was influenced by an example program in the seminal book The C Programming Language. The example program from that book prints \"hello, world\" (without capital letters or exclamation mark), and was inherited from a 1974 Bell Laboratories internal memorandum by Brian Kernighan, Programming in C: A Tutorial, which contains the first known version:\r\n\r\nThe description above is copied from Wikipedia.\r\nhttp://en.wikipedia.org/wiki/Hello_world_program\r\n','Printing string \"hello, world\" to the standard output.\r\n','','Print \"hello, world\".\r\n','','hello, world\r\n','In C:\r\nint main(){\r\n	printf(\"hello, world\");\r\n	return 0;\r\n}\r\n\r\nIn C++:\r\n#include<iostream>\r\nint main(){\r\n	std::cout<<\"hello, world\";\r\n	return 0;\r\n}',1000,1024,32768),(2,'2012-11-08 06:53:36','A+B Problem','Accepted Online Judge','','','Two integers a, b ( $-2^{31}\\le a,b<2^{31}$ ).','The sum of the two integers.\r\n','1 2\r\n','3\r\n','',0,0,0),(3,'2012-11-09 08:47:15','Triangle','Accepted Online Judge','','','ä¸‰å€‹æ•´æ•¸ã€‚\r\n','æœ‰é—œå‘½é¡Œã€Œé€™ä¸‰å€‹æ•´æ•¸æ˜¯å¦å¯ä»¥çµ„æˆä¸€å€‹ä¸‰è§’å½¢ã€ï¼Œå¦‚æžœæ˜¯å‰‡è¼¸å‡º1ï¼Œå¦å‰‡è¼¸å‡º0ã€‚\r\n','3 4 5\r\n','1\r\n','',0,0,0),(4,'2012-12-03 06:31:46','Sorting Integers','Accepted Online Judge','','æŽ’åºã€‚','å¤šå€‹æ•´æ•¸ã€‚','è«‹å°‡æ‰€æœ‰è¼¸å…¥çš„æ•¸å­—ï¼Œå¾žå°åˆ°å¤§è¼¸å‡ºã€‚','3 5 9 4 8 2 1 6 7\r\n','1 2 3 4 5 6 7 8 9\r\n','',0,0,0),(5,'2012-12-03 13:40:55','Counting Prime Numbers','Accepted Online Judge','','è¨ˆç®—è³ªæ•¸çš„å€‹æ•¸ã€‚','è¼¸å…¥ä¸€å€‹æ•´æ•¸nã€‚','è¼¸å‡ºæ•´æ•¸nä»¥ä¸‹æœ‰å€‹è³ªæ•¸ã€‚','10000000\r\n','664579\r\n','',0,0,0);
/*!40000 ALTER TABLE `problems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sources`
--

DROP TABLE IF EXISTS `sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sources` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `problem` int(4) NOT NULL,
  `solver` int(4) NOT NULL,
  `language` int(2) NOT NULL,
  `code` text NOT NULL,
  `status` int(2) NOT NULL,
  `com_mes` text,
  `run_err` int(2) DEFAULT NULL,
  `time_usage` int(8) NOT NULL,
  `memory_usage` int(8) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sources`
--

LOCK TABLES `sources` WRITE;
/*!40000 ALTER TABLE `sources` DISABLE KEYS */;
/*!40000 ALTER TABLE `sources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `group` int(4) NOT NULL DEFAULT '0',
  `username` varchar(16) NOT NULL,
  `password_md5` varchar(32) NOT NULL,
  `pref_lang` int(2) NOT NULL DEFAULT '-1',
  `school` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2012-11-11 02:41:34',1,'root','9d49fda5f8c677d2c350bd418bece350',3,''),(2,'2012-11-11 02:45:34',1,'alt','fa0932de94cbbc057f4a4e077cb2e115',3,'è‡ºåŒ—å¸‚ç«‹å»ºåœ‹é«˜ç´šä¸­å­¸');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-09-22  4:50:42
