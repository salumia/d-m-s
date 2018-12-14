-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Dec 14, 2018 at 01:00 AM
-- Server version: 10.3.9-MariaDB
-- PHP Version: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookkeeper`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `alt_phone` varchar(15) NOT NULL,
  `correspondence_address` varchar(255) NOT NULL,
  `permanent_address` varchar(255) NOT NULL,
  `father_name` varchar(255) NOT NULL,
  `mother_name` varchar(255) NOT NULL,
  `encrypted_password` varchar(100) DEFAULT NULL,
  `salt` varchar(100) NOT NULL DEFAULT '',
  `role` varchar(50) NOT NULL DEFAULT 'admin',
  `department` int(11) NOT NULL DEFAULT 1 COMMENT '1=HR, 2=Marketing,3=Finance',
  `designation` varchar(255) NOT NULL DEFAULT 'other',
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `name` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `remember_token` varchar(100) DEFAULT NULL,
  `api_token` varchar(60) DEFAULT NULL,
  `api_token_expires` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `first_name`, `last_name`, `email`, `phone`, `alt_phone`, `correspondence_address`, `permanent_address`, `father_name`, `mother_name`, `encrypted_password`, `salt`, `role`, `department`, `designation`, `created_at`, `updated_at`, `name`, `password`, `remember_token`, `api_token`, `api_token_expires`) VALUES
(1, 'Testing', 'Admin', 'admin@shredex.net', '+32-4355656756', '+43-2543654765', 'sscsde', 'xdfdvdgs', 'aasdasdsadsf', 'ADSADFS', '$2y$10$lcHTaiw8SPNzbq49qY4UL.ikB96FJuTc3EFBKu3kgNiloU3yzLuoK', 'bce158956dbdb7b82ec14690aadd450d171b6c1094e29c84bdeff79252c9ade3', 'admin', 1, 'Software Engineer', '2014-03-03 10:18:33', '2018-12-13 19:00:13', 'Testing Admin', '$2y$10$OKmM0Oqe82l8O7H0mTtsvOoSo7c6E.WBi0G1S73S9unUTXWXXnj7e', NULL, 'eDT4Oj2cQCEbfEYlaEhgHKfM06iCS3r4vVX2glZ7PZtHBCHJVuOZvv5hAGBX', '2018-12-14 04:30:13');

-- --------------------------------------------------------

--
-- Table structure for table `appraisals`
--

DROP TABLE IF EXISTS `appraisals`;
CREATE TABLE IF NOT EXISTS `appraisals` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stage` int(11) NOT NULL DEFAULT 1,
  `user_id` int(11) NOT NULL,
  `reviewer_id` int(11) DEFAULT NULL,
  `staff_comments` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reviewer_comments` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `appraisals`
--

INSERT INTO `appraisals` (`id`, `from_date`, `to_date`, `status`, `stage`, `user_id`, `reviewer_id`, `staff_comments`, `reviewer_comments`, `department`, `created_at`, `updated_at`) VALUES
(1, '2018-10-31', '2018-10-31', 'Pending', 1, 10, 4, NULL, NULL, 1, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(2, '2018-03-31', '2018-09-29', 'Pending', 1, 21, 12, NULL, NULL, 2, '2018-11-14 17:37:27', '2018-11-14 17:37:27'),
(3, '2018-03-31', '2018-09-29', 'Completed', 3, 22, 12, NULL, NULL, 2, '2018-11-15 18:53:39', '2018-11-15 19:08:34');

-- --------------------------------------------------------

--
-- Table structure for table `appraisal_feedbacks`
--

DROP TABLE IF EXISTS `appraisal_feedbacks`;
CREATE TABLE IF NOT EXISTS `appraisal_feedbacks` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appraisal_id` int(11) DEFAULT NULL,
  `point_id` int(11) DEFAULT NULL,
  `section` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feedback` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rating` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `appraisal_feedbacks`
--

