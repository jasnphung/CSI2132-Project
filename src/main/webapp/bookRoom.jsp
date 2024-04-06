<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>e-Hotel Booking - Book the best hotels today</title>
    <style>
        input, select {
            padding-left: 10px;
        }
        input::placeholder {
            color: #000000;
        }
        @font-face {
            font-family: 'Gilroy-Light';
            src: url('Gilroy-Light.otf') format('opentype');
        }
        @font-face {
            font-family: 'Gilroy-ExtraBold';
            src: url('Gilroy-ExtraBold.otf') format('opentype');
        }
        body {
            font-family: Gilroy-ExtraBold, sans-serif;
            margin: 0;
            padding: 0;
            background: rgb(255,255,255);
            background: linear-gradient(180deg, rgba(255,255,255,1) 0%, rgba(136,136,136,1) 100%);
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
        header {
            color: #000000;
            padding: 10px 0;
            text-align: center;
        }
        h1 {
            font-family: Gilroy-ExtraBold, sans-serif;
            margin-top: 20px;
            font-size: 70px;
            margin-bottom: 20px;
        }
        h2 {
            font-family: Gilroy-ExtraBold, sans-serif;
            margin-top: 0;
            font-size: 50px;
            margin-bottom: 10px;
        }
        nav {
            padding: 10px 0;
            text-align: center;
        }
        nav a {
            color: #000000;
            text-decoration: none;
            margin: 0 10px;
            font-size: 20px;
        }
        main {
            padding: 20px;
        }
        footer {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 10px 0;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
        .search {
            color: #ffffff;
        }
        .background-div {
            background-image: url('hotel-outside-4.jpg');
            background-size: cover; /* Cover the entire div */
            background-repeat: no-repeat; /* Do not repeat the image */
            background-position: center; /* Center the image */
            height: 1000px;
            /* padding: 10px; */
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 20px;
        }
        .foreground-div {
            background-color: rgba(0, 0, 0, 0.55);
            /* padding: 10px; */
            border-radius: 20px;
            height: 100%;
            width: 100%;
            text-align: center;
            /* box-shadow: 0 0 10px rgba(0, 0, 0, 0.5); */
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }
        .label-size {
            font-size: 20px;
        }
        .input-spacing {
            font-size: 20px;
            margin: 10px;
            border-radius: 5px;
            width: 250px;
            height: 60px;
            font-family: Gilroy-ExtraBold, sans-serif;
        }
        .search-button {
            font-size: 20px;
            width: 500px;
            height: 60px;
            margin: 20px;
            border-radius: 5px;
            font-family: Gilroy-ExtraBold, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .search-heading {
            margin: 20px;
        }
        .search-items {
            display: grid;
            grid-template-columns: repeat(4, max-content);
            grid-column-gap: 10px;
            grid-row-gap: 10px;
            justify-content: end; /* Align items by the right edge */
        }
        .search-individual-items {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .table-header {
            font-size: 22px;
            padding: 10px;
            text-align: center;
            border: 1px solid black; /* Adjust as needed */
        }
        .table-data {
            font-family: Gilroy-Light, sans-serif;
            font-size: 18px; /* 16px -> default font size */
            padding: 10px;
            text-align: center;
            border: 1px solid black;
        }
        .table {
            border-collapse: collapse; /* Collapse the borders */
        }
        .grid-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            grid-template-rows: repeat(2, auto);
            gap: 10px;
        }
        .form-group {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .submit-container {
            display: flex;
            justify-content: center;
            align-items: center;
        }
    </style>
</head>

<body>
<header>
    <h1>
        <span style="color: #e22951;">BOOK</span><span style="color: #fe922c;">-A-</span><span style="color: #0189d9;">STAY</span>
    </h1>
    <h2 style="font-size: 30px;">Find your next room away from home</h2>
</header>
<nav>
    <a href="index.jsp">Home</a>
    <a href="databaseView1.jsp">View 1</a>
    <a href="databaseView2.jsp">View 2</a>
    <a href="employeeLogin.jsp">Employee Login</a>
    <a href="Indexes.jsp">Indexes</a>
</nav>

<%@ page import="java.util.List" %>

<%@ page import="com.DatabaseProjectWebsite.Tables.View1" %>
<%@ page import="java.util.ArrayList" %>
<%

    List<View1> viewItems = null;
    try {
        viewItems = View1.getData();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<main style="padding-bottom: 50px">
    <div class="container">
        <div class="row" id="row">
            <div class="col-md-12">
                <div class="card" id="card-container">
                    <div class="card-body" id="card">
                        <h2 class="card-title">Book Room</h2>
                        <form method="POST">
                            <div class="grid-container">
                                <div class="form-group">
                                    <label for="firstName" class="label-size">First Name:</label>
                                    <input type="text" class="input-spacing" id="firstName" name="firstName" required>
                                </div>
                                <div class="form-group">
                                    <label for="middleName" class="label-size">Middle Name:</label>
                                    <input type="text" class="input-spacing" id="middleName" name="middleName">
                                </div>
                                <div class="form-group">
                                    <label for="lastName" class="label-size">Last Name:</label>
                                    <input type="text" class="input-spacing" id="lastName" name="lastName" required>
                                </div>
                                <div class="form-group">
                                    <label for="idNumber" class="label-size">ID Number:</label>
                                    <input type="number" class="input-spacing" id="idNumber" name="idNumber" required>
                                </div>
                                <div class="form-group">
                                    <label for="creditCardNumber" class="label-size">Credit Card Number:</label>
                                    <input type="text" class="input-spacing" id="creditCardNumber" name="creditCardNumber" required>
                                </div>
                                <div class="form-group">
                                    <label for="address" class="label-size">Address:</label>
                                    <input type="text" class="input-spacing" id="address" name="address" required>
                                </div>
                                <div class="form-group">
                                    <label for="id-type" class="label-size">Type of ID:</label>
                                    <input type="text" class="input-spacing" id="id-type" name="id-type" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="search-button">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>


<%@ page import="java.time.LocalDate" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.DatabaseProjectWebsite.DatabaseConnection" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%
    // Check if the form is submitted
    if (request.getMethod().equalsIgnoreCase("post")) {
        String firstName = request.getParameter("firstName");
        String middleName = request.getParameter("middleName");
        String lastName = request.getParameter("lastName");
        int idNumber = Integer.parseInt( request.getParameter("idNumber") );
        int creditCardNumber = Integer.parseInt( request.getParameter("creditCardNumber") );
        String address = request.getParameter("address");
        String idType = request.getParameter("id-type");

        // Get today's date as LocalDate
        LocalDate localDate = LocalDate.now();
        // Convert LocalDate to java.sql.Date
        Date sqlDate = Date.valueOf(localDate);

        try {
            // Use DatabaseConnection to get a connection
            DatabaseConnection db = new DatabaseConnection();

            try (Connection conn = db.getConnection()) {
                // Prepare the SQL statement
                String sql = "INSERT INTO dbproj.customer (first_name, middle_name, last_name, customer_id, address, id_type, register_date, card_number) " +
                             "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, firstName);
                stmt.setString(2, middleName);
                stmt.setString(3, lastName);
                stmt.setInt(4, idNumber);
                stmt.setString(5, address);
                stmt.setString(6, idType);
                stmt.setDate(7, sqlDate);
                stmt.setInt(8, creditCardNumber);

                // Execute the query
                stmt.executeUpdate();

                // Close the statement
                stmt.close();
            }
            // Redirect or display a success message
            response.sendRedirect("BookingSuccess.jsp");
        } catch (Exception e) {
            // Handle any errors
            System.out.println("Err: " + e.getMessage());
            out.println("Error: " + e.getMessage());
        }
    }
%>


<footer style=background-color:#0b1021;>
    <a href="adminLogin.jsp" style="color: white;">Admin? Login here</a>
</footer>
</body>

</html>
