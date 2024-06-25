<%-- 
    Document   : TeslimAl
    Created on : 21 Ara 2023, 22:03:55
    Author     : batin
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="Controller.TeslimAlIslemleri" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="Controller.DatabaseConn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Teslim Alma</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" type="text/css" href="../css/TeslimAl.css">
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
            dueDate.setMonth(currentDate.getMonth() + 1); // 1 ay sonrasını ayarladık
            return dueDate.toISOString().split('T')[0];
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <h2 class="text-center">Kitap Teslim Alma (Admin)</h2>

                
                <form method="post" action="">
                    <div class="form-group">
                        <label for="email">Kullanıcı E-posta Adresi:</label>
                        <select class="form-control" id="email" name="email" required>
                            
                            <%
                                TeslimAlIslemleri teslimAlIslemleri = new TeslimAlIslemleri();
                                List<String> users = teslimAlIslemleri.getAvailableUsers();

                                for (String user : users) {
                            %>
                                    <option><%= user %></option>
                            <%
                                }
                            %>
                        </select>
                         <input type="text" class="form-control" placeholder="İsim ara..." oninput="filterList('email', this.value)">
                    </div>
                    <div class="form-group">
                        <label for="book">Teslim Almak İstediğiniz Kitap:</label>
                        <select class="form-control" id="book" name="book" required>
                            
                            <%
                                List<String> books = teslimAlIslemleri.getAvailableBooks();
                                for (String book : books) {
                            %>
                                    <option><%= book %></option>
                            <%
                                }
                            %>
                        </select>
                        <input type="text" class="form-control" placeholder="Kitap adı veya yazar ara..." oninput="filterList('book', this.value)">
                    </div>
                    <button type="submit" class="btn btn-primary">Teslim Al</button>
                </form>

              
                <%
                    String email = request.getParameter("email");
                    String book = request.getParameter("book");

                    if (email != null && book != null) {
                        boolean teslimAlSonuc = TeslimAlIslemleri.teslimAl(email, book);

                        if (teslimAlSonuc) {
                %>
                            <div class="alert alert-success mt-3" role="alert">
                                Kitap başarıyla teslim alındı.
                            </div>
                <%
                        } else {
                %>
                            <div class="alert alert-danger mt-3" role="alert">
                                Kitap teslim alma işlemi sırasında bir hata oluştu.
                            </div>
                <%
                        }
                    }
                %>

               
                <div class="mt-3 text-center">
                    <a href="AdminHome.jsp">Ana Sayfa'ya Dön</a>
                </div>
            </div>
        </div>
    </div>

    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js"></script>
</body>
</html>
