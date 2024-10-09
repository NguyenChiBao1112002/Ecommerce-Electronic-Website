-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th1 30, 2024 lúc 02:20 PM
-- Phiên bản máy phục vụ: 10.4.28-MariaDB
-- Phiên bản PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `fashion-shop`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customer`
--

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL,
  `account` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `email` varchar(80) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `customer`
--

INSERT INTO `user` (`id`, `account`, `address`, `avatar_url`, `created_at`, `dob`, `email`, `name`, `password`, `phone`, `updated_at`) VALUES
(1, 'customer1', '123 Main Street, Cityville', NULL, NULL, '1990-01-01', 'customer1@example.com', 'Nguyen Van A', 'password1', '1234567890', NULL),
(2, 'customer2', '456 Oak Avenue, Townsville', NULL, '2024-01-29 17:25:30.000000', '1985-03-15', 'customer2@example.com', 'Tran Thi B', 'password2', '9876543210', NULL),
(3, 'customer3', '789 Pine Road, Villageland', NULL, NULL, '1995-07-20', 'customer3@example.com', 'Le Van C', 'password3', '5551237890', NULL),
(4, 'customer4', '101 Elm Street, Hamletville', NULL, '2024-01-29 17:26:55.000000', '1980-12-05', 'customer4@example.com', 'Pham Thi D', 'password4', '3339997777', NULL),
(5, 'customer5', '202 Maple Lane, Countryside', NULL, '2024-01-29 17:28:57.000000', '1992-09-10', 'customer5@example.com', 'Vo Van E', 'password5', '1112223333', NULL),
(6, 'user123', '123 Main Street', NULL, '2024-01-29 17:31:38.000000', '1990-05-15', 'john.doe@example.com', 'John Doe', 'password123', '123-456-7890', NULL),
(7, 'alice84', '456 Oak Avenue', NULL, '2024-01-29 17:33:44.000000', '1985-08-22', 'alice.j@example.com', 'Alice Johnson', 'securePass', '987-654-3210', NULL),
(8, 'mike92', '789 Pine Lane', NULL, '2024-01-29 17:34:03.000000', '1992-03-10', 'mike.w@example.com', 'Mike Williams', 'mySecret', '555-123-4567', NULL),
(9, 'susan88', '321 Elm Road', NULL, '2024-01-29 17:34:10.000000', '1988-11-18', 'susan.d@example.com', 'Susan Davis', 'topSecret1', '789-012-3456', NULL),
(10, 'mark95', '567 Birch Street', NULL, '2024-01-29 17:34:16.000000', '1995-07-03', 'mark.t@example.com', 'Mark Thompson', 'confidential', '321-987-6543', NULL),
(11, 'lisa83', '876 Cedar Lane', NULL, '2024-01-29 17:34:21.000000', '1983-12-29', 'lisa.b@example.com', 'Lisa Brown', 'classifiedPass', '222-333-4444', NULL),
(12, 'ryan98', '234 Willow Avenue', NULL, '2024-01-29 17:34:25.000000', '1998-01-25', 'ryan.c@example.com', 'Ryan Clark', 'sensitiveInfo', '888-999-0000', NULL),
(13, 'emily80', '678 Maple Road', NULL, '2024-01-29 17:34:30.000000', '1980-06-07', 'emily.t@example.com', 'Emily Taylor', 'hiddenPass', '444-555-6666', NULL),
(14, 'david93', '987 Pine Lane', NULL, '2024-01-29 17:34:36.000000', '1993-09-14', 'david.w@example.com', 'David Wilson', 'privatePass', '777-888-9999', NULL),
(15, 'jane86', '543 Oak Avenue', NULL, '2024-01-29 17:34:39.000000', '1986-04-02', 'jane.w@example.com', 'Jane White', 'internalPass', '666-777-8888', NULL),
(16, 'nnlthanh', 'Ninh Kieu, Can Tho', NULL, '2024-01-29 17:38:00.000000', '2002-01-01', 'thanh20@gmail.com', 'Nguyen Ngoc Lam Thanh', '123456@', '666-777-8888', NULL),
(17, 'ncbao', 'Ninh Kieu, Can Tho', NULL, '2024-01-29 17:38:21.000000', '2002-03-03', 'bao02@gmail.com', 'Nguyen Chi Bao', '123456@', '666-777-8888', NULL),
(18, 'lttai', 'Ninh Kieu, Can Tho', NULL, '2024-01-29 17:38:44.000000', '2002-04-04', 'ltt02@gmail.com', 'Ly Tan Tai', '123456@', '666-777-8888', NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `customer`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `customer`
--
ALTER TABLE `user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
