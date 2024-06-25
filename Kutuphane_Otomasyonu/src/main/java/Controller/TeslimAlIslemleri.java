package Controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TeslimAlIslemleri {

    public static boolean teslimAl(String email, String book) {
        int userId = getUserIdByEmail(email);
        int bookId = getBookIdByName(book);

        if (userId != -1 && bookId != -1) {
            return teslimAl(userId, bookId);
        }

        return false;
    }

    private static int getUserIdByEmail(String email) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int userId = -1;

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
            closeResources(conn, stmt, rs);
        }

        return userId;
    }

    private static int getBookIdByName(String book) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int bookId = -1;

        try {
            conn = DatabaseConn.getConnection();
            String query = "SELECT id FROM kitaplars WHERE kitap_adi = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, book);

            rs = stmt.executeQuery();

            if (rs.next()) {
                bookId = rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }

        return bookId;
    }

    private static boolean teslimAl(int userId, int bookId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            conn = DatabaseConn.getConnection();
            conn.setAutoCommit(false);

            String deleteOduncQuery = "DELETE FROM odunc WHERE kitap_id = ? AND kullanici_id = ?";
            stmt = conn.prepareStatement(deleteOduncQuery);
            stmt.setInt(1, bookId);
            stmt.setInt(2, userId);

            int rowsDeleted = stmt.executeUpdate();

            if (rowsDeleted > 0) {
                String updateKitaplarsQuery = "UPDATE kitaplars SET odunc_durum = 0 WHERE id = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateKitaplarsQuery);
                updateStmt.setInt(1, bookId);

                int rowsUpdated = updateStmt.executeUpdate();

                success = rowsUpdated > 0;
            }

            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            rollbackConnection(conn);
        } finally {
            closeResources(conn, stmt, null);
        }

        return success;
    }

    public static List<String> getAvailableUsers() {
        List<String> users = new ArrayList<>();

        try (Connection conn = DatabaseConn.getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement("SELECT email FROM kullanicilar");
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                users.add(resultSet.getString("email"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }

    public static List<String> getAvailableBooks() {
        List<String> books = new ArrayList<>();

        try (Connection conn = DatabaseConn.getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement("SELECT kitap_adi FROM kitaplars WHERE odunc_durum =1");
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                books.add(resultSet.getString("kitap_adi"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return books;
    }

    private static void closeResources(Connection conn, PreparedStatement stmt, ResultSet rs) {
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

    private static void rollbackConnection(Connection conn) {
        try {
            if (conn != null) {
                conn.rollback();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
