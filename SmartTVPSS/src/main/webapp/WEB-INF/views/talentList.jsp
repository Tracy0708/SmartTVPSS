<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<html>
<head>
<title>View Application Status</title>
<style>
/* Main Content Section */
.main-content {
	flex: 1;
	padding: 40px;
}

.table-container {
	background-color: #fff;
	border-radius: 12px;
	padding: 30px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
}

.table-container h2 {
	text-align: center;
	color: #003d73;
	margin-bottom: 20px;
	font-size: 1.8rem;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

table th, table td {
	padding: 12px;
	border: 1px solid #ccc;
	text-align: center;
}

table th {
	background-color: #003d73;
	color: #fff;
	font-weight: bold;
}

table tr:nth-child(even) {
	background-color: #f9f9f9;
}

table tr:hover {
	background-color: #f1f1f1;
}

.status-qualified {
	color: green;
	font-weight: bold;
}

.status-disqualified {
	color: red;
	font-weight: bold;
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
	<%@ include file="studentnavbar.jsp" %>

		<div class="main-content">
			<div class="table-container">
				<h2>Application Status</h2>
				<table>
					<thead>
						<tr>
							<th>ID</th>
							<th>School Code</th>
							<th>School Name</th>
							<th>Student Name</th>
							<th>Gender</th>
							<th>Contact Number</th>
							<th>Email</th>
							<th>Reason</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="talent" items="${talentList}">
							<tr>
								<td>${talent.id}</td>
								<td>${talent.schoolCode}</td>
								<td>${talent.schoolName}</td>
								<td>${talent.name}</td>
								<td>${talent.gender}</td>
								<td>${talent.contact}</td>
								<td>${talent.email}</td>
								<td>${talent.reason}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<script>
		// JavaScript for toggling the Talent Application submenu
		document.querySelector('.toggle > a').addEventListener('click',
				function() {
					const parentLi = this.parentNode;
					parentLi.classList.toggle('active');
				});
	</script>
</body>
</html>
