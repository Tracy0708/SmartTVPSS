<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> <!-- SweetAlert for Popups -->
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <style>
        .custom-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: 'Times New Roman', serif;
            background-color: #f0f0f0;
        }

        .custom-card {
            display: flex;
            width: 1000px;
            height: 600px;
            background-color: #ffffff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        .left-section {
            flex: 0.4;
            background-color: #004b79;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 30px;
        }

        .right-section {
            flex: 0.6;
            background-color: #fbb383;
            padding: 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .right-section input {
            padding: 10px;
            margin-bottom: 15px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
            width: 100%;
            max-width: 300px;
        }

        .right-section button {
            padding: 12px;
            background-color: #004b79;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            max-width: 300px;
        }

        .right-section button:hover {
            background-color: #00324e;
        }

        .right-section a {
            font-size: 14px;
        }

        label {
            display: block;
            width: 100%;
            text-align: left;
            max-width: 300px;
        }
    </style>
</head>
<body>
    <div class="custom-container">
        <div class="custom-card">
            <!-- Left Section -->
            <div class="left-section">
                <h1 class="text-2xl font-bold">Welcome to TVPSS Management Information System</h1>
            </div>

            <!-- Right Section -->
            <div class="right-section">
                <h2 class="text-center text-2xl font-bold mb-4">SIGN UP</h2>

                <!-- Dynamic Messages -->
                <% if (request.getAttribute("error") != null) { %>
                    <script>
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: '<%= request.getAttribute("error") %>',
                            confirmButtonText: 'OK'
                        });
                    </script>
                <% } %>
                <% if (request.getAttribute("success") != null) { %>
                    <script>
                        Swal.fire({
                            icon: 'success',
                            title: 'Success',
                            text: '<%= request.getAttribute("success") %>',
                            confirmButtonText: 'OK'
                        });
                    </script>
                <% } %>

                <form action="${pageContext.request.contextPath}/home/signup" method="POST" class="space-y-4 text-center">
                    <label for="id" class="font-bold">ID:</label>
                    <input type="text" name="id" id="id" placeholder="Enter your ID" required>

                    <label for="name" class="font-bold">Name:</label>
                    <input type="text" name="name" id="name" placeholder="Enter your name" required>

                    <label for="email" class="font-bold">Email:</label>
                    <input type="email" name="email" id="email" placeholder="Enter your email" required>

                    <label for="password" class="font-bold">Password:</label>
                    <input type="password" name="password" id="password" placeholder="Enter your password" required>

                    <button type="submit">Sign Up</button>
                </form>

                <div class="mt-6 text-center">
                    <p class="text-gray-700">Already have an account?</p>
                    <a href="${pageContext.request.contextPath}/home/login" class="text-blue-700 hover:underline">Log In Here</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
