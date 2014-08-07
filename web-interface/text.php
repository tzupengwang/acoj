<?php
/*
 * ACOJ Web Interface
 * ./text.php
 * Parameters: $_GET['id']
 * Permission required: none.
 * Version: 2014-05-14
 * Author: An-Li Alt Ting
 * Email: anlialtting@gmail.com
 */
require_once'./header.php';
require_once'./highlighter.php';
function show_body(){
	global$mysqli;
	$textpost=mysqli_single_row_select("
			SELECT *
			FROM `textposts`
			WHERE `id`='".$mysqli->real_escape_string($_GET['id'])."';");
	switch($textpost['brush']){
		case 0:
			$content=text_border(htmlentities($textpost['content']),0);
			break;
		case 1:
		case 2:
			$content=text_border(highlighter_cpp($textpost['content']),0);
			break;
		case 3:
			$content=text_border(highlighter_js($textpost['content']),0);
			break;
		case 4:
			$content=text_border(highlighter_html($textpost['content']),0);
			break;
		case 5:
			$content=text_border(highlighter_php($textpost['content']),0);
			break;
		case 6:
			$content=text_escape($textpost['content']);
			break;
	}
	echo
		"<div style=\"margin:auto auto auto 210px;\">".$content.'</div>';
}
head();
isset($_GET['id'])&&mysqli_single_select("
		SELECT COUNT(*)
		FROM `textposts`
		WHERE `id`='".$mysqli->real_escape_string($_GET['id'])."';")||exit;
show_head('Text - '.$configurations['name_website_logogram'],0);
show_menu();
show_body();
show_tail();
tail();
?>
