-- ======================================================================
-- HỆ THỐNG QUẢN LÝ SIÊU THỊ - PHÂN HỆ MỚI
-- Module 1: Khách hàng tìm kiếm mặt hàng và xem thông tin chi tiết mặt hàng
-- Module 2: Quản lý xem thống kê nhà cung cấp theo số lượng hàng nhập -> 
--           Xem danh sách các lần nhập (hóa đơn nhập) -> Xem chi tiết hóa đơn
-- Mã sinh viên: B21DCCN250
-- Cơ sở dữ liệu: 12_qlst_250 (hoặc 12_qlst_726)
-- ======================================================================

CREATE DATABASE IF NOT EXISTS `12_qlst_250`
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE `12_qlst_250`;

SET FOREIGN_KEY_CHECKS = 0;

-- ======================================================================
-- XÓA CÁC PROCEDURE CŨ NẾU ĐÃ TỒN TẠI
-- ======================================================================
DROP PROCEDURE IF EXISTS `TimKiemMatHang250`;
DROP PROCEDURE IF EXISTS `GetMatHangById250`;
DROP PROCEDURE IF EXISTS `TKNCCTheoSLNhap250`;
DROP PROCEDURE IF EXISTS `GetListHDNByNCC250`;
DROP PROCEDURE IF EXISTS `GetChiTietHDN250`;

DROP PROCEDURE IF EXISTS `TimKiemMatHang726`;
DROP PROCEDURE IF EXISTS `GetMatHangById726`;
DROP PROCEDURE IF EXISTS `TKNCCTheoSLNhap726`;
DROP PROCEDURE IF EXISTS `GetListHDNByNCC726`;
DROP PROCEDURE IF EXISTS `GetChiTietHDN726`;

-- ======================================================================
-- XÓA BẢNG VÀ VIEW NẾU TỒN TẠI (THEO THỨ TỰ KHÓA NGOẠI)
-- ======================================================================
DROP VIEW IF EXISTS `hdnchitiet_726`;
DROP VIEW IF EXISTS `hoadonnhap_726`;
DROP VIEW IF EXISTS `mathang_726`;
DROP VIEW IF EXISTS `nhacungcap_726`;
DROP VIEW IF EXISTS `nvk_726`;
DROP VIEW IF EXISTS `nvql_726`;
DROP VIEW IF EXISTS `khachhang_726`;
DROP VIEW IF EXISTS `sieuthi_726`;

DROP VIEW IF EXISTS `hdnchitiet_250`;
DROP VIEW IF EXISTS `hoadonnhap_250`;
DROP VIEW IF EXISTS `mathang_250`;
DROP VIEW IF EXISTS `nhacungcap_250`;
DROP VIEW IF EXISTS `nvk_250`;
DROP VIEW IF EXISTS `nvql_250`;
DROP VIEW IF EXISTS `khachhang_250`;
DROP VIEW IF EXISTS `sieuthi_250`;

DROP TABLE IF EXISTS `hdnchitiet_250`;
DROP TABLE IF EXISTS `hoadonnhap_250`;
DROP TABLE IF EXISTS `mathang_250`;
DROP TABLE IF EXISTS `nhacungcap_250`;
DROP TABLE IF EXISTS `nvk_250`;
DROP TABLE IF EXISTS `nvbh_250`;
DROP TABLE IF EXISTS `nvql_250`;
DROP TABLE IF EXISTS `khachhang_250`;
DROP TABLE IF EXISTS `sieuthi_250`;

DROP TABLE IF EXISTS `hdnchitiet_726`;
DROP TABLE IF EXISTS `hoadonnhap_726`;
DROP TABLE IF EXISTS `mathang_726`;
DROP TABLE IF EXISTS `nhacungcap_726`;
DROP TABLE IF EXISTS `nvk_726`;
DROP TABLE IF EXISTS `nvbh_726`;
DROP TABLE IF EXISTS `nvql_726`;
DROP TABLE IF EXISTS `khachhang_726`;
DROP TABLE IF EXISTS `sieuthi_726`;

-- ======================================================================
-- 1. BẢNG SIÊU THỊ
-- ======================================================================
CREATE TABLE `sieuthi_250` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `ten` VARCHAR(255) NOT NULL,
    `diaChi` VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `sieuthi_250` (`id`, `ten`, `diaChi`) VALUES
(1, 'Siêu thị Trung Tâm', 'Km10 Đường Nguyễn Trãi, Phường Mộ Lao, Quận Hà Đông, TP. Hà Nội');

