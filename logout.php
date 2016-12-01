<?php include '../model/database.php';

session_start();

if(isset($_GET['logout']))
{
 	session_destroy();
 	setcookie(session_name(), false, time() - 3600); 
 	header("Location: login.php");
}

mysqli_close($connect);
?>