-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th3 06, 2024 lúc 02:54 PM
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
-- Cấu trúc bảng cho bảng `store`
--

CREATE TABLE `store` (
  `id` bigint(20) NOT NULL,
  `address` text DEFAULT NULL,
  `name` text DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `map_url` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `store`
--

INSERT INTO `store` (`id`, `address`, `name`, `phone`, `map_url`) VALUES
(3, '415-417-419 Lê Đại Hành, Quận 11, Tp.Hồ Chí Minh', 'B&T STORE 415 LE DAI HANH D11', '028 7100 0415', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.5681177882984!2d106.65043317451708!3d10.767730059355115!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752f007d327f85%3A0xac4178caf14c11c4!2sHighlands%20Coffee!5e0!3m2!1svi!2s!4v1709043915813!5m2!1svi!2s'),
(5, '533 Nguyễn Tri Phương, Phường 8, Quận 10, Tp.Hồ Chí Minh', 'B&T STORE 533 NGUYEN TRI PHUONG', '028 7108 0533', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.5793006208864!2d106.6645741745171!3d10.766870459370981!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752ff302f3e26d%3A0xe2843556e962b754!2sHighlands%20Coffee%20533%20Nguyen%20Tri%20Phuong!5e0!3m2!1svi!2s!4v1709043638877!5m2!1svi!2s'),
(6, '1800 Nguyễn Ảnh Thủ, Bà Điểm, Hóc Môn, Tp. Hồ Chí Minh', 'B&T STORE 1800 NGUYEN ANH THU', '028 7108 1180', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15673.610409870083!2d106.58926668715822!3d10.856951899999997!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752b189025d0a1%3A0xd52d9ed98b18d00e!2sHighlands%20Coffee!5e0!3m2!1svi!2s!4v1709044052129!5m2!1svi!2s'),
(7, '130 - 132 Hồng Hà, Phường 9, Quận Phú Nhuận, Tp. Hồ Chí Minh\r\n', 'B&T STORE BAMBOO AIRWAYS - PHÚ NHUẬN', '028 7108 0130', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.028184848016!2d106.67012147451766!3d10.809153158590322!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317529ffbb175d6f%3A0x8df0626da28475b4!2sHighlands%20Coffee%20Bamboo%20Airways%20-%20Ph%C3%BA%20Nhu%E1%BA%ADn!5e0!3m2!1svi!2s!4v1709044115739!5m2!1svi!2s'),
(8, 'Khu vực cách ly Quốc nội, Ga đi Gate 22-25, Sân bay Quốc Tế Tân Sơn Nhất - 45 Trường Sơn, Phường 2, Quận Tân Bình, TP. Hồ Chí Minh', 'B&T STORE KIOSK VJET G24 - TÂN SƠN NHẤT AIRPORT', '028 7106 8032', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.9876573612078!2d106.66166237451763!3d10.812256058532885!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3175291d38685da5%3A0x5899074a0c608709!2sHighlands%20Coffee%20Kiosk%20VJET%20G24%20-%20T%C3%A2n%20S%C6%A1n%20Nh%E1%BA%A5t%20Airport!5e0!3m2!1svi!2s!4v1709044190831!5m2!1svi!2s'),
(9, '198–200 Huỳnh Cương, Phường An Cư, Quận Ninh Kiều, TP. Cần Thơ\r\n', 'B&T STORE HUỲNH CƯƠNG - CẦN THƠ', '0292 730 2627', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3928.780033032982!2d105.77745697450888!3d10.035002172432533!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a08955812c4969%3A0xaabcbad7f2b22a98!2zSGlnaGxhbmRzIENvZmZlZSBIdeG7s25oIEPGsMahbmcgLSBD4bqnbiBUaMah!5e0!3m2!1svi!2s!4v1709045576145!5m2!1svi!2s'),
(10, '09 Sông Hậu, Phường Cái Khế, Quận Ninh Kiều, TP. Cần Thơ', 'B&T STORE CV SÔNG HẬU - CẦN THƠ', '0292 730 2425', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3928.7192693457805!2d105.79115237450898!3d10.040008672346053!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a0636147ecc53f%3A0x90db0e0eb6e7edf1!2zSGlnaGxhbmRzIENvZmZlZSBDViBTw7RuZyBI4bqtdSAtIEPhuqduIFRoxqE!5e0!3m2!1svi!2s!4v1709049324832!5m2!1svi!2s'),
(11, '398R Nguyễn Văn Cừ, Phường Xuân Khánh, Quận Ninh Kiều, Tp.Cần Thơ\r\n', 'B&T STORE 389R NGUYỄN VĂN CỪ CẦN THƠ', '0292 730 2021', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3928.781020733673!2d105.75413137450892!3d10.0349207724339!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a089a2710ee905%3A0x9d91454136bddb60!2sHIGHLANDS%20COFFEE!5e0!3m2!1svi!2s!4v1709049462190!5m2!1svi!2s\r\n'),
(12, '209 Ba Mươi Tháng Tư, phường Xuân Khánh, Quận Ninh Kiều, Tp. Cần Thơ', 'B&T STORE VINCOM XUÂN KHÁNH CT', '0292 373 0689', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3928.9040702205207!2d105.77505230000001!3d10.0247747!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a08825b4f6bb23%3A0x17158015b921f5e5!2sHighlands%20Coffee%20Vincom%20Xu%C3%A2n%20Kh%C3%A1nh!5e0!3m2!1svi!2s!4v1709049593692!5m2!1svi!2s'),
(13, '170, Đường 29 Tháng 3, P. Hòa Xuân, P. Cẩm Lệ, TP Đà Nẵng', 'B&T STORE 29 THANG 3 DA NANG', '0236 730 2324', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3834.887908686824!2d108.22770997459905!3d16.01934954077237!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3142192cd65e0c29%3A0xf82f282749b366af!2sHighlands%20Coffee%2029%20Thang%203%20Da%20Nang!5e0!3m2!1svi!2s!4v1709049710966!5m2!1svi!2s');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `store`
--
ALTER TABLE `store`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `store`
--
ALTER TABLE `store`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
