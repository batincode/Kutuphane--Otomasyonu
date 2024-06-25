<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Controller.Kullanicilar" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kullanıcılar</title>
  
    
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" rel="stylesheet">
  
   
    <link rel="stylesheet" href="../css/UserHome.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js"></script>
    
     <!-- Bu kısmı head içine ekleyin -->
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
        <!-- Sidebar -->
        <nav id="sidebar"> 
            <div class="sidebar-header">
                <h3><strong>Admin Panel</strong></h3>
            </div>

            <ul class="list-unstyled components">
                <li class="active">
                    <a href="AdminHome.jsp"><i class="fa-solid fa-house" style="color: #007bff;"></i> Ana Sayfa</a>
                </li>
                <li>
                    <a href="OduncVerilenKitaplar.jsp"><i class="fas fa-book"></i> Ödünç Verilen Kitaplar</a>
                </li>
                 
                <li>
                    <a href="Kullanicilar.jsp"><i class="fas fa-users"></i>Kullanıcılar</a>
                </li>
                <li>
                    <a href="OduncKitap.jsp"><i class="fas fa-book-reader"></i> Ödünç Ver</a>
                </li>
                <li>
                    <a href="TeslimAl.jsp" style="color: #b80000;"><i class="fa-solid fa-book-medical" style="color: #b80000;"></i> Teslim Al</a>
                </li>
                <li>
                    <a href="AdminKayit.jsp"><i class="fa-solid fa-user-tie" style="color: #007bff;"></i> Admin Kaydı Oluştur</a>
                </li>
                <li>
                    <a href="KitapEkle.jsp"><i class="fa-solid fa-book-medical" style="color: #007bff;"></i> Kitap Ekle</a>
                </li>
                <li>
                    <a href="KitapSil.jsp" style="color: #b80000;"><i class="fas fa-right-from-bracket" style="color: #b80000;"></i> Kitap Sil</a>
                </li>
                <li>
                    <a href="CikisYap.jsp" style="color: #b80000;"><i class="fas fa-right-from-bracket" style="color: #b80000;"></i> Çıkış Yap</a>
                </li>
                
                
            </ul>
        </nav>

        <!-- Main content area -->
        <div id="content">
            <main role="main" class="container-fluid">
                <!-- İçerik buraya eklenecek -->
                 <form action="/arama-sonuclari" method="get" id="search-form">
                    <label class="arama1" for="search">Kullanıcı ara :</label>
                    <input class="arama2" type="text" id="search" name="q" placeholder="Aradığınız kullanıcı bilgileri...">
                    <input class="btn btn-outline-primary btn-sm" type="submit" value="Ara">
                </form>
                
                <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                        <thead>
                            <tr class="deneme">
                                <th><i class="fa-solid fa-book" style="color: #fff;"></i> Email</th>
                                <th><i class="fa-solid fa-book-open" style="color: #fff;"></i> İsim</th>
                                <th><i class="fa-solid fa-pen-nib" style="color: #fff;"></i> Soyisim</th>
                            </tr>
                        </thead>
                        <!-- ... (diğer kodlar) ... -->
                <tbody>
                    
             <%
                 List<Kullanicilar.Kullanici> kullaniciListesi = Kullanicilar.getKullanicilar();
                    for (Kullanicilar.Kullanici kullanici : kullaniciListesi) {
                %>
                
             <tr>
            <td><%= kullanici.getEmail() %></td>
            <td><%= kullanici.getIsim() %></td>
            <td><%= kullanici.getSoyisim() %></td>
        </tr>
    <% } %>
</tbody>
<!-- ... (diğer kodlar) ... -->

                    </table>
                </div>
            </main>
        </div>
    </div>
    <!-- jQuery, Popper.js, Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js"></script>
</body>
</html>
