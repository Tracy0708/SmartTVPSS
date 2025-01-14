<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>


<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Activity Management</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
            height: 100vh;
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
            flex-grow: 1;
            padding: 20px;
        }

        .content h2 {
            margin-bottom: 20px;
        }

        .content .search-filter {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
            width: 85vw;
        }

        .search-filter input,
        .search-filter select,
        .search-filter button {
            padding: 8px;
            font-size: 14px;

        }

        .add-button {
            background-color: #f57c00;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 14px;
            cursor: pointer;
            border-radius: 5px;
        }

        .filter-button {
            background-color: #008080;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 14px;
            cursor: pointer;
            border-radius: 5px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table th,
        table td {
            text-align: left;
            padding: 10px;
            border: 1px solid #ddd;
        }

        table th {
            background-color: #f4f4f4;
        }

        .action-buttons button {
            background-color: #0066cc;
            color: white;
            border: none;
            padding: 5px 10px;
            font-size: 12px;
            cursor: pointer;
            border-radius: 3px;
            margin-right: 5px;
        }

        .action-buttons button.delete {
            background-color: #ff4d4d;
        }

        .addUser {
            margin-bottom: 10px;
            display: flex;
            justify-content: flex-end;
        }

        .add-button a {
            width: 15%;
            text-decoration: none;
            color: white;
        }

        .table {
            background-color: grey;
        }

        .table-container {
            background-color: #f0f0f0;
            /* Light grey background */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        thead th {
            background-color: #e0e0e0;
            /* Slightly darker grey for header */
            padding: 10px;
            font-weight: bold;
            border-bottom: 2px solid #ccc;
            color: #0C3182;
        }

        tbody td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        tbody tr:nth-child(even) {
            background-color: #fafafa;
            /* Alternate row colors */
        }
        
        /* Button */
        .btn {
		    display: inline-block;
		    text-decoration:none;
		    font-weight: 400;
		    text-align: center;
		    white-space: nowrap;
		    vertical-align: middle;
		    -webkit-user-select: none;
		    -moz-user-select: none;
		    -ms-user-select: none;
		    user-select: none;
		    border: 1px solid transparent;
		    padding: .375rem .75rem;
		    font-size: 1rem;
		    line-height: 1.5;
		    border-radius: .25rem;
		    transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
		}
		
		.btn-group-sm>.btn, .btn-sm{
		    padding: .25rem .5rem;
		    font-size: .875rem;
		    line-height: 1.5;
		    border-radius: .2rem;
		 }
		 
		 .btn:not(:disabled):not(.disabled){
		     cursor: pointer;
		 }
		 
		 .btn-primary {
		    color: #fff;
		    background-color: #FBAF3C;
		    border-color: #FBAF3C;
		 }
		 
		 .btn-success {
		    color: #fff;
		    background-color: #28a745;
		    border-color: #28a745;
		 }
		 
		 .btn-danger {
		    color: #fff;
		    background-color: #dc3545;
		    border-color: #dc3545;
		}
        
        /* Pagination style */
        .pagination{
        	display:flex;
        	margin-bottom:5px;
        }
        
        .pagination a{
	        display:flex;
	        flex-direction:column;
	        text-decoration:none;
		    border-radius: 5px;
		    padding: 5px;
		    margin: 2px;
		    background-color:#e0e0e0;
		    color: #0C3182;
        }
        
        .modal {
		    position: fixed;
		    z-index: 1;
		    left: 0;
		    top: 0;
		    width: 100%;
		    height: 100%;
		    overflow: auto;
		    background-color: rgba(0, 0, 0, 0.5);
		}
		
		.modal-content {
		    background-color: #f5c687;
		    margin: 10% auto;
		    padding: 30px;
		    border: 1px solid #888;
		    width: 50%;
		    border-radius: 10px;
		}
        
        .modal-content h2{
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
        
        .modal-content .information{
        	display:flex;
        	margin-bottom:10px;
        }
		
		.close-btn {
		    color: #aaa;
		    float: right;
		    font-size: 28px;
		    font-weight: bold;
		    cursor: pointer;
		}
		
		.close-btn:hover,
		.close-btn:focus {
		    color: black;
		    text-decoration: none;
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
	    <h2>Activity List</h2>
	    
	    <form method="GET" action="activityList">
		    <div class="search-filter">
		        <input style="width: 50%;" type="text" name="search" placeholder="Search" value="${search}">
		        
		        <select style="width: 17%;" name="type">
			        <option value="" disabled selected>Type</option>
			        <option value="competition" ${type == 'competition' ? 'selected' : ''}>Competition</option>
			        <option value="award" ${type == 'award' ? 'selected' : ''}>Award</option>
			        <option value="talk" ${type == 'talk' ? 'selected' : ''}>Talk</option>
			    </select>
		        
		        <select style="width: 17%;" name="level">
			        <option value="" disabled selected>Level</option>
			        <option value="state" ${level == 'state' ? 'selected' : ''}>State</option>
			        <option value="school" ${level == 'school' ? 'selected' : ''}>School</option>
			        <option value="district" ${level == 'school' ? 'selected' : ''}>District</option>
			    </select>
			    
		        <button type="submit" class="filter-button" style="width: 16%;">Filter</button>
		    </div>
		</form>
	    
	    <div class="table-container">
	        <table>
	        
	        <!-- Pagination Controls -->
			<div class="pagination">
			    <c:if test="${currentPage > 1}">
			        <a href="activityList?page=${currentPage - 1}&search=${param.search}&type=${param.type}&level=${param.level}">Previous</a>
			    </c:if>
			
			    <c:forEach begin="1" end="${totalPages}" var="pageNo">
				    <a href="activityList?page=${pageNo}&search=${param.search}&type=${param.type}&level=${param.level}" 
				       style="${pageNo == currentPage ? 'font-weight: bold; color: red;' : ''}">
				       ${pageNo}
				    </a>
				</c:forEach>

			    <c:if test="${currentPage < totalPages}">
			        <a href="activityList?page=${currentPage + 1}&search=${param.search}&type=${param.type}&level=${param.level}">Next</a>
			    </c:if>
			</div>

	            <thead>
	                <tr>
	                    <th>No</th>
	                    <th>Activity</th>
	                    <th>Organizer</th>
	                    <th>Type</th>
	                    <th>Level</th>
	                    <th>Participant</th>
	                    <th>Action</th>
	                </tr>
	            </thead>
	            <tbody>
	                <c:if test="${empty activities}">
	                    <tr>
	                        <td colspan="7" style="text-align: center;">No data available</td>
	                    </tr>
	                </c:if>
        
	                <c:forEach var="activity" items="${activities}" varStatus="status">
	                    <tr>
	                        <td>${(currentPage - 1) * 5 + status.index + 1}</td>
	                        <td>${activity.activityName}</td>
	                        <td>${activity.organizer}</td>
	                        <td>${activity.activityType}</td>
	                        <td>${activity.activityLevel}</td>
	                        <td>${activity.currentParticipant} / ${activity.limitation}</td>
	                        <td>
	                        	<button 
					                onclick="openModal(this)" 
					                class="btn btn-success btn-sm me-2" 
					                data-activity-name="${activity.activityName}" 
					                data-organizer="${activity.organizer}" 
					                data-start-date="${activity.startDate}" 
					                data-end-date="${activity.endDate}" 
					                data-pic="${activity.pic}" 
					                data-phone="${activity.phone}" 
					                data-location="${activity.location}" 
					                data-description="${activity.description}" 
					                data-activity-type="${activity.activityType}" 
					                data-activity-level="${activity.activityLevel}" 
					                data-limitation="${activity.limitation}">
					                Details
					            </button>
	                            <a href="${pageContext.request.contextPath}/admin/activity/viewParticipant?id=${activity.id}" class="btn btn-primary btn-sm me-2">Participant</a>
	                        </td>
	                    </tr>
	                    
	                </c:forEach>
	                
	                 <c:if test="${not empty message}">
					    <script>
					        Swal.fire({
					            title: 'Success!',
					            text: '${message}',
					            icon: 'success',
					            confirmButtonText: 'OK'
					        });
					    </script>
					</c:if>
	            </tbody>
	        </table>
	  
	        <div id="activityDetailsModal" class="modal" style="display: none;">
			    <div class="modal-content">
			        <span class="close-btn" onclick="closeModal()">&times;</span>
			        <h2 style="border-bottom: 1px solid black;">Activity Details</h2>
			        <div class="information">
	                	<div class="label"><strong>Activity</strong></div>
			            <div><span class="colon">:</span></div>
			            <div><span id="activityName"></span></div>
	                </div>
	                
	                <div class="information">
	                	<div class="label"><strong>Organizer</strong></div>
			            <div><span class="colon">:</span></div>
			            <div><span id="organizer"></span></div>
	                </div>
	                
	                <div class="information">
	                	<div class="label"><strong>Start Date</strong> </div>
			            <div><span class="colon">:</span></div>
			            <div><span id="startDate"></span></div>
	                </div>
	                
	                <div class="information">
	                	<div class="label"><strong>End Date</strong></div>
			            <div><span class="colon">:</span></div>
			            <div><span id="endDate"></span></div>
	                </div>
	                
	                <div class="information">
	                	<div class="label"><strong>Person in Charge</strong></div>
			            <div><span class="colon">:</span></div>
			            <div><span id="pic"></span></div>
	                </div>
	                
	                <div class="information">
	                	<div class="label"><strong>Phone</strong></div>
			            <div><span class="colon">:</span></div>
			            <div><span id="phone"></span></div>
	                </div>
	                
	                <div class="information">
	                	<div class="label"><strong>Location</strong></div>
			            <div><span class="colon">:</span></div>
			            <div><span id="location"></span></div>
	                </div>
	                
	                <div class="information">
	                	<div class="label"><strong>Description</strong></div>
			            <div><span class="colon">:</span></div>
			            <div><span id="description"></span></div>
	                </div>
	                
	                <div class="information">
	                	<div class="label"><strong>Activity Type</strong></div>
			            <div><span class="colon">:</span></div>
			            <div><span id="activityType"></span></div>
	                </div>
	                
	                <div class="information">
	                	<div class="label"><strong>Activity Level</strong></div>
			            <div><span class="colon">:</span></div>
			            <div><span id="activityLevel"></span></div>
	                </div>
	                
	                <div class="information">
	                	<div class="label"><strong>Limitation</strong></div>
			            <div><span class="colon">:</span></div>
			            <div><span id="limitation"></span></div>
	                </div>
			    </div>
			 </div>
	    </div>

</div>
</body>
</html>

<script>
	function openModal(button) {
	    // Populate modal data
	    document.getElementById('activityName').innerText = button.getAttribute('data-activity-name') || "N/A";
	    document.getElementById('organizer').innerText = button.getAttribute('data-organizer') || "N/A";
	    document.getElementById('startDate').innerText = formatDate(button.getAttribute('data-start-date')) || "N/A";
	    document.getElementById('endDate').innerText = formatDate(button.getAttribute('data-end-date')) || "N/A";
	    document.getElementById('pic').innerText = button.getAttribute('data-pic') || "N/A";
	    document.getElementById('phone').innerText = button.getAttribute('data-phone') || "N/A";
	    document.getElementById('location').innerText = button.getAttribute('data-location') || "N/A";
	    document.getElementById('description').innerText = button.getAttribute('data-description') || "N/A";
	    document.getElementById('activityType').innerText = button.getAttribute('data-activity-type') || "N/A";
	    document.getElementById('activityLevel').innerText = button.getAttribute('data-activity-level') || "N/A";
	    document.getElementById('limitation').innerText = button.getAttribute('data-limitation') || "N/A";
	
	    // Show the modal
	    document.getElementById('activityDetailsModal').style.display = 'block';
	}
	
	function closeModal() {
	    document.getElementById('activityDetailsModal').style.display = 'none';
	}
	
	function formatDate(dateTime) {
	    if (!dateTime) return "--"; 
	    const dateParts = dateTime.split(' ')[0]; 
	    return dateParts; 
	}

</script>