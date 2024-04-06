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
        .input {
            font-family: Gilroy-Light, sans-serif;
            font-size: 18px; /* 16px -> default font size */
            padding: 10px;
            text-align: left;
            border: 1px solid black;
            margin: 10px;
            border-radius: 5px;
            box-sizing: border-box;
            background-color: white;
            width: 400px;
        }
        .input-button {
            font-size: 20px;
            border-radius: 5px;
            font-family: Gilroy-Light, sans-serif;
            padding: 10px;
            text-align: center;
            border: 1px solid black;
            background-color: white;
            margin: 10px;
            margin-bottom: 50px;
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

<%@ page import="com.DatabaseProjectWebsite.Tables.HotelChain" %>
<%@ page import="com.DatabaseProjectWebsite.Tables.Hotel" %>
<%@ page import="com.DatabaseProjectWebsite.Tables.HotelRoom" %>
<%@ page import="com.DatabaseProjectWebsite.Tables.Employee" %>
<%@ page import="com.DatabaseProjectWebsite.Tables.Customer" %>

<%
    String type = request.getParameter("type");

    String chainName = "";
    String centralOfficeAddress = "";
    long phoneNumber = 0;
    String emailAddress = "";
    int numberOfHotels = 0;

    String hotelChainName = "";
    String hotelAddress = "";
    long hotelPhoneNumber = 0;
    String hotelEmail = "";
    int hotelRating = 0;
    int hotelNumberOfRooms = 0;
    int hotelManagerID = 0;
%>

<%
    if (request.getMethod().equals("POST") && request.getParameter("type") != null && request.getParameter("type").equals("HotelChain")) {
        chainName = request.getParameter("chainName");
        centralOfficeAddress = request.getParameter("centralOfficeAddress");
        phoneNumber = Long.parseLong(request.getParameter("phoneNumber"));
        emailAddress = request.getParameter("emailAddress");
        numberOfHotels = Integer.parseInt(request.getParameter("numberOfHotels"));

        try {
            HotelChain.updateChain(chainName, centralOfficeAddress, phoneNumber, emailAddress, numberOfHotels);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("adminPage.jsp");
    }
%>

<%
    if (request.getMethod().equals("POST") && request.getParameter("type") != null && request.getParameter("type").equals("Hotel")) {
        hotelChainName = request.getParameter("chainName");
        hotelAddress = request.getParameter("address");
        hotelPhoneNumber = Long.parseLong(request.getParameter("phoneNumber"));
        hotelEmail = request.getParameter("email");
        hotelRating = Integer.parseInt(request.getParameter("rating"));
        hotelNumberOfRooms = Integer.parseInt(request.getParameter("numberOfRooms"));
        hotelManagerID = Integer.parseInt(request.getParameter("managerID"));

        try {
            Hotel.updateHotel(hotelChainName, hotelAddress, hotelPhoneNumber, hotelEmail, hotelRating, hotelNumberOfRooms, hotelManagerID);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("adminPage.jsp");
    }
%>

<%
    if (request.getMethod().equals("POST") && request.getParameter("type") != null && request.getParameter("type").equals("HotelRoom")) {
        String hotelChain = request.getParameter("hotelChain");
        String address = request.getParameter("address");
        int roomNumber = Integer.parseInt(request.getParameter("roomNumber"));
        String amenities = request.getParameter("amenities");
        float price = Float.parseFloat(request.getParameter("price"));
        String capacity = request.getParameter("capacity");
        String problemsAndDamages = request.getParameter("problemsAndDamages");
        String viewType = request.getParameter("viewType");
        String extensionCapabilities = request.getParameter("extensionCapabilities");
        String status = request.getParameter("status");

        try {
            HotelRoom.updateHotelRoom(hotelChain, address, roomNumber, amenities, price, capacity, problemsAndDamages, viewType, extensionCapabilities, status);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("adminPage.jsp");
    }
%>

<%
    if (request.getMethod().equals("POST") && request.getParameter("type") != null && request.getParameter("type").equals("Employee")) {
        String firstName = request.getParameter("firstName");
        String middleName = request.getParameter("middleName");
        String lastName = request.getParameter("lastName");
        String address = request.getParameter("address");
        int sinSsn = Integer.parseInt(request.getParameter("sinSsn"));
        String jobPosition = request.getParameter("jobPosition");

        try {
            Employee.updateEmployee(firstName, middleName, lastName, address, sinSsn, jobPosition);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("adminPage.jsp");
    }
%>

<%
    if (request.getMethod().equals("POST") && request.getParameter("type") != null && request.getParameter("type").equals("Customer")) {
        String customerID = request.getParameter("customerID");
        String IDType = request.getParameter("IDType");
        String registerDate = request.getParameter("registerDate");
        String firstName = request.getParameter("firstName");
        String middleName = request.getParameter("middleName");
        String lastName = request.getParameter("lastName");
        String address = request.getParameter("address");

        try {
            Customer.updateCustomer(customerID, IDType, registerDate, firstName, middleName, lastName, address);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("adminPage.jsp");
    }
%>

<main style="padding-bottom: 50px">
    <div class="container">
        <div class="row" id="row">
            <div class="col-md-12">
                <div class="card" id="card-container">
                    <div class="card-body" id="card">

                        <form action="adminPage.jsp" method="get">
                            <input class="input-button" type="submit" value="Go Back to Admin Page">
                        </form>

                        <%
                            if ("HotelChain".equals(type)) {
                                chainName = request.getParameter("chainName");
                                centralOfficeAddress = request.getParameter("centralOfficeAddress");
                                phoneNumber = Long.parseLong(request.getParameter("phoneNumber"));
                                emailAddress = request.getParameter("emailAddress");
                                numberOfHotels = Integer.parseInt(request.getParameter("numberOfHotels"));
                        %>
                        <form action="adminPage.jsp" method="post">
                            <label for="chainName">Chain Name:</label><br>
                            <input class="input" type="text" id="chainName" name="chainName" value="<%= chainName %>" readonly><br>
                            <label for="centralOfficeAddress">Central Office Address:</label><br>
                            <input class="input" type="text" id="centralOfficeAddress" name="centralOfficeAddress" value="<%= centralOfficeAddress %>"><br>
                            <label for="phoneNumber">Phone Number:</label><br>
                            <input class="input" type="number" id="phoneNumber" name="phoneNumber" value="<%= phoneNumber %>"><br>
                            <label for="emailAddress">Email Address:</label><br>
                            <input class="input" type="text" id="emailAddress" name="emailAddress" value="<%= emailAddress %>"><br>
                            <label for="numberOfHotels">Number of Hotels:</label><br>
                            <input class="input" type="number" id="numberOfHotels" name="numberOfHotels" value="<%= numberOfHotels %>"><br>
                            <input class="input-button" type="submit" value="Update">
                        </form>



                        <%
                        } else if ("Hotel".equals(type)) {
                            hotelChainName = request.getParameter("chainName");
                            hotelAddress = request.getParameter("address");
                            String hotelPhoneNumberStr = request.getParameter("phoneNumber");
                            if (hotelPhoneNumberStr != null && !hotelPhoneNumberStr.isEmpty()) {
                                hotelPhoneNumber = Long.parseLong(hotelPhoneNumberStr);
                            }
                            hotelEmail = request.getParameter("emailAddress");
                            String hotelRatingStr = request.getParameter("starRating");
                            if (hotelRatingStr != null && !hotelRatingStr.isEmpty()) {
                                hotelRating = Integer.parseInt(hotelRatingStr);
                            }
                            hotelNumberOfRooms = Integer.parseInt(request.getParameter("numberOfRooms"));
                            hotelManagerID = Integer.parseInt(request.getParameter("managerID"));
                        %>
                        <form action="adminPage.jsp" method="post">
                            <label for="hotelChainName">Hotel Chain Name:</label><br>
                            <input class="input" type="text" id="hotelChainName" name="hotelChainName" value="<%= hotelChainName %>"><br>
                            <label for="hotelAddress">Hotel Address:</label><br>
                            <input class="input" type="text" id="hotelAddress" name="hotelAddress" value="<%= hotelAddress %>"><br>
                            <label for="hotelPhoneNumber">Hotel Phone Number:</label><br>
                            <input class="input" type="text" id="hotelPhoneNumber" name="hotelPhoneNumber" value="<%= hotelPhoneNumber %>"><br>
                            <label for="hotelEmail">Hotel Email:</label><br>
                            <input class="input" type="text" id="hotelEmail" name="hotelEmail" value="<%= hotelEmail %>"><br>
                            <label for="hotelRating">Hotel Rating:</label><br>
                            <input class="input" type="number" id="hotelRating" name="hotelRating" value="<%= hotelRating %>"><br>
                            <label for="hotelNumberOfRooms">Number of Rooms:</label><br>
                            <input class="input" type="number" id="hotelNumberOfRooms" name="hotelNumberOfRooms" value="<%= hotelNumberOfRooms %>"><br>
                            <label for="hotelManagerID">Manager ID:</label><br>
                            <input class="input" type="number" id="hotelManagerID" name="hotelManagerID" value="<%= hotelManagerID %>"><br>
                            <input class="input-button" type="submit" value="Update">
                        </form>



                        <%
                        } else if ("HotelRoom".equals(type)) {
                            String hotelChain = request.getParameter("hotelChain");
                            String address = request.getParameter("address");
                            int roomNumber = Integer.parseInt(request.getParameter("roomNumber"));
                            String amenities = request.getParameter("amenities");
                            float price = Float.parseFloat(request.getParameter("price"));
                            String capacity = request.getParameter("capacity");
                            String problemsAndDamages = request.getParameter("problemsAndDamages");
                            String viewType = request.getParameter("viewType");
                            String extensionCapabilities = request.getParameter("extensionCapabilities");
                            String status = request.getParameter("status");
                        %>
                        <form action="adminPage.jsp" method="post">
                            <label for="hotelChain">Hotel Chain:</label><br>
                            <input class="input" type="text" id="hotelChain" name="hotelChain" value="<%= hotelChain %>"><br>
                            <label for="address">Address:</label><br>
                            <input class="input" type="text" id="hotelRoomAddress" name="address" value="<%= address %>"><br>
                            <label for="roomNumber">Room Number:</label><br>
                            <input class="input" type="number" id="roomNumber" name="roomNumber" value="<%= roomNumber %>"><br>
                            <label for="amenities">Amenities:</label><br>
                            <input class="input" type="text" id="amenities" name="amenities" value="<%= amenities %>"><br>
                            <label for="price">Price:</label><br>
                            <input class="input" type="number" step="0.01" id="price" name="price" value="<%= price %>"><br>
                            <label for="capacity">Capacity:</label><br>
                            <input class="input" type="text" id="capacity" name="capacity" value="<%= capacity %>"><br>
                            <label for="problemsAndDamages">Problems and Damages:</label><br>
                            <input class="input" type="text" id="problemsAndDamages" name="problemsAndDamages" value="<%= problemsAndDamages %>"><br>
                            <label for="viewType">View Type:</label><br>
                            <input class="input" type="text" id="viewType" name="viewType" value="<%= viewType %>"><br>
                            <label for="extensionCapabilities">Extension Capabilities:</label><br>
                            <input class="input" type="text" id="extensionCapabilities" name="extensionCapabilities" value="<%= extensionCapabilities %>"><br>
                            <label for="status">Status:</label><br>
                            <input class="input" type="text" id="status" name="status" value="<%= status %>"><br>
                            <input class="input-button" type="submit" value="Update">
                        </form>



                        <%
                        } else if ("Employee".equals(type)) {
                            String firstName = request.getParameter("firstName");
                            String middleName = request.getParameter("middleName");
                            String lastName = request.getParameter("lastName");
                            String address = request.getParameter("address");
                            int sinSsn = Integer.parseInt(request.getParameter("sinSsn"));
                            String jobPosition = request.getParameter("jobPosition");
                        %>
                        <form action="adminPage.jsp" method="post">
                            <label for="firstName">First Name:</label><br>
                            <input class="input" type="text" id="firstName" name="firstName" value="<%= firstName %>"><br>
                            <label for="middleName">Middle Name:</label><br>
                            <input class="input" type="text" id="middleName" name="middleName" value="<%= middleName %>"><br>
                            <label for="lastName">Last Name:</label><br>
                            <input class="input" type="text" id="lastName" name="lastName" value="<%= lastName %>"><br>
                            <label for="address">Address:</label><br>
                            <input class="input" type="text" id="address" name="address" value="<%= address %>"><br>
                            <label for="sinSsn">SIN/SSN:</label><br>
                            <input class="input" type="number" id="sinSsn" name="sinSsn" value="<%= sinSsn %>"><br>
                            <label for="jobPosition">Job Position:</label><br>
                            <input class="input" type="text" id="jobPosition" name="jobPosition" value="<%= jobPosition %>"><br>
                            <input class="input-button" type="submit" value="Update">
                        </form>



                        <%
                        } else if ("Customer".equals(type)) {
                            String customerID = request.getParameter("customerID");
                            String IDType = request.getParameter("IDType");
                            String registerDate = request.getParameter("registerDate");
                            String firstName = request.getParameter("firstName");
                            String middleName = request.getParameter("middleName");
                            String lastName = request.getParameter("lastName");
                            String address = request.getParameter("address");
                        %>
                        <form action="adminPage.jsp" method="post">
                            <label for="customerID">Customer ID:</label><br>
                            <input class="input" type="text" id="customerID" name="customerID" value="<%= customerID %>"><br>
                            <label for="IDType">ID Type:</label><br>
                            <input class="input" type="text" id="IDType" name="IDType" value="<%= IDType %>"><br>
                            <label for="registerDate">Register Date:</label><br>
                            <input class="input" type="date" id="registerDate" name="registerDate" value="<%= registerDate %>"><br>
                            <label for="firstName">First Name:</label><br>
                            <input class="input" type="text" id="customerFirstName" name="firstName" value="<%= firstName %>"><br>
                            <label for="middleName">Middle Name:</label><br>
                            <input class="input" type="text" id="customerMiddleName" name="middleName" value="<%= middleName %>"><br>
                            <label for="lastName">Last Name:</label><br>
                            <input class="input" type="text" id="customerLastName" name="lastName" value="<%= lastName %>"><br>
                            <label for="address">Address:</label><br>
                            <input class="input" type="text" id="customerAddress" name="address" value="<%= address %>"><br>
                            <input class="input-button" type="submit" value="Update">
                        </form>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>

</main>

<footer style=background-color:#0b1021;>
    <a href="adminLogin.jsp" style="color: white;">Admin? Login here</a>
</footer>
</body>

</html>
