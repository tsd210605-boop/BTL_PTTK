<%@page import="Entity250.MatHang250"%>
<%@page import="DAO250.MatHang_DAO250"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tìm Kiếm Mặt Hàng - Hệ Thống Quản Lý Siêu Thị</title>
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
        .page-header-box {
            background-color: rgb(175, 0, 0);
            color: white;
            padding: 15px 25px;
            border-radius: 10px;
            margin-bottom: 25px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.15);
        }
        .search-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
            margin-bottom: 25px;
        }
        .btn-custom-red {
            background-color: rgb(175, 0, 0);
            color: white;
            font-weight: bold;
        }
        .btn-custom-red:hover {
            background-color: rgb(140, 0, 0);
            color: #ffeb3b;
        }
        .result-table {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
        }
        .result-table th {
            background-color: rgb(175, 0, 0);
            color: white;
            border: none;
            padding: 12px;
            text-align: center;
        }
        .result-table td {
            vertical-align: middle;
            padding: 12px;
        }
        .btn-detail {
            background-color: #007bff;
            color: white;
            font-weight: bold;
            border-radius: 20px;
            padding: 5px 15px;
            text-decoration: none;
        }
        .btn-detail:hover {
            background-color: #0056b3;
            color: white;
            text-decoration: none;
        }
        .price-text {
            color: #d9534f;
            font-weight: bold;
            font-size: 1.05rem;
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

    <div class="container mt-3">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><i class="fa fa-home mr-1"></i><a href="Trangchu250.jsp">Trang chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">Tìm kiếm mặt hàng</li>
            </ol>
        </nav>

        <!-- Tiêu đề trang -->
        <div class="page-header-box text-center">
            <h3 class="mb-1 font-weight-bold"><i class="fa fa-search mr-2"></i>TÌM KIẾM MẶT HÀNG</h3>
            <p class="mb-0 text-white-50">Nhập tên mặt hàng để tra cứu thông tin sản phẩm và nhà cung cấp trong siêu thị</p>
        </div>

        <%
            String keyword = request.getParameter("keyword");
            if (keyword == null) {
                keyword = "";
            }
            keyword = keyword.trim();

            MatHang_DAO250 dao = null;
            List<MatHang250> listMatHang = null;
            String errorMsg = "";

            try {
                dao = new MatHang_DAO250();
                listMatHang = dao.searchMatHang(keyword);
            } catch (Exception e) {
                e.printStackTrace();
                errorMsg = "Lỗi kết nối cơ sở dữ liệu: " + e.getMessage();
            }
        %>

        <!-- Form tìm kiếm mặt hàng -->
        <div class="search-card">
            <form action="GDTimMatHang250.jsp" method="get">
                <div class="form-row align-items-center justify-content-center">
                    <div class="col-md-7 my-1">
                        <label class="sr-only" for="keywordInput">Tên mặt hàng</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <div class="input-group-text"><i class="fa fa-shopping-bag"></i></div>
                            </div>
                            <input type="text" class="form-control form-control-lg" id="keywordInput" name="keyword" 
                                   value="<%= keyword %>" placeholder="Nhập tên mặt hàng để tìm kiếm (vd: Sữa, Bánh, Dầu ăn...)..." autofocus>
                        </div>
                    </div>
                    <div class="col-md-3 my-1">
                        <button type="submit" class="btn btn-custom-red btn-lg btn-block">
                            <i class="fa fa-search mr-1"></i> Tìm kiếm
                        </button>
                    </div>
                </div>
            </form>
            <% if (!keyword.isEmpty()) { %>
                <div class="text-center mt-3">
                    <span class="badge badge-info px-3 py-2" style="font-size: 0.95rem;">
                        Từ khóa: "<strong><%= keyword %></strong>" - Tìm thấy: <strong><%= listMatHang != null ? listMatHang.size() : 0 %></strong> kết quả
                    </span>
                    <a href="GDTimMatHang250.jsp" class="btn btn-sm btn-outline-secondary ml-2">Xóa bộ lọc</a>
                </div>
            <% } %>
        </div>

        <!-- Bảng hiển thị danh sách các mặt hàng có tên chứa từ khóa vừa nhập -->
        <div class="result-table p-3 mb-5">
            <% if (!errorMsg.isEmpty()) { %>
                <div class="alert alert-danger"><%= errorMsg %></div>
            <% } else if (listMatHang != null && !listMatHang.isEmpty()) { %>
                <table class="table table-hover table-striped mb-0">
                    <thead>
                        <tr>
                            <th style="width: 5%;">STT</th>
                            <th style="width: 12%;">Mã MH</th>
                            <th style="width: 28%; text-align: left;">Tên mặt hàng</th>
                            <th style="width: 10%;">ĐVT</th>
                            <th style="width: 15%; text-align: right;">Đơn giá (VND)</th>
                            <th style="width: 18%; text-align: left;">Nhà cung cấp</th>
                            <th style="width: 12%;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (int i = 0; i < listMatHang.size(); i++) {
                                MatHang250 mh = listMatHang.get(i);
                        %>
                        <tr>
                            <td class="text-center font-weight-bold"><%= i + 1 %></td>
                            <td class="text-center"><span class="badge badge-secondary"><%= mh.getId() %></span></td>
                            <td>
                                <strong><%= mh.getTen() %></strong>
                                <% if (mh.getMota() != null && !mh.getMota().isEmpty()) { %>
                                    <br><small class="text-muted"><%= mh.getMota().length() > 65 ? mh.getMota().substring(0, 65) + "..." : mh.getMota() %></small>
                                <% } %>
                            </td>
                            <td class="text-center"><%= mh.getDonViTinh() != null ? mh.getDonViTinh() : "Cái" %></td>
                            <td class="text-right price-text"><%= String.format("%,.0f", mh.getGia()) %> đ</td>
                            <td><i class="fa fa-truck text-muted mr-1"></i><%= mh.getTenNCC() != null ? mh.getTenNCC() : "Chưa cập nhật" %></td>
                            <td class="text-center">
                                <!-- Click vào một mặt hàng xem chi tiết -->
                                <a href="GDChiTietMatHang250.jsp?id=<%= mh.getId() %>" class="btn btn-detail btn-sm">
                                    <i class="fa fa-eye mr-1"></i> Chi tiết
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <div class="text-center py-5">
                    <i class="fa fa-frown-o fa-4x text-muted mb-3"></i>
                    <h5 class="text-muted font-weight-bold">Không tìm thấy mặt hàng nào phù hợp với từ khóa "<%= keyword %>"</h5>
                    <p class="text-muted">Vui lòng thử lại với tên hoặc từ khóa tìm kiếm khác (ví dụ: Sữa, Dầu ăn, Gạo, Bánh, Acecook...)</p>
                    <a href="GDTimMatHang250.jsp" class="btn btn-outline-danger font-weight-bold mt-2">
                        <i class="fa fa-refresh mr-1"></i> Hiển thị tất cả mặt hàng
                    </a>
                </div>
            <% } %>
        </div>
    </div>

    <jsp:include page="Footer250.jsp"></jsp:include>
</body>
</html>

