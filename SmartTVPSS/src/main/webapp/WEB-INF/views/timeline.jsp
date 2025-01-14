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
    .inbox{
 
    display: flex;
    justify-content: end;
    }
    .main-container{
    max-width: 1400px;
    margin-left:20px;
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
</head>
<body>
<jsp:include page="header.jsp" />
<div class="main-container" style="display:flex">
    <jsp:include page="sidebar.jsp" />
    <div class="container mt-5">
 
    
        <h2 class="mb-4">Every Schools' Timeline</h2>
        
           <div class="search-container">
    <input type="text" 
           id="searchInput" 
           class="search-input" 
           placeholder="Search school name or code...">
</div>
        <a href="${pageContext.request.contextPath}/program/admin/requestTimeline" >
        <div class="inbox">
        <i class="bi bi-inbox-fill" style="font-size:1.8rem;color:black"></i>
        </div></a>
        <div class="table-responsive">
            <table class="table table-hover">
                <thead class="table-light">
                    <tr>
                    	<th>Status</th>
                        <th>No</th>
                        <th>School Code</th>
                        <th>School Name</th>
                        <th>Timeline</th>
                    </tr>
                </thead>
                <tbody id="schoolTableBody">
                    <c:forEach items="${schoolList}" var="school" varStatus="status">
                    
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
                              <button class="btn btn-sm btn-primary edit-timeline" data-school-id="${school.id}"><i class="bi bi-calendar3"></i></button>
							<span class="timeline-text" id="timeline-display-${school.id}">
							    <c:choose>
							        <c:when test="${not empty school.timelineStart and not empty school.timelineEnd}">
							            ${fn:split(school.timelineStart, 'T')[0]} - 
							            ${fn:split(school.timelineEnd, 'T')[0]}
							        </c:when>
							        <c:otherwise>
							            No timeline set
							        </c:otherwise>
							    </c:choose>
							</span>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Timeline Modal -->
    <div class="modal fade" id="timeline-modal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Set Timeline</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="text" class="form-control" id="timelineRange">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="saveTimeline">Save</button>
                </div>
            </div>
        </div>
    </div>
</div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <script>
        $(document).ready(function() {
            // Initialize daterangepicker
            $('#timelineRange').daterangepicker({
                locale: {
                    format: 'DD MMM YYYY'
                }
            });

            // Handle edit button click
            $('.edit-timeline').click(function() {
                selectedSchoolId = $(this).data('school-id');
                $('#timeline-modal').modal('show');
            });

            // Handle save button click
            $('#saveTimeline').click(function() {
                const dateRange = $('#timelineRange').val();
                const [start, end] = dateRange.split(' - ');
                
                // Debug logs
                console.log('Selected School ID:', selectedSchoolId);
                console.log('Date Range:', dateRange);

                // AJAX call to save
                $.ajax({
                    url: '${pageContext.request.contextPath}/program/tvpssteam/saveTimeline',
                    method: 'POST',
                    data: {
                        schoolId: selectedSchoolId,
                        timelineStart: start,
                        timelineEnd: end
                    },
                    success: function(response) {
                        console.log('Save successful:', response);
                        $('#timeline-modal').modal('hide');
                        location.reload();
                    },
                    error: function(xhr, status, error) {
                        console.error('Save failed:', error);
                        alert('Failed to save timeline: ' + error);
                    }
                });
            });
        });
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
