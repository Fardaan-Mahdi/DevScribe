package com.devscribe.servlets;

import com.devscribe.dao.UserDao;
import com.devscribe.entities.User;
import com.devscribe.helper.ConnectionProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

@WebServlet("/EditProfileServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 10,       // 10MB
        maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class EditProfileServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try(PrintWriter out=resp.getWriter()){
            HttpSession session=req.getSession(false);
            if (session == null || session.getAttribute("currentUser") == null) {
                out.print("session_expired");
                return;
            }

            User currentUser=(User)session.getAttribute("currentUser");

            String name=req.getParameter("fullname");
            String username=req.getParameter("username");
            String email=req.getParameter("email");
            String gender=req.getParameter("gender");
            String about=req.getParameter("about");

            // Get uploaded file
            Part filePart = req.getPart("profile");

            if (
                    name == null || name.trim().isEmpty() ||
                    username == null || username.trim().isEmpty() ||
                    email == null || email.trim().isEmpty() ||
                    gender == null || gender.trim().isEmpty()
            ){
                out.println("Please fill all required fields!");
                return;
            }

            try(Connection con= ConnectionProvider.getConnection()){
                UserDao dao=new UserDao(con);
                if (!username.equals(currentUser.getUsername())) {
                    if (dao.isUsernameExists(username)) {
                        out.print("exists_username");
                        return;
                    }
                }

                // Check if email changed and if new email already exists
                if (!email.equals(currentUser.getEmail())) {
                    if (dao.isEmailExists(email)) {
                        out.print("exists_email");
                        return;
                    }
                }

                // Handle profile picture upload
                String profileFileName= currentUser.getProfile(); // Keep existing

                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = filePart.getSubmittedFileName();

                    // Validate file type
                    if (!fileName.toLowerCase().matches(".*\\.(jpg|jpeg|png|gif)$")) {
                        out.print("invalid_file_type");
                        return;
                    }

                    // Generate unique filename
                    String fileExtension = fileName.substring(fileName.lastIndexOf("."));
                    profileFileName = "profile_" + currentUser.getId() + "_" +
                            System.currentTimeMillis() + fileExtension;

                    // Get the path to save
                    String uploadPath = getServletContext().getRealPath("") +
                            File.separator + "img" +
                            File.separator + "profiles";

                    // Create directory if it doesn't exist
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    // Delete old profile picture (except default)
                    if (!currentUser.getProfile().equals("default.png")) {
                        File oldFile = new File(uploadPath + File.separator +
                                currentUser.getProfile());
                        if (oldFile.exists()) {
                            oldFile.delete();
                        }
                    }

                    // Save new file
                    String filePath = uploadPath + File.separator + profileFileName;
                    filePart.write(filePath);
                }

                currentUser.setName(name);
                currentUser.setUsername(username);
                currentUser.setEmail(email);
                currentUser.setGender(gender);
                currentUser.setAbout(about);
                currentUser.setProfile(profileFileName);

                if (dao.updateUser(currentUser)) {
                    // Update session with new user data
                    session.setAttribute("currentUser", currentUser);
                    out.print("done");
                } else {
                    out.print("Failed to update profile. Please try again.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.print("An error occurred. Please try again later.");
            }




        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private boolean isEmpty(String str) {
        return str == null || str.isEmpty();
    }
}
