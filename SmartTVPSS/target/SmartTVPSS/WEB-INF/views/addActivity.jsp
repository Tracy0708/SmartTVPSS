<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Activity</title>

    <style>
        * {
            margin: 0;
            padding: 0;
        }

        body {
            min-height: 100vh;
        }

        nav {
            background-color: #0C3182;
            box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.1);
            padding-right: 2rem;
        }

        nav ul {
            width: 100%;
            list-style: none;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        nav li {
            height: 70px;
        }

        nav a {
            height: 100%;
            padding: 0 30px;
            text-decoration: none;
            display: flex;
            align-items: center;
            color: white;
        }

        nav a:hover {
            background-color: #f0f0f0;
        }

        nav li:first-child {
            margin-right: auto;
        }

        .sidebar {
            width: 15vw;
            background-color: #f4f4f4;
            border-right: 1px solid #ddd;
            padding: 20px;
        }

        .container {
            display: flex;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
        }

        .sidebar ul li {
            margin-bottom: 15px;
        }

        .sidebar ul li a {
            text-decoration: none;
            color: #333;
            font-size: 16px;
        }

        .content {
            padding: 20px;
            width: 50vw;
            margin: auto;
        }

        .form-container {
            background-color: #f5c687;
            padding: 20px;
            border-radius: 10px;
            margin: 0 auto;
            box-sizing: border-box;
        }


        .form-container label {
            display: block;
            font-weight: bold;
            margin-top: 10px;
        }

        .form-container input,
        .form-container select,
        .form-container textarea {
            width: 100%;
            margin-top: 5px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .form-container input[type="number"] {
            width: auto;
            padding-left: 10px;
        }

        .form-container input[type="text"],
        .form-container input[type="tel"],
        .form-container input[type="date"],
        .form-container input[type="number"],
        .form-container select {
            height: 35px;
        }

        .form-container .submit-button {
            background-color: #f57c00;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 20px;
            display: block;
            width: 100%;
        }

        .row {
            display: flex;
            gap: 15px;
        }

        .column{
            width: 50%;
        }
    </style>
</head>

<body>
    <nav>
        <ul style="justify-content: flex-start;">
            <li><a style="color: #FBAF3C;" href="#">SCHOOL RESOURCE CENTRE TV</a></li>
            <li><a href="#">Home</a></li>
            <li><a href="#">Program Status</a></li>
            <li><a href="#">Activity</a></li>
            <li><a href="#" style="float: right;">Logout</a>
        </ul>
    </nav>
    <div class="container">
        <div class="sidebar">
            <h2 style="text-align: center; margin-bottom: 15px;">Activity</h2>
            <ul>
                <li style="font-weight: bold;">Manage Activity</li>
                <li><a href="#">Activity List</a></li>

                <li style="font-weight: bold;">Activity Participant</li>
                <li><a href="#">Participant List</a></li>
            </ul>
        </div>

        <div class="content">
            <div class="form-container">
                <div class="header" style="display: flex;">
                    <a href="activityList.html"><svg xmlns="http://www.w3.org/2000/svg" height="26px"
                            viewBox="0 -960 960 960" width="26px" fill="black">
                            <path d="m313-440 224 224-57 56-320-320 320-320 57 56-224 224h487v80H313Z" />
                        </svg></a>
                    <h2 style="padding-left: 20px;">New Activity</h2>
                </div>

                <form>
                    <label for="activity-name">Activity Name:</label>
                    <input type="text" id="activity-name" name="activity-name" required>

                    <label for="organizer">Organizer:</label>
                    <input type="text" id="organizer" name="organizer" required>

                    <div class="row">
                        <div class="column">
                            <label for="startDate">Start Date:</label>
                            <input type="date" id="start-date" name="start-date" placeholder="start-date">
                        </div>
                        <div class="column">
                            <label for="endDate">End Date:</label>
                            <input type="date" id="end-date" name="end-date">
                        </div>
                    </div>


                    <label for="pic">PIC:</label>
                    <input type="text" id="pic" name="pic">

                    <label for="phone">Phone:</label>
                    <input type="tel" id="phone" name="phone">

                    <label>Location: </label>
                    <input type="text" id="location" name="location">

                    <!-- <label>Who can participate:</label>
                    <input type="checkbox" id="students" name="participants" value="students">
                    <label for="students" style="display: inline;">Students</label>
                    <input type="checkbox" id="teachers" name="participants" value="teachers">
                    <label for="teachers" style="display: inline;">Teacher</label> -->

                    <label for="description">Description:</label>
                    <textarea id="description" name="description" rows="4"></textarea>

                    <label for="activity-type">Activity Type:</label>
                    <select id="activity-type" name="activity-type" required>
                        <option value="" disabled selected>Select a type</option>
                        <option value="award">Award</option>
                        <option value="competition">Competition</option>
                        <option value="talk">Talk</option>
                    </select>

                    <label for="activity-level">Activity Level:</label>
                    <select id="activity-level" name="activity-level" required>
                        <option value="" disabled selected>Select level</option>
                        <option value="school">School</option>
                        <option value="state">State</option>
                        <option value="district">District</option>
                    </select>

                    <label for="limitations">Limitations:</label>
                    <input type="number" id="limitations" name="limitations" min="0" value="0">

                    <button type="submit" class="submit-button">SUBMIT</button>
                </form>
            </div>

        </div>
    </div>
</body>
