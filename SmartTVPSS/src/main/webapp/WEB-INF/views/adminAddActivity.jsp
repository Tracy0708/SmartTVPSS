<!DOCTYPE html>
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

        .sidebar {
            width: 15vw;
            background-color: #f4f4f4;
            border-right: 1px solid #ddd;
            padding: 20px;
        }

        .container {
            display: flex;
            height:100vh;
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
		    font-weight: normal;
		    padding: 5px 10px;
		    border-radius: 5px;
		    transition: background-color 0.3s, color 0.3s;
		}
		
		.sub-menu li a:hover {
		    background-color: #FBAF3C;
		    color: white;
		}
		
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
                    <h2 style="padding-left: 20px;">New Activity</h2>
                </div>

                <form action="add" method="post">
                    <label for="activityName"><span>*</span>Activity Name:</label>
                    <input type="text" id="activityName" name="activityName" required>

                    <label for="organizer"><span>*</span>Organizer:</label>
                    <input type="text" id="organizer" name="organizer" placeholder="TVPSS" required>

                    <div class="row">
                        <div class="column">
                            <label for="startDate"><span>*</span>Start Date:</label>
                            <input type="date" id="startDate" name="startDate" required>
                        </div>
                        <div class="column">
                            <label for="endDate"><span>*</span>End Date:</label>
                            <input type="date" id="endDate" name="endDate" required>
                        </div>
                    </div>

                    <label for="pic"><span>*</span>PIC:</label>
                    <input type="text" id="pic" name="pic" placeholder="Tan Yi Yi" required>

                    <label for="phone"><span>*</span>Phone:</label>
                    <input type="tel" id="phone" name="phone" placeholder="01212345678" required>

                    <label><span>*</span>Location: </label>
                    <input type="text" id="location" name="location" placeholder="SMK a, Johor" required>

                    <label for="description"><span>*</span>Description:</label>
                    <textarea id="description" name="description" rows="4" style="padding-top:10px;" placeholder="Please describe the activity.." required></textarea>

                    <label for="activityType"><span>*</span>Activity Type:</label>
                    <select id="activityType" name="activityType" required>
                        <option value="" disabled selected>Select a type</option>
                        <option value="Award">Award</option>
                        <option value="Competition">Competition</option>
                        <option value="Talk">Talk</option>
                    </select>

                    <label for="activityLevel"><span>*</span>Activity Level:</label>
                    <select id="activityLevel" name="activityLevel" required>
                        <option value="" disabled selected>Select level</option>
                        <option value="School">School</option>
                        <option value="State">State</option>
                        <option value="District">District</option>
                    </select>

                    <label for="limitation"><span>*</span>Limitations:</label>
                    <input type="number" id="limitation" name="limitation" min="0" value="0">

                    <button type="submit" class="submit-button">SUBMIT</button>
                </form>
            </div>

        </div>
    </div>
</body>

