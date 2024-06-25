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
import java.util.ArrayList;
import java.util.List;

public class AdminHome extends DatabaseConn {
    private String title;
    private int pageCount;
    private String author;
   

    // Getter ve Setter metotları
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

  

    public List<AdminHome> getAllBooks() {
        List<AdminHome> bookList = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement("SELECT * FROM kitaplars");
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                AdminHome book = new AdminHome();
                book.setTitle(resultSet.getString("kitap_adi"));
                book.setPageCount(resultSet.getInt("sayfa_sayisi"));
                book.setAuthor(resultSet.getString("yazar"));
              
                bookList.add(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return bookList;
    }
}


