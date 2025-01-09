<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>SmartTVPSS</title>
<style>
/* Main Content Section */
.main-content {
	flex: 1;
	padding: 40px;
}

.form-container {
	background-color: #ffcc80;
	border-radius: 12px;
	padding: 30px;
	max-width: 1000px;
	margin: auto;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
	animation: fadeIn 0.8s ease-in-out;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.form-container h2 {
	text-align: center;
	color: #003d73;
	margin-bottom: 20px;
	font-size: 2.0rem;
}

.form-container h3 {
	color: #003d73;
	font-size: 1.5rem;
}

.form-container label {
	display: block;
	font-weight: bold;
	margin: 10px 0 5px;
	color: #333;
}

.form-container input, .form-container textarea {
	width: 100%;
	padding: 12px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 8px;
	font-size: 1rem;
	transition: all 0.3s;
}

.form-container input:focus, .form-container textarea:focus {
	border-color: #003d73;
	box-shadow: 0 0 8px rgba(0, 61, 115, 0.3);
}

.form-container select {
	width: 100%;
	padding: 12px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 8px;
	font-size: 1rem;
	transition: all 0.3s;
	background-color: white; /* Match input field background */
	color: #333; /* Match input field text color */
}

.form-container select:focus {
	border-color: #003d73; /* Same border focus color as inputs */
	box-shadow: 0 0 8px rgba(0, 61, 115, 0.3);
	/* Match input focus style */
	outline: none; /* Remove default outline */
}

.form-container button[type="submit"] {
	display: block;
	margin: 0 auto; /* Centers the button horizontally */
	background-color: #ff5252;
	color: white;
	border: none;
	cursor: pointer;
	padding: 12px 18px;
	border-radius: 8px;
	font-size: 1rem;
	transition: all 0.3s;
}

.form-container button[type="submit"]:hover {
	background-color: #ff7373;
	transform: translateY(-2px);
	box-shadow: 0 4px 10px rgba(255, 82, 82, 0.4);
}

/* Responsive Design */
@media ( max-width : 768px) {
	.container {
		flex-direction: column;
	}
	.sidebar {
		width: 100%;
		text-align: center;
	}
	.main-content {
		padding: 20px;
	}
	.form-container {
		padding: 20px;
	}
}

/* Sub-menu Style */
.sub-menu {
	display: none;
	list-style-type: none;
	padding-left: 20px;
}

.sub-menu li a {
	text-decoration: none;
	font-weight: normal !important; /* Regular font weight */
	padding: 5px 10px; /* Add padding for spacing */
	border-radius: 5px; /* Optional: Rounded edges */
	transition: background-color 0.3s, color 0.3s; /* Smooth transition */
}

/* Hover effect for sub-menu items */
.sub-menu li a:hover {
	background-color: #FBAF3C; /* Highlight color */
	color: white; /* Change text color when hovered */
}

/* When the parent item has the 'active' class, show the sub-menu */
.active .sub-menu {
	display: block;
}
</style>
</head>
<body>
	<%@ include file="studentnavbar.jsp"%>

	<div class="main-content">
		<div class="form-container">
			<h2>Apply as Candidates</h2>
			<form action="add" method="post">
				<h3>School Information</h3>
				<label for="schoolCode">School Code:</label> <input type="text"
					id="schoolCode" name="schoolCode"
					placeholder="Enter your school code" required> <label
					for="schoolName">School Name:</label> <input type="text"
					id="schoolName" name="schoolName"
					placeholder="Enter your school name" required> <br> <br>
				<br>
				<h3>Personal Information</h3>
				<label for="name">Name:</label> <input type="text" id="name"
					name="name" placeholder="Enter your name" required> <label
					for="gender">Gender:</label> <select id="gender" name="gender"
					required>
					<option value="">Select</option>
					<option value="Male">Male</option>
					<option value="Female">Female</option>
				</select> <label for="contact">Contact No.:</label> <input type="text"
					id="contact" name="contact" placeholder="Enter your contact number"
					pattern="[0-9]{10,15}"
					title="Enter a numeric contact number (10 to 15 digits)" required>

				<label for="email">Email:</label> <input type="email" id="email"
					name="email" placeholder="Enter your email" required> <label
					for="reason">Why do you wish to join as part of TVPSS
					crew?:</label>
				<textarea id="reason" name="reason" placeholder="Write your reason"
					rows="4" required></textarea>

				<button type="submit">Submit</button>
			</form>
		</div>
	</div>
	</div>
</body>
</html>
