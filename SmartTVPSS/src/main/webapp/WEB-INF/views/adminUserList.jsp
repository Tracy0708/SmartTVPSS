<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin User Management</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <%@ include file="menu.jsp" %>

    <div class="container">
        <h1>User List</h1>
        <table border="1">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%-- Loop through the list of users from the server-side --%>
                <%
                    List<User> userList = (List<User>) request.getAttribute("userList");
                    int index = 1;
                    for (User user : userList) {
                %>
                <tr>
                    <td><%= index++ %></td>
                    <td><%= user.getName() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getRole() %></td>
                    <td>
                        <a href="editUser.jsp?id=<%= user.getId() %>" class="btn">Edit</a>
                        <a href="deleteUser?id=<%= user.getId() %>" class="btn">Delete</a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <a href="addUser.jsp" class="btn">Add User</a>
    </div>
</body>
</html>
