<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Added Successfully</title>
    <style>
        body {
            font-family: times new roman;
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .modal {
            background-color: rgba(0, 0, 0, 0.5);
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        .modal-content {
            background-color: #003d73;
            border-radius: 12px;
            padding: 30px;
            width: 400px;
            text-align: center;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        .modal-content h2 {
            color: #00ff90;
            font-size: 1.8rem;
            margin-bottom: 15px;
        }

        .modal-content p {
            color: #fff;
            font-size: 1rem;
            margin-bottom: 20px;
        }

        .close-button {
            font-family: 'Times New Roman', serif;
            background-color: #ffaa00;
            color: #003d73;
            font-weight: bold;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
            transition: all 0.3s;
        }

        .close-button:hover {
            background-color: #ffcc33;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(255, 170, 0, 0.4);
        }

        .blur-background {
            filter: blur(5px);
        }
    </style>
    <script>
        function closeModal() {
            window.location.href = "/TVPSS/user/userList";  // Navigate to User List
        }
    </script>
</head>
<body>
    <!-- Blurred Background -->
    <div class="blur-background">
        <div style="text-align: center;">
            <!-- Optionally, display form details or other info here -->
        </div>
    </div>

    <!-- Modal -->
    <div class="modal">
        <div class="modal-content">
            <h2>User Added Successfully</h2>
            <p>The new user has been added to the system.</p>
            <a href="/SmartTVPSS/TVPSS/user/userList" class="close-button" style="text-decoration: none;">Go to User List</a>
            <br><br>
            <p> </p>
            <a href="/SmartTVPSS/TVPSS/user/add" class="close-button" style="text-decoration: none;">Add Another User</a>
        </div>
    </div>
</body>
</html>