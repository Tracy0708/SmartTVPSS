<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User List</title>
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

        .container {
            display: flex;
            height: 100vh;
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
        }

        .search-filter input,
        .search-filter select,
        .search-filter button {
            padding: 8px;
            font-size: 14px;
        }

        .addUser {
            margin-bottom: 10px;
            display: flex;
            justify-content: flex-end;
        }

        .add-button {
            background-color: #f57c00;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 14px;
            cursor: pointer;
            border-radius: 5px;
            text-decoration: none;
        }

        .add-button a {
            text-decoration: none;
            color: white;
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

        .action-buttons a {
            display: inline-block;
            text-decoration: none;
            padding: 8px 12px;
            border-radius: 5px;
            font-size: 14px;
            color: white;
        }

        .action-buttons a.edit {
            background-color: #007bff;
        }

        .action-buttons a.delete {
            background-color: #dc3545;
        }

        .pagination {
            display: flex;
            margin-bottom: 5px;
        }

        .pagination a {
            text-decoration: none;
            padding: 5px;
            margin: 2px;
            background-color: #e0e0e0;
            color: #0C3182;
            border-radius: 5px;
        }

        .pagination a.active {
            font-weight: bold;
            color: red;
        }

        .table-container {
            background-color: #f0f0f0;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin: auto;
        }

        tbody tr:nth-child(even) {
            background-color: #fafafa;
        }

        thead th {
            color: #0C3182;
        }
    </style>
</head>

<body>
    <%@ include file="adminnavbar.jsp" %>

    <div class="content">
        <h2>User List</h2>

        <form method="GET" action="userList">
            <div class="search-filter">
                <input type="text" name="search" placeholder="Search by Name" value="${search}" style="width: 50%;">
                <select name="role" style="width: 20%;">
                    <option value="" ${role == null || role.isEmpty() ? 'selected' : ''}>All Roles</option>
                    <option value="TVPSS Management" ${role == 'TVPSS Management' ? 'selected' : ''}>TVPSS Management</option>
                    <option value="School Administrator" ${role == 'School Administrator' ? 'selected' : ''}>School Administrator</option>
                    <option value="Student" ${role == 'Student' ? 'selected' : ''}>Student</option>
                </select>
                <button type="submit" class="add-button" style="width: 15%;">Filter</button>
            </div>
        </form>

        <div class="addUser">
            <a href="${pageContext.request.contextPath}/TVPSS/user/add" class="add-button">Add New User</a>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty users}">
                        <tr>
                            <td colspan="5" style="text-align: center;">No users available</td>
                        </tr>
                    </c:if>

                    <c:forEach var="user" items="${users}" varStatus="status">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.name}</td>
                            <td>${user.email}</td>
                            <td>${user.role}</td>
                            <td class="action-buttons">
                                <a href="${pageContext.request.contextPath}/TVPSS/user/edit?id=${user.id}" class="edit">Edit</a>
                                <a href="#" onclick="confirmDelete('${user.id}')" class="delete">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="userList?page=${currentPage - 1}&search=${param.search}&role=${param.role}">Previous</a>
                </c:if>

                <c:forEach begin="1" end="${totalPages}" var="page">
                    <a href="userList?page=${page}&search=${param.search}&role=${param.role}" class="${page == currentPage ? 'active' : ''}">${page}</a>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="userList?page=${currentPage + 1}&search=${param.search}&role=${param.role}">Next</a>
                </c:if>
            </div>
        </div>
    </div>
    
    <c:if test="${not empty success}">
        <script>
            Swal.fire({
                title: 'Success!',
                text: '${success}',
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

    <script>
    function confirmDelete(userId) {
        Swal.fire({
            title: 'Confirm Delete?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                // Dynamically generate the delete URL
                const baseUrl = `${pageContext.request.contextPath}/TVPSS/user/delete/`;
                window.location.href = baseUrl + userId; // Redirect to delete URL
            }
        });
    }
</script>


</body>

</html>
