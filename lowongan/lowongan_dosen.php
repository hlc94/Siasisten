<?php

include 'dbconfig.php';

$_SESSION['username']='rinisagitaayu12';

session_start();
/*if(!$_SESSION['username'])  
{  
  header("Location: login.php");//redirect to login page to secure the welcome page without login access.  
}  */
  
?>

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
        <li><a href="#">Pelamar</a></li>
        <li><a href="#">Log</a></li>
      </ul>
   </div>
 </nav>
  <div class="section no-pad-bot" id="index-banner">
    <div class="container">
      <br><br>
      <h1 class="header center orange-text">Daftar Lowongan</h1>
      <div class="row center">
        <div style='overflow-x:auto'>
          <?php
            $namadosen=$_SESSION['username'];
            $query="SELECT l.idlowongan, km.kode_mk, mk.nama as nama_mk, ds.nama as nama_dosen, l.status, l.jumlah_asisten, l.jumlah_pelamar, l.jumlah_pelamar_diterima
                    FROM kelas_mk km, mata_kuliah mk, dosen ds, lowongan l
                    WHERE km.idkelasmk=l.idkelasmk
                    AND km.kode_mk=mk.kode
                    AND l.nipdosenpembuka=ds.nip
                    AND ds.nama='$namadosen'";
            $result = $connect->query($query);
            if ($result->num_rows > 0) {
              echo 
                "<table class='highlight bordered'>
                <thead>
                  <tr>
                    <th>Kode</th>
                    <th>Mata Kuliah</th>
                    <th>Dosen Pengajar</th>
                    <th>Status</th>
                    <th>Jumlah lowongan</th>
                    <th>Jumlah pelamar</th> 
                    <th>Jumlah pelamar diterima</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>";
              while($row = $result->fetch_assoc()) {
              echo 
                "<tr>
                  <td>".$row["kode_mk"]."</td>
                  <td>".$row["nama_mk"]."</td>
                  <td>".$row["nama_dosen"]."</td>
                  <td>".$row["status"]."</td>
                  <td>".$row["jumlah_asisten"]."</td>
                  <td>".$row["jumlah_pelamar"]."</td>
                  <td>".$row["jumlah_pelamar_diterima"]."</td>
                  <td><a href='buka_lowongan.php?id=".$row["idlowongan"]."'><img src='../images/edit.png' width='20' height='20'></a> <a href='deleteLowongan_admin.php?id=".$row["idlowongan"]."'><img src='../images/delete.png' width='20' height='20'></a></td>
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