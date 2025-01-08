<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Talent Status</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        .status-passed {
            color: green;
        }
        .status-failed {
            color: red;
        }
    </style>
</head>
<body>
    <h1>Your Talent Application Status</h1>

    <c:choose>
        <!-- If the student has no applications -->
        <c:when test="${empty studentTalents}">
            <p>You have no talent applications at the moment.</p>
        </c:when>
        
        <!-- If the student has applications -->
        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th>Talent ID</th>
                        <th>Talent Name</th>
                        <th>Application Date</th>
                        <th>Interview Date</th>
                        <th>Interview Result</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="talent" items="${studentTalents}">
                        <tr>
                            <td>${talent.id}</td>
                            <td>${talent.name}</td>
                            <td>${talent.applicationDate}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${empty talent.interviewDate}">
                                        Not scheduled yet
                                    </c:when>
                                    <c:otherwise>
                                        ${talent.interviewDate}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${talent.interviewResult == 'Qualified'}">
                                        <span class="status-passed">Qualified</span>
                                    </c:when>
                                    <c:when test="${talent.interviewResult == 'Disqualified'}">
                                        <span class="status-failed">Disqualified</span>
                                    </c:when>
                                    <c:otherwise>
                                        Pending
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</body>
</html>
