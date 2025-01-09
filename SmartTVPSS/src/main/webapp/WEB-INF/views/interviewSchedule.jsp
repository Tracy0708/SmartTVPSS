<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Schedule Interview</title>
    <style>
        /* Add your styling here */
        body {
            font-family: Arial, sans-serif;
        }
        .form-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        .form-container h3 {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-container div {
            margin-bottom: 15px;
        }
        .form-container label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .form-container input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-container button {
            background-color: #FBAF3C;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            display: block;
            margin: 20px auto 0;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h3>Schedule Interview</h3>
    <form action="processScheduleInterview" method="post">
        <!-- Talent ID -->
        <div>
            <label>Talent ID:</label>
            <input type="text" name="talentId" value="${param.talentId}" readonly />
        </div>
        <!-- School Code -->
        <div>
            <label>School Code:</label>
            <input type="text" name="schoolCode" value="${param.schoolCode}" readonly />
        </div>
        <!-- Name -->
        <div>
            <label>Name:</label>
            <input type="text" name="name" value="${param.name}" readonly />
        </div>
        <!-- Contact -->
        <div>
            <label>Contact Number:</label>
            <input type="text" name="contact" value="${param.contact}" readonly />
        </div>
        <!-- Date -->
        <div>
            <label>Date:</label>
            <input type="date" name="interviewDate" required />
        </div>
        <!-- Time -->
        <div>
            <label>Time:</label>
            <input type="time" name="interviewTime" required />
        </div>
        <!-- Submit Button -->
        <button type="submit">Schedule Interview</button>
    </form>
</div>
</body>
</html>
