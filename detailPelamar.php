<?php 
	session_start();
	include "../navbar.php";
	require "../database.php";

	/*$username = $_SESSION['username'];
	$role = $_SESSION["role"];
	$nama = $_SESSION["nama"];*/
	$telp = "";
	
	$conn = connectDB();
	$sql = "SELECT * FROM MAHASISWA WHERE username='mahdi.firdaus'";
	$result = pg_query($conn, $sql);
	if (!$result) {
		die("Error in SQL query: " . pg_last_error());
	}
	if (pg_num_rows($result) != 0) {
		$field = pg_fetch_array($result);
		$npm = $field[0];
		$nama = $field[1];
		$password = $field[3];
		$emailAktif = $field[5];
		$waktuKosong = $field[6];
		$bank = $field[7];
		$norek = $field[8];
	}
	
	$sql = "SELECT * FROM TELEPON_MAHASISWA WHERE npm='" . $npm . "'";
	$result = pg_query($conn, $sql);
	while($row = pg_fetch_assoc($result)){
		$telp = $telp . $row['nomortelepon'] . " ";
	}
?>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="widtd=device-widtd, initial-scale=1">
		<title>Detail Pelamar</title>
	</head>

	<body>
		<div id="maintitle">
			<h1>Detail Pelamar</h1>
		</div>
		<table>
			<tr>
				<td>Nama</td>
				<td><?php echo $nama; ?></td>
			</tr><tr>
				<td>Email</td>
				<td><?php echo $emailAktif; ?></td>
			</tr><tr>
				<td>NPM</td>
				<td><?php echo $npm; ?></td>
			</tr><tr>
				<td>Telepon</td>
				<td><?php echo $telp . "<br>"; ?></td>
			</tr><tr>
				<td>Waktu Kosong</td>
				<td><?php echo $waktuKosong; ?></td>
			</tr><tr>
				<td>Detail Rekening</td>
				<td><?php echo $bank . " - " . $norek . "<br> a/n " . $nama; ?></td>
			</tr>
		</table>

		<div id="maintitle">
			<h1>Riwayat Akademis</h1>
		</div>
		<table>
			<tr>
				<td>Basis Data Lanjut</td>
				<td>A-</td>
			</tr><tr>
				<td>Prasyarat1: Basis Data</td>
			</tr><tr>
				<td>Prasyarat2</td>
			</tr><tr>
				<td>Prasyarat3</td>
			</tr>
		</table>
		<p>Silahkan klik tombol <strong>Rekomendasikan</strong> jika ingin memilih <strong><?php echo $nama; ?></strong> sebagai Asisten, Administrator akan menerima lamaran mahasiswa tersebut jika mahasiswa tersebut jika beban jam kerja yang dimiliki oleh mahasiswa tersebut masih memadai</p>
		<button>Rekomendasikan</button>
	</body>
</html>