<%@ page import="Controller.KitapSil" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Controller.KitapListe" %>
<%@ page import="Controller.KitapListele" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Kitap Sil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/KitapSil.css">
</head>
<body>

<h2><center>Kitap Sil</center></h2>

<%
   
    List<KitapListe> kitapListesi = KitapListele.tumKitaplariGetir();
%>

<form action="" method="post">
    <label for="kitapId"><strong>Silinecek Kitabı Seç:</strong></label>
    <select name="kitapId" id="kitapId">
        <% for (KitapListe kitap : kitapListesi) { %>
            <option value="<%= kitap.getId() %>"><%= kitap.getKitapAdi() %></option>
        <% } %>
    </select>
    <br>
    <input class="btn btn-outline-danger" type="submit" value="Kitap Sil">
    <hr>
    <a class="btn btn-outline-primary" href="AdminHome.jsp" role="button">Ana Sayfaya Dön</a>

</form>

<%
    
    if (request.getMethod().equalsIgnoreCase("post")) {
       
        String kitapIdStr = request.getParameter("kitapId");

        
        int kitapId = Integer.parseInt(kitapIdStr);

        
        KitapSil kitapSil = new KitapSil(kitapId);
        kitapSil.kitapSil();

        
        if (kitapSil.getSilmeDurumu()) {
            out.println("Kitap başarıyla silindi.");
        } else {
            out.println("Kitap silinirken bir hata oluştu.");
        }
    }
%>

</body>
</html>