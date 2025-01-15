<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<title>Edit School</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert2/11.7.32/sweetalert2.min.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert2/11.7.32/sweetalert2.min.js"></script>
<style>
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

.admin-program-container {
	max-width: 2000px;
	margin: 0 auto;
	padding: 20px;
}

.header {
	margin-bottom: 20px;
}

.header h2 {
	color: #2c3e50;
}

.form-container {
	background-color: white;
	border-radius: 8px;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
	padding: 24px;
	width: 1000px;
}

.form-group {
	margin-bottom: 16px;
}

.form-label {
	display: block;
	margin-bottom: 8px;
	color: #333;
	font-size: 14px;
}

.required::after {
	content: ' *';
	color: #e74c3c;
}

.form-control {
	width: 100%;
	padding: 8px 12px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 14px;
}

.form-control:focus {
	outline: none;
	border-color: #3498db;
}

.checkbox-group {
	margin-top: 20px;
}

.checkbox-container {
	display: flex;
	align-items: center;
	margin-bottom: 10px;
}

.checkbox-container input[type="checkbox"] {
	margin-right: 10px;
}

.back-title {
	display: flex;
	align-items: center;
	gap: 20px;
}

.back-title a {
	text-decoration: none;
	color: #333;
}

.form-columns {
	display: flex;
	gap: 32px;
	margin-top: 24px;
}

.form-column {
	flex: 1;
}

.column-title {
	font-size: 16px;
	font-weight: 500;
	margin-bottom: 16px;
	color: #333;
}

.toggle-container {
	display: flex;
	align-items: center;
	margin-bottom: 16px;
}

.toggle-label {
	font-size: 14px;
	color: #333;
	margin-left: 20px;
}

.switch {
	position: relative;
	display: inline-block;
	width: 44px;
	height: 24px;
}

.switch input {
	opacity: 0;
	width: 0;
	height: 0;
}

.slider {
	position: absolute;
	cursor: pointer;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #ccc;
	transition: .4s;
	border-radius: 24px;
}

.slider:before {
	position: absolute;
	content: "";
	height: 18px;
	width: 18px;
	left: 3px;
	bottom: 3px;
	background-color: white;
	transition: .4s;
	border-radius: 50%;
}

input:checked+.slider {
	background-color: #3498db;
}

input:checked+.slider:before {
	transform: translateX(20px);
}

.version-badge {
	margin-left: 0px;
	margin-top: 10px;
	margin-bottom: 20px;
	background-color: #4da4e7;
	padding: 5px 10px;
	border-radius: 9999px;
	font-size: 0.875rem;
	display: inline-block;
	font-weight: bold;
	color: white;
}

.youtube-url {
	display: none;
	margin-top: 130px;
	margin-bottom: 16px;
	gap: 10px;
}

.extend-timeline-link {
	color: #007bff;
	text-decoration: underline;
	cursor: pointer;
	margin-top: 10px;
	display: inline-block;
}

.modal {
	display: none;
	position: fixed;
	z-index: 1000;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	animation: fadeIn 0.3s;
}

.modal-content {
	background-color: #fff;
	margin: 15% auto;
	padding: 24px;
	border-radius: 8px;
	width: 400px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	text-align: center;
}

.modal-title {
	font-size: 1.25rem;
	color: #2d3748;
	margin-bottom: 16px;
}

.modal-actions {
	display: flex;
	justify-content: center;
	gap: 12px;
	margin-top: 24px;
}

@
keyframes fadeIn {from { opacity:0;
	
}

to {
	opacity: 1;
}

}
.btn {
	padding: 8px 16px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px;
	text-decoration: none;
	transition: background-color 0.3s;
	justify-content: center;
}

.btn:disabled {
	opacity: 0.65;
	cursor: not-allowed;
}

.btnModal {
	padding: 8px 16px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px;
	text-decoration: none;
	transition: background-color 0.3s;
	justify-content: center;
	max-width: fit
}

.btn-primary {
	background-color: #3498db;
	color: white;
}

.btn-secondary {
	background-color: #95a5a6;
	color: white;
	margin-left: 15px;
	width: 80px;
}

.btn-primary:hover {
	background-color: #2980b9;
}

.btn-secondary:hover {
	background-color: #7f8c8d;
}

.btn1 {
	background-color: #3498db;
	color: white;
	width: 80px;
	width: auto;
}

.btn2 {
	background-color: #95a5a6;
	color: white;
	margin-left: 15px;
	width: 80px;
}

.btn1:hover {
	background-color: #2980b9;
}

.btn2:hover {
	background-color: #7f8c8d;
}

@media ( max-width : 768px) {
	.container {
		padding: 10px;
	}
	.form-container {
		padding: 15px;
	}
}

.exceeded-warning p {
	color: red;
	text-align: end;
	margin: 10px 0;
}

.exceeded-warning {
	display: flex;
	justify-content: end;
	align-items: center;
	gap: 10px
}

.update-btn-container {
	display: flex;
	justify-content: center;
}
</style>
<script>
function toggleYoutubeUrlRequired() {
    const checkBox = document.getElementById("hasYoutubeUpload");
    const youtubeUrlGroup = document.getElementById("youtubeUrlGroup");
    const youtubeUrl = document.getElementById("youtubeUrl");
    
    youtubeUrlGroup.style.display = checkBox.checked ? 'flex' : 'none';
    youtubeUrl.required = checkBox.checked;
}
document.addEventListener("DOMContentLoaded", function () {
    const successMessage = "${successMessage}";
    if (successMessage) {
    	debugger
        Swal.fire({
            title: "Success!",
            text: successMessage,
            icon: "success",
            confirmButtonText: "OK"
        });
    }
});
function showExtendModal() {
    document.getElementById('extendModal').style.display = 'block';
}

function hideExtendModal() {
    document.getElementById('extendModal').style.display = 'none';
}

$(document).ready(function() {
    $('#extendForm').on('submit', function(e) {
        e.preventDefault();
        $.ajax({
            url: '${pageContext.request.contextPath}/program/admin/requestExtension',
            type: 'POST',
            data: $(this).serialize(),
            success: function(response) {
                hideExtendModal();
                Swal.fire({
                    title: 'Success!',
                    text: 'Extension request submitted successfully',
                    icon: 'success'
                });
            },
            error: function(xhr) {
                Swal.fire({
                    title: 'Error!',
                    text: 'Failed to submit extension request',
                    icon: 'error'
                });
            }
        });
    });
});
</script>
</head>
<body>
	<%@ include file="schooladminnavbar.jsp"%>
	<div class="main-container" style="display: flex">
		<div class="admin-program-container">
			<h2>Update Program Status</h2>
			<span class="version-badge">Version ${school.version}</span>
			<c:if test="${school.status == 'EXCEEDED'}">
				<div class="exceeded-warning">
					<i class="bi bi-hourglass-bottom" style="color: red" ]></i>
					<p>Timeline has been exceeded.</p>
				</div>
			</c:if>
			<div class="form-container">
				<form id="updateForm" method="post"
					action="${pageContext.request.contextPath}/program/admin/updateSchool">
					<input type="hidden" name="id" value="${school.id}" />

					<div class="form-group">
						<label class="form-label required">School Code</label> <input
							type="text" name="schoolCode" class="form-control"
							value="${school.schoolCode}" required readonly>
					</div>

					<div class="form-group">
						<label class="form-label required">School Name</label> <input
							type="text" name="schoolName" class="form-control"
							value="${school.schoolName}" required readonly>
					</div>

					<div class="form-columns">
						<!-- Equipment Column -->
						<div class="form-column">
							<h3 class="column-title">Equipment</h3>

							<div class="toggle-container">
								<label class="switch"> <input type="checkbox"
									name="hasLogo" ${school.hasLogo ? 'checked' : ''}> <span
									class="slider"></span>
								</label> <span class="toggle-label">Logo</span>
							</div>

							<div class="toggle-container">
								<label class="switch"> <input type="checkbox"
									name="hasStudioPss" ${school.hasStudioPss ? 'checked' : ''}>
									<span class="slider"></span>
								</label> <span class="toggle-label">Corner/Mini studio/School PSS
									studio</span>
							</div>

							<div class="toggle-container">
								<label class="switch"> <input type="checkbox"
									name="hasInSchoolRecording"
									${school.hasInSchoolRecording ? 'checked' : ''}> <span
									class="slider"></span>
								</label> <span class="toggle-label">Recording in school</span>
							</div>

							<div class="toggle-container">
								<label class="switch"> <input type="checkbox"
									id="hasYoutubeUpload" name="hasYoutubeUpload"
									${school.hasYoutubeUpload ? 'checked' : ''}
									onchange="toggleYoutubeUrlRequired()"> <span
									class="slider"></span>
								</label> <span class="toggle-label">Upload in Youtube</span>
							</div>

							<div class="toggle-container">
								<label class="switch"> <input type="checkbox"
									name="hasExternalRecording"
									${school.hasExternalRecording ? 'checked' : ''}> <span
									class="slider"></span>
								</label> <span class="toggle-label">Recording inside/outside the
									school</span>
							</div>

							<div class="toggle-container">
								<label class="switch"> <input type="checkbox"
									name="hasExternalCollaboration"
									${school.hasExternalCollaboration ? 'checked' : ''}> <span
									class="slider"></span>
								</label> <span class="toggle-label">Collaboration with external
									agencies</span>
							</div>

							<div class="toggle-container">
								<label class="switch"> <input type="checkbox"
									name="hasGreenScreen" ${school.hasGreenScreen ? 'checked' : ''}>
									<span class="slider"></span>
								</label> <span class="toggle-label">Use Green Screen technology</span>
							</div>
						</div>
						<div class="form-column">
							<h3 class="column-title">Additional Information</h3>
							<div class="youtube-url" id="youtubeUrlGroup"
								style="display: ${school.hasYoutubeUpload ? 'flex' : 'none'}">
								<label for="youtubeUrl" class="required"></label> <input
									id="youtubeUrl" type="url" name="youtubeUrl"
									class="form-control" value="${school.youtubeUrl}"
									placeholder="Please provide valid Youtube url">
							</div>
						</div>
					</div>

					<div class="form-group update-btn-container">
						<button type="submit" class="btn btn-primary"
							${school.status == 'EXCEEDED' ? 'disabled' : ''}>Update</button>
					</div>

				</form>

			</div>
			<c:if test="${school.status == 'EXCEEDED'}">
				<a class="extend-timeline-link" onclick="showExtendModal()">Exceed
					timeline? Click here to request extending timeline</a>
			</c:if>
		</div>
	</div>
	<div id="extendModal" class="modal">
		<div class="modal-content">
			<div class="modal-title">Request Timeline Extension</div>
			<p>Do you want to request a timeline extension for updating
				status?</p>
			<div class="modal-actions">
				<button type="button" class="btnModal btn2"
					onclick="hideExtendModal()">Cancel</button>
				<button type="button" class="btnModal btn1"
					onclick="submitExtensionRequest()">Submit Request</button>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
function submitExtensionRequest() {
    $.ajax({
        url: '${pageContext.request.contextPath}/program/admin/requestExtension',
        type: 'POST',
        data: { schoolId: ${school.id} },
        success: function(response) {
            hideExtendModal();
            Swal.fire({
                title: 'Success!',
                text: 'Extension request submitted successfully',
                icon: 'success'
            }).then(() => {
                location.reload();
            });
        },
        error: function(xhr) {
            Swal.fire({
                title: 'Error!',
                text: xhr.responseText,
                icon: 'error'
            });
        }
    });
}
</script>
</body>
</html>