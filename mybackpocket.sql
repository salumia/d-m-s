-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 15, 2019 at 09:20 AM
-- Server version: 5.6.39-cll-lve
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mybackpocket`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `password` varchar(255) NOT NULL DEFAULT '',
  `role` varchar(50) NOT NULL DEFAULT 'admin',
  `photo` varchar(255) NOT NULL,
  `encrypted_password` varchar(100) DEFAULT NULL,
  `salt` varchar(100) NOT NULL DEFAULT '',
  `designation` varchar(255) NOT NULL DEFAULT 'other',
  `remember_token` varchar(100) DEFAULT NULL,
  `api_token` varchar(60) DEFAULT NULL,
  `api_token_expires` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `name`, `username`, `email`, `phone`, `password`, `role`, `photo`, `encrypted_password`, `salt`, `designation`, `remember_token`, `api_token`, `api_token_expires`, `created_at`, `updated_at`, `status`) VALUES
(1, 'Admin', '', 'admin@shredex.net', '+32-4355656756', '$2y$10$ZRmg5mLv3blAYeDXppb0M.3Joy0NPzpOvY.4xisx/INjy2ul9Bh6O', 'admin', '', '$2y$10$lcHTaiw8SPNzbq49qY4UL.ikB96FJuTc3EFBKu3kgNiloU3yzLuoK', 'bce158956dbdb7b82ec14690aadd450d171b6c1094e29c84bdeff79252c9ade3', 'Software Engineer', NULL, '5XkjuzmH0hoy6pbAcoMWi5P7whxndA2wSvDR7eXPonKTv2baIcFfZyQK1IZU', '2019-04-14 09:08:29', '2014-03-03 10:18:33', '2019-04-14 12:08:29', 1);

-- --------------------------------------------------------

--
-- Table structure for table `appraisals`
--

CREATE TABLE `appraisals` (
  `id` int(10) UNSIGNED NOT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stage` int(11) NOT NULL DEFAULT '1',
  `user_id` int(11) NOT NULL,
  `reviewer_id` int(11) DEFAULT NULL,
  `staff_comments` text COLLATE utf8mb4_unicode_ci,
  `reviewer_comments` text COLLATE utf8mb4_unicode_ci,
  `department` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

CREATE TABLE `appraisal_feedbacks` (
  `id` int(10) UNSIGNED NOT NULL,
  `appraisal_id` int(11) DEFAULT NULL,
  `point_id` int(11) DEFAULT NULL,
  `section` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feedback` text COLLATE utf8mb4_unicode_ci,
  `rating` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

CREATE TABLE `appraisal_points` (
  `id` int(10) UNSIGNED NOT NULL,
  `point` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `section` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `industry_id` int(11) DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `industry_id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 'HR', 1, '0000-00-00 00:00:00', '2019-02-23 19:41:16'),
(2, 4, 'Financial Test', 1, '2019-01-20 17:32:11', '2019-02-23 19:41:29'),
(3, 5, 'Fleet Operations', 1, '2019-02-20 02:40:19', '2019-02-23 19:41:44'),
(4, 2, 'Payables', 1, '2019-02-28 04:32:48', '2019-02-28 04:32:48'),
(5, 4, 'Mobile Service', 1, '2019-02-28 04:33:17', '2019-02-28 04:33:17'),
(6, 5, 'PHP Laravel', 1, '2019-02-28 04:34:01', '2019-02-28 04:34:01');

-- --------------------------------------------------------

--
-- Table structure for table `claims`
--

