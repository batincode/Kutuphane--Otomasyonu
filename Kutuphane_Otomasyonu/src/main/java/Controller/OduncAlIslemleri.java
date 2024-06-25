package Controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.ArrayList;

public class OduncAlIslemleri {

    public static boolean oduncAl(String email, String book, String dueDate) {
        int userId = getUserIdByEmail(email);
        List<Integer> bookIds = getBookIdsByName(book);

        if (userId != -1 && !bookIds.isEmpty()) {
            for (int bookId : bookIds) {
                if (insertOduncRecord(bookId, userId, dueDate)) {
                    return true;
                }
            }
        }

        return false;
    }

    private static int getUserIdByEmail(String email) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int userId = 0;

        try {
            conn = DatabaseConn.getConnection();
            String query = "SELECT id FROM kullanicilar WHERE email = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, email);

            rs = stmt.executeQuery();

            if (rs.next()) {
                userId = rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (stmt != null)
                    stmt.close();
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return userId;
    }

    private static List<Integer> getBookIdsByName(String book) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Integer> bookIds = new ArrayList<>();

        try {
            conn = DatabaseConn.getConnection();
            String query = "SELECT id FROM kitaplars WHERE kitap_adi = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, book);

            rs = stmt.executeQuery();

            while (rs.next()) {
                int bookId = rs.getInt("id");
                bookIds.add(bookId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (stmt != null)
                    stmt.close();
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return bookIds;
    }

    private static boolean insertOduncRecord(int bookId, int userId, String dueDate) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            conn = DatabaseConn.getConnection();
            conn.setAutoCommit(false); 

            String insertOduncQuery = "INSERT INTO odunc (kitap_id, kullanici_id, odunc_Tarihi) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(insertOduncQuery);
            stmt.setInt(1, bookId);
            stmt.setInt(2, userId);

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            try {
                java.util.Date parsedDate = dateFormat.parse(dueDate);
                java.sql.Date sqlDueDate = new java.sql.Date(parsedDate.getTime());
                stmt.setDate(3, sqlDueDate);

                int rowsInserted = stmt.executeUpdate();

                if (rowsInserted > 0) {
                   
                    String updateKitaplarsQuery = "UPDATE kitaplars SET odunc_durum = 1 WHERE odunc_durum = 0 AND id = ?";
                    PreparedStatement updateStmt = conn.prepareStatement(updateKitaplarsQuery);
                    updateStmt.setInt(1, bookId);
                    int rowsUpdated = updateStmt.executeUpdate();

                    success = rowsUpdated > 0;
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }

            conn.commit(); 
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback(); 
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (stmt != null)
                    stmt.close();
                if (conn != null) {
                    conn.setAutoCommit(true); 
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return success;
    }
}
