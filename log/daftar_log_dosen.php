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
      <h1 class="header center orange-text">Daftar Log</h1>
      <div class="row center">
        <div style='overflow-x:auto'>
          <form class="col s12" method="post">
            <div class='row'>
              <div class='input-field col s12'>
                <input name='term' type='text' value='Ganjil, 2016'>
                <label for='term' class="active">Term</label>
              </div>
            </div>
            <div class='row'>
              <div class='input-field col s12'>
                <input name='tanggal' type='text' value='CS1234 Basis Data Lanjut'>
                <label for='tanggal' class="active">Mata Kuliah</label>
              </div>
            </div>
			<div class='row'>
              <div class='input-field col s12'>
                <input name='tanggal' type='text' value='Budi Sanjaya'>
                <label for='tanggal' class="active">Nama</label>
              </div>
            </div>
          </form>
        </div>
        <br>
    </div>

	<div class="row center">
        <div style='overflow-x:auto'>
          <table class='highlight bordered'>
          <thead>
            if (pg_num_rows($result) > 0){
				
				while($row=pg_fetch_assoc($result)){
				echo
					"<tr>
						<td>echo $i; $i++;</td>
						<td>".$row["nama_mk"]."</td>
						<td>".$row["semester"]."</td>
						<td>".$row["tahun_ajaran"]."</td>
						<td>".$row["dosen"]."</td>
						<td>".$row["log_asisten"]."</td>
					
					</tr>"
				}
			}
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