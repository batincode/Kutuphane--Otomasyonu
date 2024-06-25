<%@page contentType="text/html;charset=UTF-8"%>
<%@ page import="Controller.KullaniciListe" %>
<%@ page import="Controller.OduncAlIslemleri" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Ödünç Alma Formu</title>
    <link rel="stylesheet" href="../css/OduncVer.css">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>Ödünç Verme Formu </h1>

        <%
            String message = ""; 
            boolean isSuccess = false; 

           
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String email = request.getParameter("email");
                String book = request.getParameter("book");
                String dueDate = request.getParameter("dueDate");

               
                isSuccess = OduncAlIslemleri.oduncAl(email, book, dueDate);

                
                if (isSuccess) {
                    message = "Ödünç alma işlemi başarıyla gerçekleşti!";
                } else {
                    message = "Ödünç alma işlemi başarısız oldu. Lütfen tekrar deneyin.";
                }
            }
        %>

        
        <% if (!message.isEmpty()) { %>
            <div class="alert<%= isSuccess ? " alert-success" : " alert-danger" %>">
                <%= message %>
            </div>
        <% } %>

        <form action="" method="post">
            <div class="form-group">
                <label for="email">Okuyucu Seç:</label>
                <select class="form-control" name="email" id="email">
                    <% List<String> kullanicilar = KullaniciListe.getKullanicilar();
                       for (String kullanici : kullanicilar) { %>
                           <option value="<%= kullanici %>"><%= kullanici %></option>
                    <% } %>
                </select>
                <input type="text" class="form-control" placeholder="İsim ara..." oninput="filterList('email', this.value)">
            </div>
            
            <div class="form-group">
                <label for="book">Kitap Seç:</label>
                <select class="form-control" name="book" id="book">
                    <% List<String> kitaplar = KullaniciListe.getKitaplar();
                       for (String kitap : kitaplar) { %>
                           <option value="<%= kitap %>"><%= kitap %></option>
                    <% } %>
                </select>
                <input type="text" class="form-control" placeholder="Kitap adı veya yazar ara..." oninput="filterList('book', this.value)">
            </div>
            
            <div class="form-group">
                <label for="dueDate">Teslim Tarihi:</label>
                <input type="date" class="form-control" name="dueDate" id="dueDate" required readonly>
            </div>
            
            <button type="submit" class="btn btn-primary">Ödünç Ver</button>
            <hr>
             <a href="AdminHome.jsp"><i class="fas fa-tachometer-alt"></i> Ana Sayfaya Dön</a>
        </form>
    </div>

   
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js"></script>
    
    <script>
        function filterList(selectId, searchTerm) {
            searchTerm = searchTerm.toLowerCase();
            var select = document.getElementById(selectId);
            var options = select.options;
            
            for (var i = 0; i < options.length; i++) {
                var optionValue = options[i].value.toLowerCase();
                if (optionValue.includes(searchTerm)) {
                    options[i].style.display = '';
                } else {
                    options[i].style.display = 'none';
                }
            }
        }

        
        document.getElementById("dueDate").value = getDefaultDueDate();

        function getDefaultDueDate() {
            var currentDate = new Date();
            var dueDate = new Date(currentDate);
            dueDate.setMonth(currentDate.getMonth() + 1); 
            return dueDate.toISOString().split('T')[0];
        }
    </script>
</body>
</html>