-- ======================================================================
-- 2. BẢNG NHÂN VIÊN QUẢN LÝ
-- ======================================================================
CREATE TABLE `nvql_250` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `hoTen` VARCHAR(255) NOT NULL,
    `sdt` VARCHAR(20),
    `email` VARCHAR(255),
    `ngaySinh` DATE,
    `password` VARCHAR(255) NOT NULL,
    `maNV` VARCHAR(50) NOT NULL UNIQUE,
    `chucVu` VARCHAR(100),
    `sieuThi_Id` INT DEFAULT 1,
    CONSTRAINT `fk_nvql250_sieuthi` FOREIGN KEY (`sieuThi_Id`) REFERENCES `sieuthi_250`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `nvql_250` (`id`, `hoTen`, `sdt`, `email`, `ngaySinh`, `password`, `maNV`, `chucVu`, `sieuThi_Id`) VALUES
(1, 'Quản lý viên', '0987654321', 'ngovantrong1308@gmail.com', '2003-08-13', '123456', 'NVQL250', 'Quản lý siêu thị', 1),
(2, 'Admin Quản Lý', '0988888888', 'admin@ptit.edu.vn', '1990-01-01', '123456', 'admin', 'Trưởng phòng quản lý', 1),
(3, 'Quản lý viên (Dự phòng)', '0987654321', 'ngovantrong1308@gmail.com', '2003-08-13', '123456', 'NVQL726', 'Quản lý siêu thị', 1);

-- ======================================================================
-- 3. BẢNG KHÁCH HÀNG
-- ======================================================================
CREATE TABLE `khachhang_250` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `hoTen` VARCHAR(255) NOT NULL,
    `sdt` VARCHAR(20),
    `email` VARCHAR(255),
    `ngaySinh` DATE,
    `password` VARCHAR(255) NOT NULL,
    `maKH` VARCHAR(50) NOT NULL UNIQUE,
    `sieuThi_Id` INT DEFAULT 1,
    CONSTRAINT `fk_kh250_sieuthi` FOREIGN KEY (`sieuThi_Id`) REFERENCES `sieuthi_250`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `khachhang_250` (`id`, `hoTen`, `sdt`, `email`, `ngaySinh`, `password`, `maKH`, `sieuThi_Id`) VALUES
(1, 'Nguyễn Văn An', '0901111222', 'annv@gmail.com', '1995-03-15', '123456', 'KH001', 1),
(2, 'Trần Thị Bình', '0902222333', 'binhtt@gmail.com', '1998-07-22', '123456', 'KH002', 1),
(3, 'Lê Hoàng Cường', '0903333444', 'cuonglh@gmail.com', '1992-11-05', '123456', 'KH003', 1),
(4, 'Phạm Thu Dung', '0904444555', 'dungpt@gmail.com', '2000-02-18', '123456', 'KH004', 1);

-- ======================================================================
-- 4. BẢNG NHÂN VIÊN KHO
-- ======================================================================
CREATE TABLE `nvk_250` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `hoTen` VARCHAR(255) NOT NULL,
    `sdt` VARCHAR(20),
    `email` VARCHAR(255),
    `ngaySinh` DATE,
    `password` VARCHAR(255) NOT NULL,
    `maNV` VARCHAR(50) NOT NULL UNIQUE,
    `chucVu` VARCHAR(100),
    `sieuThi_Id` INT DEFAULT 1,
    CONSTRAINT `fk_nvk250_sieuthi` FOREIGN KEY (`sieuThi_Id`) REFERENCES `sieuthi_250`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `nvk_250` (`id`, `hoTen`, `sdt`, `email`, `ngaySinh`, `password`, `maNV`, `chucVu`, `sieuThi_Id`) VALUES
(1, 'Trần Văn Kho', '0913579246', 'khotv@ptit.edu.vn', '1992-05-10', '123456', 'NVK001', 'Thủ kho trưởng', 1),
(2, 'Lê Thị Thu', '0924681357', 'thult@ptit.edu.vn', '1996-08-20', '123456', 'NVK002', 'Nhân viên kiểm kê kho', 1);

