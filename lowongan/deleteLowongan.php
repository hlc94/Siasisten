<?php

	include 'dbconfig.php';

	session_start();

	$idLowongan=$_GET["id"];

	$sql="DELETE FROM LOWONGAN WHERE idLowongan='$idLowongan'";

	pg_query($conn, $sql);

	if(pg_affected_rows($conn) > 0){
		echo "<script type='text/javascript'>";
	    echo "alert('Lowongan dihapus');
	    location.href='lowongan_admin.php';";    
	    echo "</script>";
	} else {
		echo "<script type='text/javascript'>";
	    echo "alert('Gagal menghapus lowongan');
	    location.href='lowongan_admin.php';";    
	    echo "</script>";
	}
?>
