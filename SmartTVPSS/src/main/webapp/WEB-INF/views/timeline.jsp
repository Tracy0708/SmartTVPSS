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
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">Every Schools' Timeline</h2>
        <input type="text" class="form-control mb-3" id="searchInput" placeholder="Search school name or code">
        <div class="table-responsive">
            <table class="table table-hover">
                <thead class="table-light">
                    <tr>
                        <th>No</th>
                        <th>School Code</th>
                        <th>School Name</th>
                        <th>Timeline</th>
                    </tr>
                </thead>
                <tbody id="schoolTableBody">
                    <c:forEach items="${schoolList}" var="school" varStatus="status">
                        <tr data-school-id="${school.id}">
                            <td>${status.count}</td>
                            <td>${school.schoolCode}</td>
                            <td>${school.schoolName}</td>
                            <td>
                                <span class="timeline-text" id="timeline-display-${school.id}">
                                    <c:choose>
                                        <c:when test="${not empty school.timelineStart and not empty school.timelineEnd}">
                                            <fmt:formatDate pattern="d MMM yyyy" value="${school.timelineStart}"/> - 
                                            <fmt:formatDate pattern="d MMM yyyy" value="${school.timelineEnd}"/>
                                        </c:when>
                                        <c:otherwise>Not Set</c:otherwise>
                                    </c:choose>
                                </span>
                                <button class="btn btn-sm btn-primary edit-timeline" data-school-id="${school.id}">Set Timeline</button>
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
                url: '${pageContext.request.contextPath}/school/saveTimeline',
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
</body>
</html>
