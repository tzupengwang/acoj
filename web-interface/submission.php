<?php
/*
 * ACOJ Web Interface
 * ./submission.php
 * Parameters: $_GET['id'].
 * Permission required: none.
 * Version: 2014-05-22
 * Author: An-Li Alt Ting
 * Email: anlialtting@gmail.com
 */
require_once'./header.php';
require_once'./highlighter.php';
function show_operations(){
	global$data_submission;
	if(isgroup(1))
		echo
"<p style=\"text-align:center;\">
	<a href=\"?id=".($data_submission['id']-1)."\"><span style=\"color:gray;\">Previous</span></a>
	| <a href=\"?id=".($data_submission['id']+1)."\"><span style=\"color:gray;\">Next</span></a>
	| <a href=\"?id={$data_submission['id']}&rejudge\"><span style=\"color:gray;\">Rejudge</span></a>
</p>
";
}
function show_body_xml(){
	global$mysqli,$border_head,$border_tail;
	global$data_submission;
	header("Content-Type:text/xml");
	$language=data_language();
	$name_runtime_error=data_name_runtime_error();
	$name_syscall=data_name_syscall();
	$problem_result=$mysqli->query("
			SELECT `name`
			FROM `problems`
			WHERE `id`='{$data_submission['id_problem']}';");
	$problem=$problem_result->fetch_assoc();
	$problem_result->free();
	$data_submissioncode_html=htmlentities($data_submission['sourcecode']);
	$name_status=data_status();
	echo
"<submission>
";
	if($data_submission['status']>1||1){
		echo
"	<tests>
";
		$res=$mysqli->query("
				SELECT
				`id`,
				`limit_time_ms`,
				`limit_memory_byte`
				FROM `testdata`
				WHERE `problem`='{$data_submission['id_problem']}'
				ORDER BY `id_group`,`id`;");
		while($testdata=$res->fetch_assoc()){
			$test=mysqli_single_row_select("
				SELECT
				`timestamp_insert`,
				`usage_time`,
				`usage_memory`,
				`rating`,
				`status`,
				`code_invalid_systemcall`,
				`code_runtime_error`,
				`status`
				FROM `tests`
				WHERE `id_submission`='{$data_submission['id']}'
				AND `id_testdata`='{$testdata['id']}';");
			$usage_time=$test?$test['usage_time']:0;
			$usage_memory=$test?$test['usage_memory']:0;
			$rating=$test?$test['rating']:0;
			$status=$test?$test['status']:0;
			$code_invalid_systemcall=$test?$test['code_invalid_systemcall']:0;
			$code_runtime_error=$test?$test['code_runtime_error']:0;
			echo
"		<test>
			<id>".$testdata['id']."</id>
			<timestamp_insert>".$test['timestamp_insert']."</timestamp_insert>
			<usage_time_ms>$usage_time</usage_time_ms>
			<usage_memory_byte>".($usage_memory*1024)."</usage_memory_byte>
			<status>$status</status>
			<rating>$rating</rating>
			<code_runtime_error>$code_runtime_error</code_runtime_error>
			<code_invalid_systemcall>$code_invalid_systemcall</code_invalid_systemcall>
			echo
		</test>
";
		}
		echo
"	</tests>
	<groups>
";
		$score_total=0;
		$score_full=0;
		$groups=$mysqli->query("
				SELECT `id`,`score`
				FROM `groups_testdata`
				WHERE `id_problem`='".$data_submission['id_problem']."';");
		while($group=$groups->fetch_assoc()){
			$string_status_testdata="";
			$is_accepted=true;
			$testdata=$mysqli->query("
					SELECT `id_testdatum`
					FROM `assoc_groups_testdata___testdata`
					WHERE `id_group`='".$group['id']."';");
			while($testdatum=$testdata->fetch_assoc()){
				$status_testdatum=mysqli_single_select("
						SELECT `status`
						FROM `tests`
						WHERE `id_submission`='".$data_submission['id']."'
						AND `id_testdata`='".$testdatum['id_testdatum']."';");
				$name_testdatum=mysqli_single_select("
						SELECT `name`
						FROM `testdata`
						WHERE `id`='".$testdatum['id_testdatum']."';");
				$string_status_testdata.=
"				<testdatum>".$testdatum['id_testdatum']."</testdatum>
				<status>".$status_testdatum."</status>
";
				$is_accepted=$is_accepted&&$status_testdatum==7;
			}
			if($is_accepted)
				$score_total+=$group['score'];
			$score_full+=$group['score'];
			$testdata->free();
			echo
"		<group>
			<id>".$group['id']."</id>
			<score>".($is_accepted?$group['score']:0)."/".$group['score']."</score>
			<status>
$string_status_testdata
			</status>
		</group>
";
		}
		$groups->free();
		echo
"	</groups>
</submission>
";
	}

}
function show_body(){
	global$mysqli,$border_head,$border_tail;
	global$data_submission;
	$language=data_language();
	$name_runtime_error=data_name_runtime_error();
	$name_syscall=data_name_syscall();
	$problem_result=$mysqli->query("
			SELECT `name`
			FROM `problems`
			WHERE `id`='{$data_submission['id_problem']}';");
	$problem=$problem_result->fetch_assoc();
	$problem_result->free();
	$data_submissioncode_html=htmlentities($data_submission['sourcecode']);
	$name_status=data_status();
	echo
"$border_head
	<br>
	ID: {$data_submission['id']}<br>
	<br>
	Time: {$data_submission['timestamp_insert']}<br>
	<br>
	Problem: ".hlink_problem($data_submission['id_problem'])."<br>
	<br>
	Solver: ".hlink_user($data_submission['id_user_upload'])."<br>
	<br>
	Language: {$language[$data_submission['language']]}<br>
	<br>
	Total time usage: {$data_submission['usage_time_ms']} ms<br>
	<br>
	Total memory usage: {$data_submission['usage_memory_kib']} KiB<br>
	<br>
	Status: {$name_status[$data_submission['status']]}<br>
	<br>
	Score: ".$data_submission['score']."<br>
	<br>
";
	if($data_submission['status']>1||1){
		echo
"	<h3><a href=\"javascript:toggle_verdict();\">Verdict</a></h3>
	<div id=\"verdict\">
	<table class=\"shadow\" style=\"margin:0px auto;\" width=\"100%\">
		<caption><b>Testdata</b></caption>
		<tr>
			<td><b>ID</b></td>
			<td><b>Time</b></td>
			<td><b>Time usage</b></td>
			<td><b>Memory usage</b></td>
			<td><b>Status</b></td>
			<td><b>Rating</b></td>
			<td><b><a title=\"Runtime error\">RE</a></b></td>
			<td><b><a title=\"Permission denied\">PD</a></b></td>
		</tr>
";
		$res=$mysqli->query("
				SELECT
				`id`,
				`limit_time_ms`,
				`limit_memory_byte`
				FROM `testdata`
				WHERE `problem`='{$data_submission['id_problem']}'
				ORDER BY `id_group`,`id`;");
		while($testdata=$res->fetch_assoc()){
			$test=mysqli_single_row_select("
				SELECT
				`timestamp_insert`,
				`usage_time`,
				`usage_memory`,
				`rating`,
				`status`,
				`code_invalid_systemcall`,
				`code_runtime_error`,
				`status`
				FROM `tests`
				WHERE `id_submission`='{$data_submission['id']}'
				AND `id_testdata`='{$testdata['id']}';");
			$usage_time=$test?$test['usage_time']:0;
			$usage_memory=$test?$test['usage_memory']:0;
			$rating=$test?$test['rating']:0;
			$status=$test?$test['status']:0;
			$code_invalid_systemcall=$test?$test['code_invalid_systemcall']:0;
			$code_runtime_error=$test?$test['code_runtime_error']:0;
			echo
"		<tr>
			<td style=\"text-align:right;\">
				<a href=\"./testdatum.php?id=".$testdata['id']."\">".$testdata['id']."</a>
			</td>
			<td id=\"td_timestamp_insert_".$testdata['id']."\">".$test['timestamp_insert']."</td>
			<td style=\"text-align:right;\">
				<span id=\"span_usage_time_ms_".$testdata['id']."\">$usage_time</span>
				/{$testdata['limit_time_ms']} ms
				</td>
			<td style=\"text-align:right;\">
				<span id=\"span_usage_memory_kib_".$testdata['id']."\">$usage_memory</span>
				/".($testdata['limit_memory_byte']/1024)." KiB
			</td>
			<td id=\"td_status_".$testdata['id']."\">
				<span class=\"".($status==7?"status_accepted":"status_nonaccepted")."\">{$name_status[$status]}</span>
			</td>
			<td id=\"td_rating_".$testdata['id']."\">$rating</td>
			<td>{$name_runtime_error[$code_runtime_error]}</td>
			<td>".(
			$code_invalid_systemcall
			?
				isset($name_syscall[$code_invalid_systemcall])
				?("Disallowed system call:<br>".$name_syscall[$code_invalid_systemcall]."($code_invalid_systemcall)")
				:("Disallowed system call: ".$code_invalid_systemcall)
			:"None"
			)."</td>
		</tr>
";
		}
		echo
"	</table>
	<br>
	<table class=\"shadow\" style=\"margin:0px auto;\" width=\"100%\">
		<caption><b>Testdata Groups</b></caption>
		<tr>
			<td><b>ID</b></td>
			<td><b>Score</b></td>
			<td><b>Testdata</b></td>
		</tr>
";
		$score_total=0;
		$score_full=0;
		$groups=$mysqli->query("
				SELECT `id`,`score`
				FROM `groups_testdata`
				WHERE `id_problem`='".$data_submission['id_problem']."';");
		while($group=$groups->fetch_assoc()){
			$string_status_testdata="";
			$is_accepted=true;
			$testdata=$mysqli->query("
					SELECT `id_testdatum`
					FROM `assoc_groups_testdata___testdata`
					WHERE `id_group`='".$group['id']."';");
			while($testdatum=$testdata->fetch_assoc()){
				$status_testdatum=mysqli_single_select("
						SELECT `status`
						FROM `tests`
						WHERE `id_submission`='".$data_submission['id']."'
						AND `id_testdata`='".$testdatum['id_testdatum']."';");
				$name_testdatum=mysqli_single_select("
						SELECT `name`
						FROM `testdata`
						WHERE `id`='".$testdatum['id_testdatum']."';");
				$string_status_testdata.=
					$testdatum['id_testdatum'].". ".$name_testdatum.": <span class=\"".($status_testdatum==7?"status_accepted":"status_nonaccepted")."\">".$name_status[$status_testdatum]."</span><br>";
				$is_accepted=$is_accepted&&$status_testdatum==7;
			}
			if($is_accepted)
				$score_total+=$group['score'];
			$score_full+=$group['score'];
			$testdata->free();
			echo
"		<tr>
			<td>".$group['id']."</td>
			<td>".($is_accepted?$group['score']:0)."/".$group['score']."</td>
			<td>$string_status_testdata</td>
		</tr>
";
		}
		$groups->free();
		echo
"	</table>
	</div>
";
	}
	echo
"	<h3><a href=\"javascript:toggle_sourcecode();\">Source Code</a></h3>
	<div id=\"sourcecode\">
	Length: ".strlen($data_submission['sourcecode'])." Byte(s)<br>
	".text_border(highlighter_cpp($data_submission['sourcecode']))."
	</div>
";
	if($data_submission['compilation_messages']!=='')
		echo
"	<h3><a href=\"javascript:toggle_compilationmessages();\">Compilation Messages</a></h3>
	<div id=\"compilationmessages\">
	".text_border(htmlentities($data_submission['compilation_messages']))."
	</div>
";
	echo
"	<br>
$border_tail
<script>
var name_status=[
";
	$name_status=data_status();
	for($i=0;$i<count($name_status);$i++)
		echo
"	'".$name_status[$i]."',
";
	echo
"];
function update_submission(){
	setTimeout(update_submission,1000);
	var submission=loadXMLDoc('?id=".$data_submission['id']."&xml');
	var tests=submission.getElementsByTagName('test');
	for(var i=0;i<tests.length;i++){
		var test=tests[i];
		var id=test.getElementsByTagName('id')[0].childNodes[0].nodeValue;
		var timestamp_insert=test.getElementsByTagName('timestamp_insert')[0].childNodes[0].nodeValue;
		var usage_time_ms=test.getElementsByTagName('usage_time_ms')[0].childNodes[0].nodeValue;
		var usage_memory_byte=test.getElementsByTagName('usage_memory_byte')[0].childNodes[0].nodeValue;
		var status=test.getElementsByTagName('status')[0].childNodes[0].nodeValue;
		var rating=test.getElementsByTagName('rating')[0].childNodes[0].nodeValue;
		document.getElementById('td_timestamp_insert_'+id).innerHTML=timestamp_insert;
		document.getElementById('span_usage_time_ms_'+id).innerHTML=usage_time_ms;
		document.getElementById('span_usage_memory_kib_'+id).innerHTML=usage_memory_byte/1024;
		document.getElementById('td_status_'+id).innerHTML=name_status[status];
		document.getElementById('td_rating_'+id).innerHTML=rating;
	}
}
function toggle_verdict(){
	$('#verdict').toggle(500);
}
function toggle_sourcecode(){
	$('#sourcecode').toggle(500);
}
function toggle_compilationmessages(){
	$('#compilationmessages').toggle(500);
}
$(\"#verdict\").hide();
$(\"#sourcecode\").hide();
$(\"#compilationmessages\").hide();
update_submission();
</script>
";
}
head();
isset($_GET['id'])&&($id_submission=database_id('submissions',$_GET['id']))||exit;
if(isgroup(1)){
	if(isset($_GET['rejudge'])){
		$submission=new submission($id_submission);
		$submission->rejudge();
		header("location:./submission.php?id=".$id_submission);
		exit;
	}
	if(isset($_GET['delete'])){
		$mysqli->query("
				DELETE FROM `submissions`
				WHERE `id`='".$mysqli->real_escape_string($_GET['id'])."';");
		header('location:./submissions.php');
	}
}
$data_submission=mysqli_single_row_select("
		SELECT
		`id`,
		`id_user_upload`,
		`id_problem`,
		`timestamp_insert`,
		`language`,
		`usage_time_ms`,
		`usage_memory_kib`,
		`status`,
		`score`,
		`sourcecode`,
		`compilation_messages`
		FROM `submissions`
		WHERE `id`='".$mysqli->real_escape_string($_GET['id'])."';");
if(isset($_GET['xml'])){
	show_body_xml();
}else{
	show_head("{$data_submission['id']} - Submission - ".$configurations['name_website_logogram']);
	show_menu();
	show_operations();
	show_body();
	show_operations();
	show_tail();
}
tail();
?>
