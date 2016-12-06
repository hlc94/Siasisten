<?php include '../model/database.php';?>

<?php
session_start();
if(isset($_POST['btn-login']))
{
	$username=mysqli_real_escape_string($connect,$_POST['username']);
	$password=mysqli_real_escape_string($connect,$_POST['password']);

	$check_mahasiswa = "SELECT * FROM mahasiswa WHERE username = '$username' AND password = '$password'";
	$check_dosen = "SELECT * FROM dosen WHERE username = '$usernamedosen' AND password = '$passworddosen'";

	$run1=mysqli_query($connect, $check_dosen);
	$run=mysqli_query($connect, $check_mahasiswa);
	
	/*
	*bagian ini untuk username dan password 
	*mahasiswa
	*/

	if (mysqli_num_rows($run)) {
		$_SESSION['username']=$username;
		echo"<li><a href='bukalowongan.php'>Buka lowongan</a></li>
		<li><a href='lowongan_mhs.php'>Lowongan mahasiswa</a></li>";
	}else{
		echo "incorrect username/password mahasiswa";
	}

	/*
	*bagian ini untuk username dan password 
	*Dosen
	*/

	if (mysqli_num_rows($run1)) {
		$_SESSION['username']=$usernamedosen;
		echo"<li><a href='lowongan_dosen.php'>Lowongan dosen</a></li>";
	}else{
		echo "incorrect username/password dosen";
		
	}
	
	/*
	*bagian ini untuk validasi admin 
	*
	*/
	
	if($_SESSION["accID"]=="admin") {
        	echo "<li><a href='testadmin.php'>Testing</a></li>;
      	} else {
        	echo "";
      	}
     }
}
?>
<!DOCTYPE html>
<html>
  <head>
    <title>LOGIN DISINI</title>
	
	<!-- Skrip CSS -->
   <link rel="stylesheet" href="style.css"/>
  
  </head>	
  <body>
	<div class="container">
		<div class="main">
	      <form action="" method="post">
			<h2>Selamat datang di sistem informasi asisten FASILKOM</h2><hr/>		
			
			<label>Username :</label>
			<input id="name" name="username" placeholder="username" type="text">
			
			<label>Password :</label>
			<input id="password" name="password" placeholder="**********" type="password">
			
			<input type="submit" name="submit" id="submit" value="Login">
		  </form>
		</div>
   </div>
 
  </body>
</html>
