<!-- <?php include '../model/database.php';
session_start();

if(!$_SESSION['accID'])  
{  
  header("Location: login.php");//redirect to login page to secure the welcome page without login access.  
}  
?> -->
  
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
    <ul id="dropdown1" class="dropdown-content">
      <li><a href="updateacc.php">Edit akun</a></li>
      <li><a href="viewAddress.php">Lihat alamat</a></li>      
      <li><a href="passport.php">Passport credentials</a></li> 
      <?php 
      if($_SESSION["accID"]=="admin") {
        echo "<li><a href='showpricebook.php'>price book</a></li>
        <li><a href='viewItems.php'>Manage item list</a></li>";
      } else {
        echo "";
      }
      ?>
    </ul>
    <ul id="dropdown2" class="dropdown-content">
      <li><a href="viewcart.php">Shopping cart</a></li>
      <li><a href="katalog.php">Item list</a></li>
      <li><a href="viewPastOrders.php">View order history</a></li>
    </ul>
    <ul id="dropdown3" class="dropdown-content">
      <li><a href="itiView.php">View Itinerary</a></li>
      <li><a href="tempItiView.php">Confirm Itinerary</a></li>
    </ul>
      <ul id="dropdown4" class="dropdown-content">
      <li><a href="maketrip.php">Order pickup</a></li>
      <li><a href="orderhandled_history.php">History</a></li>
    </ul>
      <a href="welcome.php" id="logo-container" href="#" class="brand-logo">Home</a>
      <ul class="right hide-on-med-and-down">
        <li><a class="dropdown-button" href="#!" data-activates="dropdown1">User data<i class="material-icons right">arrow_drop_down</i></a></li>
        <li><a class="dropdown-button" href="#!" data-activates="dropdown2">Shop<i class="material-icons right">arrow_drop_down</i></a></li>
        <li><a class="dropdown-button" href="#!" data-activates="dropdown3">Itinerary<i class="material-icons right">arrow_drop_down</i></a></li>
        <li><a class="dropdown-button" href="#!" data-activates="dropdown4">Order handling<i class="material-icons right">arrow_drop_down</i></a></li>
        <li><a href="logout.php?logout">Logout</a></li>
      </ul>

      <!-- <ul id="slide-out" class="side-nav">
        <li class="no padding">
          <ul class="collapsible collapsible-accordion">
            <li>
              <a class="collapsible-header">User data</a>
              <div class="collapsible-body">
                <ul>
                  <li><a href="updateacc.php">Edit akun</a></li>
                  <li><a href="viewAddress.php">Lihat alamat</a></li>      
                  <li><a href="passport.php">Passport credentials</a></li> 
                  <?php 
      if($_SESSION["accID"]=="admin") {
        echo "<li><a href='showpricebook.php'>price book</a></li>
        <li><a href='viewItems.php'>Manage item list</a></li>";
      } else {
        echo "";
      }
      ?>
                </ul>
              </div>  
            </li>
            <li>
              <a class="collapsible-header">Shop</a>
              <div class="collapsible-body">
                <ul>
                  <li><a href="viewcart.php">Shopping cart</a></li>
                  <li><a href="katalog.php">Item list</a></li>
                  <li><a href="viewPastOrders.php">View order history</a></li>
                </ul>
              </div>  
            </li>
            <li>
              <a class="collapsible-header">Itinerary</a>
              <div class="collapsible-body">
                <ul>
                  <li><a href="itiView.php">View Itinerary</a></li>
                  <li><a href="tempItiView.php">Confirm Itinerary</a></li>
                </ul>
              </div>  
            </li>
            <li>
              <a class="collapsible-header">Order handling</a>
              <div class="collapsible-body">
                <ul>
                  <li><a href="maketrip.php">Order pickup</a></li>
                  <li><a href="orderhandled_history.php">History</a></li>
                </ul>
              </div> 
            </li>
            <li>
              <a href="logout.php?logout">Logout</a>
            </li>
          </ul>
        </li>
      </ul> -->
    <!-- <a href="#" data-activates="slide-out" class="button-collapse"><i class="material-icons">menu</i></a> -->
   </div>
 </nav>
  <div class="section no-pad-bot" id="index-banner">
    <div class="container">
      <br><br>
      <h1 class="header center orange-text">Daftar Lowongan</h1>
      <div class="row center">
        <!-- <?php
        $accIDSession=$_SESSION["accID"];
        $sql = "SELECT * FROM `accaddr` 
                WHERE accID='$accIDSession'";
        $result = $connect->query($sql);

        if ($result->num_rows > 0) {
          echo "<div style='overflow-x:auto'>
          <table class='highlight bordered'>
          <thead>
                  <tr>
                    <th>Address name</th>
                    <th>Address Type</th>
                    <th>Provinsi</th>
                    <th>Kota/Kabupaten</th>
                    <th>Kecamatan</th>
                    <th>Alamat</th>
                    <th>Zip code</th>
                    <th>Country ISO Code</th>
                    <th></th>
                  </tr>
                  </thead>";
		    // output data of each row
          while($row = $result->fetch_assoc()) {
            echo "<tbody>
            <tr>
                    <td>".$row["addrID"]."</td>
                    <td>".$row["addrType"]."</td>
                    <td>".$row["prov"]."</td>
                    <td>".$row["kota_kab"]."</td>
                    <td>".$row["kec"]."</td>
                    <td>".$row["addr"]."</td>
                    <td>".$row["zip"]."</td>
                    <td>".$row["countryISOCode"]."</td>
                    <td><a href='editAddress.php?id=".$row["addrID"]."'>Edit</a> | <a href='../controller/deleteAddress.php?id=".$row["addrID"]."'>Delete</td>
                  </tr>
                  </tbody>";
          }
          //$id = $row["pbID"];
          //$_SESSION['sessionPB'] = $id;
          echo "</table>
          </div>";
        } else {
          echo "0 results";
        }
        $connect->close();
        ?> -->
        <div style='overflow-x:auto'>
          <table class='highlight bordered'>
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
          <tbody>
            <tr>
              <td>CS1232</td>
              <td>Basis Data</td>
              <td>Daniel</td>
              <td>Tutup</td>
              <td>1</td>
              <td>1</td>
              <td>1</td>
              <td><a href="#"><img src="../images/edit.png" width="20" height="20"></a> <a href="#"><img src="../images/delete.png" width="20" height="20"></a></td>
            </tr>
          </tbody>
        </table>
        </div>
        <br>
      <div class="row center">
        <a href="newAddress.php"><button class="btn waves-effect waves-light" name="action">Tambah baru</button></a>
        <br><br>

      </div>
    </div>






    <!--  Scripts-->
    <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="js/materialize.js"></script>
    <script src="js/init.js"></script>

  </body>
  </html>