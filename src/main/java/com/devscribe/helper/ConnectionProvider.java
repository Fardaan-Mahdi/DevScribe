package com.devscribe.helper;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider {
    public static Connection con;
    private static final String url="jdbc:mysql://127.0.0.1:3306/DevScribe";
    private static final String username="root";
    private static final String password="mysql123";

    public static Connection getConnection(){

        try {
            if(con==null) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(url, username, password);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }




        return con;
    }

}
