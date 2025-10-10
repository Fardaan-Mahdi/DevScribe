package com.devscribe.servlets;

import com.devscribe.dao.UserDao;
import com.devscribe.entities.User;
import com.devscribe.helper.ConnectionProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
@WebServlet("/RegisterServlet")
@MultipartConfig
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try(PrintWriter out=resp.getWriter()){
            String name=req.getParameter("fullname");
            String username=req.getParameter("username");
            String email=req.getParameter("email");
            String password=req.getParameter("password");
            String gender=req.getParameter("gender");
            String about=req.getParameter("about");

            // Basic validation

            if (name == null || name.trim().isEmpty() ||
                    username == null || username.trim().isEmpty() ||
                    email == null || email.trim().isEmpty() ||
                    password == null || password.trim().isEmpty() ||
                    gender == null || gender.trim().isEmpty()) {
                out.println("Please fill all required fields!");
                return;
            }
            // Creating user object

            UserDao dao=new UserDao(ConnectionProvider.getConnection());
            if(dao.isEmailExists(email)){
                out.println("email_exist");
                return;
            }
            if (dao.isUsernameExists(username)) {
                out.print("exists_username"); // Special response for existing username
                return;
            }


            User user=new User(name, username, email, password, gender, about);
            if(dao.saveUser(user)){
                out.println("done");
            }else{
                out.println("User Not Added!");
            }





        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
