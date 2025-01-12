<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Check Application Status</title>
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
	font-size: 2rem;
}

.form-container label {
	display: block;
	font-weight: bold;
	margin: 10px 0 5px;
	color: #333;
}

.form-container input {
	width: 100%;
	padding: 12px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 8px;
	font-size: 1rem;
	transition: all 0.3s;
}

.form-container input:focus {
	border-color: #003d73;
	box-shadow: 0 0 8px rgba(0, 61, 115, 0.3);
}

.form-container button {
	display: block;
	margin: 0 auto;
	background-color: #ff5252;
	color: white;
	border: none;
	cursor: pointer;
	padding: 12px 18px;
	border-radius: 8px;
	font-size: 1rem;
	transition: all 0.3s;
}

.form-container button:hover {
	background-color: #ff7373;
	transform: translateY(-2px);
	box-shadow: 0 4px 10px rgba(255, 82, 82, 0.4);
}

/* Results Section Styling */
.results-container {
	background-color: #fff;
	border-radius: 12px;
	padding: 20px;
	margin: 20px auto;
	max-width: 1000px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
}

.results-container h3 {
	color: #003d73;
	margin-bottom: 20px;
}

.results-container p {
	margin: 8px 0;
	color: #333;
	padding: 5px;
}

.alert {
	font-size: 1rem;
	border-radius: 8px;
	color: red;
	margin-top: 100px;
}
</style>
</head>
<body>
	<%@ include file="studentnavbar.jsp"%>

	<div class="main-content">
		<div class="form-container">
			<h2>Check Your Application Status</h2>
			<form action="${pageContext.request.contextPath}/talent/viewStatus"
				method="post">
				<label for="email">Enter your email address:</label>
				<div class="input-group">
					<input type="email" id="email" name="email" required
						placeholder="example@email.com">
					<button type="submit">Check Status</button>
				</div>
			</form>

			<!-- Error Message -->
			<c:if test="${not empty error}">
				<div class="alert alert-warning" role="alert">${error}</div>
			</c:if>
		</div>

		<!-- Results Section -->
		<c:if test="${not empty talent && searched}">
			<div class="results-container">
				<!-- Edit Button -->
				<div style="text-align: right; margin-bottom: 20px;">

					<form action="${pageContext.request.contextPath}/talent/edit"
						method="get" class="d-inline"></form>
						<input type="hidden" name="email" value="${talent.email}">
						<button type="submit"
							style="background-color: #003d73; border: none; color: white; padding: 6px 12px; font-size: 12px; font-weight: bold; border-radius: 8px; cursor: pointer; transition: all 0.3s;">
							Edit Application</button>
					</form>
				</div>

					<h3>Application Details</h3>
					<p>
						<strong>School Code:</strong> ${talent.schoolCode}
					</p>
					<p>
						<strong>Name:</strong> ${talent.name}
					</p>
					<p>
						<strong>Email:</strong> ${talent.email}
					</p>
					<p>
						<strong>Application Status:</strong>
					</p>
					<div
						style="padding: 10px; border-radius: 10px; text-align: center; 
        font-size: 1.2rem; font-weight: bold; color: white; 
        background-color: ${talent.applicationStatus eq 'SCHEDULED' ? '#28a745' : 
                           talent.applicationStatus eq 'PENDING' ? '#ffc107' : '#007bff'};">
						${talent.applicationStatus}</div>
					<c:if test="${talent.applicationStatus eq 'SCHEDULED'}">
						<div class="alert alert-info mt-3">
							<h3>Interview Details</h3>
							<p>
								<strong>Date:</strong>
								<fmt:formatDate value="${talent.interviewDate}"
									pattern="dd-MM-yyyy" />
							</p>
							<p>
								<strong>Time:</strong> ${talent.interviewTime}
							</p>
						</div>
					</c:if>
				</div>
		</c:if>

	</div>
</body>
</html>
