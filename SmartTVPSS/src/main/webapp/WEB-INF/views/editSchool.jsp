<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit School</title>
  
  <style>
        /* Base styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            background-color: #f5f5f5;
            color: #333;
        }

        .container {
             max-width: 2000px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Header styles */
        .header {
            margin-bottom: 20px;
        }

        .header h2 {
            color: #2c3e50;
        }

        /* Form styles */
        .form-container {
                background-color: white;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            padding: 24px;
            width:1000px;
          
        }

        .form-group {
             margin-bottom: 16px;
        }

        .form-label {
          display: block;
            margin-bottom: 8px;
            color: #333;
            font-size: 14px;
        }
          .required::after {
            content: ' *';
            color: #e74c3c;
        }

        .form-control {
           width: 100%;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .form-control:focus {
               outline: none;
            border-color: #3498db;
        }

        /* Checkbox styles */
        .checkbox-group {
            margin-top: 20px;
        }

        .checkbox-container {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .checkbox-container input[type="checkbox"] {
            margin-right: 10px;
        }
        .back-title {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 20px;
        }

        .back-title a {
            text-decoration: none;
            color: #333;
        }
         .form-columns {
            display: flex;
            gap: 32px;
            margin-top: 24px;
        }

        .form-column {
            flex: 1;
        }

        .column-title {
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 16px;
            color: #333;
        }

        /* Toggle switch styles */
        .toggle-container {
            display: flex;
            align-items: center;
            margin-bottom: 16px;
        }

        .toggle-label {
            font-size: 14px;
            color: #333;
            margin-left:20px;
        }

        .switch {
            position: relative;
            display: inline-block;
            width: 44px;
            height: 24px;
        }

        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 24px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .slider {
            background-color: #3498db;
        }

        input:checked + .slider:before {
            transform: translateX(20px);
        }

        /* YouTube URL input */
        .youtube-url {
            display:none;
            margin-top: 130px;
            margin-bottom: 16px;
   			gap: 10px;
        }
        

        /* Button styles */
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            transition: background-color 0.3s;
            justify-content:center;
        }

        .btn-primary {
            background-color: #3498db;
            color: white;
            margin-left:350px;
            width:80px;
        }

        .btn-secondary {
            background-color: #95a5a6;
            color: white;
            margin-left: 15px;
            width:80px;
        }

        .btn-primary:hover {
            background-color: #2980b9;
        }

        .btn-secondary:hover {
            background-color: #7f8c8d;
        }

        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }

            .form-container {
                padding: 15px;
            }
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="main-container" style="display:flex">
    <jsp:include page="sidebar.jsp" />   
    <div class="container">
        <div class="back-title">
            <a href="${pageContext.request.contextPath}/program/tvpssteam/schoolList">←</a>
            <h2>Edit Information</h2>
        </div>
        <div class="form-container">
            <form id="editSchoolForm" action="${pageContext.request.contextPath}/program/tvpssteam/update" method="post">
                <input type="hidden" name="id" value="${school.id}"/>
                
                <div class="form-group">
                    <label class="form-label required">School Code</label>
                    <input type="text" name="schoolCode" class="form-control" value="${school.schoolCode}" required>
                </div>

                <div class="form-group">
                    <label class="form-label required">School Name</label>
                    <input type="text" name="schoolName" class="form-control" value="${school.schoolName}" required>
                </div>

                <div class="form-columns">
                    <!-- Equipment Column -->
                    <div class="form-column">
                        <h3 class="column-title">Equipment</h3>
                        
                        <div class="toggle-container">
                            <label class="switch">
                                <input type="checkbox" name="hasLogo" ${school.hasLogo ? 'checked' : ''}>
                                <span class="slider"></span>
                            </label>
                            <span class="toggle-label">Logo</span>
                        </div>

                        <div class="toggle-container">
                            <label class="switch">
                                <input type="checkbox" name="hasStudioPss" ${school.hasStudioPss ? 'checked' : ''}>
                                <span class="slider"></span>
                            </label>
                            <span class="toggle-label">Corner/Mini studio/School PSS studio</span>
                        </div>

                        <div class="toggle-container">
                            <label class="switch">
                                <input type="checkbox" name="hasInSchoolRecording" ${school.hasInSchoolRecording ? 'checked' : ''}>
                                <span class="slider"></span>
                            </label>
                            <span class="toggle-label">Recording in school</span>
                        </div>

                        <div class="toggle-container">
                            <label class="switch">
                                <input type="checkbox" id="hasYoutubeUpload" name="hasYoutubeUpload" 
                                       ${school.hasYoutubeUpload ? 'checked' : ''} onchange="toggleYoutubeUrlRequired()">
                                <span class="slider"></span>
                            </label>
                            <span class="toggle-label">Upload in Youtube</span>
                        </div>

                        <div class="toggle-container">
                            <label class="switch">
                                <input type="checkbox" name="hasExternalRecording" ${school.hasExternalRecording ? 'checked' : ''}>
                                <span class="slider"></span>
                            </label>
                            <span class="toggle-label">Recording inside/outside the school</span>
                        </div>

                        <div class="toggle-container">
                            <label class="switch">
                                <input type="checkbox" name="hasExternalCollaboration" ${school.hasExternalCollaboration ? 'checked' : ''}>
                                <span class="slider"></span>
                            </label>
                            <span class="toggle-label">Collaboration with external agencies</span>
                        </div>

                        <div class="toggle-container">
                            <label class="switch">
                                <input type="checkbox" name="hasGreenScreen" ${school.hasGreenScreen ? 'checked' : ''}>
                                <span class="slider"></span>
                            </label>
                            <span class="toggle-label">Use Green Screen technology</span>
                        </div>
                    </div>

                    <!-- Additional Information Column -->
                    <div class="form-column">
                        <h3 class="column-title">Additional Information</h3>
                        <div class="youtube-url" id="youtubeUrlGroup" style="display: ${school.hasYoutubeUpload ? 'flex' : 'none'}">
                            <label for="youtubeUrl" class="required"></label>
                            <input id="youtubeUrl" type="url" name="youtubeUrl" class="form-control" 
                                   value="${school.youtubeUrl}" placeholder="Please provide valid Youtube url">
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-primary">Update</button>
                    <a href="${pageContext.request.contextPath}/program/tvpssteam/schoolList" class="btn btn-secondary">Back</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert2/11.7.32/sweetalert2.min.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const successMessage = "${successMessage}";
        if (successMessage) {
            Swal.fire({
                title: "Success!",
                text: successMessage,
                icon: "success",
                confirmButtonText: "OK"
            }).then(() => {
                window.location.href = "${pageContext.request.contextPath}/program/tvpssteam/schoolList";
            });
        }
    });

    function toggleYoutubeUrlRequired() {
        const checkBox = document.getElementById("hasYoutubeUpload");
        const youtubeUrlGroup = document.getElementById("youtubeUrlGroup");
        const youtubeUrl = document.getElementById("youtubeUrl");
        
        youtubeUrlGroup.style.display = checkBox.checked ? 'flex' : 'none';
        youtubeUrl.required = checkBox.checked;
    }
</script>
</body>
</html>