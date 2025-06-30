-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 30, 2025 at 04:14 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `websitedb`
--

-- --------------------------------------------------------

--
-- Table structure for table `availability`
--

CREATE TABLE `availability` (
  `id` int(11) NOT NULL,
  `arrival_date` date NOT NULL,
  `departure_date` date NOT NULL,
  `available` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `availability`
--

INSERT INTO `availability` (`id`, `arrival_date`, `departure_date`, `available`) VALUES
(1, '2025-07-01', '2025-07-05', 1),
(2, '2025-07-10', '2025-07-15', 1),
(3, '2025-07-20', '2025-07-25', 0);

-- --------------------------------------------------------

--
-- Table structure for table `available_rooms`
--

CREATE TABLE `available_rooms` (
  `id` int(11) NOT NULL,
  `room_number` varchar(20) DEFAULT NULL,
  `room_type` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `is_available` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `available_rooms`
--

INSERT INTO `available_rooms` (`id`, `room_number`, `room_type`, `price`, `is_available`) VALUES
(1, '101', 'Deluxe Suite', 399.00, 0),
(2, '102', 'Family Suite', 599.00, 0),
(3, '103', 'Luxury Penthouse', 799.00, 0),
(4, '104', 'Economy Room', 199.00, 0),
(5, '105', 'Single Room', 299.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `arrival_date` date DEFAULT NULL,
  `departure_date` date DEFAULT NULL,
  `guests` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `status` enum('confirmed','cancelled') DEFAULT 'confirmed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `name`, `email`, `phone`, `arrival_date`, `departure_date`, `guests`, `room_id`, `status`) VALUES
(1, 'Ali Fouani', 'ali@example.com', '1234567890', '2025-07-01', '2025-07-05', 2, 1, 'confirmed'),
(2, 'Sarah Ahmed', 'sarah@example.com', '0987654321', '2025-07-10', '2025-07-15', 3, 2, 'confirmed'),
(3, 'ali fouani', 'ali@gmail.com', '+961 76658007', '2025-06-01', '2025-06-04', 3, 1, 'confirmed'),
(4, '3222', '2131@fd.com', '321', '2025-06-03', '2025-06-03', 1, 1, 'confirmed'),
(5, 'ali fouani', 'admin@example.com', '+961 76658007', '2025-06-05', '2025-06-25', 1, 1, 'confirmed'),
(6, 'ali fouani', 'asa@ewq.com', 'sas', '2025-06-01', '2025-06-12', 12, 2, 'confirmed'),
(7, 'ali fouani', 'asa@ewq.com', 'sas', '2025-06-01', '2025-06-12', 12, 2, 'confirmed'),
(8, 'ali fouani', 'asa@ewq.com', 'sas', '2025-06-01', '2025-06-12', 12, 2, 'confirmed'),
(9, 'ali fouani', 'asa@ewq.com', 'sas', '2025-06-01', '2025-06-12', 12, 2, 'confirmed'),
(10, 'ali fouani', 'asa@ewq.com', 'sas', '2025-06-01', '2025-06-12', 12, 2, 'confirmed'),
(11, 'ali fouani', 'asa@ewq.com', 'sas', '2025-06-01', '2025-06-12', 12, 3, 'confirmed'),
(12, 'ali fouani', 'admin@example.com', '+961 76658007', '2025-05-30', '2025-06-01', 13, 3, 'confirmed'),
(13, 'ali jaafar', 'alijaafar@example.com', '+961 76658007', '2025-05-30', '2025-06-01', 13, 3, 'confirmed'),
(17, 'ali fouaniiii', 'admin99@example.com', '+961 76658007', '2025-07-01', '2025-07-05', 4, 1, 'confirmed'),
(20, 'ali fouani', 'asa@fffff.com', '+961 76658007', '2025-07-01', '2025-07-05', 1, 4, 'confirmed'),
(22, 'ali fouani', 'asa@fffff.com', '+961 76658007', '2025-07-01', '2025-07-05', 1, 4, 'confirmed'),
(24, 'ali fouatrrt', 'asa@fffff.com', '+961 76658007', '2025-07-01', '2025-07-05', 1, 1, 'confirmed'),
(28, '3222', 'admin@example.com', '+961 76658007', '2025-07-01', '2025-07-05', 1, 4, 'confirmed'),
(29, 'asda', 'admin@example.com', '+961 76658007', '2025-07-01', '2025-07-05', 1, 3, 'confirmed');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `name`, `price`, `description`, `image`) VALUES
(1, 'Deluxe Suite', 200.00, 'Well-appointed rooms designed for guests who desire a more.', NULL),
(2, 'Family Suite', 599.00, 'Consist of multiple rooms and a common living area.', NULL),
(3, 'Luxury Penthouse', 799.00, 'Top-tier accommodations usually on the highest floors.', '1751291368871-download.jpg'),
(4, 'alis room', 400.00, 'well appointed', '1751291295058-586152430.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`) VALUES
(1, 'admin@example.com', '1234');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `availability`
--
ALTER TABLE `availability`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `available_rooms`
--
ALTER TABLE `available_rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `availability`
--
ALTER TABLE `availability`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `available_rooms`
--
ALTER TABLE `available_rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `available_rooms` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
