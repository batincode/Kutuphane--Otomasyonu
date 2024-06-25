package Controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class UserHome extends DatabaseConn {
    private int kullaniciId;
    private String kitapAdi;
    private int sayfaSayisi;
    private String yazar;
    private Timestamp oduncTarihi;

 
    public int getKullaniciId() {
        return kullaniciId;
    }

    public void setKullaniciId(int kullaniciId) {
        this.kullaniciId = kullaniciId;
    }

    public String getKitapAdi() {
        return kitapAdi;
    }

    public void setKitapAdi(String kitapAdi) {
        this.kitapAdi = kitapAdi;
    }

    public int getSayfaSayisi() {
        return sayfaSayisi;
    }

    public void setSayfaSayisi(int sayfaSayisi) {
        this.sayfaSayisi = sayfaSayisi;
    }

    public String getYazar() {
        return yazar;
    }

    public void setYazar(String yazar) {
        this.yazar = yazar;
    }

    public Timestamp getOduncTarihi() {
        return oduncTarihi;
    }

    public void setOduncTarihi(Timestamp oduncTarihi) {
        this.oduncTarihi = oduncTarihi;
    }

    

   public List<UserHome> getOduncKitaplar() {
        List<UserHome> oduncKitaplar = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(
                     "SELECT kitaplars.kitap_adi, kitaplars.sayfa_sayisi, kitaplars.yazar, odunc.odunc_Tarihi " +
                             "FROM kitaplars " +
                             "JOIN odunc ON kitaplars.id = odunc.kitap_id " +
                             "WHERE odunc.kullanici_id = ?")) {

            preparedStatement.setInt(1, this.kullaniciId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    UserHome kitap = new UserHome();
                    kitap.setKitapAdi(resultSet.getString("kitap_adi"));
                    kitap.setSayfaSayisi(resultSet.getInt("sayfa_sayisi"));
                    kitap.setYazar(resultSet.getString("yazar"));
                    java.sql.Date sqlDate = resultSet.getDate("odunc_Tarihi");

    
                     Timestamp timestamp = new Timestamp(sqlDate.getTime());
                    kitap.setOduncTarihi(resultSet.getTimestamp("odunc_Tarihi"));

                    oduncKitaplar.add(kitap);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return oduncKitaplar;
    }

}
