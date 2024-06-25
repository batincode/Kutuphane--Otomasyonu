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

public class KitaplarDAO {

    
    public List<Book> getBooks() {
        List<Book> books = new ArrayList<>();
        
        try (Connection connection = DatabaseConn.getConnection()) {
            String query = "SELECT kitap_adi, sayfa_sayisi, yazar FROM kitaplars";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
                        String bookTitle = resultSet.getString("kitap_adi");
                        int pageCount = resultSet.getInt("sayfa_sayisi");
                        String author = resultSet.getString("yazar");

                        
                        Book book = new Book(bookTitle, pageCount, author);
                        books.add(book);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
           
        }

        return books;
    }

   
    public static class Book {
        private String bookTitle;
        private int pageCount;
        private String author;

        public Book(String bookTitle, int pageCount, String author) {
            this.bookTitle = bookTitle;
            this.pageCount = pageCount;
            this.author = author;
        }

      
        public String getBookTitle() {
            return bookTitle;
        }

        public int getPageCount() {
            return pageCount;
        }

        public String getAuthor() {
            return author;
        }
    }
}

