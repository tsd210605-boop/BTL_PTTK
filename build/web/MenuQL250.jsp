<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpSession"%>
<!-- begin of menu QL -->

<nav class="navbar navbar-expand-md navbar-dark navbar-custom">
    <div class="container">
        <a class="navbar-brand" href="GDQL250.jsp"><i class="fa fa-th-large mr-2"></i>Quản Lý Siêu Thị</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="navbarsExampleDefault">
            <ul class="navbar-nav m-auto">
                <c:if test="${sessionScope.user != null}">
                    <li class="nav-item">
                        <a class="nav-link" href="GDQL250.jsp"><i class="fa fa-home mr-1"></i>Bàn làm việc</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="GDTimMatHang250.jsp"><i class="fa fa-search mr-1"></i>Tìm mặt hàng</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link font-weight-bold text-warning" href="GDXemBC250.jsp"><i class="fa fa-bar-chart mr-1"></i>Xem báo cáo</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fa fa-user-circle mr-1"></i>Quản lý: ${sessionScope.user.hoTen}</a>
                    </li>
                    <li class="nav-item">
                       <a class="nav-link" href="Dangxuat250.jsp"><i class="fa fa-sign-out mr-1"></i>Đăng xuất</a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.user == null}">
                    <li class="nav-item">
                        <a class="nav-link" href="GDDangNhap250.jsp"><i class="fa fa-sign-in mr-1"></i>Đăng nhập</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>

<style>
    .navbar-brand {
        font-size: 20px;
        font-weight: bold;
    }

    .navbar-brand i {
        font-size: 22px;
        margin-right: 5px;
    }

    .navbar-custom {
        background-color: rgb(175, 0, 0);
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    }

    .navbar-nav .nav-link {
        font-size: 16px;
        color: white !important;
        font-weight: 600;
        padding-left: 15px !important;
        padding-right: 15px !important;
    }

    .navbar-nav .nav-link:hover {
        color: #ffeb3b !important;
    }
</style>
