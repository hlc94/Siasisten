<<!DOCTYPE HTML>
<html lang="en">
<head>
  <script type="text/javascript" src="jquery-1.7.2.min.js"></script>
  <script type="text/javascript" src="functions.js"></script>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>
  <title>Starter Template - Materialize</title>

  <!-- CSS  -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="../css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link href="../css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
</head>
<body>
  <nav class="light-blue lighten-1" role="navigation">
    <div class="nav-wrapper container">
      <a href="welcome.php" id="logo-container" href="#" class="brand-logo">Home</a>
      <ul class="right hide-on-med-and-down">
        <li><a href="#">Lowongan</a></li>
        <li><a href="#">Profil<l/a></li>
        <li><a href="#">Log</a></li>
      </ul>
   </div>
 </nav>
  <div class="section no-pad-bot" id="index-banner">
    <div class="container">
      <br><br>
      <h1 class="header center orange-text">Log Asistensi Per Mata Kuliah</h1>
      <div class="row center">
        <div style='overflow-x:auto'> 
		<?php
		$namamahasiswa=$_SESSION['username']; //hanya mahasiswayang isi
		$query="SELECT kode_mk , semester, tahun_ajaran, dosen,
				FROM KELAS_MK";
		$result = pg_query($conn, $query);
          <table class='highlight bordered'>
          <thead>
            <tr>
              <th>No.</th>
              <th>Mata Kuliah</th>
              <th>Semester</th>
              <th>Tahun Ajaran</th>
              <th>Dosen</th>
              <th>Log Asisten</th> 
            </tr>
          </thead>
          <tbody>
             if (pg_num_rows($result) > 0){
				
				while($row=pg_fetch_assoc($result)){
				echo
					"<tr>
						<td>echo $i; $i++;</td>
						<td>".$row["id_mk"]. " - " .$row["nama_mk"]."</td>
						<td>".$row["semester"]."</td>
						<td>".$row["tahun_ajaran"]."</td>
						<td>".$row["dosen"]."</td>
						<td>".$row["log_asisten"]."</td>
					
					</tr>"
				}
			} ?>
          </tbody>
        </table>
        </div>
        <br>
    </div>






    <!--  Scripts-->
    <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="js/materialize.js"></script>
    <script src="js/init.js"></script>

  </body>
</html>