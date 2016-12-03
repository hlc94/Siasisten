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
      <h1 class="header center orange-text">Daftar Log</h1>
	  <h1 class="header center orange-text">Basis Data Lanjut</h1>
      <div class="row center">
        <div style='overflow-x:auto'>
          <table class='highlight bordered'>
          <thead>
            <tr>
              <th>Kategori</th>
              <th>Tanggal</th>
              <th>Jam Mulai</th>
              <th>Jam Selesai</th>
              <th>Deskripsi Kerja</th>
              <th>Status</th>
			  <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>Mengoreksi</td>
              <td>12-09-2016</td>
              <td>09:00</td>
              <td>11:00</td>
              <td>Tugas 2</td>
              <td>-</td>
			  <td><a href="#"><img src="../images/edit.png" width="20" height="20"></a> <a href="#"><img src="../images/delete.png" width="20" height="20"></a></td>
            </tr>
             <tr>
              <td>Mengawas</td>
              <td>12-09-2016</td>
              <td>10:00</td>
              <td>11:00</td>
              <td>UTS</td>
              <td>Disetujui</td>
			  <td></td>
            </tr>
			 <tr>
              <td>Mengoreksi</td>
              <td>10-09-2016</td>
              <td>10:00</td>
              <td>12:00</td>
              <td>Tugas 1</td>
              <td>ditolak</td>
			  <td></td>
            </tr>
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