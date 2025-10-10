package com.devscribe.servlets;

import com.devscribe.entities.Message;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession(false);
        session.removeAttribute("currentUser");

        Message msg=new Message("Logout Successfully!","success","alert-success");
        session.setAttribute("message",msg);

        resp.sendRedirect("login.jsp");
    }
}