INSERT INTO `appraisal_feedbacks` (`id`, `appraisal_id`, `point_id`, `section`, `feedback`, `rating`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'P1', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(2, 1, 2, 'P1', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(3, 1, 3, 'P2', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(4, 1, 4, 'P2', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(5, 1, 5, 'P2', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(6, 1, 6, 'P2', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(7, 1, 7, 'P2', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(8, 1, 8, 'P2', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(9, 1, 9, 'P2', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(10, 1, 10, 'P2', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(11, 1, 11, 'P2', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(12, 1, 12, 'P2', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(13, 1, 13, 'P2', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(14, 1, 14, 'P2', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(15, 1, 15, 'P2', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(16, 1, 16, 'P2', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(17, 1, 17, 'P3', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(18, 1, 18, 'P3', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(19, 1, 19, 'P3', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(20, 1, 20, 'P3', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(21, 1, 21, 'P3', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(22, 1, 22, 'P3', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(23, 1, 23, 'P3', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(24, 1, 24, 'P3', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(25, 1, 25, 'P3', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(26, 1, 26, 'P3', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(27, 1, 27, 'P3', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(28, 1, 28, 'P4', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(29, 1, 29, 'P5', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(30, 1, 30, 'P5', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(31, 1, 31, 'P6', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(32, 1, 32, 'P6', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(33, 1, 33, 'P6', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(34, 1, 34, 'P6', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(35, 1, 35, 'P7', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(36, 1, 36, 'P7', '', 0, '2018-11-14 17:32:11', '2018-11-14 17:32:11'),
(37, 2, 1, 'P1', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:18'),
(38, 2, 2, 'P1', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:18'),
(39, 2, 3, 'P2', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(40, 2, 4, 'P2', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(41, 2, 5, 'P2', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(42, 2, 6, 'P2', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(43, 2, 7, 'P2', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(44, 2, 8, 'P2', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(45, 2, 9, 'P2', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(46, 2, 10, 'P2', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(47, 2, 11, 'P2', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(48, 2, 12, 'P2', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(49, 2, 13, 'P2', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(50, 2, 14, 'P2', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(51, 2, 15, 'P2', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(52, 2, 16, 'P2', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(53, 2, 17, 'P3', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(54, 2, 18, 'P3', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(55, 2, 19, 'P3', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(56, 2, 20, 'P3', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(57, 2, 21, 'P3', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(58, 2, 22, 'P3', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(59, 2, 23, 'P3', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(60, 2, 24, 'P3', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(61, 2, 25, 'P3', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(62, 2, 26, 'P3', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(63, 2, 27, 'P3', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:26'),
(64, 2, 28, 'P4', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:27'),
(65, 2, 29, 'P5', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:29'),
(66, 2, 30, 'P5', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:29'),
(67, 2, 31, 'P6', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:30'),
(68, 2, 32, 'P6', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:30'),
(69, 2, 33, 'P6', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:30'),
(70, 2, 34, 'P6', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:07:30'),
(71, 2, 35, 'P7', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:00:12'),
(72, 2, 36, 'P7', NULL, 0, '2018-11-14 17:37:27', '2018-11-14 19:00:12'),
(73, 3, 1, 'P1', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:17'),
(74, 3, 2, 'P1', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:17'),
(75, 3, 3, 'P2', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(76, 3, 4, 'P2', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(77, 3, 5, 'P2', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(78, 3, 6, 'P2', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(79, 3, 7, 'P2', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(80, 3, 8, 'P2', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(81, 3, 9, 'P2', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(82, 3, 10, 'P2', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(83, 3, 11, 'P2', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(84, 3, 12, 'P2', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(85, 3, 13, 'P2', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(86, 3, 14, 'P2', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(87, 3, 15, 'P2', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(88, 3, 16, 'P2', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(89, 3, 17, 'P3', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(90, 3, 18, 'P3', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(91, 3, 19, 'P3', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(92, 3, 20, 'P3', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(93, 3, 21, 'P3', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(94, 3, 22, 'P3', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(95, 3, 23, 'P3', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(96, 3, 24, 'P3', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(97, 3, 25, 'P3', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(98, 3, 26, 'P3', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(99, 3, 27, 'P3', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:21'),
(100, 3, 28, 'P4', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:23'),
(101, 3, 29, 'P5', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:24'),
(102, 3, 30, 'P5', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:24'),
(103, 3, 31, 'P6', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:26'),
(104, 3, 32, 'P6', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:26'),
(105, 3, 33, 'P6', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:26'),
(106, 3, 34, 'P6', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:26'),
(107, 3, 35, 'P7', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:34'),
(108, 3, 36, 'P7', NULL, 0, '2018-11-15 18:53:39', '2018-11-15 19:08:34');

-- --------------------------------------------------------

--
-- Table structure for table `appraisal_points`
--

DROP TABLE IF EXISTS `appraisal_points`;
CREATE TABLE IF NOT EXISTS `appraisal_points` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `point` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `section` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `appraisal_points`
--

INSERT INTO `appraisal_points` (`id`, `point`, `description`, `section`, `created_at`, `updated_at`) VALUES
(1, 'Were the key responsibilities during the year same as the KRA’s set out at the beginning of the year? ', '', 'P1', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(2, 'Any Major Achievements/ Contributions in the Company:', '', 'P1', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(3, 'Job Expertise', 'Has the knowledge and skills necessary to fulfill the responsibilities of the position.', 'P2', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(4, 'Time Management ', 'Ability to prioritize and plan deliverables.', 'P2', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(5, 'Coping with Uncertainty', 'Takes the uncertainties of the business in stride. Is able to handle the stress which comes with frequent changes.', 'P2', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(6, 'Inter-personal Skills', 'Is easy to get along with. People generally like him/her. Handles conflicts effectively.Is able to create a rapport with co-workers.', 'P2', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(7, 'Team working', 'Gives due respect to all members of the team. Appreciates the importance of others. Is flexible and open–minded.', 'P2', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(8, 'Dependability ', 'Ability to work in controlled way and hence requiring minimum supervision.', 'P2', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(9, 'Positive attitude', 'Enthusiasm, courtesy, adaptability, flexibility and spirit of cooperation in the work place.', 'P2', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(10, 'Communication skills', 'Connect with peers, subordinates and customers, actively listens, clearly and effectively shares information, demonstrates effective oral and written communication skills.', 'P2', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(11, 'Planning & Organizing Skills', 'Ability to visualize, prioritize and translate goals to short term & long term work plans.     ', 'P2', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(12, 'Problem Solving Skills', 'Ability to actively seek solutions to problems and pro-actively look ahead for specific opportunities for contribution', 'P2', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(13, 'Initiative/ Self Starting Abilities', 'Seeking and picking up responsibilities that you see waiting to be filled. Offers ideas / information without specifically being asked for it.', 'P2', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(14, 'Analytical Skills ', 'Ability to obtain and interpret data to identify critical issues.', 'P2', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(15, 'Ability to obtain and interpret data to identify critical issues.', 'Ability to obtain and interpret data to identify critical issues.', 'P2', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(16, 'Customer orientation', 'Responds to customer concerns to the satisfaction of the customer. Aware of how his work impacts the customer and his business.', 'P2', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(17, 'Team Motivation', '', 'P3', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(18, 'Skills Development of Team Members', '', 'P3', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(19, 'Professional Knowledge', '', 'P3', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(20, 'Leadership & Managerial Role Effectiveness', '', 'P3', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(21, 'People Management', '', 'P3', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(22, 'Handling Crisis', '', 'P3', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(23, 'Presentation Skills', '', 'P3', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(24, 'Decision Making Skills', '', 'P3', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(25, 'Customer Interface & Focus', '', 'P3', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(26, 'Quality Assurance & Implementation', '', 'P3', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(27, 'The Overall Rating for Skills and Attitudes', '', 'P3', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(28, '', '', 'P4', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(29, 'Technical/ Functional Training', '', 'P5', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(30, 'Behavioural/ Soft Skills Training', '', 'P5', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(31, 'How satisfied are you in your current assignment/ project?', '', 'P6', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(32, 'To what extent does your role utilize your skills, capabilities, training & interests?', '', 'P6', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(33, 'What action do you feel should be taken during the coming year to help in making your job more satisfying and your work more productive?', '', 'P6', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(34, 'What are your long term professional objectives?', '', 'P6', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(35, 'The appraisal has been discussed with me', '', 'P7', '2018-09-13 01:30:00', '2018-09-13 01:30:00'),
(36, 'The feedback provided has been beneficial and will help in performing better', '', 'P7', '2018-09-13 01:30:00', '2018-09-13 01:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `claims`
--

DROP TABLE IF EXISTS `claims`;
CREATE TABLE IF NOT EXISTS `claims` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `claim_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `amount` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `detail` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `claims`
--

INSERT INTO `claims` (`id`, `claim_type`, `from_date`, `to_date`, `amount`, `detail`, `status`, `user_id`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Canveyance', '2018-10-04', '2018-10-04', '2000', 'Sales expense', 'Pending', 5, NULL, '2018-10-03 15:14:30', '2018-10-03 15:14:30'),
(2, 'Canveyance', '2018-10-11', '2018-10-11', '200', 'travelled for office work', 'Approved', 15, 14, '2018-10-12 13:01:41', '2018-10-12 13:02:53');

-- --------------------------------------------------------

--
-- Table structure for table `document_templates`
--

DROP TABLE IF EXISTS `document_templates`;
CREATE TABLE IF NOT EXISTS `document_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` enum('html','plain','sheet','doc') COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cloud_document_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_files`
--

DROP TABLE IF EXISTS `employee_files`;
CREATE TABLE IF NOT EXISTS `employee_files` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `original_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employee_files`
--

INSERT INTO `employee_files` (`id`, `name`, `original_name`, `user_id`, `created_at`, `updated_at`) VALUES
(1, '1535460998.docx', 'Email - offer letter format.docx', 5, '2018-08-28 19:58:07', '2018-08-28 19:58:07'),
(3, '1535481535.docx', 'Email - offer letter format.docx', 7, '2018-08-29 01:38:56', '2018-08-29 01:38:56');

-- --------------------------------------------------------

--
-- Table structure for table `key_responsibilities`
--

DROP TABLE IF EXISTS `key_responsibilities`;
CREATE TABLE IF NOT EXISTS `key_responsibilities` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `comment` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rating` int(11) DEFAULT NULL,
  `appraisal_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leaves`
--

DROP TABLE IF EXISTS `leaves`;
CREATE TABLE IF NOT EXISTS `leaves` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `leave_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_date` date DEFAULT NULL,
  `from_day_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `to_date` date DEFAULT NULL,
  `to_day_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `leaves`
--

INSERT INTO `leaves` (`id`, `leave_type`, `reason`, `from_date`, `from_day_type`, `to_date`, `to_day_type`, `status`, `user_id`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Casual', 'Some Urgency at home', '2018-08-29', 'full_day', '2018-09-02', 'half_day', 'Approved', 4, 4, '2018-08-29 01:45:43', '2018-08-29 03:02:38'),
(2, 'Casual', 'cdhojfd', '2018-09-04', 'full_day', '2018-09-06', 'full_day', 'Approved', 8, 4, '2018-08-29 13:38:55', '2018-08-29 13:39:14'),
(3, 'Medical', 'BCB', '2018-08-29', 'full_day', '2018-08-30', 'full_day', 'Approved', 10, 10, '2018-08-29 14:17:51', '2018-08-29 14:18:19'),
(4, 'Medical', 'dEWFQ', '2018-09-11', 'half_day', '2018-09-17', 'full_day', 'Approved', 4, 4, '2018-08-29 17:00:09', '2018-10-04 17:17:38'),
(5, 'Medical', 'hv to go out', '2018-09-25', 'full_day', '2018-09-27', 'full_day', 'Rejected', 11, 4, '2018-08-30 15:50:43', '2018-08-30 15:51:21'),
(6, 'Casual', 'gfhghtjerj', '2018-10-24', 'full_day', '2018-10-25', 'half_day', 'Approved', 5, 4, '2018-10-04 12:50:49', '2018-10-04 17:17:37'),
(7, 'Casual', 'XX ZXC', '2018-10-11', 'full_day', '2018-10-14', 'full_day', 'Approved', 15, 4, '2018-10-04 17:11:27', '2018-10-04 17:17:27'),
(8, 'Casual', 'need to go to my home town', '2018-11-08', 'full_day', '2018-11-08', 'full_day', 'Pending', 15, NULL, '2018-11-01 15:35:55', '2018-11-01 15:35:55');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2018_03_04_211153_adds_api_token_to_users_table', 2),
(5, '2018_03_28_234543_create_policies_table', 3),
(6, '2018_03_29_000139_create_policy_rates_table', 3),
(7, '2018_03_29_000429_create_states_table', 3),
(8, '2018_03_29_000435_create_class_codes_table', 3),
(9, '2018_03_30_012234_add_client_other_names', 4),
(10, '2018_04_06_074933_create_document_queues_table', 5),
(11, '2018_04_06_074940_create_document_printers_table', 5),
(12, '2018_04_06_074945_create_document_templates_table', 5),
(13, '2018_04_06_074952_create_document_batches_table', 5),
(14, '2018_04_06_074959_create_documents_table', 5),
(15, '2018_04_14_232318_add_softdeletes_policies', 6),
(16, '2018_04_14_232353_add_softdeletes_policy_rates', 6),
(17, '2018_04_14_232402_add_softdeletes_states', 6),
(18, '2018_04_14_232408_add_softdeletes_class_codes', 6),
(19, '2018_04_14_232413_add_softdeletes_clients', 6),
(20, '2013_04_09_062329_create_revisions_table', 7),
(21, '2018_04_17_171216_add_softdeletes_payroll_companies', 8),
(22, '2018_04_17_171330_add_softdeletes_payroll_frequency', 9),
(23, '2018_04_17_174755_add_softdeletes_carrier', 10),
(25, '2018_04_28_080415_create_notes_table', 11),
(26, '2018_04_30_051409_create_contacts_table', 12),
(27, '2018_04_30_052542_add_client_id_to_contacts', 13),
(28, '2018_05_01_080448_create_activities_table', 14),
(29, '2018_05_01_081440_create_activity_log_table', 15),
(30, '2018_05_02_112447_add_user_id_to_activity_log', 16),
(33, '2018_05_03_084340_create_worklist_table', 17),
(34, '2018_05_03_090153_add_payroll_fields_to_clients', 18),
(35, '2018_05_10_121802_update_agencies_table', 19),
(36, '2018_05_12_120250_create_brokers_table', 20),
(37, '2018_05_14_055945_update_payroll_company_table', 21),
(38, '2018_05_14_072638_update_worklists_table', 22),
(39, '2018_08_02_012313_create_pages_table', 23),
(40, '2018_08_02_043817_create_page_files_table', 24),
(41, '2018_08_05_164609_update_users_table', 25),
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2018_03_04_211153_adds_api_token_to_users_table', 2),
(5, '2018_03_28_234543_create_policies_table', 3),
(6, '2018_03_29_000139_create_policy_rates_table', 3),
(7, '2018_03_29_000429_create_states_table', 3),
(8, '2018_03_29_000435_create_class_codes_table', 3),
(9, '2018_03_30_012234_add_client_other_names', 4),
(10, '2018_04_06_074933_create_document_queues_table', 5),
(11, '2018_04_06_074940_create_document_printers_table', 5),
(12, '2018_04_06_074945_create_document_templates_table', 5),
(13, '2018_04_06_074952_create_document_batches_table', 5),
(14, '2018_04_06_074959_create_documents_table', 5),
(15, '2018_04_14_232318_add_softdeletes_policies', 6),
(16, '2018_04_14_232353_add_softdeletes_policy_rates', 6),
(17, '2018_04_14_232402_add_softdeletes_states', 6),
(18, '2018_04_14_232408_add_softdeletes_class_codes', 6),
(19, '2018_04_14_232413_add_softdeletes_clients', 6),
(20, '2013_04_09_062329_create_revisions_table', 7),
(21, '2018_04_17_171216_add_softdeletes_payroll_companies', 8),
(22, '2018_04_17_171330_add_softdeletes_payroll_frequency', 9),
(23, '2018_04_17_174755_add_softdeletes_carrier', 10),
(25, '2018_04_28_080415_create_notes_table', 11),
(26, '2018_04_30_051409_create_contacts_table', 12),
(27, '2018_04_30_052542_add_client_id_to_contacts', 13),
(28, '2018_05_01_080448_create_activities_table', 14),
(29, '2018_05_01_081440_create_activity_log_table', 15),
(30, '2018_05_02_112447_add_user_id_to_activity_log', 16),
(33, '2018_05_03_084340_create_worklist_table', 17),
(34, '2018_05_03_090153_add_payroll_fields_to_clients', 18),
(35, '2018_05_10_121802_update_agencies_table', 19),
(36, '2018_05_12_120250_create_brokers_table', 20),
(37, '2018_05_14_055945_update_payroll_company_table', 21),
(38, '2018_05_14_072638_update_worklists_table', 22),
(39, '2018_08_02_012313_create_pages_table', 23),
(40, '2018_08_02_043817_create_page_files_table', 24),
(41, '2018_08_05_164609_update_users_table', 25);

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
CREATE TABLE IF NOT EXISTS `pages` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect_url` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `static_menu_link` int(11) DEFAULT 0,
  `description` longblob DEFAULT NULL,
  `cover_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `title`, `type`, `redirect_url`, `static_menu_link`, `description`, `cover_image`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Standard Documents', '1', NULL, 0, 0x3c7020636c6173733d22716c2d616c69676e2d63656e746572223e3c7374726f6e673e416c6c207468652063656e7472616c697a6564207374616e6461726420646f63756d656e7473206f662074686520457374656c20436f6d70616e792e3c2f7374726f6e673e3c2f703e, '', '2018-08-09 07:00:00', '2018-08-21 16:52:27', NULL),
(2, 'Organizational Chart', '1', NULL, 0, NULL, '1533883175.jpg', '2018-08-09 07:00:00', '2018-08-10 13:39:42', NULL),
(3, 'LMS', '2', 'http://trigvent.com', 0, NULL, '', '2018-08-09 07:00:00', '2018-08-10 13:40:21', NULL),
(4, 'Holidays', '1', NULL, 1, NULL, '1534844711.jpg', '2018-08-09 07:00:00', '2018-08-21 16:46:07', NULL),
(5, 'Events', '1', NULL, 1, NULL, '', '2018-08-09 07:00:00', '2018-08-09 07:00:00', NULL),
(6, 'Vacancies', '1', NULL, 0, 0x3c68323e3c753e46726f6e7420456e6420446576656c6f7065723c2f753e3c2f68323e3c703e3c62723e3c2f703e3c7020636c6173733d22716c2d616c69676e2d63656e746572223e4e657420536f6c7574696f6e73206973206120746563686e6f6c6f677920626173656420636f6d70616e7920696e204368616e6469676172682c20496e6469612e205765206275696c64206f6d6e692d6368616e6e656c206469676974616c20657870657269656e63657320627920636f6e76657267696e6720746563686e6f6c6f67696573206c696b65205765622c204d6f62696c652c20536f6369616c2c20436c6f756420616e6420496f542e3c2f703e3c7020636c6173733d22716c2d616c69676e2d63656e746572223e3c62723e3c2f703e3c683220636c6173733d22716c2d616c69676e2d63656e746572223e4f7572204172656173206f662065787065727469736520696e636c7564653a3c2f68323e3c756c3e3c6c6920636c6173733d22716c2d616c69676e2d63656e746572223e5573657220457870657269656e63652044657369676e3c2f6c693e3c2f756c3e3c7020636c6173733d22716c2d616c69676e2d63656e746572223e3c62723e3c2f703e3c756c3e3c6c6920636c6173733d22716c2d616c69676e2d63656e746572223e437573746f6d657220456e676167656d656e7420536f6c7574696f6e733c2f6c693e3c6c6920636c6173733d22716c2d616c69676e2d63656e746572223e456e7465727072697365204469676974616c20456e676167656d656e743c2f6c693e3c6c6920636c6173733d22716c2d616c69676e2d63656e746572223e4f7574736f75726365642050726f6475637420446576656c6f706d656e743c2f6c693e3c2f756c3e3c7020636c6173733d22716c2d616c69676e2d63656e746572223e3c62723e3c2f703e3c683220636c6173733d22716c2d616c69676e2d63656e746572223e3c62723e3c2f68323e3c683220636c6173733d22716c2d616c69676e2d63656e746572223e3c62723e3c2f68323e3c683220636c6173733d22716c2d616c69676e2d63656e746572223e4f7267616e697a6174696f6e616c2043756c747572653c2f68323e3c756c3e3c6c6920636c6173733d22716c2d616c69676e2d63656e746572223e4f7572206f7267616e697a6174696f6e616c2063756c7475726520697320676f616c206f7269656e7465642c2064796e616d69632c20686967682d67726f7774682c20666173742d70616365642c20616e6420666f6375736564206f6e20657863657074696f6e616c20637573746f6d657220736572766963652e20576520776f756c642065787065637420746865207375636365737366756c2063616e64696461746520746f20706f737365737320616e20657863657074696f6e616c206162696c69747920696e206275696c64696e6720656666656374697665207465616d732c20616e64206c656164696e6720706572736f6e6e656c20746f20616368696576652064657369726564206f626a656374697665732e3c2f6c693e3c6c6920636c6173733d22716c2d616c69676e2d63656e746572223e5375706572696f7220627573696e657373206163756d656e2c2066756e6374696f6e616c2f746563686e6963616c20736b696c6c732c20696e7465677269747920616e642074727573742061726520657373656e7469616c2e3c2f6c693e3c6c6920636c6173733d22716c2d616c69676e2d63656e746572223e4275696c64696e6720656666656374697665207465616d732c20646576656c6f70696e6720646972656374207265706f7274732c20616e64206d6f7469766174696e67207468656d20746f20647269766520666f7220726573756c74732061726520637269746963616c20746f20737563636573732e3c2f6c693e3c6c6920636c6173733d22716c2d616c69676e2d63656e746572223e496e206164646974696f6e2c2068652f736865206d757374206265207374726f6e676c79206173736573736564206f6e20696e7465722d706572736f6e616c20636f6d6d756e69636174696f6e2c20637573746f6d657220666f6375732c207072696f726974792073657474696e672c2070726f626c656d20736f6c76696e672c20616e64206465616c696e67207769746820616d626967756974792c20616e64206f7267616e697a6174696f6e616c206167696c6974792e3c2f6c693e3c2f756c3e3c7020636c6173733d22716c2d616c69676e2d63656e746572223e3c62723e3c2f703e3c683220636c6173733d22716c2d616c69676e2d63656e746572223e526f6c657320616e6420526573706f6e736962696c69746965733c2f68323e3c756c3e3c6c6920636c6173733d22716c2d616c69676e2d63656e746572223e5472616e73666f726d2064657369676e206d6f636b2d75707320746f20573343207374616e646172647320636f6d706c69616e742c2063726f73732d62726f7773657220636f6d70617469626c652048544d4c207061676573207573696e672048544d4c2f5848544d4c2f4353532f4a5320776974682050686f746f73686f702f447265616d7765617665722e3c2f6c693e3c6c6920636c6173733d22716c2d616c69676e2d63656e746572223e41737369737420746563686e6f6c6f677920646576656c6f7065727320696e20696e746567726174696e67206261636b2d656e64206c6f6769632077697468207468652066726f6e742d656e64206c617965722e3c2f6c693e3c2f756c3e3c7020636c6173733d22716c2d616c69676e2d63656e746572223e3c62723e3c2f703e3c683220636c6173733d22716c2d616c69676e2d63656e746572223e536b696c6c7320616e6420457870657269656e63653c2f68323e3c756c3e3c6c6920636c6173733d22716c2d616c69676e2d63656e746572223e4d75737420686176652061206d696e696d756d20657870657269656e6365206f6620322d342079656172732e3c2f6c693e3c6c6920636c6173733d22716c2d616c69676e2d63656e746572223e4162696c69747920746f2068616e642d636f646520616e642064656c6976657220636c65616e2c2076616c6964617465642c2063726f73732d62726f7773657220636f6d70617469626c6520636f64652e3c2f6c693e3c2f756c3e3c7020636c6173733d22716c2d616c69676e2d63656e746572223e3c62723e3c2f703e3c683220636c6173733d22716c2d616c69676e2d63656e746572223e456475636174696f6e3c2f68323e3c756c3e3c6c6920636c6173733d22716c2d616c69676e2d63656e746572223e42746563682f4d43413c2f6c693e3c2f756c3e3c703e3c62723e3c2f703e, '', '2018-08-09 07:00:00', '2018-08-09 07:00:00', NULL),
(7, 'Induction', '1', NULL, 0, 0x3c703e446f776e6c6f616420496e64756374696f6e20446f63756d656e74732062656c6f773c2f703e, '', '2018-08-09 07:00:00', '2018-08-21 16:50:24', NULL),
(8, 'HR Policies', '1', NULL, 0, 0x3c703e53696e636520323030302c204e657420536f6c7574696f6e7320686173206265656e20646576656c6f70696e6720776562206170706c69636174696f6e7320666f7220636f6d70616e696573206163726f73732074686520676c6f62652e204f726967696e616c6c79206275696c7420617320612077656220706f7274616c20627920686f6262796973742053616d656572204a61696e2c2069742068617320726973656e20746f206265636f6d6520616e20696e7465726e6174696f6e616c6c79206b6e6f776e206272616e6420696e20697473206669656c642c20776974682061207465616d206f66206d6f7265207468616e203232352b20776f726b696e672066726f6d20697473206f6666696365732c20696e204368616e6469676172682c204e657720596f726b2c20546f726f6e746f2c20616e64204c6f6e646f6e2e3c2f703e3c703e3c62723e3c2f703e3c68323e4f757220506172746e6572733c2f68323e3c756c3e3c6c693e4e657420536f6c7574696f6e7320646576656c6f7073206170706c69636174696f6e7320616e6420736f6c7574696f6e732074686174207075742074686520637573746f6d65722066697273742e205768656e2070656f706c6520636f6d6520746f20757320666f722068656c702c20776520736565207468656d20617320627573696e65737320706172746e65727320666972737420616e6420636c69656e7473207365636f6e642c2074616b696e67206f6e2070726f6a6563747320746861742077652062656c6965766520696e20616e64206d616b696e67207468656d206f7572206f776e2e3c2f6c693e3c6c693e5769746820637265617469766974792c20726573706563742c207472616e73706172656e63792c207175616c69747920616e64207465616d776f726b206174207468652063656e746572206f6620616c6c20776520646f2c207765206861766520666f7267656420706f77657266756c20706172746e65727368697073207769746820696e647573747279206c6561646572732073756368206173204d6963726f736f66742c20416d617a6f6e205765622053657276696365732c204b656e7469636f2c204170706c6520616e6420476f6f676c6520506c61792e3c2f6c693e3c2f756c3e3c703e3c62723e3c2f703e3c703e3c62723e3c2f703e3c703e3c62723e3c2f703e3c703e3c62723e3c2f703e3c703e3c62723e3c2f703e3c703e3c62723e3c2f703e3c703e3c62723e3c2f703e3c703e3c62723e3c2f703e3c703e3c62723e3c2f703e3c703e3c7374726f6e673e54686573652074696573206d65616e20776520686176652061636365737320746f20746865206d6f73742063757474696e67206564676520746f6f6c7320616e64206578636c757369766520736f66747761726520646576656c6f706d656e74207265736f757263657320617661696c61626c652e3c2f7374726f6e673e3c2f703e, '', '2018-08-09 07:00:00', '2018-08-09 07:00:00', NULL),
(9, 'Announcements', '1', NULL, 1, 0x3c703e646977616c6920706172747920676561722075703c2f703e3c703e3c62723e3c2f703e3c703e3c62723e3c2f703e, '', '2018-08-09 07:00:00', '2018-11-01 16:26:16', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `page_files`
--

DROP TABLE IF EXISTS `page_files`;
CREATE TABLE IF NOT EXISTS `page_files` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `original_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `page_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `page_files`
--

INSERT INTO `page_files` (`id`, `name`, `original_name`, `page_id`, `created_at`, `updated_at`) VALUES
(24, '1534845020.doc', 'Employee Induction Overview.doc', 7, '2018-08-21 16:50:25', '2018-08-21 16:50:25'),
(25, '1534845140.doc', 'Application for Change of address.doc', 1, '2018-08-21 16:52:28', '2018-08-21 16:52:28'),
(26, '1534845140.doc', 'Appointment Letter - Mgr.doc', 1, '2018-08-21 16:52:28', '2018-08-21 16:52:28'),
(27, '1534845140.doc', 'Appointment letter 2011.doc', 1, '2018-08-21 16:52:28', '2018-08-21 16:52:28'),
(28, '1534845140.xls', 'Appraisal form.xls', 1, '2018-08-21 16:52:28', '2018-08-21 16:52:28'),
(29, '1534845140.DOC', 'Comp OFF FORM.DOC', 1, '2018-08-21 16:52:28', '2018-08-21 16:52:28'),
(30, '1534845140.doc', 'Consultant Contract Format.doc', 1, '2018-08-21 16:52:28', '2018-08-21 16:52:28'),
(31, '1534845140.doc', 'conv._form.doc', 1, '2018-08-21 16:52:28', '2018-08-21 16:52:28'),
(32, '1534845140.docx', 'Email - offer letter format.docx', 1, '2018-08-21 16:52:28', '2018-08-21 16:52:28'),
(33, '1534845140.doc', 'Employee Induction Overview.doc', 1, '2018-08-21 16:52:28', '2018-08-21 16:52:28'),
(34, '1534845140.xls', 'Estel Job Description Form.xls', 1, '2018-08-21 16:52:28', '2018-08-21 16:52:28'),
(35, '1534845140.doc', 'EXIT INTERVIEW FORM.doc', 1, '2018-08-21 16:52:28', '2018-08-21 16:52:28'),
(36, '1534845140.doc', 'exp certificate ETL.doc', 1, '2018-08-21 16:52:28', '2018-08-21 16:52:28'),
(37, '1534845140.xls', 'Final interview assessment sheet.xls', 1, '2018-08-21 16:52:28', '2018-08-21 16:52:28'),
(38, '1534845140.doc', 'Full and final settlement-ETL.doc', 1, '2018-08-21 16:52:28', '2018-08-21 16:52:28'),
(39, '1534845190.doc', 'Interview Report.doc', 1, '2018-08-21 16:53:20', '2018-08-21 16:53:20'),
(40, '1534845190.doc', 'Name change letter.doc', 1, '2018-08-21 16:53:20', '2018-08-21 16:53:20'),
(41, '1534845190.doc', 'new joinee mail.doc', 1, '2018-08-21 16:53:20', '2018-08-21 16:53:20'),
(42, '1534845190.doc', 'Offer Letters - ETL.doc', 1, '2018-08-21 16:53:20', '2018-08-21 16:53:20'),
(43, '1534845190.xls', 'personal.xls', 1, '2018-08-21 16:53:20', '2018-08-21 16:53:20'),
(44, '1534845190.doc', 'relieving letter ETL.doc', 1, '2018-08-21 16:53:20', '2018-08-21 16:53:20'),
(45, '1534845190.doc', 'transfer letters.doc', 1, '2018-08-21 16:53:20', '2018-08-21 16:53:20'),
(46, '1534845190.doc', 'Work from home form.doc', 1, '2018-08-21 16:53:20', '2018-08-21 16:53:20');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`id`, `email`, `token`, `created_at`, `updated_at`) VALUES
(2, 'nitinsaluja@example.com', 'GvH0ipOcZdo4gO3JdrZkbnFnQ1p9RWTFQKplwbHYLtg56KA1gutkBS7hfxcO', '2018-12-13 11:16:06', '2018-12-13 19:24:49'),
(3, 'kirpal@example.com', 'eU76uw84AFCb8klZMdyLxi5RZbRcUhtWzzj11EqyLIMCXaZxbY9MpbVtV8N0', '2018-12-13 19:18:52', '2018-12-13 19:19:49');

-- --------------------------------------------------------

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
CREATE TABLE IF NOT EXISTS `revisions` (
  `id` int(10) UNSIGNED DEFAULT NULL,
  `revisionable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revisionable_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `old_value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `revisions`
--

INSERT INTO `revisions` (`id`, `revisionable_type`, `revisionable_id`, `user_id`, `key`, `old_value`, `new_value`, `created_at`, `updated_at`) VALUES
(1, 'Modules\\Client\\Entities\\Contact', 1, 4, 'name', 'Nitin', 'Nitin111', '2018-04-30 06:57:58', '2018-04-30 06:57:58'),
(2, 'Modules\\Client\\Entities\\Contact', 1, 4, 'role', 'role1', 'role3', '2018-04-30 06:57:58', '2018-04-30 06:57:58'),
(3, 'Modules\\Client\\Entities\\Contact', 1, 4, 'email', 'aa@hh.com', 'aa@hh.com1', '2018-04-30 06:57:58', '2018-04-30 06:57:58'),
(4, 'Modules\\Client\\Entities\\Contact', 1, 4, 'phone', '6565675656', '6565675611', '2018-04-30 06:57:58', '2018-04-30 06:57:58'),
(5, 'Modules\\Client\\Entities\\Contact', 1, 4, 'name', 'Nitin111', 'Nitin141', '2018-04-30 06:59:22', '2018-04-30 06:59:22'),
(6, 'Modules\\Client\\Entities\\Contact', 1, 4, 'name', 'Nitin141', 'Nitin11', '2018-04-30 07:05:20', '2018-04-30 07:05:20'),
(7, 'Modules\\Client\\Entities\\Contact', 1, 4, 'role', 'role3', 'role2', '2018-04-30 07:05:20', '2018-04-30 07:05:20'),
(8, 'Modules\\Client\\Entities\\Contact', 1, 4, 'role', 'role2', 'role3', '2018-04-30 07:05:41', '2018-04-30 07:05:41'),
(9, 'Modules\\Client\\Entities\\Contact', 4, 4, 'name', 'nnn', 'Test latest', '2018-04-30 07:08:21', '2018-04-30 07:08:21'),
(10, 'Modules\\Client\\Entities\\Contact', 4, 4, 'email', 'n@n', 'latest@test.com', '2018-04-30 07:08:21', '2018-04-30 07:08:21'),
(11, 'Modules\\Client\\Entities\\Contact', 4, 4, 'phone', '5454455456', '1234567890', '2018-04-30 07:08:21', '2018-04-30 07:08:21'),
(12, 'Modules\\Client\\Entities\\Contact', 1, 4, 'name', 'Nitin11', 'Nitin111', '2018-05-01 01:33:48', '2018-05-01 01:33:48'),
(13, 'Modules\\Client\\Entities\\Contact', 1, 4, 'role', 'role3', 'role1', '2018-05-01 01:33:48', '2018-05-01 01:33:48'),
(14, 'Modules\\Client\\Entities\\Contact', 1, 4, 'phone', '6565675611', '1165675611', '2018-05-01 01:33:48', '2018-05-01 01:33:48'),
(15, 'Modules\\Client\\Entities\\Contact', 1, 4, 'name', 'Nitin111', 'Nitin', '2018-05-01 01:46:53', '2018-05-01 01:46:53'),
(16, 'Modules\\Client\\Entities\\Contact', 1, 4, 'role', 'role1', 'role2', '2018-05-01 01:46:53', '2018-05-01 01:46:53'),
(17, 'Modules\\Client\\Entities\\Client', 1, NULL, 'is_active', '0', '1', '2018-05-01 07:24:54', '2018-05-01 07:24:54'),
(18, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '1', '0', '2018-05-01 08:49:27', '2018-05-01 08:49:27'),
(19, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '0', '1', '2018-05-01 23:27:13', '2018-05-01 23:27:13'),
(20, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '1', '0', '2018-05-01 23:37:05', '2018-05-01 23:37:05'),
(21, 'Modules\\Client\\Entities\\Contact', 1, 4, 'name', 'Nitin', 'Nitin1', '2018-05-01 23:37:19', '2018-05-01 23:37:19'),
(22, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '0', '1', '2018-05-02 01:06:34', '2018-05-02 01:06:34'),
(23, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '1', '0', '2018-05-02 01:55:58', '2018-05-02 01:55:58'),
(24, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '0', '1', '2018-05-02 02:11:53', '2018-05-02 02:11:53'),
(25, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '1', '0', '2018-05-02 02:22:25', '2018-05-02 02:22:25'),
(26, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '0', '1', '2018-05-02 02:23:31', '2018-05-02 02:23:31'),
(27, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '1', '0', '2018-05-02 02:26:41', '2018-05-02 02:26:41'),
(28, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '0', '1', '2018-05-02 02:28:00', '2018-05-02 02:28:00'),
(29, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '1', '0', '2018-05-02 02:29:16', '2018-05-02 02:29:16'),
(30, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '0', '1', '2018-05-02 02:29:20', '2018-05-02 02:29:20'),
(31, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '1', '0', '2018-05-02 02:30:24', '2018-05-02 02:30:24'),
(32, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '0', '1', '2018-05-02 02:31:23', '2018-05-02 02:31:23'),
(33, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '1', '0', '2018-05-02 02:31:27', '2018-05-02 02:31:27'),
(34, 'Modules\\Client\\Entities\\Contact', 1, 4, 'name', 'Nitin1', 'test on 2 may by nitin', '2018-05-02 09:05:47', '2018-05-02 09:05:47'),
(35, 'Modules\\Client\\Entities\\Contact', 1, 4, 'role', 'role2', 'role1', '2018-05-02 09:05:47', '2018-05-02 09:05:47'),
(36, 'Modules\\Client\\Entities\\Contact', 1, 4, 'email', 'aa@hh.com1', 'n1@n.com', '2018-05-02 09:05:47', '2018-05-02 09:05:47'),
(37, 'Modules\\Client\\Entities\\Contact', 1, 4, 'phone', '1165675611', '5554335345', '2018-05-02 09:05:47', '2018-05-02 09:05:47'),
(38, 'Modules\\Client\\Entities\\Contact', 8, 4, 'name', 'test on 2 may', 'test on 2 may current', '2018-05-02 09:10:53', '2018-05-02 09:10:53'),
(39, 'Modules\\Client\\Entities\\Contact', 8, 4, 'email', 'n@n.com', 'n7@n.com', '2018-05-02 09:10:53', '2018-05-02 09:10:53'),
(40, 'Modules\\Client\\Entities\\Contact', 8, 4, 'phone', '4324335345', '7774335345', '2018-05-02 09:10:53', '2018-05-02 09:10:53'),
(41, 'Modules\\Client\\Entities\\Contact', 1, 4, 'name', 'test on 2 may by nitin', 'test on 2', '2018-05-02 09:15:17', '2018-05-02 09:15:17'),
(42, 'Modules\\Client\\Entities\\Client', 1, 4, 'city', 'Davie', 'Davies', '2018-05-03 00:11:41', '2018-05-03 00:11:41'),
(43, 'Modules\\Client\\Entities\\Client', 1, 4, 'state', 'FL', 'MA', '2018-05-03 00:11:41', '2018-05-03 00:11:41'),
(44, 'Modules\\Client\\Entities\\Client', 1, 4, 'fein', '650582687', '650582685', '2018-05-03 00:11:41', '2018-05-03 00:11:41'),
(45, 'Modules\\Client\\Entities\\Client', 1, 4, 'company_name', 'Gene Contracting Demolition Inc.', '1Gene Contracting Demolition Inc.', '2018-05-03 01:07:33', '2018-05-03 01:07:33'),
(46, 'Modules\\Client\\Entities\\Client', 1, 4, 'address', '4980 Southwest 52nd Street #110', '4980 Southwest 52nd Street #111', '2018-05-03 01:13:41', '2018-05-03 01:13:41'),
(47, 'Modules\\Client\\Entities\\Client', 1, 4, 'city', 'Davies', 'Davie', '2018-05-03 01:13:41', '2018-05-03 01:13:41'),
(48, 'Modules\\Client\\Entities\\Client', 1, 4, 'state', 'MA', 'FL', '2018-05-03 01:13:41', '2018-05-03 01:13:41'),
(49, 'Modules\\Client\\Entities\\Client', 1, 4, 'zip', '33314', '333140', '2018-05-03 01:13:41', '2018-05-03 01:13:41'),
(50, 'Modules\\Client\\Entities\\Client', 1, 4, 'fein', '650582685', '6505826850', '2018-05-03 01:13:41', '2018-05-03 01:13:41'),
(51, 'Modules\\Client\\Entities\\Client', 1, 4, 'other_names', 'Genes\nGene Construction', 'Genes\nGene Construction\nTest', '2018-05-03 01:16:20', '2018-05-03 01:16:20'),
(52, 'Modules\\Client\\Entities\\Client', 1, 4, 'other_names', 'Genes\nGene Construction\nTest', 'Genes\nGene Construction\nTest1', '2018-05-03 01:20:14', '2018-05-03 01:20:14'),
(53, 'Modules\\Client\\Entities\\Client', 1, 4, 'company_name', '1Gene Contracting Demolition Inc.', 'Gene Contracting Demolition Inc.', '2018-05-03 01:30:31', '2018-05-03 01:30:31'),
(54, 'Modules\\Client\\Entities\\Client', 1, 4, 'other_names', 'Genes\nGene Construction\nTest1', 'Genes\nGene Construction\nTest', '2018-05-03 01:30:31', '2018-05-03 01:30:31'),
(55, 'Modules\\Client\\Entities\\Client', 1, 4, 'payroll_rep', '1', '7', '2018-05-03 03:40:35', '2018-05-03 03:40:35'),
(56, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '0', '1', '2018-05-04 00:56:31', '2018-05-04 00:56:31'),
(57, 'Modules\\Client\\Entities\\Client', 1, 4, 'notes', NULL, 'Latest One\nNitin', '2018-05-04 06:47:10', '2018-05-04 06:47:10'),
(58, 'Modules\\Client\\Entities\\Client', 1, 4, 'notes', 'Latest One\nNitin', 'Latest One\nNitin @Night', '2018-05-04 12:34:18', '2018-05-04 12:34:18'),
(59, 'Modules\\Client\\Entities\\Client', 1, 4, 'notes', 'Latest One\nNitin @Night', 'Latest One\nNitin @Night11111', '2018-05-04 12:49:27', '2018-05-04 12:49:27'),
(60, 'Modules\\Client\\Entities\\Client', 1, 4, 'notes', 'Latest One\nNitin @Night11111', 'Latest One\nNitin @Night1', '2018-05-04 22:03:01', '2018-05-04 22:03:01'),
(61, 'Modules\\Client\\Entities\\Client', 1, 4, 'notes', 'Latest One\nNitin @Night1', 'Latest One\nNitin @Night144', '2018-05-04 23:22:50', '2018-05-04 23:22:50'),
(62, 'Modules\\Client\\Entities\\Client', 1, 4, 'notes', 'Latest One\nNitin @Night144', 'Latest One\nNitin @Night1441', '2018-05-04 23:41:12', '2018-05-04 23:41:12'),
(63, 'Modules\\Carrier\\Entities\\Carrier', 71, NULL, 'deleted_at', NULL, '2018-05-09 12:47:11', '2018-05-09 07:17:11', '2018-05-09 07:17:11'),
(64, 'Modules\\Carrier\\Entities\\Carrier', 70, 4, 'state', '2', 'AL', '2018-05-10 02:24:08', '2018-05-10 02:24:08'),
(65, 'Modules\\Carrier\\Entities\\Carrier', 70, 4, 'phone', '1233432443', '1233432443a', '2018-05-10 02:24:08', '2018-05-10 02:24:08'),
(66, 'Modules\\Carrier\\Entities\\Carrier', 70, 4, 'email', 'sscs@dd', 'sscs@dda', '2018-05-10 02:24:08', '2018-05-10 02:24:08'),
(67, 'Modules\\Carrier\\Entities\\Carrier', 70, 4, 'fax', '21324', '21324a', '2018-05-10 02:24:08', '2018-05-10 02:24:08'),
(68, 'Modules\\Carrier\\Entities\\Carrier', 74, 4, 'state', 'CO', 'AL', '2018-05-10 02:34:16', '2018-05-10 02:34:16'),
(69, 'Modules\\Carrier\\Entities\\Carrier', 74, 4, 'carrier_name', 'Id 72', 'Id 74', '2018-05-10 02:41:48', '2018-05-10 02:41:48'),
(70, 'Modules\\Carrier\\Entities\\Carrier', 74, 4, 'state', 'AL', 'GA', '2018-05-10 03:33:12', '2018-05-10 03:33:12'),
(71, 'Modules\\Carrier\\Entities\\Carrier', 74, 4, 'fax', '11111', '222222', '2018-05-10 03:33:12', '2018-05-10 03:33:12'),
(72, 'Modules\\Agency\\Entities\\Agency', 668, 4, 'deleted_at', NULL, '2018-05-10 13:04:07', '2018-05-10 07:34:07', '2018-05-10 07:34:07'),
(73, 'Modules\\Agency\\Entities\\Agency', 669, 4, 'agency_name', 'asd', 'asd1', '2018-05-10 08:03:31', '2018-05-10 08:03:31'),
(74, 'Modules\\Client\\Entities\\Contact', 7, 4, 'name', 'gdgtr', 'test again by nitin for update', '2018-05-11 03:28:59', '2018-05-11 03:28:59'),
(75, 'Modules\\Client\\Entities\\Contact', 7, 4, 'role', 'role3', 'role2', '2018-05-11 03:28:59', '2018-05-11 03:28:59'),
(76, 'Modules\\Client\\Entities\\Contact', 7, 4, 'email', 'gtrsg@dsfdf', 'tes2@dd', '2018-05-11 03:28:59', '2018-05-11 03:28:59'),
(77, 'Modules\\Carrier\\Entities\\Carrier', 74, 4, 'deleted_at', NULL, '2018-05-11 15:55:47', '2018-05-11 10:25:47', '2018-05-11 10:25:47'),
(78, 'Modules\\Carrier\\Entities\\Carrier', 73, NULL, 'carrier_name', 'assdff', 'assd', '2018-05-11 10:30:45', '2018-05-11 10:30:45'),
(79, 'Modules\\Broker\\Entities\\Broker', 2, 4, 'broker_name', 'Broker 2', 'Broker 3', '2018-05-12 07:31:05', '2018-05-12 07:31:05'),
(80, 'Modules\\Broker\\Entities\\Broker', 2, 4, 'email', 'b2@example.com', 'b3@example.com', '2018-05-12 07:31:05', '2018-05-12 07:31:05'),
(81, 'Modules\\Client\\Entities\\Contact', 10, 4, 'name', 'Broker contact 2', 'Broker contact 3', '2018-05-12 07:31:36', '2018-05-12 07:31:36'),
(82, 'Modules\\Client\\Entities\\Contact', 10, 4, 'email', 'bc2@example.com', 'bc3@example.com', '2018-05-12 07:31:36', '2018-05-12 07:31:36'),
(83, 'Modules\\Client\\Entities\\Contact', 10, 4, 'phone', '2222222222', '3333333333', '2018-05-12 07:31:36', '2018-05-12 07:31:36'),
(84, 'Modules\\Broker\\Entities\\Broker', 2, 4, 'deleted_at', NULL, '2018-05-12 13:02:52', '2018-05-12 07:32:52', '2018-05-12 07:32:52'),
(85, 'Modules\\PayrollCompany\\Entities\\PayrollCompany', 91, 4, 'worklist', '38', '39', '2018-05-14 01:30:32', '2018-05-14 01:30:32'),
(86, 'Modules\\PayrollCompany\\Entities\\PayrollCompany', 91, 4, 'payroll_company_name', 'PC Test', 'PC Test again', '2018-05-14 01:30:32', '2018-05-14 01:30:32'),
(87, 'Modules\\PayrollCompany\\Entities\\PayrollCompany', 91, 4, 'address', 'xzcdsd', 'Model Town', '2018-05-14 01:30:32', '2018-05-14 01:30:32'),
(88, 'Modules\\PayrollCompany\\Entities\\PayrollCompany', 91, 4, 'city', 'sgrgd', 'ynr', '2018-05-14 01:30:32', '2018-05-14 01:30:32'),
(89, 'Modules\\PayrollCompany\\Entities\\PayrollCompany', 91, 4, 'state', 'AK', 'AL', '2018-05-14 01:30:32', '2018-05-14 01:30:32'),
(90, 'Modules\\PayrollCompany\\Entities\\PayrollCompany', 91, 4, 'worklist', '39', '1', '2018-05-14 02:34:27', '2018-05-14 02:34:27'),
(91, 'Modules\\Carrier\\Entities\\Carrier', 75, 4, 'carrier_name', 'wqdqd', 'Carrier 75', '2018-05-15 06:22:34', '2018-05-15 06:22:34'),
(92, 'Modules\\Carrier\\Entities\\Carrier', 75, 4, 'email', 'xs@sss', 'xs@sss1', '2018-05-15 06:22:34', '2018-05-15 06:22:34'),
(93, 'Modules\\Client\\Entities\\Contact', 19, 4, 'name', 'fafgrwg', 'cc2', '2018-05-15 06:24:00', '2018-05-15 06:24:00'),
(94, 'Modules\\Client\\Entities\\Contact', 19, 4, 'role', 'role3', 'role2', '2018-05-15 06:24:00', '2018-05-15 06:24:00'),
(95, 'Modules\\Client\\Entities\\Contact', 19, 4, 'email', 'a@a.com', 'a@a.co', '2018-05-15 06:24:00', '2018-05-15 06:24:00'),
(96, 'Modules\\Client\\Entities\\Contact', 18, 4, 'name', 'ad', 'cc1', '2018-05-15 06:24:25', '2018-05-15 06:24:25'),
(97, 'Modules\\Client\\Entities\\Contact', 18, 4, 'email', 'a@a', 'a@a.com', '2018-05-15 06:24:25', '2018-05-15 06:24:25'),
(98, 'Modules\\Agency\\Entities\\Agency', 670, 4, 'agency_name', 'Agency Latest', 'Agency Latest 670', '2018-05-15 06:46:57', '2018-05-15 06:46:57'),
(99, 'Modules\\Agency\\Entities\\Agency', 670, 4, 'state', 'AK', 'AZ', '2018-05-15 06:46:57', '2018-05-15 06:46:57'),
(100, 'Modules\\Agency\\Entities\\Agency', 669, 4, 'deleted_at', NULL, '2018-05-15 12:17:35', '2018-05-15 06:47:36', '2018-05-15 06:47:36'),
(101, 'Modules\\PayrollCompany\\Entities\\PayrollCompany', 92, 4, 'payroll_company_name', 'pc latest', 'pc 92', '2018-05-15 07:05:28', '2018-05-15 07:05:28'),
(102, 'Modules\\PayrollCompany\\Entities\\PayrollCompany', 92, 4, 'email', 'pc1@exa', 'pc1@example', '2018-05-15 07:05:28', '2018-05-15 07:05:28'),
(103, 'Modules\\PayrollCompany\\Entities\\PayrollCompany', 92, 4, 'deleted_at', NULL, '2018-05-15 12:36:58', '2018-05-15 07:06:58', '2018-05-15 07:06:58'),
(104, 'Modules\\Client\\Entities\\Worklist', 38, 4, 'deleted_at', NULL, '2018-05-16 05:07:24', '2018-05-15 23:37:24', '2018-05-15 23:37:24'),
(105, 'Modules\\Client\\Entities\\Worklist', 39, 4, 'description', 'Lorem Ipsum text', 'Lorem Ipsum text 2', '2018-05-16 00:01:13', '2018-05-16 00:01:13'),
(106, 'Modules\\Carrier\\Entities\\Carrier', 75, 4, 'phone', '212123213', '434-433-4545', '2018-05-18 03:17:32', '2018-05-18 03:17:32'),
(107, 'Modules\\Agency\\Entities\\Agency', 670, 4, 'phone', '765768687', '325-456-5476', '2018-05-18 03:40:22', '2018-05-18 03:40:22'),
(108, 'Modules\\Client\\Entities\\Contact', 23, 4, 'phone', '3243243243', '324-324-3241', '2018-05-18 03:41:06', '2018-05-18 03:41:06'),
(109, 'Modules\\Client\\Entities\\Policy', 3438, 4, 'reinstatement_date', NULL, '2018-05-24', '2018-05-22 05:53:32', '2018-05-22 05:53:32'),
(110, 'Modules\\Client\\Entities\\Policy', 3434, 4, 'reinstatement_date', NULL, '2018-05-24', '2018-05-22 06:51:07', '2018-05-22 06:51:07'),
(111, 'Modules\\Client\\Entities\\Policy', 3434, 4, 'status', 'inactive', 'active', '2018-05-22 06:51:07', '2018-05-22 06:51:07'),
(112, 'Modules\\Client\\Entities\\Policy', 3438, 4, 'status', 'inactive', 'active', '2018-05-22 07:15:43', '2018-05-22 07:15:43'),
(113, 'Modules\\Client\\Entities\\Policy', 3434, 4, 'status', 'inactive', 'active', '2018-05-22 07:16:33', '2018-05-22 07:16:33'),
(114, 'Modules\\Client\\Entities\\Policy', 3434, 4, 'notes', NULL, 'AAdasdsa', '2018-05-22 07:17:02', '2018-05-22 07:17:02'),
(115, 'Modules\\Client\\Entities\\Policy', 3438, 4, 'status', 'inactive', 'active', '2018-05-22 07:17:55', '2018-05-22 07:17:55'),
(116, 'Modules\\Client\\Entities\\Policy', 3438, 4, 'status', 'inactive', 'active', '2018-05-22 07:28:14', '2018-05-22 07:28:14'),
(117, 'Modules\\Client\\Entities\\Policy', 3434, 4, 'status', 'inactive', 'active', '2018-05-22 07:33:26', '2018-05-22 07:33:26'),
(118, 'Modules\\Client\\Entities\\Policy', 3438, 4, 'status', 'inactive', 'active', '2018-05-22 07:34:33', '2018-05-22 07:34:33'),
(119, 'Modules\\Page\\Entities\\Page', 6, 4, 'redirect_url', 'https://stackoverflow.com', NULL, '2018-08-05 10:52:08', '2018-08-05 10:52:08'),
(120, 'Modules\\Page\\Entities\\Page', 6, 4, 'description', NULL, '<p>12down voteacceptedI think you can change your query and try it like :</p><pre class=\"ql-syntax\" spellcheck=\"false\">$res=User::where(\'id\',$id)-&gt;delete();\n</pre><p>Hope this work for you !!!</p>', '2018-08-05 10:52:08', '2018-08-05 10:52:08'),
(121, 'Modules\\Page\\Entities\\Page', 5, 4, 'deleted_at', NULL, '2018-08-06 07:42:47', '2018-08-06 02:12:48', '2018-08-06 02:12:48'),
(122, 'Modules\\Page\\Entities\\Page', 3, 4, 'deleted_at', NULL, '2018-08-06 07:43:05', '2018-08-06 02:13:05', '2018-08-06 02:13:05'),
(1, 'Modules\\Client\\Entities\\Contact', 1, 4, 'name', 'Nitin', 'Nitin111', '2018-04-30 06:57:58', '2018-04-30 06:57:58'),
(2, 'Modules\\Client\\Entities\\Contact', 1, 4, 'role', 'role1', 'role3', '2018-04-30 06:57:58', '2018-04-30 06:57:58'),
(3, 'Modules\\Client\\Entities\\Contact', 1, 4, 'email', 'aa@hh.com', 'aa@hh.com1', '2018-04-30 06:57:58', '2018-04-30 06:57:58'),
(4, 'Modules\\Client\\Entities\\Contact', 1, 4, 'phone', '6565675656', '6565675611', '2018-04-30 06:57:58', '2018-04-30 06:57:58'),
(5, 'Modules\\Client\\Entities\\Contact', 1, 4, 'name', 'Nitin111', 'Nitin141', '2018-04-30 06:59:22', '2018-04-30 06:59:22'),
(6, 'Modules\\Client\\Entities\\Contact', 1, 4, 'name', 'Nitin141', 'Nitin11', '2018-04-30 07:05:20', '2018-04-30 07:05:20'),
(7, 'Modules\\Client\\Entities\\Contact', 1, 4, 'role', 'role3', 'role2', '2018-04-30 07:05:20', '2018-04-30 07:05:20'),
(8, 'Modules\\Client\\Entities\\Contact', 1, 4, 'role', 'role2', 'role3', '2018-04-30 07:05:41', '2018-04-30 07:05:41'),
(9, 'Modules\\Client\\Entities\\Contact', 4, 4, 'name', 'nnn', 'Test latest', '2018-04-30 07:08:21', '2018-04-30 07:08:21'),
(10, 'Modules\\Client\\Entities\\Contact', 4, 4, 'email', 'n@n', 'latest@test.com', '2018-04-30 07:08:21', '2018-04-30 07:08:21'),
(11, 'Modules\\Client\\Entities\\Contact', 4, 4, 'phone', '5454455456', '1234567890', '2018-04-30 07:08:21', '2018-04-30 07:08:21'),
(12, 'Modules\\Client\\Entities\\Contact', 1, 4, 'name', 'Nitin11', 'Nitin111', '2018-05-01 01:33:48', '2018-05-01 01:33:48'),
(13, 'Modules\\Client\\Entities\\Contact', 1, 4, 'role', 'role3', 'role1', '2018-05-01 01:33:48', '2018-05-01 01:33:48'),
(14, 'Modules\\Client\\Entities\\Contact', 1, 4, 'phone', '6565675611', '1165675611', '2018-05-01 01:33:48', '2018-05-01 01:33:48'),
(15, 'Modules\\Client\\Entities\\Contact', 1, 4, 'name', 'Nitin111', 'Nitin', '2018-05-01 01:46:53', '2018-05-01 01:46:53'),
(16, 'Modules\\Client\\Entities\\Contact', 1, 4, 'role', 'role1', 'role2', '2018-05-01 01:46:53', '2018-05-01 01:46:53'),
(17, 'Modules\\Client\\Entities\\Client', 1, NULL, 'is_active', '0', '1', '2018-05-01 07:24:54', '2018-05-01 07:24:54'),
(18, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '1', '0', '2018-05-01 08:49:27', '2018-05-01 08:49:27'),
(19, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '0', '1', '2018-05-01 23:27:13', '2018-05-01 23:27:13'),
(20, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '1', '0', '2018-05-01 23:37:05', '2018-05-01 23:37:05'),
(21, 'Modules\\Client\\Entities\\Contact', 1, 4, 'name', 'Nitin', 'Nitin1', '2018-05-01 23:37:19', '2018-05-01 23:37:19'),
(22, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '0', '1', '2018-05-02 01:06:34', '2018-05-02 01:06:34'),
(23, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '1', '0', '2018-05-02 01:55:58', '2018-05-02 01:55:58'),
(24, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '0', '1', '2018-05-02 02:11:53', '2018-05-02 02:11:53'),
(25, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '1', '0', '2018-05-02 02:22:25', '2018-05-02 02:22:25'),
(26, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '0', '1', '2018-05-02 02:23:31', '2018-05-02 02:23:31'),
(27, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '1', '0', '2018-05-02 02:26:41', '2018-05-02 02:26:41'),
(28, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '0', '1', '2018-05-02 02:28:00', '2018-05-02 02:28:00'),
(29, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '1', '0', '2018-05-02 02:29:16', '2018-05-02 02:29:16'),
(30, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '0', '1', '2018-05-02 02:29:20', '2018-05-02 02:29:20'),
(31, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '1', '0', '2018-05-02 02:30:24', '2018-05-02 02:30:24'),
(32, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '0', '1', '2018-05-02 02:31:23', '2018-05-02 02:31:23'),
(33, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '1', '0', '2018-05-02 02:31:27', '2018-05-02 02:31:27'),
(34, 'Modules\\Client\\Entities\\Contact', 1, 4, 'name', 'Nitin1', 'test on 2 may by nitin', '2018-05-02 09:05:47', '2018-05-02 09:05:47'),
(35, 'Modules\\Client\\Entities\\Contact', 1, 4, 'role', 'role2', 'role1', '2018-05-02 09:05:47', '2018-05-02 09:05:47'),
(36, 'Modules\\Client\\Entities\\Contact', 1, 4, 'email', 'aa@hh.com1', 'n1@n.com', '2018-05-02 09:05:47', '2018-05-02 09:05:47'),
(37, 'Modules\\Client\\Entities\\Contact', 1, 4, 'phone', '1165675611', '5554335345', '2018-05-02 09:05:47', '2018-05-02 09:05:47'),
(38, 'Modules\\Client\\Entities\\Contact', 8, 4, 'name', 'test on 2 may', 'test on 2 may current', '2018-05-02 09:10:53', '2018-05-02 09:10:53'),
(39, 'Modules\\Client\\Entities\\Contact', 8, 4, 'email', 'n@n.com', 'n7@n.com', '2018-05-02 09:10:53', '2018-05-02 09:10:53'),
(40, 'Modules\\Client\\Entities\\Contact', 8, 4, 'phone', '4324335345', '7774335345', '2018-05-02 09:10:53', '2018-05-02 09:10:53'),
(41, 'Modules\\Client\\Entities\\Contact', 1, 4, 'name', 'test on 2 may by nitin', 'test on 2', '2018-05-02 09:15:17', '2018-05-02 09:15:17'),
(42, 'Modules\\Client\\Entities\\Client', 1, 4, 'city', 'Davie', 'Davies', '2018-05-03 00:11:41', '2018-05-03 00:11:41'),
(43, 'Modules\\Client\\Entities\\Client', 1, 4, 'state', 'FL', 'MA', '2018-05-03 00:11:41', '2018-05-03 00:11:41'),
(44, 'Modules\\Client\\Entities\\Client', 1, 4, 'fein', '650582687', '650582685', '2018-05-03 00:11:41', '2018-05-03 00:11:41'),
(45, 'Modules\\Client\\Entities\\Client', 1, 4, 'company_name', 'Gene Contracting Demolition Inc.', '1Gene Contracting Demolition Inc.', '2018-05-03 01:07:33', '2018-05-03 01:07:33'),
(46, 'Modules\\Client\\Entities\\Client', 1, 4, 'address', '4980 Southwest 52nd Street #110', '4980 Southwest 52nd Street #111', '2018-05-03 01:13:41', '2018-05-03 01:13:41'),
(47, 'Modules\\Client\\Entities\\Client', 1, 4, 'city', 'Davies', 'Davie', '2018-05-03 01:13:41', '2018-05-03 01:13:41'),
(48, 'Modules\\Client\\Entities\\Client', 1, 4, 'state', 'MA', 'FL', '2018-05-03 01:13:41', '2018-05-03 01:13:41'),
(49, 'Modules\\Client\\Entities\\Client', 1, 4, 'zip', '33314', '333140', '2018-05-03 01:13:41', '2018-05-03 01:13:41'),
(50, 'Modules\\Client\\Entities\\Client', 1, 4, 'fein', '650582685', '6505826850', '2018-05-03 01:13:41', '2018-05-03 01:13:41'),
(51, 'Modules\\Client\\Entities\\Client', 1, 4, 'other_names', 'Genes\nGene Construction', 'Genes\nGene Construction\nTest', '2018-05-03 01:16:20', '2018-05-03 01:16:20'),
(52, 'Modules\\Client\\Entities\\Client', 1, 4, 'other_names', 'Genes\nGene Construction\nTest', 'Genes\nGene Construction\nTest1', '2018-05-03 01:20:14', '2018-05-03 01:20:14'),
(53, 'Modules\\Client\\Entities\\Client', 1, 4, 'company_name', '1Gene Contracting Demolition Inc.', 'Gene Contracting Demolition Inc.', '2018-05-03 01:30:31', '2018-05-03 01:30:31'),
(54, 'Modules\\Client\\Entities\\Client', 1, 4, 'other_names', 'Genes\nGene Construction\nTest1', 'Genes\nGene Construction\nTest', '2018-05-03 01:30:31', '2018-05-03 01:30:31'),
(55, 'Modules\\Client\\Entities\\Client', 1, 4, 'payroll_rep', '1', '7', '2018-05-03 03:40:35', '2018-05-03 03:40:35'),
(56, 'Modules\\Client\\Entities\\Client', 1, 4, 'is_active', '0', '1', '2018-05-04 00:56:31', '2018-05-04 00:56:31'),
(57, 'Modules\\Client\\Entities\\Client', 1, 4, 'notes', NULL, 'Latest One\nNitin', '2018-05-04 06:47:10', '2018-05-04 06:47:10'),
(58, 'Modules\\Client\\Entities\\Client', 1, 4, 'notes', 'Latest One\nNitin', 'Latest One\nNitin @Night', '2018-05-04 12:34:18', '2018-05-04 12:34:18'),
(59, 'Modules\\Client\\Entities\\Client', 1, 4, 'notes', 'Latest One\nNitin @Night', 'Latest One\nNitin @Night11111', '2018-05-04 12:49:27', '2018-05-04 12:49:27'),
(60, 'Modules\\Client\\Entities\\Client', 1, 4, 'notes', 'Latest One\nNitin @Night11111', 'Latest One\nNitin @Night1', '2018-05-04 22:03:01', '2018-05-04 22:03:01'),
(61, 'Modules\\Client\\Entities\\Client', 1, 4, 'notes', 'Latest One\nNitin @Night1', 'Latest One\nNitin @Night144', '2018-05-04 23:22:50', '2018-05-04 23:22:50'),
(62, 'Modules\\Client\\Entities\\Client', 1, 4, 'notes', 'Latest One\nNitin @Night144', 'Latest One\nNitin @Night1441', '2018-05-04 23:41:12', '2018-05-04 23:41:12'),
(63, 'Modules\\Carrier\\Entities\\Carrier', 71, NULL, 'deleted_at', NULL, '2018-05-09 12:47:11', '2018-05-09 07:17:11', '2018-05-09 07:17:11'),
(64, 'Modules\\Carrier\\Entities\\Carrier', 70, 4, 'state', '2', 'AL', '2018-05-10 02:24:08', '2018-05-10 02:24:08'),
(65, 'Modules\\Carrier\\Entities\\Carrier', 70, 4, 'phone', '1233432443', '1233432443a', '2018-05-10 02:24:08', '2018-05-10 02:24:08'),
(66, 'Modules\\Carrier\\Entities\\Carrier', 70, 4, 'email', 'sscs@dd', 'sscs@dda', '2018-05-10 02:24:08', '2018-05-10 02:24:08'),
(67, 'Modules\\Carrier\\Entities\\Carrier', 70, 4, 'fax', '21324', '21324a', '2018-05-10 02:24:08', '2018-05-10 02:24:08'),
(68, 'Modules\\Carrier\\Entities\\Carrier', 74, 4, 'state', 'CO', 'AL', '2018-05-10 02:34:16', '2018-05-10 02:34:16'),
(69, 'Modules\\Carrier\\Entities\\Carrier', 74, 4, 'carrier_name', 'Id 72', 'Id 74', '2018-05-10 02:41:48', '2018-05-10 02:41:48'),
(70, 'Modules\\Carrier\\Entities\\Carrier', 74, 4, 'state', 'AL', 'GA', '2018-05-10 03:33:12', '2018-05-10 03:33:12'),
(71, 'Modules\\Carrier\\Entities\\Carrier', 74, 4, 'fax', '11111', '222222', '2018-05-10 03:33:12', '2018-05-10 03:33:12'),
(72, 'Modules\\Agency\\Entities\\Agency', 668, 4, 'deleted_at', NULL, '2018-05-10 13:04:07', '2018-05-10 07:34:07', '2018-05-10 07:34:07'),
(73, 'Modules\\Agency\\Entities\\Agency', 669, 4, 'agency_name', 'asd', 'asd1', '2018-05-10 08:03:31', '2018-05-10 08:03:31'),
(74, 'Modules\\Client\\Entities\\Contact', 7, 4, 'name', 'gdgtr', 'test again by nitin for update', '2018-05-11 03:28:59', '2018-05-11 03:28:59'),
(75, 'Modules\\Client\\Entities\\Contact', 7, 4, 'role', 'role3', 'role2', '2018-05-11 03:28:59', '2018-05-11 03:28:59'),
(76, 'Modules\\Client\\Entities\\Contact', 7, 4, 'email', 'gtrsg@dsfdf', 'tes2@dd', '2018-05-11 03:28:59', '2018-05-11 03:28:59'),
(77, 'Modules\\Carrier\\Entities\\Carrier', 74, 4, 'deleted_at', NULL, '2018-05-11 15:55:47', '2018-05-11 10:25:47', '2018-05-11 10:25:47'),
(78, 'Modules\\Carrier\\Entities\\Carrier', 73, NULL, 'carrier_name', 'assdff', 'assd', '2018-05-11 10:30:45', '2018-05-11 10:30:45'),
(79, 'Modules\\Broker\\Entities\\Broker', 2, 4, 'broker_name', 'Broker 2', 'Broker 3', '2018-05-12 07:31:05', '2018-05-12 07:31:05'),
(80, 'Modules\\Broker\\Entities\\Broker', 2, 4, 'email', 'b2@example.com', 'b3@example.com', '2018-05-12 07:31:05', '2018-05-12 07:31:05'),
(81, 'Modules\\Client\\Entities\\Contact', 10, 4, 'name', 'Broker contact 2', 'Broker contact 3', '2018-05-12 07:31:36', '2018-05-12 07:31:36'),
(82, 'Modules\\Client\\Entities\\Contact', 10, 4, 'email', 'bc2@example.com', 'bc3@example.com', '2018-05-12 07:31:36', '2018-05-12 07:31:36'),
(83, 'Modules\\Client\\Entities\\Contact', 10, 4, 'phone', '2222222222', '3333333333', '2018-05-12 07:31:36', '2018-05-12 07:31:36'),
(84, 'Modules\\Broker\\Entities\\Broker', 2, 4, 'deleted_at', NULL, '2018-05-12 13:02:52', '2018-05-12 07:32:52', '2018-05-12 07:32:52'),
(85, 'Modules\\PayrollCompany\\Entities\\PayrollCompany', 91, 4, 'worklist', '38', '39', '2018-05-14 01:30:32', '2018-05-14 01:30:32'),
(86, 'Modules\\PayrollCompany\\Entities\\PayrollCompany', 91, 4, 'payroll_company_name', 'PC Test', 'PC Test again', '2018-05-14 01:30:32', '2018-05-14 01:30:32'),
(87, 'Modules\\PayrollCompany\\Entities\\PayrollCompany', 91, 4, 'address', 'xzcdsd', 'Model Town', '2018-05-14 01:30:32', '2018-05-14 01:30:32'),
(88, 'Modules\\PayrollCompany\\Entities\\PayrollCompany', 91, 4, 'city', 'sgrgd', 'ynr', '2018-05-14 01:30:32', '2018-05-14 01:30:32'),
(89, 'Modules\\PayrollCompany\\Entities\\PayrollCompany', 91, 4, 'state', 'AK', 'AL', '2018-05-14 01:30:32', '2018-05-14 01:30:32'),
(90, 'Modules\\PayrollCompany\\Entities\\PayrollCompany', 91, 4, 'worklist', '39', '1', '2018-05-14 02:34:27', '2018-05-14 02:34:27'),
(91, 'Modules\\Carrier\\Entities\\Carrier', 75, 4, 'carrier_name', 'wqdqd', 'Carrier 75', '2018-05-15 06:22:34', '2018-05-15 06:22:34'),
(92, 'Modules\\Carrier\\Entities\\Carrier', 75, 4, 'email', 'xs@sss', 'xs@sss1', '2018-05-15 06:22:34', '2018-05-15 06:22:34'),
(93, 'Modules\\Client\\Entities\\Contact', 19, 4, 'name', 'fafgrwg', 'cc2', '2018-05-15 06:24:00', '2018-05-15 06:24:00'),
(94, 'Modules\\Client\\Entities\\Contact', 19, 4, 'role', 'role3', 'role2', '2018-05-15 06:24:00', '2018-05-15 06:24:00'),
(95, 'Modules\\Client\\Entities\\Contact', 19, 4, 'email', 'a@a.com', 'a@a.co', '2018-05-15 06:24:00', '2018-05-15 06:24:00'),
(96, 'Modules\\Client\\Entities\\Contact', 18, 4, 'name', 'ad', 'cc1', '2018-05-15 06:24:25', '2018-05-15 06:24:25'),
(97, 'Modules\\Client\\Entities\\Contact', 18, 4, 'email', 'a@a', 'a@a.com', '2018-05-15 06:24:25', '2018-05-15 06:24:25'),
(98, 'Modules\\Agency\\Entities\\Agency', 670, 4, 'agency_name', 'Agency Latest', 'Agency Latest 670', '2018-05-15 06:46:57', '2018-05-15 06:46:57'),
(99, 'Modules\\Agency\\Entities\\Agency', 670, 4, 'state', 'AK', 'AZ', '2018-05-15 06:46:57', '2018-05-15 06:46:57'),
(100, 'Modules\\Agency\\Entities\\Agency', 669, 4, 'deleted_at', NULL, '2018-05-15 12:17:35', '2018-05-15 06:47:36', '2018-05-15 06:47:36'),
(101, 'Modules\\PayrollCompany\\Entities\\PayrollCompany', 92, 4, 'payroll_company_name', 'pc latest', 'pc 92', '2018-05-15 07:05:28', '2018-05-15 07:05:28'),
(102, 'Modules\\PayrollCompany\\Entities\\PayrollCompany', 92, 4, 'email', 'pc1@exa', 'pc1@example', '2018-05-15 07:05:28', '2018-05-15 07:05:28'),
(103, 'Modules\\PayrollCompany\\Entities\\PayrollCompany', 92, 4, 'deleted_at', NULL, '2018-05-15 12:36:58', '2018-05-15 07:06:58', '2018-05-15 07:06:58'),
(104, 'Modules\\Client\\Entities\\Worklist', 38, 4, 'deleted_at', NULL, '2018-05-16 05:07:24', '2018-05-15 23:37:24', '2018-05-15 23:37:24'),
(105, 'Modules\\Client\\Entities\\Worklist', 39, 4, 'description', 'Lorem Ipsum text', 'Lorem Ipsum text 2', '2018-05-16 00:01:13', '2018-05-16 00:01:13'),
(106, 'Modules\\Carrier\\Entities\\Carrier', 75, 4, 'phone', '212123213', '434-433-4545', '2018-05-18 03:17:32', '2018-05-18 03:17:32'),
(107, 'Modules\\Agency\\Entities\\Agency', 670, 4, 'phone', '765768687', '325-456-5476', '2018-05-18 03:40:22', '2018-05-18 03:40:22'),
(108, 'Modules\\Client\\Entities\\Contact', 23, 4, 'phone', '3243243243', '324-324-3241', '2018-05-18 03:41:06', '2018-05-18 03:41:06'),
(109, 'Modules\\Client\\Entities\\Policy', 3438, 4, 'reinstatement_date', NULL, '2018-05-24', '2018-05-22 05:53:32', '2018-05-22 05:53:32'),
(110, 'Modules\\Client\\Entities\\Policy', 3434, 4, 'reinstatement_date', NULL, '2018-05-24', '2018-05-22 06:51:07', '2018-05-22 06:51:07'),
(111, 'Modules\\Client\\Entities\\Policy', 3434, 4, 'status', 'inactive', 'active', '2018-05-22 06:51:07', '2018-05-22 06:51:07'),
(112, 'Modules\\Client\\Entities\\Policy', 3438, 4, 'status', 'inactive', 'active', '2018-05-22 07:15:43', '2018-05-22 07:15:43'),
(113, 'Modules\\Client\\Entities\\Policy', 3434, 4, 'status', 'inactive', 'active', '2018-05-22 07:16:33', '2018-05-22 07:16:33'),
(114, 'Modules\\Client\\Entities\\Policy', 3434, 4, 'notes', NULL, 'AAdasdsa', '2018-05-22 07:17:02', '2018-05-22 07:17:02'),
(115, 'Modules\\Client\\Entities\\Policy', 3438, 4, 'status', 'inactive', 'active', '2018-05-22 07:17:55', '2018-05-22 07:17:55'),
(116, 'Modules\\Client\\Entities\\Policy', 3438, 4, 'status', 'inactive', 'active', '2018-05-22 07:28:14', '2018-05-22 07:28:14'),
(117, 'Modules\\Client\\Entities\\Policy', 3434, 4, 'status', 'inactive', 'active', '2018-05-22 07:33:26', '2018-05-22 07:33:26'),
(118, 'Modules\\Client\\Entities\\Policy', 3438, 4, 'status', 'inactive', 'active', '2018-05-22 07:34:33', '2018-05-22 07:34:33'),
(119, 'Modules\\Page\\Entities\\Page', 6, 4, 'redirect_url', 'https://stackoverflow.com', NULL, '2018-08-05 10:52:08', '2018-08-05 10:52:08'),
(120, 'Modules\\Page\\Entities\\Page', 6, 4, 'description', NULL, '<p>12down voteacceptedI think you can change your query and try it like :</p><pre class=\"ql-syntax\" spellcheck=\"false\">$res=User::where(\'id\',$id)-&gt;delete();\n</pre><p>Hope this work for you !!!</p>', '2018-08-05 10:52:08', '2018-08-05 10:52:08'),
(121, 'Modules\\Page\\Entities\\Page', 5, 4, 'deleted_at', NULL, '2018-08-06 07:42:47', '2018-08-06 02:12:48', '2018-08-06 02:12:48'),
(122, 'Modules\\Page\\Entities\\Page', 3, 4, 'deleted_at', NULL, '2018-08-06 07:43:05', '2018-08-06 02:13:05', '2018-08-06 02:13:05'),
(NULL, 'Modules\\Page\\Entities\\Page', 2, NULL, 'description', '<p>Test</p><p><br></p><p><img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAS4AAAA/CAYAAABevSXJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAZdEVYdFNvZnR3YXJlAEFkb2JlIEltYWdlUmVhZHlxyWU8AAADImlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS4zLWMwMTEgNjYuMTQ1NjYxLCAyMDEyLzAyLzA2LTE0OjU2OjI3ICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M2IChXaW5kb3dzKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo0NTQxNUMxODMxQzIxMUU1QTI0NEJGNEIwRkMxNjQ0RiIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDo0NTQxNUMxOTMxQzIxMUU1QTI0NEJGNEIwRkMxNjQ0RiI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjQ1NDE1QzE2MzFDMjExRTVBMjQ0QkY0QjBGQzE2NDRGIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjQ1NDE1QzE3MzFDMjExRTVBMjQ0QkY0QjBGQzE2NDRGIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwv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\"></p>', NULL, '2018-08-10 13:39:42', '2018-08-10 13:39:42'),
(NULL, 'Modules\\Page\\Entities\\Page', 2, NULL, 'cover_image', '', '1533883175.jpg', '2018-08-10 13:39:42', '2018-08-10 13:39:42'),
(NULL, 'Modules\\Page\\Entities\\Page', 3, NULL, 'redirect_url', NULL, 'http://trigvent.com', '2018-08-10 13:40:21', '2018-08-10 13:40:21'),
(NULL, 'Modules\\Page\\Entities\\Page', 4, NULL, 'cover_image', '', '1534844711.jpg', '2018-08-21 16:45:18', '2018-08-21 16:45:18'),
(NULL, 'Modules\\Page\\Entities\\Page', 7, NULL, 'description', '<p>Since 2000, Net Solutions has been developing web applications for companies across the globe. Originally built as a web portal by hobbyist Sameer Jain, it has risen to become an internationally known brand in its field, with a team of more than 225+ working from its offices, in Chandigarh, New York, Toronto, and London.</p><p><br></p><h2>Our Partners</h2><ul><li>Net Solutions develops applications and solutions that put the customer first. When people come to us for help, we see them as business partners first and clients second, taking on projects that we believe in and making them our own.</li><li>With creativity, respect, transparency, quality and teamwork at the center of all we do, we have forged powerful partnerships with industry leaders such as Microsoft, Amazon Web Services, Kentico, Apple and Google Play.</li></ul><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><strong>These ties mean we have access to the most cutting edge tools and exclusive software development resources available.</strong></p>', '<p>Download Induction Documents below</p>', '2018-08-21 16:50:24', '2018-08-21 16:50:24'),
(NULL, 'Modules\\Page\\Entities\\Page', 1, NULL, 'description', NULL, '<p class=\"ql-align-center\"><strong>All the centralized standard documents of the Estel Company.</strong></p>', '2018-08-21 16:52:27', '2018-08-21 16:52:27'),
(NULL, 'Modules\\Page\\Entities\\Page', 9, NULL, 'description', NULL, '<p>#1 Announcement 1</p><p><br></p><p>#2 Announcement 2</p><p><br></p><p>#3 Announcement 3</p>', '2018-10-01 19:10:14', '2018-10-01 19:10:14'),
(NULL, 'Modules\\Page\\Entities\\Page', 9, NULL, 'description', '<p>#1 Announcement 1</p><p><br></p><p>#2 Announcement 2</p><p><br></p><p>#3 Announcement 3</p>', '<p>diwali party gear up</p><p><br></p><p><br></p>', '2018-11-01 16:26:16', '2018-11-01 16:26:16');

-- --------------------------------------------------------

--
-- Table structure for table `rpm_log`
--

DROP TABLE IF EXISTS `rpm_log`;
CREATE TABLE IF NOT EXISTS `rpm_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `ip` varchar(45) NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT 0,
  `log_type` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `message` text NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rpm_session`
--

DROP TABLE IF EXISTS `rpm_session`;
CREATE TABLE IF NOT EXISTS `rpm_session` (
  `session_id` char(32) NOT NULL,
  `save_path` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL DEFAULT '',
  `modified` int(11) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `session_data` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_profiles`
--

DROP TABLE IF EXISTS `user_profiles`;
CREATE TABLE IF NOT EXISTS `user_profiles` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `alt_phone` varchar(15) NOT NULL,
  `correspondence_address` varchar(255) NOT NULL,
  `permanent_address` varchar(255) NOT NULL,
  `father_name` varchar(255) NOT NULL,
  `mother_name` varchar(255) NOT NULL,
  `encrypted_password` varchar(100) DEFAULT NULL,
  `salt` varchar(100) NOT NULL DEFAULT '',
  `role` varchar(50) NOT NULL DEFAULT 'user',
  `department` int(11) NOT NULL DEFAULT 1 COMMENT '1=HR, 2=Marketing,3=Finance',
  `designation` varchar(255) NOT NULL DEFAULT 'other',
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `name` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `remember_token` varchar(100) DEFAULT NULL,
  `api_token` varchar(60) DEFAULT NULL,
  `api_token_expires` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_profiles`
--

INSERT INTO `user_profiles` (`id`, `first_name`, `last_name`, `email`, `phone`, `alt_phone`, `correspondence_address`, `permanent_address`, `father_name`, `mother_name`, `encrypted_password`, `salt`, `role`, `department`, `designation`, `created_at`, `updated_at`, `name`, `password`, `remember_token`, `api_token`, `api_token_expires`) VALUES
(1, 'Testing', 'Admin', 'admin@shredex.net', '+32-4355656756', '+43-2543654765', 'sscsde', 'xdfdvdgs', 'aasdasdsadsf', 'ADSADFS', '$2y$10$lcHTaiw8SPNzbq49qY4UL.ikB96FJuTc3EFBKu3kgNiloU3yzLuoK', 'bce158956dbdb7b82ec14690aadd450d171b6c1094e29c84bdeff79252c9ade3', 'user', 1, 'Software Engineer', '2014-03-03 10:18:33', '2018-12-13 08:59:15', 'Testing Admin', '$2y$10$OKmM0Oqe82l8O7H0mTtsvOoSo7c6E.WBi0G1S73S9unUTXWXXnj7e', NULL, 'dWaNWljbdC3a54glAR6HI7nEBJFebTti5FILQnfL694tJGKNZU8HjFLDBMo9', '2018-12-13 06:29:15'),
(2, 'Testing', 'Admin', 'admin@shredex.net', '+32-4355656756', '+43-2543654765', 'sscsde', 'xdfdvdgs', 'aasdasdsadsf', 'ADSADFS', '$2y$10$lcHTaiw8SPNzbq49qY4UL.ikB96FJuTc3EFBKu3kgNiloU3yzLuoK', 'bce158956dbdb7b82ec14690aadd450d171b6c1094e29c84bdeff79252c9ade3', 'user', 1, 'Software Engineer', '2014-03-03 10:18:33', '2018-12-07 01:00:46', 'Testing Admin', '$2y$10$OKmM0Oqe82l8O7H0mTtsvOoSo7c6E.WBi0G1S73S9unUTXWXXnj7e', NULL, 'ghhjqaF4S9WGMhQIGUaVgTelsLoTRGWiuz7b7QdewhdnhQDJiCZH3IHx2QpM', '2018-12-07 04:00:46'),
(23, 'Nitin', 'Saluja1', 'nitinsaluja@example.com', '+99-9999999999', '+99-9999999999', 'Chd, India', 'Same', 'Test1', 'Test2', NULL, '', 'user', 1, 'other', '2018-12-05 05:25:20', '2018-12-04 23:58:47', 'Nitin Saluja1', '$2y$10$kmJamWM54XlD6QH/b/ehSu0.R.tovBzJk2FyXy0qRzRlcXx7HMJv6', NULL, '', NULL),
(24, 'Kirpal', 'Singh', 'kirpal@example.com', '+24-3564465676', '+53-4645656768', 'Chd, India', 'Same', 'Test', 'Test1', NULL, '', 'user', 1, 'other', '2018-12-05 07:40:19', '2018-12-05 02:10:34', '', '$2y$10$i4V4kgLoSIRo.y.LIXx1aegq4vlRvmzOJjHjE0VXw75basUa8x1VC', NULL, 'pN0SnYPzDvXaXR5rkSnAkk88hlbrPehPbiS1ClE14xwvwwQL22BhJ0v69Al8', '2018-12-05 11:40:34'),
(25, 'asdasd', 'asdasd', 'asdsd@asd.sds', '+22-2222222222', '+22-2222222222', 'asdasdsdfsd', 'asdasdasd', 'asdasd', 'asdasd', NULL, '', 'subscriber', 1, 'other', '2018-12-09 08:54:55', '2018-12-09 04:02:08', 'asdasd asdasd', '$2y$10$glXGJbF9B2GFesaebDERd.476ONrIT0qBAGeaOhk3wtyLHrrpIiza', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vendor_profiles`
--

DROP TABLE IF EXISTS `vendor_profiles`;
CREATE TABLE IF NOT EXISTS `vendor_profiles` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `shop_name` varchar(255) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `gender` varchar(15) NOT NULL DEFAULT 'male',
  `fax` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  `encrypted_password` varchar(100) DEFAULT NULL,
  `salt` varchar(100) NOT NULL DEFAULT '',
  `role` varchar(50) NOT NULL DEFAULT 'vendor',
  `status` int(11) NOT NULL DEFAULT 0,
  `current_balance` float NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `name` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `remember_token` varchar(100) DEFAULT NULL,
  `api_token` varchar(60) DEFAULT NULL,
  `api_token_expires` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `vendor_profiles`
--

INSERT INTO `vendor_profiles` (`id`, `shop_name`, `photo`, `email`, `phone`, `gender`, `fax`, `address`, `city`, `zip`, `encrypted_password`, `salt`, `role`, `status`, `current_balance`, `created_at`, `updated_at`, `name`, `password`, `remember_token`, `api_token`, `api_token_expires`) VALUES
(1, 'Testing', 'Admin', 'admin@shredex.net', '+32-4355656756', '+43-2543654765', 'sscsde', 'xdfdvdgs', 'aasdasdsadsf', 'ADSADFS', '$2y$10$lcHTaiw8SPNzbq49qY4UL.ikB96FJuTc3EFBKu3kgNiloU3yzLuoK', 'bce158956dbdb7b82ec14690aadd450d171b6c1094e29c84bdeff79252c9ade3', 'vendor', 1, 0, '2014-03-03 10:18:33', '2018-12-13 08:59:40', 'Testing Admin', '$2y$10$OKmM0Oqe82l8O7H0mTtsvOoSo7c6E.WBi0G1S73S9unUTXWXXnj7e', NULL, 'jF5HfkIroarglIO3NynOGrrtNLirwOcKCmRUbqyZZMtpmCMmfuShNZHJl6k7', '2018-12-13 06:29:40'),
(2, 'sdfsdf', 'sdfsdf', 'sdfsdf@asdas.sdf', '+23-4444444444', '+44-4434444444', 'sdfsdf', 'sdfsdf', 'sdfsdf', 'sdfsdf', NULL, '', 'subscriber', 1, 0, '2018-12-09 09:12:01', '2018-12-09 03:42:01', '', 'sdfsdfsdfsdfsdfs', NULL, NULL, NULL),
(3, 'sdfsdf', 'sdfsdf', 'sdf@asdas.sdf', '+23-4444444444', '+44-4434444444', 'sdfsdf', 'sdfsdf', 'sdfsdf', 'sdfsdf', NULL, '', 'subscriber', 1, 0, '2018-12-09 09:12:19', '2018-12-09 04:08:45', '', 'sdfsdfsdfsdfsdfs', NULL, NULL, NULL),
(4, 'sdfsdf', 'sdfsdf', 'kt@asdas.sdf', '+23-4444444444', '+44-4434444444', 'kirpal', 'sdfsdf', 'sdfsdf', 'sdfsdf', NULL, '', 'subscriber', 1, 0, '2018-12-09 09:12:28', '2018-12-09 04:14:20', '', 'sdfsdfsdfsdfsdfs', NULL, NULL, NULL),
(5, 'sdfsdf', NULL, 'sdfsdf@test.dc', '+34-4444444444', 'famale', '+34-4444444444', 'sdfsdfsdf', 'sdfsdf', 'sdf', NULL, '', 'vendor', 0, 0, '2018-12-13 13:08:58', '2018-12-13 07:38:58', 'sdfsdf', '1233456678', NULL, NULL, NULL),
(6, 'thakurshop', NULL, 'thatkurshop@test.com', '+12-1111111111', 'male', '+12-2222222222', 'testing address', 'testingcity', 'testingzip update', NULL, '', 'vendor', 0, 0, '2018-12-13 13:12:22', '2018-12-13 08:50:47', 'thakur', 'Kirpal@18', NULL, NULL, NULL),
(7, 'sdfsdf', NULL, 'sdfsdfr@sdf.sds', '+23-4234234234', 'male', '+23-4234234234', 'serserer', 'esrerwer', 'werwe', NULL, '', 'disabled', 0, 0, '2018-12-13 15:40:00', '2018-12-13 10:11:04', 'fstsdf', '$2y$10$G1RCzQ63I5wbmA6p/sSrCuIR6VpxoJZFHQX3VsHEAHm4wgQ279B22', NULL, '', NULL),
(8, 'signup', NULL, 'signup@test.asd', '+34-2342342342', 'male', '+23-4234234234', 'signupsignupsignupsignup', 'signup', 'signup', NULL, '', 'vendor', 0, 0, '2018-12-13 16:27:11', '2018-12-13 10:57:33', 'signup', '$2y$10$5fh8uFaQbZDNBuQlM6wdRO1f3xznj7sHd8Ne2M.sYZVLr68yvNWaS', NULL, 'Kv44JMbH7BO8SarD1SjeTsq6ob0t0Nch42KDXcO1fMexq7yxzMADhgdIEN8P', '2018-12-13 08:27:33'),
(9, 'sdere', NULL, 'srese@sdfdf.sdf', '+23-4234234234', 'famale', '+23-4234234234', 'dsdfsdrwerwe', 'srwerw', 'werw', NULL, '', 'vendor', 0, 0, '2018-12-14 00:44:47', '2018-12-13 19:14:47', 'teste', '$2y$10$CJK2tMj9Kv0633wbC/WR6escKFTkGnTxvlBM/n80hnys6vTwCacKK', NULL, NULL, NULL);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
