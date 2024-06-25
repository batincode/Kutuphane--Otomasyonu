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
import java.sql.SQLException;

public class KitapSil {

    private int kitapId;
    private boolean silmeDurumu;

    public KitapSil(int kitapId) {
        this.kitapId = kitapId;
    }

    public boolean getSilmeDurumu() {
        return silmeDurumu;
    }

    public void kitapSil() {
        try {
            Connection connection = DatabaseConn.getConnection();

            
            String sqlQuery = "DELETE FROM kitaplars WHERE id = ? AND odunc_durum=0";

            try (PreparedStatement preparedStatement = connection.prepareStatement(sqlQuery)) {
                
                preparedStatement.setInt(1, kitapId);

                
                int rowCount = preparedStatement.executeUpdate();

                
                silmeDurumu = rowCount > 0;
            }
        } catch (SQLException e) {
            
            silmeDurumu = false;
            e.printStackTrace();
        }
    }
}

