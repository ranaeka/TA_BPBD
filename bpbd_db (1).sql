-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 25 Nov 2020 pada 07.48
-- Versi server: 10.1.36-MariaDB
-- Versi PHP: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bpbd_db`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `bencana`
--

CREATE TABLE `bencana` (
  `id_bencana` int(11) NOT NULL,
  `id_jenis_bencana` int(11) NOT NULL,
  `nama_bencana` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jenis_bencana`
--

CREATE TABLE `jenis_bencana` (
  `id_jenis_bencana` int(11) NOT NULL,
  `jenis_bencana` varchar(155) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `laporan`
--

CREATE TABLE `laporan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_pelapor` int(11) NOT NULL,
  `Id_petugas` int(11) NOT NULL,
  `id_bencana` int(11) NOT NULL,
  `id_jenis_bencana` int(11) NOT NULL,
  `no_hp` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kecamatan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `desa` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_bencana` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `garis_bujur` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `garis_lintang` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto_laporan` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `penyebab_bencana` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_laporan` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `laporan`
--

INSERT INTO `laporan` (`id`, `id_pelapor`, `Id_petugas`, `id_bencana`, `id_jenis_bencana`, `no_hp`, `kecamatan`, `desa`, `jenis_bencana`, `garis_bujur`, `garis_lintang`, `foto_laporan`, `keterangan`, `penyebab_bencana`, `status_laporan`, `created_at`, `updated_at`) VALUES
(14, 2, 0, 0, 0, '0', 'hbb', 'hbbb', 'vvv', '108.2871731', '-6.4088654', '202046243i45.jpg', 'jnn', '', 'Diterima', '2020-06-24 08:47:01', '2020-06-24 08:47:01'),
(15, 2, 0, 0, 0, '0', 'baba', 'bana', 'bahah', '108.2844383', '-6.4093339', '20201244i39.jpg', 'sue', '', 'Diproses', '2020-06-24 09:01:53', '2020-06-24 09:01:53'),
(16, 2, 0, 0, 0, '0', 'corowy183628', 'coro', 'coro', '108.2872806', '-6.4086607', '202016246i29.jpg', 'ana coro gede', '', 'Selesai', '2020-06-24 11:19:03', '2020-06-24 11:19:03'),
(17, 9, 0, 0, 0, '0', 'sliyeg', 'sudikampiran', 'longsor', '108.2877945', '-6.4089188', '202034246i45.jpg', 'nzmzmzmzmsm', '', 'Diterima', '2020-06-24 11:34:59', '2020-06-24 11:34:59'),
(18, 9, 0, 0, 0, '0', 'jsksn', 'jdnsn', 'banjir', '108.2839072', '-6.409809', '202038246i19.jpg', 'nsmsks', '', 'Diterima', '2020-06-24 11:38:32', '2020-06-24 11:38:32'),
(19, 2, 0, 0, 0, '0', 'bau-bwu', 'serang', 'longsor', '108.3684495', '-6.4260999', '202024257i58.jpg', 'longsor', '', 'Diterima', '2020-06-25 12:25:20', '2020-06-25 12:25:20'),
(20, 8, 0, 0, 0, '0', 'tersebut', 'terkirim', 'buaya', '108.3688248', '-6.4261665', '202031289i31.jpg', 'bsnsnsnsnsn', '', 'Diterima', '2020-06-28 14:32:08', '2020-06-28 14:32:08'),
(21, 2, 0, 0, 0, '0', 'sliyeg', 'tugu', 'banjir', '108.3687401', '-6.4284901', '20201057i52.jpg', 'banjir bandang besar', '', 'Diterima', '2020-07-05 12:11:27', '2020-07-05 12:11:27'),
(22, 11, 0, 0, 0, '0', 'sliyeg', 'tugu', 'angin puting beliung', '108.3683747', '-6.4289756', '20203711i21.jpg', 'rumah rusak karena angin puting beliung', '', 'Diterima', '2020-07-07 04:04:09', '2020-07-07 04:04:09'),
(23, 11, 0, 0, 0, '0', 'haurgeulis', 'haurgelis', 'longsor', '108.3683659', '-6.4289684', '202043711i1.jpg', 'jalan desa tertimbun reruntuhan longsor', '', 'Diterima', '2020-07-07 04:43:50', '2020-07-07 04:43:50'),
(24, 2, 0, 0, 0, '0', 'mana', 'dimana', 'apa', '108.3683626', '-6.4289652', '202046711i43.jpg', 'bencana apa', '', 'Diterima', '2020-07-07 04:47:00', '2020-07-07 04:47:00'),
(25, 11, 0, 0, 0, '0', 'ruja', 'raju', 'longsor', '0988889', '787968767', 'agama.jpg', 'coba', '', 'Diterima', '2020-07-07 04:50:12', '2020-07-07 04:50:12'),
(26, 2, 0, 0, 0, '0', 'kama mana', 'di mana', 'saha', '108.3684495', '-6.426736', '202051711i25.jpg', 'mnnvvcxasdfghjkl', '', 'Diterima', '2020-07-07 04:51:52', '2020-07-07 04:51:52'),
(27, 2, 0, 0, 0, '0', 'ruja', 'raju', 'longsor', '0988889', '787968767', 'agama.jpg', 'coba', '', 'Diterima', '2020-07-07 04:54:01', '2020-07-07 04:54:01'),
(28, 2, 0, 0, 0, '0', 'terisi', 'cikamurang', 'longsor', '108.3684495', '-6.426736', '202056711i20.jpg', 'longsor', '', 'Diterima', '2020-07-07 04:56:59', '2020-07-07 04:56:59'),
(29, 11, 0, 0, 0, '0', 'ruja', 'raju', 'longsor', '0988889', '787968767', 'agama.jpg', 'coba', '', 'Diterima', '2020-07-07 05:00:13', '2020-07-07 05:00:13'),
(30, 11, 0, 0, 0, '9', 'nac', 'joki', 'longsor', '0988889', '787968767', 'ace.png', 'coba', '', 'Diterima', '2020-07-07 05:08:02', '2020-07-07 05:08:02'),
(31, 11, 0, 0, 0, '08700008876', 'nac', 'joki', 'longsor', '0988889', '787968767', 'ace.png', 'coba', '', 'Diterima', '2020-07-07 05:19:41', '2020-07-07 05:19:41'),
(32, 2, 0, 0, 0, '085320102300', 'sliyeg', 'tambi', 'banjir', '108.2835365', '-6.4152302', '20203098i13.jpg', 'bajir', '', 'Diterima', '2020-07-09 01:30:45', '2020-07-09 01:30:45');

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2020_06_15_150846_laporan', 1),
(2, '2020_06_17_085311_users', 2),
(3, '2020_11_25_062954_jenis_bencana', 3);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_hp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `nama`, `alamat`, `no_hp`, `foto`, `level`, `created_at`, `updated_at`) VALUES
(1, 'coba@gmail.com', 'b42678461a9b641749274c1eda1a81db00f111d5', 'coba', 'coba', '876464646', 'image_cropper_1592384273155.jpg', 'pelapor', '2020-06-17 08:58:05', '2020-06-28 14:16:45'),
(2, 'safira@gmail.com', 'b42678461a9b641749274c1eda1a81db00f111d5', 'safira', 'cimahi', '08536987546', 'image_cropper_1592474962075.jpg', 'pelapor', '2020-06-18 10:09:47', '2020-06-28 14:07:19'),
(6, 'petugas@gmail.com', '51e2ff310f3eefffe43917f5d0741ae12df924eb', 'petugas', 'indramayu', '0809809808908', 'agama.jpg', 'petugas', '2020-06-20 12:19:02', '2020-06-20 12:19:02'),
(8, 'rana@gmail.com', 'f3b5fbf69814c41aeb0741da05eb07e154375cc8', 'rana', 'sliyeg', '083121146777', 'image_cropper_1592796285229.jpg', 'pelapor', '2020-06-22 03:25:19', '2020-06-22 03:25:19'),
(9, 'ratna@gmail.com', '057ace48aa3c1995f515b205a84268f637b503ec', 'ratna', 'Indragiri', '083121946121', 'image_cropper_1592969555442.jpg', 'pelapor', '2020-06-24 03:32:58', '2020-06-28 14:18:05'),
(10, 'eka@gmail.com', 'bbd43530a362ae225b6f6d27bd33ae3633deef9d', 'eka', 'tugu', '08543199888', 'image_cropper_1592998130285.jpg', 'pelapor', '2020-06-24 11:29:16', '2020-06-24 11:29:16'),
(11, 'chika@gmail.com', '4ec480fe67fe7a8f9fab492d0599fc2674a7fda7', 'chika', 'sliyeg', '08314678951', 'image_cropper_1593749330778.jpg', 'pelapor', '2020-07-03 04:09:23', '2020-07-07 04:02:04'),
(12, 'elisa@gmail.com', 'd4b5ded34cd8ea6620f1c1668bb26ba07613b7da', 'elisa', 'bekasi', '083212465789', 'image_cropper_1594205431001.jpg', 'pelapor', '2020-07-08 10:51:25', '2020-07-08 10:51:25');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `bencana`
--
ALTER TABLE `bencana`
  ADD PRIMARY KEY (`id_bencana`);

--
-- Indeks untuk tabel `jenis_bencana`
--
ALTER TABLE `jenis_bencana`
  ADD PRIMARY KEY (`id_jenis_bencana`);

--
-- Indeks untuk tabel `laporan`
--
ALTER TABLE `laporan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `bencana`
--
ALTER TABLE `bencana`
  MODIFY `id_bencana` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `jenis_bencana`
--
ALTER TABLE `jenis_bencana`
  MODIFY `id_jenis_bencana` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `laporan`
--
ALTER TABLE `laporan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
