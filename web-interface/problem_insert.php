<?php
/*
 * ACOJ Web Interface
 * ./problem_insert.php
 * Parameters: none.
 * Permission required: administrator.
 * Version: 2014-05-17
 * Author: An-Li Alt Ting
 * Email: anlialtting@gmail.com
 */
require'./header.php';
function insert(){
	global$mysqli,$data_user_current;
	parameters_exist(array(
			'id_rater',
			'is_public',
			'name',
			'source_short',
			'story',
			'problem',
			'explain_input',
			'explain_output',
			'example_input',
			'example_output',
			'hint',
			'solution',
			'limit_time_ms__total',
			'limit_memory_kib__total',
			))||exit;
	$mysqli->query("INSERT INTO `problems` (
		`id_user_upload`,
		`id_rater`,
		`is_public`,
		`name`,
		`source_short`,
		`story`,
		`problem`,
		`explain_input`,
		`explain_output`,
		`example_input`,
		`example_output`,
		`hint`,
		`solution`,
		`limit_time_ms__total`,
		`limit_memory_kib__total`
			) VALUE (
				'".$data_user_current['id']."',
				'".$mysqli->real_escape_string($_POST['id_rater'])."',
				'".$mysqli->real_escape_string($_POST['is_public'])."',
				'".$mysqli->real_escape_string($_POST['name'])."',
				'".$mysqli->real_escape_string($_POST['source_short'])."',
				'".$mysqli->real_escape_string($_POST['story'])."',
				'".$mysqli->real_escape_string($_POST['problem'])."',
				'".$mysqli->real_escape_string($_POST['explain_input'])."',
				'".$mysqli->real_escape_string($_POST['explain_output'])."',
				'".$mysqli->real_escape_string($_POST['example_input'])."',
				'".$mysqli->real_escape_string($_POST['example_output'])."',
				'".$mysqli->real_escape_string($_POST['hint'])."',
				'".$mysqli->real_escape_string($_POST['solution'])."',
				'".$mysqli->real_escape_string($_POST['limit_time_ms__total'])."',
				'".$mysqli->real_escape_string($_POST['limit_memory_kib__total'])."'
				);
	");
	$id=mysqli_single_select("SELECT LAST_INSERT_ID();");
	header("location:./problem.php?id=$id");
	exit;
}
function show_form_insert(){
	global$mysqli,$border_head,$border_tail;
	echo
"$border_head
	<form method=\"post\" enctype=\"multipart/form-data\">
		<center><input name=\"name\" size=\"64\"></center>
		<br>
		Source : <input name=\"source_short\" value=\"\" size=\"64\"><br>
		<br>
";
	echo
"	Public:
	No <input type=\"radio\" name=\"is_public\" value=\"0\" checked>
	Yes <input type=\"radio\" name=\"is_public\" value=\"1\">
	<br>
	<br>
";
	echo
"	Rater: <select name=\"id_rater\">
";
	$raters=$mysqli->query("
			SELECT `id`,`name`
			FROM `raters`;");
	while($rater=$raters->fetch_assoc())
		echo
"		<option value=\"".$rater['id']."\">".htmlentities($rater['name'])."</option>
";
	$raters->free();
	echo
"		<option value=\"0\">Else</option>
	</select>
	<br>
	<br>
";
	echo
"		<h3>Story</h3>
		<p><textarea name=\"story\" rows=\"8\" style=\"width:100%;\"></textarea><br></p>
		<h3>Problem</h3>
		<p><textarea name=\"problem\" rows=\"8\" style=\"width:100%;\"></textarea><br></p>
		<h3>Explain Input</h3>
		<p><textarea name=\"explain_input\" rows=\"8\" style=\"width:100%;\"></textarea><br></p>
		<h3>Explain Output</h3>
		<p><textarea name=\"explain_output\" rows=\"8\" style=\"width:100%;\"></textarea><br></p>
		<h3>Example Input</h3>
		<p><textarea name=\"example_input\" rows=\"8\" style=\"width:100%;\"></textarea><br></p>
		<h3>Example Output</h3>
		<p><textarea name=\"example_output\" rows=\"8\" style=\"width:100%;\"></textarea><br></p>
		<h3>Hint</h3>
		<p><textarea name=\"hint\" rows=\"8\" style=\"width:100%;\"></textarea><br></p>
		<h3>Solution</h3>
		<p><textarea name=\"solution\" rows=\"8\" style=\"width:100%;\"></textarea><br></p>
		<h3>Judge Information</h3>
		<p>
			Total time limit: <input name=\"limit_time_ms__total\" value=\"1000\"> ms<br>
			Total memory limit: <input name=\"limit_memory_kib__total\" value=\"65536\"> KiB<br>
		</p>
		<input type=\"submit\" value=\"Insert\"><br>
	</form>
$border_tail
";
}
head();
isgroup(1)||exit;
if($_SERVER['REQUEST_METHOD']==='POST')
	insert();
else{
	show_head('Problem Insert - '.$configurations['name_website_logogram']);
	show_menu();
	show_form_insert();
	show_tail();
}
tail();
?>
