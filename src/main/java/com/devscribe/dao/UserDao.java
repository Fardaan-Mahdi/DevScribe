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
                String query = "INSERT INTO users(name, username, email, password, gender) VALUES(?,?,?,?,?)";
                preparedStatement = this.con.prepareStatement(query);
                preparedStatement.setString(1, user.getName());
                preparedStatement.setString(2, user.getUsername());
                preparedStatement.setString(3, user.getEmail());
                preparedStatement.setString(4, user.getPassword());
                preparedStatement.setString(5, user.getGender());
            } else {
                // Include 'about' column if user has entered a value
                String query = "INSERT INTO users(name, username, email, password, gender, about) VALUES(?,?,?,?,?,?)";
                preparedStatement = this.con.prepareStatement(query);
                preparedStatement.setString(1, user.getName());
                preparedStatement.setString(2, user.getUsername());
                preparedStatement.setString(3, user.getEmail());
                preparedStatement.setString(4, user.getPassword());
                preparedStatement.setString(5, user.getGender());
                preparedStatement.setString(6, user.getAbout());
            }

            preparedStatement.executeUpdate();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

}
