<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
<style>
	* {
		margin: 0;
		padding: 0;
		box-sizing: border-box;
	}
	
	body {
		font-family: times new roman;
		background-color: #f0f2f5;
		color: #333;
	}
	
	/* Header Section */
	.header {
		background-color: #002855;
		color: #ffdd57;
		font-weight: bold;
		padding: 15px 30px;
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	
	.header a {
		color: #fff;
		text-decoration: none;
		font-weight: bold;
		transition: color 0.3s;
	}
	
	.header a:hover {
		color: #ffd700;
	}
	
	/* Sidebar Section */
	.container {
		display: flex;
	}
	
	.sidebar {
		width: 260px;
		color: black;
		height: auto;
		padding: 20px;
		padding-top: 100px;
	}
	
	.sidebar h3 {
		margin-bottom: 20px;
		font-size: 1.2rem;
		text-align: center;
		border-bottom: 1px solid #ccc;
		padding-bottom: 10px;
	}
	
	.sidebar ul {
		list-style: none;
	}
	
	.sidebar ul li {
		margin: 15px 0;
		text-align: center;
	}
	
	.sidebar ul li a {
		text-decoration: none;
		color: black;
		font-weight: bold;
		font-size: 1rem;
		padding: 5px 10px; /* Add padding to create space for the highlight */
		border-radius: 5px; /* Optional: make the highlight edges rounded */
		transition: background-color 0.3s, color 0.3s; /* Smooth transition */
	}
	
	.sidebar ul li a:hover {
		background-color: #FBAF3C; /* Highlight color */
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
</style>
<body>
	<div class="header">
		<div>SCHOOL RESOURCE CENTRE TV</div>
		<a href="/SmartTVPSS/home/login">Logout</a>
	</div>

	<div class="container">
		<div class="sidebar">
			<h3>TVPSS</h3>
			<ul>
				<li><a href="/SmartTVPSS/home/TVPSS/dashboard">Dashboard</a></li>
				<li class="toggle"><a href="javascript:void(0);">Activity</a>
					<ul class="sub-menu">
						<li><a href="/SmartTVPSS/TVPSS/activity/activityList">Manage activity</a></li>
						<li><a href="/SmartTVPSS/TVPSS/activity/participant">View Participant</a></li>
					</ul></li>
				<li><a href="viewActivity.jsp">Program Status</a></li>
				<li><a href="/SmartTVPSS/TVPSS/user/userList">User List</a></li>
			</ul>
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