-- ======================================================================
-- 5. BẢNG NHÀ CUNG CẤP
-- ======================================================================
CREATE TABLE `nhacungcap_250` (
    `id` VARCHAR(50) PRIMARY KEY,
    `maNCC` VARCHAR(50) UNIQUE,
    `ten` VARCHAR(255) NOT NULL,
    `diaChi` VARCHAR(255),
    `sdt` VARCHAR(20),
    `email` VARCHAR(255),
    `mota` TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `nhacungcap_250` (`id`, `maNCC`, `ten`, `diaChi`, `sdt`, `email`, `mota`) VALUES
('NCC001', 'NCC001', 'Công ty Cổ phần Sữa Việt Nam (Vinamilk)', 'Số 10 Tân Trào, P. Tân Phú, Quận 7, TP. Hồ Chí Minh', '02854155555', 'vinamilk@vinamilk.com.vn', 'Chuyên cung cấp các dòng sản phẩm sữa tươi, sữa hạt, sữa chua và kem cao cấp đạt chuẩn quốc tế.'),
('NCC002', 'NCC002', 'Công ty Cổ phần Acecook Việt Nam', 'Lô số II-3, Đường số 11, KCN Tân Bình, P. Tây Thạnh, Q. Tân Phú, TP. Hồ Chí Minh', '02838154064', 'contact@acecookvietnam.com', 'Nhà sản xuất thực phẩm đóng gói, mì ăn liền Hảo Hảo, phở Đệ Nhất, miến Phú Hương hàng đầu.'),
('NCC003', 'NCC003', 'Tập đoàn Masan Consumer', 'Tầng 12, Tòa nhà MPlaza Saigon, 39 Lê Duẩn, P. Bến Nghé, Quận 1, TP. Hồ Chí Minh', '02862563862', 'info@masangroup.com', 'Chuyên sản xuất nước mắm Nam Ngư, Chin-su, mì Kokomi, Omachi, nước tăng lực Wake-up 247.'),
('NCC004', 'NCC004', 'Công ty TNHH Thực phẩm Orion Vina', 'Tầng 22, Tòa nhà TTTM Pearl Plaza, 561A Điện Biên Phủ, P. 25, Q. Bình Thạnh, TP. Hồ Chí Minh', '02835123420', 'orion@orionworld.com', 'Sản xuất và phân phối độc quyền các loại bánh Chocopie, bánh Custas, bánh goute, snack Ostar.'),
('NCC005', 'NCC005', 'Công ty Cổ phần Tập đoàn Trung Nguyên', '82-84 Bùi Thị Xuân, Phường Bến Thành, Quận 1, TP. Hồ Chí Minh', '02839257666', 'office@trungnguyen.com.vn', 'Thương hiệu cà phê G7, cà phê rang xay nguyên chất, nước tăng lực số 1 Việt Nam.'),
('NCC006', 'NCC006', 'Công ty Cổ phần Chăn nuôi C.P. Việt Nam', 'Số 2, Đường 2A, KCN Biên Hòa 2, TP. Biên Hòa, Tỉnh Đồng Nai', '02513836251', 'contact@cp.com.vn', 'Nhà cung cấp thịt tươi sạch, xúc xích tiệt trùng, trứng gà và thủy hải sản đạt chuẩn VietGAP.');

-- ======================================================================
-- 6. BẢNG MẶT HÀNG
-- ======================================================================
CREATE TABLE `mathang_250` (
    `id` VARCHAR(50) PRIMARY KEY,
    `ten` VARCHAR(255) NOT NULL,
    `gia` DOUBLE NOT NULL DEFAULT 0,
    `donViTinh` VARCHAR(50) DEFAULT 'Cái',
    `mota` TEXT,
    `nhaCungCapId` VARCHAR(50),
    `soLuongTon` INT DEFAULT 0,
    CONSTRAINT `fk_mh250_ncc` FOREIGN KEY (`nhaCungCapId`) REFERENCES `nhacungcap_250`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `mathang_250` (`id`, `ten`, `gia`, `donViTinh`, `mota`, `nhaCungCapId`, `soLuongTon`) VALUES
('MH001', 'Sữa tươi tiệt trùng Vinamilk 100% 1L', 32000, 'Hộp', 'Sữa tươi nguyên chất tiệt trùng không đường/có đường giàu canxi và vitamin D3, tốt cho xương.', 'NCC001', 350),
('MH002', 'Gạo thơm thượng hạng ST25 túi 5kg', 185000, 'Túi', 'Gạo dẻo thơm ngon hảo hạng đạt giải Gạo ngon nhất thế giới, hạt thon dài trắng trong.', 'NCC001', 120),
('MH003', 'Dầu ăn cao cấp Neptune Gold 1L', 52000, 'Chai', 'Dầu thực vật tinh luyện tự nhiên hỗn hợp dầu đậu nành, dầu hướng dương và dầu gạo lứt nguyên chất.', 'NCC003', 240),
('MH004', 'Bánh quy bơ Hoàng Gia Danisa 454g', 125000, 'Hộp', 'Bánh quy bơ truyền thống Đan Mạch thơm ngậy vị bơ tự nhiên cao cấp, bao bì thiếc sang trọng.', 'NCC004', 85),
('MH005', 'Mì ăn liền Hảo Hảo tôm chua cay thùng 30 gói', 115000, 'Thùng', 'Mì tôm chua cay quốc dân vị đậm đà thơm lừng, sợi mì vàng giòn dai kích thích vị giác.', 'NCC002', 500),
('MH006', 'Sữa chua uống men sống Vinamilk Probi 65ml', 24000, 'Lốc 5 chai', 'Chứa 13 tỷ lợi khuẩn L.Casey 431 tăng cường đề kháng tiêu hóa, vị ngọt dịu thơm mát.', 'NCC001', 420),
('MH007', 'Nước mắm cá cơm Chin-su hảo hạng 500ml', 45000, 'Chai', 'Nước mắm cốt cá cơm đậm đà chuẩn vị, sánh quyện thơm hương cá chín, bữa ăn thêm đậm đà.', 'NCC003', 180),
('MH008', 'Bánh Chocopie Orion hộp 12 cái', 55000, 'Hộp', 'Bánh phủ socola mềm xốp với lớp nhân kem dẻo marshmallow truyền thống đậm đà khó quên.', 'NCC004', 310),
('MH009', 'Mì khoai tây Omachi sườn hầm ngũ quả thùng 30 gói', 215000, 'Thùng', 'Mì làm từ sợi khoai tây tự nhiên dai mướt kết hợp nước dùng sườn hầm ngũ quả đậm đà không lo nóng.', 'NCC003', 290);

-- ======================================================================
-- 7. BẢNG HÓA ĐƠN NHẬP
-- ======================================================================
CREATE TABLE `hoadonnhap_250` (
    `id` VARCHAR(50) PRIMARY KEY,
    `ngayNhap` DATE NOT NULL,
    `tongSoLuong` INT NOT NULL DEFAULT 0,
    `tongTien` DOUBLE NOT NULL DEFAULT 0,
    `nhaCungCapId` VARCHAR(50) NOT NULL,
    `maNVK` INT,
    CONSTRAINT `fk_hdn250_ncc` FOREIGN KEY (`nhaCungCapId`) REFERENCES `nhacungcap_250`(`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_hdn250_nvk` FOREIGN KEY (`maNVK`) REFERENCES `nvk_250`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `hoadonnhap_250` (`id`, `ngayNhap`, `tongSoLuong`, `tongTien`, `nhaCungCapId`, `maNVK`) VALUES
('HDN001', '2024-10-05', 850, 27500000, 'NCC001', 1),
('HDN002', '2024-10-12', 600, 23000000, 'NCC002', 2),
('HDN003', '2024-10-18', 420, 16800000, 'NCC001', 1),
('HDN004', '2024-10-22', 450, 22500000, 'NCC003', 1),
('HDN005', '2024-10-28', 350, 18500000, 'NCC004', 2),
('HDN006', '2024-11-02', 500, 16000000, 'NCC001', 1),
('HDN007', '2024-11-08', 400, 15000000, 'NCC002', 2),
('HDN008', '2024-11-15', 300, 15600000, 'NCC003', 1),
('HDN009', '2025-01-10', 500, 24000000, 'NCC003', 1),
('HDN010', '2026-05-15', 700, 21500000, 'NCC001', 1),
('HDN011', '2026-06-20', 500, 26000000, 'NCC004', 2);

-- ======================================================================
-- 8. BẢNG CHI TIẾT HÓA ĐƠN NHẬP
-- ======================================================================
CREATE TABLE `hdnchitiet_250` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `maHDN` VARCHAR(50) NOT NULL,
    `matHangId` VARCHAR(50) NOT NULL,
    `soLuong` INT NOT NULL,
    `giaNhap` DOUBLE NOT NULL,
    `thanhTien` DOUBLE NOT NULL,
    CONSTRAINT `fk_cthdn250_hdn` FOREIGN KEY (`maHDN`) REFERENCES `hoadonnhap_250`(`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_cthdn250_mh` FOREIGN KEY (`matHangId`) REFERENCES `mathang_250`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `hdnchitiet_250` (`maHDN`, `matHangId`, `soLuong`, `giaNhap`, `thanhTien`) VALUES
-- HDN001 (Vinamilk)
('HDN001', 'MH001', 500, 27000, 13500000),
('HDN001', 'MH006', 350, 40000, 14000000),

-- HDN002 (Acecook)
('HDN002', 'MH005', 600, 38333.33, 23000000),

-- HDN003 (Vinamilk)
('HDN003', 'MH001', 300, 28000, 8400000),
('HDN003', 'MH002', 120, 70000, 8400000),

-- HDN004 (Masan)
('HDN004', 'MH003', 250, 42000, 10500000),
('HDN004', 'MH007', 200, 60000, 12000000),

-- HDN005 (Orion)
('HDN005', 'MH004', 150, 70000, 10500000),
('HDN005', 'MH008', 200, 40000, 8000000),

-- HDN006 (Vinamilk)
('HDN006', 'MH001', 500, 32000, 16000000),

-- HDN007 (Acecook)
('HDN007', 'MH005', 400, 37500, 15000000),

-- HDN008 (Masan)
('HDN008', 'MH003', 300, 52000, 15600000),

-- HDN009 (Masan 2025)
('HDN009', 'MH007', 350, 54000, 18900000),
('HDN009', 'MH009', 150, 34000, 5100000),

-- HDN010 (Vinamilk 2026: 700 món)
('HDN010', 'MH001', 500, 28000, 14000000),
('HDN010', 'MH006', 200, 37500, 7500000),

-- HDN011 (Orion 2026: 500 món)
('HDN011', 'MH008', 400, 48000, 19200000),
('HDN011', 'MH004', 100, 68000, 6800000);

-- ======================================================================
-- STORED PROCEDURES 250
-- ======================================================================
DELIMITER $$

CREATE PROCEDURE `TimKiemMatHang250`(
    IN p_keyword VARCHAR(255)
)
BEGIN
    SELECT 
        m.id,
        m.ten,
        m.gia,
        COALESCE(m.donViTinh, 'Cái') AS donViTinh,
        m.mota,
        COALESCE(m.soLuongTon, 0) AS soLuongTon,
        m.nhaCungCapId,
        COALESCE(ncc.ten, 'Chưa xác định') AS tenNCC
    FROM `mathang_250` m
    LEFT JOIN `nhacungcap_250` ncc ON m.nhaCungCapId = ncc.id
    WHERE p_keyword IS NULL 
       OR p_keyword = '' 
       OR m.ten LIKE CONCAT('%', p_keyword, '%')
       OR m.mota LIKE CONCAT('%', p_keyword, '%')
       OR m.id LIKE CONCAT('%', p_keyword, '%')
    ORDER BY m.ten ASC;
END$$

CREATE PROCEDURE `GetMatHangById250`(
    IN p_id VARCHAR(50)
)
BEGIN
    SELECT 
        m.id,
        m.ten,
        m.gia,
        COALESCE(m.donViTinh, 'Cái') AS donViTinh,
        m.mota,
        COALESCE(m.soLuongTon, 0) AS soLuongTon,
        m.nhaCungCapId,
        COALESCE(ncc.ten, 'Chưa xác định') AS tenNCC,
        COALESCE(ncc.diaChi, 'N/A') AS diaChiNCC,
        COALESCE(ncc.sdt, 'N/A') AS sdtNCC,
        COALESCE(ncc.email, 'N/A') AS emailNCC
    FROM `mathang_250` m
    LEFT JOIN `nhacungcap_250` ncc ON m.nhaCungCapId = ncc.id
    WHERE m.id = p_id;
END$$

CREATE PROCEDURE `TKNCCTheoSLNhap250`(
    IN p_nbd DATE,
    IN p_nkt DATE
)
BEGIN
    SELECT 
        ncc.id AS `nccId`,
        ncc.maNCC AS `maNCC`,
        ncc.ten AS `tenNCC`,
        COALESCE(ncc.diaChi, 'Chưa cập nhật') AS `diaChi`,
        COALESCE(ncc.sdt, 'Chưa cập nhật') AS `sdt`,
        COALESCE(ncc.email, 'Chưa cập nhật') AS `email`,
        COUNT(DISTINCT hdn.id) AS `soLanNhap`,
        COALESCE(SUM(hdn.tongSoLuong), 0) AS `tongSoLuongNhap`,
        COALESCE(SUM(hdn.tongTien), 0) AS `tongGiaTriNhap`
    FROM `nhacungcap_250` ncc
    JOIN `hoadonnhap_250` hdn ON ncc.id = hdn.nhaCungCapId
    WHERE hdn.ngayNhap >= p_nbd AND hdn.ngayNhap <= p_nkt
    GROUP BY ncc.id, ncc.maNCC, ncc.ten, ncc.diaChi, ncc.sdt, ncc.email
    HAVING `tongSoLuongNhap` > 0
    ORDER BY `tongSoLuongNhap` DESC;
END$$

CREATE PROCEDURE `GetListHDNByNCC250`(
    IN p_nccId VARCHAR(50),
    IN p_nbd DATE,
    IN p_nkt DATE
)
BEGIN
    SELECT 
        hdn.id AS `maHDN`,
        hdn.ngayNhap AS `ngayNhap`,
        hdn.tongSoLuong AS `tongSoLuong`,
        hdn.tongTien AS `tongTien`,
        hdn.nhaCungCapId AS `nhaCungCapId`,
        ncc.ten AS `tenNCC`,
        hdn.maNVK AS `maNVK`,
        COALESCE(nvk.hoTen, 'Nhân viên kho') AS `tenNVK`
    FROM `hoadonnhap_250` hdn
    JOIN `nhacungcap_250` ncc ON hdn.nhaCungCapId = ncc.id
    LEFT JOIN `nvk_250` nvk ON hdn.maNVK = nvk.id
    WHERE hdn.nhaCungCapId = p_nccId
      AND hdn.ngayNhap >= p_nbd 
      AND hdn.ngayNhap <= p_nkt
    ORDER BY hdn.ngayNhap DESC;
END$$

CREATE PROCEDURE `GetChiTietHDN250`(
    IN p_maHDN VARCHAR(50)
)
BEGIN
    SELECT 
        ct.id AS `id`,
        ct.maHDN AS `maHDN`,
        ct.matHangId AS `matHangId`,
        m.ten AS `tenMatHang`,
        COALESCE(m.donViTinh, 'Cái') AS `donViTinh`,
        ct.soLuong AS `soLuong`,
        ct.giaNhap AS `giaNhap`,
        ct.thanhTien AS `thanhTien`
    FROM `hdnchitiet_250` ct
    JOIN `mathang_250` m ON ct.matHangId = m.id
    WHERE ct.maHDN = p_maHDN;
END$$

-- CÁC PROCEDURE 726 TƯƠNG THÍCH NGƯỢC
CREATE PROCEDURE `TimKiemMatHang726`(IN p_keyword VARCHAR(255))
BEGIN
    CALL TimKiemMatHang250(p_keyword);
END$$

CREATE PROCEDURE `GetMatHangById726`(IN p_id VARCHAR(50))
BEGIN
    CALL GetMatHangById250(p_id);
END$$

CREATE PROCEDURE `TKNCCTheoSLNhap726`(IN p_nbd DATE, IN p_nkt DATE)
BEGIN
    CALL TKNCCTheoSLNhap250(p_nbd, p_nkt);
END$$

CREATE PROCEDURE `GetListHDNByNCC726`(IN p_nccId VARCHAR(50), IN p_nbd DATE, IN p_nkt DATE)
BEGIN
    CALL GetListHDNByNCC250(p_nccId, p_nbd, p_nkt);
END$$

CREATE PROCEDURE `GetChiTietHDN726`(IN p_maHDN VARCHAR(50))
BEGIN
    CALL GetChiTietHDN250(p_maHDN);
END$$

DELIMITER ;

-- ======================================================================
-- TẠO CÁC VIEW TƯƠNG THÍCH NGƯỢC TÊN _726
-- ======================================================================
CREATE OR REPLACE VIEW `sieuthi_726` AS SELECT * FROM `sieuthi_250`;
CREATE OR REPLACE VIEW `nvql_726` AS SELECT * FROM `nvql_250`;
CREATE OR REPLACE VIEW `khachhang_726` AS SELECT * FROM `khachhang_250`;
CREATE OR REPLACE VIEW `nvk_726` AS SELECT * FROM `nvk_250`;
CREATE OR REPLACE VIEW `nhacungcap_726` AS SELECT * FROM `nhacungcap_250`;
CREATE OR REPLACE VIEW `mathang_726` AS SELECT * FROM `mathang_250`;
CREATE OR REPLACE VIEW `hoadonnhap_726` AS SELECT * FROM `hoadonnhap_250`;
CREATE OR REPLACE VIEW `hdnchitiet_726` AS SELECT * FROM `hdnchitiet_250`;

SET FOREIGN_KEY_CHECKS = 1;
