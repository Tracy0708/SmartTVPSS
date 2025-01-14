<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
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

        .school-list-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .school-list-header {
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
            margin-top:20px;
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
        .button-group{
        justify-content:end;
        display:flex;
        gap:10px;
        }
            .search-container {
    margin-bottom: 20px;
}

.search-input {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    width: 300px;
    font-size: 14px;
}

.search-input:focus {
    outline: none;
    border-color: #3498db;
    box-shadow: 0 0 0 2px rgba(52,152,219,0.2);
}
    </style>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<%@ include file="adminnavbar.jsp"%>
<div class="main-container" style="display:flex">
    <div class="school-list-container">
        <div class="school-list-header">
            <h2>Schools' Program Status</h2>
            
        </div>
         <div class="search-container">
    <input type="text" 
           id="searchInput" 
           class="search-input" 
           placeholder="Search school name or code...">
</div>
        <div class="button-group">
<a href="${pageContext.request.contextPath}/program/tvpssteam/add" class="btn btn-primary">Add School</a>
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
                            <th>Date</th>
                            
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="schoolTableBody">
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
                                <td> ${fn:split(school.updatedAt, 'T')[0]}</td>
                                <td class="action-buttons">
                                
    <a href="${pageContext.request.contextPath}/program/tvpssteam/edit/${school.id}" class="btn btn-warning"><i class="bi bi-pencil-square"></i></a>
    <a href="#" onclick="confirmDelete(${school.id})" class="btn btn-danger"><i class="bi bi-trash-fill"></i></a>
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
      <script>
document.getElementById('searchInput').addEventListener('keyup', function() {
    // Get first word only from search input
    const searchValue = this.value.trim().split(' ')[0].toLowerCase();
    const tableRows = document.querySelectorAll('#schoolTableBody tr');
    
    tableRows.forEach(row => {
        const schoolCode = row.querySelector('td:nth-child(3)').textContent.toLowerCase().split(' ')[0];
        const schoolName = row.querySelector('td:nth-child(4)').textContent.toLowerCase().split(' ')[0];
        
        if (schoolCode.includes(searchValue) || schoolName.includes(searchValue)) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
});
</script>
    
</body>
</html>
