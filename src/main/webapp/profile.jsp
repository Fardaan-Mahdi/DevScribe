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
    <title>Profile - DevScribe</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/mystyle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">

    <style>
        .profile-pic-container {
            position: relative;
            width: 150px;
            height: 150px;
            margin: 0 auto 20px;
        }

        .profile-pic {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #e0e0e0;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .profile-pic-edit {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #e0e0e0;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .profile-pic-edit:hover {
            opacity: 0.8;
            border-color: #007bff;
        }

        .profile-pic-wrapper {
            position: relative;
            display: inline-block;
        }

        .change-pic-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
            cursor: pointer;
        }

        .profile-pic-wrapper:hover .change-pic-overlay {
            opacity: 1;
        }

        .change-pic-overlay i {
            color: white;
            font-size: 24px;
        }

        #profile-input {
            display: none;
        }

        .file-info {
            font-size: 0.85rem;
            color: #6c757d;
            margin-top: 10px;
        }
    </style>
</head>

<body>
    <%@include file="navbar.jsp" %>

    <main class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card">
                    <div class="card-header card-header-primary text-white d-flex justify-content-between align-items-center">
                        <h3 class="m-0"><i class="fa-solid fa-user"></i> My Profile</h3>
                        <button class="btn btn-light btn-sm" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                            <i class="fa-solid fa-pen-to-square"></i> Edit Profile
                        </button>
                    </div>
                    <div class="card-body">
                        <!-- Profile Picture -->
                        <div class="profile-pic-container">
                            <img src="img/profiles/<%= currentUser.getProfile() != null ? currentUser.getProfile() : "default.png" %>"
                                 alt="Profile Picture"
                                 class="profile-pic"
                                 id="current-profile-pic">
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Full Name:</div>
                            <div class="col-md-8" id="display-name"><%= currentUser.getName() %></div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Username:</div>
                            <div class="col-md-8" id="display-username">@<%= currentUser.getUsername() %></div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Email:</div>
                            <div class="col-md-8" id="display-email"><%= currentUser.getEmail() %></div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Gender:</div>
                            <div class="col-md-8" id="display-gender"><%= currentUser.getGender() %></div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Member Since:</div>
                            <div class="col-md-8"><%= currentUser.getDateTime() %></div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">About:</div>
                            <div class="col-md-8" id="display-about">
                                <%= (currentUser.getAbout() != null && !currentUser.getAbout().isEmpty())
                                    ? currentUser.getAbout()
                                    : "<em class='text-muted'>No description added</em>" %>
                            </div>
                        </div>

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

    <!-- Edit Profile Modal -->
    <div class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header card-header-primary text-white">
                    <h5 class="modal-title" id="editProfileModalLabel">
                        <i class="fa-solid fa-pen-to-square"></i> Edit Profile
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editProfileForm" action="EditProfileServlet" method="post" enctype="multipart/form-data">
                        <!-- Profile Picture Section -->
                        <div class="text-center mb-4">
                            <div class="profile-pic-wrapper">
                                <img src="img/profiles/<%= currentUser.getProfile() != null ? currentUser.getProfile() : "default.png" %>"
                                     alt="Profile Picture"
                                     class="profile-pic-edit"
                                     id="profile-preview">
                                <div class="change-pic-overlay" onclick="document.getElementById('profile-input').click()">
                                    <i class="fa-solid fa-camera"></i>
                                </div>
                            </div>
                            <input type="file"
                                   id="profile-input"
                                   name="profile"
                                   accept="image/jpeg,image/png,image/jpg,image/gif">
                            <div class="file-info">
                                <small><i class="fa-solid fa-circle-info"></i> Click on image to change profile picture</small><br>
                                <small class="text-muted">Accepted formats: JPG, PNG, GIF (Max 10MB)</small>
                            </div>
                            <div id="file-name" class="mt-2 text-primary" style="display: none;">
                                <small><i class="fa-solid fa-file-image"></i> <span id="selected-file-name"></span></small>
                            </div>
                        </div>

                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="edit-fullname" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="edit-fullname"
                                       name="fullname" value="<%= currentUser.getName() %>" required>
                            </div>
                            <div class="col-md-6">
                                <label for="edit-username" class="form-label">Username</label>
                                <input type="text" class="form-control" id="edit-username"
                                       name="username" value="<%= currentUser.getUsername() %>" required>
                            </div>
                            <div class="col-md-6">
                                <label for="edit-email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="edit-email"
                                       name="email" value="<%= currentUser.getEmail() %>" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label d-block">Gender</label>
                                <div class="d-flex gap-3 mt-2">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="gender"
                                               id="edit-male" value="Male"
                                               <%= "Male".equals(currentUser.getGender()) ? "checked" : "" %>>
                                        <label class="form-check-label" for="edit-male">Male</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="gender"
                                               id="edit-female" value="Female"
                                               <%= "Female".equals(currentUser.getGender()) ? "checked" : "" %>>
                                        <label class="form-check-label" for="edit-female">Female</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="gender"
                                               id="edit-other" value="Other"
                                               <%= "Other".equals(currentUser.getGender()) ? "checked" : "" %>>
                                        <label class="form-check-label" for="edit-other">Other</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                <label for="edit-about" class="form-label">About Yourself</label>
                                <textarea class="form-control" id="edit-about" name="about"
                                          rows="3"><%= currentUser.getAbout() != null ? currentUser.getAbout() : "" %></textarea>
                            </div>
                        </div>

                        <!-- Loader -->
                        <div class="text-center mt-3" id="edit-loader" style="display: none;">
                            <i class="fa fa-spinner fa-spin fa-2x"></i>
                            <p>Updating profile...</p>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary-background text-white" id="saveProfileBtn">
                        <i class="fa-solid fa-floppy-disk"></i> Save Changes
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- JS -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/myscript.js"></script>

    <script>
        $(document).ready(function() {
            console.log("Profile page loaded...");

            // Handle profile picture preview
            $('#profile-input').on('change', function(e) {
                const file = e.target.files[0];

                if (file) {
                    // Validate file size (10MB)
                    if (file.size > 10 * 1024 * 1024) {
                        Swal.fire({
                            icon: 'error',
                            title: 'File Too Large',
                            text: 'Please select an image smaller than 10MB.'
                        });
                        this.value = '';
                        return;
                    }

                    // Validate file type
                    const validTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
                    if (!validTypes.includes(file.type)) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Invalid File Type',
                            text: 'Please select a valid image file (JPG, PNG, or GIF).'
                        });
                        this.value = '';
                        return;
                    }

                    // Show file name
                    $('#selected-file-name').text(file.name);
                    $('#file-name').show();

                    // Preview image
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        $('#profile-preview').attr('src', e.target.result);
                    };
                    reader.readAsDataURL(file);
                }
            });

            // Handle save profile button click
            $('#saveProfileBtn').on('click', function() {
                const form = $('#editProfileForm')[0];

                const fullname = $('#edit-fullname').val().trim();
                const username = $('#edit-username').val().trim();
                const email = $('#edit-email').val().trim();
                const gender = $('input[name="gender"]:checked').val();
                const about = $('#edit-about').val();

                console.log("Form Data:", { fullname, username, email, gender, about });

                // Validate form
                if (!form.checkValidity()) {
                    form.reportValidity();
                    return;
                }

                // Show loader and disable button
                $('#edit-loader').show();
                $('#saveProfileBtn').prop('disabled', true);

                // Create FormData
                const formData = new FormData(form);

                // Send AJAX request
                $.ajax({
                    url: 'EditProfileServlet',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(response) {
                        $('#edit-loader').hide();
                        $('#saveProfileBtn').prop('disabled', false);

                        const trimmedResponse = response.trim();

                        if (trimmedResponse === 'done') {
                            // Success - close modal and show success message
                            const modal = bootstrap.Modal.getInstance(document.getElementById('editProfileModal'));
                            modal.hide();

                            Swal.fire({
                                icon: 'success',
                                title: 'Profile Updated!',
                                text: 'Your profile has been updated successfully.',
                                timer: 2000,
                                showConfirmButton: false
                            }).then(() => {
                                // Reload page to show updated data
                                location.reload();
                            });
                        } else if (trimmedResponse === 'exists_username') {
                            Swal.fire({
                                icon: 'warning',
                                title: 'Username Taken',
                                text: 'This username is already taken. Please choose a different one.'
                            });
                            $('#edit-username').focus();
                        } else if (trimmedResponse === 'exists_email') {
                            Swal.fire({
                                icon: 'warning',
                                title: 'Email Already Exists',
                                text: 'This email is already registered. Please use a different one.'
                            });
                            $('#edit-email').focus();
                        } else if (trimmedResponse === 'invalid_file_type') {
                            Swal.fire({
                                icon: 'error',
                                title: 'Invalid File Type',
                                text: 'Please upload only image files (JPG, PNG, GIF).'
                            });
                        } else if (trimmedResponse === 'session_expired') {
                            Swal.fire({
                                icon: 'error',
                                title: 'Session Expired',
                                text: 'Your session has expired. Please login again.'
                            }).then(() => {
                                window.location.href = 'login.jsp';
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Update Failed',
                                text: trimmedResponse
                            });
                        }
                    },
                    error: function(xhr, status, error) {
                        $('#edit-loader').hide();
                        $('#saveProfileBtn').prop('disabled', false);

                        console.error('Error:', error);
                        Swal.fire({
                            icon: 'error',
                            title: 'Network Error',
                            text: 'Unable to connect to the server. Please try again.'
                        });
                    }
                });
            });

            // Reset form when modal is closed
            $('#editProfileModal').on('hidden.bs.modal', function() {
                // Reset to original profile picture
                $('#profile-preview').attr('src', 'img/profiles/<%= currentUser.getProfile() != null ? currentUser.getProfile() : "default.png" %>');
                $('#file-name').hide();
                $('#profile-input').val('');
            });
        });
    </script>
</body>

</html>