CREATE TABLE `claims` (
  `id` int(10) UNSIGNED NOT NULL,
  `claim_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `amount` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `detail` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `claims`
--

INSERT INTO `claims` (`id`, `claim_type`, `from_date`, `to_date`, `amount`, `detail`, `status`, `user_id`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Canveyance', '2018-10-04', '2018-10-04', '2000', 'Sales expense', 'Pending', 5, NULL, '2018-10-03 15:14:30', '2018-10-03 15:14:30'),
(2, 'Canveyance', '2018-10-11', '2018-10-11', '200', 'travelled for office work', 'Approved', 15, 14, '2018-10-12 13:01:41', '2018-10-12 13:02:53');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` int(10) UNSIGNED NOT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cc` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `status` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `vendor_id`, `user_id`, `name`, `email`, `company`, `cc`, `type`, `status`, `created_at`, `updated_at`) VALUES
(2, 1, 1, 'adsf', 'rg@gmail.com', 'ABCD', NULL, 'user', 1, '2019-02-28 04:28:46', '2019-03-01 14:08:58'),
(3, 1, 2, 'Komal', 'ks@gmail.com', 'Trigvent', 'trigvent@gmail.com', 'vendor', 1, '2019-03-01 18:52:09', '2019-03-01 18:52:09'),
(4, 1, 4, 'Vinod', 'v1@gmail.com', 'Trigvent', NULL, 'user', 1, '2019-03-11 23:57:32', '2019-03-11 23:57:32'),
(5, 1, 5, 'Bhish', 'bhish@gmail.com', 'Trigvent', NULL, 'user', 1, '2019-03-11 23:58:23', '2019-03-11 23:58:23'),
(6, 1, 6, 'Arsh', 'arsh@example.com', 'Trigvent', NULL, 'user', 1, '2019-03-11 23:59:09', '2019-03-11 23:59:09'),
(7, 1, 7, 'Shafali', 'shaf@gmail.com', 'Flairs', NULL, 'user', 1, '2019-03-12 00:00:23', '2019-03-12 00:00:23'),
(8, 1, 8, 'Sneha', 'sneh@gmail.com', 'Flairs', NULL, 'user', 1, '2019-03-12 00:01:08', '2019-03-12 00:01:08'),
(9, 1, 3, 'Sachin', 'trigvent@gmail.com', 'Trigvent', NULL, 'user', 1, '2019-04-14 12:10:52', '2019-04-14 12:10:52');

-- --------------------------------------------------------

--
-- Table structure for table `contracts`
--

CREATE TABLE `contracts` (
  `id` int(11) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `industry_id` int(11) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `receiver_role` varchar(10) NOT NULL DEFAULT 'user',
  `email` varchar(255) DEFAULT NULL,
  `sender_flag` int(11) NOT NULL DEFAULT '0',
  `receiver_flag` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0=Draft, 1=Inprogress, 2=Done , 3=Reject',
  `sender_signature` varchar(50) DEFAULT NULL,
  `receiver_signature` varchar(50) DEFAULT NULL,
  `access_token` varchar(100) DEFAULT NULL,
  `token_expiration` timestamp NULL DEFAULT NULL,
  `pin` varchar(10) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contracts`
--

INSERT INTO `contracts` (`id`, `type`, `name`, `description`, `industry_id`, `category_id`, `sender_id`, `receiver_id`, `receiver_role`, `email`, `sender_flag`, `receiver_flag`, `status`, `sender_signature`, `receiver_signature`, `access_token`, `token_expiration`, `pin`, `created_at`, `updated_at`) VALUES
(1, 'Agreement', 'Nitin-Trigvent Agreement', 'Nitin-Trigvent Agreement Nitin-Trigvent Agreement Nitin-Trigvent Agreement Nitin-Trigvent Agreement', NULL, 1, 1, 3, 'user', 'trigvent@gmail.com', 2, 2, 4, 'nsaluja', 'trigvent', 'rDuoAf6LM9BIlkTN', '2019-04-15 12:56:58', 'trigvent', '2019-04-14 12:56:58', '2019-04-14 13:36:53'),
(2, 'Agreement', 'Nitin-Sachin Agreement', 'Nitin-Sachin Agreement Nitin-Sachin Agreement', NULL, 1, 1, 3, 'user', 'trigvent@gmail.com', 1, 2, 2, NULL, 'ssal', 'tri5SOEH3XlZlaNO', '2019-04-15 13:52:02', 'sachin', '2019-04-14 13:52:02', '2019-04-14 14:03:06');

-- --------------------------------------------------------

--
-- Table structure for table `contract_logs`
--

CREATE TABLE `contract_logs` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci,
  `new_title` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_body` text COLLATE utf8mb4_unicode_ci,
  `part_id` int(11) DEFAULT NULL,
  `contract_id` int(11) DEFAULT NULL,
  `user` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'receiver',
  `iteration` int(11) NOT NULL DEFAULT '1',
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'edited',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contract_logs`
--

INSERT INTO `contract_logs` (`id`, `title`, `body`, `new_title`, `new_body`, `part_id`, `contract_id`, `user`, `iteration`, `type`, `created_at`, `updated_at`) VALUES
(1, 'Primary', 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum', NULL, NULL, 4, 1, 'receiver', 1, 'deleted', '2019-04-14 13:03:46', '2019-04-14 13:03:46'),
(2, 'Primary', 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum', NULL, NULL, 4, 1, 'sender', 2, 'reload', '2019-04-14 13:12:01', '2019-04-14 13:12:01'),
(3, 'Important Term', 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum', 'Important Term', 'Changed', 3, 1, 'receiver', 3, 'edited', '2019-04-14 13:13:27', '2019-04-14 13:13:27'),
(4, 'Important Term', 'Changed', NULL, NULL, 3, 1, 'sender', 4, 'deleted', '2019-04-14 13:15:47', '2019-04-14 13:15:47'),
(5, 'Important Term', 'Changed', NULL, NULL, 3, 1, 'receiver', 5, 'reload', '2019-04-14 13:19:49', '2019-04-14 13:19:49'),
(6, 'Important Term', 'Changed', NULL, NULL, 3, 1, 'sender', 6, 'deleted', '2019-04-14 13:21:59', '2019-04-14 13:21:59'),
(7, 'Important Term', 'Changed', NULL, NULL, 3, 1, 'receiver', 7, 'reload', '2019-04-14 13:28:55', '2019-04-14 13:28:55'),
(8, NULL, NULL, NULL, NULL, NULL, 1, 'receiver', 8, 'accept', '2019-04-14 13:32:07', '2019-04-14 13:32:07'),
(9, NULL, NULL, NULL, NULL, NULL, 1, 'receiver', 9, 'accept', '2019-04-14 13:36:54', '2019-04-14 13:36:54'),
(10, 'John Part Shredding', 'this is my john test', NULL, NULL, 7, 2, 'receiver', 1, 'deleted', '2019-04-14 13:56:14', '2019-04-14 13:56:14'),
(11, 'John Part Shredding', 'this is my john test', NULL, NULL, 7, 2, 'sender', 2, 'reload', '2019-04-14 13:56:42', '2019-04-14 13:56:42'),
(12, NULL, NULL, NULL, NULL, NULL, 2, 'sender', 3, 'accept', '2019-04-14 14:03:06', '2019-04-14 14:03:06');

-- --------------------------------------------------------

--
-- Table structure for table `contract_parts`
--

CREATE TABLE `contract_parts` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `contract_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `is_edited` tinyint(1) NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `modified` tinyint(1) NOT NULL DEFAULT '0',
  `newly_added` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contract_parts`
--

INSERT INTO `contract_parts` (`id`, `title`, `body`, `contract_id`, `user_id`, `is_edited`, `is_deleted`, `modified`, `newly_added`, `created_at`, `updated_at`) VALUES
(1, 'Definition of File Boxes', 'When rates are provided based on a per ‘file box’ basis, we refer to boxes that measure 15”D x 10”W x 12” high. If your boxes are not the same dimension, you will be notified by our driver if there will be changes to your rates, depending on the size of the boxes.', 1, 1, 0, 0, 0, 0, '2019-04-14 12:56:58', '2019-04-14 12:56:58'),
(2, 'Milestone 3 Test Global Part', 'Change Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum', 1, 1, 0, 0, 0, 0, '2019-04-14 12:56:58', '2019-04-14 12:56:58'),
(3, 'Important Term', 'Changed', 1, 1, 0, 0, 1, 0, '2019-04-14 12:56:58', '2019-04-14 13:28:55'),
(4, 'Primary', 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum', 1, 1, 0, 0, 0, 0, '2019-04-14 12:56:58', '2019-04-14 13:13:27'),
(5, 'Definition of File Boxes', 'When rates are provided based on a per ‘file box’ basis, we refer to boxes that measure 15”D x 10”W x 12” high. If your boxes are not the same dimension, you will be notified by our driver if there will be changes to your rates, depending on the size of the boxes.', 2, 1, 0, 0, 0, 0, '2019-04-14 13:52:03', '2019-04-14 13:52:03'),
(6, 'Notices, Modifications and Request', 'All notices, modifications, and/or requests and other communications required or permitted under this Agreement shall be in writing and delivered by Canada Post Registered Mail, U.S. Post Certified Mail, or by express delivery service requiring a written acknowledgment of receipt. Any time-period stated in this Agreement for providing any notice shall be measured from receipt of such notice', 2, 1, 0, 0, 0, 0, '2019-04-14 13:52:03', '2019-04-14 13:52:03'),
(7, 'John Part Shredding', 'this is my john test', 2, 1, 0, 0, 1, 0, '2019-04-14 13:52:03', '2019-04-14 13:56:42');

-- --------------------------------------------------------

--
-- Table structure for table `contract_types`
--

CREATE TABLE `contract_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contract_types`
--

INSERT INTO `contract_types` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Agreement', 1, NULL, '2019-02-23 19:42:16'),
(2, 'Invoice', 1, NULL, '2019-02-23 19:42:29'),
(3, 'Personel', 1, '2019-01-26 12:06:19', '2019-01-27 03:23:18'),
(4, 'Receipt', 1, '2019-01-28 19:13:52', '2019-01-28 19:13:52');

-- --------------------------------------------------------

--
-- Table structure for table `document_templates`
--

CREATE TABLE `document_templates` (
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

CREATE TABLE `employee_files` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `original_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employee_files`
--

INSERT INTO `employee_files` (`id`, `name`, `original_name`, `user_id`, `created_at`, `updated_at`) VALUES
(1, '1535460998.docx', 'Email - offer letter format.docx', 5, '2018-08-28 19:58:07', '2018-08-28 19:58:07'),
(3, '1535481535.docx', 'Email - offer letter format.docx', 7, '2018-08-29 01:38:56', '2018-08-29 01:38:56');

-- --------------------------------------------------------

--
-- Table structure for table `industries`
--

CREATE TABLE `industries` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `industries`
--

INSERT INTO `industries` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'All', 1, NULL, NULL),
(2, 'Mechanical', 0, NULL, '2019-01-26 10:48:12'),
(3, 'Chemical', 1, '2019-01-26 11:05:05', '2019-02-17 11:37:16'),
(4, 'Document Shredding', 1, '2019-01-28 19:12:49', '2019-01-28 19:12:49'),
(5, 'Software Development', 1, '2019-02-04 13:47:53', '2019-02-04 13:47:53');

-- --------------------------------------------------------

--
-- Table structure for table `key_responsibilities`
--

CREATE TABLE `key_responsibilities` (
  `id` int(10) UNSIGNED NOT NULL,
  `comment` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rating` int(11) DEFAULT NULL,
  `appraisal_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leaves`
--

CREATE TABLE `leaves` (
  `id` int(10) UNSIGNED NOT NULL,
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
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

CREATE TABLE `migrations` (
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
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `module` varchar(20) NOT NULL DEFAULT 'contract',
  `type` varchar(20) NOT NULL DEFAULT 'sent',
  `user_id` int(11) NOT NULL,
  `role` varchar(10) NOT NULL DEFAULT 'user',
  `ref_id` int(11) NOT NULL,
  `is_viewed` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `module`, `type`, `user_id`, `role`, `ref_id`, `is_viewed`, `created_at`, `updated_at`) VALUES
(1, 'contract', 'sent', 3, 'user', 1, 1, '2019-04-14 06:35:58', '2019-04-14 13:35:58'),
(2, 'contract', 'review', 1, 'vendor', 1, 1, '2019-04-14 06:31:28', '2019-04-14 13:31:28'),
(3, 'contract', 'review', 3, 'user', 1, 1, '2019-04-14 06:35:58', '2019-04-14 13:35:58'),
(4, 'contract', 'review', 1, 'vendor', 1, 1, '2019-04-14 06:31:28', '2019-04-14 13:31:28'),
(5, 'contract', 'review', 3, 'user', 1, 1, '2019-04-14 06:35:58', '2019-04-14 13:35:58'),
(6, 'contract', 'review', 1, 'vendor', 1, 1, '2019-04-14 06:31:28', '2019-04-14 13:31:28'),
(7, 'contract', 'review', 3, 'user', 1, 1, '2019-04-14 06:35:58', '2019-04-14 13:35:58'),
(8, 'contract', 'review', 1, 'vendor', 1, 1, '2019-04-14 06:31:28', '2019-04-14 13:31:28'),
(9, 'contract', 'accept', 1, 'vendor', 1, 1, '2019-04-15 13:41:11', '2019-04-15 20:41:11'),
(10, 'contract', 'accept', 1, 'vendor', 1, 1, '2019-04-15 13:41:11', '2019-04-15 20:41:11'),
(11, 'contract', 'sent', 3, 'user', 2, 1, '2019-04-14 06:59:22', '2019-04-14 13:59:22'),
(12, 'contract', 'review', 1, 'vendor', 2, 1, '2019-04-14 07:16:51', '2019-04-14 14:16:51'),
(13, 'contract', 'review', 3, 'user', 2, 1, '2019-04-14 06:59:22', '2019-04-14 13:59:22'),
(14, 'contract', 'accept', 3, 'user', 2, 0, '2019-04-14 14:03:06', '2019-04-14 14:03:06');

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect_url` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `static_menu_link` int(11) DEFAULT '0',
  `description` longblob,
  `cover_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

CREATE TABLE `page_files` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `original_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `page_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Table structure for table `parts`
--

CREATE TABLE `parts` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `internal_title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `special` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'conclusion',
  `type` int(11) NOT NULL DEFAULT '0',
  `industry_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'vendor',
  `status` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `parts`
--

INSERT INTO `parts` (`id`, `title`, `internal_title`, `body`, `special`, `type`, `industry_id`, `user_id`, `role`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Scheduling', 'Scheduling', 'In order to reduce costs to our clients, our routes are scheduled for maximum efficiency. We will make every attempt to provide service to you at a time that is most convenient, however we can only guarantee that service will be done between our operating hours of 8am to 5pm, unless certain times are specifically requested. You may contact our dispatch office on the day of your pick up to request a narrower time window, for your convenience.\r\n\r\nIf additional material is presented to us upon our arrival at your facility, we will do our best to complete the entire job on the same day. However, if our prior commitments to other clients prevent us from completing the job, we will re-schedule a pickup of your additional items on another day. Please note that this will result in additional costs for travel and shredding time.', 'conclusion', 1, 2, 0, 'vendor', 1, NULL, NULL),
(2, 'Definition of File Boxes', 'Definition', 'When rates are provided based on a per ‘file box’ basis, we refer to boxes that measure 15”D x 10”W x 12” high. If your boxes are not the same dimension, you will be notified by our driver if there will be changes to your rates, depending on the size of the boxes.', 'conclusion', 1, 1, 0, 'vendor', 1, NULL, '2019-01-27 06:01:07'),
(3, 'ShredPack Notes', 'Shred Pack Notes - Copy and Delete Clause', 'AAAAAAAAa', 'conclusion', 1, 4, 0, 'vendor', 0, '2019-01-27 03:01:30', '2019-02-07 00:19:50'),
(4, 'Notices, Modifications and Request', 'C11 - Notices, Modifications and Request', 'All notices, modifications, and/or requests and other communications required or permitted under this Agreement shall be in writing and delivered by Canada Post Registered Mail, U.S. Post Certified Mail, or by express delivery service requiring a written acknowledgment of receipt. Any time-period stated in this Agreement for providing any notice shall be measured from receipt of such notice', 'conclusion', 1, 3, 0, 'vendor', 1, '2019-01-27 03:04:39', '2019-01-27 03:04:39'),
(5, 'Excused Performance', 'C10 - Excused Performance', 'In the event that shredEX is unable to provide a scheduled service due to circumstances beyond the Company’s reasonable control, the Client acknowledges that  shredEX will not be in breach for failure to comply with the provisions of this Agreement.  shredEX will make every attempt to reschedule the Client’s service booking, within seven (7) business days from the original scheduled date.\r\n', 'conclusion', 1, 2, 0, 'vendor', 1, '2019-01-27 03:08:18', '2019-01-27 03:12:44'),
(6, 'global part test', 'internal title', 'this is the description', 'conclusion', 1, 2, 0, 'vendor', 1, '2019-01-28 19:15:57', '2019-01-28 19:16:12'),
(7, 'Primary', 'Primary Term for devlopment', 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum', 'conclusion', 0, 5, 1, 'vendor', 1, '2019-02-04 13:49:16', '2019-02-04 13:49:16'),
(8, 'Milestone 3 Test Global Part', 'Milestone 3 Test Global Part', 'Change Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum', 'conclusion', 1, 1, 0, 'vendor', 1, '2019-02-17 11:36:00', '2019-02-17 11:36:21'),
(9, 'Important Term', 'General term for all contracts', 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum', 'conclusion', 0, 1, 1, 'vendor', 1, '2019-02-17 11:41:02', '2019-02-17 11:41:02'),
(10, 'Parking Pass', 'Parking Pass Internal', 'this is the test for parking pass part', 'conclusion', 1, 4, 0, 'vendor', 1, '2019-02-20 02:40:03', '2019-02-20 02:40:03'),
(11, 'John Part Shredding', 'test shredding', 'this is my john test', 'conclusion', 0, 4, 1, 'vendor', 1, '2019-02-21 01:54:53', '2019-02-21 01:54:53');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`id`, `email`, `token`, `created_at`, `updated_at`) VALUES
(2, 'nitinsaluja@example.com', 'GvH0ipOcZdo4gO3JdrZkbnFnQ1p9RWTFQKplwbHYLtg56KA1gutkBS7hfxcO', '2018-12-13 11:16:06', '2018-12-13 19:24:49'),
(3, 'kirpal@example.com', 'eU76uw84AFCb8klZMdyLxi5RZbRcUhtWzzj11EqyLIMCXaZxbY9MpbVtV8N0', '2018-12-13 19:18:52', '2018-12-13 19:19:49'),
(4, 'nitinsaluja98@gmail.com', 'exL3T7WC5QWyxjrrWEl539nEtMdFvTzZ4zMVXnbsTMAZ9A1NJcFc0ghNoTst', '2019-04-14 10:55:02', '2019-04-14 10:55:02');

-- --------------------------------------------------------

--
-- Table structure for table `revisions`
--

CREATE TABLE `revisions` (
  `id` int(10) UNSIGNED DEFAULT NULL,
  `revisionable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revisionable_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `old_value` text COLLATE utf8mb4_unicode_ci,
  `new_value` text COLLATE utf8mb4_unicode_ci,
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

CREATE TABLE `rpm_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `ip` varchar(45) NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT '0',
  `log_type` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rpm_session`
--

CREATE TABLE `rpm_session` (
  `session_id` char(32) NOT NULL,
  `save_path` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL DEFAULT '',
  `modified` int(11) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `session_data` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sets`
--

CREATE TABLE `sets` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sets`
--

INSERT INTO `sets` (`id`, `title`, `user_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Software Set', 2, 0, '2019-01-30 01:30:00', '2019-01-30 10:59:44'),
(2, 'Software Terms', 1, 1, '2019-02-17 11:42:40', '2019-02-17 11:42:40'),
(3, 'One Local & One Global', 1, 1, '2019-02-17 14:01:18', '2019-02-17 14:01:18'),
(4, 'John Set', 1, 1, '2019-02-21 01:54:08', '2019-02-21 01:54:08');

-- --------------------------------------------------------

--
-- Table structure for table `set_parts`
--

CREATE TABLE `set_parts` (
  `id` int(10) UNSIGNED NOT NULL,
  `part_id` int(11) NOT NULL,
  `set_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `set_parts`
--

INSERT INTO `set_parts` (`id`, `part_id`, `set_id`, `created_at`, `updated_at`) VALUES
(3, 2, 1, '2019-02-04 13:49:45', '2019-02-04 13:49:45'),
(4, 7, 1, '2019-02-04 13:49:45', '2019-02-04 13:49:45'),
(5, 2, 2, '2019-02-17 11:42:40', '2019-02-17 11:42:40'),
(6, 8, 2, '2019-02-17 11:42:40', '2019-02-17 11:42:40'),
(7, 9, 2, '2019-02-17 11:42:40', '2019-02-17 11:42:40'),
(8, 7, 2, '2019-02-17 11:42:40', '2019-02-17 11:42:40'),
(9, 9, 3, '2019-02-17 14:01:19', '2019-02-17 14:01:19'),
(10, 8, 3, '2019-02-17 14:01:19', '2019-02-17 14:01:19'),
(13, 2, 4, '2019-02-21 01:55:35', '2019-02-21 01:55:35'),
(14, 4, 4, '2019-02-21 01:55:35', '2019-02-21 01:55:35'),
(15, 11, 4, '2019-02-21 01:55:35', '2019-02-21 01:55:35');

-- --------------------------------------------------------

--
-- Table structure for table `user_profiles`
--

CREATE TABLE `user_profiles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `gender` varchar(100) DEFAULT NULL,
  `phone` varchar(100) NOT NULL,
  `fax` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL DEFAULT '',
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  `encrypted_password` varchar(100) DEFAULT NULL,
  `salt` varchar(100) NOT NULL DEFAULT '',
  `role` varchar(50) NOT NULL DEFAULT 'user',
  `remember_token` varchar(100) DEFAULT NULL,
  `api_token` varchar(60) DEFAULT NULL,
  `api_token_expires` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL DEFAULT '1',
  `contact_added_by` int(11) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_profiles`
--

INSERT INTO `user_profiles` (`id`, `name`, `gender`, `phone`, `fax`, `email`, `password`, `address`, `city`, `zip`, `encrypted_password`, `salt`, `role`, `remember_token`, `api_token`, `api_token_expires`, `created_at`, `updated_at`, `status`, `contact_added_by`, `username`) VALUES
(1, 'Richa', 'female', '(087) 876 – 5745', '(098) 787 – 6565', 'rg@gmail.com', '$2y$10$D3TYsRrylGfE5mWgobOml.mZ6iDLL6.jEq/xyBxsMErZxDvVbiLEy', 'Model Town', 'Chandigarh', '16001', NULL, '', 'disabled', NULL, '', NULL, '2019-01-27 11:30:22', '2019-01-31 14:10:43', 1, NULL, 'richa'),
(2, 'testuser', 'male', '(702) 555 – 1212', '(866) 555 – 5555', 'admin2@shredex.net', '$2y$10$ZSRCUF7n.tdoRvs48QrSxOE1VUsq6ZZqJcmosoKzpPCVQePWtwlo.', '123', 'adfa', 'adf', NULL, '', 'user', NULL, '', NULL, '2019-02-06 17:13:00', '2019-02-09 15:03:44', 1, NULL, 'testuser'),
(3, 'Test SS', NULL, '(124) 323 – 5465', '(314) 456 – 7671', 'trigvent@gmail.com', '$2y$10$/x7hQtGDdwEhHelWjf59cO.m3/ofRAXbr1nl7P.mkeLZpDhn29ADC', '637 Manhattan Beach Blvd, Manhattan Beach, CA 90266, USA', 'Manhattan Beach', '90266', NULL, '', 'user', NULL, '2uJlyzDUmFfhhljm7XjBXRpRo971CJACF3IWUl6gNO5JXJQY3cSXMBc0dHbV', '2019-04-14 10:02:24', '2019-02-17 07:05:29', '2019-04-14 13:02:24', 1, NULL, 'testss'),
(4, 'Vinod', NULL, '(765) 657 – 6877', '(765) 677 – 8767', 'v1@gmail.com', '', '13123 E 16th Ave, Aurora, CO 80045, USA', 'Aurora', '80045', NULL, '', 'user', NULL, NULL, NULL, '2019-03-11 16:57:32', '2019-03-11 23:57:32', 1, 1, 'vinod'),
(5, 'Bhish', NULL, '(987) 867 – 6877', '(778) 678 – 7987', 'bhish@gmail.com', '', 'Chase Rd, Windermere, FL 34786, USA', 'Windermere', '34786', NULL, '', 'user', NULL, NULL, NULL, '2019-03-11 16:58:22', '2019-03-11 23:58:22', 1, 1, 'bhish'),
(6, 'Arsh', NULL, '(654) 676 – 4565', '(456) 565 – 6765', 'arsh@example.com', '', 'Orlando, FL 32827, USA', 'Orlando', '32827', NULL, '', 'user', NULL, NULL, NULL, '2019-03-11 16:59:09', '2019-03-11 23:59:09', 1, 1, 'arsh'),
(7, 'Shafali', NULL, '(987) 676 – 5787', '(878) 768 – 7887', 'shaf@gmail.com', '', '#554-A, Model Town, Yamuna Nagar, Haryana 135001, India', 'Yamuna Nagar', '135001', NULL, '', 'user', NULL, NULL, NULL, '2019-03-11 17:00:22', '2019-03-12 00:00:22', 1, 1, 'shafu'),
(8, 'Sneha', NULL, '(987) 579 – 7687', '(767) 687 – 8687', 'sneh@gmail.com', '', 'Chase Rd, Windermere, FL 34786, USA', 'Windermere', '34786', NULL, '', 'user', NULL, NULL, NULL, '2019-03-11 17:01:07', '2019-03-12 00:01:07', 1, 1, 'sneha');

-- --------------------------------------------------------

--
-- Table structure for table `vendor_profiles`
--

CREATE TABLE `vendor_profiles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `shop_name` varchar(255) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `gender` varchar(15) NOT NULL DEFAULT 'male',
  `phone` varchar(20) NOT NULL,
  `fax` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL DEFAULT '',
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  `current_balance` float NOT NULL DEFAULT '0',
  `remember_token` varchar(100) DEFAULT NULL,
  `encrypted_password` varchar(100) DEFAULT NULL,
  `salt` varchar(100) NOT NULL DEFAULT '',
  `role` varchar(50) NOT NULL DEFAULT 'vendor',
  `api_token` varchar(60) DEFAULT NULL,
  `api_token_expires` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL DEFAULT '0',
  `industry_id` int(11) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `vendor_profiles`
--

INSERT INTO `vendor_profiles` (`id`, `name`, `shop_name`, `photo`, `gender`, `phone`, `fax`, `email`, `password`, `address`, `city`, `zip`, `current_balance`, `remember_token`, `encrypted_password`, `salt`, `role`, `api_token`, `api_token_expires`, `created_at`, `updated_at`, `status`, `industry_id`, `username`) VALUES
(1, 'Nitin Saluja', 'Trigvent', NULL, 'male', '(113) 225 – 5514', '(235) 112 – 6654', 'nitinsaluja98@gmail.com', '$2y$10$mXt.Cb8Xkc4TjyuH.Ksx6u9JsvEDExEqGIhosqtRKdXYhmca8T.L.', 'Model Town', 'Yamunanagar', '135001', 0, NULL, NULL, '', 'vendor', 'Hqaoqz2WgzGoCO4H7qQaaag6ieqUXuJaAAF9fiMUsUybUoyDAgCErdtIIpjP', '2019-04-15 04:17:18', '2019-01-27 11:28:04', '2019-04-15 19:17:18', 0, 2, 'nitinsaluja98'),
(2, 'KK', 'Flairs', NULL, 'male', '+21-3424536475', '+13-2424354657', 'ks@gmail.com', '$2y$10$v/kVs9fBErfaiY8KY01Zte9GnA1EG1UseBd5mdFjpSag5R0WVM.5q', 'Model Town', 'Chandigarh', '16001', 0, NULL, NULL, '', 'vendor', 'XMuXmP5BsvPIT7HCj7AF8vZ7ZVg5WVpHqUWmvVDW2oAn7JqhKtvkvZiz8bsx', '2019-01-27 03:40:20', '2019-01-27 11:38:42', '2019-01-27 06:10:20', 0, 3, 'kirpals');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `appraisals`
--
ALTER TABLE `appraisals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `appraisal_feedbacks`
--
ALTER TABLE `appraisal_feedbacks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `appraisal_points`
--
ALTER TABLE `appraisal_points`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `claims`
--
ALTER TABLE `claims`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contracts`
--
ALTER TABLE `contracts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contract_logs`
--
ALTER TABLE `contract_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contract_parts`
--
ALTER TABLE `contract_parts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contract_types`
--
ALTER TABLE `contract_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_files`
--
ALTER TABLE `employee_files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `industries`
--
ALTER TABLE `industries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `key_responsibilities`
--
ALTER TABLE `key_responsibilities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `leaves`
--
ALTER TABLE `leaves`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `page_files`
--
ALTER TABLE `page_files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `parts`
--
ALTER TABLE `parts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sets`
--
ALTER TABLE `sets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `set_parts`
--
ALTER TABLE `set_parts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vendor_profiles`
--
ALTER TABLE `vendor_profiles`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `appraisals`
--
ALTER TABLE `appraisals`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `appraisal_feedbacks`
--
ALTER TABLE `appraisal_feedbacks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT for table `appraisal_points`
--
ALTER TABLE `appraisal_points`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `claims`
--
ALTER TABLE `claims`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `contracts`
--
ALTER TABLE `contracts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `contract_logs`
--
ALTER TABLE `contract_logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `contract_parts`
--
ALTER TABLE `contract_parts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `contract_types`
--
ALTER TABLE `contract_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `employee_files`
--
ALTER TABLE `employee_files`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `industries`
--
ALTER TABLE `industries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `key_responsibilities`
--
ALTER TABLE `key_responsibilities`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leaves`
--
ALTER TABLE `leaves`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `page_files`
--
ALTER TABLE `page_files`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `parts`
--
ALTER TABLE `parts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sets`
--
ALTER TABLE `sets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `set_parts`
--
ALTER TABLE `set_parts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `user_profiles`
--
ALTER TABLE `user_profiles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `vendor_profiles`
--
ALTER TABLE `vendor_profiles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
