-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 13, 2025 at 04:42 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smpl_outsource`
--

-- --------------------------------------------------------

--
-- Table structure for table `banks`
--

CREATE TABLE `banks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `account_name` varchar(255) DEFAULT NULL,
  `account_no` varchar(16) DEFAULT NULL,
  `swift_code_no` varchar(255) DEFAULT NULL,
  `ifsc_code` varchar(255) DEFAULT NULL,
  `branch` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `banks`
--

INSERT INTO `banks` (`id`, `name`, `account_name`, `account_no`, `swift_code_no`, `ifsc_code`, `branch`, `created_at`, `updated_at`) VALUES
(1, 'AXIS', 'VAN CLEEF', '9559696959', 'ERRRFFG0005', 'AAAABB00059', 'ALVJ', '2024-11-23 01:34:25', '2024-11-23 01:34:25'),
(2, 'BOB', 'REZALIC GOLD', '99590960009', 'BOBJJJJBBN9', 'BOB00000055', 'ALJZON', '2024-11-23 01:35:51', '2024-11-23 01:35:51'),
(3, 'YES', 'VINZ TON', '559633211546555', '55996655', 'YES55000009', 'ATVGH', '2025-01-22 00:39:33', '2025-01-22 00:39:33');

-- --------------------------------------------------------

--
-- Table structure for table `configurations`
--

CREATE TABLE `configurations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `value` text NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `code` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `configurations`
--

INSERT INTO `configurations` (`id`, `name`, `value`, `description`, `code`, `created_at`, `updated_at`) VALUES
(1, 'SMPL', '23', 'Auto generated invoice number', 'AUTO_GENERATED_INVOICE_NO', '2024-11-23 01:14:56', '2025-02-19 05:33:15'),
(2, 'SMLPI', '13', 'Auto generated proforma invoice number', 'AUTO_GENERATED_PROFORMA_INVOICE_NO', '2024-11-23 01:14:56', '2025-02-19 05:34:46'),
(3, 'SMLQ', '49', 'Auto generated quote number', 'AUTO_GENERATED_QUOTE_NO', '2024-11-23 01:14:56', '2025-02-17 04:39:16'),
(8, 'Role Type', '[{\"label\":\"ADMIN\",\"value\":\"ADMIN\"},{\"label\":\"BD\",\"value\":\"BD\"},{\"label\":\"PURCHASE\",\"value\":\"PURCHASE\"},{\"label\":\"WAREHOUSE\",\"value\":\"WAREHOUSE\"},{\"label\":\"BILLING\",\"value\":\"BILLING\"},{\"label\":\"WAREHOUSE PACKING\",\"value\":\"WAREHOUSE_PACKING\"},{\"label\":\"LOGISTIC\",\"value\":\"LOGISTIC\"}]', 'Role types', 'ROLE_TYPE', '2024-12-08 22:17:49', '2024-12-08 22:17:49');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bank_id` bigint(20) UNSIGNED DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_code` varchar(255) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone_no` varchar(25) NOT NULL,
  `registration_no` varchar(255) DEFAULT NULL,
  `address` text NOT NULL,
  `zip_code` varchar(25) DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `bank_id`, `parent_id`, `client_code`, `company_name`, `email`, `phone_no`, `registration_no`, `address`, `zip_code`, `currency`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 'SMP0001', 'TATA', 'TATA101@GMAIL.COM', '9955599655', 'RGRGRGRGR55', '99, ORTGH RTO', '395005', 'USD', '2024-11-29 00:54:13', '2025-01-13 02:52:40'),
(2, 2, NULL, 'SMP0002', 'CAP', 'CAP101@GMAIL.COM', '9959191999', '9965555619', '59, ERT LLTP', '395005', 'EURO', '2024-11-29 00:55:04', '2024-11-29 00:55:04'),
(3, 1, 1, 'SMP0003', 'TCS', 'TCS@GMAIL.COM', '9659155999', 'RFGHHYUHH55', '98, RDFCXV LLT', '395006', 'USD', '2024-11-29 00:56:02', '2025-01-12 22:35:38'),
(4, 1, 2, 'SMP0004', 'SF', 'SF101@GMAIL.COM', '9959090959', '9685555699', '15, RVN TTGS LLP', '395006', 'EURO', '2024-11-29 02:26:41', '2024-11-29 02:26:41'),
(5, 1, NULL, 'SMP0005', 'CAPGEMINI', 'CAPGEMINI@GMAIL.COM', '9955664455', 'HRGSFGSFS8885', '569, GFHDJFSHJ', '2356895623568923568998655', 'USD', '2024-12-19 03:08:59', '2025-01-22 00:55:40'),
(6, 2, 5, 'SMP0006', 'TYU', 'TYU@GMAIL.COM', '8956235698', 'SDGSGSGS4545', '899, EEYETWT', '395001', 'EURO', '2024-12-19 03:12:05', '2024-12-19 03:12:05'),
(8, 1, NULL, 'SMP0007', 'SASSIFY', 'SASSIFY@GMAIL.COM', '9955662299', 'RFSFRWFW55', '3569, ASDFG', '395005', 'AED', '2025-01-09 23:38:23', '2025-01-09 23:38:23'),
(9, 2, 8, 'SMP0008', 'SALSFORCE', 'SALSFORCE@GMAIL.COM', '8956235689', 'GFSFSWWWWRT7889', '1256, GFHFSJWUW', '395006', 'GBP', '2025-01-09 23:40:39', '2025-01-09 23:40:39'),
(10, 1, NULL, 'SMP0009', 'ANMY', 'ANMY@GMAIL.COM', '8956235689', 'DSFFWSEEER55', '55, OBRJ TTU', '395009', 'SGD', '2025-01-10 01:06:04', '2025-01-10 01:06:04'),
(11, 2, 10, 'SMP0010', 'ABTYK', 'ABTYK2GMAIL.COM', '8956455689', 'DFGTTYY55', '151, RTYGHJUU', '395005', 'AED', '2025-01-10 01:07:07', '2025-01-10 01:07:07'),
(12, 2, NULL, 'SMP0011', 'ANTINO', 'ANTINO@GMAIL.COM', '8956236589', 'ASDFGHJ4565', '501, SDFG HDHD', '395006', 'EURO', '2025-01-10 01:18:54', '2025-01-22 03:05:49'),
(13, 1, 12, 'SMP0012', 'ATWE', 'ATWE@GMAIL.COM', '8956235655', 'ASDFGHJ55', '515, SDFGHJK ERTY', '395005', 'USD', '2025-01-10 01:19:48', '2025-01-22 03:05:55'),
(14, 3, NULL, 'SMP0013', 'ANTONIA', 'ANTONIA101@GMAIL.COM', '9955555699', 'GFTYUU5559555', '505, ALONE TTMG ROAD R K MILK NEAR', '380005', 'EURO', '2025-01-22 03:07:39', '2025-01-22 03:07:39'),
(16, 2, NULL, 'SMP0014', 'AGBN', 'AGBN@GMAIL.COM', '5599446699', 'DRD55996633', '55, TYUIOJKL MMN', '395005', 'SGD', '2025-01-31 05:47:07', '2025-02-14 23:33:38'),
(17, 1, NULL, 'SMP0015', 'ARTINO', 'ARTINO@GMAIL.COM', '9559595699', 'NFBDGHDGVERF4EF', '51,  BGHVHSUFH3EUF', '395555', 'SGD', '2025-02-13 01:10:53', '2025-02-13 01:10:53'),
(18, 2, NULL, 'SMP0016', 'ALTINO', 'ALTINO@GMAIL.COM', '9545595699', '5GDFGDHVJHERY6', '55,  CSNGHDGHC', '395505', 'SGD', '2025-02-13 01:12:09', '2025-02-13 01:12:09'),
(20, 2, NULL, 'SMP0017', 'ALBYO', 'ALBYO@GMAIL.COM', '9555664485', 'HRGDGEGFSFGDGFE', '105, FSHGCSG5', '559944', 'AED', '2025-02-13 22:22:13', '2025-02-13 22:22:13'),
(22, 1, NULL, 'SMP0018', 'AYU015', 'AYU015@GMAIL.COM', '9955195651', '5152155956', '55, ALDV', '395551', 'AED', '2025-02-20 04:09:55', '2025-02-20 04:09:55');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `generics`
--

CREATE TABLE `generics` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `generics`
--

INSERT INTO `generics` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'DOMCET', '2024-11-23 01:16:55', '2024-11-23 01:19:32'),
(2, 'ACI FREE (LEMON)', '2024-11-23 01:17:04', '2024-11-23 01:19:44'),
(3, 'ACI FREE (PUDINA)', '2024-11-23 01:17:12', '2024-11-23 01:19:53'),
(4, 'ACI FREE (REGULAR)', '2024-11-23 01:20:05', '2024-11-23 01:20:05'),
(5, 'ACI FREE (ZEERA)', '2024-11-23 01:20:12', '2024-11-23 01:20:12'),
(6, 'ACIGENE GEL 170ML MINT', '2024-11-23 01:20:19', '2024-11-23 01:20:19'),
(7, 'DIGUSIL MPS (MINT)', '2024-11-23 01:20:29', '2024-11-23 01:20:29'),
(8, 'OXECAINE 170ML', '2024-11-23 01:20:37', '2024-11-23 01:20:37'),
(9, 'BENAZEPRIL HCTZ TABLET', '2024-11-26 00:16:12', '2024-11-26 00:16:12'),
(18, 'BENAZEPRIL TABLET', '2024-11-26 00:55:37', '2024-11-26 00:55:37'),
(19, 'BENZONATATE', '2024-11-26 00:57:48', '2024-11-26 00:57:48'),
(21, 'BENZONATATE CAPSULE', '2024-11-26 01:34:15', '2024-11-26 01:34:15'),
(24, 'GDGDSGD', '2024-11-26 01:44:00', '2024-11-26 01:44:00'),
(25, 'BENZTROPINE TABLET', '2024-11-26 02:08:31', '2024-11-26 02:08:31'),
(26, 'BETHANECHOL TABLET', '2024-11-26 02:12:18', '2024-11-26 02:12:18'),
(27, 'BICALUTAMIDE', '2024-11-26 02:14:57', '2024-11-26 02:14:57'),
(28, 'BISOPROLOL/HCTZ TABLET', '2024-11-26 02:42:14', '2024-11-26 02:42:14'),
(29, 'BRIMONIDINE TARTRATE', '2024-11-26 02:44:55', '2024-11-26 02:44:55'),
(30, 'BROMOCRIPTINE TABLET', '2024-11-26 03:06:14', '2024-11-26 03:06:14'),
(33, 'BUDESONIDE INHALATION SUSPENSION', '2024-11-26 03:15:26', '2024-11-26 03:15:26'),
(34, 'BUPROPION HCL', '2024-11-26 03:17:12', '2024-11-26 03:17:12'),
(35, 'UPROPION HCL', '2024-11-26 03:19:15', '2024-11-26 03:19:15'),
(38, 'BUPROPION HCL TABLET', '2024-11-26 03:31:57', '2024-11-26 03:31:57'),
(43, 'BUSPIRONE TABLET', '2024-11-26 03:48:37', '2024-11-26 03:48:37'),
(44, 'CALCITONIN-SALMON (RDNA ORIGIN)', '2024-11-26 04:09:34', '2024-11-26 04:09:34'),
(45, 'CALCITRIOL CAPSULE', '2024-11-26 04:10:33', '2024-11-26 04:21:04'),
(46, 'CALCIUM ACETATE', '2024-11-26 04:11:51', '2024-11-26 04:21:13'),
(47, 'CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE', '2024-11-26 04:12:48', '2024-11-26 04:21:26'),
(48, 'CANDESARTAN CILEXTIL', '2024-11-26 04:15:02', '2024-11-26 04:21:45'),
(49, 'CAPTOPRIL TABLET', '2024-11-26 04:18:44', '2024-11-26 04:21:57'),
(50, 'CARBAMAZEPINE TABLET', '2024-11-26 04:22:13', '2024-11-26 04:22:13'),
(111, 'AB555-F59-A5FGH-59UHJK-5599A', '2024-11-29 02:13:26', '2024-11-29 02:13:26'),
(112, 'AASSSSQSQSWSDQ555', '2025-01-07 03:49:06', '2025-01-07 03:49:06'),
(113, 'AAAEERARR5595', '2025-01-07 04:01:24', '2025-01-07 04:01:24'),
(114, 'NBFBDGETTRTY55', '2025-01-09 23:55:38', '2025-01-09 23:55:38'),
(115, 'AYUB1', '2025-01-23 04:47:29', '2025-01-23 04:47:29'),
(116, 'AYUB2A', '2025-01-28 22:55:47', '2025-01-28 22:55:47'),
(117, 'AYUB3A', '2025-01-30 06:50:43', '2025-01-30 06:50:54'),
(118, 'AYUB4A', '2025-01-30 06:51:02', '2025-01-30 06:51:02'),
(119, 'AYUB5A', '2025-01-30 06:51:12', '2025-01-30 06:51:12'),
(120, 'AYUB6A', '2025-02-06 06:58:39', '2025-02-06 06:58:39'),
(121, 'AYUB7A', '2025-02-06 06:58:45', '2025-02-06 06:58:45');

-- --------------------------------------------------------

--
-- Table structure for table `inquery_status_history`
--

CREATE TABLE `inquery_status_history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `inquiry_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('open','close','reopen','pending') DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `is_manually` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inquery_status_history`
--

INSERT INTO `inquery_status_history` (`id`, `inquiry_id`, `status`, `remarks`, `is_manually`, `created_by`, `created_at`, `updated_at`, `updated_by`) VALUES
(1, NULL, NULL, 'test', 0, 1, '2024-11-25 01:51:46', '2024-11-25 01:51:46', NULL),
(2, 12, NULL, NULL, 0, 1, '2024-11-25 02:11:45', '2024-11-25 02:11:45', NULL),
(3, NULL, NULL, 'hello test', 0, 1, '2024-11-25 03:26:37', '2024-11-25 03:26:37', NULL),
(4, 12, NULL, NULL, 0, 1, '2024-11-25 03:27:36', '2024-11-25 03:27:36', NULL),
(5, NULL, NULL, 'hello i am test', 0, 1, '2024-11-25 03:33:13', '2024-11-25 03:33:13', NULL),
(6, 12, NULL, NULL, 0, 1, '2024-11-25 03:33:43', '2024-11-25 03:33:43', NULL),
(7, NULL, NULL, 'test', 0, 3, '2024-12-01 22:41:04', '2024-12-01 22:41:04', NULL),
(8, NULL, NULL, 'hello test', 0, 3, '2024-12-01 22:42:50', '2024-12-01 22:42:50', NULL),
(9, 8, NULL, NULL, 0, 3, '2024-12-01 22:43:17', '2024-12-01 22:43:17', NULL),
(10, NULL, NULL, 'test hello', 0, 3, '2024-12-02 02:56:45', '2024-12-02 02:56:45', NULL),
(11, 10, NULL, NULL, 0, 3, '2024-12-02 03:31:37', '2024-12-02 03:31:37', NULL),
(12, NULL, NULL, 'hello i am new test', 0, 2, '2024-12-02 23:36:36', '2024-12-02 23:36:36', NULL),
(13, 10, NULL, NULL, 0, 2, '2024-12-02 23:57:12', '2024-12-02 23:57:12', NULL),
(14, NULL, NULL, 'test hello', 0, 2, '2024-12-03 00:25:12', '2024-12-03 00:25:12', NULL),
(15, 10, NULL, NULL, 0, 2, '2024-12-03 00:26:21', '2024-12-03 00:26:21', NULL),
(16, NULL, NULL, 'hello test', 0, 1, '2024-12-03 22:23:25', '2024-12-03 22:23:25', NULL),
(17, 10, NULL, NULL, 0, 1, '2024-12-03 22:23:53', '2024-12-03 22:23:53', NULL),
(18, NULL, NULL, 'test hello', 0, 1, '2024-12-04 03:17:11', '2024-12-04 03:17:11', NULL),
(19, 10, NULL, NULL, 0, 1, '2024-12-04 03:18:02', '2024-12-04 03:18:02', NULL),
(20, NULL, NULL, 'i am new test', 0, 1, '2024-12-04 03:24:59', '2024-12-04 03:24:59', NULL),
(21, 16, NULL, 'Closed by the system based on predefined criteria', 0, 1, '2024-12-04 05:14:51', '2024-12-04 05:14:51', NULL),
(22, 17, NULL, 'Closed by the system based on predefined criteria', 0, 1, '2024-12-04 05:23:18', '2024-12-04 05:23:18', NULL),
(23, 18, NULL, 'Closed by the system based on predefined criteria', 0, 2, '2024-12-09 23:05:09', '2024-12-09 23:05:09', NULL),
(24, 19, NULL, 'Closed by the system based on predefined criteria', 0, 2, '2024-12-10 05:54:22', '2024-12-10 05:54:22', NULL),
(25, 16, NULL, 'Closed by the system based on predefined criteria', 0, 2, '2024-12-10 23:54:58', '2024-12-10 23:54:58', NULL),
(27, 9, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-13 05:40:19', '2024-12-13 05:40:19', NULL),
(28, 9, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-13 05:47:26', '2024-12-13 05:47:26', NULL),
(29, 9, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-13 05:49:27', '2024-12-13 05:49:27', NULL),
(30, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-13 05:56:43', '2024-12-13 05:56:43', NULL),
(31, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-13 05:59:47', '2024-12-13 05:59:47', NULL),
(32, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-13 06:02:09', '2024-12-13 06:02:09', NULL),
(33, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-13 06:03:33', '2024-12-13 06:03:33', NULL),
(34, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-13 06:05:18', '2024-12-13 06:05:18', NULL),
(35, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-13 06:19:31', '2024-12-13 06:19:31', NULL),
(36, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-15 22:55:27', '2024-12-15 22:55:27', NULL),
(37, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-15 22:56:29', '2024-12-15 22:56:29', NULL),
(38, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-15 22:57:17', '2024-12-15 22:57:17', NULL),
(39, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-15 22:58:12', '2024-12-15 22:58:12', NULL),
(40, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-15 22:59:03', '2024-12-15 22:59:03', NULL),
(41, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-15 22:59:55', '2024-12-15 22:59:55', NULL),
(42, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-15 23:00:55', '2024-12-15 23:00:55', NULL),
(43, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-15 23:01:47', '2024-12-15 23:01:47', NULL),
(44, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-15 23:05:27', '2024-12-15 23:05:27', NULL),
(45, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-15 23:08:52', '2024-12-15 23:08:52', NULL),
(46, 20, 'close', 'Closed by the system based on predefined criteria', 0, 2, '2024-12-15 23:09:13', '2024-12-15 23:09:13', NULL),
(47, 20, 'close', 'Closed by the system based on predefined criteria', 0, 2, '2024-12-15 23:09:33', '2024-12-15 23:09:33', NULL),
(48, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-15 23:31:05', '2024-12-15 23:31:05', NULL),
(49, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-15 23:31:54', '2024-12-15 23:31:54', NULL),
(50, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-15 23:34:26', '2024-12-15 23:34:26', NULL),
(51, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 00:03:18', '2024-12-16 00:03:18', NULL),
(52, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 00:03:46', '2024-12-16 00:03:46', NULL),
(53, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 00:08:35', '2024-12-16 00:08:35', NULL),
(54, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 00:08:52', '2024-12-16 00:08:52', NULL),
(55, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 00:21:15', '2024-12-16 00:21:15', NULL),
(56, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 00:27:23', '2024-12-16 00:27:23', NULL),
(57, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 00:59:17', '2024-12-16 00:59:17', NULL),
(58, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 01:03:02', '2024-12-16 01:03:02', NULL),
(59, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 01:05:29', '2024-12-16 01:05:29', NULL),
(60, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 01:11:03', '2024-12-16 01:11:03', NULL),
(61, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 02:21:57', '2024-12-16 02:21:57', NULL),
(62, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 02:23:00', '2024-12-16 02:23:00', NULL),
(63, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 02:24:08', '2024-12-16 02:24:08', NULL),
(64, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 02:25:01', '2024-12-16 02:25:01', NULL),
(65, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 02:29:40', '2024-12-16 02:29:40', NULL),
(66, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 02:30:46', '2024-12-16 02:30:46', NULL),
(67, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 02:31:01', '2024-12-16 02:31:01', NULL),
(68, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 02:32:07', '2024-12-16 02:32:07', NULL),
(69, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 02:33:33', '2024-12-16 02:33:33', NULL),
(70, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 02:33:39', '2024-12-16 02:33:39', NULL),
(71, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 02:49:13', '2024-12-16 02:49:13', NULL),
(72, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 02:55:21', '2024-12-16 02:55:21', NULL),
(73, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 03:06:53', '2024-12-16 03:06:53', NULL),
(74, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 03:07:43', '2024-12-16 03:07:43', NULL),
(75, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 03:08:57', '2024-12-16 03:08:57', NULL),
(76, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-16 03:12:24', '2024-12-16 03:12:24', NULL),
(77, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 03:13:37', '2024-12-16 03:13:37', NULL),
(78, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 03:17:40', '2024-12-16 03:17:40', NULL),
(79, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 03:30:17', '2024-12-16 03:30:17', NULL),
(80, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-16 03:31:32', '2024-12-16 03:31:32', NULL),
(81, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 03:38:36', '2024-12-16 03:38:36', NULL),
(82, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-16 03:39:47', '2024-12-16 03:39:47', NULL),
(83, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-16 03:42:32', '2024-12-16 03:42:32', NULL),
(84, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-16 03:43:02', '2024-12-16 03:43:02', NULL),
(85, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-16 03:44:18', '2024-12-16 03:44:18', NULL),
(86, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-16 03:46:51', '2024-12-16 03:46:51', NULL),
(87, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 03:53:13', '2024-12-16 03:53:13', NULL),
(88, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-16 03:53:46', '2024-12-16 03:53:46', NULL),
(89, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 03:59:56', '2024-12-16 03:59:56', NULL),
(90, 21, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 04:12:26', '2024-12-16 04:12:26', NULL),
(91, 21, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-16 04:13:38', '2024-12-16 04:13:38', NULL),
(92, 21, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 04:16:03', '2024-12-16 04:16:03', NULL),
(93, 21, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-16 04:18:00', '2024-12-16 04:18:00', NULL),
(94, 21, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 04:26:03', '2024-12-16 04:26:03', NULL),
(95, 21, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-16 04:27:10', '2024-12-16 04:27:10', NULL),
(96, 21, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-16 04:27:43', '2024-12-16 04:27:43', NULL),
(97, 21, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-16 04:40:23', '2024-12-16 04:40:23', NULL),
(98, 21, 'close', 'Closed by the system based on complete details', 0, 3, '2024-12-16 04:41:59', '2024-12-16 04:41:59', NULL),
(99, 21, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-16 04:41:59', '2024-12-16 04:41:59', NULL),
(100, 21, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-16 04:43:12', '2024-12-16 04:43:12', NULL),
(101, 20, 'reopen', NULL, 0, 3, '2024-12-16 05:33:18', '2024-12-16 05:33:18', NULL),
(102, 20, 'close', 'Closed by the system based on complete details', 0, 3, '2024-12-16 05:39:53', '2024-12-16 05:39:53', NULL),
(103, 22, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-16 05:59:41', '2024-12-16 05:59:41', NULL),
(104, 22, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-16 06:00:37', '2024-12-16 06:00:37', NULL),
(105, 22, 'close', 'Closed by the system based on complete details', 0, 3, '2024-12-16 06:01:37', '2024-12-16 06:01:37', NULL),
(106, 22, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-16 06:02:40', '2024-12-16 06:02:40', NULL),
(107, 23, 'close', 'Closed by the system based on complete details and sufficient suppliers', 0, 3, '2024-12-17 04:07:56', '2024-12-17 04:07:56', NULL),
(108, 23, 'pending', 'Pending due to incomplete details or insufficient supplier entries', 0, 3, '2024-12-17 04:09:46', '2024-12-17 04:09:46', NULL),
(109, 23, 'pending', 'Pending due to incomplete details or insufficient supplier entries', 0, 3, '2024-12-17 04:11:07', '2024-12-17 04:11:07', NULL),
(110, 23, 'pending', 'Pending due to incomplete details, insufficient suppliers, or brands', 0, 3, '2024-12-17 04:35:57', '2024-12-17 04:35:57', NULL),
(111, 23, 'close', 'Closed by the system based on complete details, sufficient suppliers, and brands', 0, 3, '2024-12-17 04:39:07', '2024-12-17 04:39:07', NULL),
(112, 23, 'pending', 'Pending due to incomplete details, insufficient suppliers, or brands', 0, 3, '2024-12-17 04:41:55', '2024-12-17 04:41:55', NULL),
(113, 23, 'pending', 'Pending due to incomplete details, insufficient suppliers, or brands', 0, 3, '2024-12-17 04:44:03', '2024-12-17 04:44:03', NULL),
(114, 23, 'pending', 'Pending due to incomplete details, insufficient suppliers, or brands', 0, 3, '2024-12-17 05:02:12', '2024-12-17 05:02:12', NULL),
(115, 23, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-17 05:03:15', '2024-12-17 05:03:15', NULL),
(116, 23, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-17 05:03:27', '2024-12-17 05:03:27', NULL),
(117, 23, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-17 05:03:52', '2024-12-17 05:03:52', NULL),
(118, 23, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-17 05:04:15', '2024-12-17 05:04:15', NULL),
(119, 23, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-17 05:07:49', '2024-12-17 05:07:49', NULL),
(120, 23, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-17 05:07:59', '2024-12-17 05:07:59', NULL),
(121, 23, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-17 05:13:04', '2024-12-17 05:13:04', NULL),
(122, 23, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-17 05:23:46', '2024-12-17 05:23:46', NULL),
(123, 23, 'close', 'Closed by the system based on complete details', 0, 3, '2024-12-17 05:41:36', '2024-12-17 05:41:36', NULL),
(124, 23, 'pending', 'Pending due to incomplete details, insufficient suppliers, or brands', 0, 3, '2024-12-17 05:43:24', '2024-12-17 05:43:24', NULL),
(125, 23, 'pending', 'Pending due to incomplete details, insufficient suppliers, or brands', 0, 3, '2024-12-17 05:44:20', '2024-12-17 05:44:20', NULL),
(126, 23, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-17 05:45:52', '2024-12-17 05:45:52', NULL),
(127, 23, 'close', 'Closed by the system based on complete details', 0, 3, '2024-12-17 05:46:01', '2024-12-17 05:46:01', NULL),
(128, 23, 'pending', 'Pending due to incomplete details, insufficient suppliers, or brands', 0, 3, '2024-12-17 05:48:14', '2024-12-17 05:48:14', NULL),
(129, 23, 'close', 'Closed by the system based on complete details', 0, 3, '2024-12-17 05:48:54', '2024-12-17 05:48:54', NULL),
(130, 23, 'pending', 'Pending due to incomplete details, insufficient suppliers, or brands', 0, 3, '2024-12-17 05:53:27', '2024-12-17 05:53:27', NULL),
(131, 23, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-17 05:53:55', '2024-12-17 05:53:55', NULL),
(132, 23, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-17 05:54:19', '2024-12-17 05:54:19', NULL),
(133, 23, 'pending', 'Pending due to incomplete details, insufficient suppliers, or brands', 0, 3, '2024-12-17 05:54:49', '2024-12-17 05:54:49', NULL),
(134, 23, 'close', 'Closed by the system based on complete details', 0, 3, '2024-12-17 05:55:20', '2024-12-17 05:55:20', NULL),
(135, 23, 'close', 'Closed by the system based on complete details', 0, 3, '2024-12-17 05:59:10', '2024-12-17 05:59:10', NULL),
(136, 23, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-17 06:03:43', '2024-12-17 06:03:43', NULL),
(137, 23, 'close', 'Closed by the system based on complete details', 0, 3, '2024-12-17 06:04:00', '2024-12-17 06:04:00', NULL),
(138, 23, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-17 06:04:44', '2024-12-17 06:04:44', NULL),
(139, 23, 'close', 'Closed by the system based on complete details', 0, 3, '2024-12-17 06:05:03', '2024-12-17 06:05:03', NULL),
(140, 23, 'close', 'Closed by the system based on complete details', 0, 3, '2024-12-17 06:06:37', '2024-12-17 06:06:37', NULL),
(141, 21, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-17 06:13:15', '2024-12-17 06:13:15', NULL),
(142, 21, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-17 06:13:15', '2024-12-17 06:13:15', NULL),
(143, 23, 'reopen', NULL, 0, 3, '2024-12-17 22:10:50', '2024-12-17 22:10:50', NULL),
(144, 17, 'reopen', NULL, 0, 2, '2024-12-19 04:07:55', '2024-12-19 04:07:55', NULL),
(145, 23, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-19 04:12:05', '2024-12-19 04:12:05', NULL),
(146, 23, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-19 04:18:13', '2024-12-19 04:18:13', NULL),
(147, 23, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-19 04:18:13', '2024-12-19 04:18:13', NULL),
(148, 23, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-19 04:18:37', '2024-12-19 04:18:37', NULL),
(149, 20, 'reopen', NULL, 0, 3, '2024-12-22 23:52:49', '2024-12-22 23:52:49', NULL),
(150, 24, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-23 03:53:05', '2024-12-23 03:53:05', NULL),
(151, 24, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-23 03:57:59', '2024-12-23 03:57:59', NULL),
(152, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-23 03:58:51', '2024-12-23 03:58:51', NULL),
(153, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-23 04:01:11', '2024-12-23 04:01:11', NULL),
(154, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-23 04:12:16', '2024-12-23 04:12:16', NULL),
(155, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-23 04:19:39', '2024-12-23 04:19:39', NULL),
(156, 20, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-23 04:22:38', '2024-12-23 04:22:38', NULL),
(157, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-23 04:24:19', '2024-12-23 04:24:19', NULL),
(158, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-23 04:26:16', '2024-12-23 04:26:16', NULL),
(159, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-23 04:28:15', '2024-12-23 04:28:15', NULL),
(160, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-23 04:29:37', '2024-12-23 04:29:37', NULL),
(161, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-23 04:30:16', '2024-12-23 04:30:16', NULL),
(162, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-23 04:32:50', '2024-12-23 04:32:50', NULL),
(163, 17, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-23 04:43:15', '2024-12-23 04:43:15', NULL),
(164, 17, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-23 04:50:58', '2024-12-23 04:50:58', NULL),
(165, 17, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-23 05:00:30', '2024-12-23 05:00:30', NULL),
(166, 21, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-23 05:00:49', '2024-12-23 05:00:49', NULL),
(167, 9, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-23 05:01:14', '2024-12-23 05:01:14', NULL),
(168, 21, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-23 05:10:18', '2024-12-23 05:10:18', NULL),
(169, 21, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-23 05:49:16', '2024-12-23 05:49:16', NULL),
(170, 21, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-23 05:50:06', '2024-12-23 05:50:06', NULL),
(171, 17, 'pending', 'Pending due to incomplete details', 0, 3, '2024-12-23 05:54:34', '2024-12-23 05:54:34', NULL),
(172, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-31 05:46:48', '2024-12-31 05:46:48', NULL),
(173, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2024-12-31 05:47:57', '2024-12-31 05:47:57', NULL),
(174, 18, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-31 05:53:06', '2024-12-31 05:53:06', NULL),
(175, 13, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-31 05:53:19', '2024-12-31 05:53:19', NULL),
(176, 14, 'close', 'Closed by the system based on complete details', 0, 2, '2024-12-31 05:53:27', '2024-12-31 05:53:27', NULL),
(177, 22, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-01 00:58:45', '2025-01-01 00:58:45', NULL),
(178, 15, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-01 05:12:38', '2025-01-01 05:12:38', NULL),
(179, 13, 'reopen', NULL, 0, 2, '2025-01-01 06:27:01', '2025-01-01 06:27:01', NULL),
(180, 28, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-02 00:37:25', '2025-01-02 00:37:25', NULL),
(181, 28, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-02 00:44:59', '2025-01-02 00:44:59', NULL),
(182, 28, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-02 00:45:19', '2025-01-02 00:45:19', NULL),
(183, 28, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-02 00:45:57', '2025-01-02 00:45:57', NULL),
(184, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 00:20:02', '2025-01-03 00:20:02', NULL),
(185, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 00:20:35', '2025-01-03 00:20:35', NULL),
(186, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 00:21:08', '2025-01-03 00:21:08', NULL),
(187, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 00:21:29', '2025-01-03 00:21:29', NULL),
(188, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 00:22:20', '2025-01-03 00:22:20', NULL),
(189, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 00:22:20', '2025-01-03 00:22:20', NULL),
(190, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 00:22:47', '2025-01-03 00:22:47', NULL),
(191, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 00:23:10', '2025-01-03 00:23:10', NULL),
(192, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 00:23:20', '2025-01-03 00:23:20', NULL),
(193, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 00:23:28', '2025-01-03 00:23:28', NULL),
(194, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 05:22:21', '2025-01-03 05:22:21', NULL),
(195, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 05:23:42', '2025-01-03 05:23:42', NULL),
(196, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 05:24:48', '2025-01-03 05:24:48', NULL),
(197, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 05:45:05', '2025-01-03 05:45:05', NULL),
(198, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 05:54:06', '2025-01-03 05:54:06', NULL),
(199, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 05:54:20', '2025-01-03 05:54:20', NULL),
(200, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 05:59:54', '2025-01-03 05:59:54', NULL),
(201, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 06:03:45', '2025-01-03 06:03:45', NULL),
(202, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 06:04:31', '2025-01-03 06:04:31', NULL),
(203, 29, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-03 06:05:22', '2025-01-03 06:05:22', NULL),
(204, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 06:09:20', '2025-01-03 06:09:20', NULL),
(205, 29, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 06:09:38', '2025-01-03 06:09:38', NULL),
(206, 29, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-03 06:09:49', '2025-01-03 06:09:49', NULL),
(207, 25, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 06:13:30', '2025-01-03 06:13:30', NULL),
(208, 25, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 06:14:04', '2025-01-03 06:14:04', NULL),
(209, 25, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-03 06:14:22', '2025-01-03 06:14:22', NULL),
(210, 33, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 06:19:20', '2025-01-03 06:19:20', NULL),
(211, 33, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-03 06:19:46', '2025-01-03 06:19:46', NULL),
(212, 33, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 06:29:35', '2025-01-03 06:29:35', NULL),
(213, 33, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 06:29:39', '2025-01-03 06:29:39', NULL),
(214, 33, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 06:32:57', '2025-01-03 06:32:57', NULL),
(215, 33, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 06:33:08', '2025-01-03 06:33:08', NULL),
(216, 33, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 06:33:32', '2025-01-03 06:33:32', NULL),
(217, 33, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 06:34:33', '2025-01-03 06:34:33', NULL),
(218, 33, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 06:42:55', '2025-01-03 06:42:55', NULL),
(219, 33, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 06:43:07', '2025-01-03 06:43:07', NULL),
(220, 33, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 06:48:09', '2025-01-03 06:48:09', NULL),
(221, 33, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 06:48:13', '2025-01-03 06:48:13', NULL),
(222, 33, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 06:48:50', '2025-01-03 06:48:50', NULL),
(223, 33, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-03 06:49:21', '2025-01-03 06:49:21', NULL),
(224, 33, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 22:41:51', '2025-01-05 22:41:51', NULL),
(225, 33, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-05 22:42:26', '2025-01-05 22:42:26', NULL),
(226, 33, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 22:53:53', '2025-01-05 22:53:53', NULL),
(227, 33, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 22:54:07', '2025-01-05 22:54:07', NULL),
(228, 33, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 22:54:15', '2025-01-05 22:54:15', NULL),
(229, 33, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 22:54:30', '2025-01-05 22:54:30', NULL),
(230, 33, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-05 22:54:40', '2025-01-05 22:54:40', NULL),
(231, 34, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:01:12', '2025-01-05 23:01:12', NULL),
(232, 34, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:02:35', '2025-01-05 23:02:35', NULL),
(233, 34, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:02:35', '2025-01-05 23:02:35', NULL),
(234, 34, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:02:55', '2025-01-05 23:02:55', NULL),
(235, 34, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:03:28', '2025-01-05 23:03:28', NULL),
(236, 34, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:03:41', '2025-01-05 23:03:41', NULL),
(237, 34, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-05 23:04:04', '2025-01-05 23:04:04', NULL),
(238, 34, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:04:45', '2025-01-05 23:04:45', NULL),
(239, 34, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-05 23:04:54', '2025-01-05 23:04:54', NULL),
(240, 37, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:08:08', '2025-01-05 23:08:08', NULL),
(241, 37, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:08:19', '2025-01-05 23:08:19', NULL),
(242, 37, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:08:37', '2025-01-05 23:08:37', NULL),
(243, 37, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:09:02', '2025-01-05 23:09:02', NULL),
(244, 37, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:09:21', '2025-01-05 23:09:21', NULL),
(245, 37, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:09:36', '2025-01-05 23:09:36', NULL),
(246, 37, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-05 23:09:54', '2025-01-05 23:09:54', NULL),
(247, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:11:38', '2025-01-05 23:11:38', NULL),
(248, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:11:55', '2025-01-05 23:11:55', NULL),
(249, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:12:04', '2025-01-05 23:12:04', NULL),
(250, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:12:42', '2025-01-05 23:12:42', NULL),
(251, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:12:43', '2025-01-05 23:12:43', NULL),
(252, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:12:59', '2025-01-05 23:12:59', NULL),
(253, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:13:10', '2025-01-05 23:13:10', NULL),
(254, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-05 23:13:29', '2025-01-05 23:13:29', NULL),
(255, 37, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:57:01', '2025-01-05 23:57:01', NULL),
(256, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-05 23:57:28', '2025-01-05 23:57:28', NULL),
(257, 37, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:58:08', '2025-01-05 23:58:08', NULL),
(258, 37, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:58:21', '2025-01-05 23:58:21', NULL),
(259, 37, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:58:33', '2025-01-05 23:58:33', NULL),
(260, 37, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:58:47', '2025-01-05 23:58:47', NULL),
(261, 37, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-05 23:58:55', '2025-01-05 23:58:55', NULL),
(262, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-05 23:59:50', '2025-01-05 23:59:50', NULL),
(263, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 00:00:23', '2025-01-06 00:00:23', NULL),
(264, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 00:02:09', '2025-01-06 00:02:09', NULL),
(265, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 00:02:24', '2025-01-06 00:02:24', NULL),
(266, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 00:02:34', '2025-01-06 00:02:34', NULL),
(267, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 00:08:27', '2025-01-06 00:08:27', NULL),
(268, 27, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 00:12:06', '2025-01-06 00:12:06', NULL),
(269, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 00:15:13', '2025-01-06 00:15:13', NULL),
(270, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 00:25:07', '2025-01-06 00:25:07', NULL),
(271, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 00:35:07', '2025-01-06 00:35:07', NULL),
(272, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 00:35:08', '2025-01-06 00:35:08', NULL),
(273, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 00:37:55', '2025-01-06 00:37:55', NULL),
(274, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 00:38:09', '2025-01-06 00:38:09', NULL),
(275, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 00:42:52', '2025-01-06 00:42:52', NULL),
(276, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 00:43:54', '2025-01-06 00:43:54', NULL),
(277, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 00:48:21', '2025-01-06 00:48:21', NULL),
(278, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 01:07:10', '2025-01-06 01:07:10', NULL),
(279, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 01:11:16', '2025-01-06 01:11:16', NULL),
(280, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 01:17:25', '2025-01-06 01:17:25', NULL),
(281, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 01:17:26', '2025-01-06 01:17:26', NULL),
(282, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 01:18:53', '2025-01-06 01:18:53', NULL),
(283, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 01:20:54', '2025-01-06 01:20:54', NULL),
(284, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 01:22:15', '2025-01-06 01:22:15', NULL),
(285, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 01:24:03', '2025-01-06 01:24:03', NULL),
(286, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 01:33:37', '2025-01-06 01:33:37', NULL),
(287, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 01:44:05', '2025-01-06 01:44:05', NULL),
(288, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 02:37:47', '2025-01-06 02:37:47', NULL),
(289, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 02:38:46', '2025-01-06 02:38:46', NULL),
(290, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 02:44:56', '2025-01-06 02:44:56', NULL),
(291, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 03:03:15', '2025-01-06 03:03:15', NULL),
(292, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 03:11:30', '2025-01-06 03:11:30', NULL),
(293, 27, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 03:24:36', '2025-01-06 03:24:36', NULL),
(294, 27, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 03:25:45', '2025-01-06 03:25:45', NULL),
(295, 27, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 03:25:59', '2025-01-06 03:25:59', NULL),
(296, 27, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 03:26:10', '2025-01-06 03:26:10', NULL),
(297, 27, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 03:26:19', '2025-01-06 03:26:19', NULL),
(298, 27, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 03:26:31', '2025-01-06 03:26:31', NULL),
(299, 39, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 03:27:59', '2025-01-06 03:27:59', NULL),
(300, 39, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 03:29:30', '2025-01-06 03:29:30', NULL),
(301, 39, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 03:36:29', '2025-01-06 03:36:29', NULL),
(302, 39, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 03:36:55', '2025-01-06 03:36:55', NULL),
(303, 39, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 04:16:44', '2025-01-06 04:16:44', NULL),
(304, 39, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 04:17:32', '2025-01-06 04:17:32', NULL),
(305, 39, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 04:17:33', '2025-01-06 04:17:33', NULL),
(306, 39, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 04:23:07', '2025-01-06 04:23:07', NULL),
(307, 39, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 04:23:08', '2025-01-06 04:23:08', NULL),
(308, 39, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 04:24:26', '2025-01-06 04:24:26', NULL),
(309, 39, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 04:24:27', '2025-01-06 04:24:27', NULL),
(310, 39, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 04:28:55', '2025-01-06 04:28:55', NULL),
(311, 39, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-06 04:28:56', '2025-01-06 04:28:56', NULL),
(312, 39, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-06 04:31:38', '2025-01-06 04:31:38', NULL),
(313, 40, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-07 03:52:49', '2025-01-07 03:52:49', NULL),
(314, 40, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-07 03:53:42', '2025-01-07 03:53:42', NULL),
(315, 40, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-07 03:53:43', '2025-01-07 03:53:43', NULL),
(316, 40, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-07 03:55:37', '2025-01-07 03:55:37', NULL),
(317, 41, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-07 04:03:29', '2025-01-07 04:03:29', NULL),
(318, 41, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-07 04:04:59', '2025-01-07 04:04:59', NULL),
(319, 41, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-07 04:05:42', '2025-01-07 04:05:42', NULL),
(320, 41, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-07 04:07:19', '2025-01-07 04:07:19', NULL),
(321, 41, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-07 04:10:48', '2025-01-07 04:10:48', NULL),
(322, 41, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-07 04:12:34', '2025-01-07 04:12:34', NULL),
(323, 41, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-07 04:15:32', '2025-01-07 04:15:32', NULL),
(324, 41, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-07 04:20:26', '2025-01-07 04:20:26', NULL),
(325, 41, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-07 04:21:35', '2025-01-07 04:21:35', NULL),
(326, 41, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-07 04:29:23', '2025-01-07 04:29:23', NULL),
(327, 41, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-07 04:30:30', '2025-01-07 04:30:30', NULL),
(328, 40, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-07 04:30:38', '2025-01-07 04:30:38', NULL),
(329, 40, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-08 05:55:34', '2025-01-08 05:55:34', NULL),
(330, 38, 'reopen', NULL, 0, 2, '2025-01-08 05:56:22', '2025-01-08 05:56:22', NULL),
(331, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-08 05:57:00', '2025-01-08 05:57:00', NULL),
(332, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-08 05:57:25', '2025-01-08 05:57:25', NULL),
(333, 38, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-08 05:57:44', '2025-01-08 05:57:44', NULL),
(334, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-08 05:58:27', '2025-01-08 05:58:27', NULL),
(335, 40, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-08 06:34:32', '2025-01-08 06:34:32', NULL),
(336, 40, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-08 06:36:04', '2025-01-08 06:36:04', NULL),
(337, 40, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-08 06:41:35', '2025-01-08 06:41:35', NULL),
(338, 40, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-08 06:45:32', '2025-01-08 06:45:32', NULL),
(339, 40, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-08 22:50:17', '2025-01-08 22:50:17', NULL),
(340, 40, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-08 22:51:49', '2025-01-08 22:51:49', NULL),
(341, 40, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-08 22:55:26', '2025-01-08 22:55:26', NULL),
(342, 40, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-08 22:59:48', '2025-01-08 22:59:48', NULL),
(343, 40, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-08 23:00:25', '2025-01-08 23:00:25', NULL),
(344, 40, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-08 23:04:57', '2025-01-08 23:04:57', NULL),
(345, 40, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-08 23:06:16', '2025-01-08 23:06:16', NULL),
(346, 40, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-08 23:09:37', '2025-01-08 23:09:37', NULL),
(347, 40, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-08 23:11:09', '2025-01-08 23:11:09', NULL),
(348, 40, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-08 23:16:57', '2025-01-08 23:16:57', NULL),
(349, 40, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-08 23:18:05', '2025-01-08 23:18:05', NULL),
(350, 40, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-08 23:18:53', '2025-01-08 23:18:53', NULL),
(351, 40, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-08 23:20:10', '2025-01-08 23:20:10', NULL),
(352, 40, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-08 23:20:34', '2025-01-08 23:20:34', NULL),
(353, 40, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-08 23:20:50', '2025-01-08 23:20:50', NULL),
(354, 40, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-08 23:20:59', '2025-01-08 23:20:59', NULL),
(355, 40, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-08 23:21:07', '2025-01-08 23:21:07', NULL),
(356, 10, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-09 04:46:04', '2025-01-09 04:46:04', NULL),
(357, 28, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-10 03:41:21', '2025-01-10 03:41:21', NULL),
(358, 27, 'reopen', NULL, 0, 2, '2025-01-20 22:32:45', '2025-01-20 22:32:45', NULL),
(359, 13, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-20 22:33:37', '2025-01-20 22:33:37', NULL),
(360, 13, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-20 22:34:28', '2025-01-20 22:34:28', NULL),
(361, 13, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-20 22:34:44', '2025-01-20 22:34:44', NULL),
(362, 13, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-20 22:34:53', '2025-01-20 22:34:53', NULL),
(363, 13, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-20 22:35:07', '2025-01-20 22:35:07', NULL),
(364, 13, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-20 22:35:26', '2025-01-20 22:35:26', NULL),
(365, 13, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-20 22:36:51', '2025-01-20 22:36:51', NULL),
(366, 13, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-20 22:39:15', '2025-01-20 22:39:15', NULL),
(367, 9, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-20 23:15:51', '2025-01-20 23:15:51', NULL),
(368, 44, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-21 03:39:26', '2025-01-21 03:39:26', NULL),
(374, 44, 'close', 'This quote not avalable any quantity close the quote.', 1, 2, '2025-01-21 23:23:04', '2025-01-21 23:23:04', NULL),
(375, 44, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-22 04:09:13', '2025-01-22 04:09:13', NULL),
(376, 44, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-22 04:46:49', '2025-01-22 04:46:49', NULL),
(377, 44, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-22 05:22:36', '2025-01-22 05:22:36', NULL),
(378, 44, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-22 05:25:18', '2025-01-22 05:25:18', NULL),
(379, 44, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-22 05:25:36', '2025-01-22 05:25:36', NULL),
(380, 10, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-22 05:28:50', '2025-01-22 05:28:50', NULL),
(381, 10, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-22 05:29:08', '2025-01-22 05:29:08', NULL),
(382, 44, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-22 06:17:17', '2025-01-22 06:17:17', NULL),
(383, 44, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-22 23:06:06', '2025-01-22 23:06:06', NULL),
(384, 28, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-22 23:47:23', '2025-01-22 23:47:23', NULL),
(385, 28, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-22 23:47:37', '2025-01-22 23:47:37', NULL),
(386, 44, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-23 22:48:47', '2025-01-23 22:48:47', NULL),
(387, 44, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-23 22:50:44', '2025-01-23 22:50:44', NULL),
(388, 44, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-23 22:58:30', '2025-01-23 22:58:30', NULL),
(389, 44, 'close', 'not gst required!', 1, 2, '2025-01-23 22:59:27', '2025-01-23 22:59:27', NULL),
(390, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-24 00:36:13', '2025-01-24 00:36:13', NULL),
(391, 28, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-24 01:48:35', '2025-01-24 01:48:35', NULL),
(392, 28, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-24 01:48:49', '2025-01-24 01:48:49', NULL),
(393, 10, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-24 02:50:04', '2025-01-24 02:50:04', NULL),
(394, 10, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-24 02:50:04', '2025-01-24 02:50:04', NULL),
(395, 10, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-24 02:50:41', '2025-01-24 02:50:41', NULL),
(396, 10, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-24 02:50:41', '2025-01-24 02:50:41', NULL),
(397, 28, 'close', 'hello test', 1, 2, '2025-01-24 03:03:29', '2025-01-24 03:03:29', NULL),
(398, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-24 04:07:12', '2025-01-24 04:07:12', NULL),
(399, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-24 04:07:12', '2025-01-24 04:07:12', NULL),
(400, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-24 05:08:29', '2025-01-24 05:08:29', NULL),
(401, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-24 05:11:22', '2025-01-24 05:11:22', NULL),
(402, 43, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-24 06:47:07', '2025-01-24 06:47:07', NULL),
(403, 17, 'close', 'hello fiorce close', 1, 2, '2025-01-24 07:13:19', '2025-01-24 07:13:19', NULL),
(404, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 01:07:57', '2025-01-27 01:07:57', NULL),
(405, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 01:24:38', '2025-01-27 01:24:38', NULL),
(406, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 02:50:05', '2025-01-27 02:50:05', NULL),
(407, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 03:01:25', '2025-01-27 03:01:25', NULL),
(408, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 03:04:10', '2025-01-27 03:04:10', NULL),
(409, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 03:04:22', '2025-01-27 03:04:22', NULL),
(410, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 03:04:59', '2025-01-27 03:04:59', NULL),
(411, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 03:08:55', '2025-01-27 03:08:55', NULL),
(412, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 03:19:13', '2025-01-27 03:19:13', NULL),
(413, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 03:30:14', '2025-01-27 03:30:14', NULL),
(414, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 03:44:58', '2025-01-27 03:44:58', NULL),
(415, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 03:45:25', '2025-01-27 03:45:25', NULL),
(416, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 04:04:03', '2025-01-27 04:04:03', NULL),
(417, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 04:18:06', '2025-01-27 04:18:06', NULL),
(418, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 04:18:26', '2025-01-27 04:18:26', NULL),
(419, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 04:18:41', '2025-01-27 04:18:41', NULL),
(420, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 04:20:22', '2025-01-27 04:20:22', NULL),
(421, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 04:25:28', '2025-01-27 04:25:28', NULL),
(422, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 04:26:40', '2025-01-27 04:26:40', NULL),
(423, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 04:37:25', '2025-01-27 04:37:25', NULL),
(424, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 04:50:41', '2025-01-27 04:50:41', NULL),
(425, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 04:52:54', '2025-01-27 04:52:54', NULL),
(426, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 04:59:24', '2025-01-27 04:59:24', NULL),
(427, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 05:19:25', '2025-01-27 05:19:25', NULL),
(428, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 05:44:38', '2025-01-27 05:44:38', NULL),
(429, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 06:00:26', '2025-01-27 06:00:26', NULL),
(430, 17, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-27 06:03:06', '2025-01-27 06:03:06', NULL),
(431, 17, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-27 06:29:29', '2025-01-27 06:29:29', NULL),
(432, 17, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-27 06:46:06', '2025-01-27 06:46:06', NULL);
INSERT INTO `inquery_status_history` (`id`, `inquiry_id`, `status`, `remarks`, `is_manually`, `created_by`, `created_at`, `updated_at`, `updated_by`) VALUES
(433, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 23:05:34', '2025-01-27 23:05:34', NULL),
(434, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 23:05:52', '2025-01-27 23:05:52', NULL),
(435, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 23:06:27', '2025-01-27 23:06:27', NULL),
(436, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 23:06:39', '2025-01-27 23:06:39', NULL),
(437, 17, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-27 23:06:58', '2025-01-27 23:06:58', NULL),
(438, 43, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 23:13:41', '2025-01-27 23:13:41', NULL),
(439, 43, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-27 23:17:33', '2025-01-27 23:17:33', NULL),
(440, 21, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-28 00:13:34', '2025-01-28 00:13:34', NULL),
(441, 21, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-28 00:30:52', '2025-01-28 00:30:52', NULL),
(442, 21, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-28 00:57:03', '2025-01-28 00:57:03', NULL),
(443, 21, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-28 01:00:23', '2025-01-28 01:00:23', NULL),
(444, 21, 'close', 'hello test', 1, 2, '2025-01-28 01:00:39', '2025-01-28 01:00:39', NULL),
(445, 26, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-28 01:07:27', '2025-01-28 01:07:27', NULL),
(446, 26, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-28 01:09:54', '2025-01-28 01:09:54', NULL),
(447, 17, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-28 05:16:28', '2025-01-28 05:16:28', NULL),
(448, 43, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-28 05:23:18', '2025-01-28 05:23:18', NULL),
(449, 43, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-28 05:33:20', '2025-01-28 05:33:20', NULL),
(450, 43, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-28 05:33:42', '2025-01-28 05:33:42', NULL),
(451, 43, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-28 05:38:49', '2025-01-28 05:38:49', NULL),
(452, 43, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-28 05:39:25', '2025-01-28 05:39:25', NULL),
(453, 43, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-28 05:40:42', '2025-01-28 05:40:42', NULL),
(454, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-28 22:58:38', '2025-01-28 22:58:38', NULL),
(455, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-29 00:31:39', '2025-01-29 00:31:39', NULL),
(456, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-29 01:06:40', '2025-01-29 01:06:40', NULL),
(457, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-29 01:18:47', '2025-01-29 01:18:47', NULL),
(458, 43, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-29 01:19:12', '2025-01-29 01:19:12', NULL),
(459, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-29 01:19:22', '2025-01-29 01:19:22', NULL),
(460, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-29 01:19:56', '2025-01-29 01:19:56', NULL),
(461, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-29 01:24:51', '2025-01-29 01:24:51', NULL),
(462, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-29 01:25:03', '2025-01-29 01:25:03', NULL),
(463, 43, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-29 01:32:45', '2025-01-29 01:32:45', NULL),
(464, 43, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-29 01:32:58', '2025-01-29 01:32:58', NULL),
(465, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-29 06:00:33', '2025-01-29 06:00:33', NULL),
(466, 46, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-29 06:34:08', '2025-01-29 06:34:08', NULL),
(467, 45, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-29 06:55:28', '2025-01-29 06:55:28', NULL),
(468, 45, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-29 07:09:39', '2025-01-29 07:09:39', NULL),
(469, 46, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-29 07:12:24', '2025-01-29 07:12:24', NULL),
(470, 40, 'reopen', NULL, 0, 2, '2025-01-29 22:32:09', '2025-01-29 22:32:09', NULL),
(471, 40, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-30 02:27:26', '2025-01-30 02:27:26', NULL),
(472, 40, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-30 02:49:29', '2025-01-30 02:49:29', NULL),
(473, 40, 'reopen', NULL, 0, 2, '2025-01-30 02:53:23', '2025-01-30 02:53:23', NULL),
(474, 44, 'reopen', NULL, 0, 2, '2025-01-30 04:13:44', '2025-01-30 04:13:44', NULL),
(475, 39, 'reopen', NULL, 0, 2, '2025-01-30 04:20:52', '2025-01-30 04:20:52', NULL),
(476, 41, 'reopen', NULL, 0, 2, '2025-01-30 05:16:55', '2025-01-30 05:16:55', NULL),
(477, 27, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-30 07:02:35', '2025-01-30 07:02:35', NULL),
(478, 27, 'reopen', NULL, 0, 2, '2025-01-30 07:06:32', '2025-01-30 07:06:32', NULL),
(479, 48, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-30 22:38:24', '2025-01-30 22:38:24', NULL),
(480, 48, 'reopen', NULL, 0, 2, '2025-01-30 22:39:30', '2025-01-30 22:39:30', NULL),
(481, 48, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-30 22:50:42', '2025-01-30 22:50:42', NULL),
(482, 48, 'reopen', NULL, 0, 2, '2025-01-30 22:51:18', '2025-01-30 22:51:18', NULL),
(483, 48, 'close', 'Closed by the system based on complete details', 0, 2, '2025-01-30 22:57:51', '2025-01-30 22:57:51', NULL),
(484, 48, 'reopen', NULL, 0, 2, '2025-01-30 22:58:28', '2025-01-30 22:58:28', NULL),
(485, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-01-31 04:29:49', '2025-01-31 04:29:49', NULL),
(486, 48, 'close', 'Closed by the system based on complete details', 0, 2, '2025-02-02 23:53:31', '2025-02-02 23:53:31', NULL),
(487, 38, 'reopen', NULL, 0, 2, '2025-02-04 22:08:27', '2025-02-04 22:08:27', NULL),
(488, 37, 'reopen', NULL, 0, 2, '2025-02-04 22:16:35', '2025-02-04 22:16:35', NULL),
(489, 37, 'close', 'Closed by the system based on complete details', 0, 2, '2025-02-04 22:34:50', '2025-02-04 22:34:50', NULL),
(490, 38, 'close', 'Closed by the system based on complete details', 0, 2, '2025-02-04 22:35:39', '2025-02-04 22:35:39', NULL),
(491, 23, 'reopen', NULL, 0, 2, '2025-02-04 22:44:49', '2025-02-04 22:44:49', NULL),
(492, 23, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-04 22:45:58', '2025-02-04 22:45:58', NULL),
(493, 23, 'close', 'Closed by the system based on complete details', 0, 2, '2025-02-04 22:47:06', '2025-02-04 22:47:06', NULL),
(494, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-04 22:58:08', '2025-02-04 22:58:08', NULL),
(495, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-04 22:58:08', '2025-02-04 22:58:08', NULL),
(496, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-04 22:58:08', '2025-02-04 22:58:08', NULL),
(497, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-04 22:58:08', '2025-02-04 22:58:08', NULL),
(498, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-04 22:58:08', '2025-02-04 22:58:08', NULL),
(499, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-04 22:58:09', '2025-02-04 22:58:09', NULL),
(500, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-04 23:07:48', '2025-02-04 23:07:48', NULL),
(501, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-04 23:08:11', '2025-02-04 23:08:11', NULL),
(502, 40, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-04 23:09:17', '2025-02-04 23:09:17', NULL),
(503, 42, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-05 04:29:15', '2025-02-05 04:29:15', NULL),
(504, 23, 'reopen', NULL, 0, 2, '2025-02-06 06:19:41', '2025-02-06 06:19:41', NULL),
(505, 23, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-06 06:38:39', '2025-02-06 06:38:39', NULL),
(506, 27, 'close', 'Closed by the system based on complete details', 0, 2, '2025-02-06 06:45:41', '2025-02-06 06:45:41', NULL),
(507, 39, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-06 06:46:14', '2025-02-06 06:46:14', NULL),
(508, 41, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-06 06:47:04', '2025-02-06 06:47:04', NULL),
(509, 18, 'reopen', NULL, 0, 2, '2025-02-06 06:55:53', '2025-02-06 06:55:53', NULL),
(510, 44, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-06 06:57:52', '2025-02-06 06:57:52', NULL),
(511, 14, 'reopen', NULL, 0, 2, '2025-02-06 06:59:53', '2025-02-06 06:59:53', NULL),
(512, 18, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-06 23:59:18', '2025-02-06 23:59:18', NULL),
(513, 14, 'close', 'Closed by the system based on complete details', 0, 2, '2025-02-07 00:00:05', '2025-02-07 00:00:05', NULL),
(514, 19, 'reopen', NULL, 0, 2, '2025-02-07 00:01:00', '2025-02-07 00:01:00', NULL),
(515, 19, 'close', 'Closed by the system based on complete details', 0, 2, '2025-02-07 00:02:24', '2025-02-07 00:02:24', NULL),
(516, 28, 'reopen', NULL, 0, 2, '2025-02-07 00:08:21', '2025-02-07 00:08:21', NULL),
(517, 28, 'close', 'Closed by the system based on complete details', 0, 2, '2025-02-07 00:09:14', '2025-02-07 00:09:14', NULL),
(518, 27, 'reopen', NULL, 0, 2, '2025-02-07 00:15:36', '2025-02-07 00:15:36', NULL),
(519, 27, 'close', 'Closed by the system based on complete details', 0, 2, '2025-02-07 00:17:45', '2025-02-07 00:17:45', NULL),
(520, 29, 'reopen', NULL, 0, 2, '2025-02-07 00:21:10', '2025-02-07 00:21:10', NULL),
(521, 33, 'reopen', NULL, 0, 2, '2025-02-07 00:24:46', '2025-02-07 00:24:46', NULL),
(522, 34, 'reopen', NULL, 0, 2, '2025-02-07 00:53:43', '2025-02-07 00:53:43', NULL),
(523, 29, 'close', 'Closed by the system based on complete details', 0, 2, '2025-02-11 23:16:51', '2025-02-11 23:16:51', NULL),
(524, 33, 'close', 'Closed by the system based on complete details', 0, 2, '2025-02-11 23:17:25', '2025-02-11 23:17:25', NULL),
(525, 34, 'close', 'Closed by the system based on complete details', 0, 2, '2025-02-11 23:18:04', '2025-02-11 23:18:04', NULL),
(526, 20, 'reopen', NULL, 0, 2, '2025-02-11 23:20:39', '2025-02-11 23:20:39', NULL),
(527, 20, 'close', 'Closed by the system based on complete details', 0, 2, '2025-02-11 23:22:39', '2025-02-11 23:22:39', NULL),
(528, 19, 'reopen', NULL, 0, 2, '2025-02-12 00:02:07', '2025-02-12 00:02:07', NULL),
(529, 13, 'reopen', NULL, 0, 2, '2025-02-12 00:22:16', '2025-02-12 00:22:16', NULL),
(530, 13, 'close', 'Closed by the system based on complete details', 0, 2, '2025-02-12 00:25:25', '2025-02-12 00:25:25', NULL),
(531, 14, 'reopen', NULL, 0, 2, '2025-02-12 00:27:55', '2025-02-12 00:27:55', NULL),
(532, 13, 'reopen', NULL, 0, 2, '2025-02-12 00:31:46', '2025-02-12 00:31:46', NULL),
(533, 14, 'close', 'Closed by the system based on complete details', 0, 2, '2025-02-12 00:43:32', '2025-02-12 00:43:32', NULL),
(534, 19, 'close', 'Closed by the system based on complete details', 0, 2, '2025-02-12 00:44:12', '2025-02-12 00:44:12', NULL),
(535, 24, 'reopen', NULL, 0, 2, '2025-02-12 00:50:56', '2025-02-12 00:50:56', NULL),
(536, 21, 'reopen', NULL, 0, 2, '2025-02-12 00:54:02', '2025-02-12 00:54:02', NULL),
(537, 25, 'reopen', NULL, 0, 2, '2025-02-13 04:41:34', '2025-02-13 04:41:34', NULL),
(538, 25, 'close', 'Closed by the system based on complete details', 0, 2, '2025-02-13 04:45:01', '2025-02-13 04:45:01', NULL),
(539, 24, 'close', 'Closed by the system based on complete details', 0, 2, '2025-02-13 04:45:40', '2025-02-13 04:45:40', NULL),
(540, 21, 'close', 'Closed by the system based on complete details', 0, 2, '2025-02-13 04:46:25', '2025-02-13 04:46:25', NULL),
(541, 13, 'close', 'Closed by the system based on complete details', 0, 2, '2025-02-13 04:47:59', '2025-02-13 04:47:59', NULL),
(542, 15, 'reopen', NULL, 0, 2, '2025-02-13 04:49:17', '2025-02-13 04:49:17', NULL),
(543, 44, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-13 04:52:55', '2025-02-13 04:52:55', NULL),
(544, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-19 22:20:56', '2025-02-19 22:20:56', NULL),
(545, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-19 22:21:55', '2025-02-19 22:21:55', NULL),
(546, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-19 22:25:47', '2025-02-19 22:25:47', NULL),
(547, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-19 22:31:35', '2025-02-19 22:31:35', NULL),
(548, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-19 22:36:26', '2025-02-19 22:36:26', NULL),
(549, 47, 'pending', 'Pending due to incomplete details', 0, 2, '2025-02-19 22:37:16', '2025-02-19 22:37:16', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `inquires`
--

CREATE TABLE `inquires` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('brand','generic') DEFAULT NULL,
  `brand_id` bigint(20) UNSIGNED DEFAULT NULL,
  `generic_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `quote_number` varchar(255) DEFAULT NULL,
  `assigned_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('open','close','reopen','pending') DEFAULT 'open',
  `no_of_supplier` int(11) DEFAULT NULL,
  `no_of_brand` int(11) DEFAULT NULL,
  `is_generic_name` tinyint(1) DEFAULT 0,
  `is_brand_name` tinyint(1) DEFAULT 0,
  `is_manufacturer_name` tinyint(1) DEFAULT 0,
  `is_price_per_pack` tinyint(1) DEFAULT 0,
  `is_gst` tinyint(1) DEFAULT 0,
  `is_expiry` tinyint(1) DEFAULT 0,
  `is_storage_condition` tinyint(1) DEFAULT 0,
  `is_lead_time` tinyint(1) DEFAULT 0,
  `is_product_photo` tinyint(1) DEFAULT 0,
  `is_product_doc` tinyint(1) DEFAULT 0,
  `is_pack_size` tinyint(1) DEFAULT 0,
  `is_vendor_name` tinyint(1) DEFAULT 0,
  `creation_date` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inquires`
--

INSERT INTO `inquires` (`id`, `type`, `brand_id`, `generic_id`, `quantity`, `quote_number`, `assigned_user_id`, `status`, `no_of_supplier`, `no_of_brand`, `is_generic_name`, `is_brand_name`, `is_manufacturer_name`, `is_price_per_pack`, `is_gst`, `is_expiry`, `is_storage_condition`, `is_lead_time`, `is_product_photo`, `is_product_doc`, `is_pack_size`, `is_vendor_name`, `creation_date`, `created_by`, `created_at`, `updated_at`, `updated_by`) VALUES
(7, 'brand', 1, NULL, 5, 'SMLQ7', 1, 'open', NULL, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, '2024-11-25 01:44:09', 1, '2024-11-25 01:44:09', '2024-11-25 01:50:11', NULL),
(8, 'generic', NULL, 1, 15, 'SMLQ8', 1, 'open', NULL, NULL, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, '2024-11-25 01:44:23', 1, '2024-11-25 01:44:23', '2024-12-01 22:43:17', 3),
(9, 'brand', 2, NULL, 9, 'SMLQ9', 2, 'pending', NULL, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, '2024-11-25 01:44:41', 1, '2024-11-25 01:44:41', '2025-01-20 23:15:51', 2),
(10, 'generic', NULL, 2, 155, 'SMLQ10', 1, 'pending', NULL, NULL, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, '2024-11-25 01:44:59', 1, '2024-11-25 01:44:59', '2025-01-09 04:46:04', 2),
(11, 'brand', 3, NULL, 99, 'SMLQ11', 2, 'open', NULL, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, '2024-11-25 01:46:06', 1, '2024-11-25 01:46:06', '2024-12-02 01:28:54', NULL),
(12, 'generic', NULL, 3, 99, 'SMLQ12', 1, 'open', NULL, NULL, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, '2024-11-25 01:46:28', 1, '2024-11-25 01:46:28', '2024-12-01 22:41:04', 3),
(13, 'brand', 7, NULL, 55, 'SMLQ13', 2, 'close', 1, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-12 00:31:46', 2, '2024-12-02 01:30:39', '2025-02-13 04:47:59', 2),
(14, 'generic', NULL, 111, 55, 'SMLQ14', 2, 'close', 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-12 00:27:55', 1, '2024-12-04 01:11:59', '2025-02-12 00:43:32', 2),
(15, 'generic', NULL, 19, 15, 'SMLQ15', NULL, 'reopen', 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-13 04:49:17', 1, '2024-12-04 04:59:32', '2025-02-13 04:49:17', 2),
(16, 'generic', NULL, 49, 909, 'SMLQ16', 1, 'close', NULL, NULL, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, '2024-12-04 05:13:58', 1, '2024-12-04 05:13:58', '2024-12-19 04:22:25', 2),
(17, 'generic', NULL, 48, 5, 'SMLQ17', 2, 'pending', 2, 2, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2024-12-04 05:22:29', 2, '2024-12-04 05:22:29', '2025-01-27 23:06:58', 2),
(18, 'generic', NULL, 5, 5, 'SMLQ18', 2, 'pending', 1, 2, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-06 06:55:53', 2, '2024-12-09 22:18:57', '2025-02-06 23:59:18', 2),
(19, 'generic', NULL, 35, 55, 'SMLQ19', 2, 'close', 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-12 00:02:07', 2, '2024-12-09 23:50:16', '2025-02-12 00:44:12', 2),
(20, 'brand', 10, NULL, 55, 'SMLQ20', 2, 'close', 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-11 23:20:39', 2, '2024-12-13 05:56:05', '2025-02-11 23:22:39', 2),
(21, 'generic', NULL, 24, 55, 'SMLQ21', 2, 'close', 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-12 00:54:02', 2, '2024-12-16 04:11:02', '2025-02-13 04:46:25', 2),
(22, 'generic', NULL, 43, 1959, 'SMLQ22', 3, 'close', 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2024-12-16 05:42:01', 3, '2024-12-16 05:42:01', '2025-01-01 00:58:45', 2),
(23, 'generic', NULL, 27, 51, 'SMLQ23', 2, 'pending', 5, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-06 06:19:41', 3, '2024-12-16 05:50:53', '2025-02-06 06:38:39', 2),
(24, 'brand', 12, NULL, 5, 'SMLQ24', 2, 'close', 1, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-12 00:50:56', 3, '2024-12-16 23:57:11', '2025-02-13 04:45:40', 2),
(25, 'brand', 13, NULL, 5, 'SMLQ25', 2, 'close', 1, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-13 04:41:34', 3, '2024-12-17 00:03:49', '2025-02-13 04:45:01', 2),
(26, 'brand', 14, NULL, 1569, 'SMLQ26', 2, 'pending', 5, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2024-12-17 00:09:53', 3, '2024-12-17 00:09:53', '2025-01-28 01:07:27', 2),
(27, 'brand', 11, NULL, 5, 'SMLQ27', 2, 'close', 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-07 00:15:36', 3, '2024-12-17 00:19:28', '2025-02-07 00:17:45', 2),
(28, 'generic', NULL, 7, 155, 'SMLQ28', 2, 'close', 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-07 00:08:21', 3, '2024-12-17 00:33:58', '2025-02-07 00:09:14', 2),
(29, 'generic', NULL, 33, 5, 'SMLQ29', 2, 'close', 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-07 00:21:10', 3, '2024-12-17 01:18:51', '2025-02-11 23:16:51', 2),
(33, 'generic', NULL, 5, 5, 'SMLQ30', 2, 'close', 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-07 00:24:46', 3, '2024-12-17 03:27:52', '2025-02-11 23:17:25', 2),
(34, 'generic', NULL, 46, 5, 'SMLQ31', 2, 'close', 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-07 00:53:43', 3, '2024-12-17 22:11:36', '2025-02-11 23:18:04', 2),
(37, 'generic', NULL, 45, 5, 'SMLQ33', 2, 'close', 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-04 22:16:35', 2, '2025-01-05 23:07:43', '2025-02-04 22:34:50', 2),
(38, 'generic', NULL, 47, 155, 'SMLQ34', 2, 'close', 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-04 22:08:27', 2, '2025-01-05 23:10:55', '2025-02-04 22:35:39', 2),
(39, 'generic', NULL, 30, 1005, 'SMLQ35', 2, 'pending', 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-01-06 03:27:10', 2, '2025-01-06 03:27:10', '2025-02-06 06:46:14', 2),
(40, 'generic', NULL, 112, 505, 'SMLQ36', 2, 'pending', 2, 3, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-01-07 03:49:35', 2, '2025-01-07 03:49:35', '2025-02-04 23:09:17', 2),
(41, 'generic', NULL, 113, 505, 'SMLQ37', 2, 'pending', 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-01-07 04:01:58', 2, '2025-01-07 04:01:58', '2025-02-06 06:47:04', 2),
(42, 'brand', 16, NULL, 55, 'SMLQ38', 2, 'pending', 2, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, '2025-01-09 23:55:24', 2, '2025-01-09 23:55:24', '2025-02-05 04:29:15', 2),
(43, 'generic', NULL, 114, 105, 'SMLQ39', 2, 'pending', 5, 3, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-01-09 23:56:13', 2, '2025-01-09 23:56:13', '2025-01-24 06:47:07', 2),
(44, 'brand', 4, NULL, 509, 'SMLQ40', 2, 'pending', 2, 5, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-01-20 23:07:39', 2, '2025-01-20 23:07:39', '2025-02-06 06:57:52', 2),
(45, 'brand', 21, NULL, 110000, 'SMLQ41', 2, 'pending', 5, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-01-21 05:50:55', 2, '2025-01-21 05:50:55', '2025-01-29 06:55:28', 2),
(46, 'generic', NULL, 115, 5, 'SMLQ42', 2, 'pending', 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-01-23 04:47:56', 2, '2025-01-23 04:47:56', '2025-01-29 06:34:08', 2),
(47, 'generic', NULL, 116, 2, 'SMLQ43', 2, 'pending', 2, 2, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-01-28 22:56:11', 2, '2025-01-28 22:56:11', '2025-01-28 22:58:38', 2),
(48, 'generic', NULL, 117, 15, 'SMLQ44', 2, 'close', 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-01-30 22:58:28', 2, '2025-01-30 06:51:44', '2025-02-02 23:53:31', 2),
(50, 'generic', NULL, 119, 5, 'SMLQ46', 2, 'open', 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-06 06:59:26', 2, '2025-02-06 06:59:26', '2025-02-07 06:46:44', 2),
(52, 'brand', 22, NULL, 55, 'SMLQ48', 2, 'open', 1, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-11 22:20:39', 2, '2025-02-11 22:20:39', '2025-02-12 00:19:44', 2),
(53, 'brand', 36, NULL, 551, 'SMLQ49', NULL, 'open', 1, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-17 04:39:16', 2, '2025-02-17 04:39:16', '2025-02-17 04:39:16', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `inquiries_histories`
--

CREATE TABLE `inquiries_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `inquiry_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` enum('brand','generic') DEFAULT NULL,
  `brand_id` bigint(20) UNSIGNED DEFAULT NULL,
  `generic_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `quote_number` varchar(255) DEFAULT NULL,
  `assigned_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('open','close','reopen','pending') NOT NULL DEFAULT 'open',
  `no_of_supplier` int(11) DEFAULT NULL,
  `no_of_brand` int(11) DEFAULT NULL,
  `is_generic_name` tinyint(1) NOT NULL DEFAULT 0,
  `is_brand_name` tinyint(1) NOT NULL DEFAULT 0,
  `is_manufacturer_name` tinyint(1) NOT NULL DEFAULT 0,
  `is_price_per_pack` tinyint(1) NOT NULL DEFAULT 0,
  `is_gst` tinyint(1) DEFAULT 0,
  `is_expiry` tinyint(1) NOT NULL DEFAULT 0,
  `is_storage_condition` tinyint(1) NOT NULL DEFAULT 0,
  `is_lead_time` tinyint(1) NOT NULL DEFAULT 0,
  `is_product_photo` tinyint(1) NOT NULL DEFAULT 0,
  `is_product_doc` tinyint(1) NOT NULL DEFAULT 0,
  `is_pack_size` tinyint(1) DEFAULT 0,
  `is_vendor_name` tinyint(1) DEFAULT 0,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inquiries_histories`
--

INSERT INTO `inquiries_histories` (`id`, `inquiry_id`, `type`, `brand_id`, `generic_id`, `quantity`, `quote_number`, `assigned_user_id`, `status`, `no_of_supplier`, `no_of_brand`, `is_generic_name`, `is_brand_name`, `is_manufacturer_name`, `is_price_per_pack`, `is_gst`, `is_expiry`, `is_storage_condition`, `is_lead_time`, `is_product_photo`, `is_product_doc`, `is_pack_size`, `is_vendor_name`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 12, 'generic', NULL, 3, 25, 'SMLQ12', 1, 'open', NULL, NULL, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, '2024-11-25 02:11:45', '2024-11-25 02:11:45'),
(2, 12, 'generic', NULL, 3, 25, 'SMLQ12', 1, 'open', NULL, NULL, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, '2024-11-25 03:27:36', '2024-11-25 03:27:36'),
(3, 12, 'generic', NULL, 3, 25, 'SMLQ12', 1, 'open', NULL, NULL, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, '2024-11-25 03:33:43', '2024-11-25 03:33:43'),
(4, 8, 'generic', NULL, 1, 15, 'SMLQ8', 1, 'open', NULL, NULL, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, '2024-12-01 22:43:17', '2024-12-01 22:43:17'),
(6, 10, 'generic', NULL, 2, 15, 'SMLQ10', 2, 'open', NULL, NULL, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, '2024-12-02 03:31:37', '2024-12-02 03:31:37'),
(7, 10, 'generic', NULL, 2, 9, 'SMLQ10', 2, 'open', NULL, NULL, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, '2024-12-02 23:57:12', '2024-12-02 23:57:12'),
(8, 10, 'generic', NULL, 2, 55, 'SMLQ10', 2, 'open', NULL, NULL, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1, '2024-12-03 00:26:21', '2024-12-03 00:26:21'),
(9, 10, 'generic', NULL, 2, 55, 'SMLQ10', 2, 'open', NULL, NULL, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, '2024-12-03 22:23:53', '2024-12-03 22:23:53'),
(10, 10, 'generic', NULL, 2, 105, 'SMLQ10', 1, 'open', NULL, NULL, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, '2024-12-04 03:18:02', '2024-12-04 03:18:02'),
(11, 20, 'brand', 10, NULL, 105, 'SMLQ20', 2, 'open', NULL, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 2, '2024-12-16 05:33:18', '2024-12-16 05:33:18'),
(12, 23, 'generic', NULL, 27, 529, 'SMLQ23', 3, 'close', 2, 2, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, '2024-12-17 22:10:50', '2024-12-17 22:10:50'),
(13, 17, 'generic', NULL, 48, 56, 'SMLQ17', 1, 'close', NULL, NULL, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, '2024-12-19 04:07:55', '2024-12-19 04:07:55'),
(14, 20, 'brand', 10, NULL, 559, 'SMLQ20', 3, 'close', NULL, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 2, '2024-12-22 23:52:49', '2024-12-22 23:52:49'),
(15, 13, 'brand', 7, NULL, 5, 'SMLQ13', 2, 'close', NULL, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 2, '2025-01-01 06:27:00', '2025-01-01 06:27:00'),
(16, 38, 'generic', NULL, 47, 109, 'SMLQ34', 2, 'close', 1, 2, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, '2025-01-08 05:56:22', '2025-01-08 05:56:22'),
(17, 27, 'brand', 11, NULL, 5569, 'SMLQ27', 2, 'close', 2, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, '2025-01-20 22:32:45', '2025-01-20 22:32:45'),
(18, 40, 'generic', NULL, 112, 555, 'SMLQ36', 2, 'close', 2, 2, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, '2025-01-29 22:32:09', '2025-01-29 22:32:09'),
(19, 40, 'generic', NULL, 112, 5, 'SMLQ36', 2, 'close', 2, 2, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, '2025-01-30 02:53:23', '2025-01-30 02:53:23'),
(20, 44, 'brand', 15, NULL, 5, 'SMLQ40', 2, 'close', 2, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, '2025-01-30 04:13:44', '2025-01-30 04:13:44'),
(21, 39, 'generic', NULL, 30, 5, 'SMLQ35', 2, 'close', 2, 2, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, '2025-01-30 04:20:52', '2025-01-30 04:20:52'),
(22, 41, 'generic', NULL, 113, 559, 'SMLQ37', 2, 'close', 2, 2, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, '2025-01-30 05:16:55', '2025-01-30 05:16:55'),
(23, 27, 'brand', 11, NULL, 55, 'SMLQ27', 2, 'close', 2, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, '2025-01-30 07:06:32', '2025-01-30 07:06:32'),
(24, 48, 'generic', NULL, 117, 115, 'SMLQ44', 2, 'close', 5, 2, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, '2025-01-27 22:39:30', '2025-01-30 22:39:30'),
(25, 48, 'generic', NULL, 117, 10151, 'SMLQ44', 2, 'close', 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, '2025-01-29 04:26:26', NULL),
(26, 48, 'generic', NULL, 117, 151, 'SMLQ44', 2, 'close', 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, '2025-01-29 22:51:18', NULL),
(27, 38, 'generic', NULL, 47, 565, 'SMLQ34', 2, 'close', 1, 2, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, '2025-02-04 22:08:27', NULL),
(29, 37, 'generic', NULL, 45, 105, 'SMLQ33', 2, 'close', 2, 2, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, '2025-01-05 22:16:35', NULL),
(30, 23, 'generic', NULL, 27, 5, 'SMLQ23', 2, 'close', 2, 2, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, '2024-12-16 05:50:53', NULL),
(31, 23, 'generic', NULL, 27, 105, 'SMLQ23', 2, 'close', 5, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, '2025-01-23 04:54:11', NULL),
(32, 18, 'brand', 4, NULL, 159, 'SMLQ18', 2, 'close', NULL, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 2, '2024-12-10 04:49:20', NULL),
(33, 14, 'generic', NULL, 111, 109, 'SMLQ14', 1, 'close', NULL, NULL, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, '2025-02-06 04:54:55', NULL),
(34, 19, 'generic', NULL, 35, 1005, 'SMLQ19', 2, 'close', NULL, NULL, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 2, '2024-12-09 23:50:16', NULL),
(35, 28, 'generic', NULL, 7, 5498, 'SMLQ28', 2, 'close', 5, 2, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, '2024-12-17 00:33:58', NULL),
(36, 27, 'brand', 11, NULL, 1005, 'SMLQ27', 2, 'close', 1, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, '2025-01-30 07:06:32', NULL),
(37, 29, 'generic', NULL, 33, 1005, 'SMLQ29', 2, 'close', 2, 2, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, '2024-12-17 01:18:51', NULL),
(38, 33, 'generic', NULL, 5, 59, 'SMLQ30', 2, 'close', 1, 2, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, '2024-12-17 03:27:52', NULL),
(39, 34, 'generic', NULL, 46, 5, 'SMLQ31', 2, 'close', 2, 2, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 3, '2024-12-17 22:11:36', NULL),
(40, 20, 'brand', 10, NULL, 5, 'SMLQ20', 3, 'close', 1, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, '2024-12-13 05:56:05', NULL),
(41, 19, 'generic', NULL, 35, 5, 'SMLQ19', 2, 'close', 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, '2025-02-07 00:01:00', NULL),
(42, 13, 'brand', 7, NULL, 10000, 'SMLQ13', 2, 'close', 5, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, '2024-12-02 01:30:39', NULL),
(43, 14, 'generic', NULL, 111, 5, 'SMLQ14', 2, 'close', 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2025-02-06 06:59:53', NULL),
(44, 13, 'brand', 7, NULL, 55, 'SMLQ13', 2, 'close', 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, '2025-02-12 00:22:16', NULL),
(45, 24, 'brand', 12, NULL, 15559, 'SMLQ24', 2, 'close', NULL, NULL, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 0, 3, '2024-12-16 23:57:11', NULL),
(48, 21, 'generic', NULL, 24, 199, 'SMLQ21', 2, 'close', 2, 2, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, '2024-12-16 04:11:02', NULL),
(49, 25, 'brand', 13, NULL, 55, 'SMLQ25', 2, 'close', 5, NULL, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, '2024-12-17 00:03:49', NULL),
(50, 15, 'generic', NULL, 19, 105, 'SMLQ15', 1, 'close', NULL, NULL, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, '2024-12-04 04:59:32', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `manufacturers`
--

CREATE TABLE `manufacturers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `manufacturers`
--

INSERT INTO `manufacturers` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'SUN PHARMACEUTICAL INDUSTRIES', '2024-11-23 01:25:19', '2024-11-23 01:25:19'),
(2, 'DIVI’S LABORATORIES', '2024-11-23 01:25:29', '2024-11-23 01:25:29'),
(3, 'DR. REDDY’S LABORATORIES', '2024-11-23 01:25:38', '2024-11-23 01:25:38'),
(4, 'CIPLA', '2024-11-23 01:25:45', '2024-11-23 01:25:45'),
(5, 'EMCURE PHARMACEUTICALS', '2024-11-23 01:25:58', '2024-11-23 01:25:58'),
(6, 'TORRENT PHARMA', '2024-11-23 01:26:06', '2024-11-23 01:26:06'),
(7, 'NHHRGDFG', '2025-02-13 02:41:38', '2025-02-13 02:41:38'),
(8, 'H54RY34TGG43', '2025-02-13 02:41:42', '2025-02-13 02:41:42'),
(9, 'J65JTNRH5', '2025-02-13 02:41:48', '2025-02-13 02:41:48'),
(10, 'Y76HOBRKHG', '2025-02-13 02:41:53', '2025-02-13 02:41:53'),
(12, 'AYYB1', '2025-02-14 06:15:20', '2025-02-14 06:15:20'),
(13, 'AYYB2A', '2025-02-14 06:15:28', '2025-02-14 06:16:05'),
(14, 'AYYB3HG', '2025-02-14 06:15:33', '2025-02-14 06:16:10'),
(15, 'AYYB4G', '2025-02-14 06:15:41', '2025-02-14 06:16:14'),
(16, 'AYYB5JHH', '2025-02-14 06:16:21', '2025-02-14 06:16:21'),
(17, 'AYYB6K', '2025-02-14 06:16:30', '2025-02-14 06:16:30'),
(18, 'AYYB7L', '2025-02-14 06:16:40', '2025-02-14 06:16:40'),
(19, 'AYYB8YU', '2025-02-14 06:16:49', '2025-02-14 06:16:49'),
(20, 'AYYB9HJ', '2025-02-14 06:16:56', '2025-02-14 06:16:56'),
(21, 'AYYB10FHHF', '2025-02-14 06:17:02', '2025-02-14 06:17:02'),
(22, 'AYYB76LL', '2025-02-14 06:17:11', '2025-02-14 06:17:11'),
(23, 'AYYBFF', '2025-02-14 06:17:19', '2025-02-14 06:17:19'),
(24, 'AYYBEDHUF', '2025-02-14 06:17:25', '2025-02-14 06:17:25'),
(25, 'AYYB2GEIFW', '2025-02-14 06:17:30', '2025-02-14 06:17:30'),
(26, 'AYYB2GEE', '2025-02-14 06:17:34', '2025-02-14 06:17:34'),
(27, 'AYYBGYEDFUS', '2025-02-14 06:17:39', '2025-02-14 06:17:39'),
(28, 'AYYB11D', '2025-02-14 06:17:48', '2025-02-14 06:17:48');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2024_04_16_094651_create_permission_tables', 1),
(6, '2024_04_17_060845_create_orders_table', 1),
(7, '2024_04_17_061927_create_order_products_table', 1),
(8, '2024_04_17_062532_create_order_product_stocks_table', 1),
(9, '2024_04_17_063323_create_order_packages_table', 1),
(10, '2024_04_17_063610_create_order_package_products_table', 1),
(11, '2024_04_26_045033_create_products', 1),
(12, '2024_04_26_045203_create_product_variants', 1),
(13, '2024_05_31_061108_create_customer_table', 1),
(14, '2024_06_03_045224_remove_columns_name_from_orders', 1),
(15, '2024_06_03_045618_add_new_columns_to_orders_table', 1),
(16, '2024_06_05_095658_update_quantity_nullable_in_order_package_products_table', 1),
(17, '2024_06_05_100924_update_order_packages_nullable_fields', 1),
(18, '2024_06_10_054119_update_customers_table', 1),
(19, '2024_06_13_062403_remove_unique_columns_orders_table', 1),
(20, '2024_06_21_123952_add_currency_to_customers_table', 1),
(21, '2024_06_21_125027_add_fields_to_orders_table', 1),
(22, '2024_06_21_125543_create_configurations_table', 1),
(23, '2024_06_24_085043_add_price_per_set_and_total_order_products_table', 1),
(24, '2024_06_25_084543_add_unique_to_invoice_no_in_orders_table', 1),
(25, '2024_06_26_081011_add_fields_to_products_table', 1),
(26, '2024_06_26_103800_add_created_by_and_updated_by_to_orders_table', 1),
(27, '2024_06_28_121748_create_banks_table', 1),
(28, '2024_07_01_084914_add_bank_id_to_customers_table', 1),
(29, '2024_07_01_130537_add_new_fields_to_orders_table', 1),
(30, '2024_07_05_120133_add_account_no_to_banks_table', 1),
(31, '2024_07_17_122213_create_proformas_table', 1),
(32, '2024_07_17_123340_create_proforma_products_table', 1),
(33, '2024_07_23_102644_create_venders_table', 1),
(34, '2024_07_25_055037_create_generics_table', 1),
(35, '2024_07_25_074244_create_manufacturers_table', 1),
(36, '2024_07_25_112528_add_parent_id_to_users_table', 1),
(37, '2024_07_26_113957_modify_ifsc_code_unique_nullable_in_banks_table', 1),
(38, '2024_07_27_110748_create_inquires_table', 1),
(39, '2024_07_29_103753_create_quotations_table', 1),
(40, '2024_07_29_115544_create_suppliers_table', 1),
(41, '2024_07_31_131631_create_product_photos_table', 1),
(42, '2024_07_31_131951_create_product_documents_table', 1),
(43, '2024_08_12_035948_add_port_of_discharge_to_orders_table', 1),
(50, '2024_11_20_121638_create_inquery_status_history_table', 2),
(51, '2024_11_23_063257_create_inquiries_histories_table', 2),
(52, '2024_11_23_063306_create_quotations_histories_table', 2),
(53, '2024_11_23_063312_create_suppliers_histories_table', 2),
(54, '2024_11_23_063319_create_product_photos_histories_table', 2),
(55, '2024_11_23_063324_create_product_documents_histories_table', 2),
(57, '2024_11_27_113642_add_subscription_token_to_users_table', 3),
(58, '2024_11_28_051247_create_user_device_token_table', 4),
(59, '2024_11_28_094709_add_type_to_roles_table', 5),
(60, '2024_11_29_104037_create_notifications_table', 6),
(71, '2024_12_04_060051_add_product_variant_id_to_quotations_and_quotations_histories_tables', 8),
(73, '2024_12_04_060316_add_is_pack_size_to_inquires_and_inquiries_histories_tables', 9),
(78, '2024_12_04_112653_create_quotation_queries_table', 10),
(79, '2024_12_06_061945_update_value_column_in_configurations_table', 10),
(80, '2024_12_13_102406_add_pending_status_to_inquires_table', 11),
(81, '2024_12_13_105721_add_pending_status_to_inquery_status_history_table', 12),
(82, '2024_12_16_103408_add_is_vendor_name_to_inquires_table', 13),
(83, '2024_12_16_103528_add_is_vendor_name_to_inquiries_histories_table', 14),
(84, '2024_12_16_110234_add_pending_status_to_inquiries_histories_table', 15),
(87, '2024_12_17_062511_rename_is_gest_to_is_gst_in_inquires_table', 16),
(88, '2024_12_17_063611_rename_is_gest_to_is_gst_in_inquires_histories_table', 17),
(90, '2024_12_17_065847_add_no_of_supplier_and_no_of_brand_to_inquires_table', 18),
(91, '2024_12_17_070215_add_no_of_supplier_and_no_of_brand_to_inquiries_histories_table', 19),
(92, '2024_12_27_120419_alter_url_column_in_notifications_table', 20),
(93, '2024_11_12_081247_update_customers_table_make_fields_nullable', 21),
(94, '2025_01_02_041143_update_zip_code_length_in_customers_table', 21),
(95, '2025_01_03_084517_update_zip_code_length_in_orders_table', 22),
(97, '2025_01_03_085444_update_zip_code_length_in_proformas_table', 23),
(98, '2025_01_09_103734_update_quantity_in_order_and_proforma_products_tables', 24),
(99, '2025_01_09_105107_revert_quantity_in_order_and_proforma_products_tables', 25),
(100, '2025_01_22_043435_add_is_manually_to_inquiry_status_history_table', 26),
(101, '2025_01_30_121318_add_creation_date_inquires_table', 27);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(1, 'App\\Models\\User', 15),
(1, 'App\\Models\\User', 16),
(1, 'App\\Models\\User', 17),
(1, 'App\\Models\\User', 27),
(1, 'App\\Models\\User', 28),
(1, 'App\\Models\\User', 29),
(2, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(2, 'App\\Models\\User', 5),
(2, 'App\\Models\\User', 18),
(2, 'App\\Models\\User', 19),
(3, 'App\\Models\\User', 3),
(4, 'App\\Models\\User', 6),
(8, 'App\\Models\\User', 6);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `heading` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `url` text NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `heading`, `content`, `url`, `is_read`, `created_at`, `updated_at`) VALUES
(1, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Products%20purchase%20updated%20successfully', 1, '2024-11-29 05:16:37', '2024-11-30 03:03:04'),
(2, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-29 05:17:23', '2024-11-30 03:07:01'),
(3, 1, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-29 05:18:01', '2024-11-29 05:18:01'),
(4, 2, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-29 05:18:01', '2024-11-29 05:18:01'),
(5, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-29 05:18:01', '2024-11-30 06:32:13'),
(6, 1, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-29 06:18:08', '2024-11-29 06:18:08'),
(7, 2, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-29 06:18:08', '2024-11-29 06:18:08'),
(8, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-29 06:18:08', '2024-11-30 03:08:25'),
(9, 1, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-29 06:18:14', '2024-11-29 06:18:14'),
(10, 2, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-29 06:18:14', '2024-11-29 06:18:14'),
(11, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-29 06:18:14', '2024-11-30 03:18:20'),
(12, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-29 06:18:33', '2024-12-08 22:51:40'),
(13, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-29 06:18:37', '2024-11-29 06:18:37'),
(14, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-29 06:18:41', '2024-11-29 06:18:41'),
(15, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-29 06:20:01', '2024-11-29 06:20:01'),
(16, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-29 06:20:05', '2024-11-29 06:20:05'),
(17, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-29 06:20:10', '2024-11-29 06:20:10'),
(18, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Products%20purchase%20updated%20successfully', 1, '2024-11-29 06:22:39', '2024-11-29 22:08:02'),
(19, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders', 1, '2024-11-29 22:37:06', '2024-11-29 22:37:06'),
(20, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-29 22:37:46', '2024-11-29 22:37:46'),
(21, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-29 22:38:28', '2024-11-29 22:38:28'),
(22, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-29 22:46:04', '2024-11-29 22:46:04'),
(23, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders', 1, '2024-11-29 23:50:25', '2024-11-29 23:50:25'),
(24, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders', 1, '2024-11-30 00:52:34', '2024-11-30 00:52:34'),
(25, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders', 1, '2024-11-30 01:06:35', '2024-11-30 01:13:41'),
(26, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-30 01:12:15', '2024-11-30 01:15:03'),
(27, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-30 03:29:07', '2024-11-30 03:29:07'),
(28, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-30 03:48:11', '2024-11-30 03:48:11'),
(29, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-30 03:52:51', '2024-11-30 03:52:51'),
(30, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-30 05:33:06', '2024-11-30 05:33:06'),
(31, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-11-30 06:32:45', '2024-11-30 06:32:45'),
(32, 1, 'New Order Product Stock Has Arrived', 'A new order product stock added', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-11', 0, '2024-12-01 23:01:46', '2024-12-01 23:01:46'),
(33, 2, 'New Order Product Stock Has Arrived', 'A new order product stock added', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-11', 0, '2024-12-01 23:01:46', '2024-12-19 00:50:47'),
(34, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-11', 1, '2024-12-03 03:15:12', '2024-12-18 06:31:29'),
(35, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-11', 1, '2024-12-03 03:21:29', '2024-12-03 03:21:52'),
(36, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-11', 1, '2024-12-08 21:58:21', '2024-12-08 21:58:21'),
(37, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-11&success=Order%20products%20updated%20successfully', 1, '2024-12-08 22:01:33', '2024-12-08 22:18:33'),
(38, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-11', 1, '2024-12-08 22:51:24', '2024-12-08 22:51:24'),
(39, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders', 1, '2024-12-11 01:07:06', '2024-12-11 01:07:36'),
(40, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders', 1, '2024-12-18 04:32:29', '2024-12-18 06:53:11'),
(41, 3, 'New Order Product Has Arrived', 'A new order product added', 'http://127.0.0.1:8000/orders', 1, '2024-12-19 00:42:40', '2024-12-19 00:42:40'),
(42, 3, 'SMPL4 New Order Won!!', 'Let the hunt for the best deal begin!', 'http%3A%2F%2F127.0.0.1%3A8000%2Forders%3Fsuccess%3DOrder%2520products%2520updated%2520successfully', 1, '2024-12-19 02:01:24', '2024-12-19 02:01:24'),
(43, 3, 'SMPL4 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-19 02:02:39', '2024-12-19 02:02:39'),
(44, 3, 'SMPL4 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-19 03:01:07', '2024-12-19 03:01:07'),
(45, 1, 'New Order Product Purchase Has Arrived', 'A new order product purchase', 'http://127.0.0.1:8000/orders?month=2024-12', 0, '2024-12-19 03:29:17', '2024-12-19 03:29:17'),
(46, 2, 'New Order Product Purchase Has Arrived', 'A new order product purchase', 'http://127.0.0.1:8000/orders?month=2024-12', 0, '2024-12-19 03:29:17', '2024-12-19 03:29:17'),
(47, 3, 'New Order Product Purchase Has Arrived', 'A new order product purchase', 'http://127.0.0.1:8000/orders?month=2024-12', 1, '2024-12-19 03:29:17', '2024-12-19 03:29:17'),
(48, 1, 'New Order Product Purchase Has Arrived', 'A new order product purchase', 'http://127.0.0.1:8000/orders?month=2024-12&success=Products purchase updated successfully', 0, '2024-12-19 03:30:29', '2024-12-19 03:30:29'),
(49, 2, 'New Order Product Purchase Has Arrived', 'A new order product purchase', 'http://127.0.0.1:8000/orders?month=2024-12&success=Products purchase updated successfully', 0, '2024-12-19 03:30:29', '2024-12-19 03:30:29'),
(50, 3, 'New Order Product Purchase Has Arrived', 'A new order product purchase', 'http://127.0.0.1:8000/orders?month=2024-12&success=Products purchase updated successfully', 1, '2024-12-19 03:30:29', '2024-12-19 03:30:29'),
(51, 1, 'New Order Product Purchase Has Arrived', 'A new order product purchase', 'http://127.0.0.1:8000/orders?month=2024-12&success=Products purchase updated successfully', 0, '2024-12-19 03:31:17', '2024-12-19 03:31:17'),
(52, 2, 'New Order Product Purchase Has Arrived', 'A new order product purchase', 'http://127.0.0.1:8000/orders?month=2024-12&success=Products purchase updated successfully', 0, '2024-12-19 03:31:17', '2024-12-19 03:31:17'),
(53, 3, 'New Order Product Purchase Has Arrived', 'A new order product purchase', 'http://127.0.0.1:8000/orders?month=2024-12&success=Products purchase updated successfully', 1, '2024-12-19 03:31:17', '2024-12-19 03:31:17'),
(54, 3, 'SMPL6 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2024-12', 1, '2024-12-19 04:47:11', '2024-12-19 04:51:21'),
(55, 3, 'SMPL6 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2024-12', 1, '2024-12-19 04:50:48', '2024-12-19 04:50:48'),
(56, 3, 'SMPL7 The final order is placed!!', 'A new order product purchase', 'http://127.0.0.1:8000/orders', 1, '2024-12-19 05:57:46', '2024-12-19 05:57:46'),
(57, 5, 'SMPL7 The final order is placed!!', 'A new order product purchase', 'http://127.0.0.1:8000/orders', 0, '2024-12-19 05:57:46', '2024-12-19 05:57:46'),
(58, 3, 'SMPL7 The final order is placed!!', 'A new order product purchase', 'http://127.0.0.1:8000/orders', 1, '2024-12-19 06:05:46', '2024-12-19 06:05:46'),
(59, 5, 'SMPL7 The final order is placed!!', 'A new order product purchase', 'http://127.0.0.1:8000/orders', 0, '2024-12-19 06:05:46', '2024-12-19 06:05:46'),
(60, 6, 'SMPL7 The final order is placed!!', 'A new order product purchase', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-19 06:09:44', '2024-12-19 06:09:44'),
(61, 5, 'SMPL7 The final order is placed!!', 'A new order product purchase', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-19 06:09:44', '2024-12-19 06:09:44'),
(62, 6, 'SMPL7 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-19 06:10:51', '2024-12-19 06:10:51'),
(63, 5, 'SMPL7 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-19 06:10:51', '2024-12-19 06:10:51'),
(64, 6, 'SMPL7 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-19 06:24:18', '2024-12-19 06:24:18'),
(65, 5, 'SMPL7 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-19 06:24:18', '2024-12-19 06:24:18'),
(66, 6, 'SMPL7 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-19 06:24:52', '2024-12-19 06:24:52'),
(67, 5, 'SMPL7 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-19 06:24:52', '2024-12-19 06:24:52'),
(68, 6, 'SMPL7 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders', 0, '2024-12-19 06:50:08', '2024-12-19 06:50:08'),
(69, 5, 'SMPL7 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders', 0, '2024-12-19 06:50:08', '2024-12-19 06:50:08'),
(70, 3, 'SMPL7 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders', 1, '2024-12-19 23:53:58', '2024-12-19 23:53:58'),
(71, 5, 'SMPL7 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders', 0, '2024-12-19 23:53:58', '2024-12-19 23:53:58'),
(72, 3, 'SMPL7 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders', 1, '2024-12-19 23:56:40', '2024-12-19 23:56:40'),
(73, 6, 'SMPL7 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders', 0, '2024-12-19 23:56:40', '2024-12-19 23:56:40'),
(74, 5, 'SMPL7 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders', 0, '2024-12-19 23:56:40', '2024-12-19 23:56:40'),
(75, 3, 'SMPL7 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 1, '2024-12-20 00:08:30', '2024-12-20 00:08:30'),
(76, 6, 'SMPL7 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-20 00:08:30', '2024-12-20 00:08:30'),
(77, 5, 'SMPL7 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-20 00:08:30', '2024-12-20 00:08:30'),
(78, 3, 'SMPL7 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 1, '2024-12-20 00:10:27', '2024-12-20 00:10:27'),
(79, 6, 'SMPL7 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-20 00:10:27', '2024-12-20 00:10:27'),
(80, 5, 'SMPL7 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-20 00:10:27', '2024-12-20 00:10:27'),
(81, 3, 'SMPL7 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 1, '2024-12-20 01:05:00', '2024-12-20 01:05:00'),
(82, 6, 'SMPL7 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-20 01:05:00', '2024-12-20 01:05:00'),
(83, 6, 'SMPL7 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-20 01:19:51', '2024-12-20 01:19:51'),
(84, 5, 'SMPL7 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-20 01:19:51', '2024-12-20 01:19:51'),
(85, 6, 'SMPL7 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-20 01:21:25', '2024-12-20 01:21:25'),
(86, 5, 'SMPL7 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-20 01:21:25', '2024-12-20 01:21:25'),
(87, 6, 'SMPL7 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-20 01:22:44', '2024-12-20 01:22:44'),
(88, 5, 'SMPL7 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-20 01:22:44', '2024-12-20 01:22:44'),
(89, 3, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 1, '2024-12-20 04:17:28', '2024-12-20 04:17:28'),
(90, 6, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 0, '2024-12-20 04:17:28', '2024-12-20 04:17:28'),
(91, 3, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-20 04:19:52', '2024-12-20 04:19:52'),
(92, 6, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 04:19:52', '2024-12-20 04:19:52'),
(93, 3, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-20 04:20:35', '2024-12-20 04:20:35'),
(94, 6, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 04:20:35', '2024-12-20 04:20:35'),
(95, 6, 'SMPL7 Shipping Added!', 'The shipping details have been added.', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 04:20:36', '2024-12-20 04:20:36'),
(96, 6, 'SMPL7 Soft Boxes Added!', 'The soft boxes details have been added.', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 04:20:37', '2024-12-20 04:20:37'),
(97, 6, 'SMPL7 Data Logger Added!', 'The data logger details have been added.', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 04:20:37', '2024-12-20 04:20:37'),
(98, 6, 'SMPL7 Clearance Added!', 'The clearance details have been added.', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 04:20:38', '2024-12-20 04:20:38'),
(99, 3, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-20 04:21:17', '2024-12-20 04:21:17'),
(100, 6, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 04:21:17', '2024-12-20 04:21:17'),
(101, 3, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-20 04:28:09', '2024-12-20 04:28:09'),
(102, 6, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 04:28:09', '2024-12-20 04:28:09'),
(103, 6, 'SMPL7 Shipping, Soft Boxes, Data Logger, Clearance Added!', 'The shipping, soft boxes, data logger, clearance details have been added.', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 04:28:10', '2024-12-20 04:28:10'),
(104, 3, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-20 04:30:35', '2024-12-20 04:30:35'),
(105, 6, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 04:30:35', '2024-12-20 04:30:35'),
(106, 6, 'SMPL7 Shipping Added!', 'The shipping details have been added.', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 04:30:35', '2024-12-20 04:30:35'),
(107, 3, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-20 04:31:12', '2024-12-20 04:31:12'),
(108, 6, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 04:31:12', '2024-12-20 04:31:12'),
(109, 6, 'SMPL7 Soft Boxes Added!', 'The soft boxes details have been added.', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 04:31:13', '2024-12-20 04:31:13'),
(110, 3, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-20 04:31:54', '2024-12-20 04:31:54'),
(111, 6, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 04:31:54', '2024-12-20 04:31:54'),
(112, 6, 'SMPL7 Data Logger Added!', 'The data logger details have been added.', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 04:31:55', '2024-12-20 04:31:55'),
(113, 3, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-20 04:32:11', '2024-12-20 04:32:11'),
(114, 6, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 04:32:11', '2024-12-20 04:32:11'),
(115, 6, 'SMPL7 Clearance Added!', 'The clearance details have been added.', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 04:32:11', '2024-12-20 04:32:11'),
(116, 3, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-20 05:05:37', '2024-12-20 05:05:37'),
(117, 6, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 05:05:37', '2024-12-20 05:05:37'),
(118, 6, 'SMPL7 Shipping, Soft Boxes, Data Logger, Clearance Added!', 'The shipping, soft boxes, data logger, clearance details have been added.', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 05:05:38', '2024-12-20 05:05:38'),
(119, 3, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-20 05:05:58', '2024-12-20 05:05:58'),
(120, 6, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 05:05:58', '2024-12-20 05:05:58'),
(121, 6, 'SMPL7 Shipping, Soft Boxes Added!', 'The shipping, soft boxes details have been added.', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 05:06:00', '2024-12-20 05:06:00'),
(122, 3, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-20 05:41:17', '2024-12-20 05:41:17'),
(123, 6, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 05:41:17', '2024-12-20 05:41:17'),
(124, 3, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-20 05:41:34', '2024-12-20 05:41:34'),
(125, 6, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 05:41:34', '2024-12-20 05:41:34'),
(126, 6, 'SMPL7 Data Logger Details Added!', 'The data logger details have been added.', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 05:41:35', '2024-12-20 05:41:35'),
(127, 3, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-20 05:41:55', '2024-12-20 05:41:55'),
(128, 6, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 05:41:55', '2024-12-20 05:41:55'),
(129, 6, 'SMPL7 Clearance Details Added!', 'The clearance details have been added.', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-20 05:41:56', '2024-12-20 05:41:56'),
(130, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2024-12', 1, '2024-12-20 05:52:30', '2024-12-20 05:52:30'),
(131, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2024-12', 0, '2024-12-20 05:52:30', '2024-12-20 05:52:30'),
(132, 6, 'SMPL8 Shipping, Soft Boxes Details Added!', 'The shipping, soft boxes details have been added.', 'http://127.0.0.1:8000/orders?month=2024-12', 0, '2024-12-20 05:52:31', '2024-12-20 05:52:31'),
(133, 3, 'SMLQ32 Inquiry created', 'Let\'s hope the answer is better than our Wi-Fi signal!!', 'http://127.0.0.1:8000/inquires', 1, '2024-12-22 23:58:58', '2024-12-22 23:58:58'),
(134, 3, 'SMLQ24 MONONINE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=24&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 1, '2024-12-23 03:53:06', '2024-12-23 03:53:06'),
(135, 2, 'SMLQ20 RURVA Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=20&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2024-12-23 04:01:12', '2024-12-23 04:01:12'),
(136, 2, 'SMLQ20 RURVA Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=20&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2024-12-23 04:12:17', '2024-12-23 04:15:10'),
(137, 2, 'SMLQ20 RURVA Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=20&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2024-12-23 04:19:41', '2024-12-23 04:19:41'),
(138, 2, 'SMLQ20 Partial quotation created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=20&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2024-12-23 04:22:38', '2024-12-23 04:22:38'),
(139, 2, 'SMLQ20 RURVA Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=20&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2024-12-23 04:24:20', '2024-12-23 04:24:20'),
(140, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 1, '2024-12-23 04:35:15', '2024-12-23 04:35:15'),
(141, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 0, '2024-12-23 04:35:15', '2024-12-23 04:35:15'),
(142, 6, 'SMPL8 Shipping Details Added!', 'The shipping details have been added.', 'http://127.0.0.1:8000/orders', 0, '2024-12-23 04:35:16', '2024-12-23 04:35:16'),
(143, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-23 04:35:28', '2024-12-23 04:35:28'),
(144, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-23 04:35:28', '2024-12-23 04:35:28'),
(145, 3, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-23 04:36:05', '2024-12-23 04:36:05'),
(146, 6, 'SMPL7 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-23 04:36:05', '2024-12-23 04:36:05'),
(147, 6, 'SMPL7 Shipping, Soft Boxes, Data Logger, Clearance Details Added!', 'The shipping, soft boxes, data logger, clearance details have been added.', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-23 04:36:06', '2024-12-23 04:36:06'),
(148, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-23 04:37:19', '2024-12-23 04:37:19'),
(149, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-23 04:37:19', '2024-12-23 04:37:19'),
(150, 6, 'SMPL8 Data Logger Details Added!', 'The data logger details have been added.', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-23 04:37:20', '2024-12-23 04:37:20'),
(151, 6, 'SMPL9 Shipping, Soft Boxes, Data Logger, Clearance Details Added!', 'The shipping, soft boxes, data logger, clearance details have been added.', 'http://127.0.0.1:8000/orders?month=2024-12', 0, '2024-12-23 04:37:50', '2024-12-23 04:37:50'),
(152, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2024-12&success=Order%20products%20updated%20successfully', 1, '2024-12-23 04:38:19', '2024-12-23 04:38:19'),
(153, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2024-12&success=Order%20products%20updated%20successfully', 0, '2024-12-23 04:38:19', '2024-12-23 04:38:19'),
(154, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2024-12&success=Order%20products%20updated%20successfully', 1, '2024-12-23 04:38:27', '2024-12-23 04:38:27'),
(155, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2024-12&success=Order%20products%20updated%20successfully', 0, '2024-12-23 04:38:27', '2024-12-23 04:38:27'),
(156, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2024-12&success=Order%20products%20updated%20successfully', 1, '2024-12-23 04:39:10', '2024-12-23 04:39:10'),
(157, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2024-12&success=Order%20products%20updated%20successfully', 0, '2024-12-23 04:39:10', '2024-12-23 04:39:10'),
(158, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2024-12&success=Order%20products%20updated%20successfully', 1, '2024-12-23 04:39:15', '2024-12-23 04:39:15'),
(159, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2024-12&success=Order%20products%20updated%20successfully', 0, '2024-12-23 04:39:15', '2024-12-23 04:39:15'),
(160, 2, 'SMLQ17 Partial quotation created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=17&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2024-12-23 04:50:59', '2024-12-23 04:50:59'),
(161, 2, 'SMLQ17 Partial quotation created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2024-12-23 05:00:31', '2024-12-23 05:00:31'),
(162, 2, 'SMLQ21 Partial quotation created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2024-12-23 05:00:50', '2024-12-23 05:00:50'),
(163, 2, 'SMLQ21 GDGDSGD Partial quotation created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2024-12-23 05:10:19', '2024-12-23 05:10:19'),
(164, 2, 'SMLQ21 GDGDSGD Partial quotation created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2024-12-23 05:50:07', '2024-12-23 05:50:07'),
(165, 2, 'SMLQ17 CANDESARTAN CILEXTIL Partial quotation created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=17&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2024-12-23 05:54:35', '2024-12-23 05:54:35'),
(166, 2, 'SMLQ19 UPROPION HCL Client\'s Query Generated!!', 'Time to put on our detective hats and crack the case!', 'http://127.0.0.1:8000/quotations/37?redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations%253FperPage%253D10%2526status%253Dopen', 0, '2024-12-23 07:01:12', '2024-12-23 07:01:12'),
(167, 2, 'SMLQ19 UPROPION HCL Query Resolved!!', 'Mission accomplished!', 'http://127.0.0.1:8000/quotations/37?redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations%253FperPage%253D10%2526status%253Dopen', 0, '2024-12-23 07:02:12', '2024-12-23 07:02:12'),
(168, 3, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 1, '2024-12-24 00:39:08', '2024-12-24 00:39:08'),
(169, 6, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 0, '2024-12-24 00:39:08', '2024-12-24 00:39:08'),
(170, 3, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 1, '2024-12-24 00:39:09', '2024-12-24 00:39:09'),
(171, 6, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 0, '2024-12-24 00:39:09', '2024-12-24 00:39:09'),
(172, 3, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 1, '2024-12-24 05:52:34', '2024-12-24 05:52:34'),
(173, 6, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 0, '2024-12-24 05:52:34', '2024-12-24 05:52:34'),
(174, 3, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 1, '2024-12-24 05:52:35', '2024-12-24 05:52:35'),
(175, 6, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 0, '2024-12-24 05:52:35', '2024-12-24 05:52:35'),
(176, 3, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 1, '2024-12-24 22:44:03', '2024-12-24 22:44:03'),
(177, 6, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 0, '2024-12-24 22:44:03', '2024-12-24 22:44:03'),
(178, 3, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 1, '2024-12-24 22:44:03', '2024-12-24 22:44:03'),
(179, 6, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 0, '2024-12-24 22:44:03', '2024-12-24 22:44:03'),
(180, 3, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-24 22:44:10', '2024-12-24 22:44:10'),
(181, 6, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-24 22:44:10', '2024-12-24 22:44:10'),
(182, 3, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-24 22:44:10', '2024-12-24 22:44:10'),
(183, 6, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-24 22:44:10', '2024-12-24 22:44:10'),
(184, 3, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-24 22:44:57', '2024-12-24 22:44:57'),
(185, 6, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-24 22:44:57', '2024-12-24 22:44:57'),
(186, 3, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-24 22:44:58', '2024-12-24 22:44:58'),
(187, 6, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-24 22:44:58', '2024-12-24 22:44:58'),
(188, 2, 'SMLQ20 RURVA Client\'s Query Generated!!', 'Time to put on our detective hats and crack the case!', 'http://127.0.0.1:8000/quotations/102?redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations%253FperPage%253D10%2526status%253Dclose', 0, '2024-12-24 22:46:59', '2024-12-24 22:46:59'),
(189, 2, 'SMLQ20 RURVA Query Resolved!!', 'Mission accomplished!', 'http://127.0.0.1:8000/quotations/102?redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations%253FperPage%253D10%2526search%253D%2526status%253Dopen', 0, '2024-12-24 22:47:46', '2024-12-24 22:47:46'),
(190, 3, 'SMLQ20 RURVA Client\'s Query Generated!!', 'Time to put on our detective hats and crack the case!', 'http://127.0.0.1:8000/quotations/102?redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations%253FperPage%253D10%2526status%253Dclose', 1, '2024-12-24 22:50:19', '2024-12-24 22:50:19'),
(191, 2, 'SMLQ20 RURVA Query Resolved!!', 'Mission accomplished!', 'http://127.0.0.1:8000/quotations/102?redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations%253FperPage%253D10%2526search%253D%2526status%253Dopen', 0, '2024-12-24 22:50:57', '2024-12-24 22:50:57'),
(192, 3, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 1, '2024-12-24 22:52:12', '2024-12-24 22:52:12'),
(193, 6, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 0, '2024-12-24 22:52:12', '2024-12-24 22:52:12'),
(194, 3, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 1, '2024-12-24 22:52:13', '2024-12-24 22:52:13'),
(195, 6, 'SMPL5 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 0, '2024-12-24 22:52:13', '2024-12-24 22:52:13'),
(196, 3, 'SMPL5 Order Details Revised!!', 'The following fields were updated: .', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-24 23:59:16', '2024-12-24 23:59:16'),
(197, 6, 'SMPL5 Order Details Revised!!', 'The following fields were updated: .', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-24 23:59:16', '2024-12-24 23:59:16'),
(198, 3, 'SMPL5 Order Details Revised!!', 'The following fields were updated: quantity, price_per_set, total, updated_at.', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-24 23:59:17', '2024-12-24 23:59:17'),
(199, 6, 'SMPL5 Order Details Revised!!', 'The following fields were updated: quantity, price_per_set, total, updated_at.', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-24 23:59:17', '2024-12-24 23:59:17'),
(200, 3, 'SMPL5 Order Details Revised!!', 'The updated value !', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:18:21', '2024-12-25 00:18:21'),
(201, 6, 'SMPL5 Order Details Revised!!', 'The updated value !', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:18:21', '2024-12-25 00:18:21'),
(202, 3, 'SMPL5 Order Details Revised!!', 'The updated value Quantity, Price per set, Total, Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:18:22', '2024-12-25 00:18:22'),
(203, 6, 'SMPL5 Order Details Revised!!', 'The updated value Quantity, Price per set, Total, Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:18:22', '2024-12-25 00:18:22'),
(204, 3, 'SMPL5 Order Details Revised!!', 'The updated value !', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:19:37', '2024-12-25 00:19:37'),
(205, 6, 'SMPL5 Order Details Revised!!', 'The updated value !', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:19:37', '2024-12-25 00:19:37'),
(206, 3, 'SMPL5 Order Details Revised!!', 'The updated value Product variant id, Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:19:37', '2024-12-25 00:19:37'),
(207, 6, 'SMPL5 Order Details Revised!!', 'The updated value Product variant id, Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:19:37', '2024-12-25 00:19:37'),
(208, 3, 'SMPL5 Order Details Revised!!', 'The value Updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:29:08', '2024-12-25 00:29:08'),
(209, 6, 'SMPL5 Order Details Revised!!', 'The value Updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:29:08', '2024-12-25 00:29:08'),
(210, 3, 'SMPL5 Order Details Revised!!', 'The value Updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:29:09', '2024-12-25 00:29:09'),
(211, 6, 'SMPL5 Order Details Revised!!', 'The value Updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:29:09', '2024-12-25 00:29:09'),
(212, 3, 'SMPL5 Order Details Revised!!', 'The value Updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:29:25', '2024-12-25 00:29:25'),
(213, 6, 'SMPL5 Order Details Revised!!', 'The value Updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:29:25', '2024-12-25 00:29:25'),
(214, 3, 'SMPL5 Order Details Revised!!', 'The value Quantity, Total, Updated atUpdated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:29:26', '2024-12-25 00:29:26'),
(215, 6, 'SMPL5 Order Details Revised!!', 'The value Quantity, Total, Updated atUpdated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:29:26', '2024-12-25 00:29:26'),
(216, 3, 'SMPL5 Order Details Revised!!', 'The value !', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:30:06', '2024-12-25 00:30:06'),
(217, 6, 'SMPL5 Order Details Revised!!', 'The value !', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:30:06', '2024-12-25 00:30:06'),
(218, 3, 'SMPL5 Order Details Revised!!', 'The value Quantity, Total, Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:30:07', '2024-12-25 00:30:07'),
(219, 6, 'SMPL5 Order Details Revised!!', 'The value Quantity, Total, Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:30:07', '2024-12-25 00:30:07'),
(220, 3, 'SMPL5 Order Details Revised!!', 'The value !', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:30:32', '2024-12-25 00:30:32'),
(221, 6, 'SMPL5 Order Details Revised!!', 'The value !', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:30:32', '2024-12-25 00:30:32'),
(222, 3, 'SMPL5 Order Details Revised!!', 'The value Product variant id, Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:30:33', '2024-12-25 00:30:33'),
(223, 6, 'SMPL5 Order Details Revised!!', 'The value Product variant id, Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:30:33', '2024-12-25 00:30:33'),
(224, 3, 'SMPL5 Order Details Revised!!', 'The value !', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:31:22', '2024-12-25 00:31:22'),
(225, 6, 'SMPL5 Order Details Revised!!', 'The value !', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:31:22', '2024-12-25 00:31:22'),
(226, 3, 'SMPL5 Order Details Revised!!', 'The value product variant id, updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:31:23', '2024-12-25 00:31:23'),
(227, 6, 'SMPL5 Order Details Revised!!', 'The value product variant id, updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:31:23', '2024-12-25 00:31:23'),
(228, 3, 'SMPL5 Order Details Revised!!', 'The value !', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:32:14', '2024-12-25 00:32:14'),
(229, 6, 'SMPL5 Order Details Revised!!', 'The value !', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:32:14', '2024-12-25 00:32:14'),
(230, 3, 'SMPL5 Order Details Revised!!', 'The value product id, product variant id, updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:32:14', '2024-12-25 00:32:14'),
(231, 6, 'SMPL5 Order Details Revised!!', 'The value product id, product variant id, updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:32:14', '2024-12-25 00:32:14'),
(232, 3, 'SMPL5 Order Details Revised!!', 'The value  updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:43:10', '2024-12-25 00:43:10'),
(233, 6, 'SMPL5 Order Details Revised!!', 'The value  updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:43:10', '2024-12-25 00:43:10'),
(234, 3, 'SMPL5 Order Details Revised!!', 'The value Product Description, Pack Size, Updated at updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:43:10', '2024-12-25 00:43:10'),
(235, 6, 'SMPL5 Order Details Revised!!', 'The value Product Description, Pack Size, Updated at updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:43:10', '2024-12-25 00:43:10'),
(236, 3, 'SMPL5 Order Details Revised!!', 'The value  updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:47:10', '2024-12-25 00:47:10'),
(237, 6, 'SMPL5 Order Details Revised!!', 'The value  updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:47:10', '2024-12-25 00:47:10'),
(238, 3, 'SMPL5 Order Details Revised!!', 'The value product description, pack size, updated at updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:47:11', '2024-12-25 00:47:11'),
(239, 6, 'SMPL5 Order Details Revised!!', 'The value product description, pack size, updated at updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:47:11', '2024-12-25 00:47:11');
INSERT INTO `notifications` (`id`, `user_id`, `heading`, `content`, `url`, `is_read`, `created_at`, `updated_at`) VALUES
(240, 3, 'SMPL5 Order Details Revised!!', 'The value  updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:53:49', '2024-12-25 00:53:49'),
(241, 6, 'SMPL5 Order Details Revised!!', 'The value  updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:53:49', '2024-12-25 00:53:49'),
(242, 3, 'SMPL5 Order Details Revised!!', 'The value pack quantity, total, Updated at updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:53:50', '2024-12-25 00:53:50'),
(243, 6, 'SMPL5 Order Details Revised!!', 'The value pack quantity, total, Updated at updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:53:50', '2024-12-25 00:53:50'),
(244, 3, 'SMPL5 Order Details Revised!!', 'The value  updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:56:17', '2024-12-25 00:56:17'),
(245, 6, 'SMPL5 Order Details Revised!!', 'The value  updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:56:17', '2024-12-25 00:56:17'),
(246, 3, 'SMPL5 Order Details Revised!!', 'The value Pack Size, Updated at updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 00:56:17', '2024-12-25 00:56:17'),
(247, 6, 'SMPL5 Order Details Revised!!', 'The value Pack Size, Updated at updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 00:56:17', '2024-12-25 00:56:17'),
(248, 3, 'SMPL5 Order Details Revised!!', 'The value  updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:04:30', '2024-12-25 01:04:30'),
(249, 6, 'SMPL5 Order Details Revised!!', 'The value  updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:04:30', '2024-12-25 01:04:30'),
(250, 3, 'SMPL5 Order Details Revised!!', 'The value Pack Size and Updated at updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:04:30', '2024-12-25 01:04:30'),
(251, 6, 'SMPL5 Order Details Revised!!', 'The value Pack Size and Updated at updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:04:30', '2024-12-25 01:04:30'),
(252, 3, 'SMPL5 Order Details Revised!!', 'The value !', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:05:17', '2024-12-25 01:05:17'),
(253, 6, 'SMPL5 Order Details Revised!!', 'The value !', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:05:17', '2024-12-25 01:05:17'),
(254, 3, 'SMPL5 Order Details Revised!!', 'The value Pack Size and Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:05:17', '2024-12-25 01:05:17'),
(255, 6, 'SMPL5 Order Details Revised!!', 'The value Pack Size and Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:05:17', '2024-12-25 01:05:17'),
(256, 3, 'SMPL5 Order Details Revised!!', 'The value !', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:07:22', '2024-12-25 01:07:22'),
(257, 6, 'SMPL5 Order Details Revised!!', 'The value !', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:07:22', '2024-12-25 01:07:22'),
(258, 3, 'SMPL5 Order Details Revised!!', 'The value Pack Size and Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:07:23', '2024-12-25 01:07:23'),
(259, 6, 'SMPL5 Order Details Revised!!', 'The value Pack Size and Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:07:23', '2024-12-25 01:07:23'),
(260, 3, 'SMPL5 Order Details Revised!!', 'The value !', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:10:02', '2024-12-25 01:10:02'),
(261, 6, 'SMPL5 Order Details Revised!!', 'The value !', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:10:02', '2024-12-25 01:10:02'),
(262, 3, 'SMPL5 Order Details Revised!!', 'The value  updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:11:10', '2024-12-25 01:11:10'),
(263, 6, 'SMPL5 Order Details Revised!!', 'The value  updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:11:10', '2024-12-25 01:11:10'),
(264, 3, 'SMPL5 Order Details Revised!!', 'The value Pack SizeUpdated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:22:07', '2024-12-25 01:22:07'),
(265, 6, 'SMPL5 Order Details Revised!!', 'The value Pack SizeUpdated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:22:07', '2024-12-25 01:22:07'),
(266, 3, 'SMPL5 Order Details Revised!!', 'The value Pack Size Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:22:47', '2024-12-25 01:22:47'),
(267, 6, 'SMPL5 Order Details Revised!!', 'The value Pack Size Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:22:47', '2024-12-25 01:22:47'),
(268, 3, 'SMPL5 Order Details Revised!!', 'The value Product Description, Pack Size andUpdated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:23:00', '2024-12-25 01:23:00'),
(269, 6, 'SMPL5 Order Details Revised!!', 'The value Product Description, Pack Size andUpdated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:23:00', '2024-12-25 01:23:00'),
(270, 3, 'SMPL5 Order Details Revised!!', 'The value Pack Size Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:24:18', '2024-12-25 01:24:18'),
(271, 6, 'SMPL5 Order Details Revised!!', 'The value Pack Size Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:24:18', '2024-12-25 01:24:18'),
(272, 3, 'SMPL5 Order Details Revised!!', 'The value Product Description, Pack Size, Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:24:32', '2024-12-25 01:24:32'),
(273, 6, 'SMPL5 Order Details Revised!!', 'The value Product Description, Pack Size, Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:24:32', '2024-12-25 01:24:32'),
(274, 3, 'SMPL5 Order Details Revised!!', 'The value Product Description Pack Size Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:25:56', '2024-12-25 01:25:56'),
(275, 6, 'SMPL5 Order Details Revised!!', 'The value Product Description Pack Size Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:25:56', '2024-12-25 01:25:56'),
(276, 3, 'SMPL5 Order Details Revised!!', 'The value Product Description Pack Size Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:27:04', '2024-12-25 01:27:04'),
(277, 6, 'SMPL5 Order Details Revised!!', 'The value Product Description Pack Size Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:27:04', '2024-12-25 01:27:04'),
(278, 3, 'SMPL5 Order Details Revised!!', 'The value Product Description, Pack Size, Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:28:43', '2024-12-25 01:28:43'),
(279, 6, 'SMPL5 Order Details Revised!!', 'The value Product Description, Pack Size, Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:28:43', '2024-12-25 01:28:43'),
(280, 3, 'SMPL5 Order Details Revised!!', 'The value Product Description, Pack Size, Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:29:46', '2024-12-25 01:29:46'),
(281, 6, 'SMPL5 Order Details Revised!!', 'The value Product Description, Pack Size, Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:29:46', '2024-12-25 01:29:46'),
(282, 3, 'SMPL5 Order Details Revised!!', 'The value Product Description, Pack Size Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:30:39', '2024-12-25 01:30:39'),
(283, 6, 'SMPL5 Order Details Revised!!', 'The value Product Description, Pack Size Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:30:39', '2024-12-25 01:30:39'),
(284, 3, 'SMPL5 Order Details Revised!!', 'The value Product Description, Pack Size, Pack Quantity, Total Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:31:04', '2024-12-25 01:31:04'),
(285, 6, 'SMPL5 Order Details Revised!!', 'The value Product Description, Pack Size, Pack Quantity, Total Updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:31:04', '2024-12-25 01:31:04'),
(286, 3, 'SMPL5 Order Details Revised!!', 'The value Price Per Set, Total updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:32:51', '2024-12-25 01:32:51'),
(287, 6, 'SMPL5 Order Details Revised!!', 'The value Price Per Set, Total updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:32:51', '2024-12-25 01:32:51'),
(288, 3, 'SMPL5 Order Details Revised!!', 'The value product description, pack size updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:33:49', '2024-12-25 01:33:49'),
(289, 6, 'SMPL5 Order Details Revised!!', 'The value product description, pack size updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:33:49', '2024-12-25 01:33:49'),
(290, 3, 'SMPL5 Order Details Revised!!', 'The value pack quantity, price per set, total updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-25 01:34:12', '2024-12-25 01:34:12'),
(291, 6, 'SMPL5 Order Details Revised!!', 'The value pack quantity, price per set, total updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-25 01:34:12', '2024-12-25 01:34:12'),
(292, 2, 'SMPL5 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Order products updated successfully', 0, '2024-12-25 02:48:40', '2024-12-25 02:48:40'),
(293, 2, 'SMPL5 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-25 02:53:40', '2024-12-25 02:53:40'),
(294, 2, 'Delivery Date Updated!', 'The expected delivery date for your order has been updated to 2024-12-25.', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-25 03:15:13', '2024-12-25 03:15:13'),
(295, 2, 'SMPL5 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-25 03:15:14', '2024-12-25 03:15:14'),
(296, 2, 'SMPL5 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-25 03:23:37', '2024-12-25 03:23:37'),
(297, 3, 'SMPL5 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 1, '2024-12-25 03:26:13', '2024-12-25 03:26:13'),
(298, 2, 'SMPL5 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-25 03:26:13', '2024-12-25 03:26:13'),
(299, 3, 'SMPL5 Stock Details Revised!', 'Updated fields: Quantity.', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 1, '2024-12-25 05:29:48', '2024-12-25 05:29:48'),
(300, 6, 'SMPL5 Stock Details Revised!', 'Updated fields: Quantity.', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:29:48', '2024-12-25 05:29:48'),
(301, 2, 'SMPL5 Stock Details Revised!', 'Updated fields: Quantity.', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:29:48', '2024-12-25 05:29:48'),
(302, 3, 'SMPL5 Stock Details Revised!', 'The value Expiry Dateupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 1, '2024-12-25 05:31:28', '2024-12-25 05:31:28'),
(303, 6, 'SMPL5 Stock Details Revised!', 'The value Expiry Dateupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:31:28', '2024-12-25 05:31:28'),
(304, 2, 'SMPL5 Stock Details Revised!', 'The value Expiry Dateupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:31:28', '2024-12-25 05:31:28'),
(305, 3, 'SMPL5 Stock Details Revised!', 'The value  updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 1, '2024-12-25 05:32:07', '2024-12-25 05:32:07'),
(306, 6, 'SMPL5 Stock Details Revised!', 'The value  updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:32:07', '2024-12-25 05:32:07'),
(307, 2, 'SMPL5 Stock Details Revised!', 'The value  updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:32:07', '2024-12-25 05:32:07'),
(308, 3, 'SMPL5 Stock Details Revised!', 'The value  updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 1, '2024-12-25 05:36:04', '2024-12-25 05:36:04'),
(309, 6, 'SMPL5 Stock Details Revised!', 'The value  updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:36:04', '2024-12-25 05:36:04'),
(310, 2, 'SMPL5 Stock Details Revised!', 'The value  updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:36:04', '2024-12-25 05:36:04'),
(311, 3, 'SMPL5 Stock Details Revised!', 'The value Expiry Date and Quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 1, '2024-12-25 05:36:49', '2024-12-25 05:36:49'),
(312, 6, 'SMPL5 Stock Details Revised!', 'The value Expiry Date and Quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:36:49', '2024-12-25 05:36:49'),
(313, 2, 'SMPL5 Stock Details Revised!', 'The value Expiry Date and Quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:36:49', '2024-12-25 05:36:49'),
(314, 3, 'SMPL5 Stock Details Revised!', 'The value Manufacturing Date, Expiry Date Quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 1, '2024-12-25 05:37:54', '2024-12-25 05:37:54'),
(315, 6, 'SMPL5 Stock Details Revised!', 'The value Manufacturing Date, Expiry Date Quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:37:54', '2024-12-25 05:37:54'),
(316, 2, 'SMPL5 Stock Details Revised!', 'The value Manufacturing Date, Expiry Date Quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:37:54', '2024-12-25 05:37:54'),
(317, 3, 'SMPL5 Stock Details Revised!', 'The value manufacturing date, expiry date quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 1, '2024-12-25 05:42:43', '2024-12-25 05:42:43'),
(318, 6, 'SMPL5 Stock Details Revised!', 'The value manufacturing date, expiry date quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:42:43', '2024-12-25 05:42:43'),
(319, 2, 'SMPL5 Stock Details Revised!', 'The value manufacturing date, expiry date quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:42:43', '2024-12-25 05:42:43'),
(320, 3, 'SMPL5 Stock Details Revised!', 'The value batch number, manufacturing date, expiry date, quantity stock received updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 1, '2024-12-25 05:43:14', '2024-12-25 05:43:14'),
(321, 6, 'SMPL5 Stock Details Revised!', 'The value batch number, manufacturing date, expiry date, quantity stock received updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:43:14', '2024-12-25 05:43:14'),
(322, 2, 'SMPL5 Stock Details Revised!', 'The value batch number, manufacturing date, expiry date, quantity stock received updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:43:14', '2024-12-25 05:43:14'),
(323, 3, 'SMPL5 Stock Details Revised!', 'The value batch number, manufacturing date, expiry date, quantity stock received updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 1, '2024-12-25 05:43:40', '2024-12-25 05:43:40'),
(324, 6, 'SMPL5 Stock Details Revised!', 'The value batch number, manufacturing date, expiry date, quantity stock received updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:43:40', '2024-12-25 05:43:40'),
(325, 2, 'SMPL5 Stock Details Revised!', 'The value batch number, manufacturing date, expiry date, quantity stock received updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:43:40', '2024-12-25 05:43:40'),
(326, 3, 'SMPL5 Stock Details Revised!', 'The value manufacturing date, expiry date quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 1, '2024-12-25 05:45:48', '2024-12-25 05:45:48'),
(327, 6, 'SMPL5 Stock Details Revised!', 'The value manufacturing date, expiry date quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:45:48', '2024-12-25 05:45:48'),
(328, 2, 'SMPL5 Stock Details Revised!', 'The value manufacturing date, expiry date quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:45:48', '2024-12-25 05:45:48'),
(329, 3, 'SMPL5 Order Details Revised!!', 'The value pack quantity, price per set, total updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 1, '2024-12-25 05:48:18', '2024-12-25 05:48:18'),
(330, 6, 'SMPL5 Order Details Revised!!', 'The value pack quantity, price per set, total updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-25 05:48:18', '2024-12-25 05:48:18'),
(331, 3, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders', 1, '2024-12-25 22:25:53', '2024-12-25 22:25:53'),
(332, 6, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders', 0, '2024-12-25 22:25:53', '2024-12-25 22:25:53'),
(333, 2, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders', 0, '2024-12-25 22:25:53', '2024-12-25 22:25:53'),
(334, 3, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders', 1, '2024-12-25 22:25:54', '2024-12-25 22:25:54'),
(335, 6, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders', 0, '2024-12-25 22:25:54', '2024-12-25 22:25:54'),
(336, 2, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders', 0, '2024-12-25 22:25:54', '2024-12-25 22:25:54'),
(337, 6, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:26:43', '2024-12-25 22:26:43'),
(338, 2, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:26:43', '2024-12-25 22:26:43'),
(339, 6, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:26:44', '2024-12-25 22:26:44'),
(340, 2, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:26:44', '2024-12-25 22:26:44'),
(341, 6, 'SMPL5 Packing List Revised!', 'The value box no, dimension, gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:27:50', '2024-12-25 22:27:50'),
(342, 2, 'SMPL5 Packing List Revised!', 'The value box no, dimension, gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:27:50', '2024-12-25 22:27:50'),
(343, 6, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:27:51', '2024-12-25 22:27:51'),
(344, 2, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:27:51', '2024-12-25 22:27:51'),
(345, 6, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:30:43', '2024-12-25 22:30:43'),
(346, 2, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:30:43', '2024-12-25 22:30:43'),
(347, 6, 'SMPL5 Packing List Revised!', 'The value box no, dimension, gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:30:43', '2024-12-25 22:30:43'),
(348, 2, 'SMPL5 Packing List Revised!', 'The value box no, dimension, gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:30:43', '2024-12-25 22:30:43'),
(349, 6, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:31:10', '2024-12-25 22:31:10'),
(350, 2, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:31:10', '2024-12-25 22:31:10'),
(351, 6, 'SMPL5 Packing List Revised!', 'The value box no, dimension, gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:31:11', '2024-12-25 22:31:11'),
(352, 2, 'SMPL5 Packing List Revised!', 'The value box no, dimension, gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:31:11', '2024-12-25 22:31:11'),
(353, 6, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:39:01', '2024-12-25 22:39:01'),
(354, 2, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:39:01', '2024-12-25 22:39:01'),
(355, 6, 'SMPL5 Packing List Revised!!', 'The value order package id, product name and quantityupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:39:02', '2024-12-25 22:39:02'),
(356, 2, 'SMPL5 Packing List Revised!!', 'The value order package id, product name and quantityupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:39:02', '2024-12-25 22:39:02'),
(357, 6, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:39:02', '2024-12-25 22:39:02'),
(358, 2, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:39:02', '2024-12-25 22:39:02'),
(359, 6, 'SMPL5 Packing List Revised!!', 'The value order package idupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:39:03', '2024-12-25 22:39:03'),
(360, 2, 'SMPL5 Packing List Revised!!', 'The value order package idupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:39:03', '2024-12-25 22:39:03'),
(361, 6, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:39:25', '2024-12-25 22:39:25'),
(362, 2, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:39:25', '2024-12-25 22:39:25'),
(363, 6, 'SMPL5 Packing List Revised!!', 'The value order package id, product name and quantityupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:39:26', '2024-12-25 22:39:26'),
(364, 2, 'SMPL5 Packing List Revised!!', 'The value order package id, product name and quantityupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:39:26', '2024-12-25 22:39:26'),
(365, 6, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:39:27', '2024-12-25 22:39:27'),
(366, 2, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:39:27', '2024-12-25 22:39:27'),
(367, 6, 'SMPL5 Packing List Revised!!', 'The value order package idupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:39:27', '2024-12-25 22:39:27'),
(368, 2, 'SMPL5 Packing List Revised!!', 'The value order package idupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:39:27', '2024-12-25 22:39:27'),
(369, 6, 'SMPL5 Packing List Revised!!', 'The value order package idupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:55:13', '2024-12-25 22:55:13'),
(370, 2, 'SMPL5 Packing List Revised!!', 'The value order package idupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:55:13', '2024-12-25 22:55:13'),
(371, 6, 'SMPL5 Packing List Revised!!', 'The value order package idupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:55:14', '2024-12-25 22:55:14'),
(372, 2, 'SMPL5 Packing List Revised!!', 'The value order package idupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:55:14', '2024-12-25 22:55:14'),
(373, 6, 'SMPL5 Packing List Revised!!', 'The value order package idupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:57:34', '2024-12-25 22:57:34'),
(374, 2, 'SMPL5 Packing List Revised!!', 'The value order package idupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:57:34', '2024-12-25 22:57:34'),
(375, 6, 'SMPL5 Packing List Revised!!', 'The value order package idupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:57:35', '2024-12-25 22:57:35'),
(376, 2, 'SMPL5 Packing List Revised!!', 'The value order package idupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 22:57:35', '2024-12-25 22:57:35'),
(377, 6, 'SMPL5 Packing List Revised!!', 'The value quantityupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 23:00:48', '2024-12-25 23:00:48'),
(378, 2, 'SMPL5 Packing List Revised!!', 'The value quantityupdated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 23:00:48', '2024-12-25 23:00:48'),
(379, 6, 'SMPL5 Packing List Revised!!', 'The value product name and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 23:01:24', '2024-12-25 23:01:24'),
(380, 2, 'SMPL5 Packing List Revised!!', 'The value product name and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 23:01:24', '2024-12-25 23:01:24'),
(381, 6, 'SMPL5 Packing List Revised!', 'The value product name quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 23:03:25', '2024-12-25 23:03:25'),
(382, 2, 'SMPL5 Packing List Revised!', 'The value product name quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 23:03:25', '2024-12-25 23:03:25'),
(383, 6, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 23:04:17', '2024-12-25 23:04:17'),
(384, 2, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 23:04:17', '2024-12-25 23:04:17'),
(385, 6, 'SMPL5 Packing List Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 23:04:18', '2024-12-25 23:04:18'),
(386, 2, 'SMPL5 Packing List Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 23:04:18', '2024-12-25 23:04:18'),
(387, 6, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 23:05:28', '2024-12-25 23:05:28'),
(388, 2, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 23:05:28', '2024-12-25 23:05:28'),
(389, 6, 'SMPL5 Packing List Revised!!', 'The value product name and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 23:05:29', '2024-12-25 23:05:29'),
(390, 2, 'SMPL5 Packing List Revised!!', 'The value product name and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 23:05:29', '2024-12-25 23:05:29'),
(391, 6, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 23:05:55', '2024-12-25 23:05:55'),
(392, 2, 'SMPL5 Packing List Revised!', 'The value gross weight net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 23:05:55', '2024-12-25 23:05:55'),
(393, 6, 'SMPL5 Packing List Revised!', 'The value dimension, gross weight and net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 23:07:04', '2024-12-25 23:07:04'),
(394, 2, 'SMPL5 Packing List Revised!', 'The value dimension, gross weight and net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 23:07:04', '2024-12-25 23:07:04'),
(395, 6, 'SMPL5 Packing List Revised!', 'The value dimension and gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 23:07:41', '2024-12-25 23:07:41'),
(396, 2, 'SMPL5 Packing List Revised!', 'The value dimension and gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-25 23:07:41', '2024-12-25 23:07:41'),
(397, 2, 'SMPL5 Revised Date Added!!', 'The value is order placed, note and expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Order product package updated successfully', 0, '2024-12-26 01:19:48', '2024-12-26 01:19:48'),
(398, 2, 'SMPL5 Revised Date Added!!', 'The value is order placed, note and expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Order product package updated successfully', 0, '2024-12-26 01:19:48', '2024-12-26 01:19:48'),
(399, 2, 'SMPL5 Revised Date Added!!', 'The value is order placed, note and expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Order product package updated successfully', 0, '2024-12-26 01:20:11', '2024-12-26 01:20:11'),
(400, 2, 'SMPL5 Revised Date Added!!', 'The value is order placed, note and expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Order product package updated successfully', 0, '2024-12-26 01:20:12', '2024-12-26 01:20:12'),
(401, 2, 'SMPL5 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Order product package updated successfully', 0, '2024-12-26 01:20:12', '2024-12-26 01:20:12'),
(402, 2, 'SMPL5 Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-26 01:27:41', '2024-12-26 01:27:41'),
(403, 2, 'SMPL5 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-26 01:27:42', '2024-12-26 01:27:42'),
(404, 2, 'SMPL5 Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-26 01:32:18', '2024-12-26 01:32:18'),
(405, 2, 'SMPL6 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-26 01:32:48', '2024-12-26 01:32:48'),
(406, 2, 'SMPL6 Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-26 01:33:00', '2024-12-26 01:33:00'),
(407, 2, 'SMPL6 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-26 01:33:43', '2024-12-26 01:33:43'),
(408, 2, 'SMPL5 Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-26 01:37:54', '2024-12-26 01:37:54'),
(409, 2, 'SMPL5 HOPESWAN Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully', 0, '2024-12-26 02:26:16', '2024-12-26 02:26:16'),
(410, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 1, '2024-12-26 05:11:56', '2024-12-26 05:11:56'),
(411, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-26 05:11:56', '2024-12-26 05:11:56'),
(412, 3, 'SMPL5 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 1, '2024-12-26 06:35:31', '2024-12-26 06:35:31'),
(413, 6, 'SMPL5 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-26 06:35:31', '2024-12-26 06:35:31'),
(414, 2, 'SMPL5 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully', 0, '2024-12-26 06:35:31', '2024-12-26 06:35:31'),
(415, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 1, '2024-12-26 23:52:32', '2024-12-26 23:52:32'),
(416, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders', 0, '2024-12-26 23:52:32', '2024-12-26 23:52:32'),
(417, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-26 23:54:55', '2024-12-26 23:54:55'),
(418, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-26 23:54:55', '2024-12-26 23:54:55'),
(419, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-26 23:56:37', '2024-12-26 23:56:37'),
(420, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-26 23:56:37', '2024-12-26 23:56:37'),
(421, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-27 00:06:16', '2024-12-27 00:06:16'),
(422, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-27 00:06:16', '2024-12-27 00:06:16'),
(423, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-27 00:11:43', '2024-12-27 00:11:43'),
(424, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-27 00:11:43', '2024-12-27 00:11:43'),
(425, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-27 00:18:24', '2024-12-27 00:18:24'),
(426, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-27 00:18:24', '2024-12-27 00:18:24'),
(427, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-27 00:27:05', '2024-12-27 00:27:05'),
(428, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-27 00:27:05', '2024-12-27 00:27:05'),
(429, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-27 00:34:05', '2024-12-27 00:34:05'),
(430, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-27 00:34:05', '2024-12-27 00:34:05'),
(431, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-27 00:38:46', '2024-12-27 00:38:46'),
(432, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-27 00:38:46', '2024-12-27 00:38:46'),
(433, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-27 00:45:19', '2024-12-27 00:45:19'),
(434, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-27 00:45:19', '2024-12-27 00:45:19'),
(435, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-27 01:14:07', '2024-12-27 01:14:07'),
(436, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-27 01:14:07', '2024-12-27 01:14:07'),
(437, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-27 01:15:09', '2024-12-27 01:15:09'),
(438, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-27 01:15:09', '2024-12-27 01:15:09'),
(439, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-27 01:19:32', '2024-12-27 01:19:32'),
(440, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-27 01:19:32', '2024-12-27 01:19:32'),
(441, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-27 03:00:44', '2024-12-27 03:00:44'),
(442, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-27 03:00:44', '2024-12-27 03:00:44'),
(443, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 1, '2024-12-27 03:28:53', '2024-12-27 03:28:53'),
(444, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-27 03:28:53', '2024-12-27 03:28:53'),
(445, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1/orders?success=Order+products+updated+successfully&product_id=54', 1, '2024-12-27 03:56:16', '2024-12-27 03:56:16'),
(446, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1/orders?success=Order+products+updated+successfully&product_id=54', 0, '2024-12-27 03:56:16', '2024-12-27 03:56:16'),
(447, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#product-55', 1, '2024-12-27 03:58:27', '2024-12-27 04:59:10'),
(448, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#product-55', 0, '2024-12-27 03:58:27', '2024-12-27 03:58:27'),
(449, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#product-56', 1, '2024-12-27 05:05:52', '2024-12-27 05:33:16'),
(450, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#product-56', 0, '2024-12-27 05:05:52', '2024-12-27 05:05:52'),
(451, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#product-57', 1, '2024-12-27 05:05:52', '2024-12-27 05:05:52'),
(452, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#product-57', 0, '2024-12-27 05:05:52', '2024-12-27 05:05:52'),
(453, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=58', 1, '2024-12-27 05:10:25', '2024-12-27 05:33:05'),
(454, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=58', 0, '2024-12-27 05:10:25', '2024-12-27 05:10:25'),
(455, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=59,60', 1, '2024-12-27 05:13:53', '2024-12-27 05:32:57'),
(456, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=59,60', 0, '2024-12-27 05:13:53', '2024-12-27 05:13:53'),
(457, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=61', 1, '2024-12-27 05:33:58', '2024-12-27 05:33:58'),
(458, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=61', 0, '2024-12-27 05:33:58', '2024-12-27 05:33:58'),
(459, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2024-12#products=62,63', 1, '2024-12-27 05:41:25', '2024-12-27 05:41:25'),
(460, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2024-12#products=62,63', 0, '2024-12-27 05:41:25', '2024-12-27 05:41:25'),
(461, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2024-12&success=Order%20products%20created%20successfully#products=64%2C65', 1, '2024-12-27 05:59:05', '2024-12-27 05:59:05'),
(462, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2024-12&success=Order%20products%20created%20successfully#products=64%2C65', 0, '2024-12-27 05:59:05', '2024-12-27 05:59:05'),
(463, 3, 'SMPL9 Order Details Revised!!', 'The value price per set, total updated at!', 'http://127.0.0.1:8000/orders?month=2024-12&success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2264%22%2C%22fields%22%3A%5B%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2024-12-27 06:16:16', '2024-12-27 06:16:16');
INSERT INTO `notifications` (`id`, `user_id`, `heading`, `content`, `url`, `is_read`, `created_at`, `updated_at`) VALUES
(464, 6, 'SMPL9 Order Details Revised!!', 'The value price per set, total updated at!', 'http://127.0.0.1:8000/orders?month=2024-12&success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2264%22%2C%22fields%22%3A%5B%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2024-12-27 06:16:16', '2024-12-27 06:16:16'),
(465, 3, 'SMPL9 Order Details Revised!!', 'The value price per set, total updated at!', 'http://127.0.0.1:8000/orders?month=2024-12&success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2024-12-27 06:28:39', '2024-12-27 06:28:39'),
(466, 6, 'SMPL9 Order Details Revised!!', 'The value price per set, total updated at!', 'http://127.0.0.1:8000/orders?month=2024-12&success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2024-12-27 06:28:39', '2024-12-27 06:28:39'),
(467, 3, 'SMPL9 Order Details Revised!!', 'The value product description, pack size updated at!', 'http://127.0.0.1:8000/orders?month=2024-12&success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22product_id%22%2C%22product_variant_id%22%2C%22updated_at%22%5D%7D%5D', 1, '2024-12-27 06:36:09', '2024-12-29 22:34:19'),
(468, 6, 'SMPL9 Order Details Revised!!', 'The value product description, pack size updated at!', 'http://127.0.0.1:8000/orders?month=2024-12&success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22product_id%22%2C%22product_variant_id%22%2C%22updated_at%22%5D%7D%5D', 0, '2024-12-27 06:36:09', '2024-12-27 06:36:09'),
(469, 3, 'SMPL9 Order Details Revised!!', 'The value pack quantity, price per set, total updated at!', 'http://127.0.0.1:8000/orders?month=2024-12&success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22product_id%22%2C%22product_variant_id%22%2C%22updated_at%22%5D%7D%2C%7B%22id%22%3A%2264%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2024-12-27 06:36:10', '2024-12-29 22:17:12'),
(470, 6, 'SMPL9 Order Details Revised!!', 'The value pack quantity, price per set, total updated at!', 'http://127.0.0.1:8000/orders?month=2024-12&success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22product_id%22%2C%22product_variant_id%22%2C%22updated_at%22%5D%7D%2C%7B%22id%22%3A%2264%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2024-12-27 06:36:10', '2024-12-27 06:36:10'),
(471, 3, 'SMPL9 Shipping Cost Updated Updated!!', 'The shipping cost  have been updated!', 'http://127.0.0.1:8000/orders#changes=%7B%22shipping%22%3A%7B%22old%22%3A%225.00%22%2C%22new%22%3Anull%7D%2C%22order_id%22%3A%2214%22%7D', 1, '2024-12-29 23:15:08', '2024-12-29 23:15:08'),
(472, 6, 'SMPL9 Shipping Cost Updated Updated!!', 'The shipping cost  have been updated!', 'http://127.0.0.1:8000/orders#changes=%7B%22shipping%22%3A%7B%22old%22%3A%225.00%22%2C%22new%22%3Anull%7D%2C%22order_id%22%3A%2214%22%7D', 0, '2024-12-29 23:15:08', '2024-12-29 23:15:08'),
(473, 3, 'SMPL9 Shipping Cost Added, Soft Box Price Added Added!!', 'The shipping cost , soft box price  have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#changes=%7B%22shipping%22%3A%7B%22old%22%3Anull%2C%22new%22%3A%2245%22%7D%2C%22soft_boxes%22%3A%7B%22old%22%3Anull%2C%22new%22%3A%2245%22%7D%2C%22order_id%22%3A%2214%22%7D', 1, '2024-12-29 23:15:18', '2024-12-29 23:15:18'),
(474, 6, 'SMPL9 Shipping Cost Added, Soft Box Price Added Added!!', 'The shipping cost , soft box price  have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#changes=%7B%22shipping%22%3A%7B%22old%22%3Anull%2C%22new%22%3A%2245%22%7D%2C%22soft_boxes%22%3A%7B%22old%22%3Anull%2C%22new%22%3A%2245%22%7D%2C%22order_id%22%3A%2214%22%7D', 0, '2024-12-29 23:15:18', '2024-12-29 23:15:18'),
(475, 3, 'SMPL9 Shipping Cost Updated, Soft Box Price Updated Updated!!', 'The shipping cost , soft box price  have been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#changes=%7B%22shipping%22%3A%7B%22old%22%3A%2245.00%22%2C%22new%22%3Anull%7D%2C%22soft_boxes%22%3A%7B%22old%22%3A%2245.00%22%2C%22new%22%3Anull%7D%2C%22order_id%22%3A%2214%22%7D', 1, '2024-12-29 23:15:30', '2024-12-29 23:15:30'),
(476, 6, 'SMPL9 Shipping Cost Updated, Soft Box Price Updated Updated!!', 'The shipping cost , soft box price  have been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#changes=%7B%22shipping%22%3A%7B%22old%22%3A%2245.00%22%2C%22new%22%3Anull%7D%2C%22soft_boxes%22%3A%7B%22old%22%3A%2245.00%22%2C%22new%22%3Anull%7D%2C%22order_id%22%3A%2214%22%7D', 0, '2024-12-29 23:15:30', '2024-12-29 23:15:30'),
(477, 3, 'SMPL9 Shipping Cost Added Added!!', 'The shipping cost  have been added!', 'http://127.0.0.1:8000/orders#changes=%7B%22shipping%22%3A%7B%22old%22%3Anull%2C%22new%22%3A%2255%22%7D%2C%22order_id%22%3A%2214%22%7D', 1, '2024-12-29 23:16:42', '2024-12-29 23:16:42'),
(478, 6, 'SMPL9 Shipping Cost Added Added!!', 'The shipping cost  have been added!', 'http://127.0.0.1:8000/orders#changes=%7B%22shipping%22%3A%7B%22old%22%3Anull%2C%22new%22%3A%2255%22%7D%2C%22order_id%22%3A%2214%22%7D', 0, '2024-12-29 23:16:42', '2024-12-29 23:16:42'),
(479, 3, 'SMPL9 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#order=14', 0, '2024-12-29 23:29:17', '2024-12-29 23:29:17'),
(480, 6, 'SMPL9 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#order=14', 0, '2024-12-29 23:29:17', '2024-12-29 23:29:17'),
(481, 3, 'SMPL9 Shipping Cost, Soft Box Price Added!!', 'The shipping cost, soft box price have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#order=14', 0, '2024-12-29 23:30:08', '2024-12-29 23:30:08'),
(482, 6, 'SMPL9 Shipping Cost, Soft Box Price Added!!', 'The shipping cost, soft box price have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#order=14', 0, '2024-12-29 23:30:08', '2024-12-29 23:30:08'),
(483, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-29 23:37:31', '2024-12-29 23:37:31'),
(484, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-29 23:37:31', '2024-12-29 23:37:31'),
(485, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=67', 0, '2024-12-29 23:38:44', '2024-12-29 23:38:44'),
(486, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=67', 0, '2024-12-29 23:38:44', '2024-12-29 23:38:44'),
(487, 3, 'SMPL9 Soft Box Price Added!!', 'The soft box price have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-29 23:51:49', '2024-12-29 23:51:49'),
(488, 6, 'SMPL9 Soft Box Price Added!!', 'The soft box price have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-29 23:51:49', '2024-12-29 23:51:49'),
(489, 3, 'SMPL9 Data Logger Price Added!!', 'The data logger price have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#order=14', 1, '2024-12-29 23:57:15', '2024-12-30 00:21:48'),
(490, 6, 'SMPL9 Data Logger Price Added!!', 'The data logger price have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#order=14', 0, '2024-12-29 23:57:15', '2024-12-29 23:57:15'),
(491, 3, 'SMPL9 Clearance Cost Added!!', 'The clearance cost have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#order=14&fields=Clearance+Cost', 0, '2024-12-30 00:27:25', '2024-12-30 00:27:25'),
(492, 6, 'SMPL9 Clearance Cost Added!!', 'The clearance cost have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#order=14&fields=Clearance+Cost', 0, '2024-12-30 00:27:25', '2024-12-30 00:27:25'),
(493, 3, 'SMPL9 Shipping Cost, Soft Box Price, Data Logger Price, Clearance Cost Added!!', 'The shipping cost, soft box price, data logger price, clearance cost have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#order=14&fields=Shipping+Cost%2CSoft+Box+Price%2CData+Logger+Price%2CClearance+Cost', 0, '2024-12-30 00:32:32', '2024-12-30 00:32:32'),
(494, 6, 'SMPL9 Shipping Cost, Soft Box Price, Data Logger Price, Clearance Cost Added!!', 'The shipping cost, soft box price, data logger price, clearance cost have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#order=14&fields=Shipping+Cost%2CSoft+Box+Price%2CData+Logger+Price%2CClearance+Cost', 0, '2024-12-30 00:32:32', '2024-12-30 00:32:32'),
(495, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=68', 0, '2024-12-30 00:48:00', '2024-12-30 00:48:00'),
(496, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=68', 0, '2024-12-30 00:48:00', '2024-12-30 00:48:00'),
(497, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=69%2C70', 0, '2024-12-30 00:48:54', '2024-12-30 00:48:54'),
(498, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=69%2C70', 0, '2024-12-30 00:48:54', '2024-12-30 00:48:54'),
(499, 3, 'SMPL9 Order Details Revised!!', 'The value product description, pack size, pack quantity, total updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2269%22%2C%22fields%22%3A%5B%22product_id%22%2C%22product_variant_id%22%2C%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2024-12-30 00:49:41', '2024-12-30 00:49:41'),
(500, 6, 'SMPL9 Order Details Revised!!', 'The value product description, pack size, pack quantity, total updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2269%22%2C%22fields%22%3A%5B%22product_id%22%2C%22product_variant_id%22%2C%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2024-12-30 00:49:41', '2024-12-30 00:49:41'),
(501, 3, 'SMPL9 Order Details Revised!!', 'The value pack quantity, price per set, total updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2269%22%2C%22fields%22%3A%5B%22product_id%22%2C%22product_variant_id%22%2C%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%2C%7B%22id%22%3A%2270%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2024-12-30 00:49:42', '2024-12-30 02:35:39'),
(502, 6, 'SMPL9 Order Details Revised!!', 'The value pack quantity, price per set, total updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2269%22%2C%22fields%22%3A%5B%22product_id%22%2C%22product_variant_id%22%2C%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%2C%7B%22id%22%3A%2270%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2024-12-30 00:49:42', '2024-12-30 00:49:42'),
(503, 3, 'SMPL9 Shipping Cost, Clearance Cost Added!!', 'The shipping cost, clearance cost have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#order=14&fields=Shipping+Cost%2CClearance+Cost', 0, '2024-12-30 00:51:45', '2024-12-30 00:51:45'),
(504, 6, 'SMPL9 Shipping Cost, Clearance Cost Added!!', 'The shipping cost, clearance cost have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#order=14&fields=Shipping+Cost%2CClearance+Cost', 0, '2024-12-30 00:51:45', '2024-12-30 00:51:45'),
(505, 1, 'SMPL8 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#productsperchase=25', 0, '2024-12-30 01:08:27', '2024-12-30 01:08:27'),
(506, 2, 'SMPL8 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#productsperchase=25', 0, '2024-12-30 01:08:27', '2024-12-30 01:08:27'),
(507, 5, 'SMPL8 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#productsperchase=25', 0, '2024-12-30 01:08:27', '2024-12-30 01:08:27'),
(508, 3, 'SMPL8 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#productsperchase=25', 0, '2024-12-30 01:08:27', '2024-12-30 01:08:27'),
(509, 1, 'SMPL8 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#purchase=25', 0, '2024-12-30 01:19:49', '2024-12-30 01:19:49'),
(510, 2, 'SMPL8 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#purchase=25', 0, '2024-12-30 01:19:49', '2024-12-30 01:19:49'),
(511, 5, 'SMPL8 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#purchase=25', 0, '2024-12-30 01:19:49', '2024-12-30 01:19:49'),
(512, 3, 'SMPL8 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#purchase=25', 0, '2024-12-30 01:19:49', '2024-12-30 01:19:49'),
(513, 1, 'SMPL8 CEFIXIME IP 200MG + OFLOXACIN IP 200MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully&updatedPurchases=%5B%7B%22id%22%3A25%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 0, '2024-12-30 01:32:49', '2024-12-30 01:32:49'),
(514, 2, 'SMPL8 CEFIXIME IP 200MG + OFLOXACIN IP 200MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully&updatedPurchases=%5B%7B%22id%22%3A25%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 0, '2024-12-30 01:32:49', '2024-12-30 01:32:49'),
(515, 5, 'SMPL8 CEFIXIME IP 200MG + OFLOXACIN IP 200MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully&updatedPurchases=%5B%7B%22id%22%3A25%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 0, '2024-12-30 01:32:49', '2024-12-30 01:32:49'),
(516, 3, 'SMPL8 CEFIXIME IP 200MG + OFLOXACIN IP 200MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully&updatedPurchases=%5B%7B%22id%22%3A25%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 0, '2024-12-30 01:32:49', '2024-12-30 01:32:49'),
(517, 1, 'SMPL8 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders#purchase=25%2C61', 0, '2024-12-30 02:38:57', '2024-12-30 02:38:57'),
(518, 2, 'SMPL8 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders#purchase=25%2C61', 0, '2024-12-30 02:38:57', '2024-12-30 02:38:57'),
(519, 5, 'SMPL8 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders#purchase=25%2C61', 0, '2024-12-30 02:38:57', '2024-12-30 02:38:57'),
(520, 3, 'SMPL8 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders#purchase=25%2C61', 0, '2024-12-30 02:38:57', '2024-12-30 02:38:57'),
(521, 1, 'SMPL8 CEFIXIME IP 200MG + OFLOXACIN IP 200MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#updatedPurchases=%5B%7B%22id%22%3A25%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 0, '2024-12-30 02:39:41', '2024-12-30 02:39:41'),
(522, 2, 'SMPL8 CEFIXIME IP 200MG + OFLOXACIN IP 200MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#updatedPurchases=%5B%7B%22id%22%3A25%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 0, '2024-12-30 02:39:41', '2024-12-30 02:39:41'),
(523, 5, 'SMPL8 CEFIXIME IP 200MG + OFLOXACIN IP 200MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#updatedPurchases=%5B%7B%22id%22%3A25%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 0, '2024-12-30 02:39:41', '2024-12-30 02:39:41'),
(524, 3, 'SMPL8 CEFIXIME IP 200MG + OFLOXACIN IP 200MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#updatedPurchases=%5B%7B%22id%22%3A25%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 0, '2024-12-30 02:39:41', '2024-12-30 02:39:41'),
(525, 1, 'SMPL8 CEFIXIME IP 100 MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#updatedPurchases=%5B%7B%22id%22%3A25%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%2C%7B%22id%22%3A61%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 0, '2024-12-30 02:39:41', '2024-12-30 02:39:41'),
(526, 2, 'SMPL8 CEFIXIME IP 100 MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#updatedPurchases=%5B%7B%22id%22%3A25%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%2C%7B%22id%22%3A61%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 0, '2024-12-30 02:39:41', '2024-12-30 02:39:41'),
(527, 5, 'SMPL8 CEFIXIME IP 100 MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#updatedPurchases=%5B%7B%22id%22%3A25%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%2C%7B%22id%22%3A61%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 0, '2024-12-30 02:39:41', '2024-12-30 02:39:41'),
(528, 3, 'SMPL8 CEFIXIME IP 100 MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#updatedPurchases=%5B%7B%22id%22%3A25%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%2C%7B%22id%22%3A61%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 0, '2024-12-30 02:39:41', '2024-12-30 02:39:41'),
(529, 3, 'SMPL6 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders#productStocks=51', 0, '2024-12-30 03:18:22', '2024-12-30 03:18:22'),
(530, 6, 'SMPL6 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders#productStocks=51', 0, '2024-12-30 03:18:22', '2024-12-30 03:18:22'),
(531, 2, 'SMPL6 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders#productStocks=51', 0, '2024-12-30 03:18:22', '2024-12-30 03:18:22'),
(532, 3, 'SMPL6 Stock Details Revised!', 'The value expiry date and quantity updated at!', 'http://127.0.0.1:8000/orders#updatedStocks=%5B%7B%22id%22%3A51%2C%22fields%22%3A%5B%22exp_date%22%2C%22quantity%22%5D%7D%5D', 0, '2024-12-30 03:43:25', '2024-12-30 03:43:25'),
(533, 6, 'SMPL6 Stock Details Revised!', 'The value expiry date and quantity updated at!', 'http://127.0.0.1:8000/orders#updatedStocks=%5B%7B%22id%22%3A51%2C%22fields%22%3A%5B%22exp_date%22%2C%22quantity%22%5D%7D%5D', 0, '2024-12-30 03:43:25', '2024-12-30 03:43:25'),
(534, 2, 'SMPL6 Stock Details Revised!', 'The value expiry date and quantity updated at!', 'http://127.0.0.1:8000/orders#updatedStocks=%5B%7B%22id%22%3A51%2C%22fields%22%3A%5B%22exp_date%22%2C%22quantity%22%5D%7D%5D', 0, '2024-12-30 03:43:25', '2024-12-30 03:43:25'),
(535, 3, 'SMPL6 Stock Details Revised!', 'The value batch number, manufacturing date, expiry date, quantity and stock received updated at!', 'http://127.0.0.1:8000/orders#updatedStocks=%5B%7B%22id%22%3A51%2C%22fields%22%3A%5B%22batch_no%22%2C%22mfg_date%22%2C%22exp_date%22%2C%22quantity%22%2C%22is_stock_received%22%5D%7D%5D', 0, '2024-12-30 03:50:14', '2024-12-30 03:50:14'),
(536, 6, 'SMPL6 Stock Details Revised!', 'The value batch number, manufacturing date, expiry date, quantity and stock received updated at!', 'http://127.0.0.1:8000/orders#updatedStocks=%5B%7B%22id%22%3A51%2C%22fields%22%3A%5B%22batch_no%22%2C%22mfg_date%22%2C%22exp_date%22%2C%22quantity%22%2C%22is_stock_received%22%5D%7D%5D', 0, '2024-12-30 03:50:14', '2024-12-30 03:50:14'),
(537, 2, 'SMPL6 Stock Details Revised!', 'The value batch number, manufacturing date, expiry date, quantity and stock received updated at!', 'http://127.0.0.1:8000/orders#updatedStocks=%5B%7B%22id%22%3A51%2C%22fields%22%3A%5B%22batch_no%22%2C%22mfg_date%22%2C%22exp_date%22%2C%22quantity%22%2C%22is_stock_received%22%5D%7D%5D', 0, '2024-12-30 03:50:14', '2024-12-30 03:50:14'),
(538, 3, 'SMPL6 Stock Details Revised!', 'The value batch number, manufacturing date, expiry date, quantity and stock received updated at!', 'http://127.0.0.1:8000/orders#updatedStocks=%5B%7B%22id%22%3A51%2C%22fields%22%3A%5B%22batch_no%22%2C%22mfg_date%22%2C%22exp_date%22%2C%22quantity%22%2C%22is_stock_received%22%5D%7D%5D', 0, '2024-12-30 03:50:56', '2024-12-30 03:50:56'),
(539, 6, 'SMPL6 Stock Details Revised!', 'The value batch number, manufacturing date, expiry date, quantity and stock received updated at!', 'http://127.0.0.1:8000/orders#updatedStocks=%5B%7B%22id%22%3A51%2C%22fields%22%3A%5B%22batch_no%22%2C%22mfg_date%22%2C%22exp_date%22%2C%22quantity%22%2C%22is_stock_received%22%5D%7D%5D', 0, '2024-12-30 03:50:56', '2024-12-30 03:50:56'),
(540, 2, 'SMPL6 Stock Details Revised!', 'The value batch number, manufacturing date, expiry date, quantity and stock received updated at!', 'http://127.0.0.1:8000/orders#updatedStocks=%5B%7B%22id%22%3A51%2C%22fields%22%3A%5B%22batch_no%22%2C%22mfg_date%22%2C%22exp_date%22%2C%22quantity%22%2C%22is_stock_received%22%5D%7D%5D', 0, '2024-12-30 03:50:56', '2024-12-30 03:50:56'),
(541, 3, 'SMPL9 Order Details Revised!!', 'The value price per set, total updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2264%22%2C%22fields%22%3A%5B%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2024-12-30 03:52:25', '2024-12-30 03:52:25'),
(542, 6, 'SMPL9 Order Details Revised!!', 'The value price per set, total updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2264%22%2C%22fields%22%3A%5B%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2024-12-30 03:52:25', '2024-12-30 03:52:25'),
(543, 3, 'SMPL6 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-30 04:10:46', '2024-12-30 04:10:46'),
(544, 6, 'SMPL6 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-30 04:10:46', '2024-12-30 04:10:46'),
(545, 3, 'SMPL6 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-30 04:15:45', '2024-12-30 04:15:45'),
(546, 6, 'SMPL6 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-30 04:15:45', '2024-12-30 04:15:45'),
(547, 3, 'SMPL6 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-30 04:16:51', '2024-12-30 04:16:51'),
(548, 6, 'SMPL6 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully', 0, '2024-12-30 04:16:51', '2024-12-30 04:16:51'),
(549, 3, 'SMPL6 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#package=9', 0, '2024-12-30 04:32:47', '2024-12-30 04:32:47'),
(550, 6, 'SMPL6 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#package=9', 0, '2024-12-30 04:32:47', '2024-12-30 04:32:47'),
(551, 2, 'SMPL6 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#package=9', 0, '2024-12-30 04:32:47', '2024-12-30 04:32:47'),
(552, 3, 'SMPL6 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=11#packageProduct=45', 1, '2024-12-30 04:42:54', '2024-12-30 04:50:45'),
(553, 6, 'SMPL6 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=11#packageProduct=45', 0, '2024-12-30 04:42:54', '2024-12-30 04:42:54'),
(554, 2, 'SMPL6 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=11#packageProduct=45', 0, '2024-12-30 04:42:54', '2024-12-30 04:42:54'),
(555, 3, 'SMPL6 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-30 04:50:34', '2024-12-30 04:50:34'),
(556, 6, 'SMPL6 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-30 04:50:34', '2024-12-30 04:50:34'),
(557, 2, 'SMPL6 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-30 04:50:34', '2024-12-30 04:50:34'),
(558, 3, 'SMPL6 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=12&packageProduct=47%2C48', 0, '2024-12-30 05:05:50', '2024-12-30 05:05:50'),
(559, 6, 'SMPL6 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=12&packageProduct=47%2C48', 0, '2024-12-30 05:05:50', '2024-12-30 05:05:50'),
(560, 2, 'SMPL6 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=12&packageProduct=47%2C48', 0, '2024-12-30 05:05:50', '2024-12-30 05:05:50'),
(561, 3, 'SMPL6 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A12%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D', 1, '2024-12-30 05:26:02', '2024-12-30 05:28:13'),
(562, 6, 'SMPL6 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A12%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D', 0, '2024-12-30 05:26:02', '2024-12-30 05:26:02'),
(563, 2, 'SMPL6 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A12%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D', 0, '2024-12-30 05:26:02', '2024-12-30 05:26:02'),
(564, 3, 'SMPL6 Packing List Revised!!', 'The value product name updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackageProducts=%5B%7B%22id%22%3A47%2C%22fields%22%3A%5B%22order_product_id%22%5D%7D%5D', 1, '2024-12-30 05:26:02', '2024-12-30 05:28:05'),
(565, 6, 'SMPL6 Packing List Revised!!', 'The value product name updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackageProducts=%5B%7B%22id%22%3A47%2C%22fields%22%3A%5B%22order_product_id%22%5D%7D%5D', 0, '2024-12-30 05:26:02', '2024-12-30 05:26:02'),
(566, 2, 'SMPL6 Packing List Revised!!', 'The value product name updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackageProducts=%5B%7B%22id%22%3A47%2C%22fields%22%3A%5B%22order_product_id%22%5D%7D%5D', 0, '2024-12-30 05:26:02', '2024-12-30 05:26:02'),
(567, 3, 'SMPL6 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=49', 0, '2024-12-30 05:33:56', '2024-12-30 05:33:56'),
(568, 6, 'SMPL6 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=49', 0, '2024-12-30 05:33:56', '2024-12-30 05:33:56'),
(569, 2, 'SMPL6 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=49', 0, '2024-12-30 05:33:56', '2024-12-30 05:33:56'),
(570, 3, 'SMPL6 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=49%2C50', 0, '2024-12-30 05:33:56', '2024-12-30 05:33:56'),
(571, 6, 'SMPL6 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=49%2C50', 0, '2024-12-30 05:33:56', '2024-12-30 05:33:56'),
(572, 2, 'SMPL6 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=49%2C50', 0, '2024-12-30 05:33:56', '2024-12-30 05:33:56'),
(573, 3, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#products=71%2C72', 0, '2024-12-30 05:51:03', '2024-12-30 05:51:03'),
(574, 6, 'SMPL8 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#products=71%2C72', 0, '2024-12-30 05:51:03', '2024-12-30 05:51:03'),
(575, 3, 'SMPL8 Order Details Revised!!', 'The value product description, pack size updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2271%22%2C%22fields%22%3A%5B%22product_id%22%2C%22product_variant_id%22%2C%22updated_at%22%5D%7D%5D', 0, '2024-12-30 05:51:44', '2024-12-30 05:51:44'),
(576, 6, 'SMPL8 Order Details Revised!!', 'The value product description, pack size updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2271%22%2C%22fields%22%3A%5B%22product_id%22%2C%22product_variant_id%22%2C%22updated_at%22%5D%7D%5D', 0, '2024-12-30 05:51:44', '2024-12-30 05:51:44'),
(577, 3, 'SMPL8 Order Details Revised!!', 'The value pack quantity, price per set, total updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2271%22%2C%22fields%22%3A%5B%22product_id%22%2C%22product_variant_id%22%2C%22updated_at%22%5D%7D%2C%7B%22id%22%3A%2272%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2024-12-30 05:51:45', '2024-12-30 05:51:45'),
(578, 6, 'SMPL8 Order Details Revised!!', 'The value pack quantity, price per set, total updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2271%22%2C%22fields%22%3A%5B%22product_id%22%2C%22product_variant_id%22%2C%22updated_at%22%5D%7D%2C%7B%22id%22%3A%2272%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2024-12-30 05:51:45', '2024-12-30 05:51:45'),
(579, 3, 'SMPL8 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Order products updated successfully#purchase=25%2C61%2C71%2C72', 0, '2024-12-30 05:52:55', '2024-12-30 05:52:55'),
(580, 3, 'SMPL8 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#purchase=25%2C61%2C71%2C72', 0, '2024-12-30 05:55:43', '2024-12-30 05:55:43'),
(581, 3, 'SMPL8 CEFIXIME IP 100 MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#updatedPurchases=%5B%7B%22id%22%3A61%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 0, '2024-12-30 05:58:10', '2024-12-30 05:58:10'),
(582, 3, 'SMPL8 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#purchase=25%2C61%2C71%2C72', 0, '2024-12-30 06:11:38', '2024-12-30 06:11:38'),
(583, 3, 'SMPL8 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#purchase=25%2C61%2C71%2C72', 0, '2024-12-30 06:15:05', '2024-12-30 06:15:05'),
(584, 3, 'SMPL8 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products%20purchase%20updated%20successfully#productStocks=52%2C53', 0, '2024-12-30 06:16:26', '2024-12-30 06:16:26'),
(585, 6, 'SMPL8 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products%20purchase%20updated%20successfully#productStocks=52%2C53', 0, '2024-12-30 06:16:26', '2024-12-30 06:16:26'),
(586, 3, 'SMPL8 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products%20purchase%20updated%20successfully#productStocks=52%2C53', 0, '2024-12-30 06:16:26', '2024-12-30 06:16:26'),
(587, 3, 'SMPL8 Stock Details Revised!', 'The value expiry date updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22exp_date%22%5D%7D%5D', 0, '2024-12-30 06:17:02', '2024-12-30 06:17:02'),
(588, 6, 'SMPL8 Stock Details Revised!', 'The value expiry date updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22exp_date%22%5D%7D%5D', 0, '2024-12-30 06:17:02', '2024-12-30 06:17:02'),
(589, 3, 'SMPL8 Stock Details Revised!', 'The value expiry date updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22exp_date%22%5D%7D%5D', 0, '2024-12-30 06:17:02', '2024-12-30 06:17:02'),
(590, 3, 'SMPL8 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22exp_date%22%5D%7D%2C%7B%22id%22%3A53%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2024-12-30 06:17:02', '2024-12-30 06:17:02'),
(591, 6, 'SMPL8 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22exp_date%22%5D%7D%2C%7B%22id%22%3A53%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2024-12-30 06:17:02', '2024-12-30 06:17:02'),
(592, 3, 'SMPL8 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22exp_date%22%5D%7D%2C%7B%22id%22%3A53%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2024-12-30 06:17:02', '2024-12-30 06:17:02'),
(593, 3, 'SMPL8 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders#productStocks=54', 0, '2024-12-30 06:28:17', '2024-12-30 06:28:17'),
(594, 6, 'SMPL8 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders#productStocks=54', 0, '2024-12-30 06:28:17', '2024-12-30 06:28:17'),
(595, 3, 'SMPL8 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders#productStocks=54', 0, '2024-12-30 06:28:17', '2024-12-30 06:28:17'),
(596, 3, 'SMPL8 Stock Details Revised!', 'The value manufacturing date and quantity updated at!', 'http://127.0.0.1:8000/orders#updatedStocks=%5B%7B%22id%22%3A54%2C%22fields%22%3A%5B%22mfg_date%22%2C%22quantity%22%5D%7D%5D', 1, '2024-12-30 06:29:11', '2024-12-30 06:37:25'),
(597, 6, 'SMPL8 Stock Details Revised!', 'The value manufacturing date and quantity updated at!', 'http://127.0.0.1:8000/orders#updatedStocks=%5B%7B%22id%22%3A54%2C%22fields%22%3A%5B%22mfg_date%22%2C%22quantity%22%5D%7D%5D', 0, '2024-12-30 06:29:11', '2024-12-30 06:29:11'),
(598, 3, 'SMPL8 Stock Details Revised!', 'The value manufacturing date and quantity updated at!', 'http://127.0.0.1:8000/orders#updatedStocks=%5B%7B%22id%22%3A54%2C%22fields%22%3A%5B%22mfg_date%22%2C%22quantity%22%5D%7D%5D', 0, '2024-12-30 06:29:11', '2024-12-30 06:29:11'),
(599, 3, 'SMPL8 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders#productStocks=55', 1, '2024-12-30 06:29:12', '2024-12-30 06:37:21'),
(600, 6, 'SMPL8 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders#productStocks=55', 0, '2024-12-30 06:29:12', '2024-12-30 06:29:12'),
(601, 3, 'SMPL8 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders#productStocks=55', 0, '2024-12-30 06:29:12', '2024-12-30 06:29:12'),
(602, 3, 'SMPL7 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#package=13&packageProduct=51', 0, '2024-12-31 04:09:43', '2024-12-31 04:09:43'),
(603, 6, 'SMPL7 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#package=13&packageProduct=51', 0, '2024-12-31 04:09:43', '2024-12-31 04:09:43'),
(604, 5, 'SMPL7 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#package=13&packageProduct=51', 0, '2024-12-31 04:09:43', '2024-12-31 04:09:43'),
(605, 3, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders#updatedPackages=%5B%7B%22id%22%3A13%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D', 1, '2024-12-31 04:10:48', '2024-12-31 04:11:15'),
(606, 6, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders#updatedPackages=%5B%7B%22id%22%3A13%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D', 0, '2024-12-31 04:10:48', '2024-12-31 04:10:48'),
(607, 5, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders#updatedPackages=%5B%7B%22id%22%3A13%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D', 0, '2024-12-31 04:10:48', '2024-12-31 04:10:48'),
(608, 3, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders#updatedPackageProducts=%5B%7B%22id%22%3A51%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 04:10:49', '2024-12-31 04:10:49'),
(609, 6, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders#updatedPackageProducts=%5B%7B%22id%22%3A51%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 04:10:49', '2024-12-31 04:10:49'),
(610, 5, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders#updatedPackageProducts=%5B%7B%22id%22%3A51%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 04:10:49', '2024-12-31 04:10:49'),
(611, 3, 'SMPL7 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=14&packageProduct=52', 0, '2024-12-31 04:24:35', '2024-12-31 04:24:35'),
(612, 6, 'SMPL7 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=14&packageProduct=52', 0, '2024-12-31 04:24:35', '2024-12-31 04:24:35'),
(613, 5, 'SMPL7 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=14&packageProduct=52', 0, '2024-12-31 04:24:35', '2024-12-31 04:24:35'),
(614, 3, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%5D', 1, '2024-12-31 04:25:05', '2024-12-31 04:25:50'),
(615, 6, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%5D', 0, '2024-12-31 04:25:05', '2024-12-31 04:25:05'),
(616, 5, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%5D', 0, '2024-12-31 04:25:05', '2024-12-31 04:25:05'),
(617, 3, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 04:25:06', '2024-12-31 04:25:06'),
(618, 6, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 04:25:06', '2024-12-31 04:25:06'),
(619, 5, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 04:25:06', '2024-12-31 04:25:06'),
(620, 3, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%5D', 0, '2024-12-31 04:33:53', '2024-12-31 04:33:53'),
(621, 6, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%5D', 0, '2024-12-31 04:33:53', '2024-12-31 04:33:53'),
(622, 5, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%5D', 0, '2024-12-31 04:33:53', '2024-12-31 04:33:53'),
(623, 3, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 04:33:53', '2024-12-31 04:33:53'),
(624, 6, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 04:33:53', '2024-12-31 04:33:53'),
(625, 5, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 04:33:53', '2024-12-31 04:33:53'),
(626, 3, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%5D', 0, '2024-12-31 04:41:04', '2024-12-31 04:41:04'),
(627, 6, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%5D', 0, '2024-12-31 04:41:04', '2024-12-31 04:41:04'),
(628, 5, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%5D', 0, '2024-12-31 04:41:04', '2024-12-31 04:41:04'),
(629, 3, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 04:41:05', '2024-12-31 04:41:05');
INSERT INTO `notifications` (`id`, `user_id`, `heading`, `content`, `url`, `is_read`, `created_at`, `updated_at`) VALUES
(630, 6, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 04:41:05', '2024-12-31 04:41:05'),
(631, 5, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 04:41:05', '2024-12-31 04:41:05'),
(632, 3, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%5D', 0, '2024-12-31 04:52:03', '2024-12-31 04:52:03'),
(633, 6, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%5D', 0, '2024-12-31 04:52:03', '2024-12-31 04:52:03'),
(634, 5, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%5D', 0, '2024-12-31 04:52:03', '2024-12-31 04:52:03'),
(635, 3, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 04:52:04', '2024-12-31 04:52:04'),
(636, 6, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 04:52:04', '2024-12-31 04:52:04'),
(637, 5, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 04:52:04', '2024-12-31 04:52:04'),
(638, 3, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%5D', 0, '2024-12-31 05:04:10', '2024-12-31 05:04:10'),
(639, 6, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%5D', 0, '2024-12-31 05:04:10', '2024-12-31 05:04:10'),
(640, 5, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%5D', 0, '2024-12-31 05:04:10', '2024-12-31 05:04:10'),
(641, 3, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 05:04:11', '2024-12-31 05:04:11'),
(642, 6, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 05:04:11', '2024-12-31 05:04:11'),
(643, 5, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 05:04:11', '2024-12-31 05:04:11'),
(644, 3, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%5D', 1, '2024-12-31 05:13:28', '2024-12-31 05:13:36'),
(645, 6, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%5D', 0, '2024-12-31 05:13:28', '2024-12-31 05:13:28'),
(646, 5, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%5D', 0, '2024-12-31 05:13:28', '2024-12-31 05:13:28'),
(647, 3, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 05:13:29', '2024-12-31 05:13:29'),
(648, 6, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 05:13:29', '2024-12-31 05:13:29'),
(649, 5, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 05:13:29', '2024-12-31 05:13:29'),
(650, 3, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=null', 0, '2024-12-31 05:26:22', '2024-12-31 05:26:22'),
(651, 6, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=null', 0, '2024-12-31 05:26:22', '2024-12-31 05:26:22'),
(652, 5, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=null', 0, '2024-12-31 05:26:22', '2024-12-31 05:26:22'),
(653, 3, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 05:26:22', '2024-12-31 05:26:22'),
(654, 6, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 05:26:22', '2024-12-31 05:26:22'),
(655, 5, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 05:26:22', '2024-12-31 05:26:22'),
(656, 3, 'SMPL8 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-31 05:29:38', '2024-12-31 05:29:38'),
(657, 6, 'SMPL8 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-31 05:29:38', '2024-12-31 05:29:38'),
(658, 3, 'SMPL8 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-31 05:29:39', '2024-12-31 05:29:39'),
(659, 6, 'SMPL8 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully', 0, '2024-12-31 05:29:39', '2024-12-31 05:29:39'),
(660, 3, 'SMPL8 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#billing=54', 0, '2024-12-31 05:31:07', '2024-12-31 05:31:07'),
(661, 6, 'SMPL8 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#billing=54', 0, '2024-12-31 05:31:07', '2024-12-31 05:31:07'),
(662, 3, 'SMPL8 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#billing=54%2C55', 0, '2024-12-31 05:31:09', '2024-12-31 05:31:09'),
(663, 6, 'SMPL8 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#billing=54%2C55', 0, '2024-12-31 05:31:09', '2024-12-31 05:31:09'),
(664, 2, 'SMLQ20 RURVA Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations', 0, '2024-12-31 05:46:49', '2024-12-31 05:46:49'),
(665, 2, 'SMLQ17 CANDESARTAN CILEXTIL Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 0, '2024-12-31 05:47:58', '2024-12-31 05:47:58'),
(666, 2, 'SMLQ18 CEFIXIME IP 200MG + OFLOXACIN IP 200MG Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=open', 0, '2024-12-31 05:53:07', '2024-12-31 05:53:07'),
(667, 2, 'SMLQ13 ETORICOXIB IP 60 MG + THIOCOLCHICOXIB IP 4 MG Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=open', 0, '2024-12-31 05:53:20', '2024-12-31 05:53:20'),
(668, 3, 'SMPL7 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=null', 0, '2024-12-31 06:40:42', '2024-12-31 06:40:42'),
(669, 6, 'SMPL7 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=null', 0, '2024-12-31 06:40:42', '2024-12-31 06:40:42'),
(670, 5, 'SMPL7 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=null', 0, '2024-12-31 06:40:42', '2024-12-31 06:40:42'),
(671, 3, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=null', 0, '2024-12-31 06:44:52', '2024-12-31 06:44:52'),
(672, 6, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=null', 0, '2024-12-31 06:44:52', '2024-12-31 06:44:52'),
(673, 5, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=null', 0, '2024-12-31 06:44:52', '2024-12-31 06:44:52'),
(674, 3, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 06:44:53', '2024-12-31 06:44:53'),
(675, 6, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 06:44:53', '2024-12-31 06:44:53'),
(676, 5, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 06:44:53', '2024-12-31 06:44:53'),
(677, 3, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders#updatedPackages=%5B%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 07:51:40', '2024-12-31 07:51:40'),
(678, 6, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders#updatedPackages=%5B%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 07:51:40', '2024-12-31 07:51:40'),
(679, 5, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders#updatedPackages=%5B%5D&updatedPackageProducts=%5B%7B%22id%22%3A52%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2024-12-31 07:51:40', '2024-12-31 07:51:40'),
(680, 3, 'SMLQ22 BUSPIRONE TABLET Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=22&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-01 00:58:46', '2025-01-01 00:58:46'),
(681, 3, 'SMPL7 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12#packageProduct=53', 0, '2025-01-01 01:24:24', '2025-01-01 01:24:24'),
(682, 6, 'SMPL7 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12#packageProduct=53', 0, '2025-01-01 01:24:24', '2025-01-01 01:24:24'),
(683, 5, 'SMPL7 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12#packageProduct=53', 0, '2025-01-01 01:24:24', '2025-01-01 01:24:24'),
(684, 3, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12&success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%5D&updatedPackageProducts=%5B%7B%22id%22%3A53%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 01:25:10', '2025-01-01 01:25:10'),
(685, 6, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12&success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%5D&updatedPackageProducts=%5B%7B%22id%22%3A53%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 01:25:10', '2025-01-01 01:25:10'),
(686, 5, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12&success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%5D&updatedPackageProducts=%5B%7B%22id%22%3A53%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 01:25:10', '2025-01-01 01:25:10'),
(687, 3, 'SMPL7 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12&success=Order%20product%20package%20updated%20successfully#package=14&packageProduct=54', 0, '2025-01-01 01:32:10', '2025-01-01 01:32:10'),
(688, 6, 'SMPL7 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12&success=Order%20product%20package%20updated%20successfully#package=14&packageProduct=54', 0, '2025-01-01 01:32:10', '2025-01-01 01:32:10'),
(689, 5, 'SMPL7 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12&success=Order%20product%20package%20updated%20successfully#package=14&packageProduct=54', 0, '2025-01-01 01:32:10', '2025-01-01 01:32:10'),
(690, 3, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12&success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=null', 0, '2025-01-01 01:40:08', '2025-01-01 01:40:08'),
(691, 6, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12&success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=null', 0, '2025-01-01 01:40:08', '2025-01-01 01:40:08'),
(692, 5, 'SMPL7 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12&success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=null', 0, '2025-01-01 01:40:08', '2025-01-01 01:40:08'),
(693, 3, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12&success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A53%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 01:40:08', '2025-01-01 01:40:08'),
(694, 6, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12&success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A53%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 01:40:08', '2025-01-01 01:40:08'),
(695, 5, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12&success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A14%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A53%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 01:40:08', '2025-01-01 01:40:08'),
(696, 3, 'SMPL7 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12&success=Order%20product%20package%20updated%20successfully#package=15&packageProduct=55', 0, '2025-01-01 01:41:05', '2025-01-01 01:41:05'),
(697, 6, 'SMPL7 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12&success=Order%20product%20package%20updated%20successfully#package=15&packageProduct=55', 0, '2025-01-01 01:41:05', '2025-01-01 01:41:05'),
(698, 5, 'SMPL7 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12&success=Order%20product%20package%20updated%20successfully#package=15&packageProduct=55', 0, '2025-01-01 01:41:05', '2025-01-01 01:41:05'),
(699, 3, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12&success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%5D&updatedPackageProducts=%5B%7B%22id%22%3A55%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 1, '2025-01-01 01:41:23', '2025-01-01 03:52:02'),
(700, 6, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12&success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%5D&updatedPackageProducts=%5B%7B%22id%22%3A55%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 01:41:23', '2025-01-01 01:41:23'),
(701, 5, 'SMPL7 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2024-12&success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%5D&updatedPackageProducts=%5B%7B%22id%22%3A55%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 01:41:23', '2025-01-01 01:41:23'),
(702, 2, 'SMPL9 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders#purchase=62%2C64', 0, '2025-01-01 03:50:22', '2025-01-01 03:50:22'),
(703, 3, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products%20purchase%20updated%20successfully#productStocks=56', 0, '2025-01-01 03:50:44', '2025-01-01 03:50:44'),
(704, 6, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products%20purchase%20updated%20successfully#productStocks=56', 0, '2025-01-01 03:50:44', '2025-01-01 03:50:44'),
(705, 2, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products%20purchase%20updated%20successfully#productStocks=56', 0, '2025-01-01 03:50:44', '2025-01-01 03:50:44'),
(706, 3, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=57', 0, '2025-01-01 03:51:01', '2025-01-01 03:51:01'),
(707, 6, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=57', 0, '2025-01-01 03:51:01', '2025-01-01 03:51:01'),
(708, 2, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=57', 0, '2025-01-01 03:51:01', '2025-01-01 03:51:01'),
(709, 3, 'SMPL9 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#billing=56', 0, '2025-01-01 03:51:16', '2025-01-01 03:51:16'),
(710, 6, 'SMPL9 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#billing=56', 0, '2025-01-01 03:51:16', '2025-01-01 03:51:16'),
(711, 3, 'SMPL9 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#billing=57', 0, '2025-01-01 03:51:23', '2025-01-01 03:51:23'),
(712, 6, 'SMPL9 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#billing=57', 0, '2025-01-01 03:51:23', '2025-01-01 03:51:23'),
(713, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#package=16&packageProduct=56', 1, '2025-01-01 03:51:42', '2025-01-01 03:52:17'),
(714, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#package=16&packageProduct=56', 0, '2025-01-01 03:51:42', '2025-01-01 03:51:42'),
(715, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#package=16&packageProduct=56', 0, '2025-01-01 03:51:42', '2025-01-01 03:51:42'),
(716, 3, 'SMPL9 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=null', 0, '2025-01-01 03:53:42', '2025-01-01 03:53:42'),
(717, 6, 'SMPL9 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=null', 0, '2025-01-01 03:53:42', '2025-01-01 03:53:42'),
(718, 2, 'SMPL9 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=null', 0, '2025-01-01 03:53:42', '2025-01-01 03:53:42'),
(719, 3, 'SMPL9 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D', 0, '2025-01-01 04:04:37', '2025-01-01 04:04:37'),
(720, 6, 'SMPL9 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D', 0, '2025-01-01 04:04:37', '2025-01-01 04:04:37'),
(721, 2, 'SMPL9 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D', 0, '2025-01-01 04:04:37', '2025-01-01 04:04:37'),
(722, 3, 'SMPL9 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:06:07', '2025-01-01 04:06:07'),
(723, 6, 'SMPL9 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:06:07', '2025-01-01 04:06:07'),
(724, 2, 'SMPL9 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:06:07', '2025-01-01 04:06:07'),
(725, 3, 'SMPL9 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:17:08', '2025-01-01 04:17:08'),
(726, 6, 'SMPL9 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:17:08', '2025-01-01 04:17:08'),
(727, 2, 'SMPL9 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:17:08', '2025-01-01 04:17:08'),
(728, 3, 'SMPL9 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:24:33', '2025-01-01 04:24:33'),
(729, 6, 'SMPL9 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:24:33', '2025-01-01 04:24:33'),
(730, 2, 'SMPL9 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:24:33', '2025-01-01 04:24:33'),
(731, 3, 'SMPL9 Packing List Revised!', 'The value box no updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22box_no%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:26:38', '2025-01-01 04:26:38'),
(732, 6, 'SMPL9 Packing List Revised!', 'The value box no updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22box_no%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:26:38', '2025-01-01 04:26:38'),
(733, 2, 'SMPL9 Packing List Revised!', 'The value box no updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22box_no%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:26:38', '2025-01-01 04:26:38'),
(734, 3, 'SMPL9 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:27:22', '2025-01-01 04:27:22'),
(735, 6, 'SMPL9 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:27:22', '2025-01-01 04:27:22'),
(736, 2, 'SMPL9 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:27:22', '2025-01-01 04:27:22'),
(737, 3, 'SMPL9 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:27:51', '2025-01-01 04:27:51'),
(738, 6, 'SMPL9 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:27:51', '2025-01-01 04:27:51'),
(739, 2, 'SMPL9 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:27:51', '2025-01-01 04:27:51'),
(740, 3, 'SMPL9 Packing List Revised!', 'The value net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22net_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:28:05', '2025-01-01 04:28:05'),
(741, 6, 'SMPL9 Packing List Revised!', 'The value net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22net_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:28:05', '2025-01-01 04:28:05'),
(742, 2, 'SMPL9 Packing List Revised!', 'The value net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22net_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:28:05', '2025-01-01 04:28:05'),
(743, 3, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:28:21', '2025-01-01 04:28:21'),
(744, 6, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:28:21', '2025-01-01 04:28:21'),
(745, 2, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:28:21', '2025-01-01 04:28:21'),
(746, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=16&packageProduct=57', 0, '2025-01-01 04:28:40', '2025-01-01 04:28:40'),
(747, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=16&packageProduct=57', 0, '2025-01-01 04:28:40', '2025-01-01 04:28:40'),
(748, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=16&packageProduct=57', 0, '2025-01-01 04:28:40', '2025-01-01 04:28:40'),
(749, 3, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%5D&updatedPackageProducts=%5B%7B%22id%22%3A57%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:29:31', '2025-01-01 04:29:31'),
(750, 6, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%5D&updatedPackageProducts=%5B%7B%22id%22%3A57%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:29:31', '2025-01-01 04:29:31'),
(751, 2, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%5D&updatedPackageProducts=%5B%7B%22id%22%3A57%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:29:31', '2025-01-01 04:29:31'),
(752, 3, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%5D&updatedPackageProducts=%5B%7B%22id%22%3A57%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:34:18', '2025-01-01 04:34:18'),
(753, 6, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%5D&updatedPackageProducts=%5B%7B%22id%22%3A57%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:34:18', '2025-01-01 04:34:18'),
(754, 2, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%5D&updatedPackageProducts=%5B%7B%22id%22%3A57%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:34:18', '2025-01-01 04:34:18'),
(755, 3, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A57%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:37:44', '2025-01-01 04:37:44'),
(756, 6, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A57%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:37:44', '2025-01-01 04:37:44'),
(757, 2, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A57%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:37:44', '2025-01-01 04:37:44'),
(758, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=17&packageProduct=58%2C59', 0, '2025-01-01 04:39:23', '2025-01-01 04:39:23'),
(759, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=17&packageProduct=58%2C59', 0, '2025-01-01 04:39:23', '2025-01-01 04:39:23'),
(760, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=17&packageProduct=58%2C59', 0, '2025-01-01 04:39:24', '2025-01-01 04:39:24'),
(761, 3, 'SMPL9 Packing List Revised!', 'The value box no updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22box_no%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A57%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:40:06', '2025-01-01 04:40:06'),
(762, 6, 'SMPL9 Packing List Revised!', 'The value box no updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22box_no%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A57%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:40:06', '2025-01-01 04:40:06'),
(763, 2, 'SMPL9 Packing List Revised!', 'The value box no updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22box_no%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A57%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-01 04:40:06', '2025-01-01 04:40:06'),
(764, 3, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22box_no%22%5D%7D%2C%7B%22id%22%3A16%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A57%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A56%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:40:06', '2025-01-01 04:40:06'),
(765, 6, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22box_no%22%5D%7D%2C%7B%22id%22%3A16%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A57%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A56%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:40:06', '2025-01-01 04:40:06'),
(766, 2, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A16%2C%22fields%22%3A%5B%22box_no%22%5D%7D%2C%7B%22id%22%3A16%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A57%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A56%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:40:06', '2025-01-01 04:40:06'),
(767, 3, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A17%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A59%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:40:48', '2025-01-01 04:40:48'),
(768, 6, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A17%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A59%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:40:48', '2025-01-01 04:40:48'),
(769, 2, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A17%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A59%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:40:48', '2025-01-01 04:41:04'),
(770, 3, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A17%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A58%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:41:47', '2025-01-01 04:41:47'),
(771, 6, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A17%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A58%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:41:47', '2025-01-01 04:41:47'),
(772, 2, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A17%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A58%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:41:47', '2025-01-01 04:41:47'),
(773, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=18&packageProduct=60', 0, '2025-01-01 04:43:52', '2025-01-01 04:43:52'),
(774, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=18&packageProduct=60', 0, '2025-01-01 04:43:52', '2025-01-01 04:43:52'),
(775, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=18&packageProduct=60', 0, '2025-01-01 04:43:52', '2025-01-01 04:43:52'),
(776, 3, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A60%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:44:13', '2025-01-01 04:44:13'),
(777, 6, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A60%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:44:13', '2025-01-01 04:44:13'),
(778, 2, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A60%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-01 04:44:13', '2025-01-01 04:44:13'),
(779, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=18&packageProduct=61', 0, '2025-01-01 04:44:31', '2025-01-01 04:44:31');
INSERT INTO `notifications` (`id`, `user_id`, `heading`, `content`, `url`, `is_read`, `created_at`, `updated_at`) VALUES
(780, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=18&packageProduct=61', 0, '2025-01-01 04:44:31', '2025-01-01 04:44:31'),
(781, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=18&packageProduct=61', 0, '2025-01-01 04:44:31', '2025-01-01 04:44:31'),
(782, 3, 'SMLQ28 DIGUSIL MPS (MINT) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=28&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-02 00:37:26', '2025-01-02 00:37:26'),
(783, 3, 'SMLQ28 DIGUSIL MPS (MINT) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=28&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-02 00:45:00', '2025-01-02 00:45:00'),
(784, 3, 'SMLQ28 DIGUSIL MPS (MINT) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=28&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-02 00:45:20', '2025-01-02 00:45:20'),
(785, 3, 'SMLQ28 DIGUSIL MPS (MINT) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=28&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-02 00:45:57', '2025-01-02 00:45:57'),
(786, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#package=18&packageProduct=62', 0, '2025-01-02 01:11:08', '2025-01-02 01:11:08'),
(787, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#package=18&packageProduct=62', 0, '2025-01-02 01:11:08', '2025-01-02 01:11:08'),
(788, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#package=18&packageProduct=62', 0, '2025-01-02 01:11:08', '2025-01-02 01:11:08'),
(789, 3, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A60%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 01:12:42', '2025-01-02 01:12:42'),
(790, 6, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A60%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 01:12:42', '2025-01-02 01:12:42'),
(791, 2, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A60%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 01:12:42', '2025-01-02 01:12:42'),
(792, 3, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A60%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A61%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 01:12:42', '2025-01-02 01:12:42'),
(793, 6, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A60%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A61%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 01:12:42', '2025-01-02 01:12:42'),
(794, 2, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A60%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A61%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 01:12:42', '2025-01-02 01:12:42'),
(795, 3, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A60%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A61%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A62%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 01:12:43', '2025-01-02 01:12:43'),
(796, 6, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A60%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A61%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A62%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 01:12:43', '2025-01-02 01:12:43'),
(797, 2, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A60%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A61%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A62%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 01:12:43', '2025-01-02 01:12:43'),
(798, 3, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 01:14:16', '2025-01-02 01:14:16'),
(799, 6, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 01:14:16', '2025-01-02 01:14:16'),
(800, 2, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A18%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 01:14:16', '2025-01-02 01:14:16'),
(801, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=18&packageProduct=63', 0, '2025-01-02 01:17:05', '2025-01-02 01:17:05'),
(802, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=18&packageProduct=63', 0, '2025-01-02 01:17:05', '2025-01-02 01:17:05'),
(803, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=18&packageProduct=63', 0, '2025-01-02 01:17:05', '2025-01-02 01:17:05'),
(804, 3, 'SMPL9 Order Details Revised!!', 'The value price per set, total updated at!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2264%22%2C%22fields%22%3A%5B%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-02 03:49:22', '2025-01-02 03:49:22'),
(805, 6, 'SMPL9 Order Details Revised!!', 'The value price per set, total updated at!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2264%22%2C%22fields%22%3A%5B%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-02 03:49:22', '2025-01-02 03:49:22'),
(806, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=73', 0, '2025-01-02 03:51:47', '2025-01-02 03:51:47'),
(807, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=73', 0, '2025-01-02 03:51:47', '2025-01-02 03:51:47'),
(808, 2, 'SMPL9 CEFIXIME IP 100 MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders#updatedPurchases=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 0, '2025-01-02 03:52:42', '2025-01-02 03:52:42'),
(809, 2, 'SMPL9 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders#purchase=62%2C64%2C73', 0, '2025-01-02 03:53:24', '2025-01-02 03:53:24'),
(810, 2, 'SMPL9 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#purchase=62%2C64%2C73', 0, '2025-01-02 04:09:34', '2025-01-02 04:09:34'),
(811, 2, 'SMPL9 CEFIXIME IP 200MG + OFLOXACIN IP 200MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#updatedPurchases=%5B%7B%22id%22%3A73%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 0, '2025-01-02 04:10:08', '2025-01-02 04:10:08'),
(812, 2, 'SMPL9 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#purchase=64', 0, '2025-01-02 04:14:18', '2025-01-02 04:14:18'),
(813, 2, 'SMPL9 CEFIXIME IP 200MG + OFLOXACIN IP 200MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#updatedPurchases=%5B%7B%22id%22%3A73%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 0, '2025-01-02 04:15:06', '2025-01-02 04:15:06'),
(814, 3, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#productStocks=58%2C59', 0, '2025-01-02 04:17:07', '2025-01-02 04:17:07'),
(815, 6, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#productStocks=58%2C59', 0, '2025-01-02 04:17:07', '2025-01-02 04:17:07'),
(816, 2, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#productStocks=58%2C59', 0, '2025-01-02 04:17:07', '2025-01-02 04:17:07'),
(817, 3, 'SMPL9 Stock Details Revised!', 'The value manufacturing date updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A58%2C%22fields%22%3A%5B%22mfg_date%22%5D%7D%5D', 0, '2025-01-02 04:17:35', '2025-01-02 04:17:35'),
(818, 6, 'SMPL9 Stock Details Revised!', 'The value manufacturing date updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A58%2C%22fields%22%3A%5B%22mfg_date%22%5D%7D%5D', 0, '2025-01-02 04:17:35', '2025-01-02 04:17:35'),
(819, 2, 'SMPL9 Stock Details Revised!', 'The value manufacturing date updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A58%2C%22fields%22%3A%5B%22mfg_date%22%5D%7D%5D', 0, '2025-01-02 04:17:35', '2025-01-02 04:17:35'),
(820, 3, 'SMPL9 Stock Details Revised!', 'The value manufacturing date updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A58%2C%22fields%22%3A%5B%22mfg_date%22%5D%7D%5D', 0, '2025-01-02 04:21:46', '2025-01-02 04:21:46'),
(821, 6, 'SMPL9 Stock Details Revised!', 'The value manufacturing date updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A58%2C%22fields%22%3A%5B%22mfg_date%22%5D%7D%5D', 0, '2025-01-02 04:21:46', '2025-01-02 04:21:46'),
(822, 2, 'SMPL9 Stock Details Revised!', 'The value manufacturing date updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A58%2C%22fields%22%3A%5B%22mfg_date%22%5D%7D%5D', 0, '2025-01-02 04:21:46', '2025-01-02 04:21:46'),
(823, 3, 'SMPL9 Stock Details Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A58%2C%22fields%22%3A%5B%22mfg_date%22%5D%7D%2C%7B%22id%22%3A59%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 04:21:47', '2025-01-02 04:21:47'),
(824, 6, 'SMPL9 Stock Details Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A58%2C%22fields%22%3A%5B%22mfg_date%22%5D%7D%2C%7B%22id%22%3A59%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 04:21:47', '2025-01-02 04:21:47'),
(825, 2, 'SMPL9 Stock Details Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A58%2C%22fields%22%3A%5B%22mfg_date%22%5D%7D%2C%7B%22id%22%3A59%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 04:21:47', '2025-01-02 04:21:47'),
(826, 3, 'SMPL9 Stock Details Revised!', 'The value manufacturing date and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A58%2C%22fields%22%3A%5B%22mfg_date%22%5D%7D%2C%7B%22id%22%3A59%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 04:47:04', '2025-01-02 04:47:04'),
(827, 6, 'SMPL9 Stock Details Revised!', 'The value manufacturing date and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A58%2C%22fields%22%3A%5B%22mfg_date%22%5D%7D%2C%7B%22id%22%3A59%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 04:47:04', '2025-01-02 04:47:04'),
(828, 2, 'SMPL9 Stock Details Revised!', 'The value manufacturing date and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A58%2C%22fields%22%3A%5B%22mfg_date%22%5D%7D%2C%7B%22id%22%3A59%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 04:47:04', '2025-01-02 04:47:04'),
(829, 3, 'SMPL9 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#billing=58', 0, '2025-01-02 04:48:27', '2025-01-02 04:48:27'),
(830, 6, 'SMPL9 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#billing=58', 0, '2025-01-02 04:48:27', '2025-01-02 04:48:27'),
(831, 3, 'SMPL9 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#billing=58', 0, '2025-01-02 04:48:56', '2025-01-02 04:48:56'),
(832, 6, 'SMPL9 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#billing=58', 0, '2025-01-02 04:48:56', '2025-01-02 04:48:56'),
(833, 3, 'SMPL9 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#billing=58', 0, '2025-01-02 04:49:26', '2025-01-02 04:49:26'),
(834, 6, 'SMPL9 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#billing=58', 0, '2025-01-02 04:49:26', '2025-01-02 04:49:26'),
(835, 3, 'SMPL9 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#billing=58', 0, '2025-01-02 04:49:37', '2025-01-02 04:49:37'),
(836, 6, 'SMPL9 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#billing=58', 0, '2025-01-02 04:49:37', '2025-01-02 04:49:37'),
(837, 3, 'SMPL9 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#billing=58%2C59', 0, '2025-01-02 04:49:38', '2025-01-02 04:49:38'),
(838, 6, 'SMPL9 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#billing=58%2C59', 0, '2025-01-02 04:49:38', '2025-01-02 04:49:38'),
(839, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#package=19&packageProduct=64%2C65', 0, '2025-01-02 04:52:59', '2025-01-02 04:52:59'),
(840, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#package=19&packageProduct=64%2C65', 0, '2025-01-02 04:52:59', '2025-01-02 04:52:59'),
(841, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#package=19&packageProduct=64%2C65', 0, '2025-01-02 04:52:59', '2025-01-02 04:52:59'),
(842, 3, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 04:53:38', '2025-01-02 04:53:38'),
(843, 6, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 04:53:38', '2025-01-02 04:53:38'),
(844, 2, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 04:53:38', '2025-01-02 04:53:38'),
(845, 3, 'SMPL9 Packing List Revised!', 'The value box no updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22box_no%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-02 04:54:53', '2025-01-02 04:54:53'),
(846, 6, 'SMPL9 Packing List Revised!', 'The value box no updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22box_no%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-02 04:54:53', '2025-01-02 04:54:53'),
(847, 2, 'SMPL9 Packing List Revised!', 'The value box no updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22box_no%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-02 04:54:53', '2025-01-02 04:54:53'),
(848, 3, 'SMPL9 Packing List Revised!', 'The value dimension and gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22dimension%22%2C%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-02 04:55:19', '2025-01-02 04:55:19'),
(849, 6, 'SMPL9 Packing List Revised!', 'The value dimension and gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22dimension%22%2C%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-02 04:55:19', '2025-01-02 04:55:19'),
(850, 2, 'SMPL9 Packing List Revised!', 'The value dimension and gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22dimension%22%2C%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-02 04:55:19', '2025-01-02 04:55:19'),
(851, 3, 'SMPL9 Packing List Revised!', 'The value net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22net_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-02 04:55:48', '2025-01-02 04:55:48'),
(852, 6, 'SMPL9 Packing List Revised!', 'The value net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22net_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-02 04:55:48', '2025-01-02 04:55:48'),
(853, 2, 'SMPL9 Packing List Revised!', 'The value net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22net_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-02 04:55:48', '2025-01-02 04:55:48'),
(854, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=19%2C19&packageProduct=66%2C67', 0, '2025-01-02 05:02:56', '2025-01-02 05:02:56'),
(855, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=19%2C19&packageProduct=66%2C67', 0, '2025-01-02 05:02:56', '2025-01-02 05:02:56'),
(856, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=19%2C19&packageProduct=66%2C67', 0, '2025-01-02 05:02:56', '2025-01-02 05:02:56'),
(857, 3, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A65%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 1, '2025-01-02 05:05:30', '2025-01-02 05:06:05'),
(858, 6, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A65%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 05:05:30', '2025-01-02 05:05:30'),
(859, 2, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A65%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 05:05:30', '2025-01-02 05:05:30'),
(860, 3, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A65%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 1, '2025-01-02 05:05:31', '2025-01-02 05:05:59'),
(861, 6, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A65%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 05:05:31', '2025-01-02 05:05:31'),
(862, 2, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A65%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 05:05:31', '2025-01-02 05:05:31'),
(863, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=20&packageProduct=68', 0, '2025-01-02 05:17:04', '2025-01-02 05:17:04'),
(864, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=20&packageProduct=68', 0, '2025-01-02 05:17:04', '2025-01-02 05:17:04'),
(865, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=20&packageProduct=68', 0, '2025-01-02 05:17:04', '2025-01-02 05:17:04'),
(866, 3, 'SMPL9 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22box_no%22%2C%22dimension%22%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-02 05:17:51', '2025-01-02 05:17:51'),
(867, 6, 'SMPL9 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22box_no%22%2C%22dimension%22%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-02 05:17:51', '2025-01-02 05:17:51'),
(868, 2, 'SMPL9 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22box_no%22%2C%22dimension%22%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-02 05:17:51', '2025-01-02 05:17:51'),
(869, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=&packageProduct=', 0, '2025-01-02 05:17:52', '2025-01-02 05:17:52'),
(870, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=&packageProduct=', 0, '2025-01-02 05:17:52', '2025-01-02 05:17:52'),
(871, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=&packageProduct=', 0, '2025-01-02 05:17:52', '2025-01-02 05:17:52'),
(872, 3, 'SMPL9 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22box_no%22%2C%22dimension%22%2C%22gross_weight%22%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-02 05:24:49', '2025-01-02 05:24:49'),
(873, 6, 'SMPL9 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22box_no%22%2C%22dimension%22%2C%22gross_weight%22%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-02 05:24:49', '2025-01-02 05:24:49'),
(874, 2, 'SMPL9 Packing List Revised!', 'The value gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22box_no%22%2C%22dimension%22%2C%22gross_weight%22%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-02 05:24:49', '2025-01-02 05:24:49'),
(875, 3, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A66%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 05:29:38', '2025-01-02 05:29:38'),
(876, 6, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A66%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 05:29:38', '2025-01-02 05:29:38'),
(877, 2, 'SMPL9 Packing List Revised!!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A66%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 05:29:38', '2025-01-02 05:29:38'),
(878, 3, 'SMPL9 Packing List Revised!', 'The value dimension and gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22dimension%22%2C%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A66%2C%22fields%22%3A%5B%22order_product_id%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%22order_product_id%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%5D', 1, '2025-01-02 05:30:39', '2025-01-02 05:33:31'),
(879, 6, 'SMPL9 Packing List Revised!', 'The value dimension and gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22dimension%22%2C%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A66%2C%22fields%22%3A%5B%22order_product_id%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%22order_product_id%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-02 05:30:39', '2025-01-02 05:30:39'),
(880, 2, 'SMPL9 Packing List Revised!', 'The value dimension and gross weight updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22dimension%22%2C%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A66%2C%22fields%22%3A%5B%22order_product_id%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%22order_product_id%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-02 05:30:39', '2025-01-02 05:30:39'),
(881, 3, 'SMPL9 Packing List Revised!!', 'The value product name and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22dimension%22%2C%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A66%2C%22fields%22%3A%5B%22order_product_id%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%22order_product_id%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%5D', 1, '2025-01-02 05:30:40', '2025-01-02 05:33:38'),
(882, 6, 'SMPL9 Packing List Revised!!', 'The value product name and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22dimension%22%2C%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A66%2C%22fields%22%3A%5B%22order_product_id%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%22order_product_id%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-02 05:30:40', '2025-01-02 05:30:40'),
(883, 2, 'SMPL9 Packing List Revised!!', 'The value product name and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22dimension%22%2C%22gross_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A66%2C%22fields%22%3A%5B%22order_product_id%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%22order_product_id%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-01-02 05:30:40', '2025-01-02 05:30:40'),
(884, 3, 'SMPL9 Packing List Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A67%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 05:39:44', '2025-01-02 05:39:44'),
(885, 6, 'SMPL9 Packing List Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A67%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 05:39:44', '2025-01-02 05:39:44'),
(886, 2, 'SMPL9 Packing List Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A67%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 05:39:44', '2025-01-02 05:39:44'),
(887, 3, 'SMPL9 Packing List Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22box_no%22%2C%22dimension%22%2C%22net_weight%22%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22box_no%22%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%22order_product_id%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 05:40:32', '2025-01-02 05:40:32'),
(888, 6, 'SMPL9 Packing List Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22box_no%22%2C%22dimension%22%2C%22net_weight%22%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22box_no%22%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%22order_product_id%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 05:40:32', '2025-01-02 05:40:32'),
(889, 2, 'SMPL9 Packing List Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22box_no%22%2C%22dimension%22%2C%22net_weight%22%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22box_no%22%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%22order_product_id%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 05:40:32', '2025-01-02 05:40:32'),
(890, 3, 'SMPL9 Packing List Revised!', 'The value dimension and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22dimension%22%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22dimension%22%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 06:38:27', '2025-01-02 06:38:27'),
(891, 6, 'SMPL9 Packing List Revised!', 'The value dimension and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22dimension%22%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22dimension%22%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 06:38:27', '2025-01-02 06:38:27'),
(892, 2, 'SMPL9 Packing List Revised!', 'The value dimension and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22dimension%22%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22dimension%22%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 06:38:27', '2025-01-02 06:38:27'),
(893, 3, 'SMPL9 Packing List Revised!', 'The value box no, dimension, net weight and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22dimension%22%2C%22net_weight%22%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22box_no%22%2C%22dimension%22%2C%22net_weight%22%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%22order_product_id%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 06:40:31', '2025-01-02 06:40:31'),
(894, 6, 'SMPL9 Packing List Revised!', 'The value box no, dimension, net weight and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22dimension%22%2C%22net_weight%22%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22box_no%22%2C%22dimension%22%2C%22net_weight%22%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%22order_product_id%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 06:40:31', '2025-01-02 06:40:31'),
(895, 2, 'SMPL9 Packing List Revised!', 'The value box no, dimension, net weight and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%22dimension%22%2C%22net_weight%22%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%22box_no%22%2C%22dimension%22%2C%22net_weight%22%5D%7D%2C%7B%22id%22%3A20%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A64%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A65%2C%22fields%22%3A%5B%22order_product_id%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A66%2C%22fields%22%3A%5B%22quantity%22%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A68%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 06:40:31', '2025-01-02 06:40:31'),
(896, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#package=20&packageProduct=69', 0, '2025-01-02 22:40:56', '2025-01-02 22:40:56');
INSERT INTO `notifications` (`id`, `user_id`, `heading`, `content`, `url`, `is_read`, `created_at`, `updated_at`) VALUES
(897, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#package=20&packageProduct=69', 0, '2025-01-02 22:40:56', '2025-01-02 22:40:56'),
(898, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#package=20&packageProduct=69', 0, '2025-01-02 22:40:56', '2025-01-02 22:40:56'),
(899, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully&packageProduct=70', 0, '2025-01-02 22:42:55', '2025-01-02 22:42:55'),
(900, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully&packageProduct=70', 0, '2025-01-02 22:42:55', '2025-01-02 22:42:55'),
(901, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully&packageProduct=70', 0, '2025-01-02 22:42:55', '2025-01-02 22:42:55'),
(902, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully&packageProduct=71', 0, '2025-01-02 22:44:37', '2025-01-02 22:44:37'),
(903, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully&packageProduct=71', 0, '2025-01-02 22:44:37', '2025-01-02 22:44:37'),
(904, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully&packageProduct=71', 0, '2025-01-02 22:44:37', '2025-01-02 22:44:37'),
(905, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=20&packageProduct=72', 0, '2025-01-02 22:47:41', '2025-01-02 22:47:41'),
(906, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=20&packageProduct=72', 0, '2025-01-02 22:47:41', '2025-01-02 22:47:41'),
(907, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=20&packageProduct=72', 0, '2025-01-02 22:47:41', '2025-01-02 22:47:41'),
(908, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=73', 0, '2025-01-02 22:51:06', '2025-01-02 22:51:06'),
(909, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=73', 0, '2025-01-02 22:51:06', '2025-01-02 22:51:06'),
(910, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=73', 0, '2025-01-02 22:51:06', '2025-01-02 22:51:06'),
(911, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=21&packageProduct=74%2C75', 0, '2025-01-02 22:52:28', '2025-01-02 22:52:28'),
(912, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=21&packageProduct=74%2C75', 0, '2025-01-02 22:52:28', '2025-01-02 22:52:28'),
(913, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=21&packageProduct=74%2C75', 0, '2025-01-02 22:52:28', '2025-01-02 22:52:28'),
(914, 3, 'SMPL9 Packing List Revised!', 'The value gross weight and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A21%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%2C%7B%22id%22%3A21%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A66%2C%22fields%22%3A%5B%22order_product_id%22%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%22order_product_id%22%5D%7D%2C%7B%22id%22%3A74%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A75%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A74%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 22:53:07', '2025-01-02 22:53:07'),
(915, 6, 'SMPL9 Packing List Revised!', 'The value gross weight and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A21%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%2C%7B%22id%22%3A21%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A66%2C%22fields%22%3A%5B%22order_product_id%22%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%22order_product_id%22%5D%7D%2C%7B%22id%22%3A74%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A75%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A74%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 22:53:07', '2025-01-02 22:53:07'),
(916, 2, 'SMPL9 Packing List Revised!', 'The value gross weight and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A19%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A21%2C%22fields%22%3A%5B%22gross_weight%22%5D%7D%2C%7B%22id%22%3A21%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A66%2C%22fields%22%3A%5B%22order_product_id%22%5D%7D%2C%7B%22id%22%3A67%2C%22fields%22%3A%5B%22order_product_id%22%5D%7D%2C%7B%22id%22%3A74%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A75%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A74%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 22:53:07', '2025-01-02 22:53:07'),
(917, 3, 'SMPL9 Packing List Revised!', 'The value dimension, gross weight and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A21%2C%22fields%22%3A%5B%22dimension%22%2C%22gross_weight%22%5D%7D%2C%7B%22id%22%3A21%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A74%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A75%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A75%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 23:01:00', '2025-01-02 23:01:00'),
(918, 6, 'SMPL9 Packing List Revised!', 'The value dimension, gross weight and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A21%2C%22fields%22%3A%5B%22dimension%22%2C%22gross_weight%22%5D%7D%2C%7B%22id%22%3A21%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A74%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A75%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A75%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 23:01:00', '2025-01-02 23:01:00'),
(919, 2, 'SMPL9 Packing List Revised!', 'The value dimension, gross weight and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A21%2C%22fields%22%3A%5B%22dimension%22%2C%22gross_weight%22%5D%7D%2C%7B%22id%22%3A21%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A74%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A75%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A75%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-02 23:01:00', '2025-01-02 23:01:00'),
(920, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=76', 0, '2025-01-02 23:18:40', '2025-01-02 23:18:40'),
(921, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=76', 0, '2025-01-02 23:18:40', '2025-01-02 23:18:40'),
(922, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=76', 0, '2025-01-02 23:18:40', '2025-01-02 23:18:40'),
(923, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=77', 0, '2025-01-02 23:19:24', '2025-01-02 23:19:24'),
(924, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=77', 0, '2025-01-02 23:19:24', '2025-01-02 23:19:24'),
(925, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=77', 0, '2025-01-02 23:19:24', '2025-01-02 23:50:36'),
(926, 2, 'SMPL9 CEFIXIME IP 200MG + OFLOXACIN IP 200MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders#updatedPurchases=%5B%7B%22id%22%3A73%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 0, '2025-01-02 23:49:37', '2025-01-02 23:49:37'),
(927, 2, 'SMPL9 CEFIXIME IP 200MG + OFLOXACIN IP 200MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Order product package updated successfully#updatedPurchases=%5B%7B%22id%22%3A73%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 0, '2025-01-02 23:50:51', '2025-01-02 23:51:10'),
(928, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=29&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-03 00:20:02', '2025-01-03 00:20:02'),
(929, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 00:20:35', '2025-01-03 00:20:35'),
(930, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 00:21:08', '2025-01-03 00:21:08'),
(931, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 00:21:29', '2025-01-03 00:21:29'),
(932, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 00:22:20', '2025-01-03 00:22:20'),
(933, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 00:22:20', '2025-01-03 00:22:20'),
(934, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 00:22:47', '2025-01-03 00:22:47'),
(935, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 00:23:10', '2025-01-03 00:23:10'),
(936, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 00:23:20', '2025-01-03 00:23:20'),
(937, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 00:23:28', '2025-01-03 00:23:28'),
(938, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=78%2C79%2C80%2C81%2C82%2C83', 0, '2025-01-03 02:19:44', '2025-01-03 02:19:44'),
(939, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=78%2C79%2C80%2C81%2C82%2C83', 0, '2025-01-03 02:19:44', '2025-01-03 02:19:44'),
(940, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=78%2C79%2C80%2C81%2C82%2C83', 0, '2025-01-03 02:19:44', '2025-01-03 02:19:44'),
(941, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=22&packageProduct=84', 0, '2025-01-03 02:21:20', '2025-01-03 02:21:20'),
(942, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=22&packageProduct=84', 0, '2025-01-03 02:21:20', '2025-01-03 02:21:20'),
(943, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=22&packageProduct=84', 0, '2025-01-03 02:21:20', '2025-01-03 02:21:20'),
(944, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=22%2C23&packageProduct=84%2C85', 0, '2025-01-03 02:21:20', '2025-01-03 02:21:20'),
(945, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=22%2C23&packageProduct=84%2C85', 0, '2025-01-03 02:21:20', '2025-01-03 02:21:20'),
(946, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=22%2C23&packageProduct=84%2C85', 0, '2025-01-03 02:21:20', '2025-01-03 02:21:20'),
(947, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=86', 0, '2025-01-03 02:21:35', '2025-01-03 02:21:35'),
(948, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=86', 0, '2025-01-03 02:21:35', '2025-01-03 02:21:35'),
(949, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=86', 0, '2025-01-03 02:21:35', '2025-01-03 02:21:35'),
(950, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=87', 0, '2025-01-03 02:21:52', '2025-01-03 02:21:52'),
(951, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=87', 0, '2025-01-03 02:21:52', '2025-01-03 02:21:52'),
(952, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=87', 0, '2025-01-03 02:21:52', '2025-01-03 02:21:52'),
(953, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=88', 0, '2025-01-03 02:22:05', '2025-01-03 02:22:05'),
(954, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=88', 0, '2025-01-03 02:22:05', '2025-01-03 02:22:05'),
(955, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=88', 0, '2025-01-03 02:22:05', '2025-01-03 02:22:05'),
(956, 3, 'SMPL9 Packing List Revised!', 'The value product name and product name updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A22%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A23%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A84%2C%22fields%22%3A%5B%22order_product_id%22%5D%7D%2C%7B%22id%22%3A87%2C%22fields%22%3A%5B%22order_product_id%22%5D%7D%5D', 0, '2025-01-03 02:22:50', '2025-01-03 02:22:50'),
(957, 6, 'SMPL9 Packing List Revised!', 'The value product name and product name updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A22%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A23%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A84%2C%22fields%22%3A%5B%22order_product_id%22%5D%7D%2C%7B%22id%22%3A87%2C%22fields%22%3A%5B%22order_product_id%22%5D%7D%5D', 0, '2025-01-03 02:22:50', '2025-01-03 02:22:50'),
(958, 2, 'SMPL9 Packing List Revised!', 'The value product name and product name updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#updatedPackages=%5B%7B%22id%22%3A22%2C%22fields%22%3A%5B%5D%7D%2C%7B%22id%22%3A23%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A84%2C%22fields%22%3A%5B%22order_product_id%22%5D%7D%2C%7B%22id%22%3A87%2C%22fields%22%3A%5B%22order_product_id%22%5D%7D%5D', 0, '2025-01-03 02:22:50', '2025-01-03 02:22:50'),
(959, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=89', 0, '2025-01-03 02:22:51', '2025-01-03 02:22:51'),
(960, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=89', 0, '2025-01-03 02:22:51', '2025-01-03 02:22:51'),
(961, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=89', 0, '2025-01-03 02:22:51', '2025-01-03 02:22:51'),
(962, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=24&packageProduct=90%2C91', 0, '2025-01-03 02:23:58', '2025-01-03 02:23:58'),
(963, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=24&packageProduct=90%2C91', 0, '2025-01-03 02:23:58', '2025-01-03 02:23:58'),
(964, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=24&packageProduct=90%2C91', 0, '2025-01-03 02:23:58', '2025-01-03 02:23:58'),
(965, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=24%2C25&packageProduct=90%2C91%2C92%2C93', 0, '2025-01-03 02:23:59', '2025-01-03 02:23:59'),
(966, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=24%2C25&packageProduct=90%2C91%2C92%2C93', 0, '2025-01-03 02:23:59', '2025-01-03 02:23:59'),
(967, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=24%2C25&packageProduct=90%2C91%2C92%2C93', 0, '2025-01-03 02:23:59', '2025-01-03 02:23:59'),
(968, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 05:22:21', '2025-01-03 05:22:21'),
(969, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 05:23:42', '2025-01-03 05:23:42'),
(970, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 05:24:48', '2025-01-03 05:24:48'),
(971, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 05:45:05', '2025-01-03 05:45:05'),
(972, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 05:54:06', '2025-01-03 05:54:06'),
(973, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 05:54:20', '2025-01-03 05:54:20'),
(974, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 05:59:54', '2025-01-03 05:59:54'),
(975, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 06:03:45', '2025-01-03 06:03:45'),
(976, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 06:04:31', '2025-01-03 06:04:31'),
(977, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 06:05:22', '2025-01-03 06:05:22'),
(978, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 06:09:20', '2025-01-03 06:09:20'),
(979, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 06:09:38', '2025-01-03 06:09:38'),
(980, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 06:09:49', '2025-01-03 06:09:49'),
(981, 3, 'SMLQ25 HUMULIN N U-100 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=25&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-03 06:13:30', '2025-01-03 06:13:30'),
(982, 3, 'SMLQ25 HUMULIN N U-100 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=25&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-03 06:14:04', '2025-01-03 06:14:04'),
(983, 3, 'SMLQ25 HUMULIN N U-100 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 06:14:22', '2025-01-03 06:14:22'),
(984, 3, 'SMLQ30 ACI FREE (ZEERA) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=33&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-03 06:19:20', '2025-01-03 06:19:20'),
(985, 3, 'SMLQ30 ACI FREE (ZEERA) Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 06:19:46', '2025-01-03 06:19:46'),
(986, 3, 'SMLQ30 ACI FREE (ZEERA) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 06:29:35', '2025-01-03 06:29:35'),
(987, 3, 'SMLQ30 ACI FREE (ZEERA) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 06:29:39', '2025-01-03 06:29:39'),
(988, 3, 'SMLQ30 ACI FREE (ZEERA) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 06:32:57', '2025-01-03 06:32:57'),
(989, 3, 'SMLQ30 ACI FREE (ZEERA) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 06:33:08', '2025-01-03 06:33:08'),
(990, 3, 'SMLQ30 ACI FREE (ZEERA) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 06:33:32', '2025-01-03 06:33:32'),
(991, 3, 'SMLQ30 ACI FREE (ZEERA) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 06:34:33', '2025-01-03 06:34:33'),
(992, 3, 'SMLQ30 ACI FREE (ZEERA) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 06:42:55', '2025-01-03 06:42:55'),
(993, 3, 'SMLQ30 ACI FREE (ZEERA) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 06:43:07', '2025-01-03 06:43:07'),
(994, 3, 'SMLQ30 ACI FREE (ZEERA) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 06:48:09', '2025-01-03 06:48:09'),
(995, 3, 'SMLQ30 ACI FREE (ZEERA) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 06:48:13', '2025-01-03 06:48:13'),
(996, 3, 'SMLQ30 ACI FREE (ZEERA) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 06:48:50', '2025-01-03 06:48:50'),
(997, 3, 'SMLQ30 ACI FREE (ZEERA) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-03 06:49:21', '2025-01-03 06:49:21'),
(998, 3, 'SMLQ30 ACI FREE (ZEERA) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-05 22:41:51', '2025-01-05 22:41:51'),
(999, 3, 'SMLQ30 ACI FREE (ZEERA) Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-05 22:42:26', '2025-01-05 22:42:26'),
(1000, 3, 'SMLQ30 ACI FREE (ZEERA) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-05 22:53:53', '2025-01-05 22:53:53'),
(1001, 3, 'SMLQ30 ACI FREE (ZEERA) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-05 22:54:07', '2025-01-05 22:54:07'),
(1002, 3, 'SMLQ30 ACI FREE (ZEERA) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-05 22:54:15', '2025-01-05 22:54:15'),
(1003, 3, 'SMLQ30 ACI FREE (ZEERA) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-05 22:54:30', '2025-01-05 22:54:30'),
(1004, 3, 'SMLQ30 ACI FREE (ZEERA) Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-05 22:54:40', '2025-01-05 22:54:40'),
(1005, 3, 'SMLQ31 CALCIUM ACETATE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=34&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-05 23:01:12', '2025-01-05 23:01:12'),
(1006, 3, 'SMLQ31 CALCIUM ACETATE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-05 23:02:35', '2025-01-05 23:02:35'),
(1007, 3, 'SMLQ31 CALCIUM ACETATE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-05 23:02:35', '2025-01-05 23:02:35'),
(1008, 3, 'SMLQ31 CALCIUM ACETATE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-05 23:02:55', '2025-01-05 23:02:55'),
(1009, 3, 'SMLQ31 CALCIUM ACETATE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-05 23:03:28', '2025-01-05 23:03:28'),
(1010, 3, 'SMLQ31 CALCIUM ACETATE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-05 23:03:41', '2025-01-05 23:03:41'),
(1011, 3, 'SMLQ31 CALCIUM ACETATE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-05 23:04:04', '2025-01-05 23:04:04'),
(1012, 3, 'SMLQ31 CALCIUM ACETATE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-05 23:04:45', '2025-01-05 23:04:45'),
(1013, 3, 'SMLQ31 CALCIUM ACETATE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-05 23:04:54', '2025-01-05 23:04:54'),
(1014, 2, 'SMLQ33 CALCITRIOL CAPSULE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=37&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-05 23:08:10', '2025-01-05 23:08:10'),
(1015, 2, 'SMLQ33 CALCITRIOL CAPSULE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=37&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 1, '2025-01-05 23:08:20', '2025-01-13 06:13:47'),
(1016, 2, 'SMLQ33 CALCITRIOL CAPSULE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=37&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 1, '2025-01-05 23:08:37', '2025-01-10 06:06:08'),
(1017, 2, 'SMLQ33 CALCITRIOL CAPSULE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-05 23:09:03', '2025-01-10 05:53:28'),
(1018, 2, 'SMLQ33 CALCITRIOL CAPSULE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-05 23:09:22', '2025-01-10 05:52:58'),
(1019, 2, 'SMLQ33 CALCITRIOL CAPSULE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-05 23:09:37', '2025-01-10 05:52:30'),
(1020, 2, 'SMLQ33 CALCITRIOL CAPSULE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-05 23:09:54', '2025-01-10 04:10:50'),
(1021, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=38&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 1, '2025-01-05 23:11:39', '2025-01-10 04:05:42'),
(1022, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-05 23:11:55', '2025-01-10 04:04:35'),
(1023, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-05 23:12:04', '2025-01-05 23:12:04'),
(1024, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-05 23:12:43', '2025-01-05 23:12:43'),
(1025, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-05 23:12:44', '2025-01-05 23:12:44'),
(1026, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-05 23:13:00', '2025-01-05 23:13:00'),
(1027, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-05 23:13:11', '2025-01-05 23:13:11'),
(1028, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-05 23:13:29', '2025-01-05 23:13:29'),
(1029, 2, 'SMLQ33 CALCITRIOL CAPSULE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-05 23:57:02', '2025-01-05 23:57:02'),
(1030, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-05 23:57:29', '2025-01-05 23:57:29'),
(1031, 2, 'SMLQ33 CALCITRIOL CAPSULE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-05 23:58:08', '2025-01-05 23:58:08'),
(1032, 2, 'SMLQ33 CALCITRIOL CAPSULE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-05 23:58:22', '2025-01-05 23:58:22'),
(1033, 2, 'SMLQ33 CALCITRIOL CAPSULE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-05 23:58:34', '2025-01-05 23:58:34'),
(1034, 2, 'SMLQ33 CALCITRIOL CAPSULE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-05 23:58:48', '2025-01-05 23:58:48'),
(1035, 2, 'SMLQ33 CALCITRIOL CAPSULE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-05 23:58:56', '2025-01-05 23:58:56'),
(1036, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=open', 1, '2025-01-05 23:59:51', '2025-01-05 23:59:51'),
(1037, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-06 00:00:24', '2025-01-06 00:00:24'),
(1038, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-06 00:02:09', '2025-01-06 00:02:09'),
(1039, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-06 00:02:24', '2025-01-06 00:02:24'),
(1040, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-06 00:02:35', '2025-01-06 00:02:35'),
(1041, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-06 00:08:28', '2025-01-06 00:08:28'),
(1042, 3, 'SMLQ27 HOPESWAN Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=27&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-06 00:12:06', '2025-01-06 00:12:06'),
(1043, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-06 00:15:14', '2025-01-06 00:15:14'),
(1044, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=38&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 1, '2025-01-06 00:25:08', '2025-01-06 00:25:08'),
(1045, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-06 00:35:08', '2025-01-06 00:35:08'),
(1046, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-06 00:35:08', '2025-01-06 00:35:08'),
(1047, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=38&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 1, '2025-01-06 00:37:55', '2025-01-06 00:37:55'),
(1048, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-06 00:38:10', '2025-01-06 00:38:10'),
(1049, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=38&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 1, '2025-01-06 00:42:53', '2025-01-06 00:42:53'),
(1050, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=38&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 1, '2025-01-06 00:43:54', '2025-01-06 00:43:54'),
(1051, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=38&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 1, '2025-01-06 00:48:22', '2025-01-06 00:48:22'),
(1052, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=38&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 1, '2025-01-06 01:07:11', '2025-01-06 01:07:11'),
(1053, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=38&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 1, '2025-01-06 01:11:16', '2025-01-06 01:11:16'),
(1054, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-06 01:17:26', '2025-01-06 01:17:26'),
(1055, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-06 01:17:27', '2025-01-06 01:17:27');
INSERT INTO `notifications` (`id`, `user_id`, `heading`, `content`, `url`, `is_read`, `created_at`, `updated_at`) VALUES
(1056, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-06 01:18:54', '2025-01-06 01:18:54'),
(1057, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-06 01:20:55', '2025-01-06 01:20:55'),
(1058, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-06 01:22:16', '2025-01-06 01:22:16'),
(1059, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-06 01:24:04', '2025-01-06 01:24:04'),
(1060, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-06 01:33:38', '2025-01-06 01:33:38'),
(1061, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-06 01:44:06', '2025-01-06 01:44:06'),
(1062, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-06 02:37:48', '2025-01-06 02:37:48'),
(1063, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-06 02:38:47', '2025-01-06 02:38:47'),
(1064, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-06 02:44:56', '2025-01-06 02:44:56'),
(1065, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-06 03:03:16', '2025-01-06 03:03:16'),
(1066, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-06 03:11:30', '2025-01-06 03:11:30'),
(1067, 3, 'SMLQ27 HOPESWAN Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=27&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-06 03:24:36', '2025-01-06 03:24:36'),
(1068, 3, 'SMLQ27 HOPESWAN Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 0, '2025-01-06 03:25:45', '2025-01-06 03:25:45'),
(1069, 3, 'SMLQ27 HOPESWAN Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 0, '2025-01-06 03:25:59', '2025-01-06 03:25:59'),
(1070, 3, 'SMLQ27 HOPESWAN Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 0, '2025-01-06 03:26:10', '2025-01-06 03:26:10'),
(1071, 3, 'SMLQ27 HOPESWAN Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 0, '2025-01-06 03:26:19', '2025-01-06 03:26:19'),
(1072, 3, 'SMLQ27 HOPESWAN Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 0, '2025-01-06 03:26:31', '2025-01-06 03:26:31'),
(1073, 2, 'SMLQ35 BROMOCRIPTINE TABLET Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=39&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 1, '2025-01-06 03:28:00', '2025-01-06 03:28:00'),
(1074, 2, 'SMLQ35 BROMOCRIPTINE TABLET Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-06 03:29:30', '2025-01-06 03:29:30'),
(1075, 2, 'SMLQ35 BROMOCRIPTINE TABLET Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-06 03:36:30', '2025-01-06 03:36:30'),
(1076, 2, 'SMLQ35 BROMOCRIPTINE TABLET Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-06 03:36:56', '2025-01-06 03:36:56'),
(1077, 2, 'SMLQ35 BROMOCRIPTINE TABLET Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-06 04:16:45', '2025-01-06 04:16:45'),
(1078, 2, 'SMLQ35 BROMOCRIPTINE TABLET Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-06 04:17:33', '2025-01-06 04:17:33'),
(1079, 2, 'SMLQ35 BROMOCRIPTINE TABLET Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-06 04:23:08', '2025-01-06 04:23:08'),
(1080, 2, 'SMLQ35 BROMOCRIPTINE TABLET Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-06 04:23:09', '2025-01-06 04:23:09'),
(1081, 2, 'SMLQ35 BROMOCRIPTINE TABLET Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-06 04:24:27', '2025-01-06 04:24:27'),
(1082, 2, 'SMLQ35 BROMOCRIPTINE TABLET Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-06 04:24:28', '2025-01-06 04:24:28'),
(1083, 2, 'SMLQ35 BROMOCRIPTINE TABLET Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-06 04:28:56', '2025-01-06 04:28:56'),
(1084, 2, 'SMLQ35 BROMOCRIPTINE TABLET Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-06 04:28:56', '2025-01-06 04:28:56'),
(1085, 2, 'SMLQ35 BROMOCRIPTINE TABLET Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-06 04:31:38', '2025-01-06 04:31:38'),
(1086, 2, 'SMPL9 CEFIXIME IP 200MG + OFLOXACIN IP 200MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders#updatedPurchases=%5B%7B%22id%22%3A73%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 1, '2025-01-06 23:10:48', '2025-01-06 23:10:48'),
(1087, 2, 'SMPL9 CEFIXIME IP 200MG + OFLOXACIN IP 200MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#updatedPurchases=%5B%7B%22id%22%3A73%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 1, '2025-01-06 23:14:40', '2025-01-06 23:14:40'),
(1088, 3, 'SMPL9 Order Details Revised!!', 'The value pack quantity, price per set and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-07 00:19:32', '2025-01-07 00:19:32'),
(1089, 6, 'SMPL9 Order Details Revised!!', 'The value pack quantity, price per set and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-07 00:19:32', '2025-01-07 00:19:32'),
(1090, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=74%2C75', 0, '2025-01-07 00:48:48', '2025-01-07 00:48:48'),
(1091, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=74%2C75', 0, '2025-01-07 00:48:48', '2025-01-07 00:48:48'),
(1092, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=76%2C77', 0, '2025-01-07 00:48:48', '2025-01-07 00:48:48'),
(1093, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=76%2C77', 0, '2025-01-07 00:48:48', '2025-01-07 00:48:48'),
(1094, 3, 'SMPL9 Order Details Revised!!', 'The value price per set, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2275%22%2C%22fields%22%3A%5B%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-07 02:51:23', '2025-01-07 02:51:23'),
(1095, 6, 'SMPL9 Order Details Revised!!', 'The value price per set, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2275%22%2C%22fields%22%3A%5B%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-07 02:51:23', '2025-01-07 02:51:23'),
(1096, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=40&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 1, '2025-01-07 03:52:50', '2025-01-07 03:52:50'),
(1097, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-07 03:53:43', '2025-01-07 03:53:43'),
(1098, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-07 03:53:43', '2025-01-07 03:53:43'),
(1099, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-07 03:55:38', '2025-01-07 03:55:38'),
(1100, 2, 'SMLQ37 AAAEERARR5595 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=41&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 1, '2025-01-07 04:03:30', '2025-01-07 04:03:30'),
(1101, 2, 'SMLQ37 AAAEERARR5595 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-07 04:05:00', '2025-01-07 04:05:00'),
(1102, 2, 'SMLQ37 AAAEERARR5595 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-07 04:05:42', '2025-01-07 04:05:42'),
(1103, 2, 'SMLQ37 AAAEERARR5595 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-07 04:07:19', '2025-01-07 04:07:19'),
(1104, 2, 'SMLQ37 AAAEERARR5595 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-07 04:10:49', '2025-01-07 04:10:49'),
(1105, 2, 'SMLQ37 AAAEERARR5595 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-07 04:12:35', '2025-01-07 04:12:35'),
(1106, 2, 'SMLQ37 AAAEERARR5595 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-07 04:15:33', '2025-01-07 04:15:33'),
(1107, 2, 'SMLQ37 AAAEERARR5595 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-07 04:20:27', '2025-01-07 04:20:27'),
(1108, 2, 'SMLQ37 AAAEERARR5595 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-07 04:21:36', '2025-01-07 04:21:36'),
(1109, 2, 'SMLQ37 AAAEERARR5595 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-07 04:29:24', '2025-01-07 04:29:24'),
(1110, 2, 'SMLQ37 AAAEERARR5595 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-07 04:30:31', '2025-01-07 04:30:31'),
(1111, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-07 04:30:39', '2025-01-07 04:30:39'),
(1112, 3, 'SMPL9 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#order=14&fields=Shipping+Cost', 0, '2025-01-07 05:31:50', '2025-01-07 05:31:50'),
(1113, 6, 'SMPL9 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#order=14&fields=Shipping+Cost', 0, '2025-01-07 05:31:50', '2025-01-07 05:31:50'),
(1114, 3, 'SMPL9 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#order=14&fields=Shipping+Cost', 0, '2025-01-07 05:32:07', '2025-01-07 05:32:07'),
(1115, 6, 'SMPL9 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#order=14&fields=Shipping+Cost', 0, '2025-01-07 05:32:07', '2025-01-07 05:32:07'),
(1116, 3, 'SMPL9 Stock Details Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders#updatedStocks=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-07 06:05:24', '2025-01-07 06:05:24'),
(1117, 6, 'SMPL9 Stock Details Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders#updatedStocks=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-07 06:05:24', '2025-01-07 06:05:24'),
(1118, 2, 'SMPL9 Stock Details Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders#updatedStocks=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 1, '2025-01-07 06:05:24', '2025-01-07 06:05:24'),
(1119, 3, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders#productStocks=60', 0, '2025-01-07 06:06:00', '2025-01-07 06:06:00'),
(1120, 6, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders#productStocks=60', 0, '2025-01-07 06:06:00', '2025-01-07 06:06:00'),
(1121, 2, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders#productStocks=60', 1, '2025-01-07 06:06:00', '2025-01-07 06:06:00'),
(1122, 3, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders#productStocks=61', 0, '2025-01-07 06:06:02', '2025-01-07 06:06:02'),
(1123, 6, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders#productStocks=61', 0, '2025-01-07 06:06:02', '2025-01-07 06:06:02'),
(1124, 2, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders#productStocks=61', 1, '2025-01-07 06:06:02', '2025-01-07 06:06:02'),
(1125, 3, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=62', 0, '2025-01-07 06:31:10', '2025-01-07 06:31:10'),
(1126, 6, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=62', 0, '2025-01-07 06:31:10', '2025-01-07 06:31:10'),
(1127, 2, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=62', 1, '2025-01-07 06:31:10', '2025-01-07 06:31:10'),
(1128, 3, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=63', 0, '2025-01-07 06:31:11', '2025-01-07 06:31:11'),
(1129, 6, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=63', 0, '2025-01-07 06:31:11', '2025-01-07 06:31:11'),
(1130, 2, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=63', 1, '2025-01-07 06:31:11', '2025-01-07 06:31:11'),
(1131, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#package=26&packageProduct=94', 0, '2025-01-07 23:34:46', '2025-01-07 23:34:46'),
(1132, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#package=26&packageProduct=94', 0, '2025-01-07 23:34:46', '2025-01-07 23:34:46'),
(1133, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#package=26&packageProduct=94', 1, '2025-01-07 23:34:46', '2025-01-07 23:34:46'),
(1134, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#package=27&packageProduct=95', 0, '2025-01-07 23:34:47', '2025-01-07 23:34:47'),
(1135, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#package=27&packageProduct=95', 0, '2025-01-07 23:34:47', '2025-01-07 23:34:47'),
(1136, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#package=27&packageProduct=95', 1, '2025-01-07 23:34:47', '2025-01-07 23:34:47'),
(1137, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#packageProduct=96', 0, '2025-01-08 00:05:18', '2025-01-08 00:05:18'),
(1138, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#packageProduct=96', 0, '2025-01-08 00:05:18', '2025-01-08 00:05:18'),
(1139, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#packageProduct=96', 1, '2025-01-08 00:05:18', '2025-01-08 00:05:18'),
(1140, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#packageProduct=97', 0, '2025-01-08 00:05:19', '2025-01-08 00:05:19'),
(1141, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#packageProduct=97', 0, '2025-01-08 00:05:19', '2025-01-08 00:05:19'),
(1142, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders#packageProduct=97', 1, '2025-01-08 00:05:19', '2025-01-08 00:05:19'),
(1143, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=98', 0, '2025-01-08 00:06:39', '2025-01-08 00:06:39'),
(1144, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=98', 0, '2025-01-08 00:06:39', '2025-01-08 00:06:39'),
(1145, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=98', 1, '2025-01-08 00:06:39', '2025-01-08 00:06:39'),
(1146, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=99', 0, '2025-01-08 00:06:40', '2025-01-08 00:06:40'),
(1147, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=99', 0, '2025-01-08 00:06:40', '2025-01-08 00:06:40'),
(1148, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=99', 1, '2025-01-08 00:06:40', '2025-01-08 00:06:40'),
(1149, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=100', 0, '2025-01-08 00:12:57', '2025-01-08 00:12:57'),
(1150, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=100', 0, '2025-01-08 00:12:57', '2025-01-08 00:12:57'),
(1151, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#packageProduct=100', 1, '2025-01-08 00:12:57', '2025-01-08 00:12:57'),
(1152, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=28&packageProduct=101', 0, '2025-01-08 01:07:27', '2025-01-08 01:07:27'),
(1153, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=28&packageProduct=101', 0, '2025-01-08 01:07:27', '2025-01-08 01:07:27'),
(1154, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=28&packageProduct=101', 1, '2025-01-08 01:07:27', '2025-01-08 01:07:27'),
(1155, 3, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=29&packageProduct=102', 0, '2025-01-08 01:07:29', '2025-01-08 01:07:29'),
(1156, 6, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=29&packageProduct=102', 0, '2025-01-08 01:07:29', '2025-01-08 01:07:29'),
(1157, 2, 'SMPL9 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=29&packageProduct=102', 1, '2025-01-08 01:07:29', '2025-01-08 01:07:29'),
(1158, 2, 'SMPL9 CEFIXIME IP 200MG + OFLOXACIN IP 200MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#updatedPurchases=%5B%7B%22id%22%3A73%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 1, '2025-01-08 04:59:58', '2025-01-08 04:59:58'),
(1159, 2, 'SMPL9 CEFIXIME IP 200MG + OFLOXACIN IP 200MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#updatedPurchases=%5B%7B%22id%22%3A73%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 1, '2025-01-08 05:04:31', '2025-01-08 05:04:31'),
(1160, 2, 'SMPL9 CEFIXIME IP 200MG + OFLOXACIN IP 200MG Revised Date Added!!', 'The value expected delivery date updated at!', 'http://127.0.0.1:8000/orders?success=Products purchase updated successfully#updatedPurchases=%5B%7B%22id%22%3A73%2C%22fields%22%3A%5B%22expected_delivery_date%22%5D%7D%5D', 1, '2025-01-08 05:04:46', '2025-01-08 05:04:46'),
(1161, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-08 05:55:35', '2025-01-08 05:55:35'),
(1162, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=38&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 1, '2025-01-08 05:57:01', '2025-01-08 05:57:01'),
(1163, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=38&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 1, '2025-01-08 05:57:26', '2025-01-08 05:57:26'),
(1164, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=38&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 1, '2025-01-08 05:57:46', '2025-01-08 05:57:46'),
(1165, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=38&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 1, '2025-01-08 05:58:28', '2025-01-08 05:58:28'),
(1166, 3, 'SMPL10 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders#products=78', 0, '2025-01-08 06:12:23', '2025-01-08 06:12:23'),
(1167, 6, 'SMPL10 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders#products=78', 0, '2025-01-08 06:12:23', '2025-01-08 06:12:23'),
(1168, 3, 'SMPL10 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders#products=79', 0, '2025-01-08 06:12:23', '2025-01-08 06:12:23'),
(1169, 6, 'SMPL10 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders#products=79', 0, '2025-01-08 06:12:23', '2025-01-08 06:12:23'),
(1170, 3, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products%20purchase%20updated%20successfully#productStocks=64', 0, '2025-01-08 06:13:23', '2025-01-08 06:13:23'),
(1171, 6, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products%20purchase%20updated%20successfully#productStocks=64', 0, '2025-01-08 06:13:23', '2025-01-08 06:13:23'),
(1172, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products%20purchase%20updated%20successfully#productStocks=64', 1, '2025-01-08 06:13:23', '2025-01-08 06:13:23'),
(1173, 3, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products%20purchase%20updated%20successfully#productStocks=65', 0, '2025-01-08 06:13:24', '2025-01-08 06:13:24'),
(1174, 6, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products%20purchase%20updated%20successfully#productStocks=65', 0, '2025-01-08 06:13:24', '2025-01-08 06:13:24'),
(1175, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products%20purchase%20updated%20successfully#productStocks=65', 1, '2025-01-08 06:13:24', '2025-01-08 06:13:24'),
(1176, 3, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=66', 0, '2025-01-08 06:13:52', '2025-01-08 06:13:52'),
(1177, 6, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=66', 0, '2025-01-08 06:13:52', '2025-01-08 06:13:52'),
(1178, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=66', 1, '2025-01-08 06:13:52', '2025-01-08 06:13:52'),
(1179, 3, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=67', 0, '2025-01-08 06:13:53', '2025-01-08 06:13:53'),
(1180, 6, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=67', 0, '2025-01-08 06:13:53', '2025-01-08 06:13:53'),
(1181, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=67', 1, '2025-01-08 06:13:53', '2025-01-08 06:13:53'),
(1182, 3, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=68', 0, '2025-01-08 06:18:00', '2025-01-08 06:18:00'),
(1183, 6, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=68', 0, '2025-01-08 06:18:00', '2025-01-08 06:18:00'),
(1184, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=68', 1, '2025-01-08 06:18:00', '2025-01-08 06:18:00'),
(1185, 3, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=69', 0, '2025-01-08 06:18:05', '2025-01-08 06:18:05'),
(1186, 6, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=69', 0, '2025-01-08 06:18:05', '2025-01-08 06:18:05'),
(1187, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=69', 1, '2025-01-08 06:18:05', '2025-01-08 06:18:05'),
(1188, 3, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=70', 0, '2025-01-08 06:19:32', '2025-01-08 06:19:32'),
(1189, 6, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=70', 0, '2025-01-08 06:19:32', '2025-01-08 06:19:32'),
(1190, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=70', 1, '2025-01-08 06:19:32', '2025-01-08 06:19:32'),
(1191, 3, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=71', 0, '2025-01-08 06:20:05', '2025-01-08 06:20:05'),
(1192, 6, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=71', 0, '2025-01-08 06:20:05', '2025-01-08 06:20:05'),
(1193, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=71', 1, '2025-01-08 06:20:05', '2025-01-08 06:20:05'),
(1194, 3, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=72', 0, '2025-01-08 06:21:41', '2025-01-08 06:21:41'),
(1195, 6, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=72', 0, '2025-01-08 06:21:41', '2025-01-08 06:21:41'),
(1196, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=72', 1, '2025-01-08 06:21:41', '2025-01-08 06:21:41'),
(1197, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-08 06:34:34', '2025-01-08 06:34:34'),
(1198, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-08 06:36:06', '2025-01-08 06:36:06'),
(1199, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-08 06:41:37', '2025-01-08 06:41:37'),
(1200, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-08 06:45:33', '2025-01-08 06:45:33'),
(1201, 3, 'SMPL9 Stock Details Revised!', 'The value manufacturing date updated at!', 'http://127.0.0.1:8000/orders#updatedStocks=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22mfg_date%22%5D%7D%5D', 0, '2025-01-08 22:31:19', '2025-01-08 22:31:19'),
(1202, 6, 'SMPL9 Stock Details Revised!', 'The value manufacturing date updated at!', 'http://127.0.0.1:8000/orders#updatedStocks=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22mfg_date%22%5D%7D%5D', 0, '2025-01-08 22:31:19', '2025-01-08 22:31:19'),
(1203, 2, 'SMPL9 Stock Details Revised!', 'The value manufacturing date updated at!', 'http://127.0.0.1:8000/orders#updatedStocks=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22mfg_date%22%5D%7D%5D', 1, '2025-01-08 22:31:19', '2025-01-08 22:31:19'),
(1204, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-08 22:50:18', '2025-01-08 22:50:18'),
(1205, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-08 22:51:50', '2025-01-08 22:51:50'),
(1206, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-08 22:55:27', '2025-01-08 22:55:27'),
(1207, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-08 22:59:49', '2025-01-08 22:59:49'),
(1208, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-08 23:00:26', '2025-01-08 23:00:26'),
(1209, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-08 23:04:58', '2025-01-08 23:04:58'),
(1210, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-08 23:06:17', '2025-01-08 23:06:17'),
(1211, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-08 23:09:39', '2025-01-08 23:09:39'),
(1212, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-08 23:11:10', '2025-01-08 23:11:10'),
(1213, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-08 23:16:58', '2025-01-08 23:16:58'),
(1214, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-08 23:18:06', '2025-01-08 23:18:06'),
(1215, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 1, '2025-01-08 23:18:55', '2025-01-08 23:18:55'),
(1216, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-08 23:20:11', '2025-01-08 23:20:11'),
(1217, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-08 23:20:35', '2025-01-08 23:20:35'),
(1218, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-08 23:20:51', '2025-01-08 23:20:51'),
(1219, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-08 23:21:00', '2025-01-08 23:21:00'),
(1220, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 1, '2025-01-08 23:21:08', '2025-01-08 23:21:08'),
(1221, 3, 'SMPL9 Order Details Revised!!', 'The value pack quantity, price per set, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-08 23:43:45', '2025-01-08 23:43:45'),
(1222, 6, 'SMPL9 Order Details Revised!!', 'The value pack quantity, price per set, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-08 23:43:45', '2025-01-08 23:43:45'),
(1223, 3, 'SMPL9 Order Details Revised!!', 'The value price per set has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22price_per_set%22%5D%7D%5D', 0, '2025-01-08 23:43:45', '2025-01-08 23:43:45'),
(1224, 6, 'SMPL9 Order Details Revised!!', 'The value price per set has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22price_per_set%22%5D%7D%5D', 0, '2025-01-08 23:43:45', '2025-01-08 23:43:45'),
(1225, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=', 0, '2025-01-08 23:54:06', '2025-01-08 23:54:06'),
(1226, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=', 0, '2025-01-08 23:54:06', '2025-01-08 23:54:06'),
(1227, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=', 0, '2025-01-08 23:54:06', '2025-01-08 23:54:06'),
(1228, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=', 0, '2025-01-08 23:54:06', '2025-01-08 23:54:06'),
(1229, 3, 'SMPL9 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#order=14&fields=Shipping+Cost', 0, '2025-01-09 00:02:38', '2025-01-09 00:02:38'),
(1230, 6, 'SMPL9 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#order=14&fields=Shipping+Cost', 0, '2025-01-09 00:02:38', '2025-01-09 00:02:38'),
(1231, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=80', 0, '2025-01-09 00:36:28', '2025-01-09 00:36:28'),
(1232, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=80', 0, '2025-01-09 00:36:28', '2025-01-09 00:36:28'),
(1233, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=81', 0, '2025-01-09 00:36:29', '2025-01-09 00:36:29'),
(1234, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=81', 0, '2025-01-09 00:36:29', '2025-01-09 00:36:29'),
(1235, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=82', 0, '2025-01-09 00:40:56', '2025-01-09 00:40:56'),
(1236, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=82', 0, '2025-01-09 00:40:56', '2025-01-09 00:40:56'),
(1237, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=83', 0, '2025-01-09 00:40:56', '2025-01-09 00:40:56'),
(1238, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=83', 0, '2025-01-09 00:40:56', '2025-01-09 00:40:56'),
(1239, 3, 'SMPL9 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 0, '2025-01-09 00:44:43', '2025-01-09 00:44:43'),
(1240, 6, 'SMPL9 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 0, '2025-01-09 00:44:43', '2025-01-09 00:44:43'),
(1241, 2, 'SMPL9 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A56%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 1, '2025-01-09 00:44:43', '2025-01-09 00:44:43'),
(1242, 3, 'SMPL9 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 0, '2025-01-09 00:45:04', '2025-01-09 00:45:04'),
(1243, 6, 'SMPL9 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 0, '2025-01-09 00:45:04', '2025-01-09 00:45:04'),
(1244, 2, 'SMPL9 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 1, '2025-01-09 00:45:04', '2025-01-09 00:45:04');
INSERT INTO `notifications` (`id`, `user_id`, `heading`, `content`, `url`, `is_read`, `created_at`, `updated_at`) VALUES
(1245, 3, 'SMPL9 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 0, '2025-01-09 00:46:55', '2025-01-09 00:46:55'),
(1246, 6, 'SMPL9 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 0, '2025-01-09 00:46:55', '2025-01-09 00:46:55'),
(1247, 2, 'SMPL9 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 1, '2025-01-09 00:46:55', '2025-01-09 00:46:55'),
(1248, 3, 'SMPL9 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 0, '2025-01-09 00:49:14', '2025-01-09 00:49:14'),
(1249, 6, 'SMPL9 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 0, '2025-01-09 00:49:14', '2025-01-09 00:49:14'),
(1250, 2, 'SMPL9 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 1, '2025-01-09 00:49:14', '2025-01-09 00:49:14'),
(1251, 3, 'SMPL9 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 0, '2025-01-09 00:54:37', '2025-01-09 00:54:37'),
(1252, 6, 'SMPL9 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 0, '2025-01-09 00:54:37', '2025-01-09 00:54:37'),
(1253, 2, 'SMPL9 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 1, '2025-01-09 00:54:37', '2025-01-09 00:54:37'),
(1254, 3, 'SMPL9 Stock Details Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-09 00:54:57', '2025-01-09 00:54:57'),
(1255, 6, 'SMPL9 Stock Details Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-09 00:54:57', '2025-01-09 00:54:57'),
(1256, 2, 'SMPL9 Stock Details Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#updatedStocks=%5B%7B%22id%22%3A62%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 1, '2025-01-09 00:54:57', '2025-01-09 00:54:57'),
(1257, 3, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=73', 0, '2025-01-09 00:55:25', '2025-01-09 00:55:25'),
(1258, 6, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=73', 0, '2025-01-09 00:55:25', '2025-01-09 00:55:25'),
(1259, 2, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order%20product%20stocks%20updated%20successfully#productStocks=73', 1, '2025-01-09 00:55:25', '2025-01-10 03:26:38'),
(1260, 3, 'SMPL13 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-02#products=86', 0, '2025-01-09 02:25:26', '2025-01-09 02:25:26'),
(1261, 6, 'SMPL13 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-02#products=86', 0, '2025-01-09 02:25:26', '2025-01-09 02:25:26'),
(1262, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders#products=87', 0, '2025-01-09 03:45:48', '2025-01-09 03:45:48'),
(1263, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders#products=87', 0, '2025-01-09 03:45:48', '2025-01-09 03:45:48'),
(1264, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders#products=88', 0, '2025-01-09 03:45:48', '2025-01-09 03:45:48'),
(1265, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders#products=88', 0, '2025-01-09 03:45:48', '2025-01-09 03:45:48'),
(1266, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=89', 0, '2025-01-09 03:46:21', '2025-01-09 03:46:21'),
(1267, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=89', 0, '2025-01-09 03:46:21', '2025-01-09 03:46:21'),
(1268, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=90', 0, '2025-01-09 03:46:21', '2025-01-09 03:46:21'),
(1269, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=90', 0, '2025-01-09 03:46:21', '2025-01-09 03:46:21'),
(1270, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=91', 0, '2025-01-09 03:48:11', '2025-01-09 03:48:11'),
(1271, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=91', 0, '2025-01-09 03:48:11', '2025-01-09 03:48:11'),
(1272, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=92', 0, '2025-01-09 03:48:11', '2025-01-09 03:48:11'),
(1273, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=92', 0, '2025-01-09 03:48:11', '2025-01-09 03:48:11'),
(1274, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=93', 0, '2025-01-09 03:49:01', '2025-01-09 03:49:01'),
(1275, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=93', 0, '2025-01-09 03:49:01', '2025-01-09 03:49:01'),
(1276, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=94', 0, '2025-01-09 03:49:01', '2025-01-09 03:49:01'),
(1277, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=94', 0, '2025-01-09 03:49:01', '2025-01-09 03:49:01'),
(1278, 3, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=95', 0, '2025-01-09 03:58:16', '2025-01-09 03:58:16'),
(1279, 6, 'SMPL9 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#products=95', 0, '2025-01-09 03:58:16', '2025-01-09 03:58:16'),
(1280, 3, 'SMPL9 Order Details Revised!!', 'The value product description, pack size and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2295%22%2C%22fields%22%3A%5B%22product_id%22%2C%22product_variant_id%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 04:00:52', '2025-01-09 04:00:52'),
(1281, 6, 'SMPL9 Order Details Revised!!', 'The value product description, pack size and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2295%22%2C%22fields%22%3A%5B%22product_id%22%2C%22product_variant_id%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 04:00:52', '2025-01-09 04:00:52'),
(1282, 3, 'SMPL9 Order Details Revised!!', 'The value product description, pack size and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2295%22%2C%22fields%22%3A%5B%22product_id%22%2C%22product_variant_id%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 04:44:00', '2025-01-09 04:44:00'),
(1283, 6, 'SMPL9 Order Details Revised!!', 'The value product description, pack size and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2295%22%2C%22fields%22%3A%5B%22product_id%22%2C%22product_variant_id%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 04:44:00', '2025-01-09 04:44:00'),
(1284, 1, 'SMLQ10 ACI FREE (LEMON) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=open', 0, '2025-01-09 04:46:04', '2025-01-09 04:46:04'),
(1285, 3, 'SMPL9 Order Details Revised!!', 'The value pack quantity, price per set, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 05:09:27', '2025-01-09 05:09:27'),
(1286, 6, 'SMPL9 Order Details Revised!!', 'The value pack quantity, price per set, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 05:09:27', '2025-01-09 05:09:27'),
(1287, 3, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 05:12:01', '2025-01-09 05:12:01'),
(1288, 6, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 05:12:01', '2025-01-09 05:12:01'),
(1289, 3, 'SMPL9 Order Details Revised!!', 'The value price per set and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22price_per_set%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 05:44:34', '2025-01-09 05:44:34'),
(1290, 6, 'SMPL9 Order Details Revised!!', 'The value price per set and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22price_per_set%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 05:44:34', '2025-01-09 05:44:34'),
(1291, 3, 'SMPL9 Order Details Revised!!', 'The value pack quantity, price per set, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22price_per_set%22%2C%22updated_at%22%5D%7D%2C%7B%22id%22%3A%2264%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 05:44:34', '2025-01-09 05:44:34'),
(1292, 6, 'SMPL9 Order Details Revised!!', 'The value pack quantity, price per set, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22price_per_set%22%2C%22updated_at%22%5D%7D%2C%7B%22id%22%3A%2264%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 05:44:34', '2025-01-09 05:44:34'),
(1293, 3, 'SMPL9 Order Details Revised!!', 'The value price per set and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22price_per_set%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 05:44:43', '2025-01-09 05:44:43'),
(1294, 6, 'SMPL9 Order Details Revised!!', 'The value price per set and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22price_per_set%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 05:44:43', '2025-01-09 05:44:43'),
(1295, 3, 'SMPL9 Order Details Revised!!', 'The value price per set and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22price_per_set%22%2C%22updated_at%22%5D%7D%2C%7B%22id%22%3A%2264%22%2C%22fields%22%3A%5B%22price_per_set%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 05:44:43', '2025-01-09 05:44:43'),
(1296, 6, 'SMPL9 Order Details Revised!!', 'The value price per set and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22price_per_set%22%2C%22updated_at%22%5D%7D%2C%7B%22id%22%3A%2264%22%2C%22fields%22%3A%5B%22price_per_set%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 05:44:43', '2025-01-09 05:44:43'),
(1297, 3, 'SMPL9 Order Details Revised!!', 'The value pack quantity, price per set, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 05:45:45', '2025-01-09 05:45:45'),
(1298, 6, 'SMPL9 Order Details Revised!!', 'The value pack quantity, price per set, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 05:45:45', '2025-01-09 05:45:45'),
(1299, 3, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 05:47:50', '2025-01-09 05:47:50'),
(1300, 6, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 05:47:50', '2025-01-09 05:47:50'),
(1301, 3, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 05:48:37', '2025-01-09 05:48:37'),
(1302, 6, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2262%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-09 05:48:37', '2025-01-09 05:48:37'),
(1303, 3, 'SMLQ28 DIGUSIL MPS (MINT) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-10 03:41:21', '2025-01-10 03:41:21'),
(1304, 2, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2274%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-10 03:52:27', '2025-01-10 03:52:53'),
(1305, 3, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2274%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-10 03:52:27', '2025-01-10 03:52:27'),
(1306, 6, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2274%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-10 03:52:27', '2025-01-10 03:52:27'),
(1307, 2, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2274%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-10 04:01:49', '2025-01-10 04:02:00'),
(1308, 3, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2274%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-10 04:01:49', '2025-01-10 04:01:49'),
(1309, 6, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2274%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-10 04:01:49', '2025-01-10 04:01:49'),
(1310, 2, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2274%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-10 04:03:45', '2025-01-10 04:03:53'),
(1311, 3, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2274%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-10 04:03:45', '2025-01-10 04:03:45'),
(1312, 6, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2274%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-10 04:03:45', '2025-01-10 04:03:45'),
(1313, 2, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2274%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-10 04:22:09', '2025-01-10 04:22:23'),
(1314, 3, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2274%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-10 04:22:09', '2025-01-10 04:22:09'),
(1315, 6, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2274%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-10 04:22:09', '2025-01-10 04:22:09'),
(1316, 2, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2274%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-10 04:24:20', '2025-01-10 06:06:33'),
(1317, 3, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2274%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-10 04:24:20', '2025-01-10 04:24:20'),
(1318, 6, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2274%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-10 04:24:20', '2025-01-10 04:24:20'),
(1319, 2, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2274%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-10 06:07:20', '2025-01-10 06:07:40'),
(1320, 3, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2274%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-10 06:07:20', '2025-01-10 06:07:20'),
(1321, 6, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2274%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-10 06:07:20', '2025-01-10 06:07:20'),
(1322, 3, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2295%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-10 06:12:31', '2025-01-10 06:12:31'),
(1323, 6, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2295%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-10 06:12:31', '2025-01-10 06:12:31'),
(1324, 3, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2295%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-10 06:13:03', '2025-01-10 06:13:53'),
(1325, 6, 'SMPL9 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2295%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-10 06:13:03', '2025-01-10 06:13:03'),
(1326, 3, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2285%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-10 06:13:19', '2025-01-10 06:13:47'),
(1327, 6, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2285%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-10 06:13:19', '2025-01-10 06:13:19'),
(1328, 2, 'SMLQ13 ETORICOXIB IP 60 MG + THIOCOLCHICOXIB IP 4 MG Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=13&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-20 22:33:39', '2025-01-20 22:33:39'),
(1329, 2, 'SMLQ13 ETORICOXIB IP 60 MG + THIOCOLCHICOXIB IP 4 MG Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-20 22:34:29', '2025-01-20 22:34:29'),
(1330, 2, 'SMLQ13 ETORICOXIB IP 60 MG + THIOCOLCHICOXIB IP 4 MG Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-20 22:34:45', '2025-01-20 22:34:45'),
(1331, 2, 'SMLQ13 ETORICOXIB IP 60 MG + THIOCOLCHICOXIB IP 4 MG Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-20 22:34:54', '2025-01-20 22:34:54'),
(1332, 2, 'SMLQ13 ETORICOXIB IP 60 MG + THIOCOLCHICOXIB IP 4 MG Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-20 22:35:08', '2025-01-20 22:35:08'),
(1333, 2, 'SMLQ13 ETORICOXIB IP 60 MG + THIOCOLCHICOXIB IP 4 MG Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-20 22:35:26', '2025-01-20 22:35:26'),
(1334, 2, 'SMLQ13 ETORICOXIB IP 60 MG + THIOCOLCHICOXIB IP 4 MG Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-20 22:36:52', '2025-01-20 22:36:52'),
(1335, 2, 'SMLQ13 ETORICOXIB IP 60 MG + THIOCOLCHICOXIB IP 4 MG Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 0, '2025-01-20 22:39:16', '2025-01-20 22:39:16'),
(1336, 1, 'SMLQ9 AZOMYCIN 500 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-20 23:15:51', '2025-01-20 23:15:51'),
(1337, 2, 'SMLQ40 MONTECIP BL TABS Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=44&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-21 03:39:27', '2025-01-21 03:39:27'),
(1338, 2, 'SMPL9 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?is_shipment_close=yes&month=2025-01#purchase=74%2C95', 0, '2025-01-21 04:15:56', '2025-01-21 04:15:56'),
(1339, 3, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?is_shipment_close=yes&month=2025-01&success=Products%20purchase%20updated%20successfully#productStocks=74', 0, '2025-01-21 04:16:12', '2025-01-21 04:16:12'),
(1340, 6, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?is_shipment_close=yes&month=2025-01&success=Products%20purchase%20updated%20successfully#productStocks=74', 0, '2025-01-21 04:16:12', '2025-01-21 04:16:12'),
(1341, 2, 'SMPL9 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?is_shipment_close=yes&month=2025-01&success=Products%20purchase%20updated%20successfully#productStocks=74', 0, '2025-01-21 04:16:12', '2025-01-21 04:16:12'),
(1342, 3, 'SMPL9 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?is_shipment_close=yes&month=2025-01&success=Order%20product%20stocks%20updated%20successfully#billing=62', 0, '2025-01-21 04:16:23', '2025-01-21 04:16:23'),
(1343, 6, 'SMPL9 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?is_shipment_close=yes&month=2025-01&success=Order%20product%20stocks%20updated%20successfully#billing=62', 0, '2025-01-21 04:16:23', '2025-01-21 04:16:23'),
(1344, 3, 'SMPL9 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?is_shipment_close=yes&month=2025-01&success=Order%20product%20stocks%20updated%20successfully#billing=62%2C73', 0, '2025-01-21 04:16:23', '2025-01-21 04:16:23'),
(1345, 6, 'SMPL9 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?is_shipment_close=yes&month=2025-01&success=Order%20product%20stocks%20updated%20successfully#billing=62%2C73', 0, '2025-01-21 04:16:23', '2025-01-21 04:16:23'),
(1346, 3, 'SMPL9 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?is_shipment_close=yes&month=2025-01&success=Order%20product%20stocks%20updated%20successfully#billing=74', 0, '2025-01-21 04:16:29', '2025-01-21 04:16:29'),
(1347, 6, 'SMPL9 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?is_shipment_close=yes&month=2025-01&success=Order%20product%20stocks%20updated%20successfully#billing=74', 0, '2025-01-21 04:16:29', '2025-01-21 04:16:29'),
(1348, 2, 'SMLQ40 MONTECIP BL TABS Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-22 04:09:15', '2025-01-22 04:09:15'),
(1349, 2, 'SMLQ40 MONTECIP BL TABS Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 0, '2025-01-22 04:46:50', '2025-01-22 04:46:50'),
(1350, 2, 'SMLQ40 MONTECIP BL TABS Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 0, '2025-01-22 05:22:36', '2025-01-22 05:22:36'),
(1351, 2, 'SMLQ40 MONTECIP BL TABS Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 0, '2025-01-22 05:25:18', '2025-01-22 05:25:18'),
(1352, 2, 'SMLQ40 MONTECIP BL TABS Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 0, '2025-01-22 05:25:37', '2025-01-22 05:25:37'),
(1353, 1, 'SMLQ10 ACI FREE (LEMON) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 0, '2025-01-22 05:28:50', '2025-01-22 05:28:50'),
(1354, 1, 'SMLQ10 ACI FREE (LEMON) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 0, '2025-01-22 05:29:08', '2025-01-22 05:29:08'),
(1355, 2, 'SMLQ40 MONTECIP BL TABS Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-22 06:17:18', '2025-01-22 06:17:18'),
(1356, 2, 'SMLQ40 MONTECIP BL TABS Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-22 23:06:08', '2025-01-22 23:06:08'),
(1357, 3, 'SMLQ28 DIGUSIL MPS (MINT) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-22 23:47:23', '2025-01-22 23:47:23'),
(1358, 3, 'SMLQ28 DIGUSIL MPS (MINT) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-22 23:47:37', '2025-01-22 23:47:37'),
(1359, 6, 'SMPL12 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders#purchase=85', 0, '2025-01-23 00:03:57', '2025-01-23 00:03:57'),
(1360, 2, 'SMPL12 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders#purchase=85', 0, '2025-01-23 00:03:57', '2025-01-23 00:03:57'),
(1361, 3, 'SMPL12 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2025-01#products=98%2C99%2C100%2C101%2C102%2C103%2C104%2C105%2C106%2C107%2C108', 0, '2025-01-23 03:35:52', '2025-01-23 03:35:52'),
(1362, 6, 'SMPL12 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?is_shipment_close=&month=2025-01#products=98%2C99%2C100%2C101%2C102%2C103%2C104%2C105%2C106%2C107%2C108', 0, '2025-01-23 03:35:52', '2025-01-23 03:35:52'),
(1363, 2, 'SMLQ40 MONTECIP BL TABS Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-23 22:48:49', '2025-01-23 22:48:49'),
(1364, 2, 'SMLQ40 MONTECIP BL TABS Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-23 22:50:45', '2025-01-23 22:50:45'),
(1365, 2, 'SMLQ40 MONTECIP BL TABS Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-23 22:58:31', '2025-01-23 22:58:31'),
(1366, 2, 'SMLQ17 CANDESARTAN CILEXTIL Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-24 00:36:13', '2025-01-24 00:36:13'),
(1367, 3, 'SMLQ28 DIGUSIL MPS (MINT) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-24 01:48:35', '2025-01-24 01:48:35'),
(1368, 3, 'SMLQ28 DIGUSIL MPS (MINT) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-24 01:48:49', '2025-01-24 01:48:49'),
(1369, 1, 'SMLQ10 ACI FREE (LEMON) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-24 02:50:04', '2025-01-24 02:50:04'),
(1370, 1, 'SMLQ10 ACI FREE (LEMON) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-24 02:50:04', '2025-01-24 02:50:04'),
(1371, 1, 'SMLQ10 ACI FREE (LEMON) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-24 02:50:41', '2025-01-24 02:50:41'),
(1372, 1, 'SMLQ10 ACI FREE (LEMON) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-24 02:50:41', '2025-01-24 02:50:41'),
(1373, 2, 'SMLQ17 CANDESARTAN CILEXTIL Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-24 04:07:12', '2025-01-24 04:07:12'),
(1374, 2, 'SMLQ17 CANDESARTAN CILEXTIL Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-24 04:07:12', '2025-01-24 04:07:12'),
(1375, 2, 'SMLQ17 CANDESARTAN CILEXTIL Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-24 05:08:29', '2025-01-24 05:08:29'),
(1376, 2, 'SMLQ17 CANDESARTAN CILEXTIL Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-24 05:11:22', '2025-01-24 05:11:22'),
(1377, 2, 'SMLQ39 NBFBDGETTRTY55 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=43&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-24 06:47:07', '2025-01-24 06:47:07'),
(1378, 2, 'SMLQ39 NBFBDGETTRTY55 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-27 23:13:43', '2025-01-27 23:13:43'),
(1379, 2, 'SMLQ39 NBFBDGETTRTY55 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-27 23:17:33', '2025-01-27 23:17:33'),
(1380, 2, 'SMLQ21 GDGDSGD Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-28 00:13:35', '2025-01-28 00:13:35'),
(1381, 2, 'SMLQ21 GDGDSGD Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-28 00:30:53', '2025-01-28 00:30:53'),
(1382, 2, 'SMLQ21 GDGDSGD Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-28 00:57:04', '2025-01-28 00:57:04'),
(1383, 2, 'SMLQ21 GDGDSGD Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-28 01:00:24', '2025-01-28 01:00:24'),
(1384, 3, 'SMLQ26 L QUIN 500 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=26&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-28 01:07:27', '2025-01-28 01:07:27'),
(1385, 3, 'SMLQ26 L QUIN 500 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=26&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-28 01:09:54', '2025-01-28 01:09:54'),
(1386, 2, 'SMLQ17 CANDESARTAN CILEXTIL Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-28 05:16:29', '2025-01-28 05:16:29'),
(1387, 2, 'SMLQ39 NBFBDGETTRTY55 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-28 05:23:19', '2025-01-28 05:23:19'),
(1388, 2, 'SMLQ39 NBFBDGETTRTY55 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-28 05:33:22', '2025-01-28 05:33:22'),
(1389, 2, 'SMLQ39 NBFBDGETTRTY55 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-28 05:33:44', '2025-01-28 05:33:44'),
(1390, 2, 'SMLQ39 NBFBDGETTRTY55 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-28 05:38:50', '2025-01-28 05:38:50'),
(1391, 2, 'SMLQ39 NBFBDGETTRTY55 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-28 05:39:26', '2025-01-28 05:39:26'),
(1392, 2, 'SMLQ39 NBFBDGETTRTY55 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-28 05:40:43', '2025-01-28 05:40:43'),
(1393, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=47&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-28 22:58:39', '2025-01-28 22:58:39'),
(1394, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-29 00:31:40', '2025-01-29 00:31:40'),
(1395, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-29 01:06:41', '2025-01-29 01:06:41'),
(1396, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-29 01:18:48', '2025-01-29 01:18:48'),
(1397, 2, 'SMLQ39 NBFBDGETTRTY55 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-29 01:19:13', '2025-01-29 01:19:13'),
(1398, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-29 01:19:22', '2025-01-29 01:19:22'),
(1399, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-29 01:19:57', '2025-01-29 01:19:57'),
(1400, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-29 01:24:51', '2025-01-29 01:24:51'),
(1401, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-29 01:25:03', '2025-01-29 01:25:03'),
(1402, 2, 'SMLQ39 NBFBDGETTRTY55 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-29 01:32:46', '2025-01-29 01:32:46'),
(1403, 2, 'SMLQ39 NBFBDGETTRTY55 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-29 01:32:58', '2025-01-29 01:32:58'),
(1404, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending', 0, '2025-01-29 06:00:33', '2025-01-29 06:00:33'),
(1405, 2, 'SMLQ42 AYUB1 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=46&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-29 06:34:09', '2025-01-29 06:34:09'),
(1406, 2, 'SMLQ41 AYUDFGHYU Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=45&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-29 06:55:29', '2025-01-29 06:55:29'),
(1407, 2, 'SMLQ41 AYUDFGHYU Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=45&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-29 07:09:40', '2025-01-29 07:09:40'),
(1408, 2, 'SMLQ42 AYUB1 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=46&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-29 07:12:25', '2025-01-29 07:12:25'),
(1409, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=40&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-30 02:27:28', '2025-01-30 02:27:28'),
(1410, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations?perPage=10&status=pending', 0, '2025-01-30 02:49:30', '2025-01-30 02:49:30'),
(1411, 3, 'SMLQ27 HOPESWAN Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=27&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 1, '2025-01-30 07:02:35', '2025-01-31 02:21:55'),
(1412, 2, 'SMLQ44 AYUB3A Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=48&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-30 22:38:26', '2025-01-30 22:38:26'),
(1413, 2, 'SMLQ44 AYUB3A Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=48&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-30 22:50:42', '2025-01-30 22:50:42'),
(1414, 2, 'SMLQ44 AYUB3A Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=48&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations', 0, '2025-01-30 22:57:52', '2025-01-30 22:57:52');
INSERT INTO `notifications` (`id`, `user_id`, `heading`, `content`, `url`, `is_read`, `created_at`, `updated_at`) VALUES
(1415, 3, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%22108%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D&notification_id=1415', 1, '2025-01-30 23:52:16', '2025-01-30 23:56:37'),
(1416, 6, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%22108%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D&notification_id=1416', 1, '2025-01-30 23:52:16', '2025-01-30 23:52:16'),
(1417, 3, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%22108%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D&notification_id=1417', 1, '2025-01-30 23:53:13', '2025-01-30 23:54:06'),
(1418, 6, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%22108%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D&notification_id=1418', 1, '2025-01-30 23:53:14', '2025-01-30 23:53:14'),
(1419, 3, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%22107%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D&notification_id=1419', 1, '2025-01-31 00:14:08', '2025-01-31 00:18:47'),
(1420, 6, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%22107%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D&notification_id=1420', 1, '2025-01-31 00:14:09', '2025-01-31 00:14:09'),
(1421, 3, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%22100%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D&notification_id=1421', 1, '2025-01-31 00:22:26', '2025-01-31 00:30:07'),
(1422, 6, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%22100%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D&notification_id=1422', 1, '2025-01-31 00:22:27', '2025-01-31 00:22:27'),
(1423, 3, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%22106%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D&notification_id=1423', 1, '2025-01-31 00:30:42', '2025-01-31 00:43:46'),
(1424, 6, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%22106%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D&notification_id=1424', 1, '2025-01-31 00:30:43', '2025-01-31 00:30:43'),
(1425, 1, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%22101%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D#notification_id=1425', 0, '2025-01-31 00:49:53', '2025-01-31 00:49:53'),
(1426, 2, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%22101%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D#notification_id=1426', 1, '2025-01-31 00:49:55', '2025-01-31 01:08:25'),
(1427, 3, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%22101%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D#notification_id=1427', 1, '2025-01-31 00:49:56', '2025-01-31 01:08:08'),
(1428, 5, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%22101%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D#notification_id=1428', 0, '2025-01-31 00:49:56', '2025-01-31 00:49:56'),
(1429, 6, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%22101%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D#notification_id=1429', 0, '2025-01-31 00:49:57', '2025-01-31 00:49:57'),
(1430, 1, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%22106%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D&notification_id=1430', 0, '2025-01-31 00:58:37', '2025-01-31 00:58:37'),
(1431, 2, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%22106%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D&notification_id=1431', 1, '2025-01-31 00:58:37', '2025-01-31 01:08:20'),
(1432, 3, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%22106%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D&notification_id=1432', 1, '2025-01-31 00:58:38', '2025-01-31 01:08:00'),
(1433, 5, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%22106%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D&notification_id=1433', 0, '2025-01-31 00:58:39', '2025-01-31 00:58:39'),
(1434, 6, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%22106%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D&notification_id=1434', 0, '2025-01-31 00:58:39', '2025-01-31 00:58:39'),
(1435, 1, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1435#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 01:08:40', '2025-01-31 01:08:40'),
(1436, 2, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1436#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-31 01:08:40', '2025-01-31 03:20:02'),
(1437, 3, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1437#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-31 01:08:41', '2025-01-31 01:10:33'),
(1438, 5, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1438#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 01:08:42', '2025-01-31 01:08:42'),
(1439, 6, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1439#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-31 01:08:42', '2025-01-31 01:08:50'),
(1440, 1, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.18000/orders?notification_id=1440#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:11:46', '2025-01-31 02:11:46'),
(1441, 2, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.18000/orders?notification_id=1441#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-31 02:11:46', '2025-01-31 03:19:57'),
(1442, 3, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.18000/orders?notification_id=1442#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-31 02:11:46', '2025-01-31 02:21:50'),
(1443, 5, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.18000/orders?notification_id=1443#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:11:46', '2025-01-31 02:11:46'),
(1444, 6, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.18000/orders?notification_id=1444#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:11:46', '2025-01-31 02:11:46'),
(1445, 1, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.18000/orders?notification_id=1445#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:16:16', '2025-01-31 02:16:16'),
(1446, 2, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.18000/orders?notification_id=1446#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-31 02:16:16', '2025-01-31 02:24:37'),
(1447, 3, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.18000/orders?notification_id=1447#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-31 02:16:16', '2025-01-31 02:21:46'),
(1448, 5, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.18000/orders?notification_id=1448#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:16:16', '2025-01-31 02:16:16'),
(1449, 6, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.18000/orders?notification_id=1449#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:16:16', '2025-01-31 02:16:16'),
(1450, 1, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.18000/orders?notification_id=1450#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:23:27', '2025-01-31 02:23:27'),
(1451, 2, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.18000/orders?notification_id=1451#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-31 02:23:27', '2025-01-31 02:24:14'),
(1452, 3, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.18000/orders?notification_id=1452#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:23:27', '2025-01-31 02:23:27'),
(1453, 5, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.18000/orders?notification_id=1453#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:23:27', '2025-01-31 02:23:27'),
(1454, 6, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.18000/orders?notification_id=1454#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:23:27', '2025-01-31 02:23:27'),
(1455, 1, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1455#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-31 02:24:54', '2025-01-31 02:24:57'),
(1456, 2, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1456#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-31 02:24:54', '2025-01-31 02:25:20'),
(1457, 3, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1457#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:24:54', '2025-01-31 02:24:54'),
(1458, 5, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1458#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:24:54', '2025-01-31 02:24:54'),
(1459, 6, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1459#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:24:54', '2025-01-31 02:24:54'),
(1460, 1, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:45:27', '2025-01-31 02:45:27'),
(1461, 2, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-31 02:45:27', '2025-01-31 03:19:54'),
(1462, 3, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:45:27', '2025-01-31 02:45:27'),
(1463, 5, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:45:27', '2025-01-31 02:45:27'),
(1464, 6, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:45:27', '2025-01-31 02:45:27'),
(1465, 1, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:49:50', '2025-01-31 02:49:50'),
(1466, 2, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-31 02:49:50', '2025-01-31 03:19:50'),
(1467, 3, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:49:50', '2025-01-31 02:49:50'),
(1468, 5, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:49:50', '2025-01-31 02:49:50'),
(1469, 6, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 02:49:50', '2025-01-31 02:49:50'),
(1470, 1, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%22107%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 03:04:25', '2025-01-31 03:04:25'),
(1471, 2, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%22107%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-31 03:04:25', '2025-01-31 03:19:47'),
(1472, 3, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%22107%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 03:04:25', '2025-01-31 03:04:25'),
(1473, 5, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%22107%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 03:04:25', '2025-01-31 03:04:25'),
(1474, 6, 'SMPL12 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%22107%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 03:04:25', '2025-01-31 03:04:25'),
(1475, 1, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 03:05:13', '2025-01-31 03:05:13'),
(1476, 1, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1476#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-31 03:05:35', '2025-01-31 03:05:45'),
(1477, 2, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1477#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-31 03:05:35', '2025-01-31 03:19:43'),
(1478, 3, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1478#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 03:05:35', '2025-01-31 03:05:35'),
(1479, 5, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1479#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 03:05:35', '2025-01-31 03:05:35'),
(1480, 6, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1480#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 03:05:35', '2025-01-31 03:05:35'),
(1481, 1, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order%20products%20updated%20successfully#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 03:12:23', '2025-01-31 03:12:23'),
(1482, 1, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1482#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 03:12:50', '2025-01-31 03:12:50'),
(1483, 2, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1483#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-31 03:12:50', '2025-01-31 03:12:57'),
(1484, 3, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1484#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-31 03:12:50', '2025-01-31 03:13:02'),
(1485, 5, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1485#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 03:12:50', '2025-01-31 03:12:50'),
(1486, 6, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1486#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 03:12:50', '2025-01-31 03:12:50'),
(1487, 1, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1487#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 03:20:20', '2025-01-31 03:20:20'),
(1488, 2, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1488#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-31 03:20:20', '2025-01-31 03:20:34'),
(1489, 3, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1489#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-31 03:20:20', '2025-01-31 03:20:32'),
(1490, 5, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1490#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 03:20:20', '2025-01-31 03:20:20'),
(1491, 6, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1491#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 03:20:20', '2025-01-31 03:20:20'),
(1492, 1, 'SMPL13 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1492#order=18&fields=Shipping+Cost', 0, '2025-01-31 03:20:57', '2025-01-31 03:20:57'),
(1493, 2, 'SMPL13 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1493#order=18&fields=Shipping+Cost', 0, '2025-01-31 03:20:57', '2025-01-31 03:20:57'),
(1494, 5, 'SMPL13 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1494#order=18&fields=Shipping+Cost', 0, '2025-01-31 03:20:57', '2025-01-31 03:20:57'),
(1495, 6, 'SMPL13 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1495#order=18&fields=Shipping+Cost', 0, '2025-01-31 03:20:57', '2025-01-31 03:20:57'),
(1496, 1, 'SMPL13 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1496#order=18&fields=Shipping+Cost', 0, '2025-01-31 03:21:41', '2025-01-31 03:21:41'),
(1497, 2, 'SMPL13 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1497#order=18&fields=Shipping+Cost', 0, '2025-01-31 03:21:41', '2025-01-31 03:21:41'),
(1498, 5, 'SMPL13 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1498#order=18&fields=Shipping+Cost', 0, '2025-01-31 03:21:41', '2025-01-31 03:21:41'),
(1499, 6, 'SMPL13 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1499#order=18&fields=Shipping+Cost', 0, '2025-01-31 03:21:41', '2025-01-31 03:21:41'),
(1500, 1, 'SMPL13 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1500#order=18&fields=Shipping+Cost', 0, '2025-01-31 03:22:51', '2025-01-31 03:22:51'),
(1501, 2, 'SMPL13 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1501#order=18&fields=Shipping+Cost', 1, '2025-01-31 03:22:51', '2025-01-31 03:22:58'),
(1502, 5, 'SMPL13 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1502#order=18&fields=Shipping+Cost', 0, '2025-01-31 03:22:51', '2025-01-31 03:22:51'),
(1503, 6, 'SMPL13 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1503#order=18&fields=Shipping+Cost', 0, '2025-01-31 03:22:51', '2025-01-31 03:22:51'),
(1504, 1, 'SMPL13 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1504#order=18&fields=Shipping+Cost', 0, '2025-01-31 04:02:34', '2025-01-31 04:02:34'),
(1505, 2, 'SMPL13 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1505#order=18&fields=Shipping+Cost', 1, '2025-01-31 04:02:34', '2025-01-31 04:04:29'),
(1506, 5, 'SMPL13 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1506#order=18&fields=Shipping+Cost', 0, '2025-01-31 04:02:34', '2025-01-31 04:02:34'),
(1507, 6, 'SMPL13 Shipping Cost Added!!', 'The shipping cost have been added!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1507#order=18&fields=Shipping+Cost', 0, '2025-01-31 04:02:34', '2025-01-31 04:02:34'),
(1508, 1, 'SMPL12 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?notification_id=1508#purchase=98', 0, '2025-01-31 04:13:00', '2025-01-31 04:13:00'),
(1509, 2, 'SMPL12 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?notification_id=1509#purchase=98', 0, '2025-01-31 04:13:00', '2025-01-31 04:13:00'),
(1510, 5, 'SMPL12 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?notification_id=1510#purchase=98', 0, '2025-01-31 04:13:00', '2025-01-31 04:13:00'),
(1511, 2, 'SMPL12 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?notification_id=1511#purchase=98', 1, '2025-01-31 04:13:00', '2025-01-31 04:13:03'),
(1512, 3, 'SMPL12 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1512#productStocks=75', 1, '2025-01-31 04:17:53', '2025-01-31 04:18:29'),
(1513, 6, 'SMPL12 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1513#productStocks=75', 0, '2025-01-31 04:17:53', '2025-01-31 04:17:53'),
(1514, 2, 'SMPL12 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1514#productStocks=75', 1, '2025-01-31 04:17:53', '2025-01-31 04:17:59'),
(1515, 3, 'SMPL12 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1515#billing=75', 1, '2025-01-31 04:21:37', '2025-01-31 04:21:42'),
(1516, 6, 'SMPL12 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1516#billing=75', 0, '2025-01-31 04:21:37', '2025-01-31 04:21:37'),
(1517, 6, 'SMPL12 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1517#package=32&packageProduct=103', 0, '2025-01-31 04:24:06', '2025-01-31 04:24:06'),
(1518, 2, 'SMPL12 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1518#package=32&packageProduct=103', 1, '2025-01-31 04:24:06', '2025-01-31 04:24:10'),
(1519, 6, 'SMPL12 Packing List Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1519#updatedPackages=%5B%7B%22id%22%3A32%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A103%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-01-31 04:24:34', '2025-01-31 04:24:34'),
(1520, 2, 'SMPL12 Packing List Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1520#updatedPackages=%5B%7B%22id%22%3A32%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A103%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 1, '2025-01-31 04:24:34', '2025-01-31 04:24:38'),
(1521, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Query Resolved!!', 'Mission accomplished!', 'http://127.0.0.1:8000/quotations/145?redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations%253FperPage%253D10%2526search%253D%2526status%253Dclose&notification_id=1521', 1, '2025-01-31 04:28:00', '2025-01-31 04:28:06'),
(1522, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending&notification_id=1522', 1, '2025-01-31 04:29:49', '2025-01-31 04:29:54'),
(1523, 6, 'SMPL12 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1523#packageProduct=104%2C105', 0, '2025-01-31 04:53:45', '2025-01-31 04:53:45'),
(1524, 2, 'SMPL12 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1524#packageProduct=104%2C105', 0, '2025-01-31 04:53:45', '2025-01-31 04:53:45'),
(1525, 6, 'SMPL12 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1525#packageProduct=106', 0, '2025-01-31 05:05:52', '2025-01-31 05:05:52'),
(1526, 2, 'SMPL12 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1526#packageProduct=106', 0, '2025-01-31 05:05:52', '2025-01-31 05:05:52'),
(1527, 6, 'SMPL12 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1527#package=33&packageProduct=107', 0, '2025-01-31 05:06:56', '2025-01-31 05:06:56'),
(1528, 2, 'SMPL12 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1528#package=33&packageProduct=107', 1, '2025-01-31 05:06:56', '2025-01-31 05:06:59'),
(1529, 3, 'SMPL16 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-02&notification_id=1529#products=109', 0, '2025-01-31 05:27:27', '2025-01-31 05:27:27'),
(1530, 6, 'SMPL16 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-02&notification_id=1530#products=109', 0, '2025-01-31 05:27:27', '2025-01-31 05:27:27'),
(1531, 3, 'SMPL17 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-02&notification_id=1531#products=110', 0, '2025-01-31 05:31:34', '2025-01-31 05:31:34'),
(1532, 6, 'SMPL17 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-02&notification_id=1532#products=110', 0, '2025-01-31 05:31:34', '2025-01-31 05:31:34'),
(1533, 3, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?notification_id=1533#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 06:44:46', '2025-01-31 06:44:46'),
(1534, 6, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?notification_id=1534#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 06:44:46', '2025-01-31 06:44:46'),
(1535, 1, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?notification_id=1535#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 06:45:10', '2025-01-31 06:45:10'),
(1536, 2, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?notification_id=1536#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 1, '2025-01-31 06:45:10', '2025-01-31 06:45:20'),
(1537, 3, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?notification_id=1537#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 06:45:10', '2025-01-31 06:45:10'),
(1538, 5, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?notification_id=1538#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 06:45:10', '2025-01-31 06:45:10'),
(1539, 6, 'SMPL13 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?notification_id=1539#updatedProducts=%5B%7B%22id%22%3A%2286%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-01-31 06:45:10', '2025-01-31 06:45:10'),
(1540, 1, 'SMPL18 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-01&notification_id=1540#products=111', 0, '2025-01-31 06:51:03', '2025-01-31 06:51:03'),
(1541, 2, 'SMPL18 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-01&notification_id=1541#products=111', 0, '2025-01-31 06:51:03', '2025-01-31 06:51:03'),
(1542, 3, 'SMPL18 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-01&notification_id=1542#products=111', 0, '2025-01-31 06:51:03', '2025-01-31 06:51:03'),
(1543, 5, 'SMPL18 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-01&notification_id=1543#products=111', 0, '2025-01-31 06:51:03', '2025-01-31 06:51:03'),
(1544, 6, 'SMPL18 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-01&notification_id=1544#products=111', 0, '2025-01-31 06:51:03', '2025-01-31 06:51:03'),
(1545, 2, 'SMLQ44 AYUB3A Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=48&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1545', 0, '2025-02-02 23:53:31', '2025-02-02 23:53:31'),
(1546, 2, 'SMPL10 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?notification_id=1546#purchase=78', 0, '2025-02-03 01:04:19', '2025-02-03 01:04:19'),
(1547, 1, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1547#productStocks=76', 0, '2025-02-03 01:04:34', '2025-02-03 01:04:34'),
(1548, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1548#productStocks=76', 0, '2025-02-03 01:04:34', '2025-02-03 01:04:34'),
(1549, 3, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1549#productStocks=76', 0, '2025-02-03 01:04:34', '2025-02-03 01:04:34'),
(1550, 5, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1550#productStocks=76', 0, '2025-02-03 01:04:34', '2025-02-03 01:04:34'),
(1551, 6, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1551#productStocks=76', 0, '2025-02-03 01:04:34', '2025-02-03 01:04:34'),
(1552, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1552#productStocks=76', 0, '2025-02-03 01:04:34', '2025-02-03 01:04:34'),
(1553, 1, 'SMPL19 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-02&notification_id=1553#products=112', 0, '2025-02-03 01:28:37', '2025-02-03 01:28:37'),
(1554, 2, 'SMPL19 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-02&notification_id=1554#products=112', 0, '2025-02-03 01:28:37', '2025-02-03 01:28:37'),
(1555, 3, 'SMPL19 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-02&notification_id=1555#products=112', 0, '2025-02-03 01:28:37', '2025-02-03 01:28:37'),
(1556, 5, 'SMPL19 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-02&notification_id=1556#products=112', 0, '2025-02-03 01:28:37', '2025-02-03 01:28:37'),
(1557, 6, 'SMPL19 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-02&notification_id=1557#products=112', 0, '2025-02-03 01:28:37', '2025-02-03 01:28:37'),
(1558, 1, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?month=2025-02&success=Order+products+created+successfully&notification_id=1558#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 01:28:49', '2025-02-03 01:28:49'),
(1559, 2, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?month=2025-02&success=Order+products+created+successfully&notification_id=1559#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 01:28:49', '2025-02-03 01:28:49'),
(1560, 3, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?month=2025-02&success=Order+products+created+successfully&notification_id=1560#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 01:28:49', '2025-02-03 01:28:49'),
(1561, 5, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?month=2025-02&success=Order+products+created+successfully&notification_id=1561#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 01:28:49', '2025-02-03 01:28:49'),
(1562, 6, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?month=2025-02&success=Order+products+created+successfully&notification_id=1562#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 01:28:49', '2025-02-03 01:28:49'),
(1563, 1, 'SMPL19 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1563#products=113', 0, '2025-02-03 06:02:36', '2025-02-03 06:02:36'),
(1564, 2, 'SMPL19 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1564#products=113', 0, '2025-02-03 06:02:36', '2025-02-03 06:02:36'),
(1565, 3, 'SMPL19 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1565#products=113', 0, '2025-02-03 06:02:36', '2025-02-03 06:02:36'),
(1566, 5, 'SMPL19 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1566#products=113', 0, '2025-02-03 06:02:36', '2025-02-03 06:02:36'),
(1567, 6, 'SMPL19 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1567#products=113', 0, '2025-02-03 06:02:36', '2025-02-03 06:02:36'),
(1568, 1, 'SMPL19 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1568#products=114', 0, '2025-02-03 06:23:53', '2025-02-03 06:23:53'),
(1569, 2, 'SMPL19 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1569#products=114', 0, '2025-02-03 06:23:53', '2025-02-03 06:23:53'),
(1570, 3, 'SMPL19 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1570#products=114', 0, '2025-02-03 06:23:53', '2025-02-03 06:23:53'),
(1571, 5, 'SMPL19 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1571#products=114', 0, '2025-02-03 06:23:53', '2025-02-03 06:23:53'),
(1572, 6, 'SMPL19 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1572#products=114', 0, '2025-02-03 06:23:53', '2025-02-03 06:23:53'),
(1573, 1, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1573#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:23:53', '2025-02-03 06:23:53');
INSERT INTO `notifications` (`id`, `user_id`, `heading`, `content`, `url`, `is_read`, `created_at`, `updated_at`) VALUES
(1574, 2, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1574#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:23:53', '2025-02-03 06:23:53'),
(1575, 3, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1575#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:23:53', '2025-02-03 06:23:53'),
(1576, 5, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1576#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:23:53', '2025-02-03 06:23:53'),
(1577, 6, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1577#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:23:53', '2025-02-03 06:23:53'),
(1578, 1, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1578#updatedProducts=%5B%7B%22id%22%3A%22113%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:24:04', '2025-02-03 06:24:04'),
(1579, 2, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1579#updatedProducts=%5B%7B%22id%22%3A%22113%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:24:04', '2025-02-03 06:24:04'),
(1580, 3, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1580#updatedProducts=%5B%7B%22id%22%3A%22113%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:24:04', '2025-02-03 06:24:04'),
(1581, 5, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1581#updatedProducts=%5B%7B%22id%22%3A%22113%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:24:04', '2025-02-03 06:24:04'),
(1582, 6, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1582#updatedProducts=%5B%7B%22id%22%3A%22113%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:24:04', '2025-02-03 06:24:04'),
(1583, 1, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1583#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:27:27', '2025-02-03 06:27:27'),
(1584, 2, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1584#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:27:27', '2025-02-03 06:27:27'),
(1585, 3, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1585#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:27:27', '2025-02-03 06:27:27'),
(1586, 5, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1586#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:27:27', '2025-02-03 06:27:27'),
(1587, 6, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1587#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:27:27', '2025-02-03 06:27:27'),
(1588, 1, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1588#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:31:13', '2025-02-03 06:31:13'),
(1589, 2, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1589#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:31:13', '2025-02-03 06:31:13'),
(1590, 3, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1590#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:31:13', '2025-02-03 06:31:13'),
(1591, 5, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1591#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:31:13', '2025-02-03 06:31:13'),
(1592, 6, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1592#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:31:13', '2025-02-03 06:31:13'),
(1593, 1, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1593#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:37:00', '2025-02-03 06:37:00'),
(1594, 2, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1594#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:37:00', '2025-02-03 06:37:00'),
(1595, 3, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1595#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:37:00', '2025-02-03 06:37:00'),
(1596, 5, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1596#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:37:00', '2025-02-03 06:37:00'),
(1597, 6, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1597#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:37:00', '2025-02-03 06:37:00'),
(1598, 1, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1598#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:39:28', '2025-02-03 06:39:28'),
(1599, 2, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1599#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:39:28', '2025-02-03 06:39:28'),
(1600, 3, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1600#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:39:28', '2025-02-03 06:39:28'),
(1601, 5, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1601#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:39:28', '2025-02-03 06:39:28'),
(1602, 6, 'SMPL19 Order Details Revised!!', 'The value pack quantity, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1602#updatedProducts=%5B%7B%22id%22%3A%22112%22%2C%22fields%22%3A%5B%22quantity%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-03 06:39:28', '2025-02-03 06:39:28'),
(1603, 1, 'SMPL21 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-02&notification_id=1603#products=115', 0, '2025-02-03 21:50:46', '2025-02-03 21:50:46'),
(1604, 2, 'SMPL21 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-02&notification_id=1604#products=115', 0, '2025-02-03 21:50:46', '2025-02-03 21:50:46'),
(1605, 3, 'SMPL21 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-02&notification_id=1605#products=115', 0, '2025-02-03 21:50:46', '2025-02-03 21:50:46'),
(1606, 5, 'SMPL21 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-02&notification_id=1606#products=115', 0, '2025-02-03 21:50:46', '2025-02-03 21:50:46'),
(1607, 6, 'SMPL21 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?month=2025-02&notification_id=1607#products=115', 0, '2025-02-03 21:50:46', '2025-02-03 21:50:46'),
(1608, 1, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?notification_id=1608#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:22:28', '2025-02-03 22:22:28'),
(1609, 2, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?notification_id=1609#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:22:28', '2025-02-03 22:22:28'),
(1610, 3, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?notification_id=1610#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:22:28', '2025-02-03 22:22:28'),
(1611, 5, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?notification_id=1611#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:22:28', '2025-02-03 22:22:28'),
(1612, 6, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?notification_id=1612#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:22:28', '2025-02-03 22:22:28'),
(1613, 2, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?notification_id=1613#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:22:28', '2025-02-03 22:22:28'),
(1614, 1, 'SMPL10 Stock Details Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1614#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:22:42', '2025-02-03 22:22:42'),
(1615, 2, 'SMPL10 Stock Details Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1615#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:22:42', '2025-02-03 22:22:42'),
(1616, 3, 'SMPL10 Stock Details Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1616#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:22:42', '2025-02-03 22:22:42'),
(1617, 5, 'SMPL10 Stock Details Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1617#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:22:42', '2025-02-03 22:22:42'),
(1618, 6, 'SMPL10 Stock Details Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1618#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:22:42', '2025-02-03 22:22:42'),
(1619, 2, 'SMPL10 Stock Details Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1619#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:22:42', '2025-02-03 22:22:42'),
(1620, 1, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1620#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:23:56', '2025-02-03 22:23:56'),
(1621, 2, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1621#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:23:56', '2025-02-03 22:23:56'),
(1622, 3, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1622#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:23:56', '2025-02-03 22:23:56'),
(1623, 5, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1623#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:23:56', '2025-02-03 22:23:56'),
(1624, 6, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1624#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:23:56', '2025-02-03 22:23:56'),
(1625, 2, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1625#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:23:56', '2025-02-03 22:23:56'),
(1626, 1, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1626#productStocks=77', 0, '2025-02-03 22:24:10', '2025-02-03 22:24:10'),
(1627, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1627#productStocks=77', 0, '2025-02-03 22:24:10', '2025-02-03 22:24:10'),
(1628, 3, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1628#productStocks=77', 0, '2025-02-03 22:24:10', '2025-02-03 22:24:10'),
(1629, 5, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1629#productStocks=77', 0, '2025-02-03 22:24:10', '2025-02-03 22:24:10'),
(1630, 6, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1630#productStocks=77', 0, '2025-02-03 22:24:10', '2025-02-03 22:24:10'),
(1631, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1631#productStocks=77', 0, '2025-02-03 22:24:10', '2025-02-03 22:24:10'),
(1632, 1, 'SMPL10 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1632#updatedStocks=%5B%7B%22id%22%3A77%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 0, '2025-02-03 22:24:21', '2025-02-03 22:24:21'),
(1633, 2, 'SMPL10 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1633#updatedStocks=%5B%7B%22id%22%3A77%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 0, '2025-02-03 22:24:21', '2025-02-03 22:24:21'),
(1634, 3, 'SMPL10 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1634#updatedStocks=%5B%7B%22id%22%3A77%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 0, '2025-02-03 22:24:21', '2025-02-03 22:24:21'),
(1635, 5, 'SMPL10 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1635#updatedStocks=%5B%7B%22id%22%3A77%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 0, '2025-02-03 22:24:21', '2025-02-03 22:24:21'),
(1636, 6, 'SMPL10 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1636#updatedStocks=%5B%7B%22id%22%3A77%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 0, '2025-02-03 22:24:21', '2025-02-03 22:24:21'),
(1637, 2, 'SMPL10 Stock Details Revised!', 'The value batch number updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1637#updatedStocks=%5B%7B%22id%22%3A77%2C%22fields%22%3A%5B%22batch_no%22%5D%7D%5D', 0, '2025-02-03 22:24:21', '2025-02-03 22:24:21'),
(1638, 1, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1638#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A77%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:35:35', '2025-02-03 22:35:35'),
(1639, 2, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1639#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A77%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:35:35', '2025-02-03 22:35:35'),
(1640, 3, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1640#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A77%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:35:35', '2025-02-03 22:35:35'),
(1641, 5, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1641#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A77%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:35:35', '2025-02-03 22:35:35'),
(1642, 6, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1642#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A77%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:35:35', '2025-02-03 22:35:35'),
(1643, 2, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1643#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%2C%7B%22id%22%3A77%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:35:35', '2025-02-03 22:35:35'),
(1644, 1, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1644#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:36:10', '2025-02-03 22:36:10'),
(1645, 2, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1645#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:36:11', '2025-02-03 22:36:11'),
(1646, 3, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1646#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:36:11', '2025-02-03 22:36:11'),
(1647, 5, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1647#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:36:11', '2025-02-03 22:36:11'),
(1648, 6, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1648#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:36:11', '2025-02-03 22:36:11'),
(1649, 2, 'SMPL10 Stock Details Revised!', 'The value batch number and quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1649#updatedStocks=%5B%7B%22id%22%3A76%2C%22fields%22%3A%5B%22batch_no%22%2C%22quantity%22%5D%7D%5D', 0, '2025-02-03 22:36:11', '2025-02-03 22:36:11'),
(1650, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1650#package=34&packageProduct=108', 0, '2025-02-03 23:09:11', '2025-02-03 23:09:11'),
(1651, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1651#package=34&packageProduct=108', 0, '2025-02-03 23:09:11', '2025-02-03 23:09:11'),
(1652, 6, 'SMPL10 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1652#updatedPackages=%5B%7B%22id%22%3A34%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A108%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-02-04 01:19:26', '2025-02-04 01:19:26'),
(1653, 2, 'SMPL10 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1653#updatedPackages=%5B%7B%22id%22%3A34%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A108%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-02-04 01:19:26', '2025-02-04 01:19:26'),
(1654, 6, 'SMPL10 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1654#updatedPackages=%5B%7B%22id%22%3A34%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A108%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-02-04 01:19:39', '2025-02-04 01:19:39'),
(1655, 2, 'SMPL10 Packing List Revised!', 'The value dimension updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1655#updatedPackages=%5B%7B%22id%22%3A34%2C%22fields%22%3A%5B%22dimension%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A108%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-02-04 01:19:39', '2025-02-04 01:19:39'),
(1656, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1656#package=38&packageProduct=109%2C110', 0, '2025-02-04 03:39:18', '2025-02-04 03:39:18'),
(1657, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1657#package=38&packageProduct=109%2C110', 0, '2025-02-04 03:39:18', '2025-02-04 03:39:18'),
(1658, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1658#package=39&packageProduct=111%2C112%2C113', 0, '2025-02-04 03:49:53', '2025-02-04 03:49:53'),
(1659, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1659#package=39&packageProduct=111%2C112%2C113', 0, '2025-02-04 03:49:53', '2025-02-04 03:49:53'),
(1660, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1660#package=40&packageProduct=114%2C115%2C116', 0, '2025-02-04 03:50:35', '2025-02-04 03:50:35'),
(1661, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1661#package=40&packageProduct=114%2C115%2C116', 0, '2025-02-04 03:50:35', '2025-02-04 03:50:35'),
(1662, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1662#package=41&packageProduct=117', 0, '2025-02-04 03:52:04', '2025-02-04 03:52:04'),
(1663, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1663#package=41&packageProduct=117', 0, '2025-02-04 03:52:04', '2025-02-04 03:52:04'),
(1664, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1664#package=42&packageProduct=118%2C119', 0, '2025-02-04 03:52:48', '2025-02-04 03:52:48'),
(1665, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1665#package=42&packageProduct=118%2C119', 0, '2025-02-04 03:52:48', '2025-02-04 03:52:48'),
(1666, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1666#packageProduct=120', 0, '2025-02-04 03:52:49', '2025-02-04 03:52:49'),
(1667, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1667#packageProduct=120', 0, '2025-02-04 03:52:49', '2025-02-04 03:52:49'),
(1668, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1668#packageProduct=121', 0, '2025-02-04 03:54:04', '2025-02-04 03:54:04'),
(1669, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1669#packageProduct=121', 0, '2025-02-04 03:54:04', '2025-02-04 03:54:04'),
(1670, 1, 'SMLQ45 Inquiry created', 'Let\'s hope the answer is better than our Wi-Fi signal!!', 'http://127.0.0.1:8000/inquires', 0, '2025-02-04 05:23:47', '2025-02-04 05:23:47'),
(1671, 2, 'SMLQ45 Inquiry created', 'Let\'s hope the answer is better than our Wi-Fi signal!!', 'http://127.0.0.1:8000/inquires', 0, '2025-02-04 05:23:47', '2025-02-04 05:23:47'),
(1672, 3, 'SMLQ45 Inquiry created', 'Let\'s hope the answer is better than our Wi-Fi signal!!', 'http://127.0.0.1:8000/inquires', 0, '2025-02-04 05:23:47', '2025-02-04 05:23:47'),
(1673, 5, 'SMLQ45 Inquiry created', 'Let\'s hope the answer is better than our Wi-Fi signal!!', 'http://127.0.0.1:8000/inquires', 0, '2025-02-04 05:23:47', '2025-02-04 05:23:47'),
(1674, 2, 'SMLQ33 CALCITRIOL CAPSULE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=37&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1674', 0, '2025-02-04 22:34:50', '2025-02-04 22:34:50'),
(1675, 2, 'SMLQ34 CANDESARTAN CILEXETIL-HYDROCHLOROTHIAZIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=38&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1675', 0, '2025-02-04 22:35:39', '2025-02-04 22:35:39'),
(1676, 3, 'SMLQ23 BICALUTAMIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=23&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1676', 0, '2025-02-04 22:45:58', '2025-02-04 22:45:58'),
(1677, 3, 'SMLQ23 BICALUTAMIDE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=23&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1677', 0, '2025-02-04 22:47:06', '2025-02-04 22:47:06'),
(1678, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending&notification_id=1678', 0, '2025-02-04 22:58:08', '2025-02-04 22:58:08'),
(1679, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending&notification_id=1679', 0, '2025-02-04 22:58:08', '2025-02-04 22:58:08'),
(1680, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending&notification_id=1680', 0, '2025-02-04 22:58:08', '2025-02-04 22:58:08'),
(1681, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending&notification_id=1681', 0, '2025-02-04 22:58:08', '2025-02-04 22:58:08'),
(1682, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending&notification_id=1682', 0, '2025-02-04 22:58:08', '2025-02-04 22:58:08'),
(1683, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending&notification_id=1683', 0, '2025-02-04 22:58:09', '2025-02-04 22:58:09'),
(1684, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending&notification_id=1684', 0, '2025-02-04 23:07:48', '2025-02-04 23:07:48'),
(1685, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending&notification_id=1685', 0, '2025-02-04 23:08:11', '2025-02-04 23:08:11'),
(1686, 2, 'SMLQ36 AASSSSQSQSWSDQ555 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=40&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1686', 0, '2025-02-04 23:09:17', '2025-02-04 23:09:17'),
(1687, 6, 'SMPL10 Packing List Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1687#updatedPackages=%5B%7B%22id%22%3A42%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A119%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-02-05 02:46:13', '2025-02-05 02:46:13'),
(1688, 2, 'SMPL10 Packing List Revised!', 'The value quantity updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1688#updatedPackages=%5B%7B%22id%22%3A42%2C%22fields%22%3A%5B%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A119%2C%22fields%22%3A%5B%22quantity%22%5D%7D%5D', 0, '2025-02-05 02:46:13', '2025-02-05 02:46:13'),
(1689, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1689#package=45&packageProduct=122', 0, '2025-02-05 02:57:27', '2025-02-05 02:57:27'),
(1690, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1690#package=45&packageProduct=122', 0, '2025-02-05 02:57:27', '2025-02-05 02:57:27'),
(1691, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1691#packageProduct=123', 0, '2025-02-05 03:23:58', '2025-02-05 03:23:58'),
(1692, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1692#packageProduct=123', 0, '2025-02-05 03:23:58', '2025-02-05 03:23:58'),
(1693, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1693#packageProduct=124', 0, '2025-02-05 03:44:20', '2025-02-05 03:44:20'),
(1694, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1694#packageProduct=124', 0, '2025-02-05 03:44:20', '2025-02-05 03:44:20'),
(1695, 6, 'SMPL10 Packing List Revised!', 'The value dimension, gross weight and net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1695#updatedPackages=%5B%7B%22id%22%3A45%2C%22fields%22%3A%5B%22dimension%22%2C%22gross_weight%22%2C%22net_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A124%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-02-05 03:44:43', '2025-02-05 03:44:43'),
(1696, 2, 'SMPL10 Packing List Revised!', 'The value dimension, gross weight and net weight updated at!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1696#updatedPackages=%5B%7B%22id%22%3A45%2C%22fields%22%3A%5B%22dimension%22%2C%22gross_weight%22%2C%22net_weight%22%5D%7D%5D&updatedPackageProducts=%5B%7B%22id%22%3A124%2C%22fields%22%3A%5B%5D%7D%5D', 0, '2025-02-05 03:44:43', '2025-02-05 03:44:43'),
(1697, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1697#package=46&packageProduct=125', 0, '2025-02-05 03:45:03', '2025-02-05 03:45:03'),
(1698, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1698#package=46&packageProduct=125', 0, '2025-02-05 03:45:03', '2025-02-05 03:45:03'),
(1699, 2, 'SMLQ38 ZENDIBOC Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=42&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1699', 0, '2025-02-05 04:29:15', '2025-02-05 04:29:15'),
(1700, 1, 'SMPL10 Order Details Revised!!', 'The value pack quantity, price per set, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?notification_id=1700#updatedProducts=%5B%7B%22id%22%3A%2279%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-05 23:56:03', '2025-02-05 23:56:03'),
(1701, 2, 'SMPL10 Order Details Revised!!', 'The value pack quantity, price per set, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?notification_id=1701#updatedProducts=%5B%7B%22id%22%3A%2279%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-05 23:56:03', '2025-02-05 23:56:03'),
(1702, 3, 'SMPL10 Order Details Revised!!', 'The value pack quantity, price per set, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?notification_id=1702#updatedProducts=%5B%7B%22id%22%3A%2279%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-05 23:56:03', '2025-02-05 23:56:03'),
(1703, 5, 'SMPL10 Order Details Revised!!', 'The value pack quantity, price per set, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?notification_id=1703#updatedProducts=%5B%7B%22id%22%3A%2279%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-05 23:56:03', '2025-02-05 23:56:03'),
(1704, 6, 'SMPL10 Order Details Revised!!', 'The value pack quantity, price per set, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?notification_id=1704#updatedProducts=%5B%7B%22id%22%3A%2279%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-05 23:56:03', '2025-02-05 23:56:03'),
(1705, 1, 'SMPL10 Order Details Revised!!', 'The value pack quantity, price per set, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1705#updatedProducts=%5B%7B%22id%22%3A%2279%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-06 00:00:08', '2025-02-06 00:00:08'),
(1706, 2, 'SMPL10 Order Details Revised!!', 'The value pack quantity, price per set, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1706#updatedProducts=%5B%7B%22id%22%3A%2279%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-06 00:00:08', '2025-02-06 00:00:08'),
(1707, 3, 'SMPL10 Order Details Revised!!', 'The value pack quantity, price per set, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1707#updatedProducts=%5B%7B%22id%22%3A%2279%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-06 00:00:08', '2025-02-06 00:00:08'),
(1708, 5, 'SMPL10 Order Details Revised!!', 'The value pack quantity, price per set, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1708#updatedProducts=%5B%7B%22id%22%3A%2279%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-06 00:00:08', '2025-02-06 00:00:08'),
(1709, 6, 'SMPL10 Order Details Revised!!', 'The value pack quantity, price per set, total and updated at has been updated!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1709#updatedProducts=%5B%7B%22id%22%3A%2279%22%2C%22fields%22%3A%5B%22quantity%22%2C%22price_per_set%22%2C%22total%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-06 00:00:08', '2025-02-06 00:00:08'),
(1710, 3, 'SMLQ23 BICALUTAMIDE Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=23&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1710', 0, '2025-02-06 06:38:39', '2025-02-06 06:38:39'),
(1711, 3, 'SMLQ27 HOPESWAN Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=27&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1711', 0, '2025-02-06 06:45:41', '2025-02-06 06:45:41'),
(1712, 2, 'SMLQ35 BROMOCRIPTINE TABLET Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=39&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1712', 0, '2025-02-06 06:46:14', '2025-02-06 06:46:14'),
(1713, 2, 'SMLQ37 AAAEERARR5595 Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=41&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1713', 0, '2025-02-06 06:47:04', '2025-02-06 06:47:04'),
(1714, 2, 'SMLQ40 CEFIXIME IP 200MG + OFLOXACIN IP 200MG Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=44&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1714', 0, '2025-02-06 06:57:52', '2025-02-06 06:57:52'),
(1715, 2, 'SMLQ18 ACI FREE (ZEERA) Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations/create?id=18&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1715', 0, '2025-02-06 23:59:18', '2025-02-06 23:59:18'),
(1716, 1, 'SMLQ14 AB555-F59-A5FGH-59UHJK-5599A Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=14&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1716', 0, '2025-02-07 00:00:05', '2025-02-07 00:00:05'),
(1717, 2, 'SMLQ19 UPROPION HCL Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=19&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1717', 0, '2025-02-07 00:02:24', '2025-02-07 00:02:24'),
(1718, 3, 'SMLQ28 DIGUSIL MPS (MINT) Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=28&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1718', 0, '2025-02-07 00:09:14', '2025-02-07 00:09:14'),
(1719, 3, 'SMLQ27 HOPESWAN Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=27&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1719', 0, '2025-02-07 00:17:45', '2025-02-07 00:17:45'),
(1720, 3, 'SMPL10 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?notification_id=1720#products=116%2C117%2C118%2C119', 0, '2025-02-11 22:23:44', '2025-02-11 22:23:44'),
(1721, 6, 'SMPL10 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?notification_id=1721#products=116%2C117%2C118%2C119', 0, '2025-02-11 22:23:44', '2025-02-11 22:23:44'),
(1722, 3, 'SMPL10 Order Details Revised!!', 'The value product description, pack size and updated at has been updated!', 'http://127.0.0.1:8000/orders?notification_id=1722#updatedProducts=%5B%7B%22id%22%3A%2279%22%2C%22fields%22%3A%5B%22product_id%22%2C%22product_variant_id%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-11 22:23:44', '2025-02-11 22:23:44'),
(1723, 6, 'SMPL10 Order Details Revised!!', 'The value product description, pack size and updated at has been updated!', 'http://127.0.0.1:8000/orders?notification_id=1723#updatedProducts=%5B%7B%22id%22%3A%2279%22%2C%22fields%22%3A%5B%22product_id%22%2C%22product_variant_id%22%2C%22updated_at%22%5D%7D%5D', 0, '2025-02-11 22:23:44', '2025-02-11 22:23:44'),
(1724, 6, 'SMPL10 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1724#purchase=79%2C116%2C117%2C118%2C119', 0, '2025-02-11 22:24:09', '2025-02-11 22:24:09');
INSERT INTO `notifications` (`id`, `user_id`, `heading`, `content`, `url`, `is_read`, `created_at`, `updated_at`) VALUES
(1725, 2, 'SMPL10 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1725#purchase=79%2C116%2C117%2C118%2C119', 0, '2025-02-11 22:24:09', '2025-02-11 22:24:09'),
(1726, 3, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1726#productStocks=78', 0, '2025-02-11 22:24:31', '2025-02-11 22:24:31'),
(1727, 6, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1727#productStocks=78', 0, '2025-02-11 22:24:31', '2025-02-11 22:24:31'),
(1728, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1728#productStocks=78', 0, '2025-02-11 22:24:31', '2025-02-11 22:24:31'),
(1729, 3, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1729#productStocks=79', 0, '2025-02-11 22:24:59', '2025-02-11 22:24:59'),
(1730, 6, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1730#productStocks=79', 0, '2025-02-11 22:24:59', '2025-02-11 22:24:59'),
(1731, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1731#productStocks=79', 0, '2025-02-11 22:24:59', '2025-02-11 22:24:59'),
(1732, 3, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1732#productStocks=80', 0, '2025-02-11 22:25:16', '2025-02-11 22:25:16'),
(1733, 6, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1733#productStocks=80', 0, '2025-02-11 22:25:16', '2025-02-11 22:25:16'),
(1734, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1734#productStocks=80', 0, '2025-02-11 22:25:16', '2025-02-11 22:25:16'),
(1735, 3, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1735#productStocks=81', 0, '2025-02-11 22:25:33', '2025-02-11 22:25:33'),
(1736, 6, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1736#productStocks=81', 0, '2025-02-11 22:25:33', '2025-02-11 22:25:33'),
(1737, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1737#productStocks=81', 0, '2025-02-11 22:25:33', '2025-02-11 22:25:33'),
(1738, 3, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1738#productStocks=82', 0, '2025-02-11 22:25:54', '2025-02-11 22:25:54'),
(1739, 6, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1739#productStocks=82', 0, '2025-02-11 22:25:54', '2025-02-11 22:25:54'),
(1740, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1740#productStocks=82', 0, '2025-02-11 22:25:54', '2025-02-11 22:25:54'),
(1741, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1741#package=47&packageProduct=126', 0, '2025-02-11 22:33:55', '2025-02-11 22:33:55'),
(1742, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1742#package=47&packageProduct=126', 0, '2025-02-11 22:33:55', '2025-02-11 22:33:55'),
(1743, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1743#package=47%2C48&packageProduct=126%2C127', 0, '2025-02-11 22:33:55', '2025-02-11 22:33:55'),
(1744, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1744#package=47%2C48&packageProduct=126%2C127', 0, '2025-02-11 22:33:55', '2025-02-11 22:33:55'),
(1745, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1745#package=47%2C48%2C49&packageProduct=126%2C127%2C128%2C129', 0, '2025-02-11 22:33:55', '2025-02-11 22:33:55'),
(1746, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1746#package=47%2C48%2C49&packageProduct=126%2C127%2C128%2C129', 0, '2025-02-11 22:33:55', '2025-02-11 22:33:55'),
(1747, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1747#package=47%2C48%2C49%2C50&packageProduct=126%2C127%2C128%2C129%2C130%2C131%2C132%2C133%2C134', 0, '2025-02-11 22:33:55', '2025-02-11 22:33:55'),
(1748, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1748#package=47%2C48%2C49%2C50&packageProduct=126%2C127%2C128%2C129%2C130%2C131%2C132%2C133%2C134', 0, '2025-02-11 22:33:55', '2025-02-11 22:33:55'),
(1749, 3, 'SMPL10 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1749#products=120', 0, '2025-02-11 22:39:44', '2025-02-11 22:39:44'),
(1750, 6, 'SMPL10 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1750#products=120', 0, '2025-02-11 22:39:44', '2025-02-11 22:39:44'),
(1751, 3, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1751#productStocks=83', 0, '2025-02-11 22:40:03', '2025-02-11 22:40:03'),
(1752, 6, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1752#productStocks=83', 0, '2025-02-11 22:40:03', '2025-02-11 22:40:03'),
(1753, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1753#productStocks=83', 0, '2025-02-11 22:40:03', '2025-02-11 22:40:03'),
(1754, 6, 'SMPL10 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1754#purchase=120', 0, '2025-02-11 22:40:12', '2025-02-11 22:40:12'),
(1755, 2, 'SMPL10 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1755#purchase=120', 0, '2025-02-11 22:40:12', '2025-02-11 22:40:12'),
(1756, 3, 'SMPL10 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1756#billing=76', 0, '2025-02-11 22:40:20', '2025-02-11 22:40:20'),
(1757, 6, 'SMPL10 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1757#billing=76', 0, '2025-02-11 22:40:20', '2025-02-11 22:40:20'),
(1758, 3, 'SMPL10 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1758#billing=78', 0, '2025-02-11 22:40:25', '2025-02-11 22:40:25'),
(1759, 6, 'SMPL10 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1759#billing=78', 0, '2025-02-11 22:40:25', '2025-02-11 22:40:25'),
(1760, 3, 'SMPL10 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1760#billing=79', 0, '2025-02-11 22:40:34', '2025-02-11 22:40:34'),
(1761, 6, 'SMPL10 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1761#billing=79', 0, '2025-02-11 22:40:34', '2025-02-11 22:40:34'),
(1762, 3, 'SMPL10 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1762#billing=80', 0, '2025-02-11 22:40:39', '2025-02-11 22:40:39'),
(1763, 6, 'SMPL10 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1763#billing=80', 0, '2025-02-11 22:40:39', '2025-02-11 22:40:39'),
(1764, 3, 'SMPL10 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1764#billing=81', 0, '2025-02-11 22:40:44', '2025-02-11 22:40:44'),
(1765, 6, 'SMPL10 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1765#billing=81', 0, '2025-02-11 22:40:44', '2025-02-11 22:40:44'),
(1766, 3, 'SMPL10 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1766#billing=82', 0, '2025-02-11 22:40:48', '2025-02-11 22:40:48'),
(1767, 6, 'SMPL10 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1767#billing=82', 0, '2025-02-11 22:40:48', '2025-02-11 22:40:48'),
(1768, 3, 'SMPL10 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1768#billing=83', 0, '2025-02-11 22:40:53', '2025-02-11 22:40:53'),
(1769, 6, 'SMPL10 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1769#billing=83', 0, '2025-02-11 22:40:53', '2025-02-11 22:40:53'),
(1770, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1770#packageProduct=135', 0, '2025-02-11 22:43:03', '2025-02-11 22:43:03'),
(1771, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Products+purchase+updated+successfully&notification_id=1771#packageProduct=135', 0, '2025-02-11 22:43:03', '2025-02-11 22:43:03'),
(1772, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1772#package=51&packageProduct=136%2C137%2C138%2C139', 0, '2025-02-11 22:45:09', '2025-02-11 22:45:09'),
(1773, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1773#package=51&packageProduct=136%2C137%2C138%2C139', 0, '2025-02-11 22:45:09', '2025-02-11 22:45:09'),
(1774, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1774#package=52&packageProduct=140', 0, '2025-02-11 23:04:47', '2025-02-11 23:04:47'),
(1775, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1775#package=52&packageProduct=140', 0, '2025-02-11 23:04:47', '2025-02-11 23:04:47'),
(1776, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1776#package=52%2C53&packageProduct=140%2C141', 0, '2025-02-11 23:04:47', '2025-02-11 23:04:47'),
(1777, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1777#package=52%2C53&packageProduct=140%2C141', 0, '2025-02-11 23:04:47', '2025-02-11 23:04:47'),
(1778, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1778#package=52%2C53%2C54&packageProduct=140%2C141%2C142%2C143', 0, '2025-02-11 23:04:47', '2025-02-11 23:04:47'),
(1779, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1779#package=52%2C53%2C54&packageProduct=140%2C141%2C142%2C143', 0, '2025-02-11 23:04:47', '2025-02-11 23:04:47'),
(1780, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1780#package=52%2C53%2C54%2C55&packageProduct=140%2C141%2C142%2C143%2C144%2C145%2C146%2C147%2C148%2C149%2C150', 0, '2025-02-11 23:04:47', '2025-02-11 23:04:47'),
(1781, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1781#package=52%2C53%2C54%2C55&packageProduct=140%2C141%2C142%2C143%2C144%2C145%2C146%2C147%2C148%2C149%2C150', 0, '2025-02-11 23:04:47', '2025-02-11 23:04:47'),
(1782, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1782#package=52%2C53%2C54%2C55%2C56&packageProduct=140%2C141%2C142%2C143%2C144%2C145%2C146%2C147%2C148%2C149%2C150%2C151%2C152%2C153%2C154', 0, '2025-02-11 23:04:47', '2025-02-11 23:04:47'),
(1783, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1783#package=52%2C53%2C54%2C55%2C56&packageProduct=140%2C141%2C142%2C143%2C144%2C145%2C146%2C147%2C148%2C149%2C150%2C151%2C152%2C153%2C154', 0, '2025-02-11 23:04:47', '2025-02-11 23:04:47'),
(1784, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1784#package=52%2C53%2C54%2C55%2C56%2C57&packageProduct=140%2C141%2C142%2C143%2C144%2C145%2C146%2C147%2C148%2C149%2C150%2C151%2C152%2C153%2C154%2C155%2C156', 0, '2025-02-11 23:04:47', '2025-02-11 23:04:47'),
(1785, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1785#package=52%2C53%2C54%2C55%2C56%2C57&packageProduct=140%2C141%2C142%2C143%2C144%2C145%2C146%2C147%2C148%2C149%2C150%2C151%2C152%2C153%2C154%2C155%2C156', 0, '2025-02-11 23:04:47', '2025-02-11 23:04:47'),
(1786, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1786#package=52%2C53%2C54%2C55%2C56%2C57%2C58&packageProduct=140%2C141%2C142%2C143%2C144%2C145%2C146%2C147%2C148%2C149%2C150%2C151%2C152%2C153%2C154%2C155%2C156%2C157%2C158', 0, '2025-02-11 23:04:47', '2025-02-11 23:04:47'),
(1787, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1787#package=52%2C53%2C54%2C55%2C56%2C57%2C58&packageProduct=140%2C141%2C142%2C143%2C144%2C145%2C146%2C147%2C148%2C149%2C150%2C151%2C152%2C153%2C154%2C155%2C156%2C157%2C158', 0, '2025-02-11 23:04:47', '2025-02-11 23:04:47'),
(1788, 3, 'SMLQ29 BUDESONIDE INHALATION SUSPENSION Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=29&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1788', 0, '2025-02-11 23:16:51', '2025-02-11 23:16:51'),
(1789, 3, 'SMLQ30 ACI FREE (ZEERA) Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=33&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1789', 0, '2025-02-11 23:17:25', '2025-02-11 23:17:25'),
(1790, 3, 'SMLQ31 CALCIUM ACETATE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=34&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1790', 0, '2025-02-11 23:18:04', '2025-02-11 23:18:04'),
(1791, 2, 'SMLQ20 RURVA Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=20&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1791', 0, '2025-02-11 23:22:39', '2025-02-11 23:22:39'),
(1792, 2, 'SMLQ13 ETORICOXIB IP 60 MG + THIOCOLCHICOXIB IP 4 MG Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=13&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1792', 0, '2025-02-12 00:25:25', '2025-02-12 00:25:25'),
(1793, 1, 'SMLQ14 AB555-F59-A5FGH-59UHJK-5599A Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=14&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1793', 0, '2025-02-12 00:43:32', '2025-02-12 00:43:32'),
(1794, 2, 'SMLQ19 UPROPION HCL Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=19&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1794', 0, '2025-02-12 00:44:12', '2025-02-12 00:44:12'),
(1795, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1795#package=59&packageProduct=159', 0, '2025-02-12 01:02:07', '2025-02-12 01:02:07'),
(1796, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1796#package=59&packageProduct=159', 0, '2025-02-12 01:02:07', '2025-02-12 01:02:07'),
(1797, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1797#package=59%2C60&packageProduct=159%2C160', 0, '2025-02-12 01:02:07', '2025-02-12 01:02:07'),
(1798, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1798#package=59%2C60&packageProduct=159%2C160', 0, '2025-02-12 01:02:07', '2025-02-12 01:02:07'),
(1799, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1799#package=59%2C60%2C61&packageProduct=159%2C160%2C161', 0, '2025-02-12 01:02:07', '2025-02-12 01:02:07'),
(1800, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1800#package=59%2C60%2C61&packageProduct=159%2C160%2C161', 0, '2025-02-12 01:02:07', '2025-02-12 01:02:07'),
(1801, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1801#package=59%2C60%2C61%2C62&packageProduct=159%2C160%2C161%2C162%2C163%2C164%2C165%2C166%2C167%2C168%2C169%2C170%2C171%2C172%2C173%2C174', 0, '2025-02-12 01:02:07', '2025-02-12 01:02:07'),
(1802, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1802#package=59%2C60%2C61%2C62&packageProduct=159%2C160%2C161%2C162%2C163%2C164%2C165%2C166%2C167%2C168%2C169%2C170%2C171%2C172%2C173%2C174', 0, '2025-02-12 01:02:07', '2025-02-12 01:02:07'),
(1803, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1803#package=59%2C60%2C61%2C62%2C63&packageProduct=159%2C160%2C161%2C162%2C163%2C164%2C165%2C166%2C167%2C168%2C169%2C170%2C171%2C172%2C173%2C174%2C175', 0, '2025-02-12 01:02:07', '2025-02-12 01:02:07'),
(1804, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1804#package=59%2C60%2C61%2C62%2C63&packageProduct=159%2C160%2C161%2C162%2C163%2C164%2C165%2C166%2C167%2C168%2C169%2C170%2C171%2C172%2C173%2C174%2C175', 0, '2025-02-12 01:02:07', '2025-02-12 01:02:07'),
(1805, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1805#package=59%2C60%2C61%2C62%2C63%2C64&packageProduct=159%2C160%2C161%2C162%2C163%2C164%2C165%2C166%2C167%2C168%2C169%2C170%2C171%2C172%2C173%2C174%2C175%2C176', 0, '2025-02-12 01:02:07', '2025-02-12 01:02:07'),
(1806, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1806#package=59%2C60%2C61%2C62%2C63%2C64&packageProduct=159%2C160%2C161%2C162%2C163%2C164%2C165%2C166%2C167%2C168%2C169%2C170%2C171%2C172%2C173%2C174%2C175%2C176', 0, '2025-02-12 01:02:07', '2025-02-12 01:02:07'),
(1807, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1807#package=59%2C60%2C61%2C62%2C63%2C64%2C65&packageProduct=159%2C160%2C161%2C162%2C163%2C164%2C165%2C166%2C167%2C168%2C169%2C170%2C171%2C172%2C173%2C174%2C175%2C176%2C177', 0, '2025-02-12 01:02:07', '2025-02-12 01:02:07'),
(1808, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1808#package=59%2C60%2C61%2C62%2C63%2C64%2C65&packageProduct=159%2C160%2C161%2C162%2C163%2C164%2C165%2C166%2C167%2C168%2C169%2C170%2C171%2C172%2C173%2C174%2C175%2C176%2C177', 0, '2025-02-12 01:02:07', '2025-02-12 01:02:07'),
(1809, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1809#package=66&packageProduct=178', 0, '2025-02-12 01:55:39', '2025-02-12 01:55:39'),
(1810, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1810#package=66&packageProduct=178', 0, '2025-02-12 01:55:39', '2025-02-12 01:55:39'),
(1811, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1811#package=66%2C67&packageProduct=178%2C179', 0, '2025-02-12 01:55:39', '2025-02-12 01:55:39'),
(1812, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1812#package=66%2C67&packageProduct=178%2C179', 0, '2025-02-12 01:55:39', '2025-02-12 01:55:39'),
(1813, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1813#package=66%2C67%2C68&packageProduct=178%2C179%2C180', 0, '2025-02-12 01:55:39', '2025-02-12 01:55:39'),
(1814, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1814#package=66%2C67%2C68&packageProduct=178%2C179%2C180', 0, '2025-02-12 01:55:39', '2025-02-12 01:55:39'),
(1815, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1815#package=66%2C67%2C68%2C69&packageProduct=178%2C179%2C180%2C181%2C182%2C183%2C184%2C185%2C186%2C187%2C188%2C189%2C190%2C191%2C192%2C193', 0, '2025-02-12 01:55:39', '2025-02-12 01:55:39'),
(1816, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1816#package=66%2C67%2C68%2C69&packageProduct=178%2C179%2C180%2C181%2C182%2C183%2C184%2C185%2C186%2C187%2C188%2C189%2C190%2C191%2C192%2C193', 0, '2025-02-12 01:55:39', '2025-02-12 01:55:39'),
(1817, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1817#package=66%2C67%2C68%2C69%2C70&packageProduct=178%2C179%2C180%2C181%2C182%2C183%2C184%2C185%2C186%2C187%2C188%2C189%2C190%2C191%2C192%2C193%2C194', 0, '2025-02-12 01:55:39', '2025-02-12 01:55:39'),
(1818, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1818#package=66%2C67%2C68%2C69%2C70&packageProduct=178%2C179%2C180%2C181%2C182%2C183%2C184%2C185%2C186%2C187%2C188%2C189%2C190%2C191%2C192%2C193%2C194', 0, '2025-02-12 01:55:39', '2025-02-12 01:55:39'),
(1819, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1819#package=66%2C67%2C68%2C69%2C70%2C71&packageProduct=178%2C179%2C180%2C181%2C182%2C183%2C184%2C185%2C186%2C187%2C188%2C189%2C190%2C191%2C192%2C193%2C194%2C195', 0, '2025-02-12 01:55:39', '2025-02-12 01:55:39'),
(1820, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1820#package=66%2C67%2C68%2C69%2C70%2C71&packageProduct=178%2C179%2C180%2C181%2C182%2C183%2C184%2C185%2C186%2C187%2C188%2C189%2C190%2C191%2C192%2C193%2C194%2C195', 0, '2025-02-12 01:55:39', '2025-02-12 01:55:39'),
(1821, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1821#package=66%2C67%2C68%2C69%2C70%2C71%2C72&packageProduct=178%2C179%2C180%2C181%2C182%2C183%2C184%2C185%2C186%2C187%2C188%2C189%2C190%2C191%2C192%2C193%2C194%2C195%2C196', 0, '2025-02-12 01:55:39', '2025-02-12 01:55:39'),
(1822, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1822#package=66%2C67%2C68%2C69%2C70%2C71%2C72&packageProduct=178%2C179%2C180%2C181%2C182%2C183%2C184%2C185%2C186%2C187%2C188%2C189%2C190%2C191%2C192%2C193%2C194%2C195%2C196', 0, '2025-02-12 01:55:39', '2025-02-12 01:55:39'),
(1823, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1823#package=73&packageProduct=197', 0, '2025-02-12 03:12:15', '2025-02-12 03:12:15'),
(1824, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1824#package=73&packageProduct=197', 0, '2025-02-12 03:12:15', '2025-02-12 03:12:15'),
(1825, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1825#package=73%2C74&packageProduct=197%2C198', 0, '2025-02-12 03:12:15', '2025-02-12 03:12:15'),
(1826, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1826#package=73%2C74&packageProduct=197%2C198', 0, '2025-02-12 03:12:15', '2025-02-12 03:12:15'),
(1827, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1827#package=73%2C74%2C75&packageProduct=197%2C198%2C199%2C200', 0, '2025-02-12 03:12:15', '2025-02-12 03:12:15'),
(1828, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1828#package=73%2C74%2C75&packageProduct=197%2C198%2C199%2C200', 0, '2025-02-12 03:12:15', '2025-02-12 03:12:15'),
(1829, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1829#package=73%2C74%2C75%2C76&packageProduct=197%2C198%2C199%2C200%2C201%2C202%2C203%2C204%2C205%2C206%2C207', 0, '2025-02-12 03:12:15', '2025-02-12 03:12:15'),
(1830, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1830#package=73%2C74%2C75%2C76&packageProduct=197%2C198%2C199%2C200%2C201%2C202%2C203%2C204%2C205%2C206%2C207', 0, '2025-02-12 03:12:15', '2025-02-12 03:12:15'),
(1831, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1831#package=73%2C74%2C75%2C76%2C77&packageProduct=197%2C198%2C199%2C200%2C201%2C202%2C203%2C204%2C205%2C206%2C207%2C208%2C209%2C210%2C211', 0, '2025-02-12 03:12:15', '2025-02-12 03:12:15'),
(1832, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1832#package=73%2C74%2C75%2C76%2C77&packageProduct=197%2C198%2C199%2C200%2C201%2C202%2C203%2C204%2C205%2C206%2C207%2C208%2C209%2C210%2C211', 0, '2025-02-12 03:12:15', '2025-02-12 03:12:15'),
(1833, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1833#package=73%2C74%2C75%2C76%2C77%2C78&packageProduct=197%2C198%2C199%2C200%2C201%2C202%2C203%2C204%2C205%2C206%2C207%2C208%2C209%2C210%2C211%2C212%2C213', 0, '2025-02-12 03:12:15', '2025-02-12 03:12:15'),
(1834, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1834#package=73%2C74%2C75%2C76%2C77%2C78&packageProduct=197%2C198%2C199%2C200%2C201%2C202%2C203%2C204%2C205%2C206%2C207%2C208%2C209%2C210%2C211%2C212%2C213', 0, '2025-02-12 03:12:15', '2025-02-12 03:12:15'),
(1835, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1835#package=73%2C74%2C75%2C76%2C77%2C78%2C79&packageProduct=197%2C198%2C199%2C200%2C201%2C202%2C203%2C204%2C205%2C206%2C207%2C208%2C209%2C210%2C211%2C212%2C213%2C214%2C215', 0, '2025-02-12 03:12:15', '2025-02-12 03:12:15'),
(1836, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1836#package=73%2C74%2C75%2C76%2C77%2C78%2C79&packageProduct=197%2C198%2C199%2C200%2C201%2C202%2C203%2C204%2C205%2C206%2C207%2C208%2C209%2C210%2C211%2C212%2C213%2C214%2C215', 0, '2025-02-12 03:12:15', '2025-02-12 03:12:15'),
(1837, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1837#package=80&packageProduct=216', 0, '2025-02-12 03:22:35', '2025-02-12 03:22:35'),
(1838, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1838#package=80&packageProduct=216', 0, '2025-02-12 03:22:35', '2025-02-12 03:22:35'),
(1839, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1839#package=80%2C81&packageProduct=216%2C217', 0, '2025-02-12 03:22:35', '2025-02-12 03:22:35'),
(1840, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1840#package=80%2C81&packageProduct=216%2C217', 0, '2025-02-12 03:22:35', '2025-02-12 03:22:35'),
(1841, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1841#package=80%2C81%2C82&packageProduct=216%2C217%2C218%2C219', 0, '2025-02-12 03:22:35', '2025-02-12 03:22:35'),
(1842, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1842#package=80%2C81%2C82&packageProduct=216%2C217%2C218%2C219', 0, '2025-02-12 03:22:35', '2025-02-12 03:22:35'),
(1843, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1843#package=80%2C81%2C82%2C83&packageProduct=216%2C217%2C218%2C219%2C220%2C221%2C222%2C223%2C224%2C225%2C226', 0, '2025-02-12 03:22:35', '2025-02-12 03:22:35'),
(1844, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1844#package=80%2C81%2C82%2C83&packageProduct=216%2C217%2C218%2C219%2C220%2C221%2C222%2C223%2C224%2C225%2C226', 0, '2025-02-12 03:22:35', '2025-02-12 03:22:35'),
(1845, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1845#package=80%2C81%2C82%2C83%2C84&packageProduct=216%2C217%2C218%2C219%2C220%2C221%2C222%2C223%2C224%2C225%2C226%2C227%2C228%2C229%2C230', 0, '2025-02-12 03:22:35', '2025-02-12 03:22:35'),
(1846, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1846#package=80%2C81%2C82%2C83%2C84&packageProduct=216%2C217%2C218%2C219%2C220%2C221%2C222%2C223%2C224%2C225%2C226%2C227%2C228%2C229%2C230', 0, '2025-02-12 03:22:35', '2025-02-12 03:22:35'),
(1847, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1847#package=80%2C81%2C82%2C83%2C84%2C85&packageProduct=216%2C217%2C218%2C219%2C220%2C221%2C222%2C223%2C224%2C225%2C226%2C227%2C228%2C229%2C230%2C231%2C232', 0, '2025-02-12 03:22:35', '2025-02-12 03:22:35'),
(1848, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1848#package=80%2C81%2C82%2C83%2C84%2C85&packageProduct=216%2C217%2C218%2C219%2C220%2C221%2C222%2C223%2C224%2C225%2C226%2C227%2C228%2C229%2C230%2C231%2C232', 0, '2025-02-12 03:22:35', '2025-02-12 03:22:35'),
(1849, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1849#package=80%2C81%2C82%2C83%2C84%2C85%2C86&packageProduct=216%2C217%2C218%2C219%2C220%2C221%2C222%2C223%2C224%2C225%2C226%2C227%2C228%2C229%2C230%2C231%2C232%2C233%2C234%2C235', 0, '2025-02-12 03:22:35', '2025-02-12 03:22:35'),
(1850, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order+product+package+updated+successfully&notification_id=1850#package=80%2C81%2C82%2C83%2C84%2C85%2C86&packageProduct=216%2C217%2C218%2C219%2C220%2C221%2C222%2C223%2C224%2C225%2C226%2C227%2C228%2C229%2C230%2C231%2C232%2C233%2C234%2C235', 0, '2025-02-12 03:22:35', '2025-02-12 03:22:35'),
(1851, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=87&packageProduct=236', 0, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(1852, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=87&packageProduct=236', 0, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(1853, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=87%2C88&packageProduct=236%2C237', 0, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(1854, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=87%2C88&packageProduct=236%2C237', 0, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(1855, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=87%2C88%2C89&packageProduct=236%2C237%2C238%2C239', 0, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(1856, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=87%2C88%2C89&packageProduct=236%2C237%2C238%2C239', 0, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(1857, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=87%2C88%2C89%2C90&packageProduct=236%2C237%2C238%2C239%2C240%2C241%2C242%2C243%2C244%2C245%2C246', 0, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(1858, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=87%2C88%2C89%2C90&packageProduct=236%2C237%2C238%2C239%2C240%2C241%2C242%2C243%2C244%2C245%2C246', 0, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(1859, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=87%2C88%2C89%2C90%2C91&packageProduct=236%2C237%2C238%2C239%2C240%2C241%2C242%2C243%2C244%2C245%2C246%2C247%2C248%2C249%2C250', 0, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(1860, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=87%2C88%2C89%2C90%2C91&packageProduct=236%2C237%2C238%2C239%2C240%2C241%2C242%2C243%2C244%2C245%2C246%2C247%2C248%2C249%2C250', 0, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(1861, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=87%2C88%2C89%2C90%2C91%2C92&packageProduct=236%2C237%2C238%2C239%2C240%2C241%2C242%2C243%2C244%2C245%2C246%2C247%2C248%2C249%2C250%2C251%2C252%2C253%2C254', 0, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(1862, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?success=Order%20product%20package%20updated%20successfully#package=87%2C88%2C89%2C90%2C91%2C92&packageProduct=236%2C237%2C238%2C239%2C240%2C241%2C242%2C243%2C244%2C245%2C246%2C247%2C248%2C249%2C250%2C251%2C252%2C253%2C254', 0, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(1863, 3, 'SMLQ25 HUMULIN N U-100 Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=25&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1863', 0, '2025-02-13 04:45:01', '2025-02-13 04:45:01'),
(1864, 3, 'SMLQ24 MONONINE Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=24&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1864', 0, '2025-02-13 04:45:40', '2025-02-13 04:45:40'),
(1865, 2, 'SMLQ21 GDGDSGD Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=21&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1865', 0, '2025-02-13 04:46:25', '2025-02-13 04:46:25'),
(1866, 2, 'SMLQ13 ETORICOXIB IP 60 MG + THIOCOLCHICOXIB IP 4 MG Complete Quote Created!!', 'Finally, all the details are in one place, like a perfectly organized recipe!', 'http://127.0.0.1:8000/quotations/create?id=13&redirect=http%253A%252F%252F127.0.0.1%253A8000%252Fquotations&notification_id=1866', 0, '2025-02-13 04:47:59', '2025-02-13 04:47:59'),
(1867, 2, 'SMLQ40 CEFIXIME IP 200MG + OFLOXACIN IP 200MG Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending&notification_id=1867', 0, '2025-02-13 04:52:55', '2025-02-13 04:52:55'),
(1868, 6, 'SMPL10 Shipping Cost, Soft Box Price, Data Logger Price, Clearance Cost Added!!', 'The shipping cost, soft box price, data logger price, clearance cost have been added!', 'http://127.0.0.1:8000/orders?notification_id=1868#order=15&fields=Shipping+Cost%2CSoft+Box+Price%2CData+Logger+Price%2CClearance+Cost', 0, '2025-02-14 02:46:07', '2025-02-14 02:46:07'),
(1869, 6, 'SMPL16 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1869#package=93&packageProduct=255%2C256%2C257', 0, '2025-02-14 04:34:05', '2025-02-14 04:34:05'),
(1870, 2, 'SMPL16 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1870#package=93&packageProduct=255%2C256%2C257', 0, '2025-02-14 04:34:05', '2025-02-14 04:34:05'),
(1871, 6, 'SMPL16 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1871#package=93%2C94&packageProduct=255%2C256%2C257%2C258%2C259%2C260%2C261%2C262', 0, '2025-02-14 04:34:06', '2025-02-14 04:34:06'),
(1872, 2, 'SMPL16 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1872#package=93%2C94&packageProduct=255%2C256%2C257%2C258%2C259%2C260%2C261%2C262', 0, '2025-02-14 04:34:06', '2025-02-14 04:34:06'),
(1873, 6, 'SMPL16 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1873#package=95&packageProduct=263%2C264', 0, '2025-02-14 04:44:01', '2025-02-14 04:44:01'),
(1874, 2, 'SMPL16 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1874#package=95&packageProduct=263%2C264', 0, '2025-02-14 04:44:01', '2025-02-14 04:44:01');
INSERT INTO `notifications` (`id`, `user_id`, `heading`, `content`, `url`, `is_read`, `created_at`, `updated_at`) VALUES
(1875, 6, 'SMPL16 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1875#package=95%2C96&packageProduct=263%2C264%2C265%2C266', 0, '2025-02-14 04:44:02', '2025-02-14 04:44:02'),
(1876, 2, 'SMPL16 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1876#package=95%2C96&packageProduct=263%2C264%2C265%2C266', 0, '2025-02-14 04:44:02', '2025-02-14 04:44:02'),
(1877, 3, 'SMPL16 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1877#productStocks=84', 0, '2025-02-15 07:17:58', '2025-02-15 07:17:58'),
(1878, 6, 'SMPL16 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1878#productStocks=84', 0, '2025-02-15 07:17:58', '2025-02-15 07:17:58'),
(1879, 2, 'SMPL16 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1879#productStocks=84', 0, '2025-02-15 07:17:58', '2025-02-15 07:17:58'),
(1880, 6, 'SMPL16 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1880#purchase=109', 0, '2025-02-15 07:18:34', '2025-02-15 07:18:34'),
(1881, 2, 'SMPL16 The final order is placed!!', 'No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1881#purchase=109', 0, '2025-02-15 07:18:34', '2025-02-15 07:18:34'),
(1882, 3, 'SMPL10 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?notification_id=1882#products=121%2C122', 0, '2025-02-17 01:09:22', '2025-02-17 01:09:22'),
(1883, 6, 'SMPL10 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?notification_id=1883#products=121%2C122', 0, '2025-02-17 01:09:22', '2025-02-17 01:09:22'),
(1884, 3, 'SMPL10 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1884#products=123%2C124', 0, '2025-02-17 01:10:20', '2025-02-17 01:10:20'),
(1885, 6, 'SMPL10 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1885#products=123%2C124', 0, '2025-02-17 01:10:20', '2025-02-17 01:10:20'),
(1886, 3, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1886#productStocks=85', 0, '2025-02-17 03:35:47', '2025-02-17 03:35:47'),
(1887, 6, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1887#productStocks=85', 0, '2025-02-17 03:35:47', '2025-02-17 03:35:47'),
(1888, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+products+updated+successfully&notification_id=1888#productStocks=85', 0, '2025-02-17 03:35:47', '2025-02-17 03:35:47'),
(1889, 3, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1889#productStocks=86%2C87', 0, '2025-02-17 03:45:52', '2025-02-17 03:45:52'),
(1890, 6, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1890#productStocks=86%2C87', 0, '2025-02-17 03:45:52', '2025-02-17 03:45:52'),
(1891, 2, 'SMPL10 Stock has entered the warehouse!!', 'Let the unpacking party begin!', 'http://127.0.0.1:8000/orders?success=Order+product+stocks+updated+successfully&notification_id=1891#productStocks=86%2C87', 0, '2025-02-17 03:45:52', '2025-02-17 03:45:52'),
(1892, 3, 'SMPL10 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?notification_id=1892#products=125', 0, '2025-02-18 00:06:24', '2025-02-18 00:06:24'),
(1893, 6, 'SMPL10 New Order Won!!', 'Let the hunt for the best deal begin!', 'http://127.0.0.1:8000/orders?notification_id=1893#products=125', 0, '2025-02-18 00:06:24', '2025-02-18 00:06:24'),
(1894, 3, 'SMPL10 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?notification_id=1894#billing=82', 0, '2025-02-19 00:27:32', '2025-02-19 00:27:32'),
(1895, 6, 'SMPL10 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?notification_id=1895#billing=82', 0, '2025-02-19 00:27:32', '2025-02-19 00:27:32'),
(1896, 3, 'SMPL10 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?notification_id=1896#billing=86', 0, '2025-02-19 00:45:36', '2025-02-19 00:45:36'),
(1897, 6, 'SMPL10 System Entry Done!!', 'Our system just gave your stock a warm digital welcome!', 'http://127.0.0.1:8000/orders?notification_id=1897#billing=86', 0, '2025-02-19 00:45:36', '2025-02-19 00:45:36'),
(1898, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending&notification_id=1898', 0, '2025-02-19 22:20:56', '2025-02-19 22:20:56'),
(1899, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending&notification_id=1899', 0, '2025-02-19 22:21:55', '2025-02-19 22:21:55'),
(1900, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending&notification_id=1900', 0, '2025-02-19 22:25:47', '2025-02-19 22:25:47'),
(1901, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending&notification_id=1901', 0, '2025-02-19 22:31:35', '2025-02-19 22:31:35'),
(1902, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending&notification_id=1902', 0, '2025-02-19 22:36:26', '2025-02-19 22:36:26'),
(1903, 2, 'SMLQ43 AYUB2A Partial Quotation Created!!', 'Vendor\'s not giving a complete quotation—looks like we’re playing hide and seek with the details!', 'http://127.0.0.1:8000/quotations?perPage=10&search=&status=pending&notification_id=1903', 0, '2025-02-19 22:37:16', '2025-02-19 22:37:16'),
(1904, 1, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1904#packageProduct=267', 0, '2025-02-21 04:55:29', '2025-02-21 04:55:29'),
(1905, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1905#packageProduct=267', 0, '2025-02-21 04:55:29', '2025-02-21 04:55:29'),
(1906, 5, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1906#packageProduct=267', 0, '2025-02-21 04:55:29', '2025-02-21 04:55:29'),
(1907, 6, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1907#packageProduct=267', 0, '2025-02-21 04:55:29', '2025-02-21 04:55:29'),
(1908, 18, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1908#packageProduct=267', 0, '2025-02-21 04:55:29', '2025-02-21 04:55:29'),
(1909, 19, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1909#packageProduct=267', 0, '2025-02-21 04:55:29', '2025-02-21 04:55:29'),
(1910, 2, 'SMPL10 Packing List Created!!', 'Time to make sure everything fits like a puzzle... with a few extra bubble wraps!', 'http://127.0.0.1:8000/orders?notification_id=1910#packageProduct=267', 1, '2025-02-21 04:55:29', '2025-02-21 04:55:33');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `country` varchar(255) NOT NULL,
  `order_date` date DEFAULT NULL,
  `serve_date` varchar(255) DEFAULT NULL,
  `invoice_no` varchar(255) DEFAULT NULL,
  `invoice_date` date DEFAULT NULL,
  `is_shipping_documents_done` enum('yes','no') DEFAULT NULL,
  `is_tax_invoice_eway_billP_done` enum('yes','no') DEFAULT NULL,
  `is_arrange_pick_up` enum('yes','no') DEFAULT NULL,
  `is_shipment_dispatched` enum('yes','no') DEFAULT NULL,
  `is_awb_handover` enum('yes','no') DEFAULT NULL,
  `is_shipment_close` enum('yes','no') DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `pi_number` varchar(255) DEFAULT NULL,
  `shipping` decimal(10,2) DEFAULT NULL,
  `soft_boxes` decimal(10,2) DEFAULT NULL,
  `data_logger` decimal(10,2) DEFAULT NULL,
  `clearance` decimal(10,2) DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_by` bigint(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `bill_to_customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `bill_to_client_code` varchar(255) DEFAULT NULL,
  `bill_to_company_name` varchar(255) DEFAULT NULL,
  `bill_to_email` varchar(100) DEFAULT NULL,
  `bill_to_phone_no` varchar(15) DEFAULT NULL,
  `bill_to_registration_no` varchar(255) DEFAULT NULL,
  `bill_to_address` text DEFAULT NULL,
  `bill_to_zip_code` varchar(25) DEFAULT NULL,
  `ship_to_customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ship_to_client_code` varchar(255) DEFAULT NULL,
  `ship_to_company_name` varchar(255) DEFAULT NULL,
  `ship_to_email` varchar(100) DEFAULT NULL,
  `ship_to_phone_no` varchar(15) DEFAULT NULL,
  `ship_to_registration_no` varchar(255) DEFAULT NULL,
  `ship_to_address` text DEFAULT NULL,
  `ship_to_zip_code` varchar(25) DEFAULT NULL,
  `payment_terms` varchar(255) DEFAULT NULL,
  `delivery_by` varchar(255) DEFAULT NULL,
  `delivery_time` varchar(255) DEFAULT NULL,
  `port_of_discharge` varchar(100) DEFAULT NULL,
  `delivery_terms` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `country`, `order_date`, `serve_date`, `invoice_no`, `invoice_date`, `is_shipping_documents_done`, `is_tax_invoice_eway_billP_done`, `is_arrange_pick_up`, `is_shipment_dispatched`, `is_awb_handover`, `is_shipment_close`, `currency`, `pi_number`, `shipping`, `soft_boxes`, `data_logger`, `clearance`, `created_by`, `created_at`, `updated_by`, `updated_at`, `bill_to_customer_id`, `bill_to_client_code`, `bill_to_company_name`, `bill_to_email`, `bill_to_phone_no`, `bill_to_registration_no`, `bill_to_address`, `bill_to_zip_code`, `ship_to_customer_id`, `ship_to_client_code`, `ship_to_company_name`, `ship_to_email`, `ship_to_phone_no`, `ship_to_registration_no`, `ship_to_address`, `ship_to_zip_code`, `payment_terms`, `delivery_by`, `delivery_time`, `port_of_discharge`, `delivery_terms`) VALUES
(1, 'US', '2024-11-29', '2024-11', 'SMPL1', '2024-12-11', NULL, NULL, NULL, NULL, NULL, NULL, 'USD', '515599', NULL, NULL, NULL, NULL, 1, '2024-11-29 00:56:55', 2, '2024-12-11 05:55:20', 1, 'SMP0001', 'TATA', 'TATA101@GMAIL.COM', '9955599655', '9944556699', '99, ORTGH RTO', '395001', 3, 'SMP0003', 'TCS', 'TCS@GMAIL.COM', '9659155999', '9655151599', '98, RDFCXV LLT', '395009', '50% ADVANCE 50% BEFORE DELIVERY', 'RDFG', 'PPF', 'ssdf', 'TTGH'),
(2, 'US', '2024-11-29', '2024-11', 'SMPL2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'USD', '515159', NULL, NULL, NULL, NULL, 2, '2024-11-29 02:14:39', NULL, '2024-11-29 02:14:39', 1, 'SMP0001', 'TATA', 'TATA101@GMAIL.COM', '9955599655', '9944556699', '99, ORTGH RTO', '395001', 3, 'SMP0003', 'TCS', 'TCS@GMAIL.COM', '9659155999', '9655151599', '98, RDFCXV LLT', '395009', '75% ADVANCE 25% BEFORE DELIVERY', 'HGJNM', 'DFVB', 'yymmg', 'AABBC'),
(3, 'US', '2024-11-29', '2024-11', 'SMPL3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EURO', '515909', NULL, NULL, NULL, NULL, 2, '2024-11-29 02:31:44', NULL, '2024-11-29 02:31:44', 2, 'SMP0002', 'CAP', 'CAP101@GMAIL.COM', '9959191999', '9965555619', '59, ERT LLTP', '395005', 4, 'SMP0004', 'SF', 'SF101@GMAIL.COM', '9959090959', '9685555699', '15, RVN TTGS LLP', '395006', '100% ADVANCE BEFORE DELIVERY', 'JKL', 'JVM', 'fcv', 'TFG'),
(4, 'US', '2024-12-10', '2024-12', 'SMPL4', '2024-12-10', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'EURO', '51515599', 52850.21, 5951.32, 95159.09, 5006.99, 2, '2024-12-10 03:10:00', 2, '2024-12-19 03:49:49', 2, 'SMP0002', 'CAP', 'CAP101@GMAIL.COM', '9959191999', '9965555619', '59, ERT LLTP', '395005', 4, 'SMP0004', 'SF', 'SF101@GMAIL.COM', '9959090959', '9685555699', '15, RVN TTGS LLP', '395006', '75% ADVANCE 25% BEFORE DELIVERY', 'HHM', 'RFGVM', 'fftm', 'RDGH'),
(5, 'US', '2024-12-19', '2024-12', 'SMPL5', '2024-12-19', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'USD', 'SMLPI2', 50.00, 5.00, 95.00, 56.00, 2, '2024-12-19 03:26:19', 2, '2024-12-27 05:40:11', 5, 'SMP0005', 'CAPGEMINI', 'CAPGEMINI2GMAIL.COM', '9955664455', 'HRGSFGSFS8885', '569, GFHDJFSHJ', '395006', 6, 'SMP0006', 'TYU', 'TYU@GMAIL.COM', '8956235698', 'SDGSGSGS4545', '899, EEYETWT', '395001', '100% ADVANCE BEFORE DELIVERY', 'RDFGH', 'FGTUH', NULL, 'HJKL'),
(7, 'US', '2024-12-19', '2024-12', 'SMPL6', '2024-12-20', NULL, NULL, NULL, NULL, NULL, NULL, 'USD', 'AAABCCR5', NULL, NULL, NULL, NULL, 2, '2024-12-19 04:50:20', 2, '2025-01-01 03:04:17', 5, 'SMP0005', 'CAPGEMINI', 'CAPGEMINI2GMAIL.COM', '9955664455', 'HRGSFGSFS8885', '569, GFHDJFSHJ', '395006', 6, 'SMP0006', 'TYU', 'TYU@GMAIL.COM', '8956235698', 'SDGSGSGS4545', '899, EEYETWT', '395001', '100% ADVANCE BEFORE DELIVERY', 'SDFCVVB', 'AAAVB', 'aazxxc', 'AADXCVV'),
(11, 'US', '2024-12-19', '2024-12', 'SMPL7', '2024-12-20', NULL, NULL, NULL, NULL, NULL, NULL, 'USD', 'DDAAACCV55', NULL, NULL, NULL, NULL, 5, '2024-12-19 05:24:51', 2, '2024-12-23 04:36:05', 1, 'SMP0001', 'TATA', 'TATA101@GMAIL.COM', '9955599655', '9944556699', '99, ORTGH RTO', '395001', 3, 'SMP0003', 'TCS', 'TCS@GMAIL.COM', '9659155999', '9655151599', '98, RDFCXV LLT', '395009', '100% ADVANCE BEFORE DELIVERY', 'AAAAXXXCCVVT', 'AAAXXXYYFFG', 'aaaaxxxcccvvfg', 'AAAAAAXXCCVVB'),
(12, 'US', '2024-12-20', '2024-12', 'SMPL8', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'USD', 'GHBBN255', 46.00, 45.00, 56.00, NULL, 3, '2024-12-20 05:51:59', NULL, '2024-12-30 05:51:45', 1, 'SMP0001', 'TATA', 'TATA101@GMAIL.COM', '9955599655', '9944556699', '99, ORTGH RTO', '395001', 3, 'SMP0003', 'TCS', 'TCS@GMAIL.COM', '9659155999', '9655151599', '98, RDFCXV LLT', '395009', '75% ADVANCE 25% BEFORE DELIVERY', 'DFCVV', 'WSZZZ', 'hfhfd', 'GRGER'),
(14, 'US', '2024-12-27', '2025-01', 'SMPL9', '2025-01-01', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'USD', 'DFGHBNMJKL5559955', 12345678.00, 105.00, 55.00, 555.00, 2, '2024-12-27 05:40:52', 2, '2025-01-21 04:07:17', 5, 'SMP0005', 'CAPGEMINI', 'CAPGEMINI@GMAIL.COM', '9955664455', 'HRGSFGSFS8885', '569, GFHDJFSHJ', '2356895623568923568998655', 6, 'SMP0006', 'TYU', 'TYU@GMAIL.COM', '8956235698', 'SDGSGSGS4545', '899, EEYETWT', '395001', '75% ADVANCE 25% BEFORE DELIVERY', 'DFCVBNM', 'SDFCVBN', 'ssdfdfrrrr', 'ERRRRTTTT'),
(15, 'US', '2025-01-03', '2025-02', 'SMPL10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'USD', '51515599', 50.00, 540.00, 50.00, 50.00, 2, '2025-01-03 03:13:10', 1, '2025-02-19 04:53:09', 1, 'SMP0001', 'TATA', 'TATA101@GMAIL.COM', '9955599655', 'RGRGRGRGR55', '99, ORTGH RTO', '395005', 3, 'SMP0003', 'TCS', 'TCS@GMAIL.COM', '9659155999', 'RFGHHYUHH55', '98, RDFCXV LLT', '395006', '50% ADVANCE 50% BEFORE DELIVERY', 'hrfgbegte', 'erhsauf355', 'vmsfwiu51', 'gnfjashf55'),
(17, 'US', '2025-01-09', '2025-01', 'SMPL12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EURO', 'SMLPI5', 55.00, 105.00, 59.00, 55.00, 2, '2025-01-09 01:28:04', 2, '2025-01-31 03:04:25', 2, 'SMP0002', 'CAP', 'CAP101@GMAIL.COM', '9959191999', '9965555619', '59, ERT LLTP', '395005', 4, 'SMP0004', 'SF', 'SF101@GMAIL.COM', '9959090959', '9685555699', '15, RVN TTGS LLP', '395006', '100% ADVANCE BEFORE DELIVERY', 'HHDGHD', 'GDGGE', NULL, 'GEGEEG'),
(18, 'US', '2025-01-09', '2025-01', 'SMPL13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EURO', 'NGFFFRHT756765', 105.00, NULL, NULL, NULL, 2, '2025-01-09 02:25:14', 2, '2025-01-31 06:45:11', 2, 'SMP0002', 'CAP', 'CAP101@GMAIL.COM', '9959191999', '9965555619', '59, ERT LLTP', '395005', 4, 'SMP0004', 'SF', 'SF101@GMAIL.COM', '9959090959', '9685555699', '15, RVN TTGS LLP', '395006', '75% ADVANCE 25% BEFORE DELIVERY', 'YHREYREY54Y', 'YHHRER5Y5', 'hre54y', 'GH554HRHRE'),
(21, 'US', '2025-01-31', '2025-02', 'SMPL16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'USD', '55945FGDFSD', NULL, NULL, NULL, NULL, 2, '2025-01-31 05:27:14', 1, '2025-02-19 05:47:13', 1, 'SMP0001', 'TATA', 'TATA101@GMAIL.COM', '9955599655', 'RGRGRGRGR55', '99, ORTGH RTO', '395005', 3, 'SMP0003', 'TCS', 'TCS@GMAIL.COM', '9659155999', 'RFGHHYUHH55', '98, RDFCXV LLT', '395006', '75% ADVANCE 25% BEFORE DELIVERY', 'VSDVVSVSVSVSVSVSVSVSVSVSVDGHT5RHUREJGKHIORETGOEIGHDGHREGFNGJHGOUIREHGUREGKDFGJNKHJFIKHJRHIREJHRKELGJFLGJREIOGRUT9OIR4HTJKEHGKJREHGOIREHGNDFS,NVREUIOGEJKVSDANGKJDGBKJSDGHDSUIOGHEWGKJDSBGEGHEUIOGHEWGGNREJGEGHEWIGUHEWIGUEHJGKSNDVJSANFUIEWHGUIWEFGNSFEWTEGWKJJ', 'VSDVVSVSVSVSVSVSVSVSVSVSVDGHT5RHUREJGKHIORETGOEIGHDGHREGFNGJHGOUIREHGUREGKDFGJNKHJFIKHJRHIREJHRKELGJFLGJREIOGRUT9OIR4HTJKEHGKJREHGOIREHGNDFS,NVREUIOGEJKVSDANGKJDGBKJSDGHDSUIOGHEWGKJDSBGEGHEUIOGHEWGGNREJGEGHEWIGUHEWIGUEHJGKSNDVJSANFUIEWHGUIWEFGNSFEWTEGWKJJ', 'GDJGSIGJIGOEWKU9IWOFHDSJFKSGFSFGSAFSAGFFKGASKSFGSIFGSAIYFGSAFSAGFISAGUFSAGFIUSFGASGIFUSAGIUFASIGFIJJ', 'VSDVVSVSVSVSVSVSVSVSVSVSVDGHT5RHUREJGKHIORETGOEIGHDGHREGFNGJHGOUIREHGUREGKDFGJNKHJFIKHJRHIREJHRKELGJFLGJREIOGRUT9OIR4HTJKEHGKJREHGOIREHGNDFS,NVREUIOGEJKVSDANGKJDGBKJSDGHDSUIOGHEWGKJDSBGEGHEUIOGHEWGGNREJGEGHEWIGUHEWIGUEHJGKSNDVJSANFUIEWHGUIWEFGNSFEWTEGWKJJ'),
(23, 'US', '2025-01-31', '2025-01', 'SMPL18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'AED', 'AF', NULL, NULL, NULL, NULL, 2, '2025-01-31 06:50:53', NULL, '2025-01-31 06:51:04', 8, 'SMP0007', 'SASSIFY', 'SASSIFY@GMAIL.COM', '9955662299', 'RFSFRWFW55', '3569, ASDFG', '395005', 9, 'SMP0008', 'SALSFORCE', 'SALSFORCE@GMAIL.COM', '8956235689', 'GFSFSWWWWRT7889', '1256, GFHFSJWUW', '395006', '50% ADVANCE 50% BEFORE DELIVERY', 'AA', 'AA', 'aa', 'AA'),
(28, 'US', '2025-02-19', '2025-02', 'SMPL23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EURO', '', NULL, NULL, NULL, NULL, 1, '2025-02-19 05:33:15', 1, '2025-02-19 05:47:59', 2, 'SMP0002', 'CAP', 'CAP101@GMAIL.COM', '9959191999', '9965555619', '59, ERT LLTP', '395005', 4, 'SMP0004', 'SF', 'SF101@GMAIL.COM', '9959090959', '9685555699', '15, RVN TTGS LLP', '395006', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_packages`
--

CREATE TABLE `order_packages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `box_no` varchar(255) DEFAULT NULL,
  `dimension` varchar(255) DEFAULT NULL,
  `gross_weight` decimal(10,2) DEFAULT NULL,
  `net_weight` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_packages`
--

INSERT INTO `order_packages` (`id`, `order_id`, `box_no`, `dimension`, `gross_weight`, `net_weight`, `created_at`, `updated_at`) VALUES
(2, 4, 'BOX-1', '10*10*10', 110.00, 110.00, '2024-12-10 03:24:48', '2024-12-11 04:30:57'),
(3, 4, 'BOX-2', '105*105*105', 105.00, 105.00, '2024-12-11 03:10:08', '2024-12-11 04:30:57'),
(6, 5, 'BOX-1', '9*9*9', 105.00, 505.00, '2024-12-19 03:48:11', '2024-12-25 23:07:40'),
(7, 5, 'BOX-2', '5*5*5', 50.00, 51.00, '2024-12-19 03:48:11', '2024-12-25 23:07:41'),
(12, 7, 'BOX-1', '5*9*5', 105.00, 155.00, '2024-12-30 05:05:49', '2024-12-30 05:33:55'),
(14, 11, 'BOX-1', '155', 158.00, 106.00, '2024-12-31 04:24:35', '2025-01-01 01:41:22'),
(15, 11, 'BOX-2', '105*105*105', 105.00, 1055.00, '2025-01-01 01:41:04', '2025-01-01 01:41:22'),
(24, 14, 'BOX-3', '5', 105.00, 106.00, '2025-01-03 02:23:57', '2025-01-08 01:13:32'),
(25, 14, 'BOX-2', '5*5*5', 50.00, 51.00, '2025-01-03 02:23:58', '2025-01-08 01:13:32'),
(32, 17, 'BOX-1', '9*9*9', 105.00, 50.00, '2025-01-31 04:24:06', '2025-01-31 05:06:57'),
(87, 15, 'BOX-1', '1*1*1', 1.00, 1.00, '2025-02-12 04:02:28', '2025-02-21 04:55:29'),
(88, 15, 'BOX-2', '2*2*2', 2.00, 2.00, '2025-02-12 04:02:28', '2025-02-21 04:55:29'),
(89, 15, 'BOX-3', '3*3*3', 3.00, 3.00, '2025-02-12 04:02:28', '2025-02-21 04:55:29'),
(90, 15, 'BOX-4', '15*15*15', 25.00, 15.00, '2025-02-12 04:02:28', '2025-02-21 04:55:29'),
(91, 15, 'BOX-5', '5*5*5', 5.00, 5.00, '2025-02-12 04:02:28', '2025-02-21 04:55:29');

-- --------------------------------------------------------

--
-- Table structure for table `order_package_products`
--

CREATE TABLE `order_package_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_package_id` bigint(20) UNSIGNED NOT NULL,
  `order_product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_package_products`
--

INSERT INTO `order_package_products` (`id`, `order_package_id`, `order_product_id`, `quantity`, `created_at`, `updated_at`) VALUES
(3, 2, 3, 1, '2024-12-10 03:24:48', '2024-12-11 04:30:57'),
(4, 2, 4, 2, '2024-12-10 03:24:48', '2024-12-11 04:30:57'),
(5, 3, 12, 1, '2024-12-11 03:10:08', '2024-12-11 04:30:57'),
(6, 3, 10, 2, '2024-12-11 03:10:08', '2024-12-11 04:30:57'),
(7, 3, 9, 3, '2024-12-11 03:10:08', '2024-12-11 04:30:57'),
(8, 3, 8, 4, '2024-12-11 03:10:09', '2024-12-11 04:30:57'),
(9, 3, 7, 5, '2024-12-11 03:10:09', '2024-12-11 04:30:57'),
(10, 3, 6, 6, '2024-12-11 03:10:09', '2024-12-11 04:30:57'),
(11, 3, 5, 7, '2024-12-11 03:10:09', '2024-12-11 04:30:57'),
(12, 3, 4, 8, '2024-12-11 03:10:09', '2024-12-11 04:30:57'),
(13, 3, 3, 9, '2024-12-11 03:10:09', '2024-12-11 04:30:57'),
(14, 2, 5, 3, '2024-12-11 03:10:09', '2024-12-11 04:30:57'),
(15, 2, 6, 4, '2024-12-11 03:10:09', '2024-12-11 04:30:57'),
(16, 2, 7, 5, '2024-12-11 03:10:09', '2024-12-11 04:30:57'),
(17, 2, 8, 6, '2024-12-11 03:10:09', '2024-12-11 04:30:57'),
(18, 2, 9, 7, '2024-12-11 03:10:09', '2024-12-11 04:30:57'),
(19, 2, 10, 8, '2024-12-11 03:10:09', '2024-12-11 04:30:57'),
(20, 2, 11, 9, '2024-12-11 03:10:09', '2024-12-11 04:30:57'),
(21, 2, 12, 10, '2024-12-11 03:10:09', '2024-12-11 04:30:57'),
(40, 6, 14, 105, '2024-12-19 03:48:11', '2024-12-25 23:07:41'),
(41, 7, 14, 59, '2024-12-19 03:48:11', '2024-12-25 23:07:41'),
(47, 12, 17, 155, '2024-12-30 05:05:49', '2024-12-30 05:26:02'),
(48, 12, 17, 199, '2024-12-30 05:05:49', '2024-12-30 05:05:49'),
(49, 12, 16, 1005, '2024-12-30 05:33:55', '2024-12-30 05:33:55'),
(50, 12, 17, 1055, '2024-12-30 05:33:56', '2024-12-30 05:33:56'),
(52, 14, 21, 59, '2024-12-31 04:24:35', '2024-12-31 07:51:39'),
(53, 14, 21, 159, '2025-01-01 01:24:23', '2025-01-01 01:40:08'),
(54, 14, 21, 1005, '2025-01-01 01:32:09', '2025-01-01 01:32:09'),
(55, 15, 21, 55, '2025-01-01 01:41:04', '2025-01-01 01:41:22'),
(90, 24, 64, 12, '2025-01-03 02:23:57', '2025-01-03 02:23:57'),
(91, 24, 73, 12, '2025-01-03 02:23:57', '2025-01-03 02:23:57'),
(92, 25, 64, 12, '2025-01-03 02:23:58', '2025-01-03 02:23:58'),
(93, 25, 73, 12, '2025-01-03 02:23:58', '2025-01-03 02:23:58'),
(98, 24, 64, 1005, '2025-01-08 00:06:38', '2025-01-08 00:06:38'),
(100, 24, 74, 55, '2025-01-08 00:12:56', '2025-01-08 00:12:56'),
(103, 32, 104, 551, '2025-01-31 04:24:06', '2025-01-31 04:24:34'),
(106, 32, 102, 5555, '2025-01-31 05:05:52', '2025-01-31 05:05:52'),
(236, 87, 78, 1, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(237, 88, 79, 720, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(238, 89, 78, 280, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(239, 89, 116, 44, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(240, 90, 78, 11, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(241, 90, 79, 22, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(242, 90, 116, 33, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(243, 90, 117, 44, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(244, 90, 118, 55, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(245, 90, 119, 66, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(246, 90, 120, 77, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(247, 91, 78, 10, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(248, 91, 79, 20, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(249, 91, 116, 30, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(250, 91, 117, 40, '2025-02-12 04:02:28', '2025-02-12 04:02:28'),
(267, 91, 123, 51, '2025-02-21 04:55:29', '2025-02-21 04:55:29');

-- --------------------------------------------------------

--
-- Table structure for table `order_products`
--

CREATE TABLE `order_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `product_variant_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `is_order_placed` enum('yes','no','error') DEFAULT NULL,
  `note` text DEFAULT NULL,
  `expected_delivery_date` date DEFAULT NULL,
  `price_per_set` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_products`
--

INSERT INTO `order_products` (`id`, `order_id`, `product_id`, `product_variant_id`, `quantity`, `is_order_placed`, `note`, `expected_delivery_date`, `price_per_set`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 5, 'yes', NULL, '2024-11-30', 5.00, 25.00, '2024-11-29 03:29:16', '2024-11-29 04:59:14'),
(2, 1, 2, 4, 9, NULL, NULL, NULL, 9.00, 81.00, '2024-11-29 03:29:16', '2024-11-29 03:29:16'),
(3, 4, 8, 15, 101, 'yes', NULL, '2024-12-14', 1.00, 101.00, '2024-12-10 03:10:30', '2024-12-11 03:00:38'),
(4, 4, 9, 18, 102, 'yes', NULL, '2024-12-17', 2.00, 204.00, '2024-12-10 03:10:30', '2024-12-11 03:00:38'),
(5, 4, 1, 1, 103, 'yes', NULL, '2024-12-26', 3.00, 309.00, '2024-12-11 03:00:38', '2024-12-26 01:05:46'),
(6, 4, 2, 4, 104, NULL, NULL, NULL, 4.00, 416.00, '2024-12-11 03:00:38', '2024-12-11 03:00:38'),
(7, 4, 3, 6, 105, NULL, NULL, NULL, 5.00, 525.00, '2024-12-11 03:00:38', '2024-12-11 03:00:38'),
(8, 4, 4, 7, 106, NULL, NULL, NULL, 6.00, 636.00, '2024-12-11 03:00:38', '2024-12-11 03:00:38'),
(9, 4, 5, 10, 107, NULL, NULL, NULL, 7.00, 749.00, '2024-12-11 03:00:38', '2024-12-11 03:00:38'),
(10, 4, 6, 12, 108, NULL, NULL, NULL, 8.00, 864.00, '2024-12-11 03:00:38', '2024-12-11 03:00:38'),
(11, 4, 7, 13, 109, NULL, NULL, NULL, 9.00, 981.00, '2024-12-11 03:00:38', '2024-12-11 03:00:38'),
(12, 4, 7, 14, 110, NULL, NULL, NULL, 10.00, 1100.00, '2024-12-11 03:00:38', '2024-12-11 03:00:38'),
(13, 5, 9, 17, 5, 'yes', NULL, '2024-12-26', 5.00, 25.00, '2024-12-19 03:26:19', '2024-12-26 02:26:16'),
(14, 5, 11, 21, 505, 'yes', NULL, '2024-12-15', 5.00, 2525.00, '2024-12-19 03:26:19', '2024-12-26 02:26:16'),
(16, 7, 6, 11, 55, 'yes', NULL, '2024-12-25', 5.00, 275.00, '2024-12-19 04:50:47', '2024-12-26 01:33:42'),
(17, 7, 5, 10, 9, 'yes', NULL, '2024-12-15', 9.00, 81.00, '2024-12-19 04:50:47', '2024-12-26 01:33:42'),
(21, 11, 11, 21, 56, 'yes', NULL, '2024-12-20', 5.00, 280.00, '2024-12-19 05:25:04', '2024-12-19 06:50:07'),
(25, 12, 4, 8, 55, 'yes', NULL, '2025-01-05', 5.00, 275.00, '2024-12-26 05:11:55', '2024-12-30 02:39:40'),
(61, 12, 3, 6, 105, 'yes', NULL, '2025-01-05', 5.00, 525.00, '2024-12-27 05:33:57', '2024-12-30 06:15:04'),
(62, 14, 4, 7, 12345689, 'yes', NULL, '2025-01-01', 1.00, 12345689.00, '2024-12-27 05:41:24', '2025-01-09 05:48:37'),
(64, 14, 3, 6, 2, 'yes', NULL, '2025-01-05', 1.00, 1.00, '2024-12-27 05:59:04', '2025-01-09 05:44:43'),
(71, 12, 9, 17, 55, 'no', 'FSFS', NULL, 5.00, 275.00, '2024-12-30 05:51:02', '2024-12-30 05:55:28'),
(72, 12, 7, 14, 155, 'no', 'GEE', NULL, 55.00, 8525.00, '2024-12-30 05:51:02', '2024-12-30 05:55:28'),
(73, 14, 4, 7, 105, 'yes', NULL, '2026-01-15', 5.00, 525.00, '2025-01-02 03:51:46', '2025-01-08 05:04:45'),
(74, 14, 1, 1, 55, 'yes', NULL, '2025-01-16', 5.00, 275.00, '2025-01-07 00:48:48', '2025-01-21 04:15:55'),
(78, 15, 1, 1, 55, 'yes', NULL, '2025-02-05', 5.00, 275.00, '2025-01-08 06:12:23', '2025-02-03 01:04:18'),
(79, 15, 2, 3, 505, 'yes', NULL, '2025-02-13', 5.00, 2525.00, '2025-01-08 06:12:23', '2025-02-11 22:24:09'),
(85, 17, 1, 1, 105, 'yes', NULL, '2025-01-23', 55.00, 5775.00, '2025-01-09 01:28:04', '2025-01-23 00:03:56'),
(86, 18, 1, 1, 15, NULL, NULL, NULL, 5.00, 75.00, '2025-01-09 02:25:26', '2025-01-31 06:45:10'),
(95, 14, 9, 17, 155, 'yes', NULL, '2025-01-18', 5.00, 775.00, '2025-01-09 03:58:16', '2025-01-21 04:15:55'),
(98, 17, 2, 3, 505, 'yes', NULL, '2025-01-31', 5.00, 2525.00, '2025-01-23 03:35:52', '2025-01-31 04:13:00'),
(99, 17, 3, 6, 505, NULL, NULL, NULL, 5.00, 2525.00, '2025-01-23 03:35:52', '2025-01-23 03:35:52'),
(100, 17, 4, 7, 1055, NULL, NULL, NULL, 5.00, 5275.00, '2025-01-23 03:35:52', '2025-01-31 00:22:26'),
(101, 17, 5, 9, 51, NULL, NULL, NULL, 5.00, 255.00, '2025-01-23 03:35:52', '2025-01-31 00:49:53'),
(102, 17, 6, 12, 505, NULL, NULL, NULL, 5.00, 2525.00, '2025-01-23 03:35:52', '2025-01-23 03:35:52'),
(103, 17, 6, 12, 505, NULL, NULL, NULL, 5.00, 2525.00, '2025-01-23 03:35:52', '2025-01-23 03:35:52'),
(104, 17, 7, 13, 505, NULL, NULL, NULL, 5.00, 2525.00, '2025-01-23 03:35:52', '2025-01-23 03:35:52'),
(105, 17, 8, 15, 505, NULL, NULL, NULL, 5.00, 2525.00, '2025-01-23 03:35:52', '2025-01-23 03:35:52'),
(106, 17, 9, 17, 55, NULL, NULL, NULL, 5.00, 275.00, '2025-01-23 03:35:52', '2025-01-31 00:58:37'),
(107, 17, 10, 19, 105, NULL, NULL, NULL, 5.00, 525.00, '2025-01-23 03:35:52', '2025-01-31 03:04:25'),
(108, 17, 11, 21, 15, NULL, NULL, NULL, 5.00, 75.00, '2025-01-23 03:35:52', '2025-01-30 23:53:13'),
(109, 21, 3, 5, 55, 'yes', NULL, '2025-02-15', 5.00, 275.00, '2025-01-31 05:27:27', '2025-02-15 07:18:34'),
(116, 15, 3, 5, 501, 'yes', NULL, '2025-02-14', 5.00, 2505.00, '2025-02-11 22:23:44', '2025-02-11 22:24:09'),
(117, 15, 8, 15, 15, 'yes', NULL, '2025-02-15', 5.00, 75.00, '2025-02-11 22:23:44', '2025-02-11 22:24:09'),
(118, 15, 11, 22, 25, 'yes', NULL, '2025-02-15', 5.00, 125.00, '2025-02-11 22:23:44', '2025-02-11 22:24:09'),
(119, 15, 16, 45, 35, 'yes', NULL, '2025-02-15', 5.00, 175.00, '2025-02-11 22:23:44', '2025-02-11 22:24:09'),
(120, 15, 21, 53, 75, 'yes', NULL, '2025-02-15', 5.00, 375.00, '2025-02-11 22:39:44', '2025-02-11 22:40:12'),
(121, 15, 22, 62, 105, NULL, NULL, NULL, 5.00, 525.00, '2025-02-17 01:09:22', '2025-02-17 01:09:22'),
(123, 15, 30, 71, 55, NULL, NULL, NULL, 5.00, 275.00, '2025-02-17 01:10:20', '2025-02-17 01:10:20'),
(125, 15, 31, 72, 15, NULL, NULL, NULL, 5.00, 75.00, '2025-02-18 00:06:24', '2025-02-18 00:06:24');

-- --------------------------------------------------------

--
-- Table structure for table `order_product_stocks`
--

CREATE TABLE `order_product_stocks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_product_id` bigint(20) UNSIGNED NOT NULL,
  `is_stock_received` enum('yes','no') DEFAULT NULL,
  `batch_no` varchar(255) DEFAULT NULL,
  `mfg_date` varchar(255) DEFAULT NULL,
  `exp_date` varchar(255) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `is_purchase_entry_done` enum('yes','pending') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_product_stocks`
--

INSERT INTO `order_product_stocks` (`id`, `order_product_id`, `is_stock_received`, `batch_no`, `mfg_date`, `exp_date`, `quantity`, `is_purchase_entry_done`, `created_at`, `updated_at`) VALUES
(1, 1, 'yes', '5', '2024-12', '2024-12', 5, NULL, '2024-12-01 23:00:44', '2024-12-01 23:01:45'),
(2, 3, 'yes', 'BOX-1', '2024-01', '2025-12', 55, 'yes', '2024-12-10 03:14:53', '2024-12-10 03:15:36'),
(3, 3, 'yes', 'BOX-2', '2024-02', '2025-11', 105, 'yes', '2024-12-10 03:14:53', '2024-12-10 03:15:36'),
(4, 4, 'yes', 'BOX-1', '2024-12', '2025-12', 55, 'yes', '2024-12-10 03:15:26', '2024-12-10 03:15:42'),
(5, 13, 'yes', 'BOX-1', '2024-12', '2024-11', 105, 'yes', '2024-12-19 03:40:39', '2024-12-25 05:43:40'),
(6, 14, 'yes', 'BOX-1', '2025-12', '2024-11', 1956, 'yes', '2024-12-19 03:41:11', '2024-12-25 05:37:53'),
(7, 21, 'yes', 'BOX-1', '2024-12', '2024-12', 55, 'yes', '2024-12-19 23:53:56', '2024-12-20 01:04:59'),
(8, 13, 'yes', 'BOX-2', '2024-01', '2025-01', 559, NULL, '2024-12-25 05:44:30', '2024-12-25 05:45:47'),
(50, 14, 'yes', 'BOX-2', '2024-12', '2024-12', 155, NULL, '2024-12-26 06:35:30', '2024-12-26 06:35:30'),
(51, 16, 'yes', 'BOX-1', '2024-12', '2025-11', 155, 'yes', '2024-12-30 03:18:21', '2024-12-30 04:16:51'),
(52, 25, 'yes', 'BOX-1', '2024-12', '2025-11', 105, 'yes', '2024-12-30 06:16:26', '2024-12-31 05:29:38'),
(53, 25, 'yes', 'BOXX-2', '2024-11', '2025-11', 155, 'yes', '2024-12-30 06:16:26', '2024-12-31 05:29:38'),
(54, 61, 'yes', 'BOX-1', '2024-11', '2025-12', 105, 'yes', '2024-12-30 06:28:16', '2024-12-31 05:31:06'),
(55, 61, 'yes', 'BOX-2', '2024-07', '2025-10', 55, 'yes', '2024-12-30 06:29:11', '2024-12-31 05:31:07'),
(56, 62, 'yes', 'BOX-1', '2025-01', '2025-12', 15, 'yes', '2025-01-01 03:50:44', '2025-01-07 06:05:23'),
(57, 64, 'yes', 'BOX-1', '2025-01', '2025-11', 105, 'yes', '2025-01-01 03:51:00', '2025-01-01 03:51:23'),
(58, 73, 'yes', 'BOX-1', '2025-02', '2025-04', 55, 'yes', '2025-01-02 04:17:06', '2025-01-02 04:48:26'),
(59, 73, 'yes', 'BOX-2', '2025-01', '2025-12', 1055, 'yes', '2025-01-02 04:17:06', '2025-01-02 04:49:37'),
(62, 74, 'yes', 'BOX-1', '2024-03', '2025-03', 12225555, 'yes', '2025-01-07 06:31:09', '2025-01-21 04:16:23'),
(73, 74, 'yes', 'BOX-2', '2025-08', '2025-07', 4588888, 'yes', '2025-01-09 00:55:24', '2025-01-21 04:16:23'),
(74, 95, 'yes', 'BOX-1', '2025-02', '2025-02', 55, 'yes', '2025-01-21 04:16:12', '2025-01-21 04:16:29'),
(75, 85, 'yes', 'BOX-1', '2025-01', '2025-11', 55, 'yes', '2025-01-31 04:17:53', '2025-01-31 04:20:38'),
(76, 78, 'yes', 'BOX-1', '2025-01', '2025-10', 55, 'yes', '2025-02-03 01:04:34', '2025-02-11 22:40:20'),
(78, 79, 'yes', 'BOX-2', '2025-01', '2025-11', 5, 'yes', '2025-02-11 22:24:31', '2025-02-11 22:40:25'),
(79, 116, 'yes', 'BOX-3', '2025-02', '2025-12', 55, 'yes', '2025-02-11 22:24:59', '2025-02-11 22:40:34'),
(80, 117, 'yes', 'BOX-4', '2025-06', '2025-12', 501, 'yes', '2025-02-11 22:25:16', '2025-02-11 22:40:39'),
(81, 118, 'yes', 'BOX-5', '2025-01', '2025-11', 551, 'yes', '2025-02-11 22:25:33', '2025-02-11 22:40:44'),
(82, 119, 'yes', 'BOX-6', '2025-01', '2025-12', 55, 'yes', '2025-02-11 22:25:54', '2025-02-11 22:40:48'),
(86, 120, 'yes', 'BOX-1', '2025-07', '2025-12', 55, 'yes', '2025-02-17 03:45:52', '2025-02-19 00:45:36');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `category`, `created_at`, `updated_at`) VALUES
(1, 'user-list', 'web', 'user', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(2, 'user-create', 'web', 'user', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(3, 'user-edit', 'web', 'user', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(4, 'user-delete', 'web', 'user', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(5, 'user-reset-password', 'web', 'user', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(6, 'role-list', 'web', 'role', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(7, 'role-create', 'web', 'role', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(8, 'role-edit', 'web', 'role', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(9, 'role-delete', 'web', 'role', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(10, 'order-list', 'web', 'order', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(11, 'order-create', 'web', 'order', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(12, 'order-edit', 'web', 'order', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(13, 'order-delete', 'web', 'order', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(14, 'bd-department-list', 'web', 'bd-department', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(15, 'bd-department-edit', 'web', 'bd-department', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(16, 'purchase-department-edit', 'web', 'purchase-department', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(17, 'wareHouse-department-edit', 'web', 'wareHouse-department', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(18, 'billing-edit', 'web', 'billing', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(19, 'wareHouse-packing-list-edit', 'web', 'wareHouse-packing-list', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(20, 'logistic-department-edit', 'web', 'logistic-department', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(21, 'product-list', 'web', 'product', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(22, 'product-create', 'web', 'product', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(23, 'product-edit', 'web', 'product', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(24, 'product-delete', 'web', 'product', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(25, 'customer-list', 'web', 'customer', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(26, 'customer-create', 'web', 'customer', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(27, 'customer-edit', 'web', 'customer', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(28, 'customer-delete', 'web', 'customer', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(29, 'bank-list', 'web', 'bank', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(30, 'bank-create', 'web', 'bank', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(31, 'bank-edit', 'web', 'bank', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(32, 'bank-delete', 'web', 'bank', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(33, 'proforma-list', 'web', 'proforma', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(34, 'proforma-create', 'web', 'proforma', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(35, 'proforma-edit', 'web', 'proforma', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(36, 'proforma-delete', 'web', 'proforma', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(37, 'vender-list', 'web', 'vender', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(38, 'vender-create', 'web', 'vender', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(39, 'vender-edit', 'web', 'vender', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(40, 'vender-delete', 'web', 'vender', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(41, 'generic-list', 'web', 'generic', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(42, 'generic-create', 'web', 'generic', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(43, 'generic-edit', 'web', 'generic', '2024-11-23 01:14:47', '2024-11-23 01:14:47'),
(44, 'generic-delete', 'web', 'generic', '2024-11-23 01:14:48', '2024-11-23 01:14:48'),
(45, 'manufacturer-list', 'web', 'manufacturer', '2024-11-23 01:14:48', '2024-11-23 01:14:48'),
(46, 'manufacturer-create', 'web', 'manufacturer', '2024-11-23 01:14:48', '2024-11-23 01:14:48'),
(47, 'manufacturer-edit', 'web', 'manufacturer', '2024-11-23 01:14:48', '2024-11-23 01:14:48'),
(48, 'manufacturer-delete', 'web', 'manufacturer', '2024-11-23 01:14:48', '2024-11-23 01:14:48'),
(49, 'inquire-list', 'web', 'inquire', '2024-11-23 01:14:48', '2024-11-23 01:14:48'),
(50, 'inquire-create', 'web', 'inquire', '2024-11-23 01:14:48', '2024-11-23 01:14:48'),
(51, 'inquire-edit', 'web', 'inquire', '2024-11-23 01:14:48', '2024-11-23 01:14:48'),
(52, 'inquire-delete', 'web', 'inquire', '2024-11-23 01:14:48', '2024-11-23 01:14:48'),
(53, 'quotation-list', 'web', 'quotation', '2024-11-23 01:14:48', '2024-11-23 01:14:48'),
(54, 'quotation-create', 'web', 'quotation', '2024-11-23 01:14:48', '2024-11-23 01:14:48'),
(55, 'quotation-edit', 'web', 'quotation', '2024-11-23 01:14:48', '2024-11-23 01:14:48');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `heading` varchar(100) DEFAULT NULL,
  `generic_name` varchar(255) DEFAULT NULL,
  `manufactured_by` varchar(255) DEFAULT NULL,
  `hsn_code` varchar(25) DEFAULT NULL,
  `status` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `heading`, `generic_name`, `manufactured_by`, `hsn_code`, `status`, `created_at`, `updated_at`) VALUES
(1, 'THEOPHYLLINE IP 23 MG + ETOPHYLLINE 77 MG', 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE', 'DERICIP', 'RYGB', 'GHJK', 1, '2024-11-23 01:27:33', '2025-01-23 06:19:26'),
(2, 'AZOMYCIN 500', 'HARMLESS PHARMACEUTICAL MEDICINES FOR ANIMAL USE', 'AZITHROMYCIN 500 MG', 'TYGH', 'RRGH', 1, '2024-11-23 01:29:05', '2024-11-23 01:29:05'),
(3, 'CEFIXIME IP 100 MG', 'HARMLESS PHARMACEUTICAL MEDICINES FOR ANIMAL USE', 'CEFIX 100', 'RFGVB', 'NMJK', 1, '2024-11-23 01:30:03', '2025-01-20 23:35:31'),
(4, 'CEFIXIME IP 200MG + OFLOXACIN IP 200MG', 'HARMLESS PHARMACEUTICAL MEDICINES FOR ANIMAL USE', 'CEFIX - O', 'HJNM', 'FGCV', 1, '2024-11-23 01:30:35', '2025-01-20 23:15:23'),
(5, 'CEFTAZIDIME 1 GM', 'HARMLESS PHARMACEUTICAL MEDICINES FOR ANIMAL USE', 'CEFTAZ-1000MG', 'FDGB', 'DDF', 1, '2024-11-23 01:31:14', '2024-11-23 01:31:14'),
(6, 'AMOXYCILLIN TRIHYDRATE I.P. 250MG', 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE', 'CIPMOX 250 DT', 'VVFG', 'HJK', 1, '2024-11-23 01:32:04', '2024-11-23 01:32:04'),
(7, 'ETORICOXIB IP 60 MG + THIOCOLCHICOXIB IP 4 MG', 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE', 'ETOZOX- T TABS', 'KKH', 'JJN', 1, '2024-11-23 01:32:39', '2024-11-23 01:32:39'),
(8, 'DOXYCYCLINE', 'HARMLESS PHARMACEUTICAL MEDICINES FOR ANIMAL USE', 'EPLERENONE TABLET', 'FGVB', 'GHBNM', 1, '2024-12-03 02:51:56', '2025-01-20 23:37:43'),
(9, 'FARXIGA', 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE', 'LEXAPRO', 'BBVJ', 'RFFC', 1, '2024-12-03 02:52:52', '2024-12-03 02:52:52'),
(10, 'RURVA', 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE', 'ERUPTIBLE', 'ARDETERMINED', 'BLASTLY', 1, '2024-12-13 05:54:29', '2025-02-07 01:17:38'),
(11, 'HOPESWAN', 'HARMLESS PHARMACEUTICAL MEDICINES FOR ANIMAL USE', 'ARDRIVEN', 'HOPEZA', 'BORISIA', 1, '2024-12-13 05:55:24', '2025-02-07 01:18:08'),
(12, 'MONONINE', 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE', 'FACTOR IX', 'DR. VINOD KATIBOINA, PHARM. D', 'RFGVB', 1, '2024-12-16 23:55:10', '2024-12-16 23:55:10'),
(13, 'HUMULIN N U-100', 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE', 'VALACYCLOVIR', 'CIPLA', 'GHBNM', 1, '2024-12-16 23:56:32', '2025-01-23 06:58:10'),
(14, 'L QUIN 500', 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE', 'LEVOFLOXACIN HEMIHYDRATE I.P. 500MG', 'TORRENT PHARMA', 'GHBVNM', 1, '2024-12-17 00:09:37', '2024-12-17 00:09:37'),
(15, 'MONTECIP BL TABS', 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE', 'ACETAZOBILASTINE 20 MG + MONTELUKAST SODIUM IP 10 MGLAMIDE TABLETS IP 250MG', 'RFGVB', 'HHNB', 1, '2024-12-22 23:55:15', '2024-12-22 23:55:15'),
(16, 'ZENDIBOC', 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE', 'ANBONIC', 'ZENDILTOO', 'ASVINIC', 1, '2024-12-27 05:51:40', '2025-02-07 01:22:16'),
(21, 'AYUDFGHYU', 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE', 'HRHRHR', 'DFCXVBN', 'DFGVBN', 1, '2025-01-21 05:49:40', '2025-02-07 01:17:17'),
(22, 'AYUB55', 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE', 'AYUB15', 'AYUB59', 'AYU0005', 1, '2025-01-23 06:46:17', '2025-02-20 06:35:38'),
(26, 'MTYREGEG', 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE', 'H5RHGDG', 'JHTJHBF', 'JTNRT', 1, '2025-02-13 01:22:28', '2025-02-13 01:22:28'),
(27, '76H5DFB', 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE', 'BNTRBBE45B', 'N6RDFG', '6NM6TRJFN', 1, '2025-02-13 01:22:41', '2025-02-13 01:22:41'),
(29, 'AYUB1', 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE', 'AYUB1', 'AYUB1', 'AYUB1', 1, '2025-02-14 05:43:31', '2025-02-14 05:43:31'),
(30, 'AYUB2A', 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE', 'AYUB2A', 'AYUB2A', 'AYUB2A', 1, '2025-02-14 05:44:09', '2025-02-14 05:44:09'),
(31, 'AYUB3A', 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE', 'AYUB3A', 'AYUB3A', 'AYUB3A', 1, '2025-02-14 05:44:22', '2025-02-14 05:44:41'),
(32, 'AYUB4A', 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE', 'AYUB4A', 'AYUB4A', 'AYUB4A', 1, '2025-02-14 05:44:54', '2025-02-14 05:44:54'),
(33, 'AYUB5A', 'HARMLESS PHARMACEUTICAL MEDICINES FOR ANIMAL USE', 'AYUB5A', 'AYUB5A', 'AYUB5A', 1, '2025-02-14 05:45:08', '2025-02-14 05:45:08'),
(34, 'AYUB6AA', 'HARMLESS PHARMACEUTICAL MEDICINES FOR ANIMAL USE', 'AYUB6AA', 'AYUB6AA', 'AYUB6AA', 1, '2025-02-14 05:45:34', '2025-02-14 05:45:34'),
(35, 'AYUB7AA', 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE', 'AYUB7AA', 'AYUB7AA', 'AYUB7AA', 1, '2025-02-14 05:45:47', '2025-02-14 05:45:47'),
(36, 'ARTO', 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE', 'ARTO', 'ARTO', 'ARTO', 1, '2025-02-15 05:48:08', '2025-02-20 06:36:42');

-- --------------------------------------------------------

--
-- Table structure for table `product_documents`
--

CREATE TABLE `product_documents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quotation_id` bigint(20) UNSIGNED DEFAULT NULL,
  `document` varchar(255) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_documents`
--

INSERT INTO `product_documents` (`id`, `quotation_id`, `document`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(15, 11, '1732519372_674425cc2241d.pdf', 1, '2024-11-25 01:52:52', NULL, '2024-11-25 01:52:52'),
(19, 15, '1732525508_67443dc438b89.pdf', 1, '2024-11-25 03:35:08', NULL, '2024-11-25 03:35:08'),
(21, 17, '1733112857_674d3419a4bce.pdf', 3, '2024-12-01 22:44:17', NULL, '2024-12-01 22:44:17'),
(22, 18, '1733122788_674d5ae493177.pdf', 2, '2024-12-02 01:29:48', NULL, '2024-12-02 01:29:48'),
(38, 30, '1733302424_675018985790a.pdf', 1, '2024-12-04 03:23:44', NULL, '2024-12-04 03:23:44'),
(42, 34, '1733309091_675032a368b43.pdf', 1, '2024-12-04 05:14:51', NULL, '2024-12-04 05:14:51'),
(108, 111, '1735712925_6774e09d6c68b.pdf', 2, '2025-01-01 00:58:45', NULL, '2025-01-01 00:58:45'),
(148, 110, '1737972445_67975add11a2f.pdf', 2, '2025-01-27 04:37:25', NULL, '2025-01-27 04:37:25'),
(150, 151, '1737977586_67976ef274f8b.pdf', 2, '2025-01-27 06:03:06', NULL, '2025-01-27 06:03:06'),
(161, 188, '1738728290_67a2e36274758.pdf', 2, '2025-02-04 22:34:50', NULL, '2025-02-04 22:34:50'),
(162, 189, '1738728339_67a2e39338ce7.pdf', 2, '2025-02-04 22:35:39', NULL, '2025-02-04 22:35:39'),
(164, 191, '1738730357_67a2eb75cb25c.pdf', 2, '2025-02-04 23:09:17', NULL, '2025-02-04 23:09:17'),
(165, 192, '1738749555_67a3367304c14.pdf', 2, '2025-02-05 04:29:15', NULL, '2025-02-05 04:29:15'),
(166, 193, '1738843719_67a4a6472c424.pdf', 2, '2025-02-06 06:38:39', NULL, '2025-02-06 06:38:39'),
(168, 195, '1738844174_67a4a80e54753.pdf', 2, '2025-02-06 06:46:14', NULL, '2025-02-06 06:46:14'),
(169, 197, '1738844872_67a4aac8858c3.pdf', 2, '2025-02-06 06:57:52', NULL, '2025-02-06 06:57:52'),
(170, 198, '1738906158_67a59a2e73241.pdf', 2, '2025-02-06 23:59:18', NULL, '2025-02-06 23:59:18'),
(173, 201, '1738906754_67a59c8207d04.pdf', 2, '2025-02-07 00:09:14', NULL, '2025-02-07 00:09:14'),
(174, 202, '1738907265_67a59e81240c2.pdf', 2, '2025-02-07 00:17:45', NULL, '2025-02-07 00:17:45'),
(175, 203, '1739335611_67ac27bbe5a08.pdf', 2, '2025-02-11 23:16:51', NULL, '2025-02-11 23:16:51'),
(176, 204, '1739335645_67ac27dd97aa7.pdf', 2, '2025-02-11 23:17:25', NULL, '2025-02-11 23:17:25'),
(177, 205, '1739335684_67ac2804e6ecb.pdf', 2, '2025-02-11 23:18:04', NULL, '2025-02-11 23:18:04'),
(178, 206, '1739335959_67ac29175482a.pdf', 2, '2025-02-11 23:22:39', NULL, '2025-02-11 23:22:39'),
(180, 208, '1739340812_67ac3c0c968a8.pdf', 2, '2025-02-12 00:43:32', NULL, '2025-02-12 00:43:32'),
(181, 209, '1739340852_67ac3c346a824.pdf', 2, '2025-02-12 00:44:12', NULL, '2025-02-12 00:44:12'),
(182, 210, '1739441701_67adc625c02dd.pdf', 2, '2025-02-13 04:45:01', NULL, '2025-02-13 04:45:01'),
(183, 211, '1739441740_67adc64c3d04c.pdf', 2, '2025-02-13 04:45:40', NULL, '2025-02-13 04:45:40'),
(184, 212, '1739441785_67adc679e7995.pdf', 2, '2025-02-13 04:46:25', NULL, '2025-02-13 04:46:25'),
(185, 213, '1739441879_67adc6d7794ac.pdf', 2, '2025-02-13 04:47:59', NULL, '2025-02-13 04:47:59');

-- --------------------------------------------------------

--
-- Table structure for table `product_documents_histories`
--

CREATE TABLE `product_documents_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quotation_history_id` bigint(20) UNSIGNED DEFAULT NULL,
  `document` varchar(255) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_documents_histories`
--

INSERT INTO `product_documents_histories` (`id`, `quotation_history_id`, `document`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, '1732519055_6744248fab50f.pdf', 1, NULL, NULL),
(2, 1, '1732519055_6744248fabf3d.pdf', 1, NULL, NULL),
(3, 2, '1732519102_674424bef10ba.pdf', 1, NULL, NULL),
(4, 3, '1732523616_67443660ad174.pdf', 1, NULL, NULL),
(5, 4, '1732525198_67443c8e9e602.pdf', 1, NULL, NULL),
(6, 5, '1732525198_67443c8ea0932.pdf', 1, NULL, NULL),
(7, 6, '1733112743_674d33a74fa6e.pdf', 3, NULL, NULL),
(9, 8, '1733122962_674d5b92f283b.pdf', 2, NULL, NULL),
(10, 9, '1733197535_674e7edf103e5.pdf', 2, NULL, NULL),
(11, 10, '1733199064_674e84d86af8b.pdf', 2, NULL, NULL),
(12, 11, '1733205273_674e9d19a52f7.pdf', 2, NULL, NULL),
(13, 12, '1733205561_674e9e399ce61.pdf', 2, NULL, NULL),
(14, 13, '1733214616_674ec1984b152.pdf', 2, NULL, NULL),
(15, 13, '1733214616_674ec1984b900.pdf', 2, NULL, NULL),
(16, 14, '1733300013_67500f2d43642.pdf', 1, NULL, NULL),
(17, 14, '1733300013_67500f2d44265.pdf', 1, NULL, NULL),
(18, 16, '1734434607_67615f2f36e28.pdf', 3, NULL, NULL),
(19, 17, '1734435397_67616245d620c.pdf', 3, NULL, NULL),
(20, 18, '1733309598_6750349e424f8.pdf', 1, NULL, NULL),
(21, 19, '1733308615_675030c74bb92.pdf', 1, NULL, NULL),
(22, 20, '1736142907_677b703b9f488.pdf', 2, NULL, NULL),
(23, 21, '1736146046_677b7c7e6db6b.pdf', 2, NULL, NULL),
(24, 22, '1736153770_677b9aaab109e.pdf', 2, NULL, NULL),
(25, 23, '1736241769_677cf269823dc.pdf', 2, NULL, NULL),
(26, 24, '1736398133_677f5535dd7aa.pdf', 2, NULL, NULL),
(27, 25, '1738225169_679b3611bc59d.pdf', 2, NULL, NULL),
(28, 26, '1738225169_679b3611bdc24.pdf', 2, NULL, NULL),
(29, 27, '1737692327_679314a7a35cb.pdf', 2, NULL, NULL),
(30, 28, '1736153879_677b9b174a8ab.pdf', 2, NULL, NULL),
(31, 29, '1736157536_677ba9600cfbc.pdf', 2, NULL, NULL),
(32, 30, '1738240355_679b7163e0ad2.pdf', 2, NULL, NULL),
(33, 31, '1738296504_679c4cb8956d8.pdf', 2, NULL, NULL),
(34, 32, '1738296504_679c4cb8979b7.pdf', 2, NULL, NULL),
(35, 33, '1738297242_679c4f9a1549b.pdf', 2, NULL, NULL),
(36, 34, '1738297671_679c514774751.pdf', 2, NULL, NULL),
(37, 35, '1736335620_677e61041870c.pdf', 2, NULL, NULL),
(38, 38, '1736138361_677b5e79313ba.pdf', 2, NULL, NULL),
(39, 39, '1736138376_677b5e8814beb.pdf', 2, NULL, NULL),
(40, 40, '1734601325_6763ea6dd7682.pdf', 2, NULL, NULL),
(41, 41, '1734601693_6763ebdde24c8.pdf', 2, NULL, NULL),
(42, 42, '1738728958_67a2e5fed6c4c.pdf', 2, NULL, NULL),
(43, 43, '1733805309_6757c4fd84a3d.pdf', 2, NULL, NULL),
(44, 44, '1733302310_67501826292df.pdf', 1, NULL, NULL),
(45, 45, '1733308547_675030837371a.pdf', 1, NULL, NULL),
(46, 46, '1733829862_675824e69297f.pdf', 2, NULL, NULL),
(47, 48, '1738844141_67a4a7ed51633.pdf', 2, NULL, NULL),
(48, 49, '1735883489_67777ae11b9ef.pdf', 2, NULL, NULL),
(49, 50, '1735904389_6777cc85541ab.pdf', 2, NULL, NULL),
(50, 51, '1735904986_6777cedab9ef4.pdf', 2, NULL, NULL),
(51, 52, '1735905873_6777d2519b2c6.pdf', 2, NULL, NULL),
(52, 53, '1736137872_677b5c907dd88.pdf', 2, NULL, NULL),
(53, 54, '1736138044_677b5d3c3ede1.pdf', 2, NULL, NULL),
(54, 55, '1734947659_6769334baac6c.pdf', 2, NULL, NULL),
(55, 56, '1738906344_67a59ae85f611.pdf', 2, NULL, NULL),
(56, 57, '1737432284_678f1cdc76183.pdf', 2, NULL, NULL),
(57, 58, '1738906205_67a59a5d88e61.pdf', 2, NULL, NULL),
(58, 59, '1739339725_67ac37cd9e29e.pdf', 2, NULL, NULL),
(59, 60, '1734945785_67692bf9020ff.pdf', 2, NULL, NULL),
(64, 65, '1734343823_675ffc8fe4378.pdf', 3, NULL, NULL),
(65, 66, '1734435795_676163d38a1f4.pdf', 3, NULL, NULL),
(66, 67, '1735904662_6777cd9694db2.pdf', 2, NULL, NULL),
(67, 68, '1733308247_67502f576017d.pdf', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_photos`
--

CREATE TABLE `product_photos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quotation_id` bigint(20) UNSIGNED DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_photos`
--

INSERT INTO `product_photos` (`id`, `quotation_id`, `photo`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(15, 11, '1732519372_674425cc21045.jpg', 1, '2024-11-25 01:52:52', NULL, '2024-11-25 01:52:52'),
(20, 15, '1732525508_67443dc437499.jpg', 1, '2024-11-25 03:35:08', NULL, '2024-11-25 03:35:08'),
(22, 17, '1733112857_674d3419a3875.jpg', 3, '2024-12-01 22:44:17', NULL, '2024-12-01 22:44:17'),
(23, 18, '1733122788_674d5ae491a68.jpg', 2, '2024-12-02 01:29:48', NULL, '2024-12-02 01:29:48'),
(39, 30, '1733302424_6750189856493.jpg', 1, '2024-12-04 03:23:44', NULL, '2024-12-04 03:23:44'),
(43, 34, '1733309091_675032a3674ac.jpg', 1, '2024-12-04 05:14:51', NULL, '2024-12-04 05:14:51'),
(51, 44, '1734088767_675c183ff22ab.jpg', 2, '2024-12-13 05:49:27', NULL, '2024-12-13 05:49:27'),
(108, 111, '1735712925_6774e09d6b488.jpg', 2, '2025-01-01 00:58:45', NULL, '2025-01-01 00:58:45'),
(150, 110, '1737715282_67936e520ebd2.jpg', 2, '2025-01-24 05:11:22', NULL, '2025-01-24 05:11:22'),
(151, 151, '1737966685_6797445dab967.jfif', 2, '2025-01-27 03:01:25', NULL, '2025-01-27 03:01:25'),
(154, 167, '1738046247_67987b27a1465.jpg', 2, '2025-01-28 01:07:27', NULL, '2025-01-28 01:07:27'),
(167, 188, '1738728290_67a2e36262d1d.jpg', 2, '2025-02-04 22:34:50', NULL, '2025-02-04 22:34:50'),
(168, 189, '1738728339_67a2e39337aba.jpg', 2, '2025-02-04 22:35:39', NULL, '2025-02-04 22:35:39'),
(170, 191, '1738730357_67a2eb75c9f10.jpg', 2, '2025-02-04 23:09:17', NULL, '2025-02-04 23:09:17'),
(171, 192, '1738749555_67a3367303623.jpg', 2, '2025-02-05 04:29:15', NULL, '2025-02-05 04:29:15'),
(172, 193, '1738843719_67a4a6471a004.jpg', 2, '2025-02-06 06:38:39', NULL, '2025-02-06 06:38:39'),
(174, 195, '1738844174_67a4a80e53541.jpg', 2, '2025-02-06 06:46:14', NULL, '2025-02-06 06:46:14'),
(176, 198, '1738906158_67a59a2e7138b.jpg', 2, '2025-02-06 23:59:18', NULL, '2025-02-06 23:59:18'),
(179, 201, '1738906754_67a59c8206ada.jpg', 2, '2025-02-07 00:09:14', NULL, '2025-02-07 00:09:14'),
(180, 202, '1738907265_67a59e8122eed.jpg', 2, '2025-02-07 00:17:45', NULL, '2025-02-07 00:17:45'),
(181, 203, '1739335611_67ac27bbd28c3.jpg', 2, '2025-02-11 23:16:51', NULL, '2025-02-11 23:16:51'),
(182, 204, '1739335645_67ac27dd968c9.jpg', 2, '2025-02-11 23:17:25', NULL, '2025-02-11 23:17:25'),
(183, 205, '1739335684_67ac2804e5a2f.jpg', 2, '2025-02-11 23:18:04', NULL, '2025-02-11 23:18:04'),
(184, 206, '1739335959_67ac29174f56f.jpg', 2, '2025-02-11 23:22:39', NULL, '2025-02-11 23:22:39'),
(186, 208, '1739340812_67ac3c0c9561f.jpg', 2, '2025-02-12 00:43:32', NULL, '2025-02-12 00:43:32'),
(187, 209, '1739340852_67ac3c3469597.jpg', 2, '2025-02-12 00:44:12', NULL, '2025-02-12 00:44:12'),
(188, 210, '1739441701_67adc625ad3bf.jpg', 2, '2025-02-13 04:45:01', NULL, '2025-02-13 04:45:01'),
(189, 211, '1739441740_67adc64c3bd5b.jpg', 2, '2025-02-13 04:45:40', NULL, '2025-02-13 04:45:40'),
(190, 212, '1739441785_67adc679e67f7.jpg', 2, '2025-02-13 04:46:25', NULL, '2025-02-13 04:46:25'),
(191, 213, '1739441879_67adc6d777d23.jpg', 2, '2025-02-13 04:47:59', NULL, '2025-02-13 04:47:59'),
(192, 197, '1739442175_67adc7ff46957.jpeg', 2, '2025-02-13 04:52:55', NULL, '2025-02-13 04:52:55');

-- --------------------------------------------------------

--
-- Table structure for table `product_photos_histories`
--

CREATE TABLE `product_photos_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quotation_history_id` bigint(20) UNSIGNED DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_photos_histories`
--

INSERT INTO `product_photos_histories` (`id`, `quotation_history_id`, `photo`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, '1732519055_6744248fa8526.jpg', 1, NULL, NULL),
(2, 1, '1732519055_6744248faae3b.jpg', 1, NULL, NULL),
(3, 2, '1732519102_674424beefcd8.jpg', 1, NULL, NULL),
(4, 3, '1732523616_67443660abbfe.jpg', 1, NULL, NULL),
(5, 4, '1732525198_67443c8e9c911.jpg', 1, NULL, NULL),
(6, 4, '1732525198_67443c8e9ddbf.jpg', 1, NULL, NULL),
(7, 5, '1732525198_67443c8e9fe6f.jpg', 1, NULL, NULL),
(8, 6, '1733112743_674d33a74d3a1.jpg', 3, NULL, NULL),
(10, 8, '1733122962_674d5b92f139b.jpg', 2, NULL, NULL),
(11, 9, '1733197535_674e7edf0d1bd.jpg', 2, NULL, NULL),
(12, 10, '1733199064_674e84d869ae8.jpg', 2, NULL, NULL),
(13, 11, '1733205273_674e9d19a3ed3.jpg', 2, NULL, NULL),
(14, 12, '1733205561_674e9e399b992.jpg', 2, NULL, NULL),
(15, 13, '1733214616_674ec19849376.jpg', 2, NULL, NULL),
(16, 13, '1733214616_674ec1984aa3c.jpg', 2, NULL, NULL),
(17, 14, '1733300013_67500f2d40924.jpg', 1, NULL, NULL),
(18, 14, '1733300013_67500f2d42f68.jpg', 1, NULL, NULL),
(19, 15, '1734323932_675faedc36c99.jpg', 2, NULL, NULL),
(20, 16, '1734434607_67615f2f35aa7.jpg', 3, NULL, NULL),
(21, 17, '1734434689_67615f8147ab7.jpg', 3, NULL, NULL),
(22, 18, '1733309598_6750349e410c6.jpg', 1, NULL, NULL),
(23, 19, '1733308615_675030c74a943.jpg', 1, NULL, NULL),
(24, 20, '1736142907_677b703b9e1b1.jpg', 2, NULL, NULL),
(25, 21, '1736146046_677b7c7e6c3b0.jpg', 2, NULL, NULL),
(26, 22, '1736153676_677b9a4cbdb94.jpg', 2, NULL, NULL),
(27, 23, '1736241769_677cf26970f09.jpg', 2, NULL, NULL),
(28, 24, '1736398234_677f559a9edd3.jpg', 2, NULL, NULL),
(29, 25, '1738223846_679b30e65d69a.jpg', 2, NULL, NULL),
(30, 26, '1738225169_679b3611bd6b5.jpeg', 2, NULL, NULL),
(31, 27, '1737543336_6790cea8b2337.jpg', 2, NULL, NULL),
(32, 28, '1736153879_677b9b1749388.jpg', 2, NULL, NULL),
(33, 29, '1736157536_677ba960092df.jpg', 2, NULL, NULL),
(34, 30, '1738240355_679b7163d043a.jpg', 2, NULL, NULL),
(35, 31, '1738296504_679c4cb884f30.jpg', 2, NULL, NULL),
(36, 32, '1738296504_679c4cb897428.jpg', 2, NULL, NULL),
(37, 33, '1738297242_679c4f9a140fc.jpg', 2, NULL, NULL),
(38, 34, '1738297671_679c5147732c8.jpg', 2, NULL, NULL),
(39, 35, '1736335620_677e610406df3.png', 2, NULL, NULL),
(40, 36, '1736335645_677e611d162fa.png', 2, NULL, NULL),
(41, 38, '1736138361_677b5e792ffdb.jpg', 2, NULL, NULL),
(42, 39, '1736138317_677b5e4d18298.jpg', 2, NULL, NULL),
(43, 40, '1734601325_6763ea6dc79fb.jpg', 2, NULL, NULL),
(44, 41, '1734601693_6763ebdde1226.jpg', 2, NULL, NULL),
(45, 42, '1738728958_67a2e5fed5965.jpg', 2, NULL, NULL),
(46, 43, '1733805309_6757c4fd7053b.jpg', 2, NULL, NULL),
(47, 44, '1733302310_6750182627c51.jpg', 1, NULL, NULL),
(48, 45, '1733308547_6750308372218.jpg', 1, NULL, NULL),
(49, 46, '1733829862_675824e69143d.jpg', 2, NULL, NULL),
(50, 48, '1738844141_67a4a7ed4faef.jpg', 2, NULL, NULL),
(51, 49, '1735883468_67777accb6915.jpg', 2, NULL, NULL),
(52, 50, '1735883600_67777b5094e1c.jpg', 2, NULL, NULL),
(53, 51, '1735904986_6777cedab884b.jpg', 2, NULL, NULL),
(54, 52, '1735905873_6777d2519a01c.jpg', 2, NULL, NULL),
(55, 53, '1736137872_677b5c906c907.jpg', 2, NULL, NULL),
(56, 54, '1736138021_677b5d254b32e.jpg', 2, NULL, NULL),
(57, 55, '1734947659_6769334ba99da.jpg', 2, NULL, NULL),
(58, 56, '1738906344_67a59ae85e307.jpg', 2, NULL, NULL),
(59, 57, '1737432268_678f1ccc8325a.jpg', 2, NULL, NULL),
(60, 58, '1738906205_67a59a5d87cd0.jpg', 2, NULL, NULL),
(61, 59, '1739339725_67ac37cd90de3.jpg', 2, NULL, NULL),
(66, 65, '1734343030_675ff976ddd7d.jpg', 2, NULL, NULL),
(67, 66, '1734435795_676163d388ddd.jpg', 3, NULL, NULL),
(68, 67, '1735904610_6777cd62085ce.jpg', 2, NULL, NULL),
(69, 68, '1733308247_67502f575ec35.jpg', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_variants`
--

CREATE TABLE `product_variants` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_variants`
--

INSERT INTO `product_variants` (`id`, `product_id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'UUF', 1, '2024-11-23 01:27:33', '2025-01-23 06:19:26'),
(2, 1, 'HJK', 1, '2024-11-23 01:27:33', '2025-01-23 06:19:26'),
(3, 2, 'UIOP', 1, '2024-11-23 01:29:05', '2024-11-23 01:29:05'),
(4, 2, 'DFCV', 1, '2024-11-23 01:29:05', '2024-11-23 01:29:05'),
(5, 3, 'SDF', 1, '2024-11-23 01:30:03', '2025-01-20 23:35:31'),
(6, 3, 'HGJ', 1, '2024-11-23 01:30:03', '2025-01-20 23:35:31'),
(7, 4, 'SDFF', 1, '2024-11-23 01:30:35', '2025-01-20 23:15:23'),
(8, 4, 'HJKLM', 1, '2024-11-23 01:30:35', '2025-01-20 23:15:23'),
(9, 5, 'NNV', 1, '2024-11-23 01:31:14', '2024-11-23 01:31:14'),
(10, 5, 'FFG', 1, '2024-11-23 01:31:14', '2024-11-23 01:31:14'),
(11, 6, 'NNV', 1, '2024-11-23 01:32:04', '2024-11-23 01:32:04'),
(12, 6, 'TTG', 1, '2024-11-23 01:32:04', '2024-11-23 01:32:04'),
(13, 7, 'AAB', 1, '2024-11-23 01:32:39', '2024-11-23 01:32:39'),
(14, 7, 'BBA', 1, '2024-11-23 01:32:39', '2024-11-23 01:32:39'),
(15, 8, 'VASERETIC', 1, '2024-12-03 02:51:56', '2025-01-20 23:37:43'),
(16, 8, 'EPLERENONE TABLE', 1, '2024-12-03 02:51:56', '2025-01-20 23:37:43'),
(17, 9, 'LEXAPRO 5MG', 1, '2024-12-03 02:52:52', '2024-12-03 02:52:52'),
(18, 9, 'NEXIUM', 1, '2024-12-03 02:52:52', '2024-12-03 02:52:52'),
(19, 10, 'DRIVENIST', 1, '2024-12-13 05:54:29', '2025-02-07 01:17:38'),
(20, 10, 'BIGFAZE', 1, '2024-12-13 05:54:29', '2025-02-07 01:17:38'),
(21, 11, 'AMBITIOUSBOX', 1, '2024-12-13 05:55:24', '2025-02-07 01:18:08'),
(22, 11, 'BRIGHTAMBITIOUS', 1, '2024-12-13 05:55:24', '2025-02-07 01:18:08'),
(23, 12, 'BIOCON LIMITED', 1, '2024-12-16 23:55:10', '2024-12-16 23:55:10'),
(24, 12, 'LUPIN LIMITED.', 1, '2024-12-16 23:55:10', '2024-12-16 23:55:10'),
(25, 13, 'DR. REDDY\'S LABORATORIES.', 1, '2024-12-16 23:56:32', '2025-01-23 06:58:10'),
(26, 14, 'EMCURE PHARMACEUTICALS', 1, '2024-12-17 00:09:37', '2024-12-17 00:09:37'),
(27, 15, 'TABLETS', 1, '2024-12-22 23:55:15', '2024-12-22 23:55:15'),
(45, 16, 'ACVFB', 1, '2025-01-16 04:29:27', '2025-02-07 01:22:16'),
(46, 16, 'RTYU', 1, '2025-01-16 04:29:49', '2025-02-07 01:22:16'),
(47, 16, 'BSTTY', 1, '2025-01-16 04:29:49', '2025-02-07 01:22:16'),
(53, 21, 'RRTVH', 1, '2025-01-21 05:49:40', '2025-02-07 01:17:17'),
(58, 21, 'ARGHY', 1, '2025-01-22 23:05:02', '2025-02-07 01:17:17'),
(59, 21, 'BAHGYUI', 1, '2025-01-22 23:05:02', '2025-02-07 01:17:17'),
(60, 21, 'TYGHBNM', 1, '2025-01-22 23:05:02', '2025-02-07 01:17:17'),
(61, 21, 'ERDFVCB', 1, '2025-01-22 23:05:02', '2025-02-07 01:17:17'),
(62, 22, 'AYUBA1', 1, '2025-01-23 06:46:17', '2025-02-20 06:35:38'),
(63, 22, 'AYUBA2', 1, '2025-01-23 06:46:17', '2025-02-20 06:35:38'),
(67, 26, 'NTNTN', 1, '2025-02-13 01:22:28', '2025-02-13 01:22:28'),
(68, 27, 'NYTJTHNFDN', 1, '2025-02-13 01:22:41', '2025-02-13 01:22:41'),
(70, 29, 'AYUB1', 1, '2025-02-14 05:43:31', '2025-02-14 05:43:31'),
(71, 30, 'AYUB2A', 1, '2025-02-14 05:44:09', '2025-02-14 05:44:09'),
(72, 31, 'AYUB3A', 1, '2025-02-14 05:44:22', '2025-02-14 05:44:41'),
(73, 32, 'AYUB4A', 1, '2025-02-14 05:44:54', '2025-02-14 05:44:54'),
(74, 33, 'AYUB5A', 1, '2025-02-14 05:45:08', '2025-02-14 05:45:08'),
(75, 34, 'AYUB6AA', 1, '2025-02-14 05:45:34', '2025-02-14 05:45:34'),
(76, 35, 'AYUB7AA', 1, '2025-02-14 05:45:47', '2025-02-14 05:45:47'),
(77, 36, 'ARTO', 1, '2025-02-15 05:48:08', '2025-02-20 06:36:42'),
(79, 36, 'FFF', 1, '2025-02-20 06:36:42', '2025-02-20 06:36:42');

-- --------------------------------------------------------

--
-- Table structure for table `proformas`
--

CREATE TABLE `proformas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `serve_date` varchar(255) DEFAULT NULL,
  `invoice_no` varchar(255) DEFAULT NULL,
  `invoice_date` date DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `shipping` decimal(10,2) DEFAULT NULL,
  `soft_boxes` decimal(10,2) DEFAULT NULL,
  `data_logger` decimal(10,2) DEFAULT NULL,
  `clearance` decimal(10,2) DEFAULT NULL,
  `payment_terms` varchar(255) DEFAULT NULL,
  `delivery_by` varchar(255) DEFAULT NULL,
  `delivery_time` varchar(255) DEFAULT NULL,
  `delivery_terms` varchar(255) DEFAULT NULL,
  `status` enum('pending','completed') DEFAULT 'pending',
  `bill_to_customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `bill_to_client_code` varchar(255) DEFAULT NULL,
  `bill_to_company_name` varchar(255) DEFAULT NULL,
  `bill_to_email` varchar(100) DEFAULT NULL,
  `bill_to_phone_no` varchar(15) DEFAULT NULL,
  `bill_to_registration_no` varchar(255) DEFAULT NULL,
  `bill_to_address` text DEFAULT NULL,
  `bill_to_zip_code` varchar(25) DEFAULT NULL,
  `ship_to_customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ship_to_client_code` varchar(255) DEFAULT NULL,
  `ship_to_company_name` varchar(255) DEFAULT NULL,
  `ship_to_email` varchar(100) DEFAULT NULL,
  `ship_to_phone_no` varchar(15) DEFAULT NULL,
  `ship_to_registration_no` varchar(255) DEFAULT NULL,
  `ship_to_address` text DEFAULT NULL,
  `ship_to_zip_code` varchar(25) DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `proformas`
--

INSERT INTO `proformas` (`id`, `order_id`, `country`, `order_date`, `serve_date`, `invoice_no`, `invoice_date`, `currency`, `shipping`, `soft_boxes`, `data_logger`, `clearance`, `payment_terms`, `delivery_by`, `delivery_time`, `delivery_terms`, `status`, `bill_to_customer_id`, `bill_to_client_code`, `bill_to_company_name`, `bill_to_email`, `bill_to_phone_no`, `bill_to_registration_no`, `bill_to_address`, `bill_to_zip_code`, `ship_to_customer_id`, `ship_to_client_code`, `ship_to_company_name`, `ship_to_email`, `ship_to_phone_no`, `ship_to_registration_no`, `ship_to_address`, `ship_to_zip_code`, `created_by`, `created_at`, `updated_at`, `updated_by`) VALUES
(1, NULL, 'US', '2024-12-10', '2024-12', 'SMLPI1', '2024-12-10', 'USD', NULL, NULL, NULL, NULL, '50% ADVANCE 50% BEFORE DELIVERY', 'RTHHJ', 'DFGH', 'SSD', 'pending', 1, 'SMP0001', 'TATA', 'TATA101@GMAIL.COM', '9955599655', '9944556699', '99, ORTGH RTO', '395001', 3, 'SMP0003', 'TCS', 'TCS@GMAIL.COM', '9659155999', '9655151599', '98, RDFCXV LLT', '395009', 2, '2024-12-10 02:46:22', '2024-12-27 05:52:21', NULL),
(2, 5, 'US', '2024-12-19', '2024-12', 'SMLPI2', '2024-12-19', 'USD', 50.00, 5.00, 95.00, 5005.00, '100% ADVANCE BEFORE DELIVERY', 'RDFGH', 'FGTUH', 'HJKL', 'completed', 5, 'SMP0005', 'CAPGEMINI', 'CAPGEMINI2GMAIL.COM', '9955664455', 'HRGSFGSFS8885', '569, GFHDJFSHJ', '395006', 6, 'SMP0006', 'TYU', 'TYU@GMAIL.COM', '8956235698', 'SDGSGSGS4545', '899, EEYETWT', '395001', 2, '2024-12-19 03:20:38', '2024-12-19 03:26:19', NULL),
(4, NULL, 'US', '2024-12-31', '2024-12', 'SMLPI4', '2024-12-31', 'EURO', 5.00, 105.00, 55.00, 59.00, '75% ADVANCE 25% BEFORE DELIVERY', 'DJSKSJ', 'HREYREYE', 'YHYREYREY', 'pending', 2, 'SMP0002', 'CAP', 'CAP101@GMAIL.COM', '9959191999', '9965555619', '59, ERT LLTP', '395005', 4, 'SMP0004', 'SF', 'SF101@GMAIL.COM', '9959090959', '9685555699', '15, RVN TTGS LLP', '395006', 2, '2024-12-31 07:22:56', '2025-01-01 03:01:39', 2),
(7, NULL, 'US', '2025-01-09', '2025-01', 'SMLPI6', '2025-01-09', 'USD', NULL, NULL, NULL, NULL, '75% ADVANCE 25% BEFORE DELIVERY', 'GDGDGET55', 'GDGD55', 'GSDGGE55', 'pending', 1, 'SMP0001', 'TATA', 'TATA101@GMAIL.COM', '9955599655', '9944556699', '99, ORTGH RTO', '395001', 3, 'SMP0003', 'TCS', 'TCS@GMAIL.COM', '9659155999', '9655151599', '98, RDFCXV LLT', '395009', 2, '2025-01-09 04:42:08', '2025-01-21 00:35:08', 2),
(8, NULL, 'US', '2025-01-09', '2025-01', 'SMLPI7', '2025-01-09', 'USD', NULL, NULL, NULL, NULL, '75% ADVANCE 25% BEFORE DELIVERY', 'DDFGEE55', 'GFFGRETR5', 'HFGGFTRER5', 'pending', 1, 'SMP0001', 'TATA', 'TATA101@GMAIL.COM', '9955599655', '9944556699', '99, ORTGH RTO', '395001', 3, 'SMP0003', 'TCS', 'TCS@GMAIL.COM', '9659155999', '9655151599', '98, RDFCXV LLT', '395009', 2, '2025-01-09 06:24:46', '2025-02-19 05:50:02', 2),
(9, NULL, 'ADE', '2025-01-10', '2025-01', 'SMLPI8', '2025-01-10', 'AED', 105.00, 155.00, 151.00, 1505.00, '75% ADVANCE 25% BEFORE DELIVERY', 'VVEEEEE555', 'DFFFFG55', 'HHJHHF55', 'pending', 8, 'SMP0007', 'SASSIFY', 'SASSIFY@GMAIL.COM', '9955662299', 'RFSFRWFW55', '3569, ASDFG', '395005', 9, 'SMP0008', 'SALSFORCE', 'SALSFORCE@GMAIL.COM', '8956235689', 'GFSFSWWWWRT7889', '1256, GFHFSJWUW', '395006', 2, '2025-01-09 23:41:12', '2025-02-19 05:49:40', 1),
(11, NULL, 'US', '2025-02-03', '2025-02', 'SMLPI10', '2025-02-03', 'EURO', NULL, NULL, NULL, NULL, '50% ADVANCE 50% BEFORE DELIVERY', 'VSDVVSVSVSVSVSVSVSVSVSVSVDGHT5RHUREJGKHIORETGOEIGHDGHREGFNGJHGOUIREHGUREGKDFGJNKHJFIKHJRHIREJHRKELGJFLGJREIOGRUT9OIR4HTJKEHGKJREHGOIREHGNDFS,NVREUIOGEJKVSDANGKJDGBKJSDGHDSUIOGHEWGKJDSBGEGHEUIOGHEWGGNREJGEGHEWIGUHEWIGUEHJGKSNDVJSANFUIEWHGUIWEFGNSFEWTEGWKJJ', 'VSDVVSVSVSVSVSVSVSVSVSVSVDGHT5RHUREJGKHIORETGOEIGHDGHREGFNGJHGOUIREHGUREGKDFGJNKHJFIKHJRHIREJHRKELGJFLGJREIOGRUT9OIR4HTJKEHGKJREHGOIREHGNDFS,NVREUIOGEJKVSDANGKJDGBKJSDGHDSUIOGHEWGKJDSBGEGHEUIOGHEWGGNREJGEGHEWIGUHEWIGUEHJGKSNDVJSANFUIEWHGUIWEFGNSFEWTEGWKJJ', 'GDJGSIGJIGOEWKU9IWOFHDSJFKSGFSFGSAFSAGFFKGASKSFGSIFGSAIYFGSAFSAGFISAGUFSAGFIUSFGASGIFUSAGIUFASIGFIJJ', 'pending', 2, 'SMP0002', 'CAP', 'CAP101@GMAIL.COM', '9959191999', '9965555619', '59, ERT LLTP', '395005', 4, 'SMP0004', 'SF', 'SF101@GMAIL.COM', '9959090959', '9685555699', '15, RVN TTGS LLP', '395006', 2, '2025-02-03 04:25:04', '2025-02-19 05:49:25', 1),
(13, NULL, 'US', '2025-02-19', '2025-02', 'SMLPI12', '2025-02-19', 'USD', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'pending', 5, 'SMP0005', 'CAPGEMINI', 'CAPGEMINI@GMAIL.COM', '9955664455', NULL, '569, GFHDJFSHJ', '2356895623568923568998655', 6, 'SMP0006', 'TYU', 'TYU@GMAIL.COM', '8956235698', NULL, '899, EEYETWT', '395001', 1, '2025-02-19 04:28:25', '2025-02-19 04:28:25', NULL),
(14, NULL, 'US', '2025-02-19', '2025-02', 'SMLPI13', '2025-02-19', 'USD', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'pending', 1, 'SMP0001', 'TATA', 'TATA101@GMAIL.COM', '9955599655', 'RGRGRGRGR55', '99, ORTGH RTO', '395005', 3, 'SMP0003', 'TCS', 'TCS@GMAIL.COM', '9659155999', 'RFGHHYUHH55', '98, RDFCXV LLT', '395006', 1, '2025-02-19 05:34:46', '2025-02-19 05:49:34', 1);

-- --------------------------------------------------------

--
-- Table structure for table `proforma_products`
--

CREATE TABLE `proforma_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `proforma_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_variant_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `price_per_set` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `proforma_products`
--

INSERT INTO `proforma_products` (`id`, `proforma_id`, `product_id`, `product_variant_id`, `quantity`, `price_per_set`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 4, 7, 5555, 5.00, 27775.00, '2024-12-10 02:51:38', '2024-12-13 00:15:26'),
(2, 1, 2, 3, 1055, 55.00, 58025.00, '2024-12-10 02:51:38', '2024-12-13 00:15:26'),
(3, 1, 3, 6, 669, 99.00, 66231.00, '2024-12-13 02:07:41', '2024-12-13 02:07:41'),
(4, 2, 9, 17, 5, 5.00, 25.00, '2024-12-19 03:22:20', '2024-12-19 03:22:20'),
(5, 2, 11, 21, 59, 9.00, 531.00, '2024-12-19 03:22:20', '2024-12-19 03:22:20'),
(8, 4, 2, 3, 55, 5.00, 275.00, '2024-12-31 07:23:04', '2024-12-31 07:23:04'),
(12, 7, 9, 17, 55, 5.00, 275.00, '2025-01-09 04:42:49', '2025-01-09 04:43:14'),
(13, 7, 2, 3, 155, 5.00, 775.00, '2025-01-09 04:42:49', '2025-01-09 04:42:49'),
(14, 8, 3, 5, 55, 5.00, 275.00, '2025-01-09 06:24:56', '2025-01-09 06:24:56'),
(15, 9, 11, 21, 55, 5.00, 275.00, '2025-01-09 23:41:46', '2025-01-09 23:41:46'),
(16, 9, 6, 11, 105, 5.00, 525.00, '2025-01-09 23:41:46', '2025-01-09 23:41:46'),
(17, 7, 1, 1, 55, 5.00, 275.00, '2025-01-10 05:20:59', '2025-01-10 05:20:59'),
(21, 7, 16, 45, 55, 5.00, 275.00, '2025-01-21 00:35:08', '2025-01-21 00:35:08'),
(22, 11, 22, 62, 55, 5.00, 275.00, '2025-02-03 04:25:19', '2025-02-03 04:25:19');

-- --------------------------------------------------------

--
-- Table structure for table `quotations`
--

CREATE TABLE `quotations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `inquire_id` bigint(20) UNSIGNED DEFAULT NULL,
  `brand_id` bigint(20) UNSIGNED DEFAULT NULL,
  `generic_id` bigint(20) UNSIGNED DEFAULT NULL,
  `manufacturer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `gst` varchar(100) DEFAULT NULL,
  `storage_condition` varchar(255) DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` bigint(20) DEFAULT NULL,
  `product_variant_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quotations`
--

INSERT INTO `quotations` (`id`, `inquire_id`, `brand_id`, `generic_id`, `manufacturer_id`, `gst`, `storage_condition`, `created_by`, `created_at`, `updated_at`, `updated_by`, `product_variant_id`) VALUES
(11, 7, NULL, 1, 1, '18', 'rgvb', 1, '2024-11-25 01:52:52', '2024-11-25 01:52:52', NULL, NULL),
(15, 12, 4, NULL, 4, '9', 'pcgb', 1, '2024-11-25 03:35:08', '2024-11-25 03:35:08', NULL, NULL),
(17, 8, 6, NULL, 5, '18', 'gfgh', 3, '2024-12-01 22:44:17', '2024-12-01 22:44:17', NULL, NULL),
(18, 11, NULL, 9, 6, '5', 'hhj', 2, '2024-12-02 01:29:48', '2024-12-02 01:29:48', NULL, NULL),
(30, 10, 2, NULL, 6, '12', 'llnt', 1, '2024-12-04 03:23:44', '2025-01-22 05:28:50', 2, 2),
(34, 16, 7, NULL, 5, '9', 'tghj', 1, '2024-12-04 05:14:51', '2024-12-10 23:54:58', 2, 14),
(44, 9, NULL, 8, 4, '18', 'aaaaavb', 2, '2024-12-13 05:49:27', '2025-01-20 23:15:51', 2, 7),
(110, 17, 7, NULL, 4, NULL, 'ggg', 3, '2024-12-23 05:54:34', '2025-01-28 05:16:28', 2, 13),
(111, 22, 3, NULL, 2, '18', 'dfggggg', 2, '2025-01-01 00:58:45', '2025-01-01 00:58:45', NULL, 6),
(151, 17, 4, NULL, 2, '5', 'GHYU', 2, '2025-01-24 04:07:12', '2025-01-27 23:06:58', 2, 8),
(152, 43, 6, NULL, NULL, NULL, NULL, 2, '2025-01-24 06:47:07', '2025-01-27 23:13:41', 2, 11),
(167, 26, NULL, 2, 2, '12', NULL, 2, '2025-01-28 01:07:27', '2025-01-28 01:09:54', 2, 2),
(168, 43, 1, NULL, NULL, NULL, NULL, 2, '2025-01-28 05:23:18', '2025-01-28 05:33:20', 2, 1),
(169, 43, 3, NULL, NULL, NULL, NULL, 2, '2025-01-28 05:23:18', '2025-01-28 05:33:20', 2, 5),
(176, 45, NULL, 2, NULL, NULL, NULL, 2, '2025-01-29 07:09:39', '2025-01-29 07:09:39', NULL, 1),
(177, 46, 3, NULL, NULL, NULL, NULL, 2, '2025-01-29 07:12:24', '2025-01-29 07:12:24', NULL, 5),
(188, 37, 2, NULL, 1, '18', 'gdgdg', 2, '2025-02-04 22:34:50', '2025-02-04 22:34:50', NULL, 3),
(189, 38, 3, NULL, 3, '18', 'fsfef', 2, '2025-02-04 22:35:39', '2025-02-04 22:35:39', NULL, 5),
(191, 40, 1, NULL, 1, '18', 'gfff', 2, '2025-02-04 23:09:17', '2025-02-04 23:09:17', NULL, 1),
(192, 42, NULL, 116, 2, '18', 'ayubgft', 2, '2025-02-05 04:29:15', '2025-02-05 04:29:15', NULL, 4),
(193, 23, NULL, NULL, 2, '18', 'gvgdf', 2, '2025-02-06 06:38:39', '2025-02-06 06:38:39', NULL, 25),
(195, 39, 3, NULL, 1, '18', 'fbfhfg', 2, '2025-02-06 06:46:14', '2025-02-06 06:46:14', NULL, 6),
(196, 41, 3, NULL, 1, '12', 'jityututhty', 2, '2025-02-06 06:47:04', '2025-02-06 06:47:04', NULL, 6),
(197, 44, NULL, NULL, 2, '12', 'dgdgdg', 2, '2025-02-06 06:57:52', '2025-02-13 04:52:55', 2, 3),
(198, 18, NULL, NULL, 3, '18', 'fgvbn', 2, '2025-02-06 23:59:18', '2025-02-06 23:59:18', NULL, 2),
(201, 28, 13, NULL, 3, '18', 'EGY4T4T', 2, '2025-02-07 00:09:14', '2025-02-07 00:09:14', NULL, 25),
(202, 27, NULL, NULL, 2, '12', 'tyu', 2, '2025-02-07 00:17:45', '2025-02-07 00:17:45', NULL, 2),
(203, 29, 13, NULL, 3, '18', 'hthte', 2, '2025-02-11 23:16:51', '2025-02-11 23:16:51', NULL, 25),
(204, 33, NULL, NULL, 1, '12', 'tuururu', 2, '2025-02-11 23:17:25', '2025-02-11 23:17:25', NULL, 3),
(205, 34, 6, NULL, 4, '9', 'kytyktk', 2, '2025-02-11 23:18:04', '2025-02-11 23:18:04', NULL, 11),
(206, 20, NULL, 44, 2, '6', 'grgerge', 2, '2025-02-11 23:22:39', '2025-02-11 23:22:39', NULL, 3),
(208, 14, 2, NULL, 4, '9', 'hhgege', 2, '2025-02-12 00:43:32', '2025-02-12 00:43:32', NULL, 4),
(209, 19, 21, NULL, 5, '15', 'rryrr', 2, '2025-02-12 00:44:12', '2025-02-12 00:44:12', NULL, 58),
(210, 25, NULL, 33, 6, '18', 'hrtyugd', 2, '2025-02-13 04:45:01', '2025-02-13 04:45:01', NULL, 2),
(211, 24, NULL, 5, 3, '18', 'gegw', 2, '2025-02-13 04:45:40', '2025-02-13 04:45:40', NULL, 3),
(212, 21, 5, NULL, 5, '12', 'rtgwsgg', 2, '2025-02-13 04:46:25', '2025-02-13 04:46:25', NULL, 9),
(213, 13, NULL, 28, 6, '9', 'rhegeg', 2, '2025-02-13 04:47:59', '2025-02-13 04:47:59', NULL, 4);

-- --------------------------------------------------------

--
-- Table structure for table `quotations_histories`
--

CREATE TABLE `quotations_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `inquiry_history_id` bigint(20) UNSIGNED DEFAULT NULL,
  `brand_id` bigint(20) UNSIGNED DEFAULT NULL,
  `generic_id` bigint(20) UNSIGNED DEFAULT NULL,
  `manufacturer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `gst` varchar(100) DEFAULT NULL,
  `storage_condition` varchar(255) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `product_variant_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quotations_histories`
--

INSERT INTO `quotations_histories` (`id`, `inquiry_history_id`, `brand_id`, `generic_id`, `manufacturer_id`, `gst`, `storage_condition`, `created_by`, `created_at`, `updated_at`, `product_variant_id`) VALUES
(1, 1, 1, NULL, 1, '9', 'tghbn', 1, '2024-11-25 02:11:45', '2024-11-25 02:11:45', NULL),
(2, 1, 2, NULL, 2, '6', 'bvnm', 1, '2024-11-25 02:11:45', '2024-11-25 02:11:45', NULL),
(3, 2, 3, NULL, 1, '6', 'dfgh', 1, '2024-11-25 03:27:36', '2024-11-25 03:27:36', NULL),
(4, 3, 2, NULL, 2, '9', 'rtghj', 1, '2024-11-25 03:33:43', '2024-11-25 03:33:43', NULL),
(5, 3, 3, NULL, 3, '18', 'fghjk', 1, '2024-11-25 03:33:43', '2024-11-25 03:33:43', NULL),
(6, 4, 7, NULL, 6, '9', 'tfgbn', 3, '2024-12-01 22:43:17', '2024-12-01 22:43:17', NULL),
(8, 6, 5, NULL, 4, '9', 'rdgs', 2, '2024-12-02 03:31:37', '2024-12-02 03:31:37', NULL),
(9, 7, 6, NULL, 5, '9', 'tyu', 2, '2024-12-02 23:57:12', '2024-12-02 23:57:12', NULL),
(10, 7, 4, NULL, 3, '6', 'hnm', 2, '2024-12-02 23:57:12', '2024-12-02 23:57:12', NULL),
(11, 8, 2, NULL, 1, '9', NULL, 2, '2024-12-03 00:26:21', '2024-12-03 00:26:21', NULL),
(12, 9, 7, NULL, 5, '12', NULL, 2, '2024-12-03 22:23:53', '2024-12-03 22:23:53', NULL),
(13, 9, 8, NULL, 2, '18', NULL, 2, '2024-12-03 22:23:53', '2024-12-03 22:23:53', NULL),
(14, 10, 1, NULL, 1, '18', 'rk', 1, '2024-12-04 03:18:02', '2024-12-04 03:18:02', 1),
(15, 11, NULL, 34, 3, '18', 'ghfdfhf', 2, '2024-12-16 05:33:18', '2024-12-16 05:33:18', 5),
(16, 12, 4, NULL, 4, '18', 'gfggg', 3, '2024-12-17 22:10:50', '2024-12-17 22:10:50', 7),
(17, 12, 6, NULL, 6, '18', 'dfjskfajhifa', 3, '2024-12-17 22:10:50', '2024-12-17 22:10:50', 11),
(18, 13, 7, NULL, 6, '18', 'ffgh', 1, '2024-12-19 04:07:55', '2024-12-19 04:07:55', 14),
(19, 15, NULL, 50, 3, '12', 'rtyy', 1, '2025-01-01 06:27:00', '2025-01-01 06:27:00', NULL),
(20, 16, 3, NULL, 3, '18', 'fetw525t252', 2, '2025-01-08 05:56:22', '2025-01-08 05:56:22', 6),
(21, 16, 2, NULL, 3, '5', 'gedsfgw5569', 2, '2025-01-08 05:56:22', '2025-01-08 05:56:22', 4),
(22, 17, NULL, 3, 1, '18', 'fgewfr55', 2, '2025-01-20 22:32:45', '2025-01-20 22:32:45', 2),
(23, 18, 1, NULL, 3, '15', 'gsfafqjufq999', 2, '2025-01-29 22:32:09', '2025-01-29 22:32:09', 1),
(24, 18, 1, NULL, 1, '15', 'gdvsw55', 2, '2025-01-29 22:32:09', '2025-01-29 22:32:09', 1),
(25, 19, 22, NULL, 2, '12', 'fgvbnn', 2, '2025-01-30 02:53:23', '2025-01-30 02:53:23', 62),
(26, 19, 12, NULL, 3, '9', 'ayub1', 2, '2025-01-30 02:53:23', '2025-01-30 02:53:23', 23),
(27, 20, NULL, 48, 1, NULL, 'rtfghhjjj', 2, '2025-01-30 04:13:44', '2025-01-30 04:13:44', 58),
(28, 21, 1, NULL, 3, '18', 'ghfwar3r3', 2, '2025-01-30 04:20:52', '2025-01-30 04:20:52', 2),
(29, 21, 2, NULL, 2, '12', 'gfwr32r2q', 2, '2025-01-30 04:20:52', '2025-01-30 04:20:52', 3),
(30, 23, NULL, 49, 2, '12', 'ffff', 2, '2025-01-30 07:06:32', '2025-01-30 07:06:32', 2),
(31, 24, 1, NULL, 1, '18', 'ayub1jb', 2, '2025-01-30 22:39:30', '2025-01-30 22:39:30', 2),
(32, 24, 12, NULL, 4, '5', 'aesdfghj', 2, '2025-01-30 22:39:30', '2025-01-30 22:39:30', 23),
(33, 25, 6, NULL, 3, '18', 'artyu', 2, '2025-01-30 22:51:18', '2025-01-30 22:51:18', 11),
(34, 26, 13, NULL, 5, '18', 'abcvgtyuop', 2, '2025-01-30 22:58:28', '2025-01-30 22:58:28', 25),
(35, 27, 2, NULL, 2, '18', 'tyu', 2, '2025-02-08 03:41:23', NULL, 4),
(36, 27, 3, NULL, 2, '18', '6', 2, '2025-02-08 03:41:32', NULL, 5),
(38, 29, 2, NULL, 2, '18', 'gyhg7', 2, '2025-01-05 23:08:08', NULL, 4),
(39, 29, 3, NULL, 2, '9', 'dssss', 2, '2025-01-05 23:08:19', NULL, 5),
(40, 30, 13, NULL, 2, '12', 'hjkl', 2, '2024-12-19 04:12:05', NULL, 25),
(41, 30, 12, NULL, 5, '12', 'hjkbnm', 2, '2024-12-19 04:18:13', NULL, 24),
(42, 31, 5, NULL, 3, '18', 'dfcvbn', 2, '2025-02-04 22:45:58', NULL, 9),
(43, 32, NULL, 5, 6, '18', 'HJKL', 2, '2024-12-09 23:05:09', NULL, 5),
(44, 33, 8, NULL, 5, '18', 'dk', 1, '2024-12-04 03:21:50', NULL, 15),
(45, 33, 9, NULL, 5, '12', 'aark', 1, '2024-12-04 05:05:47', NULL, 18),
(46, 34, 7, NULL, 1, '12', 'lljb', 2, '2024-12-10 05:54:22', NULL, 13),
(47, 35, 2, NULL, 1, NULL, NULL, 2, '2025-01-02 00:37:24', NULL, 3),
(48, 36, NULL, 3, 2, '18', 'ggdg', 2, '2025-02-06 06:45:41', NULL, 2),
(49, 37, 10, NULL, 1, '28', '5', 2, '2025-01-03 00:20:02', NULL, 19),
(50, 37, 3, NULL, 2, '9', 'rtfgh', 2, '2025-01-03 00:22:20', NULL, 5),
(51, 38, 1, NULL, 1, '18', 'getwrtw', 2, '2025-01-03 06:19:20', NULL, 1),
(52, 38, 3, NULL, 4, '12', 'rtfgh', 2, '2025-01-03 06:19:20', NULL, 6),
(53, 39, 12, NULL, 1, '18', NULL, 2, '2025-01-05 23:01:12', NULL, 23),
(54, 39, 7, NULL, 2, '12', NULL, 2, '2025-01-05 23:02:35', NULL, 13),
(55, 40, NULL, 7, 5, '12', 'hgfhfhf', 2, '2024-12-23 04:24:19', NULL, 6),
(56, 41, 4, NULL, 2, '18', 'FFF', 2, '2025-02-07 00:02:24', NULL, 7),
(57, 42, NULL, 3, 1, '18', 'fghvbnyu55', 2, NULL, NULL, 1),
(58, 43, 14, NULL, 4, '18', 'YUHGBN', 2, '2025-02-07 00:00:05', NULL, 26),
(59, 44, NULL, 2, 4, '12', 'sfsfsfee', 2, '2025-02-12 00:25:25', NULL, 3),
(60, 45, NULL, 7, NULL, '18', NULL, 2, '2024-12-23 03:53:04', NULL, 5),
(65, 48, 11, NULL, 5, '18', 'gdgggs', 2, '2024-12-16 04:27:10', NULL, 22),
(66, 48, 5, NULL, 3, '9', 'uryyee', 3, '2024-12-17 06:13:15', NULL, 10),
(67, 49, NULL, 7, 3, '12', 'fs4242rwsrwq', 2, '2025-01-03 06:13:30', NULL, 2),
(68, 50, 9, NULL, 6, '18', 'dssss', 1, '2024-12-04 05:00:47', NULL, 17);

-- --------------------------------------------------------

--
-- Table structure for table `quotation_queries`
--

CREATE TABLE `quotation_queries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quotation_id` bigint(20) UNSIGNED DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quotation_queries`
--

INSERT INTO `quotation_queries` (`id`, `quotation_id`, `comment`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 34, 'The grant from NED is the fifth financial support from an international organization. From 2021 to 2024, the US-based NED provided $149,000 as a financial support to Peregraf. Furthermore, PEREGRAF has previously received a one-year grant from the Open Society Foundation in 2018.', 3, '2024-12-06 01:19:29', '2024-12-06 01:19:29'),
(2, 34, 'I am one more add comments', 3, '2024-12-06 01:30:08', '2024-12-06 01:30:08'),
(3, 34, 'A paragraph is a group of sentences that develops a single idea. Paragraphs are a fundamental part of any piece of writing that is longer than a few sentences. They help the reader understand the structure of the writing and grasp its main points.', 3, '2024-12-06 01:50:45', '2024-12-06 01:50:45'),
(4, 34, 'I am one more add quantity', 3, '2024-12-08 23:53:01', '2024-12-08 23:53:01'),
(5, 34, 'The grant from NED is the fifth financial support from an international organization. From 2021 to 2024, the US-based NED provided $149,000 as a financial support to Peregraf. Furthermore, PEREGRAF has previously received a one-year grant from the Open Society Foundation in 2018.', 2, '2024-12-10 22:44:51', '2024-12-10 22:44:51'),
(6, 34, 'i need one mopre add comments', 2, '2024-12-10 22:46:07', '2024-12-10 22:46:07'),
(7, 34, 'The grant from NED is the fifth financial support from an international organization. From 2021 to 2024, the US-based NED provided $149,000 as a financial support to Peregraf. Furthermore, PEREGRAF has previously received a one-year grant from the Open Society Foundation in 2018.', 2, '2024-12-12 05:58:23', '2024-12-12 05:58:23'),
(8, 34, 'I am one more add quantity', 2, '2024-12-12 05:58:47', '2024-12-12 05:58:47'),
(9, 37, 'I am one more add quantity', 2, '2024-12-12 05:59:09', '2024-12-12 05:59:09'),
(10, 37, 'If you are submitting documentation for the current stable release, submit it to the corresponding branch.', 2, '2024-12-12 06:00:39', '2024-12-12 06:00:39'),
(11, 37, 'For example, documentation for Laravel 11 would be submitted to the 11.x branch. Documentation intended for the next release of Laravel should be submitted to the master branch.', 2, '2024-12-12 06:01:38', '2024-12-12 06:01:38'),
(12, 34, 'The grant from NED is the fifth financial support from an international organization. From 2021 to 2024, the US-based NED provided $149,000 as a financial support to Peregraf. Furthermore, PEREGRAF has previously received a one-year grant from the Open Society Foundation in 2018.', 3, '2024-12-16 04:32:06', '2024-12-16 04:32:06'),
(13, 35, 'The grant from NED is the fifth financial support from an international organization. From 2021 to 2024, the US-based NED provided $149,000 as a financial support to Peregraf. Furthermore, PEREGRAF has previously received a one-year grant from the Open Society Foundation in 2018.', 3, '2024-12-16 04:32:30', '2024-12-16 04:32:30'),
(14, 34, 'I have add more quontity', 2, '2024-12-19 04:21:29', '2024-12-19 04:21:29'),
(15, 34, 'I have assined new quontity', 3, '2024-12-19 04:22:25', '2024-12-19 04:22:25'),
(16, 37, 'I am one more add quantity', 2, '2024-12-23 06:54:23', '2024-12-23 06:54:23'),
(17, 37, 'Use supporting details: Explain or give examples related to the topic.', 2, '2024-12-23 06:59:47', '2024-12-23 06:59:47'),
(18, 37, 'Use supporting details: Explain or give examples related to the topic.', 2, '2024-12-23 07:00:17', '2024-12-23 07:00:17'),
(19, 37, 'I am one more add quantity', 2, '2024-12-23 07:01:08', '2024-12-23 07:01:08'),
(20, 37, 'Query Resolved', 3, '2024-12-23 07:02:09', '2024-12-23 07:02:09'),
(21, 102, 'hello test', 2, '2024-12-24 22:46:59', '2024-12-24 22:46:59'),
(22, 102, 'close test', 3, '2024-12-24 22:47:46', '2024-12-24 22:47:46'),
(23, 102, 'Add More', 2, '2024-12-24 22:50:18', '2024-12-24 22:50:18'),
(24, 102, 'Close Query', 3, '2024-12-24 22:50:56', '2024-12-24 22:50:56'),
(25, 102, 'Add More Now', 2, '2024-12-24 22:53:13', '2024-12-24 22:53:13'),
(26, 146, 'heeloo', 2, '2025-01-31 04:28:00', '2025-01-31 04:28:00');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `type`, `created_at`, `updated_at`) VALUES
(1, 'ADMIN', 'web', 'ADMIN', '2024-11-23 01:15:29', '2024-11-28 05:35:58'),
(2, 'BD', 'web', 'LOGISTIC', '2024-11-28 05:24:08', '2025-02-21 04:54:51'),
(3, 'PURCHASE', 'web', 'PURCHASE', '2024-11-28 05:39:50', '2025-01-10 06:12:19'),
(4, 'WAREHOUSE', 'web', 'WAREHOUSE', '2024-12-11 06:23:47', '2025-02-07 03:59:38'),
(8, 'LOGISTICS', 'web', 'LOGISTIC', '2025-01-22 00:22:27', '2025-01-31 04:12:08'),
(9, 'AYUB1', 'web', 'BILLING', '2025-02-07 04:00:44', '2025-02-07 04:00:57'),
(10, 'AYUB2', 'web', 'ADMIN', '2025-02-07 04:01:14', '2025-02-07 04:01:14'),
(11, 'AYUB3', 'web', 'BD', '2025-02-07 04:01:29', '2025-02-07 04:01:29'),
(12, 'AYUB4', 'web', 'PURCHASE', '2025-02-07 04:01:58', '2025-02-07 04:01:58'),
(13, 'AYUB5', 'web', 'WAREHOUSE', '2025-02-07 04:02:14', '2025-02-07 04:02:14'),
(16, 'AYUB6', 'web', 'BD', '2025-02-19 01:23:56', '2025-02-19 01:24:06'),
(17, 'AYUB7', 'web', 'ADMIN', '2025-02-19 01:24:23', '2025-02-19 01:24:23');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 16),
(1, 17),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 8),
(2, 9),
(2, 10),
(2, 11),
(2, 12),
(2, 13),
(2, 16),
(2, 17),
(3, 1),
(3, 2),
(3, 3),
(3, 4),
(3, 8),
(3, 9),
(3, 10),
(3, 11),
(3, 12),
(3, 13),
(3, 16),
(3, 17),
(4, 1),
(4, 2),
(4, 3),
(4, 4),
(4, 8),
(4, 9),
(4, 10),
(4, 11),
(4, 12),
(4, 13),
(4, 16),
(4, 17),
(5, 1),
(5, 2),
(5, 3),
(5, 4),
(5, 8),
(5, 9),
(5, 10),
(5, 11),
(5, 12),
(5, 13),
(5, 16),
(5, 17),
(6, 1),
(6, 2),
(6, 3),
(6, 4),
(6, 8),
(6, 9),
(6, 10),
(6, 11),
(6, 12),
(6, 13),
(6, 16),
(6, 17),
(7, 1),
(7, 2),
(7, 3),
(7, 4),
(7, 8),
(7, 9),
(7, 10),
(7, 11),
(7, 12),
(7, 13),
(7, 16),
(7, 17),
(8, 1),
(8, 2),
(8, 3),
(8, 4),
(8, 8),
(8, 9),
(8, 10),
(8, 11),
(8, 12),
(8, 13),
(8, 16),
(8, 17),
(9, 1),
(9, 2),
(9, 3),
(9, 4),
(9, 8),
(9, 9),
(9, 10),
(9, 11),
(9, 12),
(9, 13),
(9, 16),
(9, 17),
(10, 1),
(10, 2),
(10, 3),
(10, 4),
(11, 1),
(11, 2),
(11, 3),
(11, 4),
(12, 1),
(12, 2),
(12, 3),
(12, 4),
(13, 1),
(13, 2),
(13, 3),
(13, 4),
(14, 1),
(14, 2),
(14, 3),
(14, 4),
(15, 1),
(15, 2),
(15, 3),
(15, 4),
(16, 1),
(16, 2),
(16, 3),
(16, 4),
(17, 1),
(17, 2),
(17, 3),
(17, 4),
(18, 1),
(18, 2),
(18, 3),
(18, 4),
(19, 1),
(19, 2),
(19, 3),
(19, 4),
(20, 1),
(20, 2),
(20, 3),
(20, 4),
(21, 1),
(21, 2),
(21, 3),
(21, 4),
(22, 1),
(22, 2),
(22, 3),
(22, 4),
(23, 1),
(23, 2),
(23, 3),
(23, 4),
(24, 1),
(24, 2),
(24, 3),
(24, 4),
(25, 1),
(25, 2),
(25, 3),
(25, 4),
(26, 1),
(26, 2),
(26, 3),
(26, 4),
(27, 1),
(27, 2),
(27, 3),
(27, 4),
(28, 1),
(28, 2),
(28, 3),
(28, 4),
(29, 1),
(29, 2),
(29, 3),
(29, 4),
(30, 1),
(30, 2),
(30, 3),
(30, 4),
(31, 1),
(31, 2),
(31, 3),
(31, 4),
(32, 1),
(32, 2),
(32, 3),
(32, 4),
(33, 1),
(33, 2),
(33, 3),
(33, 4),
(34, 1),
(34, 2),
(34, 3),
(34, 4),
(35, 1),
(35, 2),
(35, 3),
(35, 4),
(36, 1),
(36, 2),
(36, 3),
(36, 4),
(37, 1),
(37, 2),
(37, 3),
(37, 4),
(38, 1),
(38, 2),
(38, 3),
(38, 4),
(39, 1),
(39, 2),
(39, 3),
(39, 4),
(40, 1),
(40, 2),
(40, 3),
(40, 4),
(41, 1),
(41, 2),
(41, 3),
(41, 4),
(42, 1),
(42, 2),
(42, 3),
(42, 4),
(43, 1),
(43, 2),
(43, 3),
(43, 4),
(44, 1),
(44, 2),
(44, 3),
(44, 4),
(45, 1),
(45, 2),
(45, 3),
(45, 4),
(46, 1),
(46, 2),
(46, 3),
(46, 4),
(47, 1),
(47, 2),
(47, 3),
(47, 4),
(48, 1),
(48, 2),
(48, 3),
(48, 4),
(49, 1),
(49, 2),
(49, 3),
(49, 4),
(50, 1),
(50, 2),
(50, 3),
(50, 4),
(51, 1),
(51, 2),
(51, 3),
(51, 4),
(52, 1),
(52, 2),
(52, 3),
(53, 1),
(53, 2),
(53, 3),
(53, 4),
(54, 1),
(54, 2),
(54, 3),
(54, 4),
(55, 1),
(55, 2),
(55, 3),
(55, 4);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quotation_id` bigint(20) UNSIGNED DEFAULT NULL,
  `vender_id` bigint(20) UNSIGNED DEFAULT NULL,
  `price_per_pack` decimal(10,2) DEFAULT NULL,
  `expiry_date` varchar(255) DEFAULT NULL,
  `lead_time` varchar(255) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `quotation_id`, `vender_id`, `price_per_pack`, `expiry_date`, `lead_time`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(20, 11, 1, 25.00, '2024-12', '5', NULL, '2024-11-25 01:52:52', NULL, '2024-11-25 01:52:52'),
(28, 15, 3, 9.00, '2024-11', '1', NULL, '2024-11-25 03:35:08', NULL, '2024-11-25 03:35:08'),
(29, 15, 1, 19.00, '2024-12', '9', NULL, '2024-11-25 03:35:08', NULL, '2024-11-25 03:35:08'),
(32, 17, 2, 9.00, '2024-12', '5', NULL, '2024-12-01 22:44:17', NULL, '2024-12-01 22:44:17'),
(33, 17, 3, 6.00, '2024-12', '6', NULL, '2024-12-01 22:44:17', NULL, '2024-12-01 22:44:17'),
(55, 30, NULL, 9.00, '2024-12', '9', NULL, '2024-12-04 03:23:44', NULL, '2025-01-24 02:50:04'),
(60, 34, 2, 9.00, '2024-12', '9', NULL, '2024-12-04 05:14:51', NULL, '2024-12-04 05:14:51'),
(71, 44, 6, 55.00, '2024-12', '5', NULL, '2024-12-13 05:49:27', NULL, '2024-12-13 05:49:27'),
(160, 110, 7, 59.00, '2025-02', '5', NULL, '2024-12-23 05:54:34', 2, '2025-01-27 04:20:22'),
(161, 111, 7, 55.00, '2025-08', '9', NULL, '2025-01-01 00:58:45', NULL, '2025-01-01 00:58:45'),
(248, 152, 4, 5.00, '2025-07', '5', NULL, '2025-01-24 06:47:07', 2, '2025-01-28 05:23:18'),
(251, 151, 10, 5.00, '2025-08', '5', NULL, '2025-01-27 04:25:28', 2, '2025-01-27 04:37:25'),
(267, 110, 16, 55.00, '2025-08', '5', 2, '2025-01-27 06:03:06', 2, '2025-01-27 06:29:29'),
(268, 151, 19, 55.00, '2025-11', '55', 2, '2025-01-27 23:06:27', 2, '2025-01-27 23:06:39'),
(270, 167, 6, 55.00, '2025-03', '5', NULL, '2025-01-28 01:07:27', 2, '2025-01-28 01:09:54'),
(271, 152, 1, 55.00, '2025-03', '5', 2, '2025-01-28 05:33:20', 2, '2025-01-28 05:33:42'),
(272, 152, 6, 59.00, '2025-07', '5', 2, '2025-01-28 05:33:20', 2, '2025-01-28 05:33:42'),
(273, 152, 9, 57.00, '2025-12', '5', 2, '2025-01-28 05:33:20', 2, '2025-01-28 05:33:42'),
(274, 152, 13, 55.00, '2025-11', '5', 2, '2025-01-28 05:33:42', 2, '2025-01-28 05:38:49'),
(275, 168, 7, 1.00, '2025-02', '6', 2, '2025-01-28 05:39:25', 2, '2025-01-29 01:32:58'),
(282, 176, 3, 55.00, '2025-07', '5', NULL, '2025-01-29 07:09:39', NULL, '2025-01-29 07:09:39'),
(283, 177, 2, 55.00, '2025-07', '5', NULL, '2025-01-29 07:12:24', NULL, '2025-01-29 07:12:24'),
(305, 188, 6, 59.00, '2025-10', '5', NULL, '2025-02-04 22:34:50', NULL, '2025-02-04 22:34:50'),
(306, 189, 8, 55.00, '2025-07', '5', NULL, '2025-02-04 22:35:39', NULL, '2025-02-04 22:35:39'),
(320, 191, 5, 15.00, '2025-11', '5', NULL, '2025-02-04 23:09:17', NULL, '2025-02-04 23:09:17'),
(321, 191, 13, 25.00, '2025-12', '2', NULL, '2025-02-04 23:09:17', NULL, '2025-02-04 23:09:17'),
(322, 192, NULL, 55.00, '2025-08', '5', NULL, '2025-02-05 04:29:15', NULL, '2025-02-05 04:29:15'),
(323, 192, NULL, 55.00, '2025-08', '5', NULL, '2025-02-05 04:29:15', NULL, '2025-02-05 04:29:15'),
(324, 193, 5, 56.00, '2025-11', '6', NULL, '2025-02-06 06:38:39', NULL, '2025-02-06 06:38:39'),
(326, 195, 3, 59.00, '2025-07', '5', NULL, '2025-02-06 06:46:14', NULL, '2025-02-06 06:46:14'),
(327, 196, 6, 56.00, '2025-10', '5', NULL, '2025-02-06 06:47:04', NULL, '2025-02-06 06:47:04'),
(328, 197, 5, 56.00, '2025-07', '1', NULL, '2025-02-06 06:57:52', 2, '2025-02-13 04:52:55'),
(329, 198, 5, 56.00, '2025-10', '5', NULL, '2025-02-06 23:59:18', NULL, '2025-02-06 23:59:18'),
(332, 201, 5, 56.00, '2025-10', '9', NULL, '2025-02-07 00:09:14', NULL, '2025-02-07 00:09:14'),
(333, 202, 17, 56.00, '2025-06', '5', NULL, '2025-02-07 00:17:45', NULL, '2025-02-07 00:17:45'),
(334, 203, 3, 5.00, '2025-11', '5', NULL, '2025-02-11 23:16:51', NULL, '2025-02-11 23:16:51'),
(335, 204, 5, 5.00, '2025-11', '1', NULL, '2025-02-11 23:17:25', NULL, '2025-02-11 23:17:25'),
(336, 205, 6, 15.00, '2025-07', '15', NULL, '2025-02-11 23:18:04', NULL, '2025-02-11 23:18:04'),
(337, 206, 4, 55.00, '2025-11', '5', NULL, '2025-02-11 23:22:39', NULL, '2025-02-11 23:22:39'),
(339, 208, 6, 5.00, '2025-12', '5', NULL, '2025-02-12 00:43:32', NULL, '2025-02-12 00:43:32'),
(340, 209, 13, 9.00, '2025-11', '9', NULL, '2025-02-12 00:44:12', NULL, '2025-02-12 00:44:12'),
(341, 210, 4, 9.00, '2025-07', '9', NULL, '2025-02-13 04:45:01', NULL, '2025-02-13 04:45:01'),
(342, 211, 5, 55.00, '2025-11', '5', NULL, '2025-02-13 04:45:40', NULL, '2025-02-13 04:45:40'),
(343, 212, 9, 55.00, '2025-08', '5', NULL, '2025-02-13 04:46:25', NULL, '2025-02-13 04:46:25'),
(344, 213, 12, 15.00, '2025-11', '5', NULL, '2025-02-13 04:47:59', NULL, '2025-02-13 04:47:59');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers_histories`
--

CREATE TABLE `suppliers_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quotation_history_id` bigint(20) UNSIGNED DEFAULT NULL,
  `vender_id` bigint(20) UNSIGNED DEFAULT NULL,
  `price_per_pack` decimal(10,2) DEFAULT NULL,
  `expiry_date` varchar(255) DEFAULT NULL,
  `lead_time` varchar(255) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers_histories`
--

INSERT INTO `suppliers_histories` (`id`, `quotation_history_id`, `vender_id`, `price_per_pack`, `expiry_date`, `lead_time`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 5.00, '2024-11', '3', NULL, NULL, NULL),
(2, 1, 2, 6.00, '2024-12', '5', NULL, NULL, NULL),
(3, 2, 3, 6.00, '2024-11', '5', NULL, NULL, NULL),
(4, 2, 4, 9.00, '2024-12', '9', NULL, NULL, NULL),
(5, 3, 1, 6.00, '2024-11', '3', NULL, NULL, NULL),
(6, 3, 2, 9.00, '2024-12', '5', NULL, NULL, NULL),
(7, 4, 1, 55.00, '2024-12', '5', NULL, NULL, NULL),
(8, 4, 2, 99.00, '2024-12', '9', NULL, NULL, NULL),
(9, 5, 3, 35.00, '2024-11', '5', NULL, NULL, NULL),
(10, 5, 4, 45.00, '2024-12', '6', NULL, NULL, NULL),
(11, 6, 4, 5.00, '2024-12', '5', NULL, NULL, NULL),
(12, 6, 3, 6.00, '2024-12', '6', NULL, NULL, NULL),
(14, 8, 3, 5.00, '2024-12', '5', NULL, NULL, NULL),
(15, 9, 1, 9.00, '2024-12', '5', NULL, NULL, NULL),
(16, 9, 2, 55.00, '2024-12', '6', NULL, NULL, NULL),
(17, 10, 3, 9.00, '2024-12', '5', NULL, NULL, NULL),
(18, 10, 4, 55.00, '2024-12', '9', NULL, NULL, NULL),
(19, 11, 2, 9.00, '2024-12', '5', NULL, NULL, NULL),
(20, 11, 3, 55.00, '2024-12', '5', NULL, NULL, NULL),
(21, 12, 2, 9.00, '2024-12', '6', NULL, NULL, NULL),
(22, 12, 3, 55.00, '2024-12', '5', NULL, NULL, NULL),
(23, 13, 2, 99.00, '2024-11', '9', NULL, NULL, NULL),
(24, 13, 3, 55.00, '2024-12', '5', NULL, NULL, NULL),
(25, 14, 4, 9.00, '2024-12', '5', NULL, NULL, NULL),
(26, 14, 3, 5.00, '2024-12', '6', NULL, NULL, NULL),
(27, 15, 6, 99.00, '2024-12', '55', NULL, NULL, NULL),
(28, 16, 4, 55.00, '2024-12', '9', NULL, NULL, NULL),
(29, 16, 5, 559.00, '2024-12', '59', NULL, NULL, NULL),
(30, 17, 7, 55.00, '2024-10', '9', NULL, NULL, NULL),
(31, 17, 18, 59.00, '2024-12', '59', NULL, NULL, NULL),
(32, 18, 2, 55.00, '2024-12', '5', NULL, NULL, NULL),
(33, 19, 2, 55.00, '2024-12', '5', NULL, NULL, NULL),
(34, 20, 5, 55.00, '2025-06', '9', NULL, NULL, NULL),
(35, 20, 9, 109.00, '2025-02', '56', NULL, NULL, NULL),
(36, 21, 7, 56.00, '2025-03', '9', NULL, NULL, NULL),
(37, 22, 7, 59.00, '2025-07', '55', NULL, NULL, NULL),
(38, 22, 9, 56.00, '2025-07', '59', NULL, NULL, NULL),
(39, 23, 8, 55.00, '2025-03', '5', NULL, NULL, NULL),
(40, 23, 9, 55.00, '2025-07', '55', NULL, NULL, NULL),
(41, 24, 5, 59.00, '2025-07', '5', NULL, NULL, NULL),
(42, 24, 7, 99.00, '2025-11', '9', NULL, NULL, NULL),
(43, 25, 17, 55.00, '2025-07', '5', NULL, NULL, NULL),
(44, 25, 13, 5.00, '2025-08', '55', 2, NULL, NULL),
(45, 26, 19, 505.00, '2025-11', '9', NULL, NULL, NULL),
(46, 26, 17, 1005.00, '2025-11', '10', NULL, NULL, NULL),
(47, 27, 9, 55.00, '2025-03', '5', NULL, NULL, NULL),
(48, 27, 8, 559.00, '2025-11', '5', NULL, NULL, NULL),
(49, 28, 8, 59.00, '2025-07', '5', NULL, NULL, NULL),
(50, 28, 8, 99.00, '2025-10', '5', NULL, NULL, NULL),
(51, 29, 2, 56.00, '2025-07', '9', NULL, NULL, NULL),
(52, 29, 4, 56.00, '2025-07', '59', NULL, NULL, NULL),
(53, 30, 5, 55.00, '2025-07', '5', NULL, NULL, NULL),
(54, 30, 2, 15.00, '2025-08', '5', NULL, NULL, NULL),
(55, 31, 11, 55.00, '2025-03', '5', NULL, NULL, NULL),
(56, 31, 4, 5.00, '2025-11', '5', NULL, NULL, NULL),
(57, 31, 20, 15.00, '2025-10', '5', NULL, NULL, NULL),
(58, 31, 14, 25.00, '2025-11', '5', NULL, NULL, NULL),
(59, 31, 10, 35.00, '2025-12', '5', NULL, NULL, NULL),
(60, 32, 20, 15.00, '2025-11', '15', NULL, NULL, NULL),
(61, 32, 16, 25.00, '2025-10', '5', NULL, NULL, NULL),
(62, 32, 18, 35.00, '2025-11', '5', NULL, NULL, NULL),
(63, 32, 19, 45.00, '2025-10', '15', NULL, NULL, NULL),
(64, 32, 25, 55.00, '2025-12', '5', NULL, NULL, NULL),
(65, 33, 7, 55.00, '2025-07', '5', NULL, NULL, NULL),
(66, 34, 14, 55.00, '2025-07', '5', NULL, NULL, NULL),
(67, 35, 6, 55.00, '2025-02', '5', NULL, NULL, NULL),
(68, 35, 3, 55.00, '2025-02', '5', NULL, NULL, NULL),
(69, 36, 7, 55.00, '2025-06', '5', NULL, NULL, NULL),
(70, 36, 3, 56.00, '2025-01', '55', NULL, NULL, NULL),
(71, 38, 6, 559.00, '2025-01', '6', NULL, NULL, NULL),
(72, 38, 7, 55.00, '2025-10', '55', NULL, NULL, NULL),
(73, 39, 3, 56.00, '2025-01', '65', NULL, NULL, NULL),
(74, 39, 9, 99.00, '2025-01', '6', NULL, NULL, NULL),
(75, 40, 7, 6.00, '2024-12', '6', NULL, NULL, NULL),
(76, 40, 9, 99.00, '2024-12', '6', NULL, NULL, NULL),
(77, 41, 8, 56.00, '2025-12', '6', NULL, NULL, NULL),
(78, 41, 9, 9.00, '2024-08', '9', NULL, NULL, NULL),
(79, 42, 5, 5.00, '2025-12', '9', NULL, NULL, NULL),
(80, 42, 14, 5.00, '2025-07', '1', 2, NULL, NULL),
(81, 42, 7, 15.00, '2025-12', '2', 2, NULL, NULL),
(82, 42, 19, 25.00, '2025-10', '5', 2, NULL, NULL),
(83, 42, 32, 35.00, '2025-11', '5', 2, NULL, NULL),
(84, 43, 1, 105.00, '2024-12', '5', NULL, NULL, NULL),
(85, 43, 3, 109.00, '2024-12', '9', NULL, NULL, NULL),
(86, 44, 1, 9.00, '2024-12', '5', NULL, NULL, NULL),
(87, 44, 2, 18.00, '2024-12', '9', NULL, NULL, NULL),
(88, 45, 3, 99.00, '2024-12', '9', NULL, NULL, NULL),
(89, 46, 1, 105.00, '2024-12', '5', NULL, NULL, NULL),
(90, 46, 4, 109.00, '2024-12', '9', NULL, NULL, NULL),
(91, 47, 3, 99.00, '2025-06', '6', NULL, NULL, NULL),
(92, 47, 5, 56.00, '2025-03', '9', NULL, NULL, NULL),
(93, 48, 6, 51.00, '2025-07', '5', NULL, NULL, NULL),
(94, 49, 1, 55.00, '2025-07', '6', NULL, NULL, NULL),
(95, 49, 4, 5.00, '2025-11', '1', NULL, NULL, NULL),
(96, 50, 2, 99.00, '2025-07', '5', NULL, NULL, NULL),
(97, 50, 7, 6.00, '2025-02', '2', NULL, NULL, NULL),
(98, 51, 5, 6.00, '2025-11', '55', NULL, NULL, NULL),
(99, 52, 5, 99.00, '2025-07', '12', NULL, NULL, NULL),
(100, 53, 5, 55.00, '2025-02', '5', NULL, NULL, NULL),
(101, 53, 8, 99.00, '2025-03', '55', NULL, NULL, NULL),
(102, 54, 4, 99.00, '2025-06', '5', NULL, NULL, NULL),
(103, 54, 8, 56.00, '2025-03', '65', NULL, NULL, NULL),
(104, 55, 8, 59.00, '2024-12', '9', NULL, NULL, NULL),
(105, 56, 25, 9.00, '2025-11', '2', NULL, NULL, NULL),
(106, 57, 1, 55.00, '2025-11', '55', NULL, NULL, NULL),
(107, 57, 5, 99.00, '2025-07', '55', NULL, NULL, NULL),
(108, 57, 8, 5.00, '2025-06', '5', NULL, NULL, NULL),
(109, 57, 12, 105.00, '2025-07', '1', NULL, NULL, NULL),
(110, 57, 13, 55.00, '2025-07', '2', NULL, NULL, NULL),
(111, 58, 12, 55.00, '2025-11', '5', NULL, NULL, NULL),
(112, 59, 5, 5.00, '2025-11', '2', NULL, NULL, NULL),
(113, 60, 6, 55.00, '2024-12', '5', NULL, NULL, NULL),
(120, 65, 7, 109.00, '2024-10', '10', NULL, NULL, NULL),
(121, 65, 8, 55.00, '2024-12', '5', NULL, NULL, NULL),
(122, 66, 3, 5.00, '2025-07', '5', 2, NULL, NULL),
(123, 67, 1, 55.00, '2025-07', '5', NULL, NULL, NULL),
(124, 67, 6, 25.00, '2025-06', '6', NULL, NULL, NULL),
(125, 67, 8, 45.00, '2025-10', '7', NULL, NULL, NULL),
(126, 67, 8, 5.00, '2025-08', '8', NULL, NULL, NULL),
(127, 67, 3, 555.00, '2025-08', '1', NULL, NULL, NULL),
(128, 68, 1, 155.00, '2024-12', '5', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `status` bigint(20) UNSIGNED NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `parent_id`, `name`, `email`, `email_verified_at`, `password`, `status`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, NULL, 'ADMIN', 'admin@gmail.com', NULL, '$2y$12$puG5P1Erq6KuNu6R2GgI.evoA36LZeikTQjy1i/3nuDSw6VkRrJIm', 1, 'xu3Lj9MFEHAsVnnR2tRT5HnSla7CRs41SBp0edA2BYBLmIYLcfpH9BdayH5j', '2024-11-23 01:15:29', '2025-02-05 23:32:32'),
(2, 1, 'AYUSH DONGA', 'ayush.devoteeinfotech+bd@gmail.com', NULL, '$2y$12$jqjJPXV9egpuXXa66hXvB.BF4eaICI2qncz6QNZlGkCBPuBF1F5Di', 1, 'ROiYYdUy5744wQnZy0OducmZogWtJ0PVZb5MKfobUmMVIGcbPOp9pijZI4Tz', '2024-11-28 05:40:36', '2025-01-21 21:48:22'),
(3, 1, 'AYUSH PATEL', 'ayush.devoteeinfotech+product@gmail.com', NULL, '$2y$12$8jP10E8iGcz8qex7hisqZetIqh7Xnq4lhtwd8QK5/1bOb3pbusZuK', 1, 'jwQViaVQSTi82KGd25xTvdPuTwb2iLSDLb7BCppTjFBel89RyNS3biULBqDH', '2024-11-29 00:20:03', '2024-12-24 22:54:27'),
(5, 1, 'BHUMI PATEL', 'buhumi.patel@gmail.com', NULL, '$2y$12$X4BzyaNsJerKXNvHsm/CZuXh8jKP8Abuajqmir1kRI0a2jeXl3ZNG', 1, 'zOr3nhFfsr6fVRnbqdNGsDGKkKRr7ozN53PoDKbA52nsc6H8bXIlT6yOOdYB', '2024-12-19 05:01:54', '2024-12-19 05:01:54'),
(6, 1, 'OM PATEL', 'om.patel@gmail.com', NULL, '$2y$12$lF0Ys7jxt7LjMBd3OWGS1ONID1cpUMzd0UjWk4Qu.eCExe/2qZ6wW', 1, 'vEYN5hMLVQ7JVztsm37HNQt7kleeSV0pfWylOc87ZmRolZ4YrIElpZK07b88', '2024-12-19 05:10:15', '2024-12-19 05:10:15'),
(15, 1, 'ALONE', 'alone55alone55alone55alone55alone55alone555alone55alone5555alone555alone@gmail.com', NULL, '$2y$12$nIrwUj52h637ZPRBWS9Hau9JOuJXPxO0exlh55NN2fr7YiznXdaCm', 1, NULL, '2025-02-04 04:58:28', '2025-02-04 04:58:28'),
(16, 2, 'ART', 'art@gmail.com', NULL, '$2y$12$jmct/Q9rEmvOJaa6uBvV9ueWwp/dVCzhVwb4./RANnef0/3D9OZ36', 1, NULL, '2025-02-06 02:52:36', '2025-02-06 02:52:36'),
(17, 2, 'AHY', 'ahy@gmail.com', NULL, '$2y$12$3MKZqPLmI50M3mAMxi.rx.XTjv99Kd/mWnmrFDKQKvsMymfZVz7hO', 1, NULL, '2025-02-06 02:53:00', '2025-02-06 02:53:00'),
(18, 2, 'AYI', 'ayi@gmail.com', NULL, '$2y$12$mvkancMZS9NJMRYcKI9QSep3RDCRqvBSNusiv9r6ZVQghkEEBJhlS', 1, NULL, '2025-02-06 02:53:44', '2025-02-06 02:53:44'),
(19, 2, 'RTDFG', 'rtdfg@gmail.com', NULL, '$2y$12$DLOigpfPCFfPdSOPIqF9u.2T1cNuHlnQpwF31gaOtk9TQQP.V/koW', 1, NULL, '2025-02-06 02:54:10', '2025-02-06 02:54:10'),
(27, 2, 'ABYU', 'abyu1@gmail.com', NULL, '$2y$12$n91TRx6dg0ofKD36pD9PyeA9zzaI0NflnRBzce/rtQH6L.9EPXzSK', 1, NULL, '2025-02-13 23:38:21', '2025-02-13 23:38:21'),
(28, 2, 'AROG-PLUS-ONE', 'arog-plus-one@gmail.com', NULL, '$2y$12$Ah7h4e5rQWkjSN0QIJvPaesoFxvs7S2qLF1hVJ13zQTAb6uCcDNuq', 1, NULL, '2025-02-14 05:59:44', '2025-02-14 05:59:44'),
(29, 2, 'ARO-G-PLUS-TWO', 'aro-g-plus-two@gmail.com', NULL, '$2y$12$NTz27sITrlM411NaVncVueLiX.NqZoZP1QveXNl1FLG6glnQN9ddi', 1, NULL, '2025-02-14 06:00:21', '2025-02-14 06:00:21');

-- --------------------------------------------------------

--
-- Table structure for table `user_device_token`
--

CREATE TABLE `user_device_token` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `player_id` varchar(255) NOT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_device_token`
--

INSERT INTO `user_device_token` (`id`, `user_id`, `player_id`, `created_by`, `created_at`, `updated_at`) VALUES
(272, 1, '26a21a6b-a9ce-4093-88ca-1f371664d980', 1, '2025-02-19 00:45:14', '2025-02-19 00:45:14'),
(276, 2, 'dbf976e4-db9d-4dc8-95e0-d9a7d2f48454', 2, '2025-02-21 04:52:05', '2025-02-21 04:52:05'),
(282, 2, '6873c3ee-5452-4cfb-958f-9c931b9c83d7', 2, '2025-02-22 04:43:50', '2025-02-22 04:43:50');

-- --------------------------------------------------------

--
-- Table structure for table `venders`
--

CREATE TABLE `venders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `location` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `venders`
--

INSERT INTO `venders` (`id`, `name`, `email`, `phone`, `location`, `created_at`, `updated_at`) VALUES
(1, 'CMO', 'CMO101@GMAIL.COM', '9956695699', '515, ABST NVGA', '2024-11-23 01:22:21', '2024-11-23 01:22:21'),
(2, 'CAPGEMINI', 'CAPGEMINI101@GMAIL.COM', '9959596951', '305, LTRF DDGF', '2024-11-23 01:23:08', '2024-11-23 01:23:08'),
(3, 'OYO', 'OYO101@GMAIL.COM', '9159996959', '99, RTOF GHVC', '2024-11-23 01:24:09', '2024-11-23 01:24:09'),
(4, 'RTVU', 'RTYU101@GMAIL.COM', '9957196589', '96, HVJ TTFG', '2024-11-23 01:24:41', '2024-11-23 01:24:41'),
(5, 'A3REV', 'A3REV@GMAIL.COM', '9955662299', 'A3REV', '2024-12-12 02:55:49', '2024-12-12 02:55:49'),
(6, 'A4DESK', 'A4DESK@GMAIL.COM', '8965235699', 'A4DESK', '2024-12-12 02:56:13', '2024-12-12 02:56:13'),
(7, 'A51DEV', 'A51DEV@GMAIL.COM', '9955445599', 'A51DEV', '2024-12-12 02:56:40', '2024-12-12 02:56:40'),
(8, 'A9TECH', 'A9TECH@GMAIL.COM', '9951515199', 'A9TECH', '2024-12-12 02:57:10', '2024-12-12 02:57:10'),
(9, 'AA-TEAM', 'AA-TEAM@GMAIL.COM', '9955664499', 'AA-TEAM', '2024-12-12 02:57:40', '2024-12-12 02:57:40'),
(10, 'AAJODA', 'AAJODA@GMAIL.COM', '9955445599', 'AAJODA', '2024-12-12 02:58:42', '2024-12-12 02:58:42'),
(11, 'AAKASHWEB', 'AAKASHWEB@GMAIL.COM', '9788559599', 'AAKASHWEB', '2024-12-12 02:59:08', '2024-12-12 02:59:08'),
(12, 'AAPANEL', 'AAPANEL@GMAIL.COM', '9944556699', 'AAPANEL', '2024-12-12 02:59:55', '2024-12-12 02:59:55'),
(13, 'AAS9', 'AAS9@GMAIL.COM', '6565899899', 'AAS9', '2024-12-12 03:00:28', '2024-12-12 03:00:28'),
(14, 'B1', 'B1@GMAIL.COM', '8965326589', 'B1', '2024-12-12 03:01:09', '2024-12-12 03:01:09'),
(15, 'C1', 'C1@GMAIL.COM', '9755669959', 'C1', '2024-12-12 03:01:29', '2024-12-12 03:01:34'),
(16, 'D1', 'D1@GMAIL.COM', '8965455629', 'D1', '2024-12-12 03:01:53', '2024-12-12 03:01:53'),
(17, 'B1G', 'B1G@GMAIL.COM', '9865235689', 'B1G', '2024-12-12 03:03:58', '2024-12-12 03:03:58'),
(18, 'B21SOFT', 'B21SOFT@GMAIL.COM', '8965325699', 'B21SOFT', '2024-12-12 03:06:06', '2024-12-12 03:06:06'),
(19, 'B2EVOLUTION', 'B2EVOLUTION@GMAIL.COM', '5522446699', 'B2EVOLUTION', '2024-12-12 03:06:28', '2024-12-12 03:06:28'),
(20, 'B2X PROJECT', 'B2XPROJECT@GMAIL.COM', '7878785599', 'B2X PROJECT', '2024-12-12 03:07:06', '2024-12-12 03:07:17'),
(25, 'ALONE', 'ALONE101@GMAIL.COM', '9856325698', '1555, RTGB HHNB', '2025-01-12 22:45:00', '2025-01-12 22:48:45'),
(26, 'ALVIN', 'ALVIN@GMAIL.COM', '9562345896', '55, KKYG BNVB', '2025-01-12 22:55:13', '2025-01-23 07:10:41'),
(32, 'SFSF', 'FSFF@GMAIL.COM', '5599554466', '55, GFJHFDH', '2025-02-04 04:37:01', '2025-02-07 05:15:52'),
(38, 'JJJG', NULL, NULL, NULL, '2025-02-07 05:17:15', '2025-02-07 05:17:15'),
(39, 'HGHGHG', NULL, NULL, NULL, '2025-02-07 05:17:20', '2025-02-07 05:17:20'),
(41, 'GDG', NULL, NULL, NULL, '2025-02-13 00:43:00', '2025-02-13 00:43:00'),
(42, 'SGDSGDS', NULL, NULL, NULL, '2025-02-13 00:43:04', '2025-02-13 00:43:04'),
(43, 'HHTRHRH', NULL, NULL, NULL, '2025-02-13 00:43:08', '2025-02-13 00:43:08'),
(45, ',UKYKYK', NULL, NULL, NULL, '2025-02-13 00:43:17', '2025-02-13 00:43:17'),
(49, 'RE34G43GFF3', NULL, NULL, NULL, '2025-02-13 00:51:41', '2025-02-13 00:51:41'),
(50, 'T4T43TF3', NULL, NULL, NULL, '2025-02-13 00:51:45', '2025-02-13 00:51:45'),
(51, 'T4G43FFF', NULL, NULL, NULL, '2025-02-13 00:51:49', '2025-02-13 00:51:49'),
(52, 'G54G4TG43FEF', NULL, NULL, NULL, '2025-02-13 00:51:54', '2025-02-13 00:51:54'),
(53, 'J6J6U56HH5HG', NULL, NULL, NULL, '2025-02-13 00:51:58', '2025-02-13 00:51:58'),
(54, 'UYJNBT67U6HTT', NULL, NULL, NULL, '2025-02-13 00:52:02', '2025-02-13 00:52:02'),
(55, '65Y5HG5TY4T', NULL, NULL, NULL, '2025-02-13 00:52:12', '2025-02-13 00:52:12'),
(56, '6J65YH5H5Y554', NULL, NULL, NULL, '2025-02-13 00:52:18', '2025-02-13 00:52:18'),
(57, 'H65HH5H55', NULL, NULL, NULL, '2025-02-13 00:52:37', '2025-02-13 00:52:37'),
(58, 'HHRHRHRE', NULL, NULL, NULL, '2025-02-13 01:03:09', '2025-02-13 01:03:09'),
(59, 'J6TUY45GEGERG', NULL, NULL, NULL, '2025-02-13 01:03:15', '2025-02-13 01:03:15'),
(60, 'UJ65U54HRH', NULL, NULL, NULL, '2025-02-13 01:03:21', '2025-02-13 01:03:21'),
(61, 'JK65Y54GRG', NULL, NULL, NULL, '2025-02-13 01:03:24', '2025-02-13 01:03:24'),
(62, 'J65U4YHRGRG43T', NULL, NULL, NULL, '2025-02-13 01:03:28', '2025-02-13 01:03:28'),
(63, 'J65UU5HTRHRT', NULL, NULL, NULL, '2025-02-13 01:03:32', '2025-02-13 01:03:32'),
(64, 'KYTKYJT67JH', NULL, NULL, NULL, '2025-02-13 01:03:38', '2025-02-13 01:03:38'),
(65, 'K76I6JTNGHTR', NULL, NULL, NULL, '2025-02-13 01:03:42', '2025-02-13 01:03:42'),
(66, 'UYKGVNFH56U55YR', NULL, NULL, NULL, '2025-02-13 01:03:46', '2025-02-13 01:03:46'),
(67, 'K6I64JNNTJH', NULL, NULL, NULL, '2025-02-13 01:03:50', '2025-02-13 01:03:50'),
(68, 'KU78KJ56J65JH', NULL, NULL, NULL, '2025-02-13 01:03:55', '2025-02-13 01:03:55');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `banks`
--
ALTER TABLE `banks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `banks_account_no_unique` (`account_no`),
  ADD UNIQUE KEY `banks_ifsc_code_unique` (`ifsc_code`);

--
-- Indexes for table `configurations`
--
ALTER TABLE `configurations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customers_client_code_unique` (`client_code`),
  ADD KEY `customers_parent_id_foreign` (`parent_id`),
  ADD KEY `customers_bank_id_foreign` (`bank_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `generics`
--
ALTER TABLE `generics`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inquery_status_history`
--
ALTER TABLE `inquery_status_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inquery_status_history_inquiry_id_foreign` (`inquiry_id`);

--
-- Indexes for table `inquires`
--
ALTER TABLE `inquires`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inquires_brand_id_foreign` (`brand_id`),
  ADD KEY `inquires_generic_id_foreign` (`generic_id`),
  ADD KEY `inquires_assigned_user_id_foreign` (`assigned_user_id`);

--
-- Indexes for table `inquiries_histories`
--
ALTER TABLE `inquiries_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inquiries_histories_inquiry_id_foreign` (`inquiry_id`),
  ADD KEY `inquiries_histories_brand_id_foreign` (`brand_id`),
  ADD KEY `inquiries_histories_generic_id_foreign` (`generic_id`),
  ADD KEY `inquiries_histories_assigned_user_id_foreign` (`assigned_user_id`);

--
-- Indexes for table `manufacturers`
--
ALTER TABLE `manufacturers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_user_id_foreign` (`user_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `orders_invoice_no_unique` (`invoice_no`),
  ADD KEY `orders_bill_to_customer_id_foreign` (`bill_to_customer_id`),
  ADD KEY `orders_ship_to_customer_id_foreign` (`ship_to_customer_id`);

--
-- Indexes for table `order_packages`
--
ALTER TABLE `order_packages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_packages_order_id_foreign` (`order_id`);

--
-- Indexes for table `order_package_products`
--
ALTER TABLE `order_package_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_package_products_order_package_id_foreign` (`order_package_id`),
  ADD KEY `order_package_products_order_product_id_foreign` (`order_product_id`);

--
-- Indexes for table `order_products`
--
ALTER TABLE `order_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_products_order_id_foreign` (`order_id`);

--
-- Indexes for table `order_product_stocks`
--
ALTER TABLE `order_product_stocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_product_stocks_order_product_id_foreign` (`order_product_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_category_unique` (`name`,`guard_name`,`category`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_documents`
--
ALTER TABLE `product_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_documents_quotation_id_foreign` (`quotation_id`);

--
-- Indexes for table `product_documents_histories`
--
ALTER TABLE `product_documents_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_documents_histories_quotation_history_id_foreign` (`quotation_history_id`);

--
-- Indexes for table `product_photos`
--
ALTER TABLE `product_photos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_photos_quotation_id_foreign` (`quotation_id`);

--
-- Indexes for table `product_photos_histories`
--
ALTER TABLE `product_photos_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_photos_histories_quotation_history_id_foreign` (`quotation_history_id`);

--
-- Indexes for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_variants_product_id_foreign` (`product_id`);

--
-- Indexes for table `proformas`
--
ALTER TABLE `proformas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `proformas_invoice_no_unique` (`invoice_no`),
  ADD KEY `proformas_order_id_foreign` (`order_id`),
  ADD KEY `proformas_bill_to_customer_id_foreign` (`bill_to_customer_id`),
  ADD KEY `proformas_ship_to_customer_id_foreign` (`ship_to_customer_id`);

--
-- Indexes for table `proforma_products`
--
ALTER TABLE `proforma_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proforma_products_proforma_id_foreign` (`proforma_id`),
  ADD KEY `proforma_products_product_id_foreign` (`product_id`),
  ADD KEY `proforma_products_product_variant_id_foreign` (`product_variant_id`);

--
-- Indexes for table `quotations`
--
ALTER TABLE `quotations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quotations_inquire_id_foreign` (`inquire_id`),
  ADD KEY `quotations_brand_id_foreign` (`brand_id`),
  ADD KEY `quotations_generic_id_foreign` (`generic_id`),
  ADD KEY `quotations_manufacturer_id_foreign` (`manufacturer_id`),
  ADD KEY `quotations_product_variant_id_foreign` (`product_variant_id`);

--
-- Indexes for table `quotations_histories`
--
ALTER TABLE `quotations_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quotations_histories_inquiry_history_id_foreign` (`inquiry_history_id`),
  ADD KEY `quotations_histories_brand_id_foreign` (`brand_id`),
  ADD KEY `quotations_histories_generic_id_foreign` (`generic_id`),
  ADD KEY `quotations_histories_manufacturer_id_foreign` (`manufacturer_id`),
  ADD KEY `quotations_histories_product_variant_id_foreign` (`product_variant_id`);

--
-- Indexes for table `quotation_queries`
--
ALTER TABLE `quotation_queries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `suppliers_quotation_id_foreign` (`quotation_id`),
  ADD KEY `suppliers_vender_id_foreign` (`vender_id`);

--
-- Indexes for table `suppliers_histories`
--
ALTER TABLE `suppliers_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `suppliers_histories_quotation_history_id_foreign` (`quotation_history_id`),
  ADD KEY `suppliers_histories_vender_id_foreign` (`vender_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_device_token`
--
ALTER TABLE `user_device_token`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_device_token_user_id_player_id_unique` (`user_id`,`player_id`);

--
-- Indexes for table `venders`
--
ALTER TABLE `venders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `venders_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `banks`
--
ALTER TABLE `banks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `configurations`
--
ALTER TABLE `configurations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `generics`
--
ALTER TABLE `generics`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT for table `inquery_status_history`
--
ALTER TABLE `inquery_status_history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=550;

--
-- AUTO_INCREMENT for table `inquires`
--
ALTER TABLE `inquires`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `inquiries_histories`
--
ALTER TABLE `inquiries_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `manufacturers`
--
ALTER TABLE `manufacturers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1911;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `order_packages`
--
ALTER TABLE `order_packages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT for table `order_package_products`
--
ALTER TABLE `order_package_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=268;

--
-- AUTO_INCREMENT for table `order_products`
--
ALTER TABLE `order_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT for table `order_product_stocks`
--
ALTER TABLE `order_product_stocks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `product_documents`
--
ALTER TABLE `product_documents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;

--
-- AUTO_INCREMENT for table `product_documents_histories`
--
ALTER TABLE `product_documents_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `product_photos`
--
ALTER TABLE `product_photos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=193;

--
-- AUTO_INCREMENT for table `product_photos_histories`
--
ALTER TABLE `product_photos_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `proformas`
--
ALTER TABLE `proformas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `proforma_products`
--
ALTER TABLE `proforma_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `quotations`
--
ALTER TABLE `quotations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=216;

--
-- AUTO_INCREMENT for table `quotations_histories`
--
ALTER TABLE `quotations_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `quotation_queries`
--
ALTER TABLE `quotation_queries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=346;

--
-- AUTO_INCREMENT for table `suppliers_histories`
--
ALTER TABLE `suppliers_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `user_device_token`
--
ALTER TABLE `user_device_token`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=283;

--
-- AUTO_INCREMENT for table `venders`
--
ALTER TABLE `venders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_bank_id_foreign` FOREIGN KEY (`bank_id`) REFERENCES `banks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `customers_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inquery_status_history`
--
ALTER TABLE `inquery_status_history`
  ADD CONSTRAINT `inquery_status_history_inquiry_id_foreign` FOREIGN KEY (`inquiry_id`) REFERENCES `inquires` (`id`);

--
-- Constraints for table `inquires`
--
ALTER TABLE `inquires`
  ADD CONSTRAINT `inquires_assigned_user_id_foreign` FOREIGN KEY (`assigned_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `inquires_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `inquires_generic_id_foreign` FOREIGN KEY (`generic_id`) REFERENCES `generics` (`id`);

--
-- Constraints for table `inquiries_histories`
--
ALTER TABLE `inquiries_histories`
  ADD CONSTRAINT `inquiries_histories_assigned_user_id_foreign` FOREIGN KEY (`assigned_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `inquiries_histories_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `inquiries_histories_generic_id_foreign` FOREIGN KEY (`generic_id`) REFERENCES `generics` (`id`),
  ADD CONSTRAINT `inquiries_histories_inquiry_id_foreign` FOREIGN KEY (`inquiry_id`) REFERENCES `inquires` (`id`);

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_bill_to_customer_id_foreign` FOREIGN KEY (`bill_to_customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_ship_to_customer_id_foreign` FOREIGN KEY (`ship_to_customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_packages`
--
ALTER TABLE `order_packages`
  ADD CONSTRAINT `order_packages_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_package_products`
--
ALTER TABLE `order_package_products`
  ADD CONSTRAINT `order_package_products_order_package_id_foreign` FOREIGN KEY (`order_package_id`) REFERENCES `order_packages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_package_products_order_product_id_foreign` FOREIGN KEY (`order_product_id`) REFERENCES `order_products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_products`
--
ALTER TABLE `order_products`
  ADD CONSTRAINT `order_products_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_product_stocks`
--
ALTER TABLE `order_product_stocks`
  ADD CONSTRAINT `order_product_stocks_order_product_id_foreign` FOREIGN KEY (`order_product_id`) REFERENCES `order_products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_documents`
--
ALTER TABLE `product_documents`
  ADD CONSTRAINT `product_documents_quotation_id_foreign` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_documents_histories`
--
ALTER TABLE `product_documents_histories`
  ADD CONSTRAINT `product_documents_histories_quotation_history_id_foreign` FOREIGN KEY (`quotation_history_id`) REFERENCES `quotations_histories` (`id`);

--
-- Constraints for table `product_photos`
--
ALTER TABLE `product_photos`
  ADD CONSTRAINT `product_photos_quotation_id_foreign` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_photos_histories`
--
ALTER TABLE `product_photos_histories`
  ADD CONSTRAINT `product_photos_histories_quotation_history_id_foreign` FOREIGN KEY (`quotation_history_id`) REFERENCES `quotations_histories` (`id`);

--
-- Constraints for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD CONSTRAINT `product_variants_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `proformas`
--
ALTER TABLE `proformas`
  ADD CONSTRAINT `proformas_bill_to_customer_id_foreign` FOREIGN KEY (`bill_to_customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `proformas_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `proformas_ship_to_customer_id_foreign` FOREIGN KEY (`ship_to_customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `proforma_products`
--
ALTER TABLE `proforma_products`
  ADD CONSTRAINT `proforma_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `proforma_products_product_variant_id_foreign` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `proforma_products_proforma_id_foreign` FOREIGN KEY (`proforma_id`) REFERENCES `proformas` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `quotations`
--
ALTER TABLE `quotations`
  ADD CONSTRAINT `quotations_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quotations_generic_id_foreign` FOREIGN KEY (`generic_id`) REFERENCES `generics` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quotations_inquire_id_foreign` FOREIGN KEY (`inquire_id`) REFERENCES `inquires` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quotations_manufacturer_id_foreign` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quotations_product_variant_id_foreign` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`id`);

--
-- Constraints for table `quotations_histories`
--
ALTER TABLE `quotations_histories`
  ADD CONSTRAINT `quotations_histories_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `quotations_histories_generic_id_foreign` FOREIGN KEY (`generic_id`) REFERENCES `generics` (`id`),
  ADD CONSTRAINT `quotations_histories_inquiry_history_id_foreign` FOREIGN KEY (`inquiry_history_id`) REFERENCES `inquiries_histories` (`id`),
  ADD CONSTRAINT `quotations_histories_manufacturer_id_foreign` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturers` (`id`),
  ADD CONSTRAINT `quotations_histories_product_variant_id_foreign` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`id`);

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD CONSTRAINT `suppliers_quotation_id_foreign` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `suppliers_vender_id_foreign` FOREIGN KEY (`vender_id`) REFERENCES `venders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `suppliers_histories`
--
ALTER TABLE `suppliers_histories`
  ADD CONSTRAINT `suppliers_histories_quotation_history_id_foreign` FOREIGN KEY (`quotation_history_id`) REFERENCES `quotations_histories` (`id`),
  ADD CONSTRAINT `suppliers_histories_vender_id_foreign` FOREIGN KEY (`vender_id`) REFERENCES `venders` (`id`);

--
-- Constraints for table `user_device_token`
--
ALTER TABLE `user_device_token`
  ADD CONSTRAINT `user_device_token_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
