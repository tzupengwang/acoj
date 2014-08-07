<?php
/*
 * ACOJ Web Interface
 * ./group_insert.php
 * Parameters: none.
 * Version: 2014-05-12
 * Author: An-Li Alt Ting
 * Email: anlialtting@gmail.com
 */
require_once'./header.php';
function insert(){
	global$mysqli;
	parameters_exist(array('name','introduction'))||exit;
	$mysqli->query("
		INSERT INTO `groups`(
			`name`,`introduction`
			)VALUE(
				'".$mysqli->real_escape_string($_GET['name'])."',
				'".$mysqli->real_escape_string($_GET['introduction'])."'
			      );");
	//if($mysqli->error){echo$mysqli->error;exit;}
	$id=mysqli_single_select("SELECT LAST_INSERT_ID();");
	header("location:./group.php?id=$id");
	exit;
}
function show_form(){
	global$configurations,$center_head,$center_tail;
	show_head('Group Insert - '.$configurations['name_website_logogram']);
	show_menu();
	echo
"$center_head
<form method=\"post\">
	Name: <input type=\"text\" name=\"name\"><br>
	Introduction:<br>
	<textarea name=\"introduction\"></textarea><br>
	<input type=\"submit\"><br>
</form>
$center_tail
";
	show_tail();
}
head();
if($_SERVER['REQUEST_METHOD']==='POST')
	insert();
else
	show_form();
tail();
?>
