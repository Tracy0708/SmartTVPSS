<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>School List</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .header h2 {
            color: #2c3e50;
        }

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

        .btn-warning {
            background-color: #f1c40f;
            color: #fff;
        }

        .btn-danger {
            background-color: #e74c3c;
            color: #fff;
        }

        .table-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            overflow: auto;
            position: relative;
        }

        .table-wrapper {
            overflow-x: auto;
            white-space: nowrap;
            padding-bottom: 10px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1000px;
        }

        .table th,
        .table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            white-space: nowrap;
        }

        .table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #2c3e50;
        }

        .table tr:hover {
            background-color: #f8f9fa;
        }

        .table th:last-child,
        .table td:last-child {
            position: sticky;
            right: 0;
            background: white;
            z-index: 2;
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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="main-container" style="display:flex">
    <jsp:include page="sidebar.jsp" />    
    <div class="container">
        <div class="header">
            <h2>All School Information</h2>
            <a href="${pageContext.request.contextPath}/program/tvpssteam/add" class="btn btn-primary">Add Information</a>
             <a href="${pageContext.request.contextPath}/program/tvpssteam/timeline" class="btn btn-primary">Set Timeline</a>
        </div>

        <div class="table-container">
            <div class="table-wrapper">
                <table class="table">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>School Code</th>
                            <th>School Name</th>
                            <th>Version</th>
                            <th>Logo</th>
                            <th>Studio School PSS</th>
                            <th>In-school recording</th>
                            <th>Upload at YouTube</th>
                            <th>Youtube URL</th>
                            <th>Recording in and out</th>
                            <th>Collaboration with external agencies</th>
                            <th>Use green screen technology</th>
                            <th>Date created</th>
                            <th>Date updated</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${schoolList}" var="school" varStatus="status">
                            <tr>
                                <td>${status.count}</td>
                                <td>${school.schoolCode}</td>
                                <td>${school.schoolName}</td>
                                <td>${school.version}</td>
                                <td>${school.hasLogo ? 'Yes' : 'No'}</td>
                                <td>${school.hasStudioPss ? 'Yes' : 'No'}</td>
                                <td>${school.hasInSchoolRecording ? 'Yes' : 'No'}</td>
                                <td>${school.hasYoutubeUpload ? 'Yes' : 'No'}</td>
                                <td>${school.youtubeUrl}</td>
                                <td>${school.hasExternalRecording ? 'Yes' : 'No'}</td>
                                 <td>${school.hasExternalCollaboration ? 'Yes' : 'No'}</td>
                                <td>${school.hasGreenScreen ? 'Yes' : 'No'}</td>
                                <td>${school.createdAt}</td>
                                <td>${school.updatedAt}</td>
                                <td class="action-buttons">
    <a href="${pageContext.request.contextPath}/program/tvpssteam/edit/${school.id}" class="btn btn-warning">Edit</a>
    <a href="#" onclick="confirmDelete(${school.id})" class="btn btn-danger">Delete</a>
</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
   <script>
        document.addEventListener('DOMContentLoaded', function() {
            var successMessage = "${successMessage}";
            if(successMessage && successMessage !== "") {
                Swal.fire({
                    title: 'Success!',
                    text: successMessage,
                    icon: 'success',
                    confirmButtonColor: '#FBAF3C'
                });
            }
        });
        
       
        function confirmDelete(id) {
            Swal.fire({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = '${pageContext.request.contextPath}/program/tvpssteam/delete?id=' + id;
                }
            })
        }
       
    </script>
</body>
</html>
