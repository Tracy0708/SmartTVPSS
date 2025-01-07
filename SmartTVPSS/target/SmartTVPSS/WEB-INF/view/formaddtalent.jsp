<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>SmartTVPSS</title>
    <style>
        /* General Reset */
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

        @keyframes fadeIn {
            from {
                opacity: 0;
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

        .form-container input[type="submit"] {
            background-color: #ff5252;
            color: white;
            border: none;
            cursor: pointer;
            padding: 12px 18px;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s;
        }

        .form-container input[type="submit"]:hover {
            background-color: #ff7373;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(255, 82, 82, 0.4);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
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
    		font-weight: normal !important;  /* Regular font weight */
    		padding: 5px 10px; /* Add padding for spacing */
    		border-radius: 5px; /* Optional: Rounded edges */
    		transition: background-color 0.3s, color 0.3s; /* Smooth transition */
		}

		/* Hover effect for sub-menu items */
		.sub-menu li a:hover {
    		background-color: #FBAF3C; /* Highlight color */
    		color: white;  /* Change text color when hovered */
		}

		/* When the parent item has the 'active' class, show the sub-menu */
		.active .sub-menu {
    		display: block;
		}

        
    </style>
</head>
<body>
    <div class="header">
        <div>SCHOOL RESOURCE CENTRE TV</div>
        <a href="login.jsp">Login</a>
    </div>

    <div class="container">
        <div class="sidebar">
            <h3>Student</h3>
            <ul>
            	<li><a href="studentDashboard.jsp">Dashboard</a></li>
                <li class="toggle">
                    <a href="javascript:void(0);">Talent Application</a>
                    <ul class="sub-menu">
                        <li><a href="ApplyAsCandidate.jsp">Apply as Candidate</a></li>
                        <li><a href="viewApplicationStatus.jsp">View Application Status</a></li>
                    </ul>
                </li>
                <li><a href="viewActivity.jsp">View Activity</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="form-container">
                <h2>Apply as Candidates</h2>
                <form action="add" method="post">
                    <h3>School Information</h3>
                    <label for="schoolCode">School Code:</label>
                    <input type="text" id="schoolCode" name="schoolCode" placeholder="Enter your school code" required>

                    <label for="schoolName">School Name:</label>
                    <input type="text" id="schoolName" name="schoolName" placeholder="Enter your school name" required>
                    <br><br><br>
                    <h3>Personal Information</h3>
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" placeholder="Enter your name" required>

                    <label for="gender">Gender:</label>
                    <input type="text" id="gender" name="gender" placeholder="Enter your gender" required>

                    <label for="contact">Contact No.:</label>
                    <input type="text" id="contact" name="contact" placeholder="Enter your contact number" required>

                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email" required>

                    <label for="reason">Why do you wish to join as part of TVPSS crew?:</label>
                    <textarea id="reason" name="reason" placeholder="Write your reason" rows="4" required></textarea>

                    <button type="submit">Submit</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        // JavaScript for toggling the Talent Application submenu
        document.querySelector('.toggle > a').addEventListener('click', function() {
            const parentLi = this.parentNode;
            parentLi.classList.toggle('active');
        });
    </script>
</body>
</html>
