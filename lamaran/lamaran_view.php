<!DOCTYPE HTML>
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
      <h1 class="header center orange-text">Daftar Pelamar Lowongan</h1>
	  <h3 class="header center orange-text">Kelas Basis Data Lanjut, 2016-2017, Ganjil</h3>
      <div class="row center">
        <div style='overflow-x:auto'>
          <?php
            $namadosen=$_SESSION['username'];
            $query="SELECT m.nama, m.npm, m.email, sl.status
					FROM mahasiswa m, lamaran lam, status_lamaran sl
					WHERE 
					m.NPM = lam.NPM AND
					lam.ID_st_lamaran = sl.ID;";
            $result = $connect->query($query);
            if ($result->num_rows > 0) {
              echo 
                "<table class='highlight bordered'>
                <thead>
                  <tr>
                    <th>No.</th>
                    <th>Nama</th>
                    <th>NPM</th>
                    <th>Email</th>
                    <th>Profil</th>
                    <th>Status</th> 
                  </tr>
                </thead>
                <tbody>";
              while($row = $result->fetch_assoc()) {
              echo 
                "<tr>
                  <td>
					<?php
						echo $i;
						$i++;
					?>
				  </td>
                  <td>".$row["nama]."</td>
                  <td>".$row["npm"]."</td>
                  <td>".$row["email"]."</td>
                  <td><a href='buka_lowongan.php?id=".$row["npm"]."'>Lihat</a></td>
                  <td>".$row["status"]."</td>
                </tr>
              </tbody>
            </table>";
          ?>
        </div>
        <br>
    </div>






    <!--  Scripts-->
    <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="js/materialize.js"></script>
    <script src="js/init.js"></script>

  </body>
  </html>