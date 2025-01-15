<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TVPSS Dashboard</title>
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

        #eventModal, #editEventModal {
            display: none;
            position: fixed;
            top: 40%;
            left: 55%;
            transform: translate(-50%, -50%);
            width: 400px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }

        #eventModal input, #editEventModal input {
            width: 100%;
            margin-bottom: 10px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        #eventModal button, #editEventModal button {
            margin-right: 10px;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
        }

        #saveEvent, #updateEvent {
            background: #0C3182;
            color: white;
        }

        #closeModal {
            background: #ccc;
            color: black;
        }

        #deleteEvent {
            background: red;
            color: white;
        }
    </style>
</head>
<body>
    <%@ include file="adminnavbar.jsp" %>

    <div class="main-content">
        <h2>TVPSS Dashboard</h2>
        <div class="calendar-container">
            <div id="calendar"></div>
        </div>
    </div>

    <!-- Add Event Modal -->
    <div id="eventModal">
        <h3>Add New Event</h3>
        <label for="eventTitle">Event Title:</label>
        <input type="text" id="eventTitle">
        <label for="startDate">Start Date:</label>
        <input type="date" id="startDate">
        <label for="endDate">End Date (Optional):</label>
        <input type="date" id="endDate">
        <button id="saveEvent">Save</button>
        <button id="closeModal">Close</button>
    </div>

    <!-- Edit Event Modal -->
    <div id="editEventModal">
        <h3>Edit Event</h3>
        <label for="editEventTitle">Event Title:</label>
        <input type="text" id="editEventTitle">
        <label for="editStartDate">Start Date:</label>
        <input type="date" id="editStartDate">
        <label for="editEndDate">End Date (Optional):</label>
        <input type="date" id="editEndDate">
        <button id="updateEvent">Update</button>
        <button id="deleteEvent">Delete</button>
        <button id="closeEditModal">Close</button>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var calendarEl = document.getElementById('calendar');
            var currentEventId = null;

            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                headerToolbar: {
                    left: 'prev,next today addEventButton',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'
                },
                customButtons: {
                    addEventButton: {
                        text: 'Add Event',
                        click: function () {
                            document.getElementById('eventModal').style.display = 'block';
                        }
                    }
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
                    currentEventId = info.event.id;
                    document.getElementById('editEventTitle').value = info.event.title;
                    document.getElementById('editStartDate').value = info.event.startStr;
                    document.getElementById('editEndDate').value = info.event.endStr || '';
                    document.getElementById('editEventModal').style.display = 'block';
                }
            });

            calendar.render();

            document.getElementById('saveEvent').addEventListener('click', function () {
                var title = document.getElementById('eventTitle').value;
                var startDate = document.getElementById('startDate').value;
                var endDate = document.getElementById('endDate').value;

                if (title && startDate) {
                    $.ajax({
                        url: '/SmartTVPSS/home/dashboard/saveEvent',
                        method: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({
                            title: title,
                            startDate: startDate,
                            endDate: endDate
                        }),
                        success: function () {
                            Swal.fire({
                                icon: 'success',
                                title: 'Event Added',
                                text: 'The event has been successfully added!'
                            });

                            calendar.refetchEvents();
                            document.getElementById('eventModal').style.display = 'none';
                            document.getElementById('eventTitle').value = '';
                            document.getElementById('startDate').value = '';
                            document.getElementById('endDate').value = '';
                        },
                        error: function () {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'Failed to save the event. Please try again.'
                            });
                        }
                    });
                } else {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Missing Fields',
                        text: 'Please fill in the event title and start date.'
                    });
                }
            });

            document.getElementById('updateEvent').addEventListener('click', function () {
                var title = document.getElementById('editEventTitle').value;
                var startDate = document.getElementById('editStartDate').value;
                var endDate = document.getElementById('editEndDate').value;

                if (title && startDate) {
                    $.ajax({
                        url: '/SmartTVPSS/home/dashboard/updateEvent', // Fixed URL
                        method: 'PUT', // Correct HTTP method
                        contentType: 'application/json',
                        data: JSON.stringify({
                            id: currentEventId,
                            title: title,
                            startDate: startDate,
                            endDate: endDate
                        }),
                        success: function () {
                            Swal.fire({
                                icon: 'success',
                                title: 'Event Updated',
                                text: 'The event has been successfully updated!'
                            });

                            calendar.refetchEvents();
                            document.getElementById('editEventModal').style.display = 'none';
                        },
                        error: function () {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'Failed to update the event. Please try again.'
                            });
                        }
                    });
                } else {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Missing Fields',
                        text: 'Please fill in the event title and start date.'
                    });
                }
            });

            document.getElementById('deleteEvent').addEventListener('click', function () {
                Swal.fire({
                    title: 'Are you sure?',
                    text: 'You won\'t be able to revert this!',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, delete it!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            url: '/SmartTVPSS/home/dashboard/deleteEvent/' + currentEventId,
                            method: 'DELETE',
                            success: function () {
                                Swal.fire('Deleted!', 'The event has been deleted.', 'success');
                                calendar.refetchEvents();
                                document.getElementById('editEventModal').style.display = 'none';
                            },
                            error: function () {
                                Swal.fire('Error', 'Failed to delete the event.', 'error');
                            }
                        });
                    }
                });
            });

            document.getElementById('closeModal').addEventListener('click', function () {
                document.getElementById('eventModal').style.display = 'none';
            });

            document.getElementById('closeEditModal').addEventListener('click', function () {
                document.getElementById('editEventModal').style.display = 'none';
            });
        });
    </script>
</body>
</html>