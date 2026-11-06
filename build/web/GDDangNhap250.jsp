<%@page import="Entity250.NVQL_250"%>
<%@page import="DAO250.NVQL_DAO250"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" crossorigin="anonymous">
    <link href="css/login.css" rel="stylesheet" type="text/css"/>
    <link rel="icon" href="image/logo.png" type="image/x-icon">
    <title>Đăng nhập - Hệ Thống Quản Lý Siêu Thị</title>
    
    <style>
        .form-signin h1 {
            color: rgb(195, 0, 0);
            font-size: 2rem;
            font-weight: bold;
        }
        .text-danger-custom {
            color: rgb(195, 0, 0) !important;
            font-size: 1.25rem;
            font-weight: bold;
        }
        .btn-custom-red {
            background-color: rgb(195, 0, 0);
            border-color: rgb(195, 0, 0);
            color: #ffffff;
            font-weight: bold;
            font-size: 1rem;
        }
        .btn-custom-red:hover {
            background-color: rgb(160, 0, 0);
            border-color: rgb(140, 0, 0);
            color: #ffeb3b;
        }
        #logreg-forms {
            max-width: 480px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
    </style>
</head>

<%
    String message = "";
    String error = "";

    if (request.getParameter("user") != null) {
        String userId = request.getParameter("user").trim();
        String password = request.getParameter("pass").trim();

        try {
            NVQL_DAO250 qldao = new NVQL_DAO250();
            NVQL_250 ql = qldao.checkLogin(userId, password);

            if (ql != null) {
                session.setAttribute("user", ql);
                response.sendRedirect("GDQL250.jsp");
                return;
            } else {
                error = "Mã nhân viên hoặc mật khẩu không chính xác!";
            }
        } catch (Exception e) {
            e.printStackTrace();
            error = "Lỗi kết nối cơ sở dữ liệu: " + e.getMessage();
        }
    }
%>

<body style="background-color: #f5f5f5;">
    <div id="logreg-forms">
        <form class="form-signin" action="" method="post">
            <div class="text-center mb-3">
                <div style="width: 70px; height: 70px; background: linear-gradient(135deg, rgb(175,0,0), rgb(220,20,20)); border-radius: 50%; display: inline-flex; align-items: center; justify-content: center; color: white; box-shadow: 0 4px 12px rgba(175,0,0,0.3); margin: 0 auto;"><i class="fa fa-shopping-cart fa-2x"></i></div>
            </div>
            <h1 class="h3 mb-3 font-weight-normal text-danger-custom text-center">ĐĂNG NHẬP HỆ THỐNG</h1>
            
            <% if (!error.isEmpty()) { %>
                <div class="alert alert-danger" role="alert"><i class="fa fa-exclamation-circle mr-1"></i><%= error %></div>
            <% } else if (!message.isEmpty()) { %>
                <div class="alert alert-success" role="alert"><%= message %></div>
            <% } %>

            <div class="form-group">
                <label><strong>Mã nhân viên quản lý:</strong></label>
                <input name="user" type="text" class="form-control form-control-lg" placeholder="Ví dụ: NVQL250 hoặc admin" required autofocus>
            </div>

            <div class="form-group">
                <label><strong>Mật khẩu:</strong></label>
                <input name="pass" type="password" class="form-control form-control-lg" placeholder="Mật khẩu (mặc định: 123456)" required>
            </div>

            <div class="form-group form-check">
                <input name="remember" value="1" type="checkbox" class="form-check-input" id="exampleCheck1" checked>
                <label class="form-check-label text-muted" for="exampleCheck1">Ghi nhớ đăng nhập</label>
            </div>

            <button class="btn btn-custom-red btn-block btn-lg" type="submit">
                <i class="fas fa-sign-in-alt mr-1"></i> Đăng nhập
            </button>

            <div class="alert alert-info mt-3 p-2 small text-center">
                <strong>Tài khoản Quản lý thử nghiệm:</strong><br>
                Mã NV: <code>NVQL250</code> hoặc <code>admin</code> | Mật khẩu: <code>123456</code>
            </div>

            <hr>
            <div class="text-center">
                <a href="GDTimMatHang250.jsp" class="btn btn-outline-secondary btn-sm mr-2">
                    <i class="fas fa-search mr-1"></i> Tìm kiếm mặt hàng
                </a>
                <a href="Trangchu250.jsp" class="btn btn-outline-danger btn-sm">
                    <i class="fas fa-home mr-1"></i> Trở về trang chủ
                </a>
            </div>
        </form>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" crossorigin="anonymous"></script>
</body>
</html>

