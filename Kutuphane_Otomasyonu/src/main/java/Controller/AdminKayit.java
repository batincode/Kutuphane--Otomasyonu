/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author batin
 */
package Controller;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import org.mindrot.jbcrypt.BCrypt;

public class AdminKayit {

    private String ad;
    private String soyad;
    private String email;
    private String sifre;
    private boolean kayitDurumu;

    public boolean getKayitDurumu() {
        return kayitDurumu;
    }

    public AdminKayit(String ad, String soyad, String email, String sifre) {
        this.ad = ad;
        this.soyad = soyad;
        this.email = email;
        this.sifre = sifre;
    }

    public boolean kayitOl() {
        try {
            Connection conn = DatabaseConn.getConnection();

            // Şifreyi hashleme
            String hashedPassword = BCrypt.hashpw(sifre, BCrypt.gensalt());

            String sqlQuery = "INSERT INTO adminler (ad, soyad, email, sifre) VALUES (?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = conn.prepareStatement(sqlQuery)) {
                preparedStatement.setString(1, ad);
                preparedStatement.setString(2, soyad);
                preparedStatement.setString(3, email);
                preparedStatement.setString(4, hashedPassword);

                int rowCount = preparedStatement.executeUpdate();

                
                kayitDurumu = rowCount > 0;

                return kayitDurumu;
            }
        } catch (SQLException e) {

            
            kayitDurumu = false;
            return false;
        }
    }
}


