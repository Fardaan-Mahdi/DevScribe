<%@page import="java.sql.*" %>
    <%@ page import="com.devscribe.helper.ConnectionProvider" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Register - DevScribe</title>

            <!-- CSS -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css">
            <link rel="stylesheet" href="css/mystyle.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
        </head>

        <body>
            <!-- navbar -->
            <%@ include file="navbar.jsp" %>

                <!-- Register Form -->
                <main class="banner-background hero-section d-flex align-items-center" style="min-height: 80vh;">
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-6 col-md-8 col-sm-10">
                                <div class="card mb-5">
                                    <div class="card-header card-header-primary text-white">
                                        <h3 class="text-center m-0"><i class="fa-solid fa-user-plus"></i> Register</h3>
                                    </div>
                                    <div class="card-body">
                                        <form action="register_action.jsp" method="post">
                                            <div class="row g-3">
                                                <div class="col-md-6">
                                                    <label for="fullname" class="form-label">Full Name</label>
                                                    <input type="text" class="form-control" id="fullname"
                                                        name="fullname" placeholder="Enter full name" required>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="username" class="form-label">Username</label>
                                                    <input type="text" class="form-control" id="username"
                                                        name="username" placeholder="Enter username" required>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="email" class="form-label">Email</label>
                                                    <input type="email" class="form-control" id="email" name="email"
                                                        placeholder="Enter email" required>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="password" class="form-label">Password</label>
                                                    <input type="password" class="form-control" id="password"
                                                        name="password" placeholder="Enter password" required>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="confirm_password" class="form-label">Confirm
                                                        Password</label>
                                                    <input type="password" class="form-control" id="confirm_password"
                                                        name="confirm_password" placeholder="Confirm password" required>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label d-block">Gender</label>
                                                    <div class="d-flex gap-3">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="gender"
                                                                id="male" value="Male" required>
                                                            <label class="form-check-label" for="male">Male</label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="gender"
                                                                id="female" value="Female">
                                                            <label class="form-check-label" for="female">Female</label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="gender"
                                                                id="other" value="Other">
                                                            <label class="form-check-label" for="other">Other</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12">
                                                    <label for="about" class="form-label">About Yourself</label>
                                                    <textarea class="form-control" id="about" name="about" rows="2"
                                                        placeholder="Write something about yourself..."></textarea>
                                                </div>
                                                <div class="col-12">
                                                    <button type="submit"
                                                        class="btn btn-primary-background text-white w-100">Register</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="card-footer text-center bg-light-blue">
                                        <small>Already have an account? <a href="login.jsp"
                                                class="text-primary-background">Login here</a></small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>




                <!-- JS -->
                <script src="https://code.jquery.com/jquery-3.7.1.min.js" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
                <script src="js/myscript.js"></script>

        </body>

        </html>