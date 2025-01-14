<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Every Schools' Timeline</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert2/11.7.32/sweetalert2.min.css" rel="stylesheet">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert2/11.7.32/sweetalert2.min.js"></script>
<style>
    .status-chip {
        border-radius: 16px;
        padding: 4px 12px;
        display: inline-block;
        text-align: center;
        font-size: 0.875rem;
        font-weight: 500;
    }
    
    .status-not_assigned { 
        background-color: #f8f9fa !important;
        color: #666;
    }
    .status-ongoing { 
        background-color: #d4edda !important;
        color: #155724;
    }
    .status-assigned { 
        background-color: #fff3cd !important;
        color: #856404;
    }
    .status-extended { 
        background-color: #e2e3e5 !important;
        color: #383d41;
    }
    .status-exceeded { 
        background-color: #f8d7da !important;
        color: #721c24;
    }
    .status-complete { 
        background-color: #cce5ff !important;
        color: #004085;
    }

</style>
</head>
<body>
<%@ include file="adminnavbar.jsp"%>
    <div class="container mt-5">
        <h2 class="mb-4">Requests Extending Timeline</h2>
        <div class="table-responsive">
            <table class="table table-hover">
                <thead class="table-light">
                    <tr>
                    	<th>Status</th>
                        <th>No</th>
                        <th>School Code</th>
                        <th>School Name</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="schoolTableBody">
                    <c:forEach items="${schools}" var="school" varStatus="status">
                    
                        <tr data-school-id="${school.id}">
						   <td>
							        <span class="status-chip status-${fn:toLowerCase(school.status)}">
								        ${school.status}
								    </span>
							</td>
                            <td>${status.count}</td>
                            <td>${school.schoolCode}</td>
                            <td>${school.schoolName}</td>
                  
                           <td>
                <button class="btn btn-danger btn-sm" onclick="cancelExtension(${school.id})">
                    <i class="bi bi-trash"></i> 
                </button>
            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function cancelExtension(schoolId) {
    Swal.fire({
        title: 'Are you sure?',
        text: "This will cancel the extension request",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Yes, cancel it!'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: '${pageContext.request.contextPath}/program/admin/cancelExtension/' + schoolId,
                type: 'POST',
                success: function(response) {
                    Swal.fire(
                        'Cancelled!',
                        'Extension request has been cancelled.',
                        'success'
                    ).then(() => {
                        location.reload();
                    });
                },
                error: function(xhr) {
                    Swal.fire(
                        'Error!',
                        'Failed to cancel extension request',
                        'error'
                    );
                }
            });
        }
    });
}
</script>

</body>
</html>
