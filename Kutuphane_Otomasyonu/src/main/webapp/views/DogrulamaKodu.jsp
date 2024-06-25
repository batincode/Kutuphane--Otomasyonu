<%-- 
    Document   : SifreGuncelle
    Created on : 13 Ara 2023, 23:22:39
    Author     : batin
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Controller.SifreSifirla" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Şifre Sıfırla</title>
</head>
<body>
    <h2>Şifre Sıfırla</h2>
    
    <form method="post" action="">
        <label for="email">E-posta Adresi:</label>
        <input type="email" id="email" name="email" required>
        <button type="submit">Şifre Sıfırlama E-postası Gönder</button>
    </form>

    <% 
        String email = request.getParameter("email");
        if (email != null && !email.isEmpty()) {
            boolean sifreSifirlaBasarili = SifreSifirla.sifreSifirla(email);

            if (sifreSifirlaBasarili) {
    %>
                <p style="color: green;">Şifre sıfırlama e-postası başarıyla gönderildi. Lütfen e-postanızı kontrol edin.</p>

                <form method="post" action="SifreGuncelle.jsp">
                    <label for="dogrulamaKodu">Doğrulama Kodu:</label>
                    <input type="text" id="dogrulamaKodu" name="dogrulamaKodu" required>
                    <label for="yeniSifre">Yeni Şifre:</label>
                    <input type="password" id="yeniSifre" name="yeniSifre" required>
                    <button type="submit">Şifreyi Güncelle</button>
                    <input type="hidden" name="email" value="<%= email %>">
                </form>
    <%
            } else {
    %>
                <p style="color: red;">Şifre sıfırlama e-postası gönderilirken bir hata oluştu. Lütfen daha sonra tekrar deneyin.</p>
    <%
            }
        }
    %>
</body>
</html>
