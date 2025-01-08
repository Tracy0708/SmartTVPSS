<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add School</title>
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
            max-width: 800px;
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
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #2c3e50;
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
            box-shadow: 0 0 0 2px rgba(52,152,219,0.2);
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

        /* Button styles */
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .btn-primary {
            background-color: #3498db;
            color: white;
        }

        .btn-secondary {
            background-color: #95a5a6;
            color: white;
            margin-left: 10px;
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
    <div class="container">
        <div class="header">
            <h2>Add School Information</h2>
        </div>

        <div class="form-container">
            <form action="${pageContext.request.contextPath}/school/add" method="post">
                <div class="form-group">
                    <label class="form-label">School Code</label>
                    <input type="text" name="schoolCode" class="form-control" required>
                </div>

                <div class="form-group">
                    <label class="form-label">School Name</label>
                    <input type="text" name="schoolName" class="form-control" required>
                </div>

                <div class="checkbox-group">
                    <h3 class="form-label">Equipment</h3>
                    
                    <div class="checkbox-container">
                        <input type="checkbox" name="hasLogo" id="hasLogo">
                        <label for="hasLogo">Logo</label>
                    </div>

                    <div class="checkbox-container">
                        <input type="checkbox" name="hasStudioPss" id="hasStudioPss">
                        <label for="hasStudioPss">Corner/Mini studio/School PSS studio</label>
                    </div>

                    <div class="checkbox-container">
                        <input type="checkbox" name="hasInSchoolRecording" id="hasInSchoolRecording">
                        <label for="hasInSchoolRecording">Recording in school</label>
                    </div>

                    <div class="checkbox-container">
                        <input type="checkbox" name="hasYoutubeUpload" id="hasYoutubeUpload">
                        <label for="hasYoutubeUpload">Upload in Youtube</label>
                    </div>

                    <div class="form-group" id="youtubeUrlGroup" style="display: none;">
                        <label class="form-label">Youtube URL</label>
                        <input type="url" name="youtubeUrl" class="form-control">
                    </div>

                    <div class="checkbox-container">
                        <input type="checkbox" name="hasExternalRecording" id="hasExternalRecording">
                        <label for="hasExternalRecording">Recording inside/outside the school</label>
                    </div>

                    <div class="checkbox-container">
                        <input type="checkbox" name="hasExternalCollaboration" id="hasExternalCollaboration">
                        <label for="hasExternalCollaboration">Collaboration with external agencies</label>
                    </div>

                    <div class="checkbox-container">
                        <input type="checkbox" name="hasGreenScreen" id="hasGreenScreen">
                        <label for="hasGreenScreen">Use Green Screen technology</label>
                    </div>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-primary">Add Status</button>
                    <a href="${pageContext.request.contextPath}/schools/list" class="btn btn-secondary">Back</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.getElementById('hasYoutubeUpload').addEventListener('change', function() {
            document.getElementById('youtubeUrlGroup').style.display = this.checked ? 'block' : 'none';
        });
    </script>
</body>
</html>