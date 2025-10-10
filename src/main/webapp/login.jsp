<%@ page import="com.devscribe.entities.Message" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/mystyle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">

</head>

<body>
    <!-- navbar -->
    <%@ include file="navbar.jsp" %>

        <main class="d-flex align-items-center banner-background hero-section" style=" height: 70vh;">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 offset-md-4">
                        <div class="card mb-5">
                            <div class="card-header card-header-primary text-white">
                                <h3 class="text-center m-0"><i class="fa-solid fa-user-plus"></i> Login</h3>
                            </div>

                            <%
                                Message msg=(Message)session.getAttribute("message");
                                if (msg!=null) {
                                    %>
                                        <div class="alert <%= msg.getCssClass()%>" role="alert">
                                            <%= msg.getContent() %>
                                        </div>
                                    <%
                                    session.removeAttribute("message");
                                }
                            %>

                            <div class="card-body">
                                <form action="LoginServlet" method="POST">
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email</label>
                                        <input name="email" required type="email" class="form-control" id="email"
                                            placeholder="Enter email">
                                    </div>
                                    <div class="mb-3">
                                        <label for="password" class="form-label">Password</label>
                                        <input name="password" required type="password" class="form-control"
                                            id="password" placeholder="Enter password">
                                    </div>
                                    <button type="submit"
                                        class="btn btn-primary-background text-white w-100">Login</button>
                                </form>
                            </div>
                            <div class="card-footer text-center bg-light-blue">
                                <small>Don't have an account? <a href="register.jsp"
                                        class="text-primary-background">Register here</a></small>
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