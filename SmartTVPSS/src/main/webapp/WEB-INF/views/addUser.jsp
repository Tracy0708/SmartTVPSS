<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add User</title>
    <link rel="stylesheet" href="styles.css">
    <script>
        function confirmSubmit() {
            return confirm("Are you sure you want to add this user?");
        }
    </script>
</head>
<body>
    <%@ include file="menu.jsp" %>

    <div class="container">
        <h1>Add User</h1>
        <form action="addUser" method="post" onsubmit="return confirmSubmit();">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required><br>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required><br>

            <label for="role">Role:</label>
            <select id="role" name="role" required>
                <option value="Admin">Admin</option>
                <option value="Teacher">Teacher</option>
                <option value="TVPSS Management">TVPSS Management</option>
            </select><br>

            <button type="submit">Add User</button>
        </form>
    </div>
</body>
</html>