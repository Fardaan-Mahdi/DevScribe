<%@page import="java.sql.*" %>
    <%@ page import="com.devscribe.helper.ConnectionProvider" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Index Page</title>

            <!-- css -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css">
            <link rel="stylesheet" href="css/mystyle.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
        </head>

        <body>
            <!-- navbar -->
            <%@ include file="navbar.jsp" %>

                <!-- banner -->
                <div class="container-fluid p-0 m-0">
                    <section class="hero-section text-white d-flex align-items-center">
                        <div class="container">
                            <h1 class="display-4 fw-bold mb-3">Welcome to DevScribe</h1>
                            <h4 class="mb-4">A Programming Blog for Curious Minds</h4>
                            <p class="lead mb-4">
                                A space where developers share their knowledge and learn from each other.
                            </p>
                                <button class="btn btn-light btn-lg me-3">
                                    <i class="fa-solid fa-right-to-bracket"></i> Start! It's Free
                                </button>
                                <button class="btn btn-outline-light btn-lg">
                                    <i class="fa-solid fa-user"></i> Login
                                </button>
                        </div>
                    </section>
                </div>



                <!-- js -->
                <script src="https://code.jquery.com/jquery-3.7.1.min.js"
                    integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
                <script src="js/myscript.js"></script>

        </body>

        </html>