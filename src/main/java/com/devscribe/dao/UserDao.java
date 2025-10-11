package com.devscribe.dao;
import com.devscribe.entities.User;

import java.sql.*;


public class UserDao {
    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

    //inserting data to database
    public boolean saveUser(User user) {
        boolean flag = false;
        try {
            PreparedStatement preparedStatement;

            // Check if about is empty or null
            if (user.getAbout() == null || user.getAbout().trim().isEmpty()) {
                // Omit the 'about' column, so MySQL will use the default value
                String query = "INSERT INTO users(name, username, email, password, gender, profile) VALUES(?,?,?,?,?, ?)";
                preparedStatement = this.con.prepareStatement(query);
                preparedStatement.setString(1, user.getName());
                preparedStatement.setString(2, user.getUsername());
                preparedStatement.setString(3, user.getEmail());
                preparedStatement.setString(4, user.getPassword());
                preparedStatement.setString(5, user.getGender());
                preparedStatement.setString(6, user.getProfile());
            } else {
                // Include 'about' column if user has entered a value
                String query = "INSERT INTO users(name, username, email, password, gender, about,profile) VALUES(?,?,?,?,?,?,?)";
                preparedStatement = this.con.prepareStatement(query);
                preparedStatement.setString(1, user.getName());
                preparedStatement.setString(2, user.getUsername());
                preparedStatement.setString(3, user.getEmail());
                preparedStatement.setString(4, user.getPassword());
                preparedStatement.setString(5, user.getGender());
                preparedStatement.setString(6, user.getAbout());
                preparedStatement.setString(7, user.getProfile());
            }

            preparedStatement.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
    public boolean isUsernameExists(String username) {
        String query = "SELECT COUNT(*) FROM users WHERE username = ?";

        try (PreparedStatement pstmt = this.con.prepareStatement(query)) {
            pstmt.setString(1, username);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Database error in isUsernameExists: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean isEmailExists(String email) {
        String query = "SELECT COUNT(*) FROM users WHERE email = ?";

        try (PreparedStatement pstmt = this.con.prepareStatement(query)) {
            pstmt.setString(1, email);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Database error in isEmailExists: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }


    public User getUserByEmailAndPassword(String email, String password) {
        String query = "SELECT * FROM users WHERE email = ? AND password = ?";
        try (PreparedStatement pstmt = this.con.prepareStatement(query)) {
            pstmt.setString(1, email);
            pstmt.setString(2, password); // Should be hashed in production!

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractUserFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Database error in getUserByEmailAndPassword: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateUser(User user) {
        String query = "UPDATE users SET name = ?, username = ?, email = ?, gender = ?, about = ?, profile = ? WHERE id = ?";

        try (PreparedStatement pstmt = this.con.prepareStatement(query)) {
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getUsername());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getGender());

            String about = user.getAbout();
            if (about == null || about.trim().isEmpty()) {
                pstmt.setNull(5, Types.VARCHAR);
            } else {
                pstmt.setString(5, about.trim());
            }

            pstmt.setString(6, user.getProfile());
            pstmt.setInt(7, user.getId());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLIntegrityConstraintViolationException e) {
            // Handle duplicate username or email during update
            System.err.println("Duplicate entry during update: " + e.getMessage());
            return false;
        } catch (SQLException e) {
            System.err.println("Database error in updateUser: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        return new User(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("username"),
                rs.getString("email"),
                rs.getString("password"),
                rs.getString("gender"),
                rs.getTimestamp("rdate"),
                rs.getString("about"),
                rs.getString("profile")
        );
    }

}
