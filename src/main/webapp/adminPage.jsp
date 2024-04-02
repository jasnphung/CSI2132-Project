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
</nav>

<%@ page import="java.util.List" %>
<%@ page import="com.DatabaseProjectWebsite.Tables.HotelChain" %>
<%@ page import="com.DatabaseProjectWebsite.Tables.Hotel" %>
<%@ page import="com.DatabaseProjectWebsite.Tables.HotelRoom" %>
<%@ page import="com.DatabaseProjectWebsite.Tables.Employee" %>
<%@ page import="com.DatabaseProjectWebsite.Tables.Customer" %>
<%@ page import="java.util.ArrayList" %>
<%

    // get all hotel chains from database
    List<HotelChain> chains = null;
    try {
        chains = HotelChain.getAllHotelChains();
    } catch (Exception e) {
        e.printStackTrace();
    }

    // get all hotels from database
    List<Hotel> hotels = null;
    try {
        hotels = Hotel.getAllHotels();
    } catch (Exception e) {
        e.printStackTrace();
    }

    List<HotelRoom> rooms = null;
    try {
        rooms = HotelRoom.getAllHotelRooms();
    } catch (Exception e) {
        e.printStackTrace();
    }

    List<Employee> employees = null;
    try {
        employees = Employee.getAllEmployees();
    } catch (Exception e) {
        e.printStackTrace();
    }

    List<Customer> customers = null;
    try {
        customers = Customer.getAllCustomers();
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
                            <% if (chains == null || chains.size() == 0) { %>
                            <h1 style="margin-top: 5rem;">No Hotel Chains found!</h1>
                            <% } else { %>

                            <h2>Hotel chains</h2>

                            <!-- First table -->
                            <div>
                                <table class="table center-table">
                                    <thead>
                                    <tr>
                                        <th class="table-header">Chain Name</th>
                                        <th class="table-header">Central Office Address</th>
                                        <th class="table-header">Contact Phone Number</th>
                                        <th class="table-header">Contact Email</th>
                                        <th class="table-header">Number of Hotels</th>
                                    </tr>
                                    </thead>
                                    <%
                                        for (HotelChain hc : chains) { %>
                                    <tr>
                                        <td class="table-data"><%= hc.getChainName() %></td>
                                        <td class="table-data"><%= hc.getCentralOfficeAddress() %></td>
                                        <td class="table-data"><%= hc.getPhoneNumber() %></td>
                                        <td class="table-data"><%= hc.getEmailAddress() %></td>
                                        <td class="table-data"><%= hc.getNumberOfHotels() %></td>
                                    </tr>
                                    <% } %>
                                </table>
                            </div>

                            <h2 style="margin-top: 50px;">Hotels</h2>

                            <!-- Second table -->
                            <div>
                                <table class="table center-table">
                                    <thead>
                                    <tr>
                                        <th class="table-header">Address</th>
                                        <th class="table-header">Phone number</th>
                                        <th class="table-header">Email address</th>
                                        <th class="table-header">Star rating</th>
                                        <th class="table-header">Total number of rooms</th>
                                        <th class="table-header">Chain name</th>
                                        <th class="table-header">Manager ID</th>
                                    </tr>
                                    </thead>
                                    <%
                                        for (Hotel h : hotels) { %>
                                    <tr>
                                        <td class="table-data"><%= h.getAddress() %></td>
                                        <td class="table-data"><%= h.getPhoneNumber() %></td>
                                        <td class="table-data"><%= h.getEmailAddress() %></td>
                                        <td class="table-data"><%= h.getStarRating() %></td>
                                        <td class="table-data"><%= h.getNumberOfRooms() %></td>
                                        <td class="table-data"><%= h.getChainName() %></td>
                                        <td class="table-data"><%= h.getManagerID() %></td>
                                    </tr>
                                    <% } %>
                                </table>
                            </div>

                            <h2 style="margin-top: 50px;">Hotel rooms</h2>

                            <!-- Third table -->
                            <div>
                                <table class="table center-table">
                                    <thead>
                                    <tr>
                                        <th class="table-header">Address</th>
                                        <th class="table-header">Room number</th>
                                        <th class="table-header">Amenities</th>
                                        <th class="table-header">Price</th>
                                        <th class="table-header">Capacity</th>
                                        <th class="table-header">Problems and damages</th>
                                        <th class="table-header">View type</th>
                                        <th class="table-header">Extension capabilities</th>
                                        <th class="table-header">Status</th>
                                    </tr>
                                    </thead>
                                    <%
                                        for (HotelRoom r : rooms) { %>
                                    <tr>
                                        <td class="table-data"><%= r.getAddress() %></td>
                                        <td class="table-data"><%= r.getRoomNumber() %></td>
                                        <td class="table-data"><%= r.getAmenities() %></td>
                                        <td class="table-data"><%= r.getPrice() %></td>
                                        <td class="table-data"><%= r.getCapacity() %></td>
                                        <td class="table-data"><%= r.getProblemsAndDamages() %></td>
                                        <td class="table-data"><%= r.getViewType() %></td>
                                        <td class="table-data"><%= r.getExtensionCapabilities() %></td>
                                        <td class="table-data" style="color:<%= r.getStatus().equalsIgnoreCase("available") ? "green" : (r.getStatus().equalsIgnoreCase("booked") ? "yellow" : "red") %>;"><%= r.getStatus() %></td>                                    </tr>
                                    <% } %>
                                </table>
                            </div>

                            <h2 style="margin-top: 50px;">Employees</h2>

                            <!-- Fourth table -->
                            <div>
                                <table class="table center-table">
                                    <thead>
                                    <tr>
                                        <th class="table-header">First name</th>
                                        <th class="table-header">Middle name</th>
                                        <th class="table-header">Last name</th>
                                        <th class="table-header">Work address</th>
                                        <th class="table-header">SIN/SSN number</th>
                                        <th class="table-header">Job position</th>
                                    </tr>
                                    </thead>
                                    <%
                                        for (Employee e : employees) { %>
                                    <tr>
                                        <td class="table-data"><%= e.getFirstName() %></td>
                                        <td class="table-data"><%= e.getMiddleName() %></td>
                                        <td class="table-data"><%= e.getLastName() %></td>
                                        <td class="table-data"><%= e.getAddress() %></td>
                                        <td class="table-data"><%= e.getSin_ssn() %></td>
                                        <td class="table-data"><%= e.getJobPosition() %></td>
                                    </tr>
                                    <% } %>
                                </table>
                            </div>

                            <h2 style="margin-top: 50px;">Customers</h2>

                            <!-- Fifth table -->
                            <div>
                                <table class="table center-table">
                                    <thead>
                                    <tr>
                                        <th class="table-header">Customer ID</th>
                                        <th class="table-header">ID type</th>
                                        <th class="table-header">Register date</th>
                                        <th class="table-header">First name</th>
                                        <th class="table-header">Middle name</th>
                                        <th class="table-header">Last name</th>
                                        <th class="table-header">Address</th>
                                    </tr>
                                    </thead>
                                    <%
                                        for (Customer c : customers) { %>
                                    <tr>
                                        <td class="table-data"><%= c.getCustomerID() %></td>
                                        <td class="table-data"><%= c.getIDType() %></td>
                                        <td class="table-data"><%= c.getRegisterDate() %></td>
                                        <td class="table-data"><%= c.getFirstName() %></td>
                                        <td class="table-data"><%= c.getMiddleName() %></td>
                                        <td class="table-data"><%= c.getLastName() %></td>
                                        <td class="table-data"><%= c.getAddress() %></td>
                                    </tr>
                                    <% } %>
                                </table>
                            </div>
                            <% } %>
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