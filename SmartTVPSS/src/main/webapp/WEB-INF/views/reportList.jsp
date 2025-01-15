<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>Version Report</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
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

.report-container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
}

.report-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.version-table {
	background: white;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	width: 1100px;
}

.version-badge {
	background-color: #FBAF3C;
	color: white;
	padding: 4px 8px;
	border-radius: 12px;
	font-size: 0.875rem;
}

.table th {
	background-color: #f8f9fa;
	font-weight: 600;
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

.filter-container {
	display: flex;
	gap: 20px;
	margin-bottom: 20px;
	background: white;
	padding: 15px;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	width: 600px;
}

.filter-group {
	display: flex;
	align-items: center;
	gap: 10px;
}

.filter-label {
	font-weight: 500;
	color: #2c3e50;
}

.filter-input {
	padding: 6px 12px;
	border: 1px solid #ddd;
	border-radius: 4px;
}
</style>
</head>
<body>
	<%@ include file="adminnavbar.jsp"%>
	<div class="main-container" style="display: flex">
		<div class="report-container">
			<div class="report-header">
				<h2>Schools' Version Report</h2>
			</div>

			<div class="search-container">
				<input type="text" id="searchInput" class="search-input"
					placeholder="Search school name or school code">
			</div>
			<div class="filter-container">
				<div class="filter-group">
					<label class="filter-label">Version:</label> <select
						id="versionFilter" class="filter-input">
						<option value="">All</option>
						<option value="0">v0</option>
						<option value="1">v1</option>
						<option value="2">v2</option>
						<option value="3">v3</option>
						<option value="4">v4</option>
					</select>
				</div>
				<div class="filter-group">
					<label class="filter-label">From:</label> <input type="date"
						id="dateFrom" class="filter-input">
				</div>
				<div class="filter-group">
					<label class="filter-label">To:</label> <input type="date"
						id="dateTo" class="filter-input">
				</div>
			</div>
			<div class="version-table">
				<table class="table">
					<thead>
						<tr>
							<th>School Code</th>
							<th>School Name</th>
							<th>Version</th>
							<th>Last Updated</th>
						</tr>
					</thead>
					<tbody id="versionTable">
						<c:forEach items="${schools}" var="school">
							<tr>
								<td>${school.schoolCode}</td>
								<td>${school.schoolName}</td>
								<td><span class="version-badge">v${school.version}</span></td>
								<td>${fn:split(school.updatedAt, 'T')[0]}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document)
				.ready(
						function() {
							$("#searchInput")
									.on(
											"keyup",
											function() {
												var value = $(this).val()
														.toLowerCase();
												$("table tbody tr")
														.filter(
																function() {
																	$(this)
																			.toggle(
																					$(
																							this)
																							.text()
																							.toLowerCase()
																							.indexOf(
																									value) > -1)
																});
											});
						});
	</script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/date-fns/2.29.3/date-fns.min.js"></script>
	<script>
		$(document)
				.ready(
						function() {
							function filterTable() {
								var version = $("#versionFilter").val();
								var dateFrom = $("#dateFrom").val();
								var dateTo = $("#dateTo").val();

								$("#versionTable tr")
										.each(
												function() {
													var row = $(this);

													var rowVersion = row
															.find(
																	"td:nth-child(3) .version-badge")
															.text().replace(
																	'v', '')
															.trim();

													var rowDateText = row.find(
															"td:nth-child(4)")
															.text().trim();

													try {
														console
																.log(
																		'Processing row:',
																		{
																			version : rowVersion,
																			dateText : rowDateText
																		});

														var rowDate = new Date(
																rowDateText);
														var fromDate = dateFrom ? new Date(
																dateFrom
																		+ 'T00:00:00')
																: null;
														var toDate = dateTo ? new Date(
																dateTo
																		+ 'T23:59:59')
																: null;

														var showRow = true;

														if (version
																&& parseInt(rowVersion) !== parseInt(version)) {
															showRow = false;
														}

														if (fromDate
																&& !isNaN(rowDate
																		.getTime())
																&& rowDate < fromDate) {
															showRow = false;
														}

														if (toDate
																&& !isNaN(rowDate
																		.getTime())
																&& rowDate > toDate) {
															showRow = false;
														}

														console
																.log(
																		'Date comparison:',
																		{
																			rowDate : rowDate,
																			fromDate : fromDate,
																			toDate : toDate,
																			showRow : showRow
																		});

														row.toggle(showRow);

													} catch (error) {
														console
																.error(
																		'Error processing row:',
																		error);
														console
																.error(
																		'Row data:',
																		{
																			version : rowVersion,
																			date : rowDateText
																		});
														row.show();
													}
												});
							}

							$("#versionFilter, #dateFrom, #dateTo").on(
									"input change", function() {
										filterTable();
									});

							filterTable();
						});
	</script>
</body>
</html>