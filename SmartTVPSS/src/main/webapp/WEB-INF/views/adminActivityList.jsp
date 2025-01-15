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
		    background-color: #007bff;
		    border-color: #007bff;
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
        
        .history{
        	display: flex;
		    justify-content: flex-end;
		    margin-top: 15px;
		    align-items: center;
		    text-align: center;
        }
        
        .history-button{
        	background-color: transparent;
		    text-align: center;
		    text-decoration: none;
		    color: black;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    border-radius: 15px;
		    padding: 5px;
		    color: #17a2b8;
    		background-image: none;
    		border-color: #17a2b8;
        }
        
        .history-button:hover{
		    color: #fff;
		    background-color: #17a2b8;
		    border-color: #17a2b8;
		}
		
		.history-button:hover svg{
			fill: #fff;
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
	    <h2>Activity List</h2>
	    
	    <form method="GET" action="activityList">
		    <div class="search-filter">
		        <input style="width: 50%;" type="text" name="search" placeholder="Search" value="${search}">
		        
		        <select style="width: 17%;" name="type">
			        <option value="" disabled selected>Type</option>
			        <option value="Competition" ${type == 'competition' ? 'selected' : ''}>Competition</option>
			        <option value="Award" ${type == 'award' ? 'selected' : ''}>Award</option>
			        <option value="Talk" ${type == 'talk' ? 'selected' : ''}>Talk</option>
			    </select>
		        
		        <select style="width: 17%;" name="level">
			        <option value="" disabled selected>Level</option>
			        <option value="State" ${level == 'state' ? 'selected' : ''}>State</option>
			        <option value="School" ${level == 'school' ? 'selected' : ''}>School</option>
			        <option value="District" ${level == 'school' ? 'selected' : ''}>District</option>
			    </select>
			    
		        <button type="submit" class="filter-button" style="width: 16%;">Filter</button>
		    </div>
		</form>
	    
	    <div class="addUser">
	        <button class="add-button" style="width: 15%;"><a href="add">Add Activity</a></button>
	    </div>
	
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
	                    <th>Action</th>
	                </tr>
	            </thead>
	            <tbody>
	                <c:if test="${empty activities}">
	                    <tr>
	                        <td colspan="6" style="text-align: center;">No data available</td>
	                    </tr>
	                </c:if>
        
	                <c:forEach var="activity" items="${activities}" varStatus="status">
	                    <tr>
	                        <td>${(currentPage - 1) * 5 + status.index + 1}</td>
	                        <td>${activity.activityName}</td>
	                        <td>${activity.organizer}</td>
	                        <td>${activity.activityType}</td>
	                        <td>${activity.activityLevel}</td>
	                        <td>
	                        	<a href="view?id=${activity.id}" class="btn btn-success btn-sm me-2 view-data" data-activity-id="${activity.id}">View</a>
								<a href='edit?id=${activity.id}' class='btn btn-primary btn-sm me-2'>Edit</a>
								<a href="#" onclick="confirmDelete(${activity.id})" class='btn btn-danger btn-sm'>Delete</a>
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
	    </div>
	    <div class="history">
	    	   <a href="history" class="history-button btn" style="width: 10%;"><svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#17a2b8"><path d="M480-120q-138 0-240.5-91.5T122-440h82q14 104 92.5 172T480-200q117 0 198.5-81.5T760-480q0-117-81.5-198.5T480-760q-69 0-129 32t-101 88h110v80H120v-240h80v94q51-64 124.5-99T480-840q75 0 140.5 28.5t114 77q48.5 48.5 77 114T840-480q0 75-28.5 140.5t-77 114q-48.5 48.5-114 77T480-120Zm112-192L440-464v-216h80v184l128 128-56 56Z"/></svg> History</a>
	    </div>
	</div>
	
	<script>	
	    function confirmDelete(activityId) {
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
	                window.location.href = 'delete?id=' + activityId;
	            }
	        });
	    }
	</script>    
</body>

</html>