<%@page import="Entity250.TKNCC250"%>
<%@page import="DAO250.TKNCC_DAO250"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <title>Thống Kê Nhà Cung Cấp - Hệ Thống Quản Lý Siêu Thị</title>
    <link rel="icon" href="image/logo.png" type="image/x-icon">
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" crossorigin="anonymous">
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <style>
        body {
            background-color: #f7f9fa;
        }
        .header-bar {
            background-color: rgb(175, 0, 0);
            padding: 16px 25px;
            color: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.12);
            margin-bottom: 25px;
        }
        .report-summary-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
            margin-bottom: 25px;
            border-left: 5px solid rgb(175, 0, 0);
        }
        .stats-table-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.08);
            margin-bottom: 30px;
        }
        .stats-table th {
            background-color: rgb(175, 0, 0);
            color: white;
            border: none;
            padding: 14px 10px;
            text-align: center;
            vertical-align: middle;
        }
        .stats-table td {
            vertical-align: middle;
            padding: 12px 10px;
        }
        .qty-highlight {
            font-weight: bold;
            font-size: 1.15rem;
            color: #d9534f;
        }
        .btn-select {
            background-color: rgb(175, 0, 0);
            color: white;
            font-weight: bold;
            border-radius: 20px;
            padding: 6px 18px;
            border: none;
            transition: all 0.2s;
        }
        .btn-select:hover {
            background-color: #ffeb3b;
            color: rgb(175, 0, 0);
            transform: scale(1.05);
        }
    </style>
</head>

<body>
    <jsp:include page="Header250.jsp"></jsp:include>
    <jsp:include page="MenuQL250.jsp"></jsp:include>

    <%
        String startDate = request.getParameter("start-date");
        String endDate = request.getParameter("end-date");

        if (startDate == null || startDate.isEmpty()) startDate = "2024-10-01";
        if (endDate == null || endDate.isEmpty()) endDate = "2024-10-31";

        TKNCC_DAO250 dao = null;
        List<TKNCC250> dstk = null;
        String errorMsg = "";
        int tongSoLuongToanBo = 0;
        double tongGiaTriToanBo = 0;

        try {
            dao = new TKNCC_DAO250();
            dstk = dao.getTKNCC(startDate, endDate);
            session.setAttribute("dstkNCC", dstk);
            session.setAttribute("tkStartDate", startDate);
            session.setAttribute("tkEndDate", endDate);

            if (dstk != null) {
                for (TKNCC250 tk : dstk) {
                    tongSoLuongToanBo += tk.getTongSoLuongNhap();
                    tongGiaTriToanBo += tk.getTongGiaTriNhap();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorMsg = "Lỗi khi lấy dữ liệu thống kê: " + e.getMessage();
        }
    %>

    <div class="container mt-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><i class="fa fa-home mr-1"></i><a href="GDQL250.jsp">Trang chủ Quản lý</a></li>
                <li class="breadcrumb-item"><a href="GDXemBC250.jsp">Xem Báo Cáo</a></li>
                <li class="breadcrumb-item active" aria-current="page">Thống kê nhà cung cấp theo số lượng hàng nhập</li>
            </ol>
        </nav>

        <!-- Header -->
        <div class="header-bar d-flex justify-content-between align-items-center">
            <div>
                <h4 class="mb-1 font-weight-bold"><i class="fa fa-truck mr-2"></i>THỐNG KÊ NHÀ CUNG CẤP THEO SỐ LƯỢNG HÀNG NHẬP</h4>
                <small class="text-white-50">Sắp xếp theo thứ tự tổng số lượng hàng nhập giảm dần</small>
            </div>
            <a href="GDXemBC250.jsp" class="btn btn-outline-light"><i class="fa fa-arrow-left mr-1"></i> Đổi khoảng ngày</a>
        </div>

        <!-- Summary Banner -->
        <div class="report-summary-card">
            <div class="row align-items-center text-center">
                <div class="col-md-3 border-right">
                    <span class="text-muted d-block small">KHOẢNG THỜI GIAN</span>
                    <strong><%= startDate %></strong> <span class="text-muted">đến</span> <strong><%= endDate %></strong>
                </div>
                <div class="col-md-3 border-right">
                    <span class="text-muted d-block small">SỐ NHÀ CUNG CẤP CÓ NHẬP HÀNG</span>
                    <h4 class="font-weight-bold text-dark mb-0"><%= dstk != null ? dstk.size() : 0 %> NCC</h4>
                </div>
                <div class="col-md-3 border-right">
                    <span class="text-muted d-block small">TỔNG SỐ LƯỢNG HÀNG NHẬP</span>
                    <h4 class="font-weight-bold text-danger mb-0"><%= String.format("%,d", tongSoLuongToanBo) %> SP</h4>
                </div>
                <div class="col-md-3">
                    <span class="text-muted d-block small">TỔNG GIÁ TRỊ NHẬP HÀNG</span>
                    <h4 class="font-weight-bold text-success mb-0"><%= String.format("%,.0f", tongGiaTriToanBo) %> đ</h4>
                </div>
            </div>
        </div>

        <!-- Bảng Thống kê Nhà Cung Cấp -->
        <div class="stats-table-card">
            <h5 class="font-weight-bold text-danger mb-3">
                <i class="fa fa-list-ol mr-2"></i>Bảng xếp hạng Nhà cung cấp theo số lượng hàng nhập
            </h5>

            <% if (!errorMsg.isEmpty()) { %>
                <div class="alert alert-danger"><%= errorMsg %></div>
            <% } else if (dstk != null && !dstk.isEmpty()) { %>
                <table class="table table-hover table-striped stats-table mb-0">
                    <thead>
                        <tr>
                            <th style="width: 5%;">STT</th>
                            <th style="width: 10%;">Mã NCC</th>
                            <th style="width: 25%; text-align: left;">Tên Nhà Cung Cấp</th>
                            <th style="width: 18%; text-align: left;">Địa chỉ</th>
                            <th style="width: 12%;">Số điện thoại</th>
                            <th style="width: 12%;">Tổng SL nhập</th>
                            <th style="width: 10%;">Số lần nhập</th>
                            <th style="width: 15%; text-align: right;">Tổng tiền nhập</th>
                            <th style="width: 13%;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (int i = 0; i < dstk.size(); i++) {
                                TKNCC250 ncc = dstk.get(i);
                        %>
                        <tr>
                            <td class="text-center font-weight-bold"><%= i + 1 %></td>
                            <td class="text-center"><span class="badge badge-secondary"><%= ncc.getMaNCC() %></span></td>
                            <td>
                                <strong><%= ncc.getTen() %></strong>
                                <% if (ncc.getEmail() != null && !ncc.getEmail().isEmpty()) { %>
                                    <br><small class="text-muted"><i class="fa fa-envelope-o mr-1"></i><%= ncc.getEmail() %></small>
                                <% } %>
                            </td>
                            <td><small><%= ncc.getDiaChi() %></small></td>
                            <td class="text-center"><%= ncc.getSdt() %></td>
                            <td class="text-center qty-highlight"><%= String.format("%,d", ncc.getTongSoLuongNhap()) %></td>
                            <td class="text-center font-weight-bold"><%= ncc.getSoLanNhap() %> lần</td>
                            <td class="text-right text-dark font-weight-bold"><%= String.format("%,.0f", ncc.getTongGiaTriNhap()) %> đ</td>
                            <td class="text-center">
                                <!-- Click vào một nhà cung cấp xem chi tiết -->
                                <a href="GDListHDN250.jsp?nccId=<%= ncc.getId() %>&start-date=<%= startDate %>&end-date=<%= endDate %>" 
                                   class="btn btn-select btn-sm">
                                    <i class="fa fa-eye mr-1"></i> Xem chi tiết
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <div class="text-center py-5">
                    <i class="fa fa-info-circle fa-3x text-muted mb-3"></i>
                    <h5 class="text-muted">Không có dữ liệu nhập hàng nào từ nhà cung cấp trong khoảng thời gian từ <%= startDate %> đến <%= endDate %>.</h5>
                    <p class="text-muted">Vui lòng thử chọn khoảng ngày khác (ví dụ: từ <code>2024-10-01</code> đến <code>2024-10-31</code>).</p>
                    <a href="GDXemBC250.jsp" class="btn btn-danger mt-2 font-weight-bold"><i class="fa fa-calendar mr-1"></i> Chọn lại khoảng ngày</a>
                </div>
            <% } %>
        </div>
    </div>

    <jsp:include page="Footer250.jsp"></jsp:include>
</body>
</html>

