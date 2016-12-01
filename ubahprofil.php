<?php
include_once 'dbconfig.php';
if(isset($_GET['edit_npm']))
{
 $sql_query="SELECT * FROM mahasiswa WHERE npm=".$_GET['edit_npm'];
$result_set=mysql_query($sql_query);
$fetched_row=mysql_fetch_array($result_set);
}
if(isset($_POST['btn-update']))
{
 // variables for input data
//npm,nama,username,password,email-emailaktif,waktukosong,notelp,bank,norek,halamanmuka,foto
 $npm = $_POST['npm'];
 $nama = $_POST['nama'];
 $username = $_POST['username'];
 $password = $_POST['password'];
 $email = $_POST['email'];
 $email_aktif = $_POST['email_aktif'];
 $waktu_kosong = $_POST['waktu_kosong'];
 $bank = $_POST['bank'];
 $norekening = $_POST['norekening'];
 $url_mukatab = $_POST['url_mukatab'];
 $url_foto = $_POST['url_foto'];
 // variables for input data
 
 // sql query for update data into database
 $sql_query = "UPDATE mahasiswa SET password='$password',email_aktif='$email_aktif',waktu_kosong='$waktu_kosong',bank='$bank',norekening='$norekening',url_mukatab='$url_mukatab',url_foto='$url_foto' WHERE npm=".$_GET['edit_npm'];
        mysql_query($sql_query));
 // sql query for update data into database 
}
?>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Data Profil (Mahasiswa)</title>
<link rel="stylesheet" href="style.css" type="text/css" />
</head>
<body>
<center>

<div id="body">
 <div id="content">
    <form method="post">
    <table align="center">
    
    <tr>
    <td><input type="password" name="password" placeholder="password" value="<?php echo $fetched_row['password']; ?>" required /></td>
    </tr>
    
    <tr>
    <td><input type="email" name="email_aktif" placeholder="email_aktif" value="<?php echo $fetched_row['email_aktif']; ?>" required /></td>
    </tr>
    
    <tr>
    <td><input type="text" name="waktu_kosong" placeholder="waktu_kosong" value="<?php echo $fetched_row['waktu_kosong']; ?>" required /></td>
    </tr>
    
    <tr>
    <td><input type="text" name="bank" placeholder="bank" value="<?php echo $fetched_row['bank']; ?>" required /></td>
    </tr>

    <tr>
    <td><input type="number" name="norekening" placeholder="norekening" value="<?php echo $fetched_row['norekening']; ?>" required /></td>
    </tr>

    <tr>
    <td><input type="text" name="url_mukatab" placeholder="url_mukatab" value="<?php echo $fetched_row['url_mukatab']; ?>" required /></td>
    </tr>
    
    <tr>
    <td><input type="text" name="url_foto" placeholder="url_foto" value="<?php echo $fetched_row['url_foto']; ?>" required /></td>
    </tr>
    

    <tr>
    <td>
    <button type="submit" name="btn-update"><strong>UPDATE</strong></button>
    <button type="submit"><strong>CANCEL</strong></button>
    </td>
    </tr>
    
    </table>
    </form>
    </div>
</div>

</center>
</body>
</html>