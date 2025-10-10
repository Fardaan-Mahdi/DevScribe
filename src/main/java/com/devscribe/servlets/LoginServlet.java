package com.devscribe.servlets;

import com.devscribe.dao.UserDao;
import com.devscribe.entities.Message;
import com.devscribe.entities.User;
import com.devscribe.helper.ConnectionProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try(PrintWriter out=resp.getWriter()){
            String email=req.getParameter("email");
            String password=req.getParameter("password");

            try(Connection con= ConnectionProvider.getConnection()){
                UserDao dao=new UserDao(con);
                User user=dao.getUserByEmailAndPassword(email,password);

                if (user != null) {
                    // Login successful - create session
                    HttpSession session = req.getSession();
                    session.setAttribute("currentUser", user);
                    session.setMaxInactiveInterval(30 * 60); // 30 minutes
                    resp.sendRedirect("profile.jsp");
                    out.print("success");
                } else {
                    // Login failed
                    Message msg=new Message("Invalid Email or Password!", "error", "alert-danger");
                    HttpSession session = req.getSession();
                    session.setAttribute("message", msg);
                    resp.sendRedirect("login.jsp");
                }


            } catch (Exception e) {
                System.err.println("Database error in login: " + e.getMessage());
                e.printStackTrace();
                out.print("An error occurred. Please try again later.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
