package Controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import org.mindrot.jbcrypt.BCrypt;

public class UserRegister {

    private String isim;
    private String soyisim;
    private String email;
    private String sifre;
    private boolean kayitDurumu;

    public boolean getKayitDurumu() {
        return kayitDurumu;
    }

    public UserRegister(String isim, String soyisim, String email, String sifre) {
        this.isim = isim;
        this.soyisim = soyisim;
        this.email = email;
        this.sifre = sifre;
    }

    public boolean kayitOl() {
        try {
            Connection conn = DatabaseConn.getConnection();

            // Şifreyi hashleme
            String hashedPassword = BCrypt.hashpw(sifre, BCrypt.gensalt());

            String sqlQuery = "INSERT INTO kullanicilar (isim, soyisim, email, sifre) VALUES (?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = conn.prepareStatement(sqlQuery)) {
                preparedStatement.setString(1, isim);
                preparedStatement.setString(2, soyisim);
                preparedStatement.setString(3, email);
                preparedStatement.setString(4, hashedPassword);

                int rowCount = preparedStatement.executeUpdate();

                
                kayitDurumu = rowCount > 0;

                return kayitDurumu;
            }
        } catch (SQLException e) {
            e.printStackTrace();

           
            kayitDurumu = false;
            return false;
        }
    }
}

