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

/* Modal styles */
.modal {
	background-color: rgba(0, 0, 0, 0.5);
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: none;
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
</style>
<script>
	function showModal() {
		document.getElementById('modal').style.display = 'flex';
	}

	function closeModal() {
		document.getElementById('modal').style.display = 'none';
		window.location.href = "viewStatus"; // Redirect to the status page
	}

	// Function to handle form submission via AJAX
	function submitForm(event) {
		event.preventDefault(); // Prevent the default form submission
		var formData = new FormData(event.target); // Get form data

		var xhr = new XMLHttpRequest();
		xhr.open("POST", "add", true); // Make sure "add" is your form action URL
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				// If submission is successful, show the modal
				showModal();
			}
		};
		xhr.send(formData); // Send form data to the server
	}
</script>
</head>
<body>
	<%@ include file="studentnavbar.jsp"%>

	<div class="main-content">
    <div class="form-container">
        <h2>Edit Application</h2>
        <form action="${pageContext.request.contextPath}/talent/save" method="post">
            <h3>School Information</h3>
            <label for="schoolCode">School Code:</label>
            <input type="text" id="schoolCode" name="schoolCode" value="${talent.schoolCode}" required>
            
            <label for="schoolName">School Name:</label>
            <input type="text" id="schoolName" name="schoolName" value="${talent.schoolName}" required>
            
            <br><br><br>
            
            <h3>Personal Information</h3>
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" value="${talent.name}" required>
            
            <label for="gender">Gender:</label>
            <select id="gender" name="gender" required>
                <option value="">Select</option>
                <option value="Male" <c:if test="${talent.gender == 'Male'}">selected</c:if>>Male</option>
                <option value="Female" <c:if test="${talent.gender == 'Female'}">selected</c:if>>Female</option>
            </select>
            
            <label for="contact">Contact No.:</label>
            <input type="text" id="contact" name="contact" value="${talent.contact}" pattern="[0-9]{10,15}" required>
            
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="${talent.email}" readonly>
            
            <label for="reason">Why do you wish to join as part of TVPSS crew?:</label>
            <textarea id="reason" name="reason" rows="4" required>${talent.reason}</textarea>
            
            <button type="submit">Save Changes</button>
        </form>
    </div>
</div>

	<!-- Modal -->
	<div id="modal" class="modal">
		<div class="modal-content">
			<h2>SUCCESSFULLY</h2>
			<p>The information has been successfully edited.</p>
			<button class="close-button" onclick="closeModal()">Close</button>
		</div>
	</div>
</body>
</html>
