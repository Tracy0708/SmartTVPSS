<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add User</title>

<style>
* {
	margin: 0;
	padding: 0;
}

body {
	min-height: 100vh;
}

.sidebar {
	width: 15vw;
	background-color: #f4f4f4;
	border-right: 1px solid #ddd;
	padding: 20px;
}

.container {
	display: flex;
	height: 100vh;
}

.sidebar ul {
	list-style: none;
	padding: 0;
}

.sidebar ul li {
	margin-bottom: 15px;
}

.sidebar ul li a {
	text-decoration: none;
	color: #333;
	font-size: 16px;
}

.content {
	padding: 20px;
	width: 50vw;
	margin: auto;
}

.form-container {
	background-color: #f5c687;
	padding: 20px;
	border-radius: 10px;
	margin: 0 auto;
	box-sizing: border-box;
}

.form-container label {
	display: block;
	font-weight: bold;
	margin-top: 10px;
}

.form-container input, 
.form-container select {
    width: 100%;
    margin-top: 5px;
    font-size: 14px; /* Ensures consistent font size */
    border: 1px solid #ddd;
    border-radius: 5px;
    padding: 8px 10px; /* Consistent padding */
    height: 35px; /* Uniform height */
    box-sizing: border-box;
}


.form-container input[type="text"], .form-container input[type="email"],
	.form-container select {
	height: 35px;
}

.form-container .submit-button {
	background-color: #FF0000; /* Red background */
	color: white; /* White text */
	border: none;
	padding: 10px 20px;
	font-size: 16px;
	cursor: pointer;
	border-radius: 5px;
	margin-top: 20px;
	display: block;
	width: 50%;
	margin-left: auto; /* Center the button */
	margin-right: auto; /* Center the button */
}

span {
	color: red;
}
</style>
</head>

<body>
	<%@ include file="adminnavbar.jsp"%>

	<div class="content">
		<div class="form-container">
			<div class="form-header" style="display: flex;">
				<a href="${pageContext.request.contextPath}/TVPSS/user/userList"><svg
						xmlns="http://www.w3.org/2000/svg" height="26px"
						viewBox="0 -960 960 960" width="26px" fill="black">
                        <path
							d="m313-440 224 224-57 56-320-320 320-320 57 56-224 224h487v80H313Z" />
                    </svg></a>
				<h2 style="padding-left: 20px;">New User</h2>
			</div>

			<form action="${pageContext.request.contextPath}/TVPSS/user/add" method="post">
    <label for="id"><span>*</span>ID:</label>
    <input type="text" id="id" name="id" placeholder="Enter ID" required>
    
    <label for="name"><span>*</span>Name:</label>
    <input type="text" id="name" name="name" placeholder="Enter user name" required>
    
    <label for="email"><span>*</span>Email:</label>
    <input type="email" id="email" name="email" placeholder="Enter user email" required>
    
    <label for="role"><span>*</span>Role:</label>
    <select id="role" name="role" required>
        <option value="" disabled selected>Select role</option>
        <option value="Student">Student</option>
        <option value="School Administrator">School Administrator</option>
        <option value="TVPSS Management">TVPSS Management</option>
    </select>

    <label for="password"><span>*</span>Password:</label>
    <input type="password" id="password" name="password" placeholder="Enter user password" required>
    
    <button type="submit" class="submit-button">SUBMIT</button>
</form>


		</div>
	</div>
</body>

</html>