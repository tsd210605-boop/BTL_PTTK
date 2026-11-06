<%@page import="Entity250.HDNChiTiet250"%>
<%@page import="Entity250.HoaDonNhap250"%>
<%@page import="DAO250.HoaDonNhap_DAO250"%>
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
    <title>Hóa Đơn Nhập Hàng - Hệ Thống Quản Lý Siêu Thị</title>
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
        .invoice-card {
            background: white;
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            max-width: 900px;
            margin: 0 auto 40px auto;
            border-top: 6px solid rgb(175, 0, 0);
        }
        .invoice-header-title {
            color: rgb(175, 0, 0);
            font-weight: bold;
            font-size: 26px;
            letter-spacing: 1px;
        }
        .invoice-meta-box {
            background-color: #fafbfc;
            border: 1px solid #e9ecef;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 25px;
        }
        .invoice-table th {
            background-color: rgb(175, 0, 0);
            color: white;
            border: none;
            padding: 12px;
            text-align: center;
        }
        .invoice-table td {
            vertical-align: middle;
            padding: 12px;
        }
        .total-box {
            background-color: #fff9f9;
            border: 2px dashed rgb(175, 0, 0);
            border-radius: 10px;
            padding: 20px;
        }
        .signature-box {
            margin-top: 40px;
            margin-bottom: 30px;
        }
        @media print {
            .no-print {
                display: none !important;
            }
            .invoice-card {
                box-shadow: none;
                border: none;
                padding: 0;
            }
        }
    </style>
</head>

<body>
    <div class="no-print">
        <jsp:include page="Header250.jsp"></jsp:include>
        <jsp:include page="MenuQL250.jsp"></jsp:include>
    </div>

    <%
        String maHDN = request.getParameter("maHDN");
        String nccId = request.getParameter("nccId");
        String startDate = request.getParameter("start-date");
        String endDate = request.getParameter("end-date");

        if (startDate == null || startDate.isEmpty()) startDate = (String) session.getAttribute("tkStartDate");
        if (endDate == null || endDate.isEmpty()) endDate = (String) session.getAttribute("tkEndDate");

        HoaDonNhap_DAO250 dao = null;
        HoaDonNhap250 hdn = null;
        List<HDNChiTiet250> listChiTiet = null;
        String errorMsg = "";

        if (maHDN == null || maHDN.trim().isEmpty()) {
            errorMsg = "Không tìm thấy mã hóa đơn nhập!";
        } else {
            try {
                dao = new HoaDonNhap_DAO250();
                hdn = dao.getHDNById(maHDN.trim());
                listChiTiet = dao.getChiTietHDN(maHDN.trim());

                if (hdn == null) {
                    errorMsg = "Không tìm thấy thông tin hóa đơn nhập mã: " + maHDN;
                }
            } catch (Exception e) {
                e.printStackTrace();
                errorMsg = "Lỗi truy vấn cơ sở dữ liệu: " + e.getMessage();
            }
        }
    %>

    <div class="container mt-4">
        <!-- Breadcrumb -->
        <div class="no-print">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><i class="fa fa-home mr-1"></i><a href="GDQL250.jsp">Trang chủ Quản lý</a></li>
                    <li class="breadcrumb-item"><a href="GDXemBC250.jsp">Xem Báo Cáo</a></li>
                    <li class="breadcrumb-item"><a href="GDTKNCC250.jsp?start-date=<%= startDate %>&end-date=<%= endDate %>">Thống kê nhà cung cấp</a></li>
                    <% if (nccId != null && !nccId.isEmpty()) { %>
                        <li class="breadcrumb-item"><a href="GDListHDN250.jsp?nccId=<%= nccId %>&start-date=<%= startDate %>&end-date=<%= endDate %>">Danh sách lần nhập</a></li>
                    <% } %>
                    <li class="breadcrumb-item active" aria-current="page">Hóa đơn <%= maHDN %></li>
                </ol>
            </nav>
        </div>

        <% if (!errorMsg.isEmpty()) { %>
            <div class="alert alert-danger p-4 text-center">
                <h5><i class="fa fa-exclamation-triangle mr-2"></i><%= errorMsg %></h5>
                <a href="javascript:history.back()" class="btn btn-secondary mt-3"><i class="fa fa-arrow-left mr-1"></i> Quay lại</a>
            </div>
        <% } else if (hdn != null) { %>
            <!-- Khung Hóa Đơn Nhập Chi Tiết -->
            <div class="invoice-card">
                <!-- Tiêu đề và logo đơn vị -->
                <div class="row align-items-center mb-4">
                    <div class="col-sm-3 text-center text-sm-left">
                        <div style="width: 75px; height: 75px; background: linear-gradient(135deg, rgb(175,0,0), rgb(220,20,20)); border-radius: 12px; display: inline-flex; align-items: center; justify-content: center; color: white; box-shadow: 0 4px 12px rgba(175,0,0,0.3);"><i class="fa fa-shopping-cart fa-2x"></i></div>
                    </div>
                    <div class="col-sm-9 text-center text-sm-right">
                        <h4 class="font-weight-bold text-danger mb-1">HỆ THỐNG QUẢN LÝ SIÊU THỊ</h4>
                        <p class="mb-0 text-muted small"><i class="fa fa-map-marker mr-1"></i>Trung tâm điều hành và phân phối Siêu thị</p>
                        <p class="mb-0 text-muted small"><i class="fa fa-phone mr-1"></i>Hotline: 1900 8888 | Email: contact@sieuthi.vn</p>
                    </div>
                </div>

                <hr style="border-top: 2px solid #ddd;" class="mb-4">

                <div class="text-center mb-4">
                    <h2 class="invoice-header-title">HÓA ĐƠN NHẬP HÀNG</h2>
                    <h5 class="text-muted font-weight-bold">MÃ PHIẾU: <span class="badge badge-danger px-3 py-1"><%= hdn.getId() %></span></h5>
                    <p class="text-muted"><i class="fa fa-calendar mr-1"></i>Ngày lập hóa đơn: <strong><%= hdn.getNgayNhap() %></strong></p>
                </div>

                <!-- Thông tin các bên -->
                <div class="invoice-meta-box">
                    <div class="row">
                        <div class="col-md-6 border-right">
                            <h6 class="font-weight-bold text-danger mb-2"><i class="fa fa-truck mr-1"></i>ĐƠN VỊ GIAO HÀNG (NHÀ CUNG CẤP):</h6>
                            <p class="mb-1"><strong><%= hdn.getTenNCC() %></strong></p>
                            <p class="mb-1 text-muted small">Mã NCC: <span class="badge badge-secondary"><%= hdn.getNhaCungCapId() %></span></p>
                        </div>
                        <div class="col-md-6 pl-md-4">
                            <h6 class="font-weight-bold text-danger mb-2"><i class="fa fa-building mr-1"></i>ĐƠN VỊ NHẬN HÀNG (KHO SIÊU THỊ):</h6>
                            <p class="mb-1"><strong>Kho Tổng Hệ Thống Quản Lý Siêu Thị</strong></p>
                            <p class="mb-1 text-muted small">Nhân viên tiếp nhận kho: <strong><%= hdn.getTenNVK() %></strong> (Mã: NVK<%= hdn.getMaNVK() %>)</p>
                        </div>
                    </div>
                </div>

                <!-- Bảng chi tiết các mặt hàng trong lần nhập -->
                <h5 class="font-weight-bold text-dark mb-3"><i class="fa fa-list mr-1"></i>Danh sách các mặt hàng nhập</h5>
                <table class="table table-bordered invoice-table mb-4">
                    <thead>
                        <tr>
                            <th style="width: 5%;">STT</th>
                            <th style="width: 15%;">Mã MH</th>
                            <th style="width: 35%; text-align: left;">Tên mặt hàng</th>
                            <th style="width: 10%;">ĐVT</th>
                            <th style="width: 10%;">Số lượng</th>
                            <th style="width: 12%; text-align: right;">Đơn giá nhập</th>
                            <th style="width: 13%; text-align: right;">Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int tongSL = 0;
                            double tongTien = 0;
                            if (listChiTiet != null && !listChiTiet.isEmpty()) {
                                for (int i = 0; i < listChiTiet.size(); i++) {
                                    HDNChiTiet250 ct = listChiTiet.get(i);
                                    tongSL += ct.getSoLuong();
                                    tongTien += ct.getThanhTien();
                        %>
                        <tr>
                            <td class="text-center font-weight-bold"><%= i + 1 %></td>
                            <td class="text-center"><span class="badge badge-secondary"><%= ct.getMatHangId() %></span></td>
                            <td><strong><%= ct.getTenMatHang() %></strong></td>
                            <td class="text-center"><%= ct.getDonViTinh() %></td>
                            <td class="text-center font-weight-bold text-danger"><%= String.format("%,d", ct.getSoLuong()) %></td>
                            <td class="text-right"><%= String.format("%,.0f", ct.getGiaNhap()) %> đ</td>
                            <td class="text-right font-weight-bold text-dark"><%= String.format("%,.0f", ct.getThanhTien()) %> đ</td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="7" class="text-center text-muted py-4">Không có chi tiết mặt hàng cho hóa đơn này.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>

                <!-- Tổng kết hóa đơn -->
                <div class="total-box">
                    <div class="row align-items-center">
                        <div class="col-sm-6">
                            <p class="mb-1 text-muted">Tổng số lượng sản phẩm nhập:</p>
                            <h4 class="font-weight-bold text-danger mb-0"><%= String.format("%,d", tongSL) %> sản phẩm</h4>
                        </div>
                        <div class="col-sm-6 text-sm-right mt-3 mt-sm-0">
                            <p class="mb-1 text-muted">TỔNG CỘNG TIỀN THANH TOÁN:</p>
                            <h3 class="font-weight-bold text-danger mb-0"><%= String.format("%,.0f", tongTien > 0 ? tongTien : hdn.getTongTien()) %> VND</h3>
                        </div>
                    </div>
                </div>

                <!-- Chữ ký xác nhận hai bên -->
                <div class="row signature-box text-center">
                    <div class="col-6">
                        <p class="font-weight-bold mb-1">ĐẠI DIỆN BÊN GIAO HÀNG</p>
                        <small class="text-muted d-block mb-5">(Ký, ghi rõ họ tên)</small>
                        <p class="font-weight-bold mt-4 text-muted"><%= hdn.getTenNCC() %></p>
                    </div>
                    <div class="col-6">
                        <p class="font-weight-bold mb-1">THỦ KHO TIẾP NHẬN</p>
                        <small class="text-muted d-block mb-5">(Ký, ghi rõ họ tên)</small>
                        <p class="font-weight-bold mt-4 text-danger"><%= hdn.getTenNVK() %></p>
                    </div>
                </div>

                <!-- Nút thao tác (không hiển thị khi in) -->
                <div class="no-print mt-4 pt-3 border-top d-flex justify-content-between align-items-center">
                    <div>
                        <% if (nccId != null && !nccId.isEmpty()) { %>
                            <a href="GDListHDN250.jsp?nccId=<%= nccId %>&start-date=<%= startDate %>&end-date=<%= endDate %>" class="btn btn-secondary mr-2">
                                <i class="fa fa-arrow-left mr-1"></i> Quay lại danh sách lần nhập
                            </a>
                        <% } else { %>
                            <a href="javascript:history.back()" class="btn btn-secondary mr-2">
                                <i class="fa fa-arrow-left mr-1"></i> Quay lại
                            </a>
                        <% } %>
                        <a href="GDTKNCC250.jsp?start-date=<%= startDate %>&end-date=<%= endDate %>" class="btn btn-outline-danger">
                            <i class="fa fa-bar-chart mr-1"></i> Thống kê NCC
                        </a>
                    </div>
                    <div>
                        <button onclick="window.print()" class="btn btn-success font-weight-bold px-4">
                            <i class="fa fa-print mr-1"></i> In hóa đơn
                        </button>
                    </div>
                </div>
            </div>
        <% } %>
    </div>

    <div class="no-print">
        <jsp:include page="Footer250.jsp"></jsp:include>
    </div>
</body>
</html>

