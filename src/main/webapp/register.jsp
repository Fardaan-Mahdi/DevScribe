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
                                        <form id="regform" action="RegisterServlet" method="POST">
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
                                                <div class="col-12 text-center" id="loader"
                                                    style="display: none; margin-bottom: 15px;">
                                                    <i class="fa fa-spinner fa-spin fa-2x"></i>
                                                    <p>Processing...</p>
                                                </div>

                                                <div class="col-12">
                                                    <button type="submit"
                                                        class="btn btn-primary-background text-white w-100">Register</button>
                                                </div>
                                                <h6 id="passwordError" class="text-danger" style="display:none;">
                                                    Passwords do not match!</h6>
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
                <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                <script src="js/myscript.js"></script>


                <script>
                    // Optimized registration form handling
                    (function () {
                        'use strict';

                        const form = document.getElementById('regform');
                        const loader = document.getElementById('loader');
                        const submitBtn = form.querySelector('button[type="submit"]');
                        const passwordError = document.getElementById('passwordError');

                        // Password validation
                        function validatePassword() {
                            const password = document.getElementById('password').value;
                            const confirmPassword = document.getElementById('confirm_password').value;

                            if (password !== confirmPassword) {
                                passwordError.style.display = 'block';
                                return false;
                            }
                            passwordError.style.display = 'none';
                            return true;
                        }

                        // Real-time password matching feedback
                        const confirmPasswordField = document.getElementById('confirm_password');
                        confirmPasswordField.addEventListener('input', validatePassword);

                        // Toggle UI during submission
                        function toggleSubmitState(isSubmitting) {
                            if (isSubmitting) {
                                loader.style.display = 'block';
                                submitBtn.disabled = true;
                                submitBtn.style.display = 'none';
                            } else {
                                loader.style.display = 'none';
                                submitBtn.disabled = false;
                                submitBtn.style.display = 'block';
                            }
                        }

                        // Handle form submission
                        form.addEventListener('submit', function (e) {
                            e.preventDefault();

                            // Validate passwords match
                            if (!validatePassword()) {
                                return;
                            }

                            toggleSubmitState(true);

                            const formData = new FormData(form);

                            fetch('RegisterServlet', {
                                method: 'POST',
                                body: formData
                            })
                                .then(response => response.text())
                                .then(data => {
                                    toggleSubmitState(false);

                                    const trimmedResponse = data.trim();

                                    if (trimmedResponse === 'done') {
                                        Swal.fire({
                                            icon: 'success',
                                            title: 'Success!',
                                            text: 'Registration successful! Redirecting to login...',
                                            timer: 2000,
                                            showConfirmButton: false,
                                            allowOutsideClick: false
                                        }).then(() => {
                                            window.location.href = 'login.jsp';
                                        });
                                    } else if (trimmedResponse === 'exists_username') {
                                        // Username already exists
                                        Swal.fire({
                                            icon: 'warning',
                                            title: 'Username Taken',
                                            text: 'This username is already taken. Please choose a different one.',
                                            confirmButtonText: 'OK'
                                        }).then(() => {
                                            // Clear username field and focus on it
                                            document.getElementById('username').value = '';
                                            document.getElementById('username').focus();
                                        });
                                    } else if (trimmedResponse === 'email_exist') {
                                        // Email already exists - show login option
                                        Swal.fire({
                                            icon: 'warning',
                                            title: 'User Already Exists',
                                            text: 'An account with this email already exists.',
                                            showCancelButton: true,
                                            confirmButtonText: 'Go to Login',
                                            cancelButtonText: 'Try Different Email',
                                            confirmButtonColor: '#3085d6',
                                            cancelButtonColor: '#6c757d'
                                        }).then((result) => {
                                            if (result.isConfirmed) {
                                                window.location.href = 'login.jsp';
                                            } else {
                                                // Clear email field and focus on it
                                                document.getElementById('email').value = '';
                                                document.getElementById('email').focus();
                                            }
                                        });
                                    } else {
                                        Swal.fire({
                                            icon: 'error',
                                            title: 'Registration Failed',
                                            text: trimmedResponse || 'An error occurred during registration.'
                                        });
                                    }
                                })
                                .catch(error => {
                                    toggleSubmitState(false);
                                    console.error('Registration error:', error);
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Network Error',
                                        text: 'Unable to connect to the server. Please check your connection and try again.'
                                    });
                                });
                        });
                    })();
                </script>
        </body>

        </html>