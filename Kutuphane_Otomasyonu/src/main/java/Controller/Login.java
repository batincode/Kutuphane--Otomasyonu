package Controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.mindrot.jbcrypt.BCrypt; 

public class Login {
    public static int kullaniciId;  
        public int getKullaniciId() {
        return kullaniciId;
    }

    public void setKullaniciId(int kullaniciId) {
        this.kullaniciId = kullaniciId;
    }

   public static boolean signIn(String email, String password, String rol) {
    try {
        Connection connection = DatabaseConn.getConnection();

        String sql;
        if ("Admin".equals(rol)) {
            sql = "SELECT * FROM adminler WHERE email = ?";
        } else {
            sql = "SELECT * FROM kullanicilar WHERE email = ?";
        }

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, email);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    String hashedPasswordFromDB = resultSet.getString("sifre");
                    boolean passwordMatch = BCrypt.checkpw(password, hashedPasswordFromDB);

                    if (passwordMatch) {
                        //  kullanıcı ID ayarladık
                        kullaniciId = resultSet.getInt("id");
                    }

                    return passwordMatch;
                } else {
                    return false;
                }
            }
        }
    } catch (SQLException e) {
        return false;
    }
    
        
}
    public static int getKullaniciId(String email, String rol) {
        try {
            Connection connection = DatabaseConn.getConnection();

            String sql;
            if ("Admin".equals(rol)) {
                sql = "SELECT id FROM adminler WHERE email = ?";
            } else {
                sql = "SELECT id FROM kullanicilar WHERE email = ?";
            }

            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, email);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        return resultSet.getInt("id");
                    } else {
                        return -1; 
                    }
                }
            }
        } catch (SQLException e) {
            return -1; 
        }
    }    



}


