<?php
/*
 * ACOJ Web Interface
 * ./blog_article_insert.php
 * Parameters: none.
 * Permission required: loggedin.
 * Version: 2014-05-17
 * Author: An-Li Alt Ting
 * Email: anlialtting@gmail.com
 */
require_once'./header.php';
function insert(){
	global$mysqli,$data_user_current;
	parameters_exist(array('title','content'))||exit;
	$mysqli->query("
			INSERT INTO `blogposts`(
				`id_user`,`public`,`title`,`content`
				)VALUE(
				'{$data_user_current['id']}',
				'".isset($_POST['is_public'])."',
				'".$mysqli->real_escape_string($_POST['title'])."',
				'".$mysqli->real_escape_string($_POST['content'])."'
			      );");
	$id=mysqli_single_select("
			SELECT LAST_INSERT_ID();");
	header("location:./blog_article.php?id=$id");
	exit;
}
function show_form(){
	global$configurations,$data_user_current,$border_head,$border_tail;
	show_head('Blog - Post - '.$configurations['name_website_logogram']);
	show_blog_menu($data_user_current['id']);
	echo
"$border_head
<br>
<form method=\"post\">
	<div style=\"text-align:center;\">
		<input type=\"text\" name=\"title\" size=\"48\" style=\"text-align:center;\">
	</div>
	<br>
	<input type=\"checkbox\" name=\"is_public\"> Public
	<textarea id=\"content\" name=\"content\" rows=\"24\" style=\"width:100%;\"></textarea><br>
	<input type=\"submit\" value=\"Post\"><br>
</form>
$border_tail
<script>
	build_tab('content');
</script>
";
	show_tail();
}
head();
$loggedin||exit;
if($_SERVER['REQUEST_METHOD']==='POST')
	insert();
else
	show_form();
tail();
?>
