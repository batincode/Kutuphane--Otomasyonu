

package Controller;




import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class KullaniciSil {

    private int userId;
    private boolean silmeDurumu;

    public KullaniciSil(int userId) {
        this.userId = userId;
    }

    public boolean getSilmeDurumu() {
        return silmeDurumu;
    }

    public void kitapSil() {
        try {
            Connection connection = DatabaseConn.getConnection();

       
            String sqlQuery = "DELETE FROM kullanicilar WHERE id = ?";

            try (PreparedStatement preparedStatement = connection.prepareStatement(sqlQuery)) {
                
                preparedStatement.setInt(1, userId);

                
                int rowCount = preparedStatement.executeUpdate();

               
                silmeDurumu = rowCount > 0;
            }
        } catch (SQLException e) {
            
            silmeDurumu = false;
            e.printStackTrace();
        }
    }
}


