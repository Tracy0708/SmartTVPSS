<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Forgot Password</title>
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
	width: 400px;
	background-color: #ffffff;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
	padding: 30px;
}

input {
	padding: 10px;
	margin-bottom: 15px;
	font-size: 16px;
	border: 1px solid #ddd;
	border-radius: 5px;
	width: 100%;
}

button {
	padding: 12px;
	background-color: #004b79;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	width: 100%;
}

button:hover {
	background-color: #00324e;
}
</style>
</head>
<body>
	<div class="custom-container">
		<div class="custom-card">
			<h2 class="text-center text-2xl font-bold mb-4">Forgot Password</h2>

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

			<!-- Email Verification Form -->
			<form action="${pageContext.request.contextPath}/home/forgotpassword"
				method="POST">
				<label for="email" class="block font-bold mb-2">Enter your
					email:</label> <input type="email" id="email" name="email"
					placeholder="Email address" required>
				<button type="submit">Verify Email</button>
			</form>

			<!-- Reset Password Form -->
			<% if (request.getAttribute("verifiedEmail") != null) { %>
			<form action="${pageContext.request.contextPath}/home/resetpassword"
				method="POST" class="mt-4">
				<input type="hidden" name="email"
					value="<%= request.getAttribute("verifiedEmail") %>"> <label
					for="newPassword" class="block font-bold mb-2">Enter your
					new password:</label> <input type="password" id="newPassword"
					name="newPassword" placeholder="New password" required> <label
					for="confirmPassword" class="block font-bold mb-2">Confirm
					your new password:</label> <input type="password" id="confirmPassword"
					name="confirmPassword" placeholder="Confirm password" required>

				<button type="submit">Reset Password</button>
			</form>

			<% } %>

			<div class="mt-4 text-center">
				<a href="${pageContext.request.contextPath}/home/login"
					class="text-blue-700 hover:underline">Back to Login</a>
			</div>
		</div>
	</div>
</body>
</html>
