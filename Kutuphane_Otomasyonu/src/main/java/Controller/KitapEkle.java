/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class KitapEkle {

    private String kitap_adi;
    private String sayfa_sayisi;
    private String yazar;
    private boolean eklemeDurumu;

    public KitapEkle(String kitap_adi, String sayfa_sayisi, String yazar) {
        this.kitap_adi = kitap_adi;
        
        this.sayfa_sayisi = sayfa_sayisi;
        this.yazar = yazar;
    }

    public boolean getEklemeDurumu() {
        return eklemeDurumu;
    }

    public void kitapEkle() {
        try {
            Connection connection = DatabaseConn.getConnection();

            
            String sqlQuery = "INSERT INTO kitaplars(kitap_adi, sayfa_sayisi, yazar) VALUES (?, ?, ?)";

            try (PreparedStatement preparedStatement = connection.prepareStatement(sqlQuery)) {
               
                preparedStatement.setString(1, kitap_adi);
                preparedStatement.setString(2, sayfa_sayisi);
                preparedStatement.setString(3, yazar);
                
               
                int rowCount = preparedStatement.executeUpdate();

                
                eklemeDurumu = rowCount > 0;
            }
        } catch (SQLException e) {
          
            eklemeDurumu = false;
        }
    }
}
