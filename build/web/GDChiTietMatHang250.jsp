<%@page import="Entity250.MatHang250"%>
<%@page import="DAO250.MatHang_DAO250"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chi Tiết Mặt Hàng - Hệ Thống Quản Lý Siêu Thị</title>
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
        .detail-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            border-top: 4px solid rgb(175, 0, 0);
            overflow: hidden;
            margin-bottom: 30px;
        }
        .price-highlight {
            font-size: 2rem;
            font-weight: bold;
            color: #d9534f;
        }
        .info-label {
            font-weight: bold;
            color: #555;
            width: 160px;
            display: inline-block;
        }
        .supplier-box {
            background-color: #fdf7f7;
            border: 2px dashed rgb(175, 0, 0);
            border-radius: 12px;
            padding: 20px;
            margin-top: 20px;
        }
        .btn-custom-red {
            background-color: rgb(175, 0, 0);
            color: white;
            font-weight: bold;
        }
        .btn-custom-red:hover {
            background-color: rgb(140, 0, 0);
            color: white;
        }
    </style>
</head>

<body>
    <jsp:include page="Header250.jsp"></jsp:include>
    <c:choose>
        <c:when test="${sessionScope.user != null}">
            <jsp:include page="MenuQL250.jsp"></jsp:include>
        </c:when>
        <c:otherwise>
            <jsp:include page="Menu250.jsp"></jsp:include>
        </c:otherwise>
    </c:choose>

    <%
        String id = request.getParameter("id");
        MatHang250 mh = null;
        String errorMsg = "";

        if (id == null || id.trim().isEmpty()) {
            errorMsg = "Không tìm thấy mã mặt hàng!";
        } else {
            try {
                MatHang_DAO250 dao = new MatHang_DAO250();
                mh = dao.getMatHangById(id.trim());
                if (mh == null) {
                    errorMsg = "Mặt hàng với mã " + id + " không tồn tại trên hệ thống.";
                }
            } catch (Exception e) {
                e.printStackTrace();
                errorMsg = "Lỗi truy vấn cơ sở dữ liệu: " + e.getMessage();
            }
        }
    %>

    <div class="container mt-3">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><i class="fa fa-home mr-1"></i><a href="Trangchu250.jsp">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="GDTimMatHang250.jsp">Tìm kiếm mặt hàng</a></li>
                <li class="breadcrumb-item active" aria-current="page">
                    <%= mh != null ? mh.getTen() : "Chi tiết mặt hàng" %>
                </li>
            </ol>
        </nav>

        <% if (!errorMsg.isEmpty()) { %>
            <div class="alert alert-danger p-4 text-center">
                <h5><i class="fa fa-exclamation-triangle mr-2"></i><%= errorMsg %></h5>
                <a href="GDTimMatHang250.jsp" class="btn btn-secondary mt-3"><i class="fa fa-arrow-left mr-1"></i> Quay lại tìm kiếm</a>
            </div>
        <% } else if (mh != null) { %>
            <div class="detail-card p-4">
                <div class="row">
                    <!-- Ảnh minh họa / Biểu tượng sản phẩm -->
                    <div class="col-md-4 text-center my-auto">
                        <div class="p-4 bg-light rounded" style="border: 1px solid #e0e0e0;">
                            <img src="image/logo.png" alt="Ảnh sản phẩm" class="img-fluid mb-3" style="max-height: 200px; object-fit: contain;">
                            <h6 class="text-muted">Mã sản phẩm: <span class="badge badge-danger px-2 py-1"><%= mh.getId() %></span></h6>
                            <span class="badge badge-success px-3 py-1">Tình trạng: Còn <%= mh.getSoLuongTon() %> <%= mh.getDonViTinh() != null ? mh.getDonViTinh() : "sản phẩm" %></span>
                        </div>
                    </div>

                    <!-- Thông tin chi tiết mặt hàng -->
                    <div class="col-md-8">
                        <h2 class="font-weight-bold" style="color: rgb(175, 0, 0);"><%= mh.getTen() %></h2>
                        <div class="price-highlight my-3">
                            <%= String.format("%,.0f", mh.getGia()) %> VND
                            <small class="text-muted" style="font-size: 1rem;"> / <%= mh.getDonViTinh() != null ? mh.getDonViTinh() : "Cái" %></small>
                        </div>
                        <hr>

                        <div class="product-attributes">
                            <p><span class="info-label"><i class="fa fa-barcode mr-2"></i>Mã mặt hàng:</span> <strong><%= mh.getId() %></strong></p>
                            <p><span class="info-label"><i class="fa fa-cubes mr-2"></i>Đơn vị tính:</span> <%= mh.getDonViTinh() != null ? mh.getDonViTinh() : "Cái" %></p>
                            <p><span class="info-label"><i class="fa fa-archive mr-2"></i>Tồn kho:</span> <span class="badge badge-info"><%= mh.getSoLuongTon() %> <%= mh.getDonViTinh() %></span></p>
                            <p><span class="info-label"><i class="fa fa-align-left mr-2"></i>Mô tả chi tiết:</span></p>
                            <div class="p-3 bg-light rounded mb-3" style="line-height: 1.6;">
                                <%= mh.getMota() != null && !mh.getMota().isEmpty() ? mh.getMota() : "Chưa có mô tả chi tiết cho mặt hàng này." %>
                            </div>
                        </div>

                        <!-- Khung thông tin Nhà Cung Cấp -->
                        <div class="supplier-box">
                            <h5 class="font-weight-bold text-danger mb-3">
                                <i class="fa fa-truck mr-2"></i>Thông tin Nhà Cung Cấp
                            </h5>
                            <p class="mb-1"><span class="info-label">Tên nhà cung cấp:</span> <strong><%= mh.getTenNCC() != null ? mh.getTenNCC() : "Chưa xác định" %></strong></p>
                            <p class="mb-1"><span class="info-label">Mã nhà cung cấp:</span> <%= mh.getNhaCungCapId() != null ? mh.getNhaCungCapId() : "N/A" %></p>
                            <p class="mb-1"><span class="info-label">Địa chỉ:</span> <%= mh.getDiaChiNCC() != null ? mh.getDiaChiNCC() : "Chưa cập nhật" %></p>
                            <p class="mb-1"><span class="info-label">Số điện thoại:</span> <%= mh.getSdtNCC() != null ? mh.getSdtNCC() : "Chưa cập nhật" %></p>
                            <p class="mb-0"><span class="info-label">Email liên hệ:</span> <%= mh.getEmailNCC() != null ? mh.getEmailNCC() : "Chưa cập nhật" %></p>
                        </div>

                        <!-- Các nút điều hướng -->
                        <div class="mt-4 d-flex justify-content-between">
                            <a href="GDTimMatHang250.jsp" class="btn btn-secondary btn-lg">
                                <i class="fa fa-arrow-left mr-1"></i> Quay lại tìm kiếm
                            </a>
                            <a href="Trangchu250.jsp" class="btn btn-custom-red btn-lg">
                                <i class="fa fa-home mr-1"></i> Về trang chủ
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        <% } %>
    </div>

    <jsp:include page="Footer250.jsp"></jsp:include>
</body>
</html>

