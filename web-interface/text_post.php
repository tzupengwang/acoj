<?php
/*
 * ACOJ Web Interface
 * ./text_post.php
 * Version: 2014-05-11
 * Author: An-Li Alt Ting
 * Email: anlialtting@gmail.com
 */
require_once'./header.php';
function insert(){
	global$mysqli,$data_user_current;
	parameters_exist(array('brush','content'))&&$_POST['brush']!==-1||exit;
	$mysqli->query("
			INSERT INTO `textposts` (
				`ipaddress`,`id_user`,`brush`,`content`
				) VALUE (
					'{$_SERVER['REMOTE_ADDR']}',
					'{$data_user_current['id']}',
					'".$mysqli->real_escape_string($_POST['brush'])."',
					'".$mysqli->real_escape_string($_POST['content'])."'
					);");
	$id=mysqli_single_select("SELECT LAST_INSERT_ID();");
	header("location:./text.php?id=$id");
	exit;
}
function show_form(){
	global$configurations,$border_head,$border_tail;
	show_head('Text Post - '.$configurations['name_website_logogram']);
	show_menu();
	show_tail();
}
head();
if($_SERVER['REQUEST_METHOD']==='POST')
	insert();
else
	show_form();
tail();
?>
