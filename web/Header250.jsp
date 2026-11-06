<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Header -->
<div class="header-wrapper bg-white border-bottom shadow-sm">
    <div class="container" id="header">
        <div class="header-brand">
            <a href="Trangchu250.jsp" class="d-flex align-items-center text-decoration-none">
                <div class="brand-icon-box mr-3">
                    <i class="fa fa-shopping-cart fa-lg"></i>
                </div>
                <div>
                    <h4 class="brand-title mb-0">HỆ THỐNG QUẢN LÝ SIÊU THỊ</h4>
                    <span class="brand-subtitle">SUPERMARKET MANAGEMENT SYSTEM</span>
                </div>
            </a>
        </div>
        <div class="header-right d-flex align-items-center">
            <c:choose>
                <c:when test="${sessionScope.user != null}">
                    <div class="user-profile mr-3 text-right">
                        <small class="text-muted d-block">Xin chào quản lý,</small>
                        <strong class="text-danger font-weight-bold">
                            <i class="fa fa-user-circle mr-1"></i>${sessionScope.user.hoTen}
                        </strong>
                        <span class="badge badge-secondary ml-1">${sessionScope.user.maNV}</span>
                    </div>
                    <a href="Dangxuat250.jsp" class="btn btn-sm btn-outline-danger font-weight-bold">
                        <i class="fa fa-sign-out mr-1"></i>Đăng xuất
                    </a>
                </c:when>
                <c:otherwise>
                    <div class="header-contact mr-3 d-none d-md-flex align-items-center text-right">
                        <div class="contact-icon mr-2">
                            <i class="fa fa-phone"></i>
                        </div>
                        <div>
                            <small class="text-muted d-block">Hotline hỗ trợ</small>
                            <strong class="text-dark">1900 8888</strong>
                        </div>
                    </div>
                    <a href="GDDangNhap250.jsp" class="btn btn-login-header font-weight-bold">
                        <i class="fa fa-lock mr-1"></i>Đăng nhập
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<style>
    .header-wrapper {
        background-color: #ffffff;
    }
    #header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 15px;
    }
    .brand-icon-box {
        width: 46px;
        height: 46px;
        background: linear-gradient(135deg, rgb(175, 0, 0), rgb(220, 20, 20));
        color: #ffffff;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 3px 8px rgba(175, 0, 0, 0.3);
    }
    .brand-title {
        font-weight: 800;
        font-size: 1.35rem;
        color: rgb(175, 0, 0);
        letter-spacing: 0.5px;
        line-height: 1.2;
    }
    .brand-subtitle {
        font-size: 0.75rem;
        font-weight: 700;
        letter-spacing: 1px;
        color: #6c757d;
    }
    .contact-icon {
        width: 34px;
        height: 34px;
        background-color: #f8f9fa;
        color: rgb(175, 0, 0);
        border: 1px solid #dee2e6;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .btn-login-header {
        background-color: rgb(175, 0, 0);
        color: #ffffff !important;
        border-radius: 20px;
        padding: 6px 18px;
        font-size: 0.9rem;
        transition: all 0.2s;
    }
    .btn-login-header:hover {
        background-color: rgb(140, 0, 0);
        color: #ffeb3b !important;
        box-shadow: 0 3px 10px rgba(175, 0, 0, 0.25);
    }
    @media (max-width: 576px) {
        .brand-title {
            font-size: 1.05rem;
        }
        .brand-subtitle {
            display: none;
        }
        .brand-icon-box {
            width: 38px;
            height: 38px;
        }
    }
</style>
