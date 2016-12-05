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
      <h1 class="header center orange-text">Daftar Lowongan</h1>
      <div class="row center">
        <div style='overflow-x:auto'>
        <?php
          $query="SELECT mk.kode, mk.nama as nama_mk, ds.nama as nama_dosen, lo.status, lo.jumlah_asisten, lo.jumlah_pelamar, lo.jumlah_pelamar_diterima, la.id_st_lamaran
                  from mata_kuliah mk, dosen ds, lowongan lo, lamaran la, kelas_mk km
                  where lo.idkelasmk=km.idkelasmk
                  and mk.kode=km.kode_mk
                  and lo.nipdosenpembuka=ds.nip
                  and la.idlowongan=lo.idlowongan
                  group by mk.kode;"
          $result = pg_query($conn, $query);
          if (pg_num_rows($result) > 0) {
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
                <th>Status Lamaran</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>";
            while($row=pg_fetch_assoc($result)) {
              echo
                "<tr>
                  <th>".$row["kode"]."</th>
                  <th>".$row["nama_mk"]."</th>
                  <th>".$row["nama_dosen"]."</th>
                  <th>".$row["status"]."</th>
                  <th>".$row["jumlah_asisten"]."</th>
                  <th>".$row["jumlah_pelamar"]."</th> 
                  <th>".$row["jumlah_pelamar_diterima"]."</th>
                  <th>".$row["id_st_lamaran"]."</th>";
                  if ($row["id_st_lamaran"]==1) {
                    echo "<th><a href='deleteLamaran.php?id=</th>";
                  }
                  
                </tr>";
            }
          }
        ?> 
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