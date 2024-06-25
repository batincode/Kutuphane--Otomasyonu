<%-- 
    Document   : CikisYap
    Created on : 22 Ara 2023, 16:55:13
    Author     : batin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>
<body>
    <% 
        session.removeAttribute("userId");
        session.removeAttribute("email");
        session.removeAttribute("rol");
        Integer userId = (Integer) session.getAttribute("userId");
        String email = (String) session.getAttribute("email");
        String rol = (String) session.getAttribute("rol");

       
        System.out.println("UserID: " + userId);
        System.out.println("Email: " + email);
        System.out.println("Rol: " + rol);
        response.sendRedirect("LoginPage.jsp");
    %>
    
    
</body>
</html>
