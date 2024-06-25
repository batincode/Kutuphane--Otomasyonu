/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

public class KitapListe {
    private int id;
    private String kitapAdi;
    private String sayfaSayisi;
    private String yazar;

    public KitapListe(int id, String kitapAdi, String sayfaSayisi, String yazar) {
        this.id = id;
        this.kitapAdi = kitapAdi;
        this.sayfaSayisi = sayfaSayisi;
        this.yazar = yazar;
    }

    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getKitapAdi() {
        return kitapAdi;
    }

    public void setKitapAdi(String kitapAdi) {
        this.kitapAdi = kitapAdi;
    }

    public String getSayfaSayisi() {
        return sayfaSayisi;
    }

    public void setSayfaSayisi(String sayfaSayisi) {
        this.sayfaSayisi = sayfaSayisi;
    }

    public String getYazar() {
        return yazar;
    }

    public void setYazar(String yazar) {
        this.yazar = yazar;
    }
}

