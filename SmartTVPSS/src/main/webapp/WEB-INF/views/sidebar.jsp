 <style>
 /* Sidebar Section */

        .sidebar {
            width: 260px;
            color: black;
            height: auto;
            padding: 20px;
            padding-top: 100px;
        }

        .sidebar h3 {
            margin-bottom: 20px;
            font-size: 1.2rem;
            text-align: center;
            border-bottom: 1px solid #ccc;
            padding-bottom: 10px;
        }

        .sidebar ul {
            list-style: none;
        }

        .sidebar ul li {
            margin: 15px 0;
            text-align: center;
        }

        .sidebar ul li a {
    		text-decoration: none;
    		color: black;
    		font-weight: bold;
    		font-size: 1rem;
    		padding: 5px 10px; /* Add padding to create space for the highlight */
    		border-radius: 5px; /* Optional: make the highlight edges rounded */
    		transition: background-color 0.3s, color 0.3s; /* Smooth transition */
		}

		.sidebar ul li a:hover {
    		background-color: #FBAF3C; /* Highlight color */
		}
 </style>
 
 <div class="sidebar">
            <h3>TVPSS Team</h3>
            <ul>
            	
                <li class="toggle">
                    
                    <ul class="sub-menu">
                        <li><a href="${pageContext.request.contextPath}/school/schoolList">Program status</a></li>

                    </ul>
                </li>
                
            </ul>
        </div>