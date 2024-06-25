<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Controller.UserHome" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
        Integer userId= null;
        String  email= null;
        String rol= null;
        userId = (Integer) session.getAttribute("userId");
        email = (String) session.getAttribute("email");
        rol = (String) session.getAttribute("rol");

        System.out.println("UserId: " + userId);
        System.out.println("Email: " + email);
        System.out.println("Rol: " + rol); 
        if( userId==null && email==null && rol==null ) {

       response.sendRedirect("LoginPage.jsp");



}%>
<!DOCTYPE html>


<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Home</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="../css/kitaplarım.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js"></script>
    <script>
        
        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById("search-form").addEventListener("submit", function (event) {
                event.preventDefault();
                var searchTerm = document.getElementById("search").value.toLowerCase();
                filterTable(searchTerm);
            });

            function filterTable(searchTerm) {
                var rows = document.querySelectorAll("table tbody tr");

                rows.forEach(function (row) {
                    var found = false;
                    row.querySelectorAll("td").forEach(function (cell) {
                        var cellText = cell.textContent.toLowerCase();
                        if (cellText.includes(searchTerm)) {
                            found = true;
                        }
                    });

                    if (found) {
                        row.style.display = "";
                    } else {
                        row.style.display = "none";
                    }
                });
            }
        });
    </script>
    
</head>
<body>
    <div class="wrapper">
       
        <nav id="sidebar">
            <div class="sidebar-header">
                <h3><strong>User Panel</strong></h3>
            </div>

            <ul class="list-unstyled components">
                <li class="active">
                    <a href="UserHome.jsp"><i class="fa-solid fa-house-chimney" style="color: #0058f0;"></i> Ana Sayfa</a>
                </li>

                <li>
                    <a href="kitaplarım.jsp"><i class="fa-solid fa-book-open-reader" style="color: #007bff;"></i> Kitaplarım</a>
                </li>
                
                <li>
                    <a href="LoginPage.jsp" style="color: #b80000;"><i class="fas fa-right-from-bracket" style="color: #b80000;"></i> Çıkış Yap</a>
                </li>
            </ul>
        </nav>

        
        <div id="content">
            <main role="main" class="container-fluid">
                
                <form action="/arama-sonuclari" method="get" id="search-form">
                    <label class="arama1" for="search">Aramak istediğiniz kitap:</label>
                    <input class="arama2" type="text" id="search" name="q" placeholder="Aradığınız kitap veya yazar...">
                    <input class="btn btn-outline-primary btn-sm" type="submit" value="Ara">
                </form>
                <hr>
                

<div class="table-responsive">
    <table class="table table-bordered table-striped">
        <thead>
            <tr class="deneme">
                <th><i class="fa-solid fa-book" style="color: #fff;"></i> Kitap Adı</th>
                <th><i class="fa-solid fa-book-open" style="color: #fff;"></i> Sayfa Sayısı</th>
                <th><i class="fa-solid fa-pen-nib" style="color: #fff;"></i> Yazar</th>
                <th><i class="fa-solid fa-clock" style="color: #fff;"></i> Teslim Tarihi</th> 
            </tr>
        </thead>
        
            <% if(userId!=null){
                HttpSession sessions = request.getSession();
               int kullaniciId = (int) sessions.getAttribute("userId");  
    

                UserHome userHome = new UserHome();
                userHome.setKullaniciId(kullaniciId);
                List<UserHome> oduncKitaplar = userHome.getOduncKitaplar();

                for (UserHome oduncKitap : oduncKitaplar) {
            %>
            <tr>
                <td><%= oduncKitap.getKitapAdi() %></td>
                <td><%= oduncKitap.getSayfaSayisi() %></td>
                <td><%= oduncKitap.getYazar() %></td>
                <td><%= oduncKitap.getOduncTarihi() %></td> 
            </tr>
            <%
                }}
            %>
        
    </table>
</div>



            </main>
        </div>
    </div>
</body>
</html>
