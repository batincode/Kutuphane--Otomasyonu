<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="Controller.KitapEkle" %>
<%
    String message = ""; 
    KitapEkle kitapEkle = null; 

    if (request.getMethod().equalsIgnoreCase("POST")) {
        String kitap_adi = request.getParameter("kitap_adi");
        String yazar = request.getParameter("yazar");
        String sayfa_sayisi = request.getParameter("sayfa_sayisi");

        kitapEkle = new KitapEkle(kitap_adi, sayfa_sayisi, yazar);
        kitapEkle.kitapEkle();

        if (kitapEkle.getEklemeDurumu()) {
            message = "Kitap ekleme işlemi başarıyla gerçekleşti.";
        } else {
            message = "Kitap ekleme işlemi sırasında bir hata oluştu.";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kitap Ekle</title>
    <link rel="stylesheet" href="../css/kitapekle.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<div class="container">
    <h2>Kitap Ekle</h2>
    <% if (kitapEkle != null && !message.isEmpty()) { %>
        <div class="alert<%= kitapEkle.getEklemeDurumu() ? " alert-success" : " alert-danger" %>">
            <%= message %>
        </div>
    <% } %>
    <form action="" method="post">
        <label for="kitap_adi">Kitap Adı:</label>
        <input type="text" id="kitap_adi" name="kitap_adi" required>

        <label for="yazar">Yazar:</label>
        <input type="text" id="yazar" name="yazar" required>

        <label for="sayfa_sayisi">Sayfa Sayısı:</label>
        <input type="number" id="sayfa_sayisi" name="sayfa_sayisi" required>

        <button type="submit" class="btn btn-primary">Kitap Ekle</button>
        <hr>
        <a href="AdminHome.jsp"><i class="fas fa-tachometer-alt"></i> Ana Sayfaya Dön</a>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>

