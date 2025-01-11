<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
    <link rel="stylesheet" href="styles.css">
    <script>
        function confirmSubmit() {
            return confirm("Are you sure you want to update this user?");
        }
    </script>
</head>
<body>
    <%@ include file="menu.jsp" %>

    <div class="container">
        <h1>Edit User</h1>
        <form action="updateUser" method="post" onsubmit="return confirmSubmit();">
            <%-- Get the user details from the server-side --%>
            <%
                User user = (User) request.getAttribute("user");
            %>
            <input type="hidden" name="id" value="<%= user.getId() %>">

            <label for="name">Name:</label>
            <input type="text" id="name" name="name" value="<%= user.getName() %>" required><br>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required><br>

            <label for="role">Role:</label>
            <select id="role" name="role" required>
                <option value="Admin" <%= user.getRole().equals("Admin") ? "selected" : "" %>>Admin</option>
                <option value="Teacher" <%= user.getRole().equals("Teacher") ? "selected" : "" %>>Teacher</option>
                <option value="TVPSS Management" <%= user.getRole().equals("TVPSS Management") ? "selected" : "" %>>TVPSS Management</option>
            </select><br>

            <button type="submit">Update User</button>
        </form>
    </div>
</body>
</html>
