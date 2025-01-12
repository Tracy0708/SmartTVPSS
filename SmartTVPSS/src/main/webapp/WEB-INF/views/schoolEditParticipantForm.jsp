<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Activity</title>

    <style>
        * {
            margin: 0;
            padding: 0;
        }

        body {
            min-height: 100vh;
        }

        nav {
            background-color: #0C3182;
            box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.1);
            padding-right: 2rem;
        }

        nav ul {
            width: 100%;
            list-style: none;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        nav li {
            height: 70px;
        }

        nav a {
            height: 100%;
            padding: 0 30px;
            text-decoration: none;
            display: flex;
            align-items: center;
            color: white;
        }

        nav a:hover {
            background-color: #f0f0f0;
        }

        nav li:first-child {
            margin-right: auto;
        }

        .sidebar {
            width: 15vw;
            background-color: #f4f4f4;
            border-right: 1px solid #ddd;
            padding: 20px;
        }

        .container {
            display: flex;
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
        .form-container select,
        .form-container textarea {
            width: 100%;
            margin-top: 5px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding-left: 10px;
            
        }

        .form-container input[type="number"] {
            width: auto;
            padding-left: 10px;
        }

        .form-container input[type="text"],
        .form-container input[type="tel"],
        .form-container input[type="date"],
        .form-container input[type="number"],
        .form-container input[type="email"],
        .form-container select {
            height: 35px;
        }

        .form-container .submit-button {
            background-color: #f57c00;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 20px;
            display: block;
            width: 100%;
        }

        .row {
            display: flex;
            gap: 15px;
        }

        .column{
            width: 50%;
        }
        
        label{
        	margin-bottom:10px;
        }
        
        .gender-input input{
        	width: 15px;
    		margin-top: 0;
    		margin-right:15px;
        }
        
        span{
            color:red;
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
    <%@ include file="schooladminnavbar.jsp"%>

        <div class="content">
            <div class="form-container">
                <div class="form-header" style="display: flex;">
                    <a href='${pageContext.request.contextPath}/admin/activity/viewParticipant?id=${participant.activityId}'><svg xmlns="http://www.w3.org/2000/svg" height="26px"
                            viewBox="0 -960 960 960" width="26px" fill="black">
                            <path d="m313-440 224 224-57 56-320-320 320-320 57 56-224 224h487v80H313Z" />
                        </svg></a>
                    <h2 style="padding-left: 20px;">Edit Participant</h2>
                </div>

                <form action="${pageContext.request.contextPath}/admin/activity/save" method="post">
                	<input type="hidden" name="activityId" value="${participant.activityId}" />
                	<input type="hidden" name="participant_id" value="${participant.participant_id}">
                	
                    <label><span>*</span>Participant Name:</label>
                    <input type="text" id="name" name="name" value="${participant.name}" required>
                    
                    <label><span>*</span>Student ID:</label>
                    <input type="text" id="studentID" name="studentID" value="${participant.studentID}" required>

                    <label><span>*</span>Gender:</label>
                    <div class="gender-input" style="display:flex;">
                    	<input type="radio" name="gender" value="male" ${participant.gender == 'Male' ? 'checked' : ''}> Male
						<input type="radio" name="gender" value="female" style="margin-left:20px" ${participant.gender == 'Female' ? 'checked' : ''}> Female
                    </div>
					
					<label><span>*</span>Age:</label>
                    <input type="number" id="age" name="age" min="0" value="${participant.age}" required>

                    <label><span>*</span>School:</label>
                    <input type="text" id="school" name="school" value="${participant.school}" required>
                    
                    <label><span>*</span>Email: </label>
                    <input type="email" id="email" name="email" value="${participant.email}" required>

                    <label><span>*</span>Phone:</label>
                    <input type="tel" id="phone" name="phone" value="${participant.phone}" required>

                    <label><span>*</span>Address:</label>
                    <input type="text" id="address" name="address" value="${participant.address}" required>

                    <button type="submit" class="submit-button">SUBMIT</button>
                </form>
            </div>

        </div>
</body>

</html>