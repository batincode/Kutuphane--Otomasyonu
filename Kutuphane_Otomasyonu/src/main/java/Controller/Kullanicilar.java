/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Kullanicilar {
    
    public static List<Kullanici> getKullanicilar() {
        List<Kullanici> kullaniciListesi = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseConn.getConnection();
            String query = "SELECT isim, soyisim, email FROM kullanicilar";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();

            while (rs.next()) {
                String isim = rs.getString("isim");
                String soyisim = rs.getString("soyisim");
                String email = rs.getString("email");

                Kullanici kullanici = new Kullanici(isim, soyisim, email);
                kullaniciListesi.add(kullanici);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return kullaniciListesi;
    }

    public static class Kullanici {
        private String isim;
        private String soyisim;
        private String email;

        public Kullanici(String isim, String soyisim, String email) {
            this.isim = isim;
            this.soyisim = soyisim;
            this.email = email;
        }

        public String getIsim() {
            return isim;
        }

        public String getSoyisim() {
            return soyisim;
        }

        public String getEmail() {
            return email;
        }
    }
}
