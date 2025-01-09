<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Activity Management</title>

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

        .edit:hover svg{
            fill: green;
        }

        .delete:hover svg{
            fill: red;
        }
    </style>
</head>

<body>
    	<%@ include file="adminnavbar.jsp"%>

        <div class="content">
            <h2>Activity List</h2>
            <div class="search-filter">
                <input style="width: 50%;" type="text" placeholder="Search">
                <select style="width: 15%;">
                    <option value="">Type</option>
                </select>
                <select style="width: 15%;">
                    <option value="">Level</option>
                </select>
                <button class="filter-button" style="width: 15%;">Filter</button>
            </div>
            <div class="addUser">
                <button class="add-button" style="width: 15%;"><a href="addActivity.html">Add Activity</a></button>
            </div>

            <div class="table-container">
	            <table>
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
		                <c:if test="${empty activityList}">
		                    <tr>
		                        <td colspan="6" style="text-align: center;">No data available</td>
		                    </tr>
		                </c:if>
		                <c:forEach var="activity" items="${activityList}">
		                    <tr>
		                        <td>${activity.id}</td>
		                        <td>${activity.activityName}</td>
		                        <td>${activity.organizer}</td>
		                        <td>${activity.activityType}</td>
		                        <td>${activity.activityLevel}</td>
		                        <td>
		                            <a href='#' class='edit'><svg xmlns="http://www.w3.org/2000/svg"
		                                    height="24px" viewBox="0 -960 960 960" width="24px" fill="grey">
		                                    <path
		                                        d="M200-200h57l391-391-57-57-391 391v57Zm-80 80v-170l528-527q12-11 26.5-17t30.5-6q16 0 31 6t26 18l55 56q12 11 17.5 26t5.5 30q0 16-5.5 30.5T817-647L290-120H120Zm640-584-56-56 56 56Zm-141 85-28-29 57 57-29-28Z" />
		                                </svg></a>
		                            <a href='#' class='delete'><svg xmlns="http://www.w3.org/2000/svg"
		                                    height="24px" viewBox="0 -960 960 960" width="24px" fill="grey">
		                                    <path
		                                        d="M280-120q-33 0-56.5-23.5T200-200v-520h-40v-80h200v-40h240v40h200v80h-40v520q0 33-23.5 56.5T680-120H280Zm400-600H280v520h400v-520ZM360-280h80v-360h-80v360Zm160 0h80v-360h-80v360ZM280-720v520-520Z" />
		                                </svg></a>
		                        </td>
		                    </tr>
		                	</c:forEach>
			        	</tbody>
			    </table>
                        
            </div>
        </div>
</body>

</html>