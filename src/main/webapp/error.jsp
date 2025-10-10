<%@ page isErrorPage="true" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Error: Something Went Wrong!</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/mystyle.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    </head>

    <body>
        <div class="container text-center">
            <img src="img/error.png" alt="Error" class="img-fluid mt-3">
            <h3 class="display-6"><i class="fa-solid fa-triangle-exclamation"></i> Oops! Something went wrong</h3>
            <p>We're sorry, but an unexpected error occurred.<br>
                Please try again later or return to the homepage.</p>
            <a href="index.jsp" class="display-8 btn btn-lg btn-light" style="text-decoration: none;"><i
                    class="fa-solid fa-home"></i> Home</a>

            <% if (exception !=null) { %>
                <div class="mt-3 text-start p-2 bg-light border rounded">
                    <strong>Error Details:</strong>
                    <pre style="white-space: pre-wrap;"><%= exception.getMessage() %></pre>
                </div>
            <% } %>


        </div>
    </body>

    </html>