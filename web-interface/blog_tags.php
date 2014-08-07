<?php
/*
 * ACOJ Web Interface
 * ./blog_tags.php
 * Version: 2014-05-21
 * Author: An-Li Alt Ting
 * Email: anlialtting@gmail.com
 */
require_once'./header.php';
function insert(){
	global$mysqli,$data_user_current;
	$name=$_POST['name'];
	$name_e=$mysqli->real_escape_string($name);
	$mysqli->query("INSERT INTO `blogtags`
			(`id_user`,`name`)
			VALUE (
				'{$data_user_current['id']}',
				'$name_e'
			      )
			;");
	refresh_to_clear_post();
}
function remove(){
	global$mysqli;
	$id=$_GET['remove'];
	$id_e=$mysqli->real_escape_string($id);
	$mysqli->query("DELETE FROM `blogtags`
			WHERE `id`='$id_e'
			;");
}
function show_operations(){
	echo
"	<form method=\"post\" style=\"text-align:center;\">
		<input type=\"text\" name=\"name\">
		<input type=\"submit\" value=\"Insert\">
	</form>
";
}
function show_form(){
	global$mysqli,$configurations,$data_user_current,$center_head,$center_tail;
show_head('Tags - Blog - '.$configurations['name_website_logogram']);
show_blog_menu($data_user_current['id']);
show_operations();
	echo
"$center_head
<p style=\"line-height:32px;\">
";
	$res_tag=$mysqli->query("
			SELECT `id`,`name`
			FROM `blogtags`
			WHERE `id_user`='{$data_user_current['id']}'
			ORDER BY `name`
			;");
	while($tag=$res_tag->fetch_assoc()){
		echo
"	".hlink_tag($tag['id'])."(<a href=\"?remove={$tag['id']}\">X</a>)
";
	}
	$res_tag->free();
	echo
"</p>
$center_tail
";
show_operations();
show_tail();
}
head();
if($_SERVER['REQUEST_METHOD']==='POST')
	insert();
if(isset($_GET['remove']))
	remove();
show_form();
tail();
?>
