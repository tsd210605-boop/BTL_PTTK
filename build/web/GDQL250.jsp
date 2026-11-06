<%@page import="javax.servlet.http.HttpSession"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("GDDangNhap250.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="icon" href="image/logo.png" type="image/x-icon">
    <title>Giao diện Quản Lý - Hệ Thống Quản Lý Siêu Thị</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" crossorigin="anonymous">
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <style>
        .ql-hero {
            background: linear-gradient(135deg, rgb(175, 0, 0), #800000);
            color: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.15);
            margin-bottom: 30px;
        }
        .action-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            transition: all 0.3s;
            overflow: hidden;
        }
        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .card-icon {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            color: white;
        }
    </style>
</head>

<body style="background-color: #f7f9fa;">
    <jsp:include page="Header250.jsp"></jsp:include>
    <jsp:include page="MenuQL250.jsp"></jsp:include>

    <div class="container mt-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><i class="fa fa-home mr-1"></i><a href="GDQL250.jsp">Trang chủ Quản lý</a></li>
                <li class="breadcrumb-item active" aria-current="page">Bảng điều khiển</li>
            </ol>
        </nav>

        <!-- Welcome Banner -->
        <div class="ql-hero text-center">
            <h2 class="font-weight-bold mb-2">CHÀO MỪNG QUẢN LÝ: ${sessionScope.user.hoTen}</h2>
            <p class="mb-0 text-white-50">Chức vụ: ${sessionScope.user.chucVu} | Mã nhân viên: ${sessionScope.user.maNV}</p>
        </div>

        <!-- Dashboard Actions -->
        <div class="row mb-5">
            <div class="col-md-6 mb-4">
                <div class="card action-card h-100 p-4 text-center">
                    <div class="card-icon" style="background-color: rgb(175, 0, 0);">
                        <i class="fa fa-line-chart fa-2x"></i>
                    </div>
                    <h4 class="font-weight-bold text-danger">Xem Báo Cáo Thống Kê</h4>
                    <p class="text-muted">
                        Thống kê các nhà cung cấp theo tổng số lượng hàng nhập trong khoảng thời gian, xem chi tiết các lần nhập hàng và hóa đơn nhập chi tiết.
                    </p>
                    <a href="GDXemBC250.jsp" class="btn btn-danger btn-lg mt-auto font-weight-bold">
                        <i class="fa fa-bar-chart mr-1"></i> Truy cập Xem Báo Cáo
                    </a>
                </div>
            </div>

            <div class="col-md-6 mb-4">
                <div class="card action-card h-100 p-4 text-center">
                    <div class="card-icon" style="background-color: #007bff;">
                        <i class="fa fa-search fa-2x"></i>
                    </div>
                    <h4 class="font-weight-bold text-primary">Tìm Kiếm Mặt Hàng</h4>
                    <p class="text-muted">
                        Tra cứu nhanh danh sách các mặt hàng trong siêu thị, kiểm tra đơn giá, tồn kho và thông tin nhà phân phối cung cấp sản phẩm.
                    </p>
                    <a href="GDTimMatHang250.jsp" class="btn btn-primary btn-lg mt-auto font-weight-bold">
                        <i class="fa fa-search mr-1"></i> Tìm Kiếm Mặt Hàng
                    </a>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="Footer250.jsp"></jsp:include>
</body>
</html>

