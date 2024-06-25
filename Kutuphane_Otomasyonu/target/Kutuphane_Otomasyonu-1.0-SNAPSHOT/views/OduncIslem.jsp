<%-- 
    Document   : OduncIslem
    Created on : 20 Ara 2023, 01:23:38
    Author     : batin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Controller.KullaniciListe" %>
<%@ page import="Controller.OduncAlIslemleri" %>

<%
    String email = request.getParameter("email");
    String book = request.getParameter("book");
    String dueDate = request.getParameter("dueDate");

    boolean success = OduncAlIslemleri.oduncAl(email, book, dueDate);

    if (success) {
        response.sendRedirect("OduncVerilenKitaplar.jsp");
    } else {
        response.sendRedirect("oduncHata.jsp");
    }
%>
