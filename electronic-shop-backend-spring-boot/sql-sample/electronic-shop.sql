-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 09, 2024 lúc 06:11 PM
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
-- Cơ sở dữ liệu: `electronic-shop`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `address`
--

CREATE TABLE `address` (
  `id` bigint(20) NOT NULL,
  `address` text DEFAULT NULL,
  `belongs_to` text DEFAULT NULL,
  `city_id` varchar(255) DEFAULT NULL,
  `district_id` varchar(255) DEFAULT NULL,
  `is_default` bit(1) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `ward_id` varchar(255) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `warehouse_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `address`
--

INSERT INTO `address` (`id`, `address`, `belongs_to`, `city_id`, `district_id`, `is_default`, `phone`, `ward_id`, `customer_id`, `warehouse_id`) VALUES
(1, 'Xuân Hiệp, Trà Ôn, Vĩnh Long', 'Nguyễn Chí Bảo', '215', '1962', b'0', '0862818304', '570201', 1, NULL),
(2, 'hẻm 117, đường 3/2', 'Nguyễn Chí Bằng', '220', '1572', b'0', '0862818305', '550102', 1, NULL),
(3, 'hẻm 58 đường 3/2', 'Nguyễn Ngọc Lam Thanh', '220', '1572', b'0', '0862818333', '550110', 1, NULL),
(4, 'Trường THPT Trần Đại Nghĩa', 'Phạm Ngọc Minh Thư', '215', '2008', b'1', '0887158963', '570510', 19, NULL),
(5, 'hẻm 12', 'Trần Văn Linh', '220', '1572', b'1', '0886020214', '550110', 5, NULL),
(6, 'hẻm 58, đường Phạm Văn Đồng', 'Nguyễn Yến Vy', '202', '1444', b'0', '0889020285', '20301', 5, NULL),
(7, '103, Vạn Phúc', 'Nguyễn Ngọc Hân', '224', '1819', b'0', '0862818372', '31003', 1, NULL),
(8, 'Xuân Hiệp, Trà Ôn, Vĩnh Long', 'Nguyễn Ngọc Hà', '215', '2034', b'1', '0862818304', '570614', 20, NULL),
(9, 'Chợ Định Hòa (Chợ Cà Nhung)', 'Nguyễn Chí Văn', '250', '1653', b'1', '0889202085', '640107', 22, NULL),
(10, 'chợ Tam Bình', 'Nguyễn Ngọc Như Quỳnh', '215', '2008', b'1', '0879586794', '570501', 21, NULL),
(11, 'Ấp 3', 'Nguyễn Gia Bảo', '215', '2008', b'1', '0889020285', '570508', 23, NULL),
(12, 'Xuân Hiệp, Trà Ôn, Vĩnh Long', 'Nguyễn Văn B', '215', '2034', b'1', '0889020285', '570614', 1, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `admin`
--

CREATE TABLE `admin` (
  `id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `admin`
--

INSERT INTO `admin` (`id`) VALUES
(11);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart`
--

CREATE TABLE `cart` (
  `id` bigint(20) NOT NULL,
  `customer_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `cart`
--

INSERT INTO `cart` (`id`, `customer_id`) VALUES
(1, NULL),
(2, NULL),
(9, NULL),
(11, NULL),
(12, NULL),
(13, NULL),
(15, NULL),
(3, 1),
(4, 2),
(5, 3),
(6, 4),
(8, 5),
(7, 6),
(16, 7),
(10, 18),
(14, 19),
(17, 20),
(19, 21),
(18, 22),
(20, 23);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart_detail`
--

CREATE TABLE `cart_detail` (
  `id` bigint(20) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `cart_id` bigint(20) DEFAULT NULL,
  `product_detail_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `cart_detail`
--

INSERT INTO `cart_detail` (`id`, `quantity`, `total`, `cart_id`, `product_detail_id`) VALUES
(97, 2, 39980000.00, 3, 49);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `conversation`
--

CREATE TABLE `conversation` (
  `id` bigint(20) NOT NULL,
  `end_time` datetime(6) DEFAULT NULL,
  `start_time` datetime(6) DEFAULT NULL,
  `receiver_account` varchar(20) DEFAULT NULL,
  `sender_account` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `coupon`
--

CREATE TABLE `coupon` (
  `id` bigint(20) NOT NULL,
  `capped_at` decimal(10,2) DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `min_spend` decimal(10,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `uses_per_coupon` int(11) DEFAULT NULL,
  `value` decimal(10,2) DEFAULT NULL,
  `employee_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customer`
--

CREATE TABLE `customer` (
  `id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `customer`
--

INSERT INTO `customer` (`id`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(18),
(19),
(20),
(21),
(22),
(23);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customer_order`
--

CREATE TABLE `customer_order` (
  `id` bigint(20) NOT NULL,
  `create_date` datetime(6) DEFAULT NULL,
  `status` enum('CREATING','PENDING_PAYMENT','PROCESSING','SHIPPED','DELIVERED','CANCELLED','REFUNDED','ON_HOLD') DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `coupon_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `payment_id` bigint(20) DEFAULT NULL,
  `shipment_id` bigint(20) DEFAULT NULL,
  `staff_id` bigint(20) DEFAULT NULL,
  `warehouse_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `customer_order`
--

INSERT INTO `customer_order` (`id`, `create_date`, `status`, `total`, `coupon_id`, `customer_id`, `payment_id`, `shipment_id`, `staff_id`, `warehouse_id`) VALUES
(1, '2024-02-05 00:43:39.000000', 'CANCELLED', 25635001.00, NULL, 1, 1, 1, 9, NULL),
(4, '2024-01-05 00:48:38.000000', 'DELIVERED', 20045001.00, NULL, 4, 4, NULL, 10, NULL),
(5, '2024-01-16 00:54:04.000000', 'DELIVERED', 287401.00, NULL, 4, 5, NULL, 9, NULL),
(6, '2024-01-17 01:01:40.000000', 'DELIVERED', 9896701.00, NULL, 2, 6, NULL, NULL, NULL),
(7, '2024-01-08 01:46:38.000000', 'DELIVERED', 23780201.00, NULL, 6, 7, 7, 15, NULL),
(8, '2024-01-08 08:55:41.000000', 'DELIVERED', 900201.00, NULL, 1, 8, 8, 10, NULL),
(9, '2024-01-10 13:11:55.000000', 'DELIVERED', 23796701.00, NULL, 1, 9, NULL, NULL, NULL),
(10, '2024-01-22 00:59:13.000000', 'DELIVERED', 23718600.00, NULL, 3, 10, 10, NULL, NULL),
(11, '2024-01-29 00:59:40.000000', 'DELIVERED', 53610800.00, NULL, 3, 11, NULL, NULL, NULL),
(12, '2024-01-13 01:00:50.000000', 'DELIVERED', 18190801.00, NULL, 1, 12, 12, NULL, NULL),
(13, '2024-01-03 01:01:15.000000', 'DELIVERED', 22596701.00, NULL, 1, 13, NULL, NULL, NULL),
(14, '2024-01-08 01:10:03.000000', 'DELIVERED', 16096701.00, NULL, 1, 14, NULL, NULL, NULL),
(15, '2024-01-08 01:10:33.000000', 'DELIVERED', 89667001.00, NULL, 1, 15, NULL, NULL, NULL),
(16, '2024-01-02 01:11:39.000000', 'DELIVERED', 65448001.00, NULL, 1, 16, 16, NULL, NULL),
(17, '2024-01-08 01:13:06.000000', 'DELIVERED', 15760201.00, NULL, 1, 17, NULL, NULL, NULL),
(18, '2024-01-08 01:13:46.000000', 'DELIVERED', 83646701.00, NULL, 1, 18, 18, NULL, NULL),
(19, '2024-01-05 01:14:06.000000', 'DELIVERED', 16080201.00, NULL, 1, 19, NULL, NULL, NULL),
(20, '2024-01-09 01:14:30.000000', 'DELIVERED', 47468001.00, NULL, 1, 20, 20, NULL, NULL),
(21, '2024-02-12 01:28:40.000000', 'DELIVERED', 50089201.00, NULL, 1, 21, NULL, NULL, NULL),
(22, '2024-02-12 01:28:58.000000', 'DELIVERED', 40035001.00, NULL, 1, 22, 22, NULL, NULL),
(23, '2024-02-08 01:29:13.000000', 'DELIVERED', 60058001.00, NULL, 1, 23, 23, NULL, NULL),
(24, '2024-02-13 01:37:33.000000', 'DELIVERED', 94044001.00, NULL, 5, 24, NULL, NULL, NULL),
(25, '2024-02-20 01:38:08.000000', 'DELIVERED', 77447801.00, NULL, 5, 25, NULL, NULL, NULL),
(26, '2024-02-13 01:38:39.000000', 'DELIVERED', 89767001.00, NULL, 5, 26, NULL, NULL, NULL),
(27, '2024-02-06 01:39:43.000000', 'DELIVERED', 71367801.00, NULL, 5, 27, NULL, NULL, NULL),
(28, '2024-04-11 01:40:19.000000', 'DELIVERED', 80950201.00, NULL, 5, 28, NULL, NULL, NULL),
(29, '2024-04-11 01:46:22.000000', 'DELIVERED', 16027401.00, NULL, 5, 29, 29, NULL, NULL),
(30, '2024-03-07 01:48:14.000000', 'DELIVERED', 80050201.00, NULL, 5, NULL, 30, NULL, NULL),
(31, '2024-03-04 02:02:50.000000', 'DELIVERED', 63960000.00, NULL, 5, 31, NULL, NULL, NULL),
(32, '2024-04-11 09:52:03.000000', 'DELIVERED', 82810201.00, NULL, 2, 32, NULL, NULL, NULL),
(33, '2024-03-12 09:53:00.000000', 'DELIVERED', 95977401.00, NULL, 2, 33, 33, NULL, NULL),
(34, '2024-03-13 09:53:36.000000', 'DELIVERED', 12450000.00, NULL, 2, 34, NULL, NULL, NULL),
(35, '2024-03-05 09:54:04.000000', 'DELIVERED', 79987401.00, NULL, 2, 49, 35, NULL, NULL),
(36, '2024-03-23 09:56:42.000000', 'DELIVERED', 51560000.00, NULL, 4, 48, 36, NULL, NULL),
(37, '2024-03-15 09:57:10.000000', 'DELIVERED', 99007401.00, NULL, 4, 47, 37, NULL, NULL),
(38, '2024-03-11 09:58:03.000000', 'DELIVERED', 90806401.00, NULL, 4, 46, 38, NULL, NULL),
(39, '2024-03-06 09:59:39.000000', 'DELIVERED', 71125001.00, NULL, 4, 39, NULL, NULL, NULL),
(40, '2024-04-11 10:00:42.000000', 'DELIVERED', 88087801.00, NULL, 3, 40, NULL, NULL, NULL),
(41, '2024-04-11 10:00:52.000000', 'DELIVERED', 87980000.00, NULL, 3, 41, NULL, NULL, NULL),
(42, '2024-04-11 10:02:37.000000', 'DELIVERED', 71160201.00, NULL, 3, 42, NULL, NULL, NULL),
(43, '2024-04-11 10:03:11.000000', 'DELIVERED', 76507401.00, NULL, 3, 43, 43, NULL, NULL),
(44, '2024-04-11 10:04:03.000000', 'DELIVERED', 71107401.00, NULL, 3, 44, 44, NULL, NULL),
(45, '2024-05-03 10:06:18.000000', 'DELIVERED', 72004801.00, NULL, 18, 45, 45, NULL, NULL),
(46, '2024-05-06 10:06:54.000000', 'DELIVERED', 28835001.00, NULL, 18, 46, NULL, NULL, NULL),
(47, '2024-05-01 10:08:36.000000', 'DELIVERED', 78375001.00, NULL, 18, 47, 47, NULL, NULL),
(48, '2024-05-05 10:11:09.000000', 'DELIVERED', 77925001.00, NULL, 1, 48, NULL, NULL, NULL),
(49, '2024-05-02 10:11:33.000000', 'DELIVERED', 28035001.00, NULL, 1, 49, 49, NULL, NULL),
(50, '2024-05-04 10:11:52.000000', 'DELIVERED', 84035001.00, NULL, 1, 50, NULL, NULL, NULL),
(51, '2024-04-11 11:05:03.000000', 'SHIPPED', 19845001.00, NULL, 1, 51, 51, 14, NULL),
(52, '2024-04-11 11:05:34.000000', 'SHIPPED', 555001.00, NULL, 1, 52, 52, 9, NULL),
(53, '2024-04-11 11:06:02.000000', 'SHIPPED', 7025201.00, NULL, 1, 53, NULL, 14, NULL),
(54, '2024-04-11 11:06:16.000000', 'PROCESSING', 1897801.00, NULL, 1, 54, NULL, NULL, NULL),
(55, '2024-04-13 20:39:51.000000', 'PROCESSING', 14096701.00, NULL, 1, 55, NULL, NULL, NULL),
(56, '2024-04-13 20:51:44.000000', 'SHIPPED', 20096701.00, NULL, 1, 56, NULL, 16, NULL),
(57, '2024-04-13 20:54:14.000000', 'PROCESSING', 23796701.00, NULL, 1, 57, NULL, NULL, NULL),
(58, '2024-04-15 22:41:34.000000', 'PROCESSING', 20043901.00, NULL, 1, 58, NULL, NULL, NULL),
(59, '2024-04-15 22:57:47.000000', 'PROCESSING', 9843901.00, NULL, 1, 59, NULL, NULL, NULL),
(60, '2024-04-19 10:34:32.000000', 'CANCELLED', 9845001.00, NULL, 19, 60, 60, 10, NULL),
(61, '2024-04-19 10:35:02.000000', 'SHIPPED', 354001.00, NULL, 19, 61, 61, 14, NULL),
(62, '2024-04-19 10:43:22.000000', 'CANCELLED', 305001.00, NULL, 19, 62, NULL, 17, NULL),
(63, '2024-04-19 10:43:33.000000', 'CANCELLED', 3545001.00, NULL, 19, 63, NULL, 16, NULL),
(64, '2024-04-19 10:43:44.000000', 'SHIPPED', 23745001.00, NULL, 19, 64, NULL, 15, NULL),
(65, '2024-04-23 21:43:52.000000', 'PROCESSING', 352901.00, NULL, 1, NULL, 65, NULL, NULL),
(66, '2024-05-02 00:06:45.000000', 'PROCESSING', 17108600.00, NULL, 5, 66, NULL, NULL, NULL),
(67, '2024-05-05 20:55:57.000000', 'PROCESSING', 33018600.00, NULL, 1, 67, NULL, NULL, NULL),
(68, '2024-05-07 20:38:03.000000', 'SHIPPED', 50052901.00, NULL, 1, NULL, 68, 15, NULL),
(69, '2024-05-08 22:28:44.000000', 'PROCESSING', 3545001.00, NULL, 23, NULL, 69, NULL, NULL),
(70, '2024-05-08 22:29:23.000000', 'PROCESSING', 14045001.00, NULL, 21, 70, 70, NULL, NULL),
(71, '2024-05-08 22:30:04.000000', 'PROCESSING', 7042801.00, NULL, 22, 71, 71, NULL, NULL),
(72, '2024-05-08 22:55:49.000000', 'DELIVERED', 23718600.00, NULL, 1, 72, 72, 9, NULL),
(73, '2024-05-08 23:48:55.000000', 'PROCESSING', 33018600.00, NULL, 1, 73, 73, NULL, NULL),
(74, '2024-05-09 10:03:44.000000', 'PROCESSING', 33018600.00, NULL, 1, 74, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `employee`
--

CREATE TABLE `employee` (
  `title` varchar(255) DEFAULT NULL,
  `id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `employee`
--

INSERT INTO `employee` (`title`, `id`) VALUES
(NULL, 9),
(NULL, 10),
(NULL, 11),
(NULL, 13),
(NULL, 14),
(NULL, 15),
(NULL, 16),
(NULL, 17);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `image_data`
--

CREATE TABLE `image_data` (
  `id` bigint(20) NOT NULL,
  `base64string` text DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `image_data`
--

INSERT INTO `image_data` (`id`, `base64string`, `type`) VALUES
(1, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307989548944936_iphone-15-promax-xanh-1.jpg', 'PRODUCT'),
(2, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055947587336314_ipad-pro-11-inch-m2-wifi-xam-1.jpg', 'PRODUCT'),
(3, 'https://cdn.hoanghamobile.com/i/preview/Uploads/2022/10/18/image-removebg-preview-54_638017091789031630.png', 'PRODUCT'),
(4, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2024/3/2/638449680115850570_oppo-reno11-f-xanh-5.png', 'PRODUCT'),
(5, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303942321093007_iphone-15-hong-1.jpg', 'PRODUCT'),
(6, 'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-1-4.jpg', 'PRODUCT'),
(7, 'https://cdn.tgdd.vn/Products/Images/57/307306/pin-sac-du-phong-10000mah-type-c-pd-samsung-eb-p3400-1.jpg', 'PRODUCT'),
(8, 'https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-xanh-1.jpg', 'PRODUCT'),
(9, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/7/11/637931467775595338_hp-15s-fq-bac-win11-1.jpg', 'PRODUCT'),
(10, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2024/1/29/638421347766418657_hp-gaming-victus-15-fb1022ax-r5-7535hs-5.jpg', 'PRODUCT'),
(11, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/5/24/637889803064747112_hp-gaming-omen-16-den-1.jpg', 'PRODUCT'),
(12, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/8/22/638283012469903137_hp-245-g10-bac-1.jpg', 'PRODUCT'),
(13, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/8/28/638288269292176880_hp-gaming-victus-16-s0078ax-r5-7640hs-3.jpg', 'PRODUCT'),
(14, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/2/2/638109508116523500_oppo-reno8-t-4g-cam-4.jpg', 'PRODUCT'),
(15, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/7/5/638241535661884488_oppo-a78-den-1.jpg', 'PRODUCT'),
(16, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/11/7/638349536350112992_oppo-find-n3-5g-vang-7.jpg', 'PRODUCT'),
(17, 'https://images.fpt.shop/unsafe/fit-in/750x500/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/8/22/638283171372247619_LEXAR-256-2.jpg', 'PRODUCT'),
(18, 'https://images.fpt.shop/unsafe/fit-in/750x500/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/12/9/638377119768865676_may-in-laser-don-nang-brother-hl-b2100d-3.jpg', 'PRODUCT'),
(19, 'https://images.fpt.shop/unsafe/fit-in/750x500/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2021/11/2/637714580251908282_pin-sac-du-phong-powergo-smart-ai-10000mah-innostyle-den-1.jpg', 'PRODUCT'),
(20, 'https://cdn.tgdd.vn/Products/Images/5697/315724/samsung-s3-s33gc-ls27c330gaexxv-27-inch-fhd-1.jpg', 'PRODUCT'),
(21, 'https://cdn.tgdd.vn/Products/Images/5697/309329/asus-va27ehf-27-inch-fhd-glr-1-1.jpg', 'PRODUCT'),
(22, 'https://cdn.tgdd.vn/Products/Images/5697/307971/msi-pro-mp223-21-45-inch-fhd-glr-1.jpg', 'PRODUCT'),
(23, 'https://cdn.tgdd.vn/Products/Images/5697/317535/hp-m22f-21-5-inch-fhd-glr-1.jpg', 'PRODUCT'),
(24, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/8/9/638271911445594813_xiaomi-redmi-watch-3-active-xam-3.jpg', 'PRODUCT'),
(25, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/4/14/638170692740868269_dong-ho-thong-minh-garmin-forerunner-965-den-5.jpg', 'PRODUCT'),
(26, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/6/638322126940324462_apple-watch-series-9-gps-41mm-hong-1.jpg', 'PRODUCT'),
(27, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/27/638314191410449941_apple-watch-series-9-gps-cellular-41mm-vien-thep-day-milanese-thep-den (1).jpg', 'PRODUCT'),
(28, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/6/638059319531382608_ipad-mini-6-wifi-xam-1.jpg', 'PRODUCT'),
(29, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/5/638058511270228916_ipad-pro-129-m1-wifi-xam-1.jpg', 'PRODUCT'),
(30, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/1/638054829629162158_ipad-gen10-109-cell-trang-1.jpg', 'PRODUCT'),
(31, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307992305419305_iphone-15-promax-xanh-vang-1.jpg', 'PRODUCT'),
(32, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303950417112947_iphone-15-xanh-la-1.jpg', 'PRODUCT'),
(33, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055950546989770_ipad-pro-11-inch-m2-wifi-bac-1.jpg', 'PRODUCT'),
(34, 'http://res.cloudinary.com/dpgavjuxz/image/upload/v1715083127/e4e44c24-0a1a-4fe3-8600-4c67fe9a759a.webp', 'PRODUCT'),
(35, 'http://res.cloudinary.com/dpgavjuxz/image/upload/v1715187582/9214c17f-df78-4089-9c18-abd43b052322.webp', 'PRODUCT'),
(36, 'http://res.cloudinary.com/dpgavjuxz/image/upload/v1715224417/1af167dc-a0b3-49f9-b05f-0702cba3bdff.webp', 'PRODUCT');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `manager`
--

CREATE TABLE `manager` (
  `id` bigint(20) NOT NULL,
  `warehouse_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `manager`
--

INSERT INTO `manager` (`id`, `warehouse_id`) VALUES
(13, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `message`
--

CREATE TABLE `message` (
  `id` bigint(20) NOT NULL,
  `content` text DEFAULT NULL,
  `time_stamp` datetime(6) DEFAULT NULL,
  `conversation_id` bigint(20) DEFAULT NULL,
  `sender_account` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `notification`
--

CREATE TABLE `notification` (
  `id` bigint(20) NOT NULL,
  `content` text DEFAULT NULL,
  `date_time` timestamp NULL DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `title` text DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_detail`
--

CREATE TABLE `order_detail` (
  `id` bigint(20) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `product_detail_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `order_detail`
--

INSERT INTO `order_detail` (`id`, `quantity`, `total`, `order_id`, `product_detail_id`) VALUES
(1, 1, 24490000.00, 1, 26),
(2, 1, 1090000.00, 1, 43),
(3, 1, 19990000.00, 4, 49),
(4, 1, 250000.00, 5, 20),
(5, 1, 9790000.00, 6, 46),
(6, 1, 23690000.00, 7, 65),
(7, 1, 900000.00, 8, 35),
(8, 1, 23690000.00, 9, 65),
(9, 1, 23690000.00, 10, 65),
(10, 1, 35584000.00, 11, 2),
(11, 1, 23690000.00, 11, 62),
(12, 1, 22890000.00, 12, 24),
(13, 1, 24446000.00, 13, 21),
(14, 1, 15990000.00, 14, 51),
(15, 2, 47120000.00, 15, 10),
(16, 1, 49999000.00, 15, 54),
(17, 2, 17980000.00, 16, 8),
(18, 2, 47380000.00, 16, 65),
(19, 2, 19580000.00, 18, 46),
(20, 4, 63960000.00, 18, 51),
(21, 1, 15990000.00, 19, 51),
(22, 2, 47380000.00, 20, 65),
(23, 1, 49999000.00, 21, 54),
(24, 2, 39980000.00, 22, 49),
(25, 3, 59970000.00, 23, 49),
(26, 1, 49999000.00, 24, 54),
(27, 1, 43990000.00, 24, 60),
(28, 3, 29370000.00, 25, 46),
(29, 3, 47970000.00, 25, 51),
(30, 1, 15990000.00, 26, 51),
(31, 1, 49999000.00, 26, 54),
(32, 1, 23690000.00, 26, 62),
(33, 2, 47380000.00, 27, 62),
(34, 1, 3490000.00, 27, 36),
(35, 1, 900000.00, 27, 35),
(36, 2, 19580000.00, 27, 46),
(37, 2, 47380000.00, 28, 62),
(38, 1, 23690000.00, 28, 65),
(39, 1, 9790000.00, 28, 46),
(40, 1, 15990000.00, 29, 51),
(41, 4, 79960000.00, 30, 49),
(42, 4, 63960000.00, 31, 51),
(43, 2, 35418000.00, 32, 15),
(44, 2, 13980000.00, 32, 29),
(45, 4, 40760000.00, 32, 27),
(46, 6, 95940000.00, 33, 51),
(47, 5, 12450000.00, 34, 42),
(48, 1, 35584000.00, 34, 1),
(49, 5, 79950000.00, 35, 51),
(50, 2, 31980000.00, 36, 51),
(51, 2, 19580000.00, 36, 46),
(52, 3, 98970000.00, 37, 5),
(53, 2, 598000.00, 38, 37),
(54, 2, 500000.00, 38, 20),
(55, 2, 71168000.00, 38, 1),
(56, 3, 71070000.00, 39, 65),
(57, 1, 23690000.00, 40, 62),
(58, 2, 87980000.00, 41, 58),
(59, 3, 71070000.00, 42, 65),
(60, 3, 76470000.00, 43, 25),
(61, 3, 71070000.00, 44, 65),
(62, 3, 59970000.00, 45, 49),
(63, 5, 4500000.00, 45, 35),
(64, 2, 6980000.00, 45, 36),
(65, 3, 897000.00, 45, 37),
(66, 1, 23560000.00, 46, 10),
(67, 1, 8990000.00, 46, 8),
(68, 8, 78320000.00, 47, 46),
(69, 3, 47970000.00, 48, 51),
(70, 10, 29900000.00, 48, 39),
(71, 2, 35418000.00, 49, 15),
(72, 2, 83980000.00, 50, 33),
(73, 1, 23560000.00, 51, 10),
(74, 2, 500000.00, 52, 20),
(75, 1, 6990000.00, 53, 29),
(76, 1, 1790000.00, 54, 41),
(77, 1, 17709000.00, 55, 15),
(78, 1, 19990000.00, 56, 49),
(79, 1, 23690000.00, 57, 62),
(80, 1, 19990000.00, 58, 49),
(81, 1, 9790000.00, 59, 46),
(82, 1, 9790000.00, 60, 46),
(83, 1, 299000.00, 61, 37),
(84, 1, 250000.00, 62, 20),
(85, 1, 3490000.00, 63, 36),
(86, 1, 23690000.00, 64, 62),
(87, 1, 299000.00, 65, 37),
(88, 1, 15990000.00, 66, 51),
(89, 1, 1090000.00, 66, 43),
(90, 1, 32990000.00, 67, 6),
(91, 1, 49999000.00, 68, 55),
(92, 1, 3490000.00, 69, 36),
(93, 1, 17709000.00, 70, 17),
(94, 1, 6990000.00, 71, 32),
(95, 1, 23690000.00, 72, 65),
(96, 1, 32990000.00, 73, 6),
(97, 1, 32990000.00, 74, 6);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment`
--

CREATE TABLE `payment` (
  `id` bigint(20) NOT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  `method` varchar(50) DEFAULT NULL,
  `payment_url` text DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `payment`
--

INSERT INTO `payment` (`id`, `amount`, `date`, `method`, `payment_url`, `status`) VALUES
(1, 25635001.00, '2024-04-04 17:43:39', 'COD', NULL, 'COD'),
(2, 287401.00, '2024-04-04 17:44:10', 'vnpay', NULL, 'PENDING'),
(3, 356701.00, '2024-04-04 17:45:08', 'vnpay', NULL, 'PENDING'),
(4, 20045001.00, '2024-04-04 17:48:38', 'COD', NULL, 'COD'),
(5, 287401.00, '2024-04-04 17:54:04', 'vnpay', NULL, 'PENDING'),
(6, 9896701.00, '2024-04-04 18:01:40', 'COD', NULL, 'COD'),
(7, 23780201.00, '2024-04-04 18:46:38', 'COD', NULL, 'COD'),
(8, 900201.00, '2024-04-05 01:55:41', 'COD', NULL, 'COD'),
(9, 23796701.00, '2024-04-05 06:11:55', 'COD', NULL, 'COD'),
(10, 23718600.00, '2024-04-10 17:59:13', 'vnpay', NULL, 'COD'),
(11, 53610800.00, '2024-04-10 17:59:40', 'COD', NULL, 'COD'),
(12, 18190801.00, '2024-04-10 18:00:50', 'COD', NULL, 'COD'),
(13, 22596701.00, '2024-04-10 18:01:15', 'COD', NULL, 'COD'),
(14, 16096701.00, '2024-04-10 18:10:03', 'COD', NULL, 'COD'),
(15, 89667001.00, '2024-04-10 18:10:33', 'COD', NULL, 'COD'),
(16, 65448001.00, '2024-04-10 18:11:39', 'COD', NULL, 'COD'),
(17, 15760201.00, '2024-04-10 18:13:06', 'COD', NULL, 'COD'),
(18, 83646701.00, '2024-04-10 18:13:46', 'COD', NULL, 'COD'),
(19, 16080201.00, '2024-04-10 18:14:06', 'COD', NULL, 'COD'),
(20, 47468001.00, '2024-04-10 18:14:30', 'COD', NULL, 'COD'),
(21, 50089201.00, '2024-04-10 18:28:40', 'COD', NULL, 'COD'),
(22, 40035001.00, '2024-04-10 18:28:58', 'COD', NULL, 'COD'),
(23, 60058001.00, '2024-04-10 18:29:13', 'vnpay', NULL, 'COD'),
(24, 94044001.00, '2024-04-10 18:37:33', 'COD', NULL, 'COD'),
(25, 77447801.00, '2024-04-10 18:38:08', 'vnpay', NULL, 'COD'),
(26, 89767001.00, '2024-04-10 18:38:39', 'COD', NULL, 'COD'),
(27, 71367801.00, '2024-04-10 18:39:43', 'COD', NULL, 'COD'),
(28, 80950201.00, '2024-04-10 18:40:19', 'COD', NULL, 'COD'),
(29, 16027401.00, '2024-04-10 18:46:22', 'COD', NULL, 'COD'),
(30, 80050201.00, '2024-04-10 18:48:14', 'vnpay', NULL, 'COD'),
(31, 63960000.00, '2024-04-10 19:02:50', 'COD', NULL, 'COD'),
(32, 82810201.00, '2024-04-11 02:52:03', 'COD', NULL, 'COD'),
(33, 95977401.00, '2024-04-11 02:53:00', 'COD', NULL, 'COD'),
(34, 12450000.00, '2024-04-11 02:53:36', 'COD', NULL, 'COD'),
(35, 79987401.00, '2024-04-11 02:54:04', 'COD', NULL, 'COD'),
(36, 51560000.00, '2024-04-11 02:56:42', 'COD', NULL, 'COD'),
(37, 99007401.00, '2024-04-11 02:57:10', 'COD', NULL, 'COD'),
(38, 90806401.00, '2024-04-11 02:58:03', 'COD', NULL, 'COD'),
(39, 71125001.00, '2024-04-11 02:59:39', 'COD', NULL, 'COD'),
(40, 88087801.00, '2024-04-11 03:00:42', 'COD', NULL, 'COD'),
(41, 87980000.00, '2024-04-11 03:00:52', 'COD', NULL, 'COD'),
(42, 71160201.00, '2024-04-11 03:02:37', 'COD', NULL, 'COD'),
(43, 76507401.00, '2024-04-11 03:03:11', 'COD', NULL, 'COD'),
(44, 71107401.00, '2024-04-11 03:04:03', 'COD', NULL, 'COD'),
(45, 72004801.00, '2024-04-11 03:06:18', 'COD', NULL, 'COD'),
(46, 28835001.00, '2024-04-11 03:06:54', 'COD', NULL, 'COD'),
(47, 78375001.00, '2024-04-11 03:08:36', 'COD', NULL, 'COD'),
(48, 77925001.00, '2024-04-11 03:11:09', 'COD', NULL, 'COD'),
(49, 28035001.00, '2024-04-11 03:11:33', 'COD', NULL, 'COD'),
(50, 84035001.00, '2024-04-11 03:11:52', 'vnpay', NULL, 'COD'),
(51, 19845001.00, '2024-04-11 04:05:03', 'COD', NULL, 'COD'),
(52, 555001.00, '2024-04-11 04:05:34', 'COD', NULL, 'COD'),
(53, 7025201.00, '2024-04-11 04:06:02', 'vnpay', NULL, 'COD'),
(54, 1897801.00, '2024-04-11 04:06:16', 'COD', NULL, 'COD'),
(55, 14096701.00, '2024-04-13 13:39:51', 'vnpay', NULL, 'COD'),
(56, 20096701.00, '2024-04-13 13:51:45', 'COD', NULL, 'COD'),
(57, 23796701.00, '2024-04-13 13:54:14', 'COD', NULL, 'COD'),
(58, 20043901.00, '2024-04-15 15:41:34', 'COD', NULL, 'COD'),
(59, 9843901.00, '2024-04-15 15:57:47', 'COD', NULL, 'COD'),
(60, 9845001.00, '2024-04-19 03:34:32', 'COD', NULL, 'COD'),
(61, 354001.00, '2024-04-19 03:35:02', 'COD', NULL, 'COD'),
(62, 305001.00, '2024-04-19 03:43:22', 'vnpay', NULL, 'COD'),
(63, 3545001.00, '2024-04-19 03:43:33', 'COD', NULL, 'COD'),
(64, 23745001.00, '2024-04-19 03:43:44', 'COD', NULL, 'COD'),
(65, 352901.00, '2024-04-23 14:43:52', 'COD', NULL, 'COD'),
(66, 17108600.00, '2024-05-01 17:06:45', 'COD', NULL, 'COD'),
(67, 33018600.00, '2024-05-05 13:55:58', 'vnpay', NULL, 'PENDING'),
(68, 50052901.00, '2024-05-07 13:38:03', 'COD', NULL, 'COD'),
(69, 3545001.00, '2024-05-08 15:28:44', 'COD', NULL, 'COD'),
(70, 14045001.00, '2024-05-08 15:29:23', 'COD', NULL, 'COD'),
(71, 7042801.00, '2024-05-08 15:30:04', 'COD', NULL, 'COD'),
(72, 23718600.00, '2024-05-08 15:55:49', 'vnpay', NULL, 'PENDING'),
(73, 33018600.00, '2024-05-08 16:48:55', 'vnpay', NULL, 'PENDING'),
(74, 33018600.00, '2024-05-09 03:03:44', 'vnpay', NULL, 'PENDING');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `post`
--

CREATE TABLE `post` (
  `id` bigint(20) NOT NULL,
  `author` varchar(255) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `imagesurl` varchar(255) DEFAULT NULL,
  `public_at` timestamp NULL DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `privilege`
--

CREATE TABLE `privilege` (
  `id` bigint(20) NOT NULL,
  `name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product`
--

CREATE TABLE `product` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `material` enum('APPLE','HP','ASUS','SAMSUNG','ACER','LENOVO','XIAOMI','OPPO','OTHER') DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `sale_percent` int(11) DEFAULT NULL,
  `type` enum('PHONE','LAPTOP','TABLET','SMARTWATCH','SCREEN','HEADPHONE','SPEAKER','PRINTER','KEYBOARD','MOUSE','OTHER') DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `imagedata_id` bigint(20) DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product`
--

INSERT INTO `product` (`id`, `created_at`, `material`, `name`, `price`, `sale_percent`, `type`, `updated_at`, `imagedata_id`, `cost`) VALUES
(1, '2024-04-03 23:46:13.000000', 'APPLE', 'Điện thoại iPhone 15 Pro Max 256GB', 35584000.00, 16, 'PHONE', NULL, 1, 35000000.00),
(2, '2024-04-04 01:09:34.000000', 'APPLE', 'iPad Pro 11 2022 M2 WiFi 512GB', 32990000.00, 0, 'TABLET', NULL, 2, 31000000.00),
(3, '2024-04-04 01:27:32.000000', 'ACER', 'Laptop Acer Aspire 7 Gaming A715 43G R8GA R5 5625U /8GB /512GB /4GB RTX3050 /144Hz /Win11 (NH.QHDSV.002)', 19363000.00, 20, 'LAPTOP', NULL, 3, 17000000.00),
(4, NULL, 'OPPO', 'OPPO Reno11 F 5G 8GB-256GB', 8990000.00, 0, 'PHONE', NULL, 4, 7800000.00),
(5, NULL, 'APPLE', 'Điện thoại iPhone 15 128GB', 23560000.00, 16, 'PHONE', NULL, 5, 21000000.00),
(6, '2024-04-04 19:27:01.000000', 'APPLE', 'Điện thoại iPhone 13 128GB', 17709000.00, 21, 'PHONE', NULL, 6, 14500000.00),
(7, '2024-04-04 19:57:25.000000', 'SAMSUNG', 'Pin sạc dự phòng 10000 mAh Type C PD 25W Samsung EB-P3400', 250000.00, 0, 'OTHER', NULL, 7, 175000.00),
(8, '2024-04-04 20:04:05.000000', 'XIAOMI', 'Điện thoại Xiaomi 14 5G 512GB', 24446000.00, 8, 'PHONE', NULL, 8, 22500000.00),
(9, NULL, 'HP', 'Laptop HP 15s-fq5144TU i7 1255U /16GB /512GB /15.6\"FHD /Win11', 22890000.00, 21, 'LAPTOP', NULL, 9, 20000000.00),
(10, '2024-04-04 21:05:55.000000', 'HP', 'Laptop HP Gaming Victus 15-fb1022AX R5 7535HS /16GB /512GB /15.6\'\'FHD /NVIDIA RTX2050 4GB /Win11', 25490000.00, 0, 'LAPTOP', NULL, 10, 22350000.00),
(11, '2024-04-04 21:10:52.000000', 'HP', 'Laptop HP Gaming OMEN 16-b0176TX i7 11800H /16GB /1TB /16.1\"FHD /GeForce RTX 3060 6GB /Win 11', 24490000.00, 0, 'LAPTOP', NULL, 11, 22600000.00),
(12, '2024-04-04 21:18:07.000000', 'HP', 'Laptop HP 245 G10 R5 7520U /8GB /256GB /14\"FHD /Win11 (8F154PA)', 10190000.00, 0, 'LAPTOP', NULL, 12, 8750000.00),
(13, '2024-04-04 21:21:09.000000', 'HP', 'Laptop HP Gaming Victus 16-s0078AX R5-7640HS /16GB /512GB /16.1\"FHD /Nvidia RTX3050 6GB /Win11', 22490000.00, 0, 'LAPTOP', NULL, 13, 18900000.00),
(14, '2024-04-04 21:46:31.000000', 'OPPO', 'OPPO Reno8 T 4G 256GB', 6990000.00, 0, 'PHONE', NULL, 14, 5500000.00),
(15, '2024-04-04 21:51:31.000000', 'OPPO', 'OPPO A78 8GB-256GB', 6990000.00, 0, 'PHONE', NULL, 15, 3600000.00),
(16, '2024-04-04 21:58:39.000000', 'OPPO', 'OPPO Find N3 5G 16GB-512GB', 41990000.00, 0, 'PHONE', NULL, 16, 35500000.00),
(17, NULL, 'OTHER', 'Thẻ nhớ MicroSD 256GB Lexar Class 10', 900000.00, 10, 'OTHER', NULL, 17, 690000.00),
(18, '2024-04-04 22:15:49.000000', 'OTHER', 'Máy in laser đơn năng Brother HL-B2100D', 3490000.00, 0, 'OTHER', NULL, 18, 3250000.00),
(19, '2024-04-04 22:19:28.000000', 'OTHER', 'Pin sạc dự phòng Innostyle PowerGo Smart Ai 10000mAh', 299000.00, 0, 'OTHER', NULL, 19, 200000.00),
(20, '2024-04-04 22:40:30.000000', 'SAMSUNG', 'Màn hình Samsung S3 S33GC LS27C330GAEXXV 27 inch FHD /IPS /100Hz /4ms /HDMI', 2990000.00, 0, 'SCREEN', NULL, 20, 2367000.00),
(21, '2024-04-04 22:45:58.000000', 'ASUS', 'Màn hình Asus VA27EHF 27 inch FHD /IPS /100Hz /1ms /HDMI', 3090000.00, 0, 'SCREEN', NULL, 21, 2000000.00),
(22, '2024-04-04 22:51:28.000000', 'OTHER', 'Màn hình MSI PRO MP223 21.45 inch FHD /VA /100Hz /1ms /HDMI', 1790000.00, 0, 'SCREEN', NULL, 22, 1250000.00),
(23, '2024-04-04 22:55:11.000000', 'HP', 'Màn hình HP M22f 21.5 inch FHD /IPS /75Hz /5ms /AMD FreeSync /HDMI /VGA', 2490000.00, 0, 'SCREEN', NULL, 23, 1950000.00),
(24, '2024-04-04 23:10:46.000000', 'XIAOMI', 'Đồng hồ thông minh Xiaomi Redmi Watch 3 Active', 1090000.00, 0, 'SMARTWATCH', NULL, 24, 890000.00),
(25, NULL, 'OTHER', 'Đồng hồ thông minh Garmin Forerunner 965', 15670000.00, 0, 'SMARTWATCH', NULL, 25, 11485000.00),
(26, '2024-04-04 23:25:30.000000', 'APPLE', 'Apple Watch Series 9 GPS 41mm Viền nhôm Dây cao su cỡ S/M', 9790000.00, 0, 'SMARTWATCH', NULL, 26, 8150000.00),
(27, '2024-04-04 23:36:56.000000', 'APPLE', 'Apple Watch Series 9 GPS + Cellular 41mm Viền thép Dây Milanese thép', 19990000.00, 0, 'SMARTWATCH', NULL, 27, 17800000.00),
(28, '2024-04-04 23:43:15.000000', 'APPLE', 'iPad mini 6 2021 8.3 inch WiFi 256GB', 15990000.00, 0, 'TABLET', NULL, 28, 13650000.00),
(29, '2024-04-04 23:51:55.000000', 'APPLE', 'iPad Pro 12.9 2021 M1 Wi-Fi 1TB', 49999000.00, 0, 'TABLET', NULL, 29, 39600000.00),
(30, '2024-04-04 23:51:55.000000', 'APPLE', 'iPad Gen 10 2022 10.9 inch WiFi 64GB', 14590000.00, 0, 'TABLET', NULL, 30, 10500000.00),
(31, '2024-04-05 00:10:44.000000', 'APPLE', 'Điện thoại iPhone 15 Pro Max 1TB', 43990000.00, 0, 'PHONE', NULL, 31, 35650000.00),
(32, '2024-04-05 00:17:33.000000', 'APPLE', 'Điện thoại iPhone 15 256GB', 23690000.00, 0, 'PHONE', NULL, 32, 20500000.00),
(33, '2024-04-05 00:33:11.000000', 'APPLE', 'iPad Pro 11 2022 M2 WiFi 256GB', 23690000.00, 0, 'TABLET', NULL, 33, 18500000.00),
(38, '2024-05-09 10:13:32.000000', 'SAMSUNG', 'Samsung Galaxy S24 Ultra 5G 256GB', 26890000.00, 0, 'PHONE', '2024-05-09 10:13:36.000000', 36, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_detail`
--

CREATE TABLE `product_detail` (
  `id` bigint(20) NOT NULL,
  `color` varchar(255) DEFAULT NULL,
  `color_image` varchar(255) DEFAULT NULL,
  `image_link` text DEFAULT NULL,
  `image_links` text DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `size` varchar(255) DEFAULT NULL,
  `sold` int(11) NOT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product_detail`
--

INSERT INTO `product_detail` (`id`, `color`, `color_image`, `image_link`, `image_links`, `quantity`, `size`, `sold`, `unit`, `product_id`) VALUES
(1, 'Titan Xanh', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-pro-finish-bluetitanium-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692895385157', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307989548944936_iphone-15-promax-xanh-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307989548164135_iphone-15-promax-xanh-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307989547694968_iphone-15-promax-xanh-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307989548632428_iphone-15-promax-xanh-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980087329808_iphone-15-promax-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980086696914_iphone-15-promax-6.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980087009486_iphone-15-promax-7.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307989548007937_iphone-15-promax-xanh-9.jpg', 100, '256GB', 21, NULL, 1),
(2, 'Titan Đen', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-pro-finish-blacktitanium-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692895384718', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980220145280_iphone-15-promax-den-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980219675778_iphone-15-promax-den-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980219357093_iphone-15-promax-den-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980220145280_iphone-15-promax-den-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980087329808_iphone-15-promax-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980086696914_iphone-15-promax-6.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980087009486_iphone-15-promax-7.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980087009486_iphone-15-promax-8.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980219675778_iphone-15-promax-den-9.jpg', 85, '256GB', 32, NULL, 1),
(3, 'Titan tự nhiên', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-pro-finish-naturaltitanium-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692895385156', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307992305419305_iphone-15-promax-xanh-vang-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307992304365855_iphone-15-promax-xanh-vang-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307992301539390_iphone-15-promax-vang-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307992303272057_iphone-15-promax-vang-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980087329808_iphone-15-promax-5.jpg', 65, '256GB', 25, NULL, 1),
(4, 'Titan Trắng', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-pro-finish-whitetitanium-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692895385155', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307982103040290_iphone-15-promax-trang-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307982102230644_iphone-15-promax-trang-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307982102074523_iphone-15-promax-trang-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307982102543210_iphone-15-promax-trang-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980087329808_iphone-15-promax-5.jpg', 120, '256GB', 110, NULL, 1),
(5, 'Xám', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-pro-finish-space-gray-2022?wid=208&amp;hei=208&amp;fmt=png-alpha&amp;.v=1668031205892', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055947587336314_ipad-pro-11-inch-m2-wifi-xam-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055947587658876_ipad-pro-11-inch-m2-wifi-xam-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055947587502128_ipad-pro-11-inch-m2-wifi-xam-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055947586541793_ipad-pro-11-inch-m2-wifi-xam-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055947587336314_ipad-pro-11-inch-m2-wifi-xam-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055947590518785_ipad-pro-11-inch-m2-wifi-xam-8.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055947588715689_ipad-pro-11-inch-m2-wifi-xam-7.jpg', 70, '512GB', 62, NULL, 2),
(6, 'Bạc', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-pro-finish-silver-2022?wid=204&amp;hei=204&amp;fmt=png-alpha&amp;.v=1668031205682', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055950546989770_ipad-pro-11-inch-m2-wifi-bac-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055950545701876_ipad-pro-11-inch-m2-wifi-bac-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055950547128348_ipad-pro-11-inch-m2-wifi-bac-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055950545880787_ipad-pro-11-inch-m2-wifi-bac-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055950546314904_ipad-pro-11-inch-m2-wifi-bac-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055950545580916_ipad-pro-11-inch-m2-wifi-bac-6.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055950547491978_ipad-pro-11-inch-m2-wifi-bac-7.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055950548553280_ipad-pro-11-inch-m2-wifi-bac-8.jpg', 150, '512GB', 121, NULL, 2),
(7, 'Đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2Z9kjVe0xeB62HR1HQOLUabj07oZs4wjFjA&s', NULL, 'https://cdn.hoanghamobile.com/i/preview/Uploads/2022/10/18/image-removebg-preview-54_638017091789031630.png, https://cdn.hoanghamobile.com/i/preview/Uploads/2022/10/18/image-removebg-preview-53_638017091789031630.png, https://cdn.hoanghamobile.com/i/productlist/dsp/Uploads/2022/10/18/image-removebg-preview-55.png', 200, '512GB', 124, NULL, 3),
(8, 'Xanh', 'https://www.oppo.com/content/dam/oppo/product-asset-library/reno/reno11-series/en/reno11-f-5g/v2/assets/images-design-mzl-btn-1-mo-1.svg', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2024/3/2/638449680115850570_oppo-reno11-f-xanh-5.png, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2024/3/1/638449310772181204_oppo-reno11-f-xanh-1.png, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2024/3/2/638449680115381811_oppo-reno11-f-xanh-4.png, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2024/3/2/638449680115694374_oppo-reno11-f-xanh-2.png, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2024/3/1/638449310771253150_oppo-reno11-f-xanh-3.png', 250, '256GB', 126, NULL, 4),
(9, 'Xanh Đen', 'https://www.oppo.com/content/dam/oppo/product-asset-library/reno/reno11-series/en/reno11-f-5g/v2/assets/images-design-mzl-btn-2-mo-1.svg', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2024/3/2/638449680115850570_oppo-reno11-f-xanh-den-5.png, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2024/3/1/638449312178509644_oppo-reno11-f-xanh-den-2.png, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2024/3/2/638449680115225500_oppo-reno11-f-xanh-den-4.png, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2024/3/2/638449680115850570_oppo-reno11-f-xanh-den-3.png, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2024/3/1/638449312176817062_oppo-reno11-f-xanh-den-1.png', 130, '256GB', 120, NULL, 4),
(10, 'Hồng', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-pink-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831506843', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303942321093007_iphone-15-hong-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303942320468016_iphone-15-hong-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657239008_iphone-15-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657714445_iphone-15-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-6.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-7.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657395275_iphone-15-8.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303942320311782_iphone-15-hong-9.jpg, ', 140, '128GB', 50, NULL, 5),
(11, 'Xanh lá', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-green-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831507021', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303950417112947_iphone-15-xanh-la-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303950416510178_iphone-15-xanh-la-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657239008_iphone-15-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657714445_iphone-15-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-6.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-7.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657395275_iphone-15-8.jpg', 140, '128GB', 68, NULL, 5),
(12, 'Đen', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-black-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831506982', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303947974016720_iphone-15-den-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303947975273507_iphone-15-den-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657239008_iphone-15-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657714445_iphone-15-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-6.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-7.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657395275_iphone-15-8.jpg', 140, '128GB', 132, NULL, 5),
(13, 'Xanh Dương', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-blue-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831507035', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935769505085_iphone-15-xanh-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935769184945_iphone-15-xanh-2.jpg\r\n', 140, '128GB', 25, NULL, 5),
(14, 'Vàng', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-yellow-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831505426', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303944832321476_iphone-15-vang-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303944831540229_iphone-15-vang-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657239008_iphone-15-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657714445_iphone-15-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-6.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-7.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657395275_iphone-15-8.jpg', 140, '128GB', 29, NULL, 5),
(15, 'Trắng', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-finish-starlight-202108?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1630016970000', NULL, 'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-1-4.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-2-3.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-3-3.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-4-3.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-5-3.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-6-3.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-7-3.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-11-3.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-12-3.jpg', 200, '128GB', 157, NULL, 6),
(16, 'Đen', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-finish-midnight-202108?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1630016969000', NULL, 'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-1-2.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-2-1.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-3-1.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-4-1.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-5-1.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-6-1.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-10-1.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-11-1.jpg, //cdn.tgdd.vn/Products/Images/42/223602/iphone-13-12-1.jpg', 250, '128GB', 56, NULL, 6),
(17, 'Hồng', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-finish-pink-202108?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1630016970000', NULL, 'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-1-3.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-2-2.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-3-2.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-4-2.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-5-2.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-6-2.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-10-2.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-11-2.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-12-2.jpg, ', 150, '128GB', 88, NULL, 6),
(18, 'Xanh Lá', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-finish-green-202203?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1645218698057', NULL, 'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-glr-1.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-glr-2.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-glr-3.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-glr-4.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-glr-5.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-glr-6.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-glr-7.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-glr-8.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-glr-9.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-glr-11.jpg,', 300, '128GB', 190, NULL, 6),
(19, 'Xanh Dương', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-finish-blue-202108?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1630016970000', NULL, 'https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-1.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-2.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-3.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-4.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-5.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-6.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-7.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-7.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-8.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-9.jpg, https://cdn.tgdd.vn/Products/Images/42/223602/iphone-13-xanh-12.jpg,', 400, '128GB', 350, NULL, 6),
(20, 'Kem', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-finish-starlight-202108?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1630016970000', NULL, 'https://cdn.tgdd.vn/Products/Images/57/307306/pin-sac-du-phong-10000mah-type-c-pd-samsung-eb-p3400-1.jpg', 120, '10000 mAh', 75, NULL, 7),
(21, 'Xanh Lá', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-finish-green-202203?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1645218698057', NULL, 'https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-xanh-1.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-xanh-2.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-xanh-3.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-xanh-4.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-xanh-5.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-xanh-6.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-xanh-7.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-xanh-8.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-xanh-9.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-xanh-10.jpg', 500, '512GB', 410, NULL, 8),
(22, 'Đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2Z9kjVe0xeB62HR1HQOLUabj07oZs4wjFjA&s', NULL, 'https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-den-1.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-den-2.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-den-3.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-den-4.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-den-5.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-den-6.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-den-7.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-den-8.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-den-9.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-den-10.jpg,', 600, '512GB', 400, NULL, 8),
(23, 'Trắng', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-finish-starlight-202108?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1630016970000', NULL, 'https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-trang-1.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-trang-2.jpg,\r\nhttps://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-trang-3.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-trang-4.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-trang-5.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-trang-6.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-trang-7.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-trang-8.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-trang-9.jpg, https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-trang-10.jpg,', 500, '512GB', 450, NULL, 8),
(24, 'Bạc', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-pro-finish-silver-2022?wid=204&amp;hei=204&amp;fmt=png-alpha&amp;.v=1668031205682', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/7/11/637931467775595338_hp-15s-fq-bac-win11-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/7/11/637931467775282867_hp-15s-fq-bac-win11-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/7/11/637931467775282867_hp-15s-fq-bac-win11-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/7/11/637931467774345435_hp-15s-fq-bac-win11-4.jpg', 100, '512GB', 45, NULL, 9),
(25, 'Đen', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-black-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831506982', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2024/1/29/638421347766418657_hp-gaming-victus-15-fb1022ax-r5-7535hs-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2024/1/29/638421347766418657_hp-gaming-victus-15-fb1022ax-r5-7535hs-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2024/1/29/638421347766418657_hp-gaming-victus-15-fb1022ax-r5-7535hs-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2024/1/29/638421347765949142_hp-gaming-victus-15-fb1022ax-r5-7535hs-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2024/1/29/638421347765479312_hp-gaming-victus-15-fb1022ax-r5-7535hs-1.jpg', 200, '512GB', 12, NULL, 10),
(26, 'Đen', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-black-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831506982', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/5/24/637889803064747112_hp-gaming-omen-16-den-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/5/24/637889803064591061_hp-gaming-omen-16-den-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/5/24/637889803064747112_hp-gaming-omen-16-den-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/5/24/637889803064591061_hp-gaming-omen-16-den-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/5/24/637889803064591061_hp-gaming-omen-16-den-5.jpg, ', 150, '1TB', 23, NULL, 11),
(27, 'Bạc', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-pro-finish-silver-2022?wid=204&amp;hei=204&amp;fmt=png-alpha&amp;.v=1668031205682', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/8/22/638283012469903137_hp-245-g10-bac-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/8/22/638283012469903137_hp-245-g10-bac-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/8/22/638283012469903137_hp-245-g10-bac-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/8/22/638283012468774377_hp-245-g10-bac-4.jpg, ', 200, '256GB', 12, NULL, 12),
(28, 'Đen', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-black-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831506982', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/8/28/638288269292176880_hp-gaming-victus-16-s0078ax-r5-7640hs-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/8/28/638288269292496272_hp-gaming-victus-16-s0078ax-r5-7640hs-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/8/28/638288269292496272_hp-gaming-victus-16-s0078ax-r5-7640hs-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/8/28/638288269291864254_hp-gaming-victus-16-s0078ax-r5-7640hs-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/8/28/638288269292496272_hp-gaming-victus-16-s0078ax-r5-7640hs-1.jpg, ', 40, '512GB', 15, NULL, 13),
(29, 'Cam', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/MWNA3_SW_COLOR?wid=64&hei=64&fmt=jpeg&qlt=90&.v=1707946383474', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/2/2/638109508116523500_oppo-reno8-t-4g-cam-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/2/2/638109508108251467_oppo-reno8-t-4g-cam-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/1/30/638106973187152721_oppo-reno8-t-4g-cam-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/1/30/638106973185404344_oppo-reno8-t-4g-cam-1.jpg', 320, '256GB', 35, NULL, 14),
(30, 'Đen', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-black-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831506982', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/2/2/638109518679725316_oppo-reno8-t-4g-den-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/2/2/638109518678425077_oppo-reno8-t-4g-den-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/1/30/638106969904277336_oppo-reno8-t-4g-den-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/2/2/638109518684860017_oppo-reno8-t-4g-den-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/1/30/638106969903053322_oppo-reno8-t-4g-den-1.jpg', 350, '256GB', 285, NULL, 14),
(31, 'Đen', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-black-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831506982', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/7/5/638241535661884488_oppo-a78-den-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/7/5/638241535661884488_oppo-a78-den-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/7/5/638241535662353179_oppo-a78-den-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/7/5/638241535662040806_oppo-a78-den-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/7/5/638241535661318293_oppo-a78-den-2.jpg', 200, '256GB', 100, NULL, 15),
(32, 'Xanh Lá', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/MWNC3_SW_COLOR?wid=64&hei=64&fmt=jpeg&qlt=90&.v=1707946383513', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/7/5/638241536485827638_oppo-a78-xanh-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/7/5/638241536484874637_oppo-a78-xanh-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/7/5/638241536484037173_oppo-a78-xanh-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/7/5/638241536485031136_oppo-a78-xanh-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/7/5/638241537490385189_oppo-a78-xanh-2.jpg', 350, '256GB', 159, NULL, 15),
(33, 'Vàng', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-yellow-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831505426', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/11/7/638349536350112992_oppo-find-n3-5g-vang-7.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/19/638333314892594748_oppo-find-n3-5g-vang-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/19/638333314892594748_oppo-find-n3-5g-vang-6.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/19/638333314891969791_oppo-find-n3-5g-vang-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/19/638333314892594748_oppo-find-n3-5g-vang-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/19/638333314892594748_oppo-find-n3-5g-vang-2.jpg', 30, '512GB', 8, NULL, 16),
(34, 'Đen', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-black-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831506982', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/11/7/638349536349641250_oppo-find-n3-5g-den-7.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/19/638333556945857459_oppo-find-n3-5g-den-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/19/638333556951381540_oppo-find-n3-5g-den-6.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/19/638333556947255997_oppo-find-n3-5g-den-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/19/638333556945544781_oppo-find-n3-5g-den-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/19/638333556944131890_oppo-find-n3-5g-den-3.jpg', 30, '512GB', 10, NULL, 16),
(35, 'Đen', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-black-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831506982', NULL, 'https://images.fpt.shop/unsafe/fit-in/750x500/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/8/22/638283171372247619_LEXAR-256-2.jpg, https://images.fpt.shop/unsafe/fit-in/750x500/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/8/22/638283171372144754_LEXAR-256-1.jpg', 10, '256GB', 2, NULL, 17),
(36, 'Bạc', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-pro-finish-silver-2022?wid=204&amp;hei=204&amp;fmt=png-alpha&amp;.v=1668031205682', NULL, 'https://images.fpt.shop/unsafe/fit-in/750x500/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/12/9/638377119768865676_may-in-laser-don-nang-brother-hl-b2100d-3.jpg, https://images.fpt.shop/unsafe/fit-in/750x500/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/12/9/638377119768865676_may-in-laser-don-nang-brother-hl-b2100d-2.jpg, https://images.fpt.shop/unsafe/fit-in/750x500/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/12/9/638377119769178204_may-in-laser-don-nang-brother-hl-b2100d-1.jpg', 10, '34 trang/phút', 1, NULL, 18),
(37, 'Đen', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-black-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831506982', NULL, 'https://images.fpt.shop/unsafe/fit-in/750x500/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2021/11/2/637714580251908282_pin-sac-du-phong-powergo-smart-ai-10000mah-innostyle-den-1.jpg, https://images.fpt.shop/unsafe/fit-in/750x500/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2021/11/2/637714580251908282_pin-sac-du-phong-powergo-smart-ai-10000mah-innostyle-den-3.jpg, https://images.fpt.shop/unsafe/fit-in/750x500/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2021/11/2/637714580252377010_pin-sac-du-phong-powergo-smart-ai-10000mah-innostyle-den-2.jpg', 10, '10000mAh', 5, NULL, 19),
(38, 'Trắng', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-finish-starlight-202108?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1630016970000', NULL, 'https://images.fpt.shop/unsafe/fit-in/750x500/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2021/11/2/637714578492520331_pin-sac-du-phong-powergo-smart-ai-10000mah-innostyle-trang-1.jpg, ', 10, '10000mAh', 3, NULL, 19),
(39, 'Đen', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-black-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831506982', NULL, 'https://cdn.tgdd.vn/Products/Images/5697/315724/samsung-s3-s33gc-ls27c330gaexxv-27-inch-fhd-1.jpg, https://cdn.tgdd.vn/Products/Images/5697/315724/samsung-s3-s33gc-ls27c330gaexxv-27-inch-fhd-4.jpg, https://cdn.tgdd.vn/Products/Images/5697/315724/samsung-s3-s33gc-ls27c330gaexxv-27-inch-fhd-6.jpg, https://cdn.tgdd.vn/Products/Images/5697/315724/samsung-s3-s33gc-ls27c330gaexxv-27-inch-fhd-7.jpg, https://cdn.tgdd.vn/Products/Images/5697/315724/samsung-s3-s33gc-ls27c330gaexxv-27-inch-fhd-8.jpg', 60, '27inch', 17, NULL, 20),
(40, 'Đen', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-black-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831506982', NULL, 'https://cdn.tgdd.vn/Products/Images/5697/309329/asus-va27ehf-27-inch-fhd-glr-1-1.jpg, https://cdn.tgdd.vn/Products/Images/5697/309329/asus-va27ehf-27-inch-fhd-glr-2-1.jpg, https://cdn.tgdd.vn/Products/Images/5697/309329/asus-va27ehf-27-inch-fhd-glr-3-1.jpg, https://cdn.tgdd.vn/Products/Images/5697/309329/asus-va27ehf-27-inch-fhd-glr-4-1.jpg, https://cdn.tgdd.vn/Products/Images/5697/309329/asus-va27ehf-27-inch-fhd-glr-5-1.jpg, https://cdn.tgdd.vn/Products/Images/5697/309329/asus-va27ehf-27-inch-fhd-glr-6.jpg, https://cdn.tgdd.vn/Products/Images/5697/309329/asus-va27ehf-27-inch-fhd-glr-7.jpg, ', 70, '27inch', 28, NULL, 21),
(41, 'Đen', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-black-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831506982', NULL, 'https://cdn.tgdd.vn/Products/Images/5697/307971/msi-pro-mp223-21-45-inch-fhd-glr-1.jpg, https://cdn.tgdd.vn/Products/Images/5697/307971/msi-pro-mp223-21-45-inch-fhd-glr-2.jpg, https://cdn.tgdd.vn/Products/Images/5697/307971/msi-pro-mp223-21-45-inch-fhd-glr-3.jpg, https://cdn.tgdd.vn/Products/Images/5697/307971/msi-pro-mp223-21-45-inch-fhd-glr-4.jpg, https://cdn.tgdd.vn/Products/Images/5697/307971/msi-pro-mp223-21-45-inch-fhd-glr-5.jpg, https://cdn.tgdd.vn/Products/Images/5697/307971/msi-pro-mp223-21-45-inch-fhd-glr-6.jpg, https://cdn.tgdd.vn/Products/Images/5697/307971/msi-pro-mp223-21-45-inch-fhd-glr-7.jpg, https://cdn.tgdd.vn/Products/Images/5697/307971/msi-pro-mp223-21-45-inch-fhd-glr-8.jpg, ', 60, '21.45inch', 24, NULL, 22),
(42, 'Đen', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-black-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831506982', NULL, 'https://cdn.tgdd.vn/Products/Images/5697/317535/hp-m22f-21-5-inch-fhd-glr-1.jpg, https://cdn.tgdd.vn/Products/Images/5697/317535/hp-m22f-21-5-inch-fhd-glr-2.jpg, https://cdn.tgdd.vn/Products/Images/5697/317535/hp-m22f-21-5-inch-fhd-glr-3.jpg, https://cdn.tgdd.vn/Products/Images/5697/317535/hp-m22f-21-5-inch-fhd-glr-4.jpg, https://cdn.tgdd.vn/Products/Images/5697/317535/hp-m22f-21-5-inch-fhd-glr-5.jpg, https://cdn.tgdd.vn/Products/Images/5697/317535/hp-m22f-21-5-inch-fhd-glr-6.jpg, https://cdn.tgdd.vn/Products/Images/5697/317535/hp-m22f-21-5-inch-fhd-glr-7.jpg, https://cdn.tgdd.vn/Products/Images/5697/317535/hp-m22f-21-5-inch-fhd-glr-8.jpg, ', 80, '21.5inch', 71, NULL, 23),
(43, 'Đen', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-black-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831506982', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/8/9/638271911445594813_xiaomi-redmi-watch-3-active-xam-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/8/9/638271911444946352_xiaomi-redmi-watch-3-active-xam-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/8/9/638271911444866398_xiaomi-redmi-watch-3-active-xam-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/8/9/638271911445226443_xiaomi-redmi-watch-3-active-xam-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/8/9/638271911445546202_xiaomi-redmi-watch-3-active-xam-1.jpg', 200, '1.83inch', 113, NULL, 24),
(44, 'Đen', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-black-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831506982', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/4/14/638170692740868269_dong-ho-thong-minh-garmin-forerunner-965-den-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/4/14/638170692740969078_dong-ho-thong-minh-garmin-forerunner-965-den-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/4/14/638170692741647824_dong-ho-thong-minh-garmin-forerunner-965-den-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/4/14/638170692740969078_dong-ho-thong-minh-garmin-forerunner-965-den-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/4/14/638170692740868269_dong-ho-thong-minh-garmin-forerunner-965-den-3.jpg', 100, '1.4inch', 12, NULL, 25),
(45, 'Trắng', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-finish-starlight-202108?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1630016970000', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/4/14/638170841340350024_dong-ho-thong-minh-garmin-forerunner-965-trang-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/4/14/638170841340037466_dong-ho-thong-minh-garmin-forerunner-965-trang-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/4/14/638170841340037466_dong-ho-thong-minh-garmin-forerunner-965-trang-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/4/14/638170841340662558_dong-ho-thong-minh-garmin-forerunner-965-trang-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/4/14/638170841339723624_dong-ho-thong-minh-garmin-forerunner-965-trang-2.jpg', 100, '1.4inch', 14, NULL, 25),
(46, 'Hồng', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/MWEE3ref_SW_COLOR?wid=64&hei=64&fmt=jpeg&qlt=90&.v=1707792928577', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/6/638322126940324462_apple-watch-series-9-gps-41mm-hong-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/6/638322126940324462_apple-watch-series-9-gps-41mm-hong-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/6/638322126940168291_apple-watch-series-9-gps-41mm-hong-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/6/638322123023435762_apple-watch-series-9-gps-41mm-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/6/638322123023903949_apple-watch-series-9-gps-41mm-5.jpg', 100, '41mm-SM', 80, NULL, 26),
(47, 'Bạc', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/MUHA3ref_SW_COLOR?wid=64&hei=64&fmt=jpeg&qlt=90&.v=1693005423915', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/6/638322123257868629_apple-watch-series-9-gps-41mm-bac-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/6/638322123258024961_apple-watch-series-9-gps-41mm-bac-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/6/638322123257868629_apple-watch-series-9-gps-41mm-bac-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/6/638322123023435762_apple-watch-series-9-gps-41mm-4.jpg', 100, '45mm-S/M', 70, NULL, 26),
(48, 'Vàng', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ML733_SW_COLOR?wid=64&hei=64&fmt=jpeg&qlt=90&.v=1630084574000', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/6/638322124720746079_apple-watch-series-9-gps-41mm-vang-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/6/638322124720902278_apple-watch-series-9-gps-41mm-vang-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/6/638322124721995982_apple-watch-series-9-gps-41mm-vang-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/6/638322123023435762_apple-watch-series-9-gps-41mm-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/6/638322124720902278_apple-watch-series-9-gps-41mm-vang-6.jpg', 100, '45mm-S/M', 58, NULL, 26);
INSERT INTO `product_detail` (`id`, `color`, `color_image`, `image_link`, `image_links`, `quantity`, `size`, `sold`, `unit`, `product_id`) VALUES
(49, 'Đen', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-black-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831506982', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/27/638314191410449941_apple-watch-series-9-gps-cellular-41mm-vien-thep-day-milanese-thep-den (1).jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/27/638314191408408229_apple-watch-series-9-gps-cellular-41mm-vien-thep-day-milanese-thep-den (2).jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/27/638314191409658258_apple-watch-series-9-gps-cellular-41mm-vien-thep-day-milanese-thep-den (3).jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/27/638314191409658258_apple-watch-series-9-gps-cellular-41mm-vien-thep-day-milanese-thep-den (4).jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/27/638314191409814472_apple-watch-series-9-gps-cellular-41mm-vien-thep-day-milanese-thep-den (5).jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/27/638314191409501960_apple-watch-series-9-gps-cellular-41mm-vien-thep-day-milanese-thep-den (6).jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/27/638314191410618725_apple-watch-series-9-gps-cellular-41mm-vien-thep-day-milanese-thep-den (7).jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/27/638314191411868878_apple-watch-series-9-gps-cellular-41mm-vien-thep-day-milanese-thep-den (8).jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/27/638314191412962673_apple-watch-series-9-gps-cellular-41mm-vien-thep-day-milanese-thep-den (9).jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/27/638314191413431335_apple-watch-series-9-gps-cellular-41mm-vien-thep-day-milanese-thep-den (10).jpg', 100, '41mm', 23, NULL, 27),
(50, 'Vàng', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ML733_SW_COLOR?wid=64&hei=64&fmt=jpeg&qlt=90&.v=1630084574000', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/27/638314192379251689_apple-watch-series-9-gps-cellular-41mm-vien-thep-day-milanese-thep-vang (1).jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/27/638314192378183092_apple-watch-series-9-gps-cellular-41mm-vien-thep-day-milanese-thep-vang (2).jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/27/638314192378939209_apple-watch-series-9-gps-cellular-41mm-vien-thep-day-milanese-thep-vang (3).jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/27/638314192378495612_apple-watch-series-9-gps-cellular-41mm-vien-thep-day-milanese-thep-vang (4).jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/27/638314192379720443_apple-watch-series-9-gps-cellular-41mm-vien-thep-day-milanese-thep-vang (5).jpg', 100, '41mm', 11, NULL, 27),
(51, 'Xám', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-pro-finish-space-gray-2022?wid=208&amp;hei=208&amp;fmt=png-alpha&amp;.v=1668031205892', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/6/638059319531382608_ipad-mini-6-wifi-xam-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/6/638059319531682592_ipad-mini-6-wifi-xam-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/6/638059319531657137_ipad-mini-6-wifi-xam-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/6/638059319531382608_ipad-mini-6-wifi-xam-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/6/638059319532141743_ipad-mini-6-wifi-xam-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/6/638059319531070180_ipad-mini-6-wifi-xam-6.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/6/638059319533711679_ipad-mini-6-wifi-xam-7.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/6/638059319534812324_ipad-mini-6-wifi-xam-8.jpg', 30, '256GB', 10, NULL, 28),
(52, 'Vàng', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ML733_SW_COLOR?wid=64&hei=64&fmt=jpeg&qlt=90&.v=1630084574000', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/6/638059317253580936_ipad-mini-6-wifi-trang-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/6/638059317253906831_ipad-mini-6-wifi-trang-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/6/638059317253503125_ipad-mini-6-wifi-trang-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/6/638059317253743558_ipad-mini-6-wifi-trang-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/6/638059317255014468_ipad-mini-6-wifi-trang-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/6/638059317253502557_ipad-mini-6-wifi-trang-6.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/6/638059317256199052_ipad-mini-6-wifi-trang-7.jpg', 10, '256GB', 4, NULL, 28),
(53, 'Hồng', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-finish-pink-202108?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1630016970000', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/6/638059313570329429_ipad-mini-6-wifi-hong-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/6/638059313570173166_ipad-mini-6-wifi-hong-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/6/638059313569860622_ipad-mini-6-wifi-hong-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/6/638059313570016929_ipad-mini-6-wifi-hong-4.jpg', 15, '256GB', 4, NULL, 28),
(54, 'Xám', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-pro-finish-space-gray-2022?wid=208&amp;hei=208&amp;fmt=png-alpha&amp;.v=1668031205892', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/5/638058511270228916_ipad-pro-129-m1-wifi-xam-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/5/638058511270486981_ipad-pro-129-m1-wifi-xam-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/5/638058511268783981_ipad-pro-129-m1-wifi-xam-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/5/638058511268580122_ipad-pro-129-m1-wifi-xam-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/5/638058511268783981_ipad-pro-129-m1-wifi-xam-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/5/638058511268783981_ipad-pro-129-m1-wifi-xam-6.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/5/638058511271525701_ipad-pro-129-m1-wifi-xam-7.jpg', 40, '1TB', 4, NULL, 29),
(55, 'Bạc', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/MUHA3ref_SW_COLOR?wid=64&hei=64&fmt=jpeg&qlt=90&.v=1693005423915', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/5/638058514292775501_ipad-pro-129-m1-wifi-bac-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/5/638058514291669942_ipad-pro-129-m1-wifi-bac-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/5/638058514291603438_ipad-pro-129-m1-wifi-bac-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/5/638058514291946322_ipad-pro-129-m1-wifi-bac-6.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/5/638058514291585459_ipad-pro-129-m1-wifi-bac-7.jpg', 10, '1TB', 4, NULL, 29),
(56, 'Bạc', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/MUHA3ref_SW_COLOR?wid=64&hei=64&fmt=jpeg&qlt=90&.v=1693005423915', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/1/638054829629162158_ipad-gen10-109-cell-trang-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/1/638054829629409980_ipad-gen10-109-cell-trang-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/1/638054829630274052_ipad-gen10-109-cell-trang-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/1/638054829631392864_ipad-gen10-109-cell-trang-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/1/638054829629455485_ipad-gen10-109-cell-trang-5.jpg', 5, '256GB', 2, NULL, 30),
(57, 'Hồng', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-finish-pink-202108?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1630016970000', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/1/638054827883816537_ipad-gen10-109-cell-hong-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/1/638054827883816537_ipad-gen10-109-cell-hong-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/1/638054827885479497_ipad-gen10-109-cell-hong-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/1/638054827885948377_ipad-gen10-109-cell-hong-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/1/638054827883972771_ipad-gen10-109-cell-hong-5.jpg,', 10, '256GB', 4, NULL, 30),
(58, 'Titan Tự Nhiên', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-pro-finish-naturaltitanium-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692895385156', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307992305419305_iphone-15-promax-xanh-vang-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307992304365855_iphone-15-promax-xanh-vang-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307992301539390_iphone-15-promax-vang-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307992303272057_iphone-15-promax-vang-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980087329808_iphone-15-promax-5.jpg', 200, '1TB', 75, NULL, 31),
(59, 'Titan Xanh', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-pro-finish-bluetitanium-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692895385157', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307989548944936_iphone-15-promax-xanh-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307989548164135_iphone-15-promax-xanh-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307989547694968_iphone-15-promax-xanh-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307989548632428_iphone-15-promax-xanh-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980087329808_iphone-15-promax-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980086696914_iphone-15-promax-6.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980087009486_iphone-15-promax-7.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307989548007937_iphone-15-promax-xanh-9.jpg', 200, '1TB', 150, NULL, 31),
(60, 'Titan Trắng', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-pro-finish-whitetitanium-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692895385155', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307982103040290_iphone-15-promax-trang-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307982102230644_iphone-15-promax-trang-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307982102074523_iphone-15-promax-trang-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307982102543210_iphone-15-promax-trang-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980087329808_iphone-15-promax-5.jpg', 200, '1TB', 27, NULL, 31),
(61, 'Titan Đen', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-pro-finish-blacktitanium-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692895384718', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980220145280_iphone-15-promax-den-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980219675778_iphone-15-promax-den-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980219357093_iphone-15-promax-den-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980220145280_iphone-15-promax-den-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980087329808_iphone-15-promax-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980086696914_iphone-15-promax-6.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980087009486_iphone-15-promax-7.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980087009486_iphone-15-promax-8.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/20/638307980219675778_iphone-15-promax-den-9.jpg', 200, '1TB', 34, NULL, 31),
(62, 'Hồng', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-pink-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831506843', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303942321093007_iphone-15-hong-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303942320468016_iphone-15-hong-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657239008_iphone-15-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657714445_iphone-15-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-6.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-7.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657395275_iphone-15-8.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303942320311782_iphone-15-hong-9.jpg, ', 100, '256GB', 45, NULL, 32),
(63, 'Đen', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-black-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831506982', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303947974016720_iphone-15-den-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303947975273507_iphone-15-den-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657239008_iphone-15-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657714445_iphone-15-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-6.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-7.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657395275_iphone-15-8.jpg', 100, '256GB', 37, NULL, 32),
(64, 'Vàng', 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/finish-yellow-202309?wid=204&amp;hei=204&amp;fmt=jpeg&amp;qlt=90&amp;.v=1692831505426', NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303944832321476_iphone-15-vang-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303944831540229_iphone-15-vang-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657239008_iphone-15-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657714445_iphone-15-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-6.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657557507_iphone-15-7.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/9/15/638303935657395275_iphone-15-8.jpg', 90, '256GB', 12, NULL, 32),
(65, 'Bạc', NULL, NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055950546989770_ipad-pro-11-inch-m2-wifi-bac-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055950545701876_ipad-pro-11-inch-m2-wifi-bac-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055950547128348_ipad-pro-11-inch-m2-wifi-bac-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055950545880787_ipad-pro-11-inch-m2-wifi-bac-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055950546314904_ipad-pro-11-inch-m2-wifi-bac-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055950545580916_ipad-pro-11-inch-m2-wifi-bac-6.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055950547491978_ipad-pro-11-inch-m2-wifi-bac-7.jpg', 200, '256GB', 125, NULL, 33),
(66, 'Bạc', NULL, NULL, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055947587336314_ipad-pro-11-inch-m2-wifi-xam-1.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055947587658876_ipad-pro-11-inch-m2-wifi-xam-2.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055947587502128_ipad-pro-11-inch-m2-wifi-xam-3.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055947586541793_ipad-pro-11-inch-m2-wifi-xam-4.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055947587336314_ipad-pro-11-inch-m2-wifi-xam-5.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055947588127736_ipad-pro-11-inch-m2-wifi-xam-6.jpg, https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2022/12/2/638055947588715689_ipad-pro-11-inch-m2-wifi-xam-7.jpg', 200, '256GB', 111, NULL, 33),
(69, 'Đen', NULL, NULL, 'http://res.cloudinary.com/dpgavjuxz/image/upload/v1715224442/40ae8af8-64bb-491e-a3c9-fdc040d83ea6.webp, http://res.cloudinary.com/dpgavjuxz/image/upload/v1715224444/b531e4ec-65f9-473b-86e4-0573a830b359.webp, http://res.cloudinary.com/dpgavjuxz/image/upload/v1715224446/3422e444-d948-4c93-ab2f-caa2bb82f9cc.webp, http://res.cloudinary.com/dpgavjuxz/image/upload/v1715224447/08ab9d2b-dbdd-455a-96f1-d88bd8ff140e.webp, http://res.cloudinary.com/dpgavjuxz/image/upload/v1715224449/185f30d1-0cb6-4d16-86ab-71a55e2b4c2c.webp', 50, '256GB', 0, NULL, 38);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `review`
--

CREATE TABLE `review` (
  `id` bigint(20) NOT NULL,
  `content` text DEFAULT NULL,
  `create_date` datetime(6) DEFAULT NULL,
  `image_urls` text DEFAULT NULL,
  `rate` float NOT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `order_detail_id` bigint(20) DEFAULT NULL,
  `staff_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `review`
--

INSERT INTO `review` (`id`, `content`, `create_date`, `image_urls`, `rate`, `customer_id`, `order_detail_id`, `staff_id`) VALUES
(1, 'Đã nhận hàng. Sản phẩm OK nhe', '2024-04-05 01:47:18.000000', 'http://res.cloudinary.com/dcsjzfvzz/image/upload/v1712256440/0e575779-266d-4b96-a115-69b5c3920eed.jpg', 4, 6, 6, NULL),
(2, 'Hàng đẹp. Sẽ ủng hộ shop tiếp', '2024-04-05 08:51:48.000000', 'http://res.cloudinary.com/dcsjzfvzz/image/upload/v1712281911/5d4631f8-e0df-4f5f-8df6-6790361ec53c.jpg', 4, 1, 1, NULL),
(3, 'Hàng đẹp nhe', '2024-04-05 09:05:24.000000', 'http://res.cloudinary.com/dcsjzfvzz/image/upload/v1712282727/efb72bec-47da-4dd2-9c5f-488cc8816557.jpg', 4, 1, 7, NULL),
(4, 'Hàng giống mẫu. Giao hàng nhanh', '2024-04-11 01:11:56.000000', NULL, 4, 1, 17, NULL),
(5, 'Sản phẩm đẹp. Sẽ ủng hộ shop tiếp', '2024-04-11 01:12:14.000000', NULL, 4, 1, 17, NULL),
(6, 'Hàng đẹp nhe', '2024-04-13 20:40:15.000000', 'http://res.cloudinary.com/dpgavjuxz/image/upload/v1713015617/32fc7bf5-e261-4782-8b08-dcca0aa7cd7f.jpg', 5, 1, 77, NULL),
(7, 'Đánh giá mới\n', '2024-04-13 20:52:03.000000', 'http://res.cloudinary.com/dpgavjuxz/image/upload/v1713016324/015c4a89-33f0-4237-b3f3-db97860951dc.jpg', 3, 1, 78, NULL),
(8, 'Oki hihi! Shop cảm ơn nhe', '2024-04-13 21:02:04.000000', NULL, 4, 1, 77, NULL),
(9, 'okii', '2024-04-15 22:05:05.000000', NULL, 3, 1, 78, NULL),
(10, 'oki shop cam on nhe', '2024-04-15 22:11:28.000000', NULL, 2, 1, 7, NULL),
(11, 'đánh giá mới\n', '2024-04-15 22:18:04.000000', NULL, 1, 1, 78, NULL),
(12, 'đánh giá mới nhất ', '2024-04-15 22:18:47.000000', NULL, 2, 1, 1, NULL),
(13, 'oki. Sản phẩm đẹp', '2024-04-15 22:19:18.000000', NULL, 4, 1, 1, NULL),
(14, 'kkk\nKhông biết bình luận gì. Sản phẩm ổn nhe', '2024-04-15 22:21:42.000000', NULL, 5, 1, 1, NULL),
(15, 'Sản phẩm đẹp', '2024-04-15 22:32:20.000000', NULL, 5, 1, 78, NULL),
(16, 'Sản phẩm đẹp', '2024-04-15 22:33:36.000000', NULL, 5, 1, 78, NULL),
(17, 'Sản phẩm đẹp', '2024-04-15 22:42:12.000000', NULL, 4, 1, 80, NULL),
(18, 'Sản phẩm đẹp', '2024-04-15 22:42:13.000000', NULL, 4, 1, 80, NULL),
(19, 'oki nhe. Sản phẩm đẹp', '2024-04-15 22:42:22.000000', NULL, 4, 1, 80, NULL),
(20, 'Sản phẩm đẹp', '2024-04-15 22:43:03.000000', 'http://res.cloudinary.com/dpgavjuxz/image/upload/v1713195786/667e8bdf-aae8-465f-8dd8-fbe323f1fd75.jpg', 5, 1, 75, NULL),
(21, 'Nhận được hàng rồi', '2024-04-15 22:43:46.000000', NULL, 5, 1, 75, NULL),
(22, 'okiiii nhe. Sản phẩm đẹp ưng ý ghê hihi', '2024-04-15 22:44:17.000000', NULL, 5, 6, 6, NULL),
(23, 'Nhận được hàng', '2024-04-15 22:49:33.000000', NULL, 3, 1, 75, 9),
(24, 'Ko biết nói gì hihi. Nhưng sẽ ủng hộ shop tiếp', '2024-04-15 22:51:22.000000', NULL, 4, 1, 75, NULL),
(25, 'oki nhe\nĐã nhận được hàng, hàng giống mẫu', '2024-04-15 22:51:31.000000', NULL, 5, 1, 75, 9),
(26, 'Đã nhận được hàng, giao hàng nhanh, shipper thân thiện hihi', '2024-04-15 22:58:05.000000', NULL, 5, 1, 81, NULL),
(27, 'oki nhận được đánh giá', '2024-04-15 22:59:22.000000', NULL, 5, 1, 81, 9),
(28, 'oki nhe, hàng đẹp giống mẫu, giao hàng nhanh', '2024-04-15 23:00:29.000000', NULL, 5, 1, 71, NULL),
(29, 'Nhận được hàng rồi nhe.', '2024-04-15 23:00:31.000000', NULL, 5, 1, 71, NULL),
(30, 'Shop cảm ơn bạn đã để lại đánh giá chân thành. Mong bạn sẽ tiếp tục ủng hộ shop!!!', '2024-04-25 20:47:01.000000', NULL, 5, 1, 7, 9),
(31, 'Đã nhận được hàng, giao hàng nhanh', '2024-05-02 00:11:17.000000', NULL, 5, 5, 42, NULL),
(32, 'Đã nhận được hàng. Sản phẩm đẹp', '2024-05-05 20:58:47.000000', NULL, 5, 1, 72, NULL),
(33, 'Cảm ơn bạn đã đánh giá. Mong bạn tiếp tục ủng hộ shop', '2024-05-05 21:15:19.000000', NULL, 0, 1, 72, 9),
(34, 'Tôi có một thắc mắc, tôi có thể hỏi không', '2024-05-05 21:16:13.000000', NULL, 0, 1, 72, NULL),
(35, 'Sản phẩm đẹp nhe', '2024-05-05 21:30:55.000000', NULL, 5, 1, 69, NULL),
(36, 'Cảm ơn bạn nhiề', '2024-05-05 21:37:42.000000', NULL, 0, 1, 69, 9),
(37, 'Đã nhận được hàng. Hàng đẹp, giao nhanh', '2024-05-08 22:58:11.000000', NULL, 5, 1, 24, NULL),
(38, 'Cảm ơn bạn đã ủng hộ shop', '2024-05-09 00:02:09.000000', NULL, 0, 1, 24, 9),
(39, 'Đã nhận được sản phẩm', '2024-05-09 10:05:11.000000', NULL, 5, 1, 95, NULL),
(40, 'Cảm ơn bạn đã ủng hộ shop', '2024-05-09 10:16:12.000000', NULL, 0, 1, 95, 9);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `role`
--

CREATE TABLE `role` (
  `id` bigint(20) NOT NULL,
  `name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles_privileges`
--

CREATE TABLE `roles_privileges` (
  `role_id` bigint(20) NOT NULL,
  `privilege_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `senior_manager`
--

CREATE TABLE `senior_manager` (
  `id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `shipment`
--

CREATE TABLE `shipment` (
  `id` bigint(20) NOT NULL,
  `method` varchar(100) DEFAULT NULL,
  `ship_cost` decimal(10,2) DEFAULT NULL,
  `ship_date` timestamp NULL DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `shipment`
--

INSERT INTO `shipment` (`id`, `method`, `ship_cost`, `ship_date`, `status`) VALUES
(1, 'road', 30000.00, '2024-04-04 17:43:39', 'pending'),
(2, 'road', 30000.00, '2024-04-04 17:44:10', 'pending'),
(3, 'road', 30000.00, '2024-04-04 17:45:08', 'pending'),
(4, 'road', 30000.00, '2024-04-04 17:48:38', 'pending'),
(5, 'road', 30000.00, '2024-04-04 17:54:04', 'pending'),
(6, 'road', 30000.00, '2024-04-04 18:01:40', 'pending'),
(7, 'road', 30000.00, '2024-04-04 18:46:38', 'pending'),
(8, 'road', 30000.00, '2024-04-05 01:55:41', 'pending'),
(9, 'road', 30000.00, '2024-04-05 06:11:55', 'pending'),
(10, 'road', 30000.00, '2024-04-10 17:59:13', 'pending'),
(11, 'road', 30000.00, '2024-04-10 17:59:40', 'pending'),
(12, 'road', 30000.00, '2024-04-10 18:00:50', 'pending'),
(13, 'road', 30000.00, '2024-04-10 18:01:15', 'pending'),
(14, 'road', 30000.00, '2024-04-10 18:10:03', 'pending'),
(15, 'road', 30000.00, '2024-04-10 18:10:33', 'pending'),
(16, 'road', 30000.00, '2024-04-10 18:11:39', 'pending'),
(17, 'road', 30000.00, '2024-04-10 18:13:06', 'pending'),
(18, 'road', 30000.00, '2024-04-10 18:13:46', 'pending'),
(19, 'road', 30000.00, '2024-04-10 18:14:06', 'pending'),
(20, 'road', 30000.00, '2024-04-10 18:14:30', 'pending'),
(21, 'road', 30000.00, '2024-04-10 18:28:40', 'pending'),
(22, 'road', 30000.00, '2024-04-10 18:28:58', 'pending'),
(23, 'road', 30000.00, '2024-04-10 18:29:13', 'pending'),
(24, 'road', 30000.00, '2024-04-10 18:37:33', 'pending'),
(25, 'road', 30000.00, '2024-04-10 18:38:08', 'pending'),
(26, 'road', 30000.00, '2024-04-10 18:38:39', 'pending'),
(27, 'road', 30000.00, '2024-04-10 18:39:43', 'pending'),
(28, 'road', 30000.00, '2024-04-10 18:40:19', 'pending'),
(29, 'road', 30000.00, '2024-04-10 18:46:22', 'pending'),
(30, 'road', 30000.00, '2024-04-10 18:48:14', 'pending'),
(31, 'road', 30000.00, '2024-04-10 19:02:50', 'pending'),
(32, 'road', 30000.00, '2024-04-11 02:52:03', 'pending'),
(33, 'road', 30000.00, '2024-04-11 02:53:00', 'pending'),
(34, 'road', 30000.00, '2024-04-11 02:53:36', 'pending'),
(35, 'road', 30000.00, '2024-04-11 02:54:04', 'pending'),
(36, 'road', 30000.00, '2024-04-11 02:56:42', 'pending'),
(37, 'road', 30000.00, '2024-04-11 02:57:10', 'pending'),
(38, 'road', 30000.00, '2024-04-11 02:58:03', 'pending'),
(39, 'road', 30000.00, '2024-04-11 02:59:39', 'pending'),
(40, 'road', 30000.00, '2024-04-11 03:00:42', 'pending'),
(41, 'road', 30000.00, '2024-04-11 03:00:52', 'pending'),
(42, 'road', 30000.00, '2024-04-11 03:02:37', 'pending'),
(43, 'road', 30000.00, '2024-04-11 03:03:11', 'pending'),
(44, 'road', 30000.00, '2024-04-11 03:04:03', 'pending'),
(45, 'road', 30000.00, '2024-04-11 03:06:18', 'pending'),
(46, 'road', 30000.00, '2024-04-11 03:06:54', 'pending'),
(47, 'road', 30000.00, '2024-04-11 03:08:36', 'pending'),
(48, 'road', 30000.00, '2024-04-11 03:11:09', 'pending'),
(49, 'road', 30000.00, '2024-04-11 03:11:33', 'pending'),
(50, 'road', 30000.00, '2024-04-11 03:11:52', 'pending'),
(51, 'road', 30000.00, '2024-04-11 04:05:03', 'pending'),
(52, 'road', 30000.00, '2024-04-11 04:05:34', 'pending'),
(53, 'road', 30000.00, '2024-04-11 04:06:02', 'pending'),
(54, 'road', 30000.00, '2024-04-11 04:06:16', 'pending'),
(55, 'road', 30000.00, '2024-04-13 13:39:51', 'pending'),
(56, 'road', 30000.00, '2024-04-13 13:51:45', 'pending'),
(57, 'road', 30000.00, '2024-04-13 13:54:14', 'pending'),
(58, 'road', 30000.00, '2024-04-15 15:41:34', 'pending'),
(59, 'road', 30000.00, '2024-04-15 15:57:47', 'pending'),
(60, 'road', 30000.00, '2024-04-19 03:34:32', 'pending'),
(61, 'road', 30000.00, '2024-04-19 03:35:02', 'pending'),
(62, 'road', 30000.00, '2024-04-19 03:43:22', 'pending'),
(63, 'road', 30000.00, '2024-04-19 03:43:33', 'pending'),
(64, 'road', 30000.00, '2024-04-19 03:43:44', 'pending'),
(65, 'road', 30000.00, '2024-04-23 14:43:52', 'pending'),
(66, 'road', 30000.00, '2024-05-01 17:06:45', 'pending'),
(67, 'road', 30000.00, '2024-05-05 13:55:58', 'pending'),
(68, 'road', 30000.00, '2024-05-07 13:38:03', 'pending'),
(69, 'road', 30000.00, '2024-05-08 15:28:44', 'pending'),
(70, 'road', 30000.00, '2024-05-08 15:29:23', 'pending'),
(71, 'road', 30000.00, '2024-05-08 15:30:04', 'pending'),
(72, 'road', 30000.00, '2024-05-08 15:55:49', 'pending'),
(73, 'road', 30000.00, '2024-05-08 16:48:55', 'pending'),
(74, 'road', 30000.00, '2024-05-09 03:03:44', 'pending');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `staff`
--

CREATE TABLE `staff` (
  `id` bigint(20) NOT NULL,
  `warehouse_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `staff`
--

INSERT INTO `staff` (`id`, `warehouse_id`) VALUES
(9, NULL),
(10, NULL),
(14, NULL),
(15, NULL),
(16, NULL),
(17, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `store`
--

CREATE TABLE `store` (
  `id` bigint(20) NOT NULL,
  `address` text DEFAULT NULL,
  `map_url` text DEFAULT NULL,
  `name` text DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `store`
--

INSERT INTO `store` (`id`, `address`, `map_url`, `name`, `phone`) VALUES
(3, '415-417-419 Lê Đại Hành, Quận 11, Tp.Hồ Chí Minh', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.5681177882984!2d106.65043317451708!3d10.767730059355115!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752f007d327f85%3A0xac4178caf14c11c4!2sHighlands%20Coffee!5e0!3m2!1svi!2s!4v1709043915813!5m2!1svi!2s', 'B&B STORE 415 LE DAI HANH D11', '028 7100 0415'),
(5, '533 Nguyễn Tri Phương, Phường 8, Quận 10, Tp.Hồ Chí Minh', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.5793006208864!2d106.6645741745171!3d10.766870459370981!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752ff302f3e26d%3A0xe2843556e962b754!2sHighlands%20Coffee%20533%20Nguyen%20Tri%20Phuong!5e0!3m2!1svi!2s!4v1709043638877!5m2!1svi!2s', 'B&B STORE 533 NGUYEN TRI PHUONG', '028 7108 0533'),
(6, '1800 Nguyễn Ảnh Thủ, Bà Điểm, Hóc Môn, Tp. Hồ Chí Minh', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15673.610409870083!2d106.58926668715822!3d10.856951899999997!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752b189025d0a1%3A0xd52d9ed98b18d00e!2sHighlands%20Coffee!5e0!3m2!1svi!2s!4v1709044052129!5m2!1svi!2s', 'B&B STORE 1800 NGUYEN ANH THU', '028 7108 1180'),
(7, '130 - 132 Hồng Hà, Phường 9, Quận Phú Nhuận, Tp. Hồ Chí Minh\r\n', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.028184848016!2d106.67012147451766!3d10.809153158590322!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317529ffbb175d6f%3A0x8df0626da28475b4!2sHighlands%20Coffee%20Bamboo%20Airways%20-%20Ph%C3%BA%20Nhu%E1%BA%ADn!5e0!3m2!1svi!2s!4v1709044115739!5m2!1svi!2s', 'B&B STORE BAMBOO AIRWAYS - PHÚ NHUẬN', '028 7108 0130'),
(8, 'Khu vực cách ly Quốc nội, Ga đi Gate 22-25, Sân bay Quốc Tế Tân Sơn Nhất - 45 Trường Sơn, Phường 2, Quận Tân Bình, TP. Hồ Chí Minh', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.9876573612078!2d106.66166237451763!3d10.812256058532885!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3175291d38685da5%3A0x5899074a0c608709!2sHighlands%20Coffee%20Kiosk%20VJET%20G24%20-%20T%C3%A2n%20S%C6%A1n%20Nh%E1%BA%A5t%20Airport!5e0!3m2!1svi!2s!4v1709044190831!5m2!1svi!2s', 'B&T STORE KIOSK VJET G24 - TÂN SƠN NHẤT AIRPORT', '028 7106 8032'),
(9, '198–200 Huỳnh Cương, Phường An Cư, Quận Ninh Kiều, TP. Cần Thơ\r\n', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3928.780033032982!2d105.77745697450888!3d10.035002172432533!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a08955812c4969%3A0xaabcbad7f2b22a98!2zSGlnaGxhbmRzIENvZmZlZSBIdeG7s25oIEPGsMahbmcgLSBD4bqnbiBUaMah!5e0!3m2!1svi!2s!4v1709045576145!5m2!1svi!2s', 'B&B STORE HUỲNH CƯƠNG - CẦN THƠ', '0292 730 2627'),
(10, '09 Sông Hậu, Phường Cái Khế, Quận Ninh Kiều, TP. Cần Thơ', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3928.7192693457805!2d105.79115237450898!3d10.040008672346053!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a0636147ecc53f%3A0x90db0e0eb6e7edf1!2zSGlnaGxhbmRzIENvZmZlZSBDViBTw7RuZyBI4bqtdSAtIEPhuqduIFRoxqE!5e0!3m2!1svi!2s!4v1709049324832!5m2!1svi!2s', 'B&B STORE CV SÔNG HẬU - CẦN THƠ', '0292 730 2425'),
(11, '398R Nguyễn Văn Cừ, Phường Xuân Khánh, Quận Ninh Kiều, Tp.Cần Thơ\r\n', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3928.781020733673!2d105.75413137450892!3d10.0349207724339!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a089a2710ee905%3A0x9d91454136bddb60!2sHIGHLANDS%20COFFEE!5e0!3m2!1svi!2s!4v1709049462190!5m2!1svi!2s\r\n', 'B&B STORE 389R NGUYỄN VĂN CỪ CẦN THƠ', '0292 730 2021'),
(12, '209 Ba Mươi Tháng Tư, phường Xuân Khánh, Quận Ninh Kiều, Tp. Cần Thơ', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3928.9040702205207!2d105.77505230000001!3d10.0247747!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a08825b4f6bb23%3A0x17158015b921f5e5!2sHighlands%20Coffee%20Vincom%20Xu%C3%A2n%20Kh%C3%A1nh!5e0!3m2!1svi!2s!4v1709049593692!5m2!1svi!2s', 'B&B STORE VINCOM XUÂN KHÁNH CT', '0292 373 0689'),
(13, '170, Đường 29 Tháng 3, P. Hòa Xuân, P. Cẩm Lệ, TP Đà Nẵng', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3834.887908686824!2d108.22770997459905!3d16.01934954077237!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3142192cd65e0c29%3A0xf82f282749b366af!2sHighlands%20Coffee%2029%20Thang%203%20Da%20Nang!5e0!3m2!1svi!2s!4v1709049710966!5m2!1svi!2s', 'B&B STORE 29 THANG 3 DA NANG', '0236 730 2324');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

CREATE TABLE `user` (
  `user_type` varchar(31) NOT NULL,
  `id` bigint(20) NOT NULL,
  `account` varchar(50) NOT NULL,
  `address` text DEFAULT NULL,
  `avatar` text DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `district` text DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `email` varchar(80) DEFAULT NULL,
  `locked` tinyint(1) DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `password` text DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `province` text DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `ward` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`user_type`, `id`, `account`, `address`, `avatar`, `created_at`, `district`, `dob`, `email`, `locked`, `name`, `password`, `phone`, `province`, `updated_at`, `ward`) VALUES
('customer', 1, 'Nguyen Chi Bao B2012178', 'đường Phạm Thái Bường, phường 4, TP. Vĩnh Long', 'http://res.cloudinary.com/dpgavjuxz/image/upload/v1714917702/3301c26d-eca3-48de-9b52-b4a9ba8f0f11.jpg', '2024-04-03 23:56:42.000000', NULL, '2002-03-16', 'chibao123@gmail.com', 0, 'Nguyễn Chí Bảo', NULL, '0889020278', NULL, NULL, NULL),
('customer', 2, 'Bao Nguyen Chi', '7 Đường F2, KDC Bình Nhựt (Khu 12 hecta 8 cũ Can tho', 'https://lh3.googleusercontent.com/a/ACg8ocKQnvunnTcPqtedaUWQZoNNwHU6zRVdpTvbAunGKEsc8lXosg=s96-c', '2024-04-04 06:40:47.000000', NULL, '1994-07-22', 'nguyenchibao011102@gmail.com', 0, 'Nguyễn Bảo Chí', NULL, '0974586974', NULL, NULL, NULL),
('customer', 3, 'Chi Bao Nguyen', '3Q22+944, Đường F4, An Thới, Bình Thủy, Cần Thơ', 'https://lh3.googleusercontent.com/a/ACg8ocKH0YgZ_BhoInuWH6-wn-Z1pAFEBfl4aS5okpeHajtf7R6CEg=s96-c', '2024-04-04 19:50:30.000000', NULL, '1997-08-11', 'baubaunguyen111@gmail.com', 0, 'Nguyễn Chí Bảo', NULL, '0258123456', NULL, NULL, NULL),
('customer', 4, 'ncb', '3P2X+GVR, Bình Thuỷ, Bình Thủy, Cần Thơ', 'http://res.cloudinary.com/dcsjzfvzz/image/upload/v1712253513/3d58c69d-8bb9-442f-bedf-108231e00d9f.jpg', '2024-04-05 00:47:45.000000', NULL, '1996-02-12', 'ncb@gmail.com', 0, 'Nguyễn Chi Bảo', '$2a$10$yYvYQsMxl75di6z45xs05.SRWMr.NER2RlYuNPwCl2hn/oMvleIGa', '0392564778', NULL, NULL, NULL),
('customer', 5, 'linhxeom', '280 Đ. Vành Đai Trong, Bình Trị Đông B, Bình Tân, Thành phố Hồ Chí Minh', 'http://res.cloudinary.com/dcsjzfvzz/image/upload/v1712655930/f54bac87-e88f-4198-9e12-f068a45ae441.jpg', '2024-04-05 01:41:31.000000', NULL, '2024-05-06', 'TeoEm123@gmail.com', 0, 'Trần Văn Linh', '$2a$10$9TR8E0fXDlDHlg7FA13NF.WlruAVqkkMCRSoyiI9RkNI5z8fSVQXa', '0886020214', NULL, NULL, NULL),
('customer', 6, 'anhthu', '46 Võ Văn Kiệt, An Thới, Bình Thủy, Cần Thơ', NULL, '2024-04-05 01:43:39.000000', NULL, '1998-05-18', 'nnathu@2000@gmail.com', 0, 'Nguyễn Ngọc Anh Thư', '$2a$10$ilz9/Bdhi9d0g9o7zFLjCOObjjzqE/ROjZrXzaytcVFB7i7VyYnNK', '0392332316', NULL, NULL, NULL),
('customer', 7, 'nnlt', '2QX2+P2H, Đường F7, Phường An Khánh, Ninh Kiều, Cần Thơ', NULL, '2024-04-05 01:44:29.000000', NULL, '1987-08-20', 'nnlt2002@gmail.com', 1, 'Nguyễn Ngọc Lam Thanh', '$2a$10$7cGEIn1B5t5EU99PuU7gb.m3nKespSo82FYfeDdvt3RARlrSOQoDm', '0986123456', NULL, NULL, NULL),
('customer', 8, 'Ly Tan Tai', 'An Thới, Bình Thủy, Cần Thơ', NULL, '2024-04-05 01:45:45.000000', NULL, '2000-04-18', 'lttai2002@gmail.com', 0, 'Lý Tấn Tài', '$2a$10$y3.xAsQkRomRUOlrfKID5u7uHRpD5msvV0oOA.922M5x3OcqHgB5C', '0889202078', NULL, NULL, NULL),
('staff', 9, 'NguyenThuHang', 'Q.Cái Răng, TP.Cần Thơ', 'data:image/jpeg;base64,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', '2024-04-05 01:51:53.000000', NULL, '2000-04-06', 'thang2000@gmail.com', 0, 'Nguyễn Thu Hằng', '$2a$10$9TR8E0fXDlDHlg7FA13NF.WlruAVqkkMCRSoyiI9RkNI5z8fSVQXa', '0886027545', NULL, NULL, NULL),
('staff', 10, 'NguyenChiBao', NULL, NULL, '2024-04-05 01:52:09.000000', NULL, '1989-05-16', 'hoangbao2002@gmail.com', 0, 'Nguyễn Chí Bảo', '$2a$10$9TR8E0fXDlDHlg7FA13NF.WlruAVqkkMCRSoyiI9RkNI5z8fSVQXa', '039258456', NULL, NULL, NULL),
('admin', 11, 'PhanPhuongLan', 'Hẻm 68, phường Hưng Lợi, quận Ninh Kiều, TP Cần Thơ', 'data:image/jpeg;base64,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', '2024-04-05 01:53:23.000000', NULL, '1992-04-01', 'pplan@gmail.com', 0, 'Phan Phương Lan', '$2a$10$9TR8E0fXDlDHlg7FA13NF.WlruAVqkkMCRSoyiI9RkNI5z8fSVQXa', '0886020280', NULL, NULL, NULL),
('manager', 13, 'NguyenNhanDuc', 'p.Hưng Lợi, Q.Ninh Kiều, TP.Cần Thơ', 'https://gcs.tripi.vn/public-tripi/tripi-feed/img/474087dyr/avatar-anime-nam-dep-nhat_041627396.jpg', '2024-04-05 02:06:26.000000', NULL, '1985-04-12', 'nnduc1985&gmail.com', 0, 'Nguyễn Nhân Đức', '$2a$10$9TR8E0fXDlDHlg7FA13NF.WlruAVqkkMCRSoyiI9RkNI5z8fSVQXa', '0392332374', NULL, NULL, NULL),
('staff', 14, 'YenVy', 'Q.12, TP.HCM', NULL, '2024-04-05 03:36:56.000000', NULL, '1996-09-10', 'nyvy@1998@gmail.com', 0, 'Nguyễn Yến Vy', '$2a$10$9TR8E0fXDlDHlg7FA13NF.WlruAVqkkMCRSoyiI9RkNI5z8fSVQXa', '0862475845', NULL, NULL, NULL),
('staff', 15, 'NguyetHang', '3 Đ. DD5, Đông Hưng Thuận, Quận 12, Thành phố Hồ Chí Minh', NULL, '2024-04-05 03:37:11.000000', NULL, '1990-07-13', 'nhang2002@gmail.com', 0, 'Nguyễn Nguyệt Hằng', '$2a$10$9TR8E0fXDlDHlg7FA13NF.WlruAVqkkMCRSoyiI9RkNI5z8fSVQXa', '0974493859', NULL, NULL, NULL),
('staff', 16, 'NgocHan', '488-502 ĐT923, Trường Lạc, Ô Môn, Cần Thơ', NULL, '2024-04-05 03:37:16.000000', NULL, '2002-04-01', 'ngochan@gmail.com', 0, 'Nguyễn Ngọc Hân', '$2a$10$9TR8E0fXDlDHlg7FA13NF.WlruAVqkkMCRSoyiI9RkNI5z8fSVQXa', '0392332378', NULL, NULL, NULL),
('staff', 17, 'AnhDao', '292 Rạch Bà Sự, Thới An, Ô Môn, Cần Thơ', NULL, '2024-04-05 03:37:31.000000', NULL, '2002-12-07', 'anhdao@gmail.com', 0, 'Mã Anh Đào', '$2a$10$9TR8E0fXDlDHlg7FA13NF.WlruAVqkkMCRSoyiI9RkNI5z8fSVQXa', '0889027581', NULL, NULL, NULL),
('customer', 18, 'nthn', NULL, NULL, '2024-04-11 10:05:23.000000', NULL, NULL, NULL, 0, NULL, '$2a$10$gzrSxz0tfe6j59i/v8L7jealUCQeMl0I5gQ90RVuay6jDD7jdZOI6', NULL, NULL, NULL, NULL),
('customer', 19, 'PhamNgocMinhThu2604', '101, ấp Mỹ Phú, huyện Tam Bình, tỉnh Vĩnh Long', 'http://res.cloudinary.com/dpgavjuxz/image/upload/v1713497487/01ed856a-36bd-473e-b790-b67e5bd71419.jpg', '2024-04-19 10:27:48.000000', NULL, '2002-04-26', 'minhthu123@gmail.com', 1, 'Phạm Ngọc Minh Thư', '$2a$10$0ucRmjlvyhDU/XIGVU2tL.0xuXL4fMLrXLrvWrjAi2juTNxHDyIPK', '0887456789', NULL, NULL, NULL),
('customer', 20, 'NguyenNgocHa2002', 'ấp Hồi Trinh, xã Xuân Hiệp, huyện Trà Ôn, tỉnh Vĩnh Long', 'http://res.cloudinary.com/dpgavjuxz/image/upload/v1715166079/6f4d5ac1-df8f-48dc-9bb4-9fa0781b7c20.jpg', '2024-04-19 10:28:09.000000', NULL, '2002-02-06', 'nnha@gmail.com', 0, 'Nguyễn Ngọc Ha', '$2a$10$I/.ZLqR.s0JaqULd3J4vBOVWu7TqPguh1jY0pz0pUMobI5paRGQBG', '0392584788', NULL, NULL, NULL),
('customer', 21, 'NguyenNgocNhuQuynh', 'khóm 2, Thị Trấn Tam Bình, tỉnh Vĩnh Long', 'http://res.cloudinary.com/dpgavjuxz/image/upload/v1715167846/189fdb6d-f8ab-4189-8eb0-b004b8a14a17.jpg', '2024-04-19 10:28:31.000000', NULL, '2001-08-09', 'nnnquynh@gmail.com', 0, 'Nguyễn Ngọc Như Quỳnh', '$2a$10$DYiPAY065zb0i6sPYkiwe.CW3HqQB11bcc/BCtdylVfmkwG6xBeYa', '0862818324', NULL, NULL, NULL),
('customer', 22, 'NguyenChiVan', 'Chợ Định Hòa (Chợ Cà Nhung), Q7Q8+WHX, Định Hoà, Gò Quao, Kiên Giang', 'http://res.cloudinary.com/dpgavjuxz/image/upload/v1715166261/b2424582-6a9d-4cb6-836a-ea163344e727.jpg', '2024-05-05 20:45:02.000000', NULL, '2003-07-08', 'chivan@gmail.com', 0, 'Nguyễn Chí Văn', '$2a$10$1Fh28rFq0eHHOHpk4UFb6.iTz/vCwe3tKPkIqAvsDdFwAxkdc7zPa', '0889202085', NULL, NULL, NULL),
('customer', 23, 'NguyenGiaBao', 'xã  Long Phú, huyện Tam Bình, tỉnh Vĩnh Long', 'http://res.cloudinary.com/dpgavjuxz/image/upload/v1715168047/51ec35b0-6895-490a-a408-abb84f8840f6.jpg', '2024-05-05 20:52:01.000000', NULL, '1998-12-07', 'giabao1998@gmail.com', 0, 'Nguyễn Gia Bảo', '$2a$10$gDQoq1T40FTZvrWQjLGzaemW8KfPVOrpF9fqRaW8cuufwUCorwC0y', '0392589637', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users_roles`
--

CREATE TABLE `users_roles` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `warehouse`
--

CREATE TABLE `warehouse` (
  `id` bigint(20) NOT NULL,
  `address` varchar(200) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK93c3js0e22ll1xlu21nvrhqgg` (`customer_id`),
  ADD KEY `FK3sql38dviqtd0ctkixny6tusj` (`warehouse_id`);

--
-- Chỉ mục cho bảng `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_867x3yysb1f3jk41cv3vsoejj` (`customer_id`);

--
-- Chỉ mục cho bảng `cart_detail`
--
ALTER TABLE `cart_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKrg4yopd2252nwj8bfcgq5f4jp` (`cart_id`),
  ADD KEY `FK3c8gudcdnngwh5k2g2n25kkqk` (`product_detail_id`);

--
-- Chỉ mục cho bảng `conversation`
--
ALTER TABLE `conversation`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `coupon`
--
ALTER TABLE `coupon`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_qfxqi38pg68c877n4o67b6egt` (`employee_id`);

--
-- Chỉ mục cho bảng `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `customer_order`
--
ALTER TABLE `customer_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK1i928kdo9v2sgxn8xbel27of3` (`coupon_id`),
  ADD KEY `FKf9abd30bhiqvugayxlpq8ryq9` (`customer_id`),
  ADD KEY `FKhktmgho7kcbxo4muas3mj0amn` (`payment_id`),
  ADD KEY `FK6jmbqkjrax1lfqf2amy0cww7g` (`shipment_id`),
  ADD KEY `FKeud89hox32thd9p2y7lb17fs0` (`staff_id`),
  ADD KEY `FKdn6npqs9ccpcmxfjqtac3cdgf` (`warehouse_id`);

--
-- Chỉ mục cho bảng `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `image_data`
--
ALTER TABLE `image_data`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `manager`
--
ALTER TABLE `manager`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_aqy38jplglo2mpneqq9u554oh` (`warehouse_id`);

--
-- Chỉ mục cho bảng `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK6yskk3hxw5sklwgi25y6d5u1l` (`conversation_id`);

--
-- Chỉ mục cho bảng `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKduo4ugsictahhrd219y86wqho` (`customer_id`),
  ADD KEY `FKpitbjyxxfd8mub3oam3r4kqmy` (`order_id`);

--
-- Chỉ mục cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKk99e899ovga4l366djjrqmpy0` (`order_id`);

--
-- Chỉ mục cho bảng `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `privilege`
--
ALTER TABLE `privilege`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK6d8deakb8jl5h2ola2043itpe` (`imagedata_id`);

--
-- Chỉ mục cho bảng `product_detail`
--
ALTER TABLE `product_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKilxoi77ctyin6jn9robktb16c` (`product_id`);

--
-- Chỉ mục cho bảng `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKgce54o0p6uugoc2tev4awewly` (`customer_id`),
  ADD KEY `FKcueyxqruikr81ahlxl18e6s0y` (`order_detail_id`),
  ADD KEY `FK41xp0utwmwc2xgu44v6qx4nk4` (`staff_id`);

--
-- Chỉ mục cho bảng `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `roles_privileges`
--
ALTER TABLE `roles_privileges`
  ADD KEY `FK5yjwxw2gvfyu76j3rgqwo685u` (`privilege_id`),
  ADD KEY `FK9h2vewsqh8luhfq71xokh4who` (`role_id`);

--
-- Chỉ mục cho bảng `senior_manager`
--
ALTER TABLE `senior_manager`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `shipment`
--
ALTER TABLE `shipment`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_mybp3crm0sui9ed5it8cjvwj2` (`warehouse_id`);

--
-- Chỉ mục cho bảng `store`
--
ALTER TABLE `store`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_dnq7r8jcmlft7l8l4j79l1h74` (`account`);

--
-- Chỉ mục cho bảng `users_roles`
--
ALTER TABLE `users_roles`
  ADD KEY `FKt4v0rrweyk393bdgt107vdx0x` (`role_id`),
  ADD KEY `FKgd3iendaoyh04b95ykqise6qh` (`user_id`);

--
-- Chỉ mục cho bảng `warehouse`
--
ALTER TABLE `warehouse`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `address`
--
ALTER TABLE `address`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT cho bảng `cart`
--
ALTER TABLE `cart`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `cart_detail`
--
ALTER TABLE `cart_detail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- AUTO_INCREMENT cho bảng `conversation`
--
ALTER TABLE `conversation`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `coupon`
--
ALTER TABLE `coupon`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `customer_order`
--
ALTER TABLE `customer_order`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT cho bảng `image_data`
--
ALTER TABLE `image_data`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT cho bảng `message`
--
ALTER TABLE `message`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `notification`
--
ALTER TABLE `notification`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT cho bảng `payment`
--
ALTER TABLE `payment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT cho bảng `post`
--
ALTER TABLE `post`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `privilege`
--
ALTER TABLE `privilege`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `product`
--
ALTER TABLE `product`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT cho bảng `product_detail`
--
ALTER TABLE `product_detail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT cho bảng `review`
--
ALTER TABLE `review`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT cho bảng `role`
--
ALTER TABLE `role`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `shipment`
--
ALTER TABLE `shipment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT cho bảng `store`
--
ALTER TABLE `store`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT cho bảng `user`
--
ALTER TABLE `user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT cho bảng `warehouse`
--
ALTER TABLE `warehouse`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `FK3sql38dviqtd0ctkixny6tusj` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`id`),
  ADD CONSTRAINT `FK93c3js0e22ll1xlu21nvrhqgg` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`);

--
-- Các ràng buộc cho bảng `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `FK10tbv302geptlk5ks8a6ek28` FOREIGN KEY (`id`) REFERENCES `employee` (`id`);

--
-- Các ràng buộc cho bảng `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `FKdebwvad6pp1ekiqy5jtixqbaj` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`);

--
-- Các ràng buộc cho bảng `cart_detail`
--
ALTER TABLE `cart_detail`
  ADD CONSTRAINT `FK3c8gudcdnngwh5k2g2n25kkqk` FOREIGN KEY (`product_detail_id`) REFERENCES `product_detail` (`id`),
  ADD CONSTRAINT `FKrg4yopd2252nwj8bfcgq5f4jp` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`);

--
-- Các ràng buộc cho bảng `coupon`
--
ALTER TABLE `coupon`
  ADD CONSTRAINT `FKq1tlwit8crggqy51nwc7efafs` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`);

--
-- Các ràng buộc cho bảng `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `FKg2o3t8h0g17smtr9jgypagdtv` FOREIGN KEY (`id`) REFERENCES `user` (`id`);

--
-- Các ràng buộc cho bảng `customer_order`
--
ALTER TABLE `customer_order`
  ADD CONSTRAINT `FK1i928kdo9v2sgxn8xbel27of3` FOREIGN KEY (`coupon_id`) REFERENCES `coupon` (`id`),
  ADD CONSTRAINT `FK6jmbqkjrax1lfqf2amy0cww7g` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`id`),
  ADD CONSTRAINT `FKdn6npqs9ccpcmxfjqtac3cdgf` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`id`),
  ADD CONSTRAINT `FKeud89hox32thd9p2y7lb17fs0` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`),
  ADD CONSTRAINT `FKf9abd30bhiqvugayxlpq8ryq9` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  ADD CONSTRAINT `FKhktmgho7kcbxo4muas3mj0amn` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`);

--
-- Các ràng buộc cho bảng `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `FKd8il4lxw1wi74qh8b7uoy6e0a` FOREIGN KEY (`id`) REFERENCES `user` (`id`);

--
-- Các ràng buộc cho bảng `manager`
--
ALTER TABLE `manager`
  ADD CONSTRAINT `FKfyj837fl3wvsfdrwxe10fss10` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`id`),
  ADD CONSTRAINT `FKobm0udnqxv4jiddvi5oykkgdr` FOREIGN KEY (`id`) REFERENCES `employee` (`id`);

--
-- Các ràng buộc cho bảng `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `FK6yskk3hxw5sklwgi25y6d5u1l` FOREIGN KEY (`conversation_id`) REFERENCES `conversation` (`id`);

--
-- Các ràng buộc cho bảng `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `FKduo4ugsictahhrd219y86wqho` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  ADD CONSTRAINT `FKpitbjyxxfd8mub3oam3r4kqmy` FOREIGN KEY (`order_id`) REFERENCES `customer_order` (`id`);

--
-- Các ràng buộc cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  ADD CONSTRAINT `FKk99e899ovga4l366djjrqmpy0` FOREIGN KEY (`order_id`) REFERENCES `customer_order` (`id`);

--
-- Các ràng buộc cho bảng `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `FK6d8deakb8jl5h2ola2043itpe` FOREIGN KEY (`imagedata_id`) REFERENCES `image_data` (`id`);

--
-- Các ràng buộc cho bảng `product_detail`
--
ALTER TABLE `product_detail`
  ADD CONSTRAINT `FKilxoi77ctyin6jn9robktb16c` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Các ràng buộc cho bảng `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `FK41xp0utwmwc2xgu44v6qx4nk4` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`),
  ADD CONSTRAINT `FKcueyxqruikr81ahlxl18e6s0y` FOREIGN KEY (`order_detail_id`) REFERENCES `order_detail` (`id`),
  ADD CONSTRAINT `FKgce54o0p6uugoc2tev4awewly` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`);

--
-- Các ràng buộc cho bảng `roles_privileges`
--
ALTER TABLE `roles_privileges`
  ADD CONSTRAINT `FK5yjwxw2gvfyu76j3rgqwo685u` FOREIGN KEY (`privilege_id`) REFERENCES `privilege` (`id`),
  ADD CONSTRAINT `FK9h2vewsqh8luhfq71xokh4who` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);

--
-- Các ràng buộc cho bảng `senior_manager`
--
ALTER TABLE `senior_manager`
  ADD CONSTRAINT `FKc1k3bgc30q7tk6tug2ib1kk5c` FOREIGN KEY (`id`) REFERENCES `employee` (`id`);

--
-- Các ràng buộc cho bảng `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `FKav6774qxrey70920sd85yv78r` FOREIGN KEY (`id`) REFERENCES `employee` (`id`),
  ADD CONSTRAINT `FKp3d783a0xb10nnsw3ig3sts9n` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`id`);

--
-- Các ràng buộc cho bảng `users_roles`
--
ALTER TABLE `users_roles`
  ADD CONSTRAINT `FKgd3iendaoyh04b95ykqise6qh` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `FKt4v0rrweyk393bdgt107vdx0x` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
