-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 22, 2017 at 06:30 PM
-- Server version: 10.1.28-MariaDB
-- PHP Version: 7.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `burstexplorer`
--

-- --------------------------------------------------------

--
-- Table structure for table `blacklist`
--

CREATE TABLE `blacklist` (
  `id` int(11) NOT NULL,
  `accountId` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `blocks`
--

CREATE TABLE `blocks` (
  `id` int(11) NOT NULL,
  `blockId` varchar(255) NOT NULL,
  `height` int(11) NOT NULL,
  `generator` varchar(255) NOT NULL,
  `generatorRS` varchar(26) NOT NULL,
  `generatorName` varchar(100) DEFAULT NULL,
  `pool` varchar(255) DEFAULT NULL,
  `poolRS` varchar(26) DEFAULT NULL,
  `poolName` varchar(100) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `netDiff` int(11) NOT NULL,
  `deadline` int(11) NOT NULL,
  `reward` bigint(20) NOT NULL,
  `fee` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `burst`
--

CREATE TABLE `burst` (
  `date` date NOT NULL,
  `open` float NOT NULL,
  `high` float NOT NULL,
  `low` float NOT NULL,
  `close` float NOT NULL,
  `volume` int(11) NOT NULL,
  `marketcap` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `market`
--

CREATE TABLE `market` (
  `btc` varchar(50) NOT NULL,
  `usd` varchar(50) NOT NULL,
  `eur` varchar(50) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `market`
--

INSERT INTO `market` (`btc`, `usd`, `eur`, `timestamp`) VALUES
('0.00000100', '0.00599066', '0.0050842731', '2017-10-22 18:28:44');

-- --------------------------------------------------------

--
-- Table structure for table `pools`
--

CREATE TABLE `pools` (
  `id` int(11) NOT NULL,
  `pool` varchar(255) NOT NULL,
  `poolRS` varchar(26) NOT NULL,
  `poolName` varchar(100) DEFAULT NULL,
  `color` varchar(7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blacklist`
--
ALTER TABLE `blacklist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `accountId` (`accountId`);

--
-- Indexes for table `blocks`
--
ALTER TABLE `blocks`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `height` (`height`);

--
-- Indexes for table `pools`
--
ALTER TABLE `pools`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pool` (`pool`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blacklist`
--
ALTER TABLE `blacklist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `blocks`
--
ALTER TABLE `blocks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69209;

--
-- AUTO_INCREMENT for table `pools`
--
ALTER TABLE `pools`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13769;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
