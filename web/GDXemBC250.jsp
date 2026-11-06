<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("GDDangNhap250.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Xem Báo Cáo Thống Kê - Hệ Thống Quản Lý Siêu Thị</title> 
    <link rel="icon" href="image/logo.png" type="image/x-icon">
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" crossorigin="anonymous">
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f9fa;
        }
        .header-bar {
            background-color: rgb(175, 0, 0);
            padding: 18px 25px;
            color: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.12);
            margin-bottom: 30px;
        }
        .manager-label {
            font-size: 22px;
            font-weight: bold;
        }
        .report-card {
            background: white;
            border-radius: 15px;
            padding: 35px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.08);
            max-width: 750px;
            margin: 0 auto 40px auto;
            border-top: 5px solid rgb(175, 0, 0);
        }
        .date-picker-label {
            font-size: 16px;
            font-weight: bold;
            color: #333;
            margin-bottom: 8px;
        }
        .date-picker {
            padding: 12px;
            font-size: 16px;
            border-radius: 8px;
            border: 1px solid #ced4da;
            width: 100%;
        }
        .btn-report {
            font-size: 17px;
            color: white;
            background-color: rgb(175, 0, 0);
            padding: 15px 30px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.2s;
            box-shadow: 0 3px 10px rgba(175,0,0,0.3);
        }
        .btn-report:hover {
            background-color: rgb(140, 0, 0);
            color: #ffeb3b;
            transform: translateY(-2px);
        }
    </style>
</head>

<body>
    <jsp:include page="Header250.jsp"></jsp:include>
    <jsp:include page="MenuQL250.jsp"></jsp:include>

    <div class="container mt-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><i class="fa fa-home mr-1"></i><a href="GDQL250.jsp">Trang chủ Quản lý</a></li>
                <li class="breadcrumb-item active" aria-current="page">Xem Báo Cáo</li>
            </ol>
        </nav>

        <!-- Header -->
        <div class="header-bar d-flex justify-content-between align-items-center">
            <div class="manager-label"><i class="fa fa-bar-chart mr-2"></i>BÁO CÁO THỐNG KÊ SIÊU THỊ</div>
            <a href="GDQL250.jsp" class="btn btn-outline-light"><i class="fa fa-arrow-left mr-1"></i> Quay lại</a>
        </div>

        <div class="report-card text-center">
            <h4 class="font-weight-bold text-danger mb-4">
                CHỌN KHOẢNG THỜI GIAN VÀ LOẠI BÁO CÁO
            </h4>

            <form action="GDTKNCC250.jsp" method="get" onsubmit="return validateDates()">
                <div class="form-row justify-content-center mb-4">
                    <div class="col-md-5 mb-3 text-left">
                        <label class="date-picker-label" for="start-date"><i class="fa fa-calendar mr-1"></i> Ngày bắt đầu:</label>
                        <input type="date" id="start-date" name="start-date" class="date-picker form-control" value="2024-10-01" required>
                    </div>
                    <div class="col-md-5 mb-3 text-left">
                        <label class="date-picker-label" for="end-date"><i class="fa fa-calendar-check-o mr-1"></i> Ngày kết thúc:</label>
                        <input type="date" id="end-date" name="end-date" class="date-picker form-control" value="2024-10-31" required>
                    </div>
                </div>

                <div class="alert alert-light border text-left p-3 mb-4">
                    <h6 class="font-weight-bold text-danger mb-2"><i class="fa fa-info-circle mr-1"></i>Gợi ý khoảng thời gian có sẵn dữ liệu mẫu:</h6>
                    <ul class="mb-0 small text-muted">
                        <li><strong>Tháng 10/2024:</strong> <code>2024-10-01</code> đến <code>2024-10-31</code> (Có nhiều đợt nhập hàng nhất từ các NCC: Vinamilk, Cái Lân, Acecook, TH True Milk, Orion)</li>
                        <li><strong>Tháng 11/2024:</strong> <code>2024-11-01</code> đến <code>2024-11-30</code></li>
                        <li><strong>Cả quý 4/2024:</strong> <code>2024-10-01</code> đến <code>2024-12-31</code></li>
                    </ul>
                </div>

                <!-- Nút chức năng đúng theo yêu cầu hình ảnh -->
                <button type="submit" class="btn btn-report btn-block py-3">
                    <i class="fa fa-truck mr-2"></i> THỐNG KÊ NHÀ CUNG CẤP THEO SỐ LƯỢNG HÀNG NHẬP
                </button>
            </form>
        </div>
    </div>

    <script>
        function validateDates() {
            const startDate = document.getElementById("start-date").value;
            const endDate = document.getElementById("end-date").value;

            if (!startDate || !endDate) {
                alert("Vui lòng chọn đầy đủ ngày bắt đầu và ngày kết thúc.");
                return false;
            }

            if (new Date(endDate) < new Date(startDate)) {
                alert("Ngày kết thúc không thể nhỏ hơn ngày bắt đầu.");
                return false;
            }

            return true;
        }
    </script>

    <jsp:include page="Footer250.jsp"></jsp:include>
</body>
</html>

