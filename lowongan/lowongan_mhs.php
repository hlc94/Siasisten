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
          $query="SELECT mk.kode, mk.nama, ds.nama, lo.status, lo.jumlah_asisten, lo.jumlah_pelamar, lo.jumlah_pelamar_diterima, sla.status
                  FROM lowongan lo
                  INNER JOIN kelas_mk km ON km.idkelasmk=lo.idkelasmk
                  INNER JOIN mata_kuliah mk ON km.kode_mk=mk.kode
                  INNER JOIN lamaran la ON la.idlowongan=lo.idlowongan
                  INNER JOIN status_lamaran sla ON sla.id=la.id_st_lamaran
                  INNER JOIN mahasiswa mhs ON la.npm=mhs.npm
                  INNER JOIN dosen ds ON lo.nipdosenpembuka=ds.nip
                  WHERE mhs.username='pferguson0';"
          $result=$connect->query($query);
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
                <th>Status Lamaran</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>";
            while($row=$result->fetch_assoc()) {
              echo
                "<tr>
                  <td>".$row["kode"]."</td>
                  <td>".$row["nama_mk"]."</td>
                  <td>".$row["nama_dosen"]."</td>
                  <td>".$row["status"]."</td>
                  <td>".$row["jumlah_asisten"]."</td>
                  <td>".$row["jumlah_pelamar"]."</td> 
                  <td>".$row["jumlah_pelamar_diterima"]."</td>
                  <td>".$row["id_st_lamaran"]."</td>";
                  if ($row["id_st_lamaran"]==1) 
                  {
                    echo "<td><a href='deleteLamaran.php?id=</td>";
                  }
                  elseif ($row["id_st_lamaran"]==3)
                  {
                    echo "<td></td>";
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