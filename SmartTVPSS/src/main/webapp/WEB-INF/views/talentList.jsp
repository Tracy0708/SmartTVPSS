<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>

<html>
<head>
<title>View Application Status</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<style>
/* Main Content Section */
.main-content {
	flex: 1;
	padding: 40px;
}

.table-container {
	background-color: #fff;
	border-radius: 12px;
	padding: 30px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
}

.table-container h2 {
	text-align: center;
	color: #003d73;
	margin-bottom: 20px;
	font-size: 1.8rem;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

table th, table td {
	padding: 12px;
	border: 1px solid #ccc;
	text-align: center;
}

table th {
	background-color: #003d73;
	color: #fff;
	font-weight: bold;
}

table tr:nth-child(even) {
	background-color: #f9f9f9;
}

table tr:hover {
	background-color: #f1f1f1;
}

/* Modal Styles */
.modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	z-index: 1000;
}

.modal-content {
	background-color: #fff;
	margin: 5% auto;
	padding: 30px;
	border-radius: 12px;
	width: 50%;
	max-width: 600px;
	position: relative;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
}

.close {
	position: absolute;
	right: 20px;
	top: 15px;
	font-size: 24px;
	cursor: pointer;
	color: #666;
}

.close:hover {
	color: #000;
}

.student-info {
	background-color: #f8f9fa;
	padding: 20px;
	border-radius: 8px;
	margin-bottom: 25px;
	border: 1px solid #e9ecef;
}

.student-info h3 {
	color: #003d73;
	margin-top: 0;
	margin-bottom: 15px;
}

.student-info p {
	margin: 10px 0;
	color: #333;
}

.form-group {
	margin-bottom: 20px;
}

.form-group label {
	display: block;
	margin-bottom: 8px;
	color: #333;
	font-weight: 600;
}

.form-group input {
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 6px;
	font-size: 14px;
}

.form-group input:focus {
	outline: none;
	border-color: #FBAF3C;
	box-shadow: 0 0 5px rgba(251, 175, 60, 0.3);
}

/* Button Styles */
.action-button {
	background-color: #FBAF3C;
	color: white;
	border: none;
	padding: 8px 12px;
	border-radius: 5px;
	cursor: pointer;
	margin: 2px;
	transition: background-color 0.3s;
}

.action-button:hover {
	background-color: #fbd23c;
}

.delete-button {
	background-color: #A30000;
	color: white;
	border: none;
	padding: 8px 12px;
	border-radius: 5px;
	cursor: pointer;
	margin: 2px;
	transition: background-color 0.3s;
}

.delete-button:hover {
	background-color: #ff0000;
}

.schedule-btn {
	background-color: #FBAF3C;
	color: white;
	padding: 12px 24px;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	width: 100%;
	font-size: 16px;
	font-weight: 600;
	transition: background-color 0.3s;
}

.schedule-btn:hover {
	background-color: #fbd23c;
}

/* Dropdown Menu Styling */
#newStatus {
	width: 100%;
	padding: 12px;
	font-size: 16px;
	border: 1px solid #ddd;
	border-radius: 6px;
	background-color: #fff;
	color: #333;
	appearance: none; /* Removes the default browser arrow for dropdown */
	-webkit-appearance: none;
	-moz-appearance: none;
	background-image:
		url('data:image/svg+xml;charset=US-ASCII,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 4 5"><path fill="%23333" d="M2 0L0 2h4z"/></svg>');
	/* Custom arrow */
	background-repeat: no-repeat;
	background-position: right 12px center;
	background-size: 12px;
	transition: border-color 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}

#newStatus:focus {
	outline: none;
	border-color: #FBAF3C;
	box-shadow: 0 0 5px rgba(251, 175, 60, 0.3);
}

#newStatus:hover {
	border-color: #FBAF3C;
}

.search-container {
	margin: 20px 0;
	display: flex;
	justify-content: flex-end;
}

.search-input {
	padding: 10px 15px;
	border: 2px solid #003d73;
	border-radius: 6px;
	font-size: 14px;
	width: 250px;
	transition: all 0.3s ease;
}

.search-input:focus {
	outline: none;
	border-color: #FBAF3C;
	box-shadow: 0 0 5px rgba(251, 175, 60, 0.3);
	width: 300px;
}

.search-input::placeholder {
	color: #666;
}

.pagination-container {
	margin-top: 20px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px 0;
}

.items-per-page {
	display: flex;
	align-items: center;
	gap: 10px;
}

.items-per-page select {
	padding: 5px 10px;
	border: 1px solid #003d73;
	border-radius: 4px;
	background-color: white;
}

.pagination-controls {
	display: flex;
	align-items: center;
	gap: 10px;
}

.pagination-button {
	background-color: #003d73;
	color: white;
	border: none;
	padding: 8px 16px;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.pagination-button:disabled {
	background-color: #cccccc;
	cursor: not-allowed;
}

.pagination-button:hover:not(:disabled) {
	background-color: #FBAF3C;
}

.page-numbers {
	display: flex;
	gap: 5px;
}

.page-number {
	padding: 8px 12px;
	border: 1px solid #003d73;
	border-radius: 4px;
	cursor: pointer;
	background-color: white;
}

.page-number.active {
	background-color: #FBAF3C;
	color: white;
	border-color: #FBAF3C;
}
</style>
</head>
<body>
	<%@ include file="schooladminnavbar.jsp"%>

	<div class="main-content">
		<div class="table-container">
			<h2>Application Status</h2>

			<div class="search-container">
				<input type="text" id="schoolCodeSearch" class="search-input"
					placeholder="Search by School Code...">
			</div>
			
			
			<script>
    // Check if a success message is passed
    <c:if test="${not empty message}">
        Swal.fire({
            icon: 'success',
            title: 'Success',
            text: '${message}',
            confirmButtonColor: '#3085d6'
        });
    </c:if>
    
    
 // Pagination
    // Global variables for pagination state
let currentPage = 1;
let rowsPerPage = 10;
let searchValue = '';

// Initialize table functionality
function initializeTable() {
    const tableBody = document.querySelector('table tbody');
    const rows = Array.from(tableBody.querySelectorAll('tr'));
    
    // Filter rows based on search
    const filteredRows = filterRows(rows);
    
    // Calculate pagination
    const totalPages = Math.ceil(filteredRows.length / rowsPerPage);
    const startIndex = (currentPage - 1) * rowsPerPage;
    const endIndex = Math.min(startIndex + rowsPerPage, filteredRows.length);
    
    // Hide all rows first
    rows.forEach(row => row.style.display = 'none');
    
    // Show only rows for current page
    filteredRows.slice(startIndex, endIndex).forEach(row => row.style.display = '');
    
    // Update pagination UI
    updatePaginationUI(totalPages);
}

// Filter rows based on search value
function filterRows(rows) {
    if (!searchValue) return rows;
    
    return rows.filter(row => {
        const schoolCode = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
        return schoolCode.includes(searchValue.toLowerCase());
    });
}

// Update pagination UI elements
function updatePaginationUI(totalPages) {
    const pageNumbers = document.getElementById('pageNumbers');
    pageNumbers.innerHTML = '';
    
    // Add first page if not in range
    if (currentPage > 3) {
        addPageButton(1, pageNumbers);
        if (currentPage > 4) addEllipsis(pageNumbers);
    }
    
    // Add page numbers around current page
    for (let i = Math.max(1, currentPage - 2); i <= Math.min(totalPages, currentPage + 2); i++) {
        addPageButton(i, pageNumbers);
    }
    
    // Add last page if not in range
    if (currentPage < totalPages - 2) {
        if (currentPage < totalPages - 3) addEllipsis(pageNumbers);
        addPageButton(totalPages, pageNumbers);
    }
    
    // Update navigation buttons
    document.getElementById('prevPage').disabled = currentPage === 1;
    document.getElementById('nextPage').disabled = currentPage === totalPages;
}

// Add page number button
function addPageButton(pageNum, container) {
    const button = document.createElement('div');
    button.classList.add('page-number');
    if (pageNum === currentPage) button.classList.add('active');
    button.textContent = pageNum;
    button.addEventListener('click', () => {
        currentPage = pageNum;
        initializeTable();
    });
    container.appendChild(button);
}

// Add ellipsis
function addEllipsis(container) {
    const ellipsis = document.createElement('div');
    ellipsis.classList.add('page-number');
    ellipsis.textContent = '...';
    ellipsis.style.cursor = 'default';
    container.appendChild(ellipsis);
}

// Event Listeners
document.addEventListener('DOMContentLoaded', () => {
    // Initialize table
    initializeTable();
    
    // Search input listener
    document.getElementById('schoolCodeSearch').addEventListener('input', (e) => {
        searchValue = e.target.value;
        currentPage = 1; // Reset to first page when searching
        initializeTable();
    });
    
    // Rows per page listener
    document.getElementById('rowsPerPage').addEventListener('change', (e) => {
        rowsPerPage = parseInt(e.target.value);
        currentPage = 1; // Reset to first page when changing rows per page
        initializeTable();
    });
    
    // Navigation button listeners
    document.getElementById('prevPage').addEventListener('click', () => {
        if (currentPage > 1) {
            currentPage--;
            initializeTable();
        }
    });
    
    document.getElementById('nextPage').addEventListener('click', () => {
        const tableRows = document.querySelectorAll('table tbody tr');
        const filteredRows = filterRows(Array.from(tableRows));
        const totalPages = Math.ceil(filteredRows.length / rowsPerPage);
        
        if (currentPage < totalPages) {
            currentPage++;
            initializeTable();
        }
    });
});
</script>
			<table>
				<thead>
					<tr>
						<th>ID</th>
						<th>School Code</th>
						<th>School Name</th>
						<th>Student Name</th>
						<th>Gender</th>
						<th>Contact Number</th>
						<th>Email</th>
						<th>Reason</th>
						<th>Status</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="talent" items="${talentList}">
						<tr>
							<td>${talent.id}</td>
							<td>${talent.schoolCode}</td>
							<td>${talent.schoolName}</td>
							<td>${talent.name}</td>
							<td>${talent.gender}</td>
							<td>${talent.contact}</td>
							<td>${talent.email}</td>
							<td>${talent.reason}</td>
							<td
								style="font-weight: bold; color: white; 
    background-color: ${talent.applicationStatus eq 'SCHEDULED' ? '#007bff' : 
                       talent.applicationStatus eq 'PENDING' ? '#ffc107' : 
                       talent.applicationStatus eq 'QUALIFIED' ? '#28a745' : 
                       talent.applicationStatus eq 'DISQUALIFIED' ? '#dc3545' : '#007bff'};">
								${talent.applicationStatus}<br> <c:if
									test="${talent.applicationStatus != 'PENDING' && talent.applicationStatus != 'QUALIFIED' && talent.applicationStatus != 'DISQUALIFIED'}">
									<fmt:formatDate value="${talent.interviewDate}"
										pattern="dd-MM-yyyy" />
									<br>
        ${talent.interviewTime}
    </c:if>
							</td>


							<td>
								<button class="delete-button"
									onclick="deleteTalent(${talent.id})">Delete</button>
								<button class="action-button"
									onclick="openInterviewModal('${talent.id}', 
                                                                  '${talent.name}', 
                                                                  '${talent.schoolName}', 
                                                                  '${talent.email}', 
                                                                  '${talent.contact}')">
									Schedule Interview</button>
								<button class="action-button"
									onclick="updateStatus(${talent.id})">Update Status</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<div class="pagination-container">
				<div class="items-per-page">
					<label for="rowsPerPage">Rows per page:</label> <select
						id="rowsPerPage">
						<option value="5">5</option>
						<option value="10" selected>10</option>
						<option value="15">15</option>
						<option value="20">20</option>
					</select>
				</div>
				<div class="pagination-controls">
					<button id="prevPage" class="pagination-button">&lt;
						Previous</button>
					<div id="pageNumbers" class="page-numbers"></div>
					<button id="nextPage" class="pagination-button">Next &gt;</button>
				</div>
			</div>


		</div>
	</div>

	<!-- Interview Modal -->
	<div id="interviewModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>
			<h2>Schedule Interview</h2>

			<div class="student-info">
				<h3>Student Information</h3>
				<div id="studentDetails">
					<p>
						<strong>Name:</strong> <span id="modal-name"></span>
					</p>
					<p>
						<strong>School Code:</strong> <span id="modal-school"></span>
					</p>
					<p>
						<strong>Email:</strong> <span id="modal-email"></span>
					</p>
					<p>
						<strong>Contact:</strong> <span id="modal-contact"></span>
					</p>
				</div>
			</div>

			<form id="interviewForm" onsubmit="submitInterview(event)">
				<input type="hidden" id="studentId">

				<div class="form-group">
					<label for="interviewDate">Interview Date:</label> <input
						type="date" id="interviewDate" required>
				</div>

				<div class="form-group">
					<label for="interviewTime">Interview Time:</label> <input
						type="time" id="interviewTime" required>
				</div>

				<button type="submit" class="schedule-btn">Schedule
					Interview</button>
			</form>
		</div>
	</div>

	<!-- Update Status Modal -->
	<div id="updateStatusModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeStatusModal()">&times;</span>
			<h2>Update Application Status</h2>

			<div class="form-group">
				<label for="newStatus">Select Status:</label> <select id="newStatus"
					class="form-control" required>
					<option value="PENDING">PENDING</option>
					<option value="SCHEDULED">SCHEDULED</option>
					<option value="QUALIFIED">QUALIFIED</option>
					<option value="DISQUALIFIED">DISQUALIFIED</option>
				</select>
			</div>

			<button class="schedule-btn" onclick="submitStatusUpdate()">Update
				Status</button>
		</div>
	</div>


	<script>
        const modal = document.getElementById('interviewModal');
        
        function openInterviewModal(id, name, school, email, contact) {
            if (!id || !name || !school || !email || !contact) {
                alert('Missing required information for scheduling interview');
                return;
            }
            
            document.getElementById('studentId').value = id;
            document.getElementById('modal-name').textContent = name;
            document.getElementById('modal-school').textContent = school;
            document.getElementById('modal-email').textContent = email;
            document.getElementById('modal-contact').textContent = contact;
            
            const today = new Date().toISOString().split('T')[0];
            const dateInput = document.getElementById('interviewDate');
            dateInput.min = today;
            
            // Clear previous values
            dateInput.value = '';
            document.getElementById('interviewTime').value = '';
            
            modal.style.display = 'block';
        }
        
        function closeModal() {
            modal.style.display = 'none';
        }
        
        function submitInterview(event) {
            event.preventDefault();

            const interviewDate = document.getElementById('interviewDate').value;
            const interviewTime = document.getElementById('interviewTime').value;
            const id = parseInt(document.getElementById('studentId').value);

            if (!interviewDate || !interviewTime) {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Please select both an interview date and time.',
                });
                return;
            }

            Swal.fire({
                title: 'Confirm Schedule',
                html: `<p>Are you sure you want to schedule the interview?</p>`,
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, schedule it!',
            }).then((result) => {
                if (result.isConfirmed) {
                    const interviewData = {
                        id: id,
                        interviewDate: interviewDate,
                        interviewTime: interviewTime,
                    };

                    fetch('/SmartTVPSS/talent/admin/talentList', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'Accept': 'application/json',
                        },
                        body: JSON.stringify(interviewData),
                    })
                    .then((response) => {
                        if (!response.ok) {
                            return response.text().then((text) => {
                                throw new Error(`HTTP error! status: ${response.status}, body: ${text}`);
                            });
                        }
                        return response.json();
                    })
                    .then((data) => {
                        if (data.success) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Success',
                                text: 'Interview scheduled successfully!',
                            }).then(() => {
                                window.location.reload();
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: data.message || 'Failed to schedule the interview. Please try again.',
                            });
                        }
                    })
                    .catch((error) => {
                        console.error('Error:', error);
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: `An error occurred while scheduling the interview: ${error.message}`,
                        });
                    });
                }
            });
        }

        
        window.onclick = function(event) {
            if (event.target == modal) {
                closeModal();
            }
        }
        
        
        function deleteTalent(id) {
	        Swal.fire({
	            title: 'Are you sure?',
	            text: "You won't be able to revert this!",
	            icon: 'warning',
	            showCancelButton: true,
	            confirmButtonColor: '#3085d6',
	            cancelButtonColor: '#d33',
	            confirmButtonText: 'Yes, delete it!'
	        }).then((result) => {
	            if (result.isConfirmed) {
	                window.location.href = 'delete?id=' + id;
	            }
	        });
	    }
        
        
        
        
        const statusModal = document.getElementById('updateStatusModal');
        let updateTalentId = null;

        function updateStatus(id) {
            updateTalentId = id;
            statusModal.style.display = 'block';
        }

        function closeStatusModal() {
            statusModal.style.display = 'none';
        }

        function submitStatusUpdate() {
            const newStatus = document.getElementById('newStatus').value;

            if (!newStatus) {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Please select a status.',
                });
                return;
            }

            Swal.fire({
                title: 'Confirm Status Update',
                text: 'Are you sure you want to update the status?',
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, update it!',
            }).then((result) => {
                if (result.isConfirmed) {
                    fetch(`/SmartTVPSS/talent/admin/updateStatus`, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'Accept': 'application/json',
                        },
                        body: JSON.stringify({
                            id: updateTalentId,
                            status: newStatus,
                        }),
                    })
                        .then((response) => response.json())
                        .then((data) => {
                            if (data.success) {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Success',
                                    text: 'Status updated successfully!',
                                }).then(() => {
                                    window.location.reload();
                                });
                            } else {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error',
                                    text: data.message || 'Failed to update the status. Please try again.',
                                });
                            }
                        })
                        .catch((error) => {
                            console.error('Error:', error);
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: `An error occurred while updating the status: ${error.message}`,
                            });
                        });
                }
            });
        }

    </script>
</body>
</html>