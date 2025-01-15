<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Activity</title>

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
    <%@ include file="adminnavbar.jsp"%>

        <div class="content">
            <div class="form-container">
                <div class="form-header" style="display: flex;">
                    <a href="${pageContext.request.contextPath}/TVPSS/activity/activityList"><svg xmlns="http://www.w3.org/2000/svg" height="26px"
                            viewBox="0 -960 960 960" width="26px" fill="black">
                            <path d="m313-440 224 224-57 56-320-320 320-320 57 56-224 224h487v80H313Z" />
                        </svg></a>
                    <h2 style="padding-left: 20px;">Edit Activity</h2>
                </div>

                <form action="${pageContext.request.contextPath}/TVPSS/activity/save" method="post">
                	<input type="hidden" id="id" name="id" value="${activity.id}">
                	
                    <label for="activityName">Activity Name:</label>
                    <input type="text" id="activityName" name="activityName" value="${activity.activityName}" required>

                    <label for="organizer">Organizer:</label>
                    <input type="text" id="organizer" name="organizer" value="${activity.organizer}" required>

                    <div class="row">
                        <div class="column">
                            <label for="startDate">Start Date:</label>
                            <input type="date" id="startDate" name="startDate" value="${startDateFormatted}" required>
                        </div>
                        <div class="column">
                            <label for="endDate">End Date:</label>
							<input type="date" id="endDate" name="endDate" value="${endDateFormatted}" required>
                        </div>
                    </div>

                    <label for="pic">PIC:</label>
                    <input type="text" id="pic" name="pic" value="${activity.pic}" required>

                    <label for="phone">Phone:</label>
                    <input type="tel" id="phone" name="phone" value="${activity.phone}" required>

                    <label>Location: </label>
                    <input type="text" id="location" name="location" value="${activity.location}" required>

                    <label for="description">Description:</label>
                    <textarea id="description" name="description" rows="4" style="padding-top:10px;" >${activity.description}</textarea>

                    <label for="activityType">Activity Type:</label>
                    <select id="activityType" name="activityType" required>
                        <option value="" disabled>Select a type</option>
                        <option value="award" ${activity.activityType == 'Award' ? 'selected' : ''}>Award</option>
                        <option value="competition" ${activity.activityType == 'Competition' ? 'selected' : ''}>Competition</option>
                        <option value="talk" ${activity.activityType == 'Talk' ? 'selected' : ''}>Talk</option>
                    </select>

                    <label for="activityLevel">Activity Level:</label>
                    <select id="activityLevel" name="activityLevel" required>
                        <option value="" disabled>Select level</option>
                        <option value="school" ${activity.activityLevel == 'School' ? 'selected' : ''}>School</option>
                        <option value="state" ${activity.activityLevel == 'State' ? 'selected' : ''}>State</option>
                        <option value="district" ${activity.activityLevel == 'District' ? 'selected' : ''}>District</option>
                    </select>

                    <label for="limitation">Limitations:</label>
                    <input type="number" id="limitation" name="limitation" min="0" value="${activity.limitation}" required>

                    <button type="submit" class="submit-button">SUBMIT</button>
                </form>
            </div>

        </div>
    </div>
</body>
