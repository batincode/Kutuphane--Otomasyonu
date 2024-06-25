<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="Controller.Login" %>
<%@ page import="javax.servlet.http.Cookie" %>
<!DOCTYPE html>
<html lang="en">
    
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="cache-control" content="no-store, no-cache, must-revalidate" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="expires" content="0" />
    
    <title>Login Page</title>
  
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/Login.css">
        
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <h2 class="text-center">Giriş Yap</h2>

                
                <%
    
    String email = request.getParameter("email");
    String sifre = request.getParameter("sifre");
    String rol = request.getParameter("rol");

    
    String hataMesaji = null;

    
    boolean girisBasarili = Login.signIn(email, sifre, rol);

  
    if (!girisBasarili && request.getMethod().equalsIgnoreCase("post")) {
        hataMesaji = "Giriş sırasında bir hata oluştu. Lütfen tekrar deneyin.";
    }

    
    if (girisBasarili) {
        
        session.setAttribute("userId", Login.getKullaniciId(email, rol));
        session.setAttribute("email", email);
        session.setAttribute("rol", rol);

        

        
        if ("Admin".equals(rol)) {
        
            
            response.sendRedirect("AdminHome.jsp");
        } else {
            response.sendRedirect("UserHome.jsp");
        }
    }
%>


               
                <% if (!girisBasarili) { %>
                    <form method="post" action="">
                        <div class="mb-3">
                            <label for="email" class="form-label">E-posta</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="sifre" class="form-label">Şifre</label>
                            <input type="password" class="form-control" id="sifre" name="sifre" required>
                        </div>
                        <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="rol" name="rol" value="Admin">
                    <label class="form-check-label" for="adminCheckbox">Admin Girişi</label>
                    </div>

                        <button type="submit" class="btn btn-primary">Giriş Yap</button>
                    </form>

                    
                    <% if (hataMesaji != null) { %>
                        <div class="alert alert-danger mt-3" role="alert">
                            <%= hataMesaji %>
                        </div>
                    <% } %>
                <% } %>

                
                

                
                <div class="mt-3 text-center">
                    <p>Hesabınız yok mu? Hemen oluşturun <a href="Register.jsp">Kayıt Ol</a></p>
                </div>
            </div>
        </div> 
    </div>

   
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js"></script>
</body>
</html>
