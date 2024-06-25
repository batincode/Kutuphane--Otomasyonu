/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

/**
 *
 * @author batin
 */

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class KitapListele {

    public static List<KitapListe> tumKitaplariGetir() {
        List<KitapListe> kitapListesi = new ArrayList<>();

        try {
            Connection connection = DatabaseConn.getConnection();
            String sqlQuery = "SELECT * FROM kitaplars";
            
            try (PreparedStatement preparedStatement = connection.prepareStatement(sqlQuery)) {
                ResultSet resultSet = preparedStatement.executeQuery();

                while (resultSet.next()) {
                    int id = resultSet.getInt("id");
                    String kitapAdi = resultSet.getString("kitap_adi");
                    String sayfaSayisi = resultSet.getString("sayfa_sayisi");
                    String yazar = resultSet.getString("yazar");

                    KitapListe kitap = new KitapListe(id, kitapAdi, sayfaSayisi, yazar);
                    kitapListesi.add(kitap);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return kitapListesi;
    }
}
