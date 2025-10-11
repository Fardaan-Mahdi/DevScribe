<%@page import="com.devscribe.entities.User" %>
<% User navUser=(User) session.getAttribute("currentUser"); %>

<style>
  .navbar-profile-pic {
    width: 35px;
    height: 35px;
    border-radius: 50%;
    object-fit: cover;
    border: 2px solid #fff;
    margin-right: 8px;
    vertical-align: middle;
  }
  
  .profile-link {
    display: flex;
    align-items: center;
  }
  
  .navbar-username {
    display: inline-block;
    max-width: 120px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    vertical-align: middle;
  }
  
  @media (max-width: 991px) {
    .navbar-profile-pic {
      width: 30px;
      height: 30px;
    }
    
    .navbar-username {
      max-width: 100%;
    }
  }
</style>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark-blue sticky-top">
  <div class="container-fluid">
    <a class="navbar-brand text-cream" href="index.jsp"><i class="fa-solid fa-blog"></i> DevScribe</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
      aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="index.jsp"><i class="fa-solid fa-house"></i> Home</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
            aria-expanded="false">
            <i class="fa-solid fa-layer-group"></i> Category
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">Code</a></li>
            <li><a class="dropdown-item" href="#">Project</a></li>
            <li><a class="dropdown-item" href="#">Data Structures</a></li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#"><i class="fa-solid fa-phone"></i> Contact</a>
        </li>
      </ul>
      <ul class="navbar-nav mr-right">
        <% if (navUser==null) { %>
          <!-- Not logged in - show login/register -->
          <li class="nav-item">
            <a class="nav-link" href="login.jsp">
              <i class="fa-solid fa-right-to-bracket"></i> Login
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="register.jsp">
              <i class="fa-solid fa-user"></i> Register
            </a>
          </li>
        <% } else { %>
          <!-- Logged in - show profile picture and username -->
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle profile-link" href="#" role="button" 
               data-bs-toggle="dropdown" aria-expanded="false">
              <img src="img/profiles/<%= navUser.getProfile() != null ? navUser.getProfile() : "default.png" %>" 
                   alt="Profile" 
                   class="navbar-profile-pic"
                   onerror="this.src='img/profiles/default.png'">
              <span class="navbar-username">@<%= navUser.getUsername() %></span>
            </a>
            <ul class="dropdown-menu dropdown-menu-end">
              <li>
                <a class="dropdown-item" href="profile.jsp">
                  <i class="fa-solid fa-user"></i> My Profile
                </a>
              </li>
              <li><hr class="dropdown-divider"></li>
              <li>
                <a class="dropdown-item text-danger" href="LogoutServlet">
                  <i class="fa-solid fa-right-from-bracket"></i> Logout
                </a>
              </li>
            </ul>
          </li>
        <% } %>
      </ul>
    </div>
  </div>
</nav>