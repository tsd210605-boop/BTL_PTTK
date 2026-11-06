<%@page import="Entity250.HoaDonNhap250"%>
<%@page import="Entity250.TKNCC250"%>
<%@page import="DAO250.HoaDonNhap_DAO250"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
    <title>Danh Sách Các Lần Nhập Hàng - Hệ Thống Quản Lý Siêu Thị</title>
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
        .ncc-info-card {
            background: white;
            border-radius: 12px;
            padding: 22px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
            margin-bottom: 25px;
            border-left: 5px solid rgb(175, 0, 0);
        }
        .hdn-table-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.08);
            margin-bottom: 30px;
        }
        .hdn-table th {
            background-color: rgb(175, 0, 0);
            color: white;
            border: none;
            padding: 14px 10px;
            text-align: center;
        }
        .hdn-table td {
            vertical-align: middle;
            padding: 12px 10px;
        }
        .btn-view-invoice {
            background-color: #28a745;
            color: white;
            font-weight: bold;
            border-radius: 20px;
            padding: 6px 16px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-view-invoice:hover {
            background-color: #218838;
            color: white;
            text-decoration: none;
            box-shadow: 0 2px 8px rgba(40,167,69,0.4);
        }
    </style>
</head>

<body>
    <jsp:include page="Header250.jsp"></jsp:include>
    <jsp:include page="MenuQL250.jsp"></jsp:include>

    <%
        String nccId = request.getParameter("nccId");
        String startDate = request.getParameter("start-date");
        String endDate = request.getParameter("end-date");

        if (startDate == null || startDate.isEmpty()) startDate = (String) session.getAttribute("tkStartDate");
        if (endDate == null || endDate.isEmpty()) endDate = (String) session.getAttribute("tkEndDate");
        if (startDate == null || startDate.isEmpty()) startDate = "2024-10-01";
        if (endDate == null || endDate.isEmpty()) endDate = "2024-10-31";

        List<TKNCC250> dstk = (List<TKNCC250>) session.getAttribute("dstkNCC");
        TKNCC250 selectedNCC = null;

        if (dstk != null && nccId != null) {
            for (TKNCC250 ncc : dstk) {
                if (ncc.getId().equals(nccId)) {
                    selectedNCC = ncc;
                    break;
                }
            }
        }

        HoaDonNhap_DAO250 hdnDao = null;
        List<HoaDonNhap250> listHDN = null;
        String errorMsg = "";

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date nbdSql = new Date(sdf.parse(startDate).getTime());
            Date nktSql = new Date(sdf.parse(endDate).getTime());

            hdnDao = new HoaDonNhap_DAO250();
            listHDN = hdnDao.getListHDNByNCC(nccId, nbdSql, nktSql);

            // Lưu NCC đang chọn vào session để các trang sau tiện dùng
            if (selectedNCC != null) {
                session.setAttribute("selectedNCC", selectedNCC);
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorMsg = "Lỗi khi lấy danh sách hóa đơn nhập: " + e.getMessage();
        }
    %>

    <div class="container mt-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><i class="fa fa-home mr-1"></i><a href="GDQL250.jsp">Trang chủ Quản lý</a></li>
                <li class="breadcrumb-item"><a href="GDXemBC250.jsp">Xem Báo Cáo</a></li>
                <li class="breadcrumb-item"><a href="GDTKNCC250.jsp?start-date=<%= startDate %>&end-date=<%= endDate %>">Thống kê nhà cung cấp</a></li>
                <li class="breadcrumb-item active" aria-current="page">Danh sách lần nhập hàng</li>
            </ol>
        </nav>

        <!-- Header -->
        <div class="header-bar d-flex justify-content-between align-items-center">
            <div>
                <h4 class="mb-1 font-weight-bold"><i class="fa fa-history mr-2"></i>THỐNG KÊ CÁC LẦN NHẬP HÀNG CỦA NHÀ CUNG CẤP</h4>
                <small class="text-white-50">Khoảng thời gian: Từ <%= startDate %> đến <%= endDate %></small>
            </div>
            <a href="GDTKNCC250.jsp?start-date=<%= startDate %>&end-date=<%= endDate %>" class="btn btn-outline-light">
                <i class="fa fa-arrow-left mr-1"></i> Quay lại thống kê NCC
            </a>
        </div>

        <!-- Thông tin Nhà Cung Cấp -->
        <% if (selectedNCC != null) { %>
            <div class="ncc-info-card">
                <div class="row">
                    <div class="col-md-7 border-right">
                        <h4 class="font-weight-bold text-danger mb-2"><%= selectedNCC.getTen() %></h4>
                        <p class="mb-1"><strong><i class="fa fa-id-card-o mr-2"></i>Mã NCC:</strong> <span class="badge badge-secondary"><%= selectedNCC.getMaNCC() %></span></p>
                        <p class="mb-1"><strong><i class="fa fa-map-marker mr-2"></i>Địa chỉ:</strong> <%= selectedNCC.getDiaChi() %></p>
                        <p class="mb-1"><strong><i class="fa fa-phone mr-2"></i>Điện thoại:</strong> <%= selectedNCC.getSdt() %></p>
                        <p class="mb-0"><strong><i class="fa fa-envelope-o mr-2"></i>Email:</strong> <%= selectedNCC.getEmail() %></p>
                    </div>
                    <div class="col-md-5 my-auto text-center">
                        <div class="p-3 bg-light rounded">
                            <span class="text-muted small font-weight-bold d-block mb-1">TỔNG KẾT ĐỢT NHẬP HÀNG</span>
                            <div class="d-flex justify-content-around mt-2">
                                <div>
                                    <h4 class="font-weight-bold text-primary mb-0"><%= listHDN != null ? listHDN.size() : 0 %></h4>
                                    <small class="text-muted">Lần nhập</small>
                                </div>
                                <div>
                                    <h4 class="font-weight-bold text-danger mb-0"><%= String.format("%,d", selectedNCC.getTongSoLuongNhap()) %></h4>
                                    <small class="text-muted">Tổng SL nhập</small>
                                </div>
                                <div>
                                    <h5 class="font-weight-bold text-success mb-0 mt-1"><%= String.format("%,.0f", selectedNCC.getTongGiaTriNhap()) %> đ</h5>
                                    <small class="text-muted">Tổng tiền nhập</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        <% } %>

        <!-- Bảng danh sách các lần nhập hàng -->
        <div class="hdn-table-card">
            <h5 class="font-weight-bold text-danger mb-3">
                <i class="fa fa-file-text-o mr-2"></i>Danh sách các hóa đơn nhập hàng trong kỳ
            </h5>

            <% if (!errorMsg.isEmpty()) { %>
                <div class="alert alert-danger"><%= errorMsg %></div>
            <% } else if (listHDN != null && !listHDN.isEmpty()) { %>
                <table class="table table-hover table-striped hdn-table mb-0">
                    <thead>
                        <tr>
                            <th style="width: 5%;">STT</th>
                            <th style="width: 15%;">Mã Hóa Đơn Nhập</th>
                            <th style="width: 15%;">Ngày nhập hàng</th>
                            <th style="width: 20%; text-align: left;">Nhân viên kho tiếp nhận</th>
                            <th style="width: 15%;">Tổng số lượng nhập</th>
                            <th style="width: 18%; text-align: right;">Tổng tiền hóa đơn</th>
                            <th style="width: 12%;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (int i = 0; i < listHDN.size(); i++) {
                                HoaDonNhap250 hdn = listHDN.get(i);
                        %>
                        <tr>
                            <td class="text-center font-weight-bold"><%= i + 1 %></td>
                            <td class="text-center"><span class="badge badge-dark px-2 py-1"><%= hdn.getId() %></span></td>
                            <td class="text-center font-weight-bold text-primary"><%= hdn.getNgayNhap() %></td>
                            <td><i class="fa fa-user-circle text-muted mr-1"></i><%= hdn.getTenNVK() %></td>
                            <td class="text-center font-weight-bold text-danger" style="font-size: 1.1rem;"><%= String.format("%,d", hdn.getTongSoLuong()) %></td>
                            <td class="text-right font-weight-bold text-dark"><%= String.format("%,.0f", hdn.getTongTien()) %> VND</td>
                            <td class="text-center">
                                <!-- Click xem một lần nhập -> xem hóa đơn -->
                                <a href="GDChiTietHDN250.jsp?maHDN=<%= hdn.getId() %>&nccId=<%= nccId %>&start-date=<%= startDate %>&end-date=<%= endDate %>" 
                                   class="btn btn-view-invoice btn-sm">
                                    <i class="fa fa-file-text mr-1"></i> Xem hóa đơn
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <div class="text-center py-5">
                    <i class="fa fa-info-circle fa-3x text-muted mb-3"></i>
                    <h5 class="text-muted">Không tìm thấy lần nhập hàng nào của nhà cung cấp này trong khoảng thời gian đã chọn.</h5>
                    <a href="GDTKNCC250.jsp?start-date=<%= startDate %>&end-date=<%= endDate %>" class="btn btn-secondary mt-2">
                        <i class="fa fa-arrow-left mr-1"></i> Quay lại danh sách nhà cung cấp
                    </a>
                </div>
            <% } %>
        </div>
    </div>

    <jsp:include page="Footer250.jsp"></jsp:include>
</body>
</html>

