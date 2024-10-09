-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th3 01, 2024 lúc 10:37 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

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
-- Cấu trúc bảng cho bảng `product`
--

CREATE TABLE `product` (
  `id` bigint(20) NOT NULL,
  `material` enum('COTTON','CANVAS','FABRIC','GOLD','SILVER','COPPER','LEATHER','SILK','DENIM','WOOL','POLYESTER','NYLON','LINEN','VELVET','CHIFFON','SPANDEX','LACE','SYNTHETIC','OTHER') DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `type` enum('SHIRTS','PANTS','DRESSES','SHOES','JACKETS','JEWELRY','ACCESSORIES','SWEATERS','JEANS','SHORTS','SKIRTS','BLOUSES','T_SHIRTS','ACTIVEWEAR','SOCKS','SCARVES','SUNGLASSES','WATCHES','HATS_CAPS','BELTS','GLOVES','WALLETS','PERFUMES','MAKEUP_COSMETICS','HAIR_ACCESSORIES','BACKPACKS','FORMAL_WEAR','OTHER') DEFAULT NULL,
  `imagedata_id` bigint(20) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `sale_percent` int(11) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product`
--

INSERT INTO `product` (`id`, `material`, `name`, `price`, `type`, `imagedata_id`, `created_at`, `sale_percent`, `updated_at`) VALUES
(1, 'COTTON', 'Áo Thun Nam Chạy Bộ Graphic Photic Zone', 199000.00, 'T_SHIRTS', 1, '2024-02-24 14:00:02.000000', 10, '2024-02-24 14:00:02.000000'),
(2, 'COTTON', 'Áo Singlet Nam Chạy Bộ in Graphic Special', 189000.00, 'T_SHIRTS', 2, '2024-02-26 21:47:46.000000', 0, '2024-02-26 21:47:46.000000'),
(3, 'COTTON', 'Áo Thun Nam Chạy Bộ Graphic Heartbeat', 189000.00, 'T_SHIRTS', 3, '2024-02-26 21:49:31.000000', 5, '2024-02-26 21:49:31.000000'),
(4, 'COTTON', 'Áo Singlet Nam Chạy Bộ Graphic Photic Zone', 189000.00, 'T_SHIRTS', 4, '2024-02-26 21:51:08.000000', 0, '2024-02-26 21:51:08.000000'),
(5, 'COTTON', 'Áo Khoác Nam có mũ Daily Wear', 399000.00, 'T_SHIRTS', 5, '2024-02-26 21:52:36.000000', 20, '2024-02-26 21:52:36.000000'),
(6, 'COTTON', 'Áo Khoác Nam Thể Thao Pro Active', 499000.00, 'T_SHIRTS', 6, '2024-02-26 21:53:11.000000', 34, '2024-02-26 21:53:11.000000'),
(7, 'FABRIC', 'Quần Jogger Nam UT đa năng', 499000.00, 'PANTS', 8, NULL, 0, NULL),
(8, 'FABRIC', 'Quần Jeans Nam Basics dáng Slim fit', 490000.00, 'JEANS', 9, NULL, 6, NULL),
(9, 'FABRIC', 'Áo Giữ Nhiệt Modal Ultra', 289000.00, 'SHIRTS', 10, NULL, 31, NULL),
(10, 'FABRIC', 'Quần Dài Nam Chạy Bộ Fast & Free', 399000.00, 'PANTS', 11, NULL, 25, NULL),
(11, 'CANVAS', 'Áo thun Cotton Trạm Phóng Tương Lai', 259000.00, 'SHIRTS', 12, NULL, 0, NULL),
(12, 'CANVAS', 'Áo Thun Care & Share Pastel', 199000.00, 'SHIRTS', 13, NULL, 0, NULL),
(13, 'CANVAS', 'Áo Thun Nam Cotton Team Whales', 349000.00, 'SHIRTS', 14, NULL, 0, NULL),
(14, 'CANVAS', 'Áo Thun Nam Cotton Compact in Coolmate', 259000.00, 'SHIRTS', 15, NULL, 42, NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK6d8deakb8jl5h2ola2043itpe` (`imagedata_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `product`
--
ALTER TABLE `product`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `FK6d8deakb8jl5h2ola2043itpe` FOREIGN KEY (`imagedata_id`) REFERENCES `image_data` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
