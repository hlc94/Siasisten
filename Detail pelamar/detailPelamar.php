<?php 
	session_start();
	include "../navbar.php";
	require "../database.php";

	$npm = $_GET['npm'];
	$idLamaran = $_GET['idLam'];
	$role = $_SESSION["role"];
	$telp = "";
	$ket = "";

	$conn = connectDB();
	$sql = "SELECT * FROM MAHASISWA WHERE npm='" .$npm. "'";
	$result = pg_query($conn, $sql);
	if (!$result) {
		die("Error in SQL query: " . pg_last_error());
	}
	if (pg_num_rows($result) != 0) {
		$field = pg_fetch_array($result);
		$nama = $field[1];
		$emailAktif = $field[5];
		$waktuKosong = $field[6];
		$bank = $field[7];
		$norek = $field[8];
	}
	
	$sql = "SELECT * FROM TELEPON_MAHASISWA WHERE npm='" . $npm . "'";
	$result = pg_query($conn, $sql);
	if (!$result) {
		die("Error in SQL query: " . pg_last_error());
	}
	while($row = pg_fetch_assoc($result)){
		$telp = $telp . $row['nomortelepon'] . " ";
	}

	$dataPelamar = "";
	$dataPelamar = $dataPelamar .
		"<table>
			<tr>
				<td>Nama</td>
				<td>" .$nama. "</td>
			</tr><tr>
				<td>Email</td>
				<td>" .$emailAktif. "</td>
			</tr><tr>
				<td>NPM</td>
				<td>" .$npm. "</td>
			</tr><tr>
				<td>Telepon</td>
				<td>" .$telp. "</td>
			</tr><tr>
				<td>Waktu Kosong</td>
				<td>" .$waktuKosong. "</td>
			</tr><tr>
				<td>Detail Rekening</td>
				<td>" .$bank. " - " .$norek. "<br>a/n " .$nama. "</td>
			</tr>
		</table>";

	$sql = "SELECT mk.nama, mmkmk.nilai, mk.kode
		FROM MAHASISWA m, LAMARAN la, LOWONGAN lo, KELAS_MK kmk, MATA_KULIAH mk, MHS_MENGAMBIL_KELAS_MK mmkmk 
		WHERE m.npm=la.npm AND la.idlowongan=lo.idlowongan AND lo.idkelasmk=kmk.idkelasmk AND kmk.kode_mk=mk.kode AND mmkmk.idkelasmk=kmk.idkelasmk AND mmkmk.npm=m.npm AND m.npm='" .$npm. "' AND la.idlamaran='" .$idLamaran. "'";
	$result = pg_query($conn, $sql);
	if (!$result) {
		die("Error in SQL query: " . pg_last_error());
	}
	if (pg_num_rows($result) != 0) {
		$field = pg_fetch_array($result);
		$namaMk = $field[0];
		$nilai = $field[1];
		$kodeMkParent = $field[2];
	}

	$dataAkademis = "";
	$dataAkademis = $dataAkademis .
		"<table>
			<tr>
				<td>" .$namaMk. "</td>
				<td>" .$nilai. "</td>
			</tr>";

	$sql = "SELECT mkChild.nama FROM MATA_KULIAH mkChild, MATA_KULIAH mkParent WHERE mkParent.prasyarat=mkChild.kode AND mkParent.kode='" .$kodeMkParent. "'";
	$result = pg_query($conn, $sql);
	if (!$result) {
		die("Error in SQL query: " . pg_last_error());
	}
	if (pg_num_rows($result) != 0) {
		$field = pg_fetch_array($result);
		$namaMkChild = $field[0];
	}

	$dataAkademis = $dataAkademis .
		"<tr>
			<td>Prasyarat1: " .$namaMkChild. "</td>
		</tr></table>";

	if($role == "DOSEN"){
		$ket = "<p>Silahkan klik tombol <strong>Rekomendasikan</strong> jika ingin memilih <strong>" .$nama. "</strong> sebagai Asisten, Administrator akan menerima lamaran mahasiswa tersebut jika mahasiswa tersebut jika beban jam kerja yang dimiliki oleh mahasiswa tersebut masih memadai</p>
		<button method='POST' action='detailPelamar.php?npm=" .$npm. "&idLam=" .$idLamaran. "' name='rekomendasi'>Rekomendasikan</button>";
	}
	elseif($role == "ADMIN"){
		$ket = "<p>Silahkan klik tombol <strong>Terima</strong> jika ingin memilih <strong>" .$nama. "</strong>  sebagai Asisten. Pastikan beban jam kerja yang dimiliki oleh mahasiswa tersebut masih memadai</p>
		<button method='POST' action='detailPelamar.php?npm=" .$npm. "&idLam=" .$idLamaran. "' name='terima'>Terima</button>";
	}

	if(isset($_POST["rekomendasi"]) OR isset($_POST["terima"])){
		if ($_POST["rekomendasi"] != null) {
			$sql = "UPDATE STATUS_LAMARAN SET status='2' WHERE id='" .$idLam. "'";
			$result = pg_query($conn, $sql);
		}
		if ($_POST["terima"] != null) {
			$sql = "UPDATE STATUS_LAMARAN SET status='3' WHERE id='" .$idLam. "'";
			$result = pg_query($conn, $sql);
		}
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
		<?php echo $dataPelamar; ?>

		<div id="maintitle">
			<h1>Riwayat Akademis</h1>
		</div>
		<?php echo $dataAkademis; ?>
		<?php echo $ket; ?>
	</body>
</html>