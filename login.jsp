<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
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
            width: 900px;
            height: 550px;
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

        .forgot-password {
            margin-top: 5px;
            display: block;
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
                <h2 class="text-center text-2xl font-bold mb-4">LOGIN</h2>

                <!-- Dynamic Messages -->
                <% if (request.getAttribute("error") != null) { %>
                    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-2 rounded mb-4">
                        <strong>Error:</strong> <%= request.getAttribute("error") %>
                    </div>
                <% } %>
                <% if (request.getAttribute("success") != null) { %>
                    <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-2 rounded mb-4">
                        <strong>Success:</strong> <%= request.getAttribute("success") %>
                    </div>
                <% } %>

                <form action="${pageContext.request.contextPath}/home/login" method="POST" class="space-y-4 text-center">
                    <label for="email" class="font-bold">Email:</label>
                    <input type="email" name="email" id="email" placeholder="Email address" required>

                    <label for="password" class="font-bold">Password:</label>
                    <input type="password" name="password" id="password" placeholder="Password" required>

                    <a href="${pageContext.request.contextPath}/home/forgotpassword" class="text-sm text-blue-700 hover:underline forgot-password">Forgot password?</a>

                    <button type="submit">Login</button>
                </form>

                <div class="mt-6 text-center">
                    <p class="text-gray-700">Don't have an account?</p>
                    <a href="${pageContext.request.contextPath}/home/signup" class="text-blue-700 hover:underline">Sign Up Now</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
