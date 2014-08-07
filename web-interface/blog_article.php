<?php
/*
 * ACOJ Web Interface
 * ./blog_article.php
 * Parameters: $_GET['id'].
 * Permission required: none.
 * Version: 2014-05-17
 * Author: An-Li Alt Ting
 * Email: anlialtting@gmail.com
 */
require_once'./header.php';
require_once'./highlighter.php';
function delete_article(){
	global$mysqli,$article;
	isuser($article['id_user'])||exit;
	$mysqli->query("DELETE FROM `blogposts`
			WHERE `id`='".$article['id']."';");
	header("location:./blog.php?id={$article['id_user']}");
	exit;
}
function insert(){
	global$mysqli,$id,$id_e;
	$parameters=array('id_tag');
	foreach($parameters as $x){
		if(!isset($_POST[$x]))
			exit(0);
		$$x=$_POST[$x];
		${$x.'_e'}=$mysqli->real_escape_string($$x);
	}
	$mysqli->query("INSERT INTO `blogposts_tags`
			(`id_post`,`id_tag`)
			VALUE('$id_e','$id_tag_e');");
	if($mysqli->error)
		echo$mysqli->error;
	refresh_to_clear_post();
}
function remove_tag(){
	global$mysqli;
	global$id,$id_e;
	$parameters=array('remove');
	foreach($parameters as $x){
		if(!isset($_GET[$x]))
			exit(0);
		$$x=$_GET[$x];
		${$x.'_e'}=$mysqli->real_escape_string($$x);
	}
	$mysqli->query("DELETE FROM `blogposts_tags`
			WHERE `id`='$remove_e'
			;");
}
function show_operations($uid,$article){
	global$mysqli;
	global$loggedin,$data_user_current;
	global$id,$id_e;
	echo
'<form id="form_delete" method="get" action="./blog_article.php" style="display:none;">
	<input type="hidden" name="id" value="'.$id.'">
	<input type="hidden" name="delete">
</form>
<script>
	function onclick_delete(){
		if(confirm("Are you sure you want to delete this article?"))
			document.forms[\'form_delete\'].submit();
	}
</script>
<p style="text-align:center;">
';
	echo
"	<a href=\"./blog_article.php?id=$id&amp;print\" target=\"_blank\">Print frendly</a>
";
	if(isuser($uid)){
		echo
"	| <a href=\"./blog_article_update.php?id=$id\">Update</a>
	| <a href=\"#\" onclick=\"onclick_delete();\">Delete</a>
	| <a href=\"./blog_article_upload.php?id=$id\">Upload</a>
";
	}
	echo
"	<br>
	Insert: ".htmlentities($article['timestamp_insert']).", last modified: ".htmlentities($article['timestamp_lastmodified']).(isuser($uid)?', '.($article['public']?'public':'private'):'')."
</p>
<form style=\"text-align:center;\" method=\"post\">
	Tags:
";
	$res_edges=$mysqli->query("
			SELECT `id`,`id_tag` AS `tid`
			FROM `blogposts_tags`
			WHERE `id_post`='$id'
			ORDER BY(
				SELECT `name`
				FROM `blogtags`
				WHERE `id`=`tid`
				)
			;
			");
	if($mysqli->error)
		echo$mysqli->error;
	while($edge=$res_edges->fetch_assoc()){
		echo
"	".hlink_tag($edge['tid'])."
";
		if(isuser($uid))
		echo
"	(<a href=\"?id=$id&remove={$edge['id']}\">X</a>)
";
	}
	$res_edges->free();
	if(isuser($uid)){
		echo
"<br>
<select name=\"id_tag\" onchange=\"this.form.submit();\">
		<option value=\"-1\">&nbsp;</option>
";
		$res_tags=$mysqli->query("
				SELECT *
				FROM `blogtags`
				WHERE `id_user`='$uid'
				ORDER BY `name`;");
		while($tag=$res_tags->fetch_assoc()){
			echo
"	<option value=\"{$tag['id']}\">{$tag['name']}</option>
";
		}
		$res_tags->free();
		echo
"</select>
";
	}
echo
"</form>
";
}
function show_form(){
	global$border_head,$border_tail,$id,$id_e,$print;
	$article=mysqli_single_row_select("
			SELECT *
			FROM `blogposts`
			WHERE `id`='$id_e';
			");
	if(!$article['public']&&!isuser($article['id_user']))
		exit(0);
	$user_blog=mysqli_single_row_select("
			SELECT `username`,`blog_title`
			FROM `users`
			WHERE `id`='{$article['id_user']}';");
	$html_title="{$article['title']} - ".($user_blog['blog_title']!==''?$user_blog['blog_title']:$user_blog['username']."'s Blog");
	show_head($html_title,!$print);
	if(!$print){
		show_blog_menu($article['id_user']);
		show_operations($article['id_user'],$article);
	}
	$user_name=mysqli_single_select("
			SELECT `name`
			FROM `users`
			WHERE `id`='{$article['id_user']}'");
	if($article['timestamp_lastmodified']==='0000-00-00 00:00:00')
		$article['timestamp_lastmodified']=$article['timestamp_insert'];
	echo
"<br>
<br>
$border_head
	<h2 style=\"text-align:center;\">".htmlentities($article['title'])."</h2>
	<p style=\"text-align:center;\">
		".htmlentities($user_name)."<br>
		<br>
		".htmlentities((new DateTime($article['timestamp_lastmodified']))->format('F jS, Y'))."<br>
	</p>
	<br>
	".text_escape($article['content'])."
$border_tail
";
	if(!$print){
		show_operations($article['id_user'],$article);
		show_tail();
	}
}
isset($_GET['id'])||exit;
head();
$id=$_GET['id'];
$id_e=$mysqli->real_escape_string($_GET['id']);
$article=mysqli_single_row_select("
		SELECT *
		FROM `blogposts`
		WHERE `id`='".$mysqli->real_escape_string($_GET['id'])."';");
$print=isset($_GET['print']);
if($_SERVER['REQUEST_METHOD']==='POST')
	insert();
else{
	if(isset($_GET['delete']))
		delete_article();
	if(isset($_GET['remove']))
		remove_tag();
	show_form();
}
tail();
?>
