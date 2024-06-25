package Controller;

import static Controller.DatabaseConn.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OduncVerilen extends DatabaseConn {
    private String title;
    private int pageCount;
    private String author;

    
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getPageCount() {
        return pageCount;
    }

    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    private String email;
    private Timestamp oduncAlmaTarihi;
    private Timestamp teslimEtmeTarihi;

    // Getter ve Setter metotları
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Timestamp getOduncAlmaTarihi() {
        return oduncAlmaTarihi;
    }

    public void setOduncAlmaTarihi(Timestamp oduncAlmaTarihi) {
        this.oduncAlmaTarihi = oduncAlmaTarihi;
    }

    public Timestamp getTeslimEtmeTarihi() {
        return teslimEtmeTarihi;
    }

    public void setTeslimEtmeTarihi(Timestamp teslimEtmeTarihi) {
        this.teslimEtmeTarihi = teslimEtmeTarihi;
    }

    public List<OduncVerilen> getAllBooks() {
        List<OduncVerilen> bookList = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement("SELECT k.kitap_adi, k.sayfa_sayisi, k.yazar, u.email, o.odunc_Tarihi, o.odunc_alma_tarihi " +
                     "FROM kitaplars k " +
                     "JOIN odunc o ON k.id = o.kitap_id " +
                     "JOIN kullanicilar u ON o.kullanici_id = u.id " +
                     "WHERE k.odunc_durum = 1");
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                OduncVerilen book = new OduncVerilen();
                book.setTitle(resultSet.getString("kitap_adi"));
                book.setPageCount(resultSet.getInt("sayfa_sayisi"));
                book.setAuthor(resultSet.getString("yazar"));
                book.setEmail(resultSet.getString("email"));

                Timestamp oduncAlmaTimestamp = resultSet.getTimestamp("odunc_Tarihi");
                Timestamp teslimEtmeTimestamp = resultSet.getTimestamp("odunc_alma_tarihi");

                Date oduncAlmaDate = new Date(oduncAlmaTimestamp.getTime());
                Date teslimEtmeDate = new Date(teslimEtmeTimestamp.getTime());

                book.setOduncAlmaTarihi(oduncAlmaTimestamp);
                book.setTeslimEtmeTarihi(teslimEtmeTimestamp);

                bookList.add(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return bookList;
    }
}
