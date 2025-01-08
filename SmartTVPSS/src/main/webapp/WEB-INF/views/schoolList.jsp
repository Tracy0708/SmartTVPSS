<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>School List</title>
    <style>
        /* Base styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            background-color: #f5f5f5;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Header styles */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .header h2 {
            color: #2c3e50;
        }

        /* Button styles */
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .btn-primary {
            background-color: #3498db;
            color: white;
        }

        .btn-primary:hover {
            background-color: #2980b9;
        }

        .btn-warning {
            background-color: #f1c40f;
            color: #fff;
        }

        .btn-danger {
            background-color: #e74c3c;
            color: #fff;
        }

        /* Table styles */
        .table-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            overflow: auto;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            min-width: 800px;
        }

        .table th,
        .table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #2c3e50;
        }

        .table tr:hover {
            background-color: #f8f9fa;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }

            .header {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>All School Information</h2>
            <a href="${pageContext.request.contextPath}/school/add" class="btn btn-primary">Add Information</a>
        </div>

        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>School Code</th>
                        <th>School Name</th>
                        <th>Logo</th>
                        <th>Studio School PSS</th>
                        <th>In-school recording</th>
                        <th>Upload at YouTube</th>
                        <th>Recording in and out</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${schoolList}" var="school" varStatus="status">
                        <tr>
                            <td>${status.count}</td>
                            <td>${school.schoolCode}</td>
                            <td>${school.schoolName}</td>
                            <td>${school.hasLogo ? 'Yes' : 'No'}</td>
                            <td>${school.hasStudioPss ? 'Yes' : 'No'}</td>
                            <td>${school.hasInSchoolRecording ? 'Yes' : 'No'}</td>
                            <td>${school.hasYoutubeUpload ? 'Yes' : 'No'}</td>
                            <td>${school.hasExternalRecording ? 'Yes' : 'No'}</td>
                            <td class="action-buttons">
                                <a href="${pageContext.request.contextPath}/school/edit/${school.id}" class="btn btn-warning">Edit</a>
                                <a href="${pageContext.request.contextPath}/school/delete/${school.id}" class="btn btn-danger">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>