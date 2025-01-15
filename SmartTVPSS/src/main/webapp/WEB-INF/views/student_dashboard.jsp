<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.2/main.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.2/main.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            min-height: 100vh;
        }

        .main-content {
            flex-grow: 1;
            padding: 20px;
        }

        .main-content h2 {
            margin-bottom: 20px;
        }

        .calendar-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <%@ include file="studentnavbar.jsp" %>

    <div class="main-content">
        <h2>Student Dashboard</h2>
        <div class="calendar-container">
            <div id="calendar"></div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var calendarEl = document.getElementById('calendar');

            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'
                },
                events: function (fetchInfo, successCallback, failureCallback) {
                    $.ajax({
                        url: '/SmartTVPSS/home/dashboard/getEvents',
                        method: 'GET',
                        success: function (data) {
                            var events = data.map(function (activity) {
                                return {
                                    id: activity.id,
                                    title: activity.title,
                                    start: activity.startDate,
                                    end: activity.endDate,
                                    allDay: true
                                };
                            });
                            successCallback(events);
                        },
                        error: function () {
                            Swal.fire({
                                icon: 'error',
                                title: 'Oops...',
                                text: 'Failed to load activities!'
                            });
                            failureCallback();
                        }
                    });
                },
                eventClick: function (info) {
                    const start = info.event.start ? info.event.start.toLocaleString() : "N/A";
                    const end = info.event.end ? info.event.end.toLocaleString() : "N/A";

                    Swal.fire({
                        icon: 'info',
                        title: info.event.title,
                        html: `<strong>Start:</strong> ${start}<br><strong>End:</strong> ${end}`
                    });
                }
            });

            calendar.render();
        });
    </script>
</body>
</html>
