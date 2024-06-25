<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="Controller.UserRegister" %>
<%@ page import="Controller.DatabaseConn" %>

<%
    
    String isim = request.getParameter("isim");
    String soyisim = request.getParameter("soyisim");
    String email = request.getParameter("email");
    String sifre = request.getParameter("sifre");

    
    UserRegister userRegister = new UserRegister(isim, soyisim, email, sifre);

    
    boolean kayitBasarili = userRegister.kayitOl();
%>

<html>
<head>
    <title>Kayıt Ol</title>
    <link rel="stylesheet" href="../css/Register.css">
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
                            <label for="isim" class="form-label">İsim</label>
                            <input type="text" class="form-control" id="isim" name="isim" required>
                        </div>
                        <div class="mb-3">
                            <label for="soyisim" class="form-label">Soyisim</label>
                            <input type="text" class="form-control" id="soyisim" name="soyisim" required>
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

                    
                    


                <% } %>

                <div class="mt-3 text-center">
                    <p>Zaten bir hesabınız var mı? Hemen <a href="LoginPage.jsp">Giriş Yapın</a></p>
                </div> 
            </div>
        </div>
    </div>
</body>
</html>
