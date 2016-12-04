<?php
session_start(); 
define(ADMIN,$_SESSION['name']); 
	
	if(!session_is_registered("admin")){ 
	header("location:hoho.php"); 
	}
else 
header( 'Content-Type: text/html; charset=utf-8' );
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <title>SISTEM INFORMASI ASISTEN</title>
</head>
<body>
    <h1>ADMIN</h1>
    <p><a href="logout.php">Logout</a></p> <!-- A link for the logout page -->
    <p>Put Admin Contents</p>
</body>
</html>