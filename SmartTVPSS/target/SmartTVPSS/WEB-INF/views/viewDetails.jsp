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

        .container {
            display: flex;
        }
        
        .sidebar {
            width: 15vw;
            background-color: #f4f4f4;
            border-right: 1px solid #ddd;
            padding: 20px;
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
            width: 60vw;
            margin: auto;
        }

        .detail-container {
            background-color: #f5c687;
            padding: 30px;
            border-radius: 10px;
            margin: 0 auto;
            box-sizing: border-box;
        }
        
        .detail-header{
        	padding-bottom: 20px;
        	display:flex;
        }
        
        .details-grid {
            display: flex;
            flex-direction:column;
            gap: 15px;
        }

        .label {
            font-weight: bold;
            min-width: 160px;
        }

        .colon {
            margin-right: 8px;
        }

        .description {
            margin-top: 5px;
            line-height: 1.5;
        }

        .edit-button {
            background-color: #eb6b6b;
            color: white;
            padding: 12px 60px;
            border-radius: 25px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            display: block;
            width: fit-content;
            margin: 30px auto 0;
            transition: background-color 0.3s;
            text-align: center;
        }

        .edit-button:hover {
            background-color: #d55959;
        }
        
        .information{
        	display: flex;
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
            <div class="detail-container">
                <div class="detail-header">
                    <a href="${pageContext.request.contextPath}/activity/activityList"><svg xmlns="http://www.w3.org/2000/svg" height="26px"
                            viewBox="0 -960 960 960" width="26px" fill="black">
                            <path d="m313-440 224 224-57 56-320-320 320-320 57 56-224 224h487v80H313Z" />
                        </svg></a>
                    <h2 style="padding-left: 20px;">Activity Details</h2>
                </div>
                
                <div class="details-grid">
	                <div class="information">
	                	<div class="label">Activity</div>
			            <div><span class="colon">:</span></div>
			            <div>${activity.activityName}</div>
	                </div>
		            
		            <div class="information">
	                	<div class="label">Organizer</div>
			            <div><span class="colon">:</span></div>
			            <div>${activity.organizer}</div>
	                </div>
	                		
		           	<div class="information">
	                	<div class="label">Date</div>
			            <div><span class="colon">:</span></div>
			            <div>${startDateFormatted} to ${endDateFormatted}</div>
	                </div>
		
		            <div class="information">
	                	<div class="label">Person in Charge</div>
			            <div><span class="colon">:</span></div>
			            <div>${activity.pic}</div>
	                </div>
	                
	                <div class="information">
	                	<div class="label">Phone</div>
			            <div><span class="colon">:</span></div>
			            <div>${activity.phone}</div>
	                </div>
	                
	                <div class="information">
	                	<div class="label">Location</div>
			            <div><span class="colon">:</span></div>
			            <div>${activity.location}</div>
	                </div>
	                
	                <div class="information">
	                	<div class="label">Description</div>
			            <div><span class="colon">:</span></div>
			            <div>${activity.description}</div>
	                </div>
	                
	                <div class="information">
	                	<div class="label">Activity Type</div>
			            <div><span class="colon">:</span></div>
			            <div>${activity.activityType}</div>
	                </div>
	                
	                <div class="information">
	                	<div class="label">Activity Level</div>
			            <div><span class="colon">:</span></div>
			            <div>${activity.activityLevel}</div>
	                </div>
	                
					<div class="information">
				        <div class="label">Limited of Participant</div>
						<div><span class="colon">:</span></div>
						<div>${activity.limitation}</div>
				    </div>
		        </div>
		
		        <a href='${pageContext.request.contextPath}/activity/edit?id=${activity.activityId}' class='edit-button'>Edit</a>
        </div>
    </div>
</body>