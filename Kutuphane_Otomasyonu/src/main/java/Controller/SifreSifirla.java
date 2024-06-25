package Controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;
import org.mindrot.jbcrypt.BCrypt;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Random;
import javax.servlet.http.HttpSession;


public class SifreSifirla {

    public static boolean dogrulamaKodu(String email) {
        // E-posta gönderme işlemi için gerekli bilgiler
        final String username = "ayyildizbatin6@gmail.com"; 
        final String password = "floy erry gbhs fglv"; 
        String toAddress = email;

        // E-posta sunucusu ayarları
        String host = "smtp.gmail.com";
        Properties properties = System.getProperties();
        properties.setProperty("mail.smtp.host", host);
        properties.setProperty("mail.smtp.port", "587");
        properties.setProperty("mail.smtp.auth", "true");
        properties.setProperty("mail.smtp.starttls.enable", "true");

        
        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            
            String dogrulamaKodu = generateRandomCode();

            // E-posta oluşturma
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toAddress));
            message.setSubject("Şifre Sıfırlama");
            message.setText("Merhaba, şifrenizi sıfırlamak için aşağıdaki bağlantıyı kullanabilirsiniz. "
                + "Doğrulama Kodunuz: " + dogrulamaKodu);

           
            Transport.send(message);

            System.out.println("Şifre sıfırlama e-postası başarıyla gönderildi.");

         
           ;

            return true;
        } catch (MessagingException mex) {
            mex.printStackTrace();
            return false;
        }
    }


    private static String hashleSifre(String sifre) {
        
        return BCrypt.hashpw(sifre, BCrypt.gensalt());
    }

    private static String generateRandomCode() {
        
        int length = 6;
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random();
        StringBuilder sb = new StringBuilder();

        for (int i = 0; i < length; i++) {
            int index = random.nextInt(characters.length());
            sb.append(characters.charAt(index));
        }

        return sb.toString();
    }


}
