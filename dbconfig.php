/*<?php
$host = "db.cs.ui.ac.id";
$user = "henry.louis ";
$password = "KanbanMusume01";
$datbase = "dbtuts";
p_connect($npm,$password);
mysql_select_db($datbase);
?>*/

<?php
	$conn = pg_connect("host=db.cs.ui.ac.id user=henry.louis password=KanbanMusume01");
	$sql = "set search_path to siasisten;";
	$result = pg_query($conn,$sql) or die("Query failed".pg_last_error());	
?>
