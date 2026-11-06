<%@page import="javax.servlet.http.HttpSession"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ Thống Quản Lý Siêu Thị</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" crossorigin="anonymous">
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    
    <style>
        body {
            background-color: #f7f9fa;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }

        /* Modern Hero Banner */
        .hero-banner {
            background: linear-gradient(135deg, #7f0000 0%, #b71c1c 45%, #c62828 100%);
            color: #ffffff;
            padding: 55px 20px 65px 20px;
            position: relative;
            box-shadow: inset 0 -10px 25px rgba(0,0,0,0.15);
        }

        .hero-title {
            font-size: 2.6rem;
            font-weight: 800;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            text-shadow: 0 2px 8px rgba(0,0,0,0.25);
            margin-bottom: 12px;
        }

        .hero-subtitle {
            font-size: 1.15rem;
            color: #ffebee;
            max-width: 780px;
            margin: 0 auto 30px auto;
            line-height: 1.6;
            font-weight: 400;
        }

        .hero-highlight-badges {
            display: flex;
            justify-content: center;
            gap: 25px;
            flex-wrap: wrap;
            margin-top: 15px;
        }

        .highlight-item {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(5px);
            padding: 8px 20px;
            border-radius: 30px;
            font-size: 0.95rem;
            font-weight: 600;
            border: 1px solid rgba(255, 255, 255, 0.25);
        }

        /* Search Hero Box */
        .search-hero-box {
            background: #ffffff;
            border-radius: 16px;
            padding: 28px 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin: -40px auto 40px auto;
            max-width: 900px;
            position: relative;
            z-index: 10;
            border: 1px solid rgba(0,0,0,0.06);
        }

        .search-input-group {
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .search-input-group .form-control {
            border: 2px solid #e0e0e0;
            border-right: none;
            padding: 14px 20px;
            font-size: 1.05rem;
            border-radius: 12px 0 0 12px;
        }

        .search-input-group .form-control:focus {
            border-color: #b71c1c;
            box-shadow: none;
        }

        .btn-search-hero {
            background-color: #b71c1c;
            color: #ffffff;
            font-weight: 700;
            padding: 0 30px;
            border: 2px solid #b71c1c;
            border-radius: 0 12px 12px 0;
            font-size: 1.05rem;
            transition: all 0.2s;
        }

        .btn-search-hero:hover {
            background-color: #8e0000;
            color: #ffeb3b;
            border-color: #8e0000;
        }

        .keyword-tag {
            background-color: #f1f3f5;
            color: #495057;
            padding: 5px 12px;
            border-radius: 15px;
            margin: 0 4px;
            font-weight: 600;
            font-size: 0.85rem;
            text-decoration: none;
            display: inline-block;
            transition: all 0.2s;
        }

        .keyword-tag:hover {
            background-color: #b71c1c;
            color: #ffffff;
            text-decoration: none;
        }

        /* Module Cards */
        .module-card {
            background: #ffffff;
            border: none;
            border-radius: 16px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.06);
            transition: all 0.3s ease;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .module-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 28px rgba(0, 0, 0, 0.12);
        }

        .module-header {
            padding: 24px 24px 15px 24px;
            display: flex;
            align-items: center;
        }

        .module-icon {
            width: 58px;
            height: 58px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.6rem;
            margin-right: 18px;
            flex-shrink: 0;
        }

        .module-icon-red {
            background: linear-gradient(135deg, #c62828, #e53935);
            color: #ffffff;
            box-shadow: 0 4px 12px rgba(198, 40, 40, 0.3);
        }

        .module-icon-dark {
            background: linear-gradient(135deg, #263238, #37474f);
            color: #ffffff;
            box-shadow: 0 4px 12px rgba(38, 50, 56, 0.3);
        }

        .module-body {
            padding: 0 24px 24px 24px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .module-features {
            list-style: none;
            padding-left: 0;
            margin-bottom: 22px;
        }

        .module-features li {
            padding: 6px 0;
            color: #555;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
        }

        .module-features li i {
            margin-right: 10px;
            font-size: 0.9rem;
        }

        .btn-module-red {
            background: #b71c1c;
            color: #ffffff;
            font-weight: 700;
            border-radius: 10px;
            padding: 12px 20px;
            text-align: center;
            text-decoration: none;
            margin-top: auto;
            transition: all 0.2s;
            display: block;
        }

        .btn-module-red:hover {
            background: #8e0000;
            color: #ffeb3b;
            text-decoration: none;
        }

        .btn-module-dark {
            background: #263238;
            color: #ffffff;
            font-weight: 700;
            border-radius: 10px;
            padding: 12px 20px;
            text-align: center;
            text-decoration: none;
            margin-top: auto;
            transition: all 0.2s;
            display: block;
        }

        .btn-module-dark:hover {
            background: #102027;
            color: #ffeb3b;
            text-decoration: none;
        }

        /* Feature section */
        .info-strip {
            background: #ffffff;
            border-radius: 14px;
            padding: 24px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.04);
            margin-top: 30px;
            margin-bottom: 30px;
        }

        .info-col {
            text-align: center;
            padding: 15px;
        }

        .info-col i {
            color: #b71c1c;
            font-size: 2.2rem;
            margin-bottom: 12px;
        }

        @media (max-width: 768px) {
            .hero-title {
                font-size: 1.8rem;
            }
            .hero-banner {
                padding: 40px 15px 50px 15px;
            }
            .search-hero-box {
                margin: -25px 15px 30px 15px;
                padding: 20px;
            }
        }
    </style>
</head>

<body>
    <!-- Top Header & Menu -->
    <jsp:include page="Header250.jsp"></jsp:include>
    <jsp:include page="Menu250.jsp"></jsp:include>

    <!-- Hero Banner -->
    <section class="hero-banner text-center">
        <div class="container">
            <h1 class="hero-title">HỆ THỐNG QUẢN LÝ SIÊU THỊ</h1>
            <p class="hero-subtitle">
                Giải pháp quản trị hàng hóa, tra cứu sản phẩm thông minh và phân tích thống kê chuỗi cung ứng siêu thị hiện đại, nhanh chóng và chính xác.
            </p>
            <div class="hero-highlight-badges">
                <div class="highlight-item">
                    <i class="fa fa-cubes mr-2 text-warning"></i>Hàng hóa đa dạng & rõ ràng
                </div>
                <div class="highlight-item">
                    <i class="fa fa-truck mr-2 text-warning"></i>Quản lý đối tác nhà cung cấp
                </div>
                <div class="highlight-item">
                    <i class="fa fa-bar-chart mr-2 text-warning"></i>Thống kê nhập kho chuẩn xác
                </div>
            </div>
        </div>
    </section>

    <!-- Quick Search Box -->
    <div class="container">
        <div class="search-hero-box">
            <h4 class="text-center font-weight-bold mb-3" style="color: #b71c1c;">
                <i class="fa fa-search mr-2"></i>Tra cứu thông tin mặt hàng
            </h4>
            <form action="GDTimMatHang250.jsp" method="get">
                <div class="input-group search-input-group mb-3">
                    <input type="text" name="keyword" class="form-control" 
                           placeholder="Nhập tên mặt hàng cần tìm kiếm (ví dụ: Sữa, Gạo, Dầu ăn, Bánh, Acecook...)..." autofocus>
                    <div class="input-group-append">
                        <button class="btn btn-search-hero" type="submit">
                            <i class="fa fa-search mr-1"></i> Tìm kiếm
                        </button>
                    </div>
                </div>
            </form>
            <div class="text-center">
                <small class="text-muted mr-2 font-weight-bold">Từ khóa phổ biến:</small>
                <a href="GDTimMatHang250.jsp?keyword=Sữa" class="keyword-tag"><i class="fa fa-tag mr-1"></i>Sữa tươi</a>
                <a href="GDTimMatHang250.jsp?keyword=Gạo" class="keyword-tag"><i class="fa fa-tag mr-1"></i>Gạo ST25</a>
                <a href="GDTimMatHang250.jsp?keyword=Dầu ăn" class="keyword-tag"><i class="fa fa-tag mr-1"></i>Dầu ăn</a>
                <a href="GDTimMatHang250.jsp?keyword=Mì" class="keyword-tag"><i class="fa fa-tag mr-1"></i>Mì Hảo Hảo</a>
                <a href="GDTimMatHang250.jsp?keyword=Bánh" class="keyword-tag"><i class="fa fa-tag mr-1"></i>Bánh quy</a>
                <a href="GDTimMatHang250.jsp?keyword=Vinamilk" class="keyword-tag"><i class="fa fa-tag mr-1"></i>Vinamilk</a>
                <a href="GDTimMatHang250.jsp" class="keyword-tag" style="background-color: #ffebee; color: #b71c1c;">
                    <i class="fa fa-list mr-1"></i>Tất cả mặt hàng
                </a>
            </div>
        </div>

        <!-- 2 Main Modules Cards -->
        <div class="row">
            <!-- Module 1: Khách hàng -->
            <div class="col-lg-6 mb-4">
                <div class="module-card">
                    <div class="module-header">
                        <div class="module-icon module-icon-red">
                            <i class="fa fa-shopping-basket"></i>
                        </div>
                        <div>
                            <span class="badge badge-danger px-2 py-1 mb-1">DÀNH CHO KHÁCH HÀNG</span>
                            <h4 class="font-weight-bold text-dark mb-0">Tìm Kiếm & Tra Cứu Mặt Hàng</h4>
                        </div>
                    </div>
                    <div class="module-body">
                        <p class="text-muted mb-3">
                            Phân hệ phục vụ khách hàng mua sắm, tra cứu thông tin sản phẩm có tại siêu thị một cách nhanh chóng và thuận tiện.
                        </p>
                        <ul class="module-features">
                            <li><i class="fa fa-check-circle text-success"></i>Nhập tên mặt hàng để tìm kiếm ngay lập tức</li>
                            <li><i class="fa fa-check-circle text-success"></i>Xem bảng danh sách kết quả chứa từ khóa tìm kiếm</li>
                            <li><i class="fa fa-check-circle text-success"></i>Click xem chi tiết: Quy cách, đơn giá, tồn kho và nhà cung cấp</li>
                            <li><i class="fa fa-check-circle text-success"></i>Giao diện thân thiện, tương thích mọi thiết bị</li>
                        </ul>
                        <a href="GDTimMatHang250.jsp" class="btn-module-red">
                            <i class="fa fa-search mr-2"></i>Truy cập Tìm Mặt Hàng
                        </a>
                    </div>
                </div>
            </div>

            <!-- Module 2: Quản lý -->
            <div class="col-lg-6 mb-4">
                <div class="module-card">
                    <div class="module-header">
                        <div class="module-icon module-icon-dark">
                            <i class="fa fa-line-chart"></i>
                        </div>
                        <div>
                            <span class="badge badge-dark px-2 py-1 mb-1">DÀNH CHO BAN QUẢN LÝ</span>
                            <h4 class="font-weight-bold text-dark mb-0">Thống Kê Nhà Cung Cấp</h4>
                        </div>
                    </div>
                    <div class="module-body">
                        <p class="text-muted mb-3">
                            Công cụ thống kê phân tích số lượng hàng hóa nhập từ các đối tác cung cấp nhằm tối ưu hóa chuỗi cung ứng siêu thị.
                        </p>
                        <ul class="module-features">
                            <li><i class="fa fa-check-circle text-primary"></i>Chọn khoảng thời gian (ngày bắt đầu - ngày kết thúc) để lọc báo cáo</li>
                            <li><i class="fa fa-check-circle text-primary"></i>Bảng xếp hạng nhà cung cấp theo tổng số lượng hàng nhập và giá trị</li>
                            <li><i class="fa fa-check-circle text-primary"></i>Xem lịch sử các lần nhập hàng (hóa đơn nhập) của từng nhà cung cấp</li>
                            <li><i class="fa fa-check-circle text-primary"></i>Truy xuất chi tiết danh sách mặt hàng và số lượng trong từng hóa đơn</li>
                        </ul>
                        <c:choose>
                            <c:when test="${sessionScope.user != null}">
                                <a href="GDXemBC250.jsp" class="btn-module-dark">
                                    <i class="fa fa-bar-chart mr-2"></i>Vào Báo Cáo Thống Kê
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="GDDangNhap250.jsp" class="btn-module-dark">
                                    <i class="fa fa-lock mr-2"></i>Đăng nhập để xem thống kê
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <!-- System Information Strip -->
        <div class="info-strip">
            <div class="row">
                <div class="col-md-4 info-col">
                    <i class="fa fa-database"></i>
                    <h5 class="font-weight-bold text-dark">Dữ Liệu Chuẩn Hóa</h5>
                    <p class="text-muted small mb-0">
                        Cơ sở dữ liệu được tổ chức theo kiến trúc phân tích thiết kế chuẩn, đáp ứng truy vấn khối lượng lớn với Stored Procedures.
                    </p>
                </div>
                <div class="col-md-4 info-col">
                    <i class="fa fa-bolt"></i>
                    <h5 class="font-weight-bold text-dark">Xử Lý Nhanh Chóng</h5>
                    <p class="text-muted small mb-0">
                        Mô hình MVC (Model - View - Controller) cùng DAO tối ưu hóa tốc độ kết nối và phản hồi tức thời cho người sử dụng.
                    </p>
                </div>
                <div class="col-md-4 info-col">
                    <i class="fa fa-shield"></i>
                    <h5 class="font-weight-bold text-dark">Bảo Mật & Phân Quyền</h5>
                    <p class="text-muted small mb-0">
                        Tách biệt rõ ràng quyền hạn tra cứu của khách hàng và quyền truy cập số liệu nội bộ của nhân viên quản lý siêu thị.
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="Footer250.jsp"></jsp:include>
</body>
</html>
