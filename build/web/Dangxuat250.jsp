<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session != null) {
        session.removeAttribute("user");
        session.invalidate();
    }
    response.sendRedirect("Trangchu250.jsp");
%>

