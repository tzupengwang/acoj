-- phpMyAdmin SQL Dump
-- version 4.2.0
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 07, 2014 at 11:04 PM
-- Server version: 5.5.38-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `acoj`
--

-- --------------------------------------------------------

--
-- Table structure for table `assoc_groups_testdata___testdata`
--

CREATE TABLE IF NOT EXISTS `assoc_groups_testdata___testdata` (
  `id_group` int(8) NOT NULL,
  `id_testdatum` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `blogarticles_files`
--

CREATE TABLE IF NOT EXISTS `blogarticles_files` (
`id` int(8) NOT NULL,
  `timestamp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_article` int(8) NOT NULL,
  `extension` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `blogposts`
--

CREATE TABLE IF NOT EXISTS `blogposts` (
`id` int(8) unsigned zerofill NOT NULL,
  `timestamp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `timestamp_lastmodified` datetime NOT NULL,
  `id_user` int(8) unsigned zerofill NOT NULL,
  `public` tinyint(1) NOT NULL,
  `title` varchar(256) NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `blogposts_tags`
--

CREATE TABLE IF NOT EXISTS `blogposts_tags` (
`id` int(8) NOT NULL,
  `timestamp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_post` int(8) NOT NULL,
  `id_tag` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `blogtags`
--

CREATE TABLE IF NOT EXISTS `blogtags` (
`id` int(8) NOT NULL,
  `timestamp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_user` int(8) NOT NULL,
  `name` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `competitions`
--

CREATE TABLE IF NOT EXISTS `competitions` (
`id` int(11) NOT NULL,
  `timestamp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_user_insert` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `time_first` datetime NOT NULL,
  `time_last` datetime NOT NULL,
  `problemlist` int(11) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `competition_problemlist`
--

CREATE TABLE IF NOT EXISTS `competition_problemlist` (
`id` int(8) NOT NULL,
  `timestamp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_competition` int(8) NOT NULL,
  `id_problem` int(8) NOT NULL,
  `rank` int(8) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

-- --------------------------------------------------------

--
-- Table structure for table `configurations`
--

CREATE TABLE IF NOT EXISTS `configurations` (
  `id` varchar(32) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `configurations`
--

INSERT INTO `configurations` (`id`, `value`) VALUES
('domain_name', 'acoj.twbbs.org'),
('name_website', 'Accepted Online Judge'),
('name_website_logogram', 'ACOJ'),
('notice_menu', 'ç›®å‰ ACOJ ç„¡äººç¶­è­·ã€‚æœ‰èˆˆè¶£ç¶­è­·çš„æœ‹å‹è«‹ Email è‡³ anlialtting@gmail.comï¼Œå…§å®¹è¡¨æ˜Žèº«ä»½å’Œæ„é¡˜å³å¯ã€‚\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `contestants_competition`
--

CREATE TABLE IF NOT EXISTS `contestants_competition` (
`id` int(8) NOT NULL,
  `id_competition` int(8) NOT NULL,
  `id_user` int(8) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
`id` int(8) NOT NULL,
  `timestamp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(256) NOT NULL,
  `introduction` text NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `timestamp_insert`, `name`, `introduction`) VALUES
(1, '2013-12-01 20:28:37', 'The Administators', 'The Administators');

-- --------------------------------------------------------

--
-- Table structure for table `groups_testdata`
--

CREATE TABLE IF NOT EXISTS `groups_testdata` (
`id` int(8) NOT NULL,
  `timestamp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_insert` int(8) NOT NULL,
  `id_problem` int(8) NOT NULL,
  `score` int(8) NOT NULL,
  `name` varchar(64) NOT NULL,
  `is_example` tinyint(1) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=97 ;

-- --------------------------------------------------------

--
-- Table structure for table `groups_users`
--

CREATE TABLE IF NOT EXISTS `groups_users` (
`id` int(8) NOT NULL,
  `timestamp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_user_upload` int(8) NOT NULL,
  `id_group` int(8) NOT NULL,
  `id_user` int(8) NOT NULL,
  `permission` int(1) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=28 ;

--
-- Dumping data for table `groups_users`
--

INSERT INTO `groups_users` (`id`, `timestamp_insert`, `id_user_upload`, `id_group`, `id_user`, `permission`) VALUES
(7, '2013-12-04 21:02:37', 2, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `page_permissions`
--

CREATE TABLE IF NOT EXISTS `page_permissions` (
`id` int(8) NOT NULL,
  `id_user` int(8) NOT NULL DEFAULT '-1',
  `id_group` int(8) NOT NULL DEFAULT '-1',
  `path` varchar(256) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=67 ;

--
-- Dumping data for table `page_permissions`
--

INSERT INTO `page_permissions` (`id`, `id_user`, `id_group`, `path`) VALUES
(1, 0, 0, '/time.php'),
(2, 0, 0, '/homepage.php'),
(3, 0, 0, '/index.php'),
(4, 0, 0, '/map.php'),
(5, 0, 1, '/admin_configuration.php'),
(6, 0, 1, '/admin.php'),
(7, 0, 0, '/introduction.php'),
(8, 0, 0, '/introduction_oj.php'),
(9, 0, 1, '/competition_insert.php'),
(10, 0, 0, '/competitions.php'),
(11, -1, -1, '/config.php'),
(12, -1, -1, '/defaultcode.php'),
(13, 0, 1, '/forum.php'),
(14, 0, 0, '/google2d7615d28accd439.html'),
(15, 0, 0, '/group_insert.php'),
(16, 0, 0, '/groups.php'),
(17, -1, -1, '/header.php'),
(18, 0, 1, '/immediate.php'),
(19, 0, 0, '/list_ojs.php'),
(20, 0, 0, '/notfound.php'),
(21, 0, 1, '/phpinfo.php'),
(22, 0, 1, '/problem_insert.php'),
(23, 0, 1, '/problem_update.php'),
(24, 0, 0, '/problems.php'),
(25, 0, 0, '/problem.php'),
(26, 0, 1, '/rater_insert.php'),
(27, 0, 0, '/raters.php'),
(28, 0, 1, '/rater_update.php'),
(29, 0, 0, '/register.php'),
(30, 1, 0, '/root_pages.php'),
(31, 1, 0, '/root.php'),
(32, 1, 0, '/root_users.php'),
(33, 0, 0, '/submission.php'),
(34, 0, 0, '/submissions.php'),
(35, 0, 0, '/submit.php'),
(36, 0, 1, '/testdatum_insert.php'),
(37, 0, 0, '/testdata.php'),
(38, 0, 0, '/testdatum.php'),
(39, 0, 1, '/testdatum_update.php'),
(40, 0, 0, '/text.php'),
(41, 0, 0, '/text_post.php'),
(42, 0, 0, '/user.php'),
(43, 0, 0, '/user_update.php'),
(44, 0, 0, '/rater.php'),
(45, 0, 0, '/ranklist.php'),
(46, 0, 0, '/group.php'),
(47, 0, 0, '/blog.php'),
(48, 0, 0, '/blog_article_insert.php'),
(49, 0, 0, '/blog_article.php'),
(50, 0, 0, '/blog_article_update.php'),
(51, 0, 0, '/blog_tags.php'),
(52, 0, 1, '/rpg_map.php'),
(53, 0, 1, '/rpg_map_insert.php'),
(54, 0, 1, '/rpg_map_list.php'),
(55, 0, 1, '/problemlists.php'),
(56, 0, 1, '/problemlist_insert.php'),
(57, 0, 1, '/rpg_characters.php'),
(58, 0, 0, '/competition.php'),
(59, 0, 0, '/competition_ranklist.php'),
(60, 0, 1, '/competition_update.php'),
(61, 0, 1, '/admin_text_list.php'),
(62, 0, 0, '/blog_article_upload.php'),
(63, -1, -1, '/defaultcode_insert_form.php'),
(64, 0, 1, '/rpg_upload.php'),
(65, 0, 1, '/rpg_character_insert.php'),
(66, 0, 1, '/testdata_group_update.php');

-- --------------------------------------------------------

--
-- Table structure for table `problemlists`
--

CREATE TABLE IF NOT EXISTS `problemlists` (
`id` int(11) NOT NULL,
  `timestamp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_user_owner` int(8) NOT NULL,
  `name` varchar(128) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `problemlist_items`
--

CREATE TABLE IF NOT EXISTS `problemlist_items` (
  `id` int(11) NOT NULL,
  `timestmp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_problemlist` int(11) NOT NULL,
  `id_problem` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `problems`
--

CREATE TABLE IF NOT EXISTS `problems` (
`id` int(4) unsigned zerofill NOT NULL,
  `timestamp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_upload` int(8) NOT NULL,
  `id_rater` int(4) NOT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  `source_short` varchar(128) NOT NULL,
  `story` text NOT NULL,
  `problem` text NOT NULL,
  `explain_input` text NOT NULL,
  `explain_output` text NOT NULL,
  `example_input` text NOT NULL,
  `example_output` text NOT NULL,
  `hint` text NOT NULL,
  `solution` text NOT NULL,
  `source` text NOT NULL,
  `limit_time_ms__total` int(12) NOT NULL DEFAULT '0',
  `limit_memory_kib__total` int(12) NOT NULL DEFAULT '0'
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=66 ;

-- --------------------------------------------------------

--
-- Table structure for table `raters`
--

CREATE TABLE IF NOT EXISTS `raters` (
`id` int(8) NOT NULL,
  `timestamp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `general` tinyint(1) NOT NULL,
  `interactive` tinyint(1) NOT NULL,
  `name` varchar(128) NOT NULL,
  `source` text NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `raters`
--

INSERT INTO `raters` (`id`, `timestamp_insert`, `general`, `interactive`, `name`, `source`, `description`) VALUES
(1, '2014-05-02 14:12:04', 1, 0, 'Comparing by Characters', '/*\r\n   acoj judge\r\n   comparing by characters\r\n */\r\n#include<cstdio>\r\n#include<cstdlib>\r\nint main(int argc,char*argv[]){\r\n	FILE*tdout=fopen(argv[2],"r");\r\n	FILE*sbout=fopen(argv[3],"r");\r\n	float rate;\r\n	while(1){\r\n		char c=fgetc(tdout),d=fgetc(sbout);\r\n		if(c==d&&d==EOF){\r\n			rate=1;\r\n			break;\r\n		}\r\n		if(c!=d){\r\n			rate=0;\r\n			break;\r\n		}\r\n	}\r\n	printf("%f\\n",rate);\r\n	fclose(tdout);\r\n	fclose(sbout);\r\n	return EXIT_SUCCESS;\r\n}\r\n', 'Comparing by Characters\r\n'),
(2, '2013-11-30 10:49:29', 1, 0, 'Comparing by Tokens', '/*\r\n   acoj judge\r\n   comparing by tokens\r\n */\r\n#include<cstdio>\r\n#include<cstdlib>\r\n#include<cstring>\r\nconst int max_token=1<<20;\r\nchar token_td[max_token],token_sb[max_token];\r\nint main(int argc,char*argv[]){\r\n	float rate;\r\n	FILE*tdout=fopen(argv[2],"r");\r\n	FILE*sbout=fopen(argv[3],"r");\r\n	while(1){\r\n		int r=fscanf(tdout,"%s",token_td);\r\n		int s=fscanf(sbout,"%s",token_sb);\r\n		if(r==EOF&&s==EOF){\r\n			rate=1;\r\n			break;\r\n		}else if(r==EOF||s==EOF){\r\n			rate=0;\r\n			break;\r\n		}\r\n		if(strcmp(token_td,token_sb)){\r\n			rate=0;\r\n			break;\r\n		}\r\n	}\r\n	printf("%f\\n",rate);\r\n	fclose(tdout);\r\n	fclose(sbout);\r\n	return EXIT_SUCCESS;\r\n}\r\n', 'Comparing by Tokens'),
(3, '2013-11-18 19:28:01', 1, 0, 'Comparing by Tokens ( line separated )', '', 'Comparing by Lines, Tokens'),
(4, '2014-05-03 17:07:19', 1, 0, 'Comparing by Graph Structures (NPC)', '', 'Comparing Graphs'),
(5, '2013-11-18 19:28:09', 1, 0, 'Comparing by Integer Sets ( line separated ) ( O(n log n) )', '', 'Comparing by Integer Sets ( O(n log n) )'),
(6, '2013-11-30 13:38:57', 0, 0, 'Problem 29 Rater', '#include<cstdio>\r\n#include<cstdlib>\r\nint main(int argc,char*argv[]){\r\n	float rate;\r\n	FILE*tdin=fopen(argv[1],"r");\r\n	FILE*sbout=fopen(argv[3],"r");\r\n	int n;\r\n	fscanf(tdin,"%i",&n);\r\n	int a,b;\r\n	fscanf(sbout,"%i%i",&a,&b);\r\n	if(a+b==n)\r\n		rate=1;\r\n	else\r\n		rate=0;\r\n	printf("%f\\n",rate);\r\n	fclose(tdin);\r\n	fclose(sbout);\r\n	return EXIT_SUCCESS;\r\n}\r\n', ''),
(7, '2014-05-04 13:25:21', 0, 1, 'Problem 30 Rater', '#include<cstdio>\r\n#include<cstdlib>\r\n#include<ctime>\r\nint main(int argc,char*argv[]){\r\n	setvbuf(stdout,NULL,_IONBF,0);\r\n	float rate=1;\r\n	int x;\r\n	FILE*testdata_input=fopen(argv[1],"r");\r\n	fscanf(testdata_input,"%i",&x);\r\n	fclose(testdata_input);\r\n	while(1){\r\n		int n;\r\n		if(scanf("%i",&n)!=1){\r\n			rate=0;\r\n			break;\r\n		}\r\n		printf("%i\\n",n<x?1:2);\r\n		rate-=0.01;\r\n		if(n==x){\r\n			puts("0");\r\n			break;\r\n		}\r\n	}\r\n	FILE*file_rate=fopen(argv[4],"w");\r\n	fprintf(file_rate,"%f\\n",rate);\r\n	fclose(file_rate);\r\n	return EXIT_SUCCESS;\r\n}\r\n', ''),
(8, '2014-05-21 18:21:18', 0, 0, 'Problem 20 Rater', '#include<cstdio>\r\n#include<cstdlib>\r\n#include<fstream>\r\n#include<iostream>\r\n#include<string>\r\n#include<vector>\r\nusing namespace std;\r\nconst int mv=1e6,me=1e6;int cv,ce;\r\nvector<int>G[mv];\r\nint vs[mv];\r\nbool exist_circle;\r\nint dfs(int v){\r\n	vs[v]=1;\r\n	for(int i=0;i<G[v].size();i++){int w=G[v][i];\r\n		vs[w]||dfs(w);\r\n		if(vs[w]==1)\r\n			exist_circle=1;\r\n	}\r\n	vs[v]=2;\r\n}\r\nint submission_ts[mv];\r\nint inverse_submission_ts[mv];\r\nint main(int argc,char*argv[]){\r\n	float rate;\r\n	FILE*testdata_input=fopen(argv[1],"r");\r\n	FILE*testdata_output=fopen(argv[2],"r");\r\n	ifstream submission_output;\r\n	submission_output.open(argv[3]);\r\n	fscanf(testdata_input,"%i%i",&cv,&ce);\r\n	for(int e=0;e<ce;e++){\r\n		int v,w;\r\n		fscanf(testdata_input,"%i%i",&v,&w);\r\n		G[v].push_back(w);\r\n	}\r\n	exist_circle=0;\r\n	for(int v=0;v<cv;v++)\r\n		vs[v]||dfs(v);\r\n	if(exist_circle){\r\n		string s;\r\n		submission_output>>s;\r\n		rate=(float)(s=="NaN");\r\n	}else{\r\n		rate=1;\r\n		for(int i=0;i<cv;i++){\r\n			if(!(submission_output>>submission_ts[i]\r\n				&&0<=submission_ts[i]&&submission_ts[i]<cv))\r\n				rate=0;\r\n		}\r\n		if(rate==0)\r\n			goto end;\r\n		fill(inverse_submission_ts,inverse_submission_ts+mv,-1);\r\n		for(int i=0;i<cv;i++){\r\n			if(inverse_submission_ts[submission_ts[i]]!=-1)\r\n				rate=0;\r\n			inverse_submission_ts[submission_ts[i]]=i;\r\n		}\r\n		if(rate==0)\r\n			goto end;\r\n		for(int v=0;v<cv;v++)\r\n			for(int i=0;i<G[v].size();i++){int w=G[v][i];\r\n				if(!(inverse_submission_ts[v]<inverse_submission_ts[w]))\r\n					rate=0;\r\n			}\r\n	}\r\nend:	printf("%f\\n",rate);\r\n	fclose(testdata_input);\r\n	fclose(testdata_output);\r\n	submission_output.close();\r\n	return EXIT_SUCCESS;\r\n}', '');

-- --------------------------------------------------------

--
-- Table structure for table `rpg_characters`
--

CREATE TABLE IF NOT EXISTS `rpg_characters` (
`id` int(8) NOT NULL,
  `timestamp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_user` int(8) NOT NULL,
  `name` varchar(128) NOT NULL,
  `gender` int(1) NOT NULL,
  `position_map` int(8) NOT NULL,
  `position_x` int(4) NOT NULL,
  `position_y` int(4) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Table structure for table `rpg_maps`
--

CREATE TABLE IF NOT EXISTS `rpg_maps` (
`id` int(8) NOT NULL,
  `name` varchar(128) NOT NULL,
  `description` text NOT NULL,
  `max_x` int(4) NOT NULL,
  `max_y` int(4) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `rpg_maps_cells`
--

CREATE TABLE IF NOT EXISTS `rpg_maps_cells` (
`id` int(8) NOT NULL,
  `id_map` int(8) NOT NULL,
  `x` int(4) NOT NULL,
  `y` int(4) NOT NULL,
  `value` int(4) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=328 ;

-- --------------------------------------------------------

--
-- Table structure for table `rpg_sync`
--

CREATE TABLE IF NOT EXISTS `rpg_sync` (
`id` int(8) NOT NULL,
  `timestamp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_character` int(8) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14980 ;

-- --------------------------------------------------------

--
-- Table structure for table `servers`
--

CREATE TABLE IF NOT EXISTS `servers` (
  `id` int(8) NOT NULL,
  `hostname` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `operating_system` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `submissions`
--

CREATE TABLE IF NOT EXISTS `submissions` (
`id` int(8) unsigned zerofill NOT NULL,
  `timestamp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_upload` int(8) NOT NULL,
  `id_problem` int(8) NOT NULL,
  `language` int(2) NOT NULL,
  `status` int(2) NOT NULL,
  `rating` float NOT NULL,
  `score` float NOT NULL DEFAULT '-1',
  `usage_time_ms` int(8) NOT NULL,
  `usage_memory_kib` int(8) NOT NULL,
  `sourcecode` text NOT NULL,
  `compilation_messages` text NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1698 ;

-- --------------------------------------------------------

--
-- Table structure for table `testdata`
--

CREATE TABLE IF NOT EXISTS `testdata` (
`id` int(8) unsigned zerofill NOT NULL,
  `timestamp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_user_insert` int(8) NOT NULL,
  `id_group` int(4) NOT NULL,
  `problem` int(8) NOT NULL,
  `name` varchar(128) NOT NULL,
  `type` int(2) NOT NULL,
  `limit_time_ms` int(24) NOT NULL,
  `limit_memory_byte` int(24) NOT NULL,
  `limit_stack_byte` int(24) NOT NULL,
  `input` longtext NOT NULL,
  `output` longtext NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=694 ;

-- --------------------------------------------------------

--
-- Table structure for table `tests`
--

CREATE TABLE IF NOT EXISTS `tests` (
`id` int(16) NOT NULL,
  `timestamp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_submission` int(8) NOT NULL,
  `id_testdata` int(8) NOT NULL,
  `code_runtime_error` int(2) NOT NULL,
  `code_invalid_systemcall` int(4) NOT NULL,
  `usage_time` int(10) NOT NULL,
  `usage_memory` int(10) NOT NULL,
  `status` int(2) NOT NULL,
  `rating` float NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=362046 ;

-- --------------------------------------------------------

--
-- Table structure for table `textposts`
--

CREATE TABLE IF NOT EXISTS `textposts` (
`id` int(8) NOT NULL,
  `timestamp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ipaddress` varchar(16) NOT NULL,
  `id_user` int(8) NOT NULL,
  `brush` int(2) NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=108103 ;

-- --------------------------------------------------------

--
-- Table structure for table `userlistitems`
--

CREATE TABLE IF NOT EXISTS `userlistitems` (
  `id` int(11) NOT NULL,
  `user_upload` int(11) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `userlists`
--

CREATE TABLE IF NOT EXISTS `userlists` (
  `id` int(11) NOT NULL,
  `id_user_insert` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `timestamp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
`id` int(8) unsigned zerofill NOT NULL,
  `timestamp_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `username` varchar(16) NOT NULL,
  `hashcode_sha1_password` varchar(40) NOT NULL,
  `password_md5` varchar(32) NOT NULL,
  `pref_lang` int(2) NOT NULL DEFAULT '-1',
  `name` varchar(64) NOT NULL,
  `school` varchar(128) NOT NULL,
  `status` varchar(128) NOT NULL,
  `email` varchar(256) NOT NULL,
  `introduction` text NOT NULL,
  `blog_title` varchar(64) NOT NULL,
  `blog_subtitle` varchar(256) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=123 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `timestamp_insert`, `username`, `hashcode_sha1_password`, `password_md5`, `pref_lang`, `name`, `school`, `status`, `email`, `introduction`, `blog_title`, `blog_subtitle`) VALUES
(00000001, '0000-00-00 00:00:00', 'root', '*', '', 3, '', '', '', '', '', '', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assoc_groups_testdata___testdata`
--
ALTER TABLE `assoc_groups_testdata___testdata`
 ADD PRIMARY KEY (`id_group`,`id_testdatum`);

--
-- Indexes for table `blogarticles_files`
--
ALTER TABLE `blogarticles_files`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blogposts`
--
ALTER TABLE `blogposts`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blogposts_tags`
--
ALTER TABLE `blogposts_tags`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blogtags`
--
ALTER TABLE `blogtags`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `competitions`
--
ALTER TABLE `competitions`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `competition_problemlist`
--
ALTER TABLE `competition_problemlist`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `configurations`
--
ALTER TABLE `configurations`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contestants_competition`
--
ALTER TABLE `contestants_competition`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `groups_testdata`
--
ALTER TABLE `groups_testdata`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `groups_users`
--
ALTER TABLE `groups_users`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `page_permissions`
--
ALTER TABLE `page_permissions`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `problemlists`
--
ALTER TABLE `problemlists`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `problemlist_items`
--
ALTER TABLE `problemlist_items`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `problems`
--
ALTER TABLE `problems`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `raters`
--
ALTER TABLE `raters`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rpg_characters`
--
ALTER TABLE `rpg_characters`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rpg_maps`
--
ALTER TABLE `rpg_maps`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rpg_maps_cells`
--
ALTER TABLE `rpg_maps_cells`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rpg_sync`
--
ALTER TABLE `rpg_sync`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `submissions`
--
ALTER TABLE `submissions`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `testdata`
--
ALTER TABLE `testdata`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tests`
--
ALTER TABLE `tests`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `textposts`
--
ALTER TABLE `textposts`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `userlistitems`
--
ALTER TABLE `userlistitems`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `userlists`
--
ALTER TABLE `userlists`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blogarticles_files`
--
ALTER TABLE `blogarticles_files`
MODIFY `id` int(8) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `blogposts`
--
ALTER TABLE `blogposts`
MODIFY `id` int(8) unsigned zerofill NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `blogposts_tags`
--
ALTER TABLE `blogposts_tags`
MODIFY `id` int(8) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `blogtags`
--
ALTER TABLE `blogtags`
MODIFY `id` int(8) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `competitions`
--
ALTER TABLE `competitions`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `competition_problemlist`
--
ALTER TABLE `competition_problemlist`
MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `contestants_competition`
--
ALTER TABLE `contestants_competition`
MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `groups_testdata`
--
ALTER TABLE `groups_testdata`
MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=97;
--
-- AUTO_INCREMENT for table `groups_users`
--
ALTER TABLE `groups_users`
MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT for table `page_permissions`
--
ALTER TABLE `page_permissions`
MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=67;
--
-- AUTO_INCREMENT for table `problemlists`
--
ALTER TABLE `problemlists`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `problems`
--
ALTER TABLE `problems`
MODIFY `id` int(4) unsigned zerofill NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=66;
--
-- AUTO_INCREMENT for table `raters`
--
ALTER TABLE `raters`
MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `rpg_characters`
--
ALTER TABLE `rpg_characters`
MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `rpg_maps`
--
ALTER TABLE `rpg_maps`
MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `rpg_maps_cells`
--
ALTER TABLE `rpg_maps_cells`
MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=328;
--
-- AUTO_INCREMENT for table `rpg_sync`
--
ALTER TABLE `rpg_sync`
MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14980;
--
-- AUTO_INCREMENT for table `submissions`
--
ALTER TABLE `submissions`
MODIFY `id` int(8) unsigned zerofill NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1698;
--
-- AUTO_INCREMENT for table `testdata`
--
ALTER TABLE `testdata`
MODIFY `id` int(8) unsigned zerofill NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=694;
--
-- AUTO_INCREMENT for table `tests`
--
ALTER TABLE `tests`
MODIFY `id` int(16) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=362046;
--
-- AUTO_INCREMENT for table `textposts`
--
ALTER TABLE `textposts`
MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=108103;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
MODIFY `id` int(8) unsigned zerofill NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=123;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
