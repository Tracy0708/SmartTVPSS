<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Participant List</title>
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
		    border-color: #FBAF3C
		 }
		 
		 .btn-edit {
		    color: #fff;
		    background-color: #007bff;
		    border-color: #007bff;
		 }
		 
		 .btn-danger {
		    color: #fff;
		    background-color: #dc3545;
		    border-color: #dc3545;
		}
		
		.btn-reset{
			color:blue;
			text-decoration:none;
		}
		
		.activityInfo{
			margin-left:20px;
			font-size: 20px;
		}
		
		.activityInfo p{
			margin-bottom:10px;
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
		    background-color: white;
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
        	margin-bottom: 15px;
        	font-size: 20px;
    		font-family: monospace;
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
	
		<div class="detail-header" style="display:flex;">
              <a href='activityList'><svg xmlns="http://www.w3.org/2000/svg" height="26px"
                      viewBox="0 -960 960 960" width="26px" fill="black">
                      <path d="m313-440 224 224-57 56-320-320 320-320 57 56-224 224h487v80H313Z" />
                  </svg></a>
              <h2 style="padding-left: 20px;">Participant List</h2>
        </div>
                	    
	    <form method="GET" action="viewParticipant">
		    <input type="hidden" name="id" value="${activity.id}" />
		    <div class="search-filter">
		        <input style="width: 60%;" type="text" name="search" placeholder="Search" value="${search}">
		        <select style="width: 20%;" name="gender">
		            <option value="" disabled selected>Gender</option>
		            <option value="Male" ${gender == 'Male' ? 'selected' : ''}>Male</option>
		            <option value="Female" ${gender == 'Female' ? 'selected' : ''}>Female</option>
		        </select>
		        <button type="submit" class="filter-button" style="width: 20%;">Filter</button>
		        <a href="${pageContext.request.contextPath}/admin/activity/viewParticipant?id=${activity.id}" class="btn-reset">Reset</a>
		    </div>
		</form>

		
		<div class="activityInfo">
			<p><strong>Activity : </strong> ${activity.activityName}</p>
			<p><strong>Organizer : </strong> ${activity.organizer}</p>
		</div>
	
	    <div class="table-container">
	        <table>
	        
	        <!-- Pagination Controls -->
			<div class="pagination">
			    <c:if test="${currentPage > 1}">
			        <a href="viewParticipant?id=${activity.id}&page=${currentPage - 1}&search=${search}&gender=${gender}">Previous</a>
			    </c:if>
			
			    <c:forEach begin="1" end="${totalPages}" var="pageNo">
			        <a href="viewParticipant?id=${activity.id}&page=${pageNo}&search=${search}&gender=${gender}" 
			           style="${pageNo == currentPage ? 'font-weight: bold; color: red;' : ''}">
			           ${pageNo}
			        </a>
			    </c:forEach>
			
			    <c:if test="${currentPage < totalPages}">
			        <a href="viewParticipant?id=${activity.id}&page=${currentPage + 1}&search=${search}&gender=${gender}">Next</a>
			    </c:if>
			</div>

	            <thead>
	                <tr>
	                    <th>No</th>
	                    <th>Student Name</th>
	                    <th>School</th>
	                    <th>Gender</th>
	                    <th>Email</th>
	                    <th>Action</th>
	                </tr>
	            </thead>
	            <tbody>
	                <c:if test="${empty participants}">
	                    <tr>
	                        <td colspan="6" style="text-align: center;">No data available</td>
	                    </tr>
	                </c:if>
        
	                <c:forEach var="participant" items="${participants}" varStatus="status">
	                    <tr>
	                        <td>${(currentPage - 1) * 5 + status.index + 1}</td>
	                        <td>${participant.name}</td>
	                        <td>${participant.school}</td>
	                        <td>${participant.gender}</td>
	                        <td>${participant.email}</td>
	                        <td>
								<button 
					                onclick="openModal(this)" 
					                class="btn btn-primary btn-sm me-2" 
					                data-student-id="${participant.studentID}" 
					                data-name="${participant.name}" 
					                data-gender="${participant.gender}" 
					                data-age="${participant.age}" 
					                data-school="${participant.school}" 
					                data-email="${participant.email}" 
					                data-phone="${participant.phone}" 
					                data-address="${participant.address}" >
					                View
					            </button>
								<a href='${pageContext.request.contextPath}/admin/activity/edit?id=${participant.participant_id}' class='btn btn-edit btn-sm me-2'>Edit</a>
								<a href="#" onclick="confirmDelete(${participant.participant_id})" class='btn btn-danger btn-sm'>Delete</a>
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
					
					<c:if test="${not empty error}">
						<script>
						        Swal.fire({
						            title: 'Error!',
						            text: '${error}',
						            icon: 'error',
						            confirmButtonText: 'OK'
						        });
						</script>
					</c:if>
	            </tbody>
	        </table>
	        
	        <div id="participantDetailsModal" class="modal" style="display: none;">
			    <div class="modal-content">
			        <span class="close-btn" onclick="closeModal()">&times;</span>
			        <h2>Participant Details</h2>
			        <div class="information">
	                	<div class="label"><strong>Student ID:</strong></div>
			            <div><span class="colon">:</span></div>
			            <div><span id="studentID"></span></div>
	                </div>
	                
	                <div class="information">
	                	<div class="label"><strong>Name:</strong></div>
			            <div><span class="colon">:</span></div>
			            <div><span id="name"></span></div>
	                </div>
	                
	                <div class="information">
	                	<div class="label"><strong>Gender</strong> </div>
			            <div><span class="colon">:</span></div>
			            <div><span id="gender"></span></div>
	                </div>
	                
	                <div class="information">
	                	<div class="label"><strong>Age</strong></div>
			            <div><span class="colon">:</span></div>
			            <div><span id="age"></span></div>
	                </div>
	                
	                <div class="information">
	                	<div class="label"><strong>School</strong></div>
			            <div><span class="colon">:</span></div>
			            <div><span id="school"></span></div>
	                </div>
	                
	                <div class="information">
	                	<div class="label"><strong>Email</strong></div>
			            <div><span class="colon">:</span></div>
			            <div><span id="email"></span></div>
	                </div>
	                
	                <div class="information">
	                	<div class="label"><strong>Phone</strong></div>
			            <div><span class="colon">:</span></div>
			            <div><span id="phone"></span></div>
	                </div>
	                
	                <div class="information">
	                	<div class="label"><strong>Address</strong></div>
			            <div><span class="colon">:</span></div>
			            <div><span id="address"></span></div>
	                </div>
	                
			    </div>
			 </div>
	    </div>
	    
	    </div>
</body>

<script>
	function confirmDelete(participantId) {
	    Swal.fire({
	        title: 'Are you sure?',
	        text: "You won't be able to revert this!",
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
	        confirmButtonText: 'Yes, delete it!'
	    }).then((result) => {
	        if (result.isConfirmed) {
	            window.location.href = 'delete?id=' + participantId;
	        }
	    });
	}
	
	function openModal(button) {
	    // Populate modal data
	    document.getElementById('studentID').innerText = button.getAttribute('data-student-id') || "N/A";
	    document.getElementById('name').innerText = button.getAttribute('data-name') || "N/A";
	    document.getElementById('gender').innerText = button.getAttribute('data-gender') || "N/A";
	    document.getElementById('age').innerText = button.getAttribute('data-age') || "N/A";
	    document.getElementById('school').innerText = button.getAttribute('data-school') || "N/A";
	    document.getElementById('email').innerText = button.getAttribute('data-email') || "N/A";
	    document.getElementById('phone').innerText = button.getAttribute('data-phone') || "N/A";
	    document.getElementById('address').innerText = button.getAttribute('data-address') || "N/A";
	
	    // Show the modal
	    document.getElementById('participantDetailsModal').style.display = 'block';
	}
	
	function closeModal() {
	    document.getElementById('participantDetailsModal').style.display = 'none';
	}
</script>

</html>