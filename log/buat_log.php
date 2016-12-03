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
        <li><a href="#">Pelamar</a></li>
        <li><a href="#">Log</a></li>
      </ul>
   </div>
 </nav>
  <div class="section no-pad-bot" id="index-banner">
    <div class="container">
      <br><br>
      <h1 class="header center orange-text">Buat Log</h1>
      <div class="row center">
        <div style='overflow-x:auto'>
          <form class="col s12" method="post">
            <div class='row'>
              <div class='input-field col s12'>
                <input name='term' type='text'>
                <label for='term' class="active">Kategori</label>
              </div>
            </div>
            <div class='row'>
              <div class='input-field col s12'>
                <input name='tanggal' type='text'>
                <label for='tanggal' class="active">Tanggal</label>
              </div>
            </div>
			<div class='row'>
              <div class='input-field col s12'>
                <input name='tanggal' type='text'>
                <label for='tanggal' class="active">Jam Mulai</label>
              </div>
            </div>
			<div class='row'>
              <div class='input-field col s12'>
                <input name='tanggal' type='text'>
                <label for='tanggal' class="active">Jam Selesai</label>
              </div>
            </div>
            <div class='row'>
              <div class='input-field col s12'>
                <input name='jml_asisten' type='text'>
                <label for='jml_asisten' class="active">Deskripsi Kerja</label>
              </div>
            </div>
            <div class='row center'>
                <button class='btn waves-effect waves-light' type='submit' name='action'>Simpan<i class='material-icons right'>send</i></button>
                <a href="#"><button class='btn waves-effect waves-light'>Batal</button>
            </div>
          </form>
        </div>
        <br>
    </div>






    <!--  Scripts-->
    <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="js/materialize.js"></script>
    <script src="js/init.js"></script>

  </body>
  </html>