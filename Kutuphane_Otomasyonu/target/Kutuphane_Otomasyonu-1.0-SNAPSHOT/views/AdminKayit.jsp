<%-- 
    Document   : AdminKayit
    Created on : 14 Ara 2023, 16:41:37
    Author     : batin
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="Controller.AdminKayit" %>
<%@ page import="Controller.DatabaseConn" %>

<%
    // Formdan gelen parametreleri alıyoruz
    String ad = request.getParameter("ad");
    String soyad = request.getParameter("soyad");
    String email = request.getParameter("email");
    String sifre = request.getParameter("sifre");

    // nesne oluştur
    AdminKayit AdminKayit = new AdminKayit(ad, soyad, email, sifre);

   
    boolean kayitBasarili = AdminKayit.kayitOl();
%>

<html>
<head>
    <title>Kayıt Ol</title>
    <link rel="stylesheet" href="">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <h2 class="text-center">Kayıt Ol</h2>

               
                <% if (kayitBasarili) { %>
                    <div class="alert alert-success" role="alert">
                        Kayıt başarıyla tamamlandı. Giriş yapmak için <a href="LoginPage.jsp">buraya tıklayın</a>.
                    </div>
                <% } else { %>
                    
                    <form method="post" action="">
                        <div class="mb-3">
                            <label for="ad" class="form-label">İsim</label>
                            <input type="text" class="form-control" id="ad" name="ad" required>
                        </div>
                        <div class="mb-3">
                            <label for="soyad" class="form-label">Soyisim</label>
                            <input type="text" class="form-control" id="soyad" name="soyad" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">E-posta</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="sifre" class="form-label">Şifre</label>
                            <input type="password" class="form-control" id="sifre" name="sifre" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Kayıt Ol</button>
                    
                    </form>
                    

                    <
                    <% if (!AdminKayit.getKayitDurumu()) { %>
             <div>
                 <a href="AdminHome.jsp"><i class="fas fa-tachometer-alt"></i> Ana Sayfaya Dön</a>
                 
             </div>
            <% } %>


                <% } %>

                <div class="mt-3 text-center">
                    <p>Zaten bir hesabınız var mı? Hemen <a href="LoginPage.jsp">Giriş Yapın</a></p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
