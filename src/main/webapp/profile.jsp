<%@ page errorPage="error.jsp" %>
<%@ page import="com.devscribe.entities.User" %>

<% 
    User currentUser=(User) session.getAttribute("currentUser"); 
    if (currentUser==null) {
        response.sendRedirect("login.jsp"); 
        return; 
    } 
%>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Profile</title>

            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css">
            <link rel="stylesheet" href="css/mystyle.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
        </head>

        <body>
            <%@include file="navbar.jsp" %>
                <main class="container mt-5">
                    <div class="row justify-content-center">
                        <div class="col-lg-8">
                            <div class="card">
                                <div class="card-header card-header-primary text-white">
                                    <h3 class="text-center m-0"><i class="fa-solid fa-user"></i> My Profile</h3>
                                </div>
                                <div class="card-body">
                                    <div class="row mb-3">
                                        <div class="col-md-4 fw-bold">Full Name:</div>
                                        <div class="col-md-8">
                                            <%= currentUser.getName() %>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-4 fw-bold">Username:</div>
                                        <div class="col-md-8">@<%= currentUser.getUsername() %>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-4 fw-bold">Email:</div>
                                        <div class="col-md-8">
                                            <%= currentUser.getEmail() %>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-4 fw-bold">Gender:</div>
                                        <div class="col-md-8">
                                            <%= currentUser.getGender() %>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-4 fw-bold">Member Since:</div>
                                        <div class="col-md-8">
                                            <%= currentUser.getDateTime() %>
                                        </div>
                                    </div>
                                    <% if (currentUser.getAbout() !=null && !currentUser.getAbout().isEmpty()) { %>
                                        <div class="row mb-3">
                                            <div class="col-md-4 fw-bold">About:</div>
                                            <div class="col-md-8">
                                                <%= currentUser.getAbout() %>
                                            </div>
                                        </div>
                                        <% } %>

                                            <hr>

                                            <div class="text-center">
                                                <a href="LogoutServlet" class="btn btn-danger">
                                                    <i class="fa-solid fa-right-from-bracket"></i> Logout
                                                </a>
                                            </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>


                <script src="https://code.jquery.com/jquery-3.7.1.min.js"
                    integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
                <script src="js/myscript.js"></script>

        </body>

        </html>