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
            background-color: white;
        }
        .edit-update-button {
            font-size: 20px;
            border-radius: 5px;
            font-family: Gilroy-Light, sans-serif;
            padding: 10px;
            text-align: center;
            border: 1px solid black;
            background-color: lightgrey;
        }
        .delete-button {
            font-size: 20px;
            border-radius: 5px;
            font-family: Gilroy-Light, sans-serif;
            padding: 10px;
            text-align: center;
            border: 1px solid black;
            background-color: #FF6961;
            color: white;
        }
        .table-insert-input {
            font-family: Gilroy-Light, sans-serif;
            font-size: 18px; /* 16px -> default font size */
            padding: 10px;
            text-align: left;
            border: 1px solid black;
            margin: 10px;
            border-radius: 5px;
            box-sizing: border-box;
            background-color: lightgrey;
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
<%@ page import="com.DatabaseProjectWebsite.Tables.HotelChain" %>
<%@ page import="com.DatabaseProjectWebsite.Tables.Hotel" %>
<%@ page import="com.DatabaseProjectWebsite.Tables.HotelRoom" %>
<%@ page import="com.DatabaseProjectWebsite.Tables.Employee" %>
<%@ page import="com.DatabaseProjectWebsite.Tables.Customer" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="org.json.JSONArray" %>

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

<%
    if (request.getMethod().equals("POST") && request.getParameter("type") != null && request.getParameter("type").equals("HotelChain")) {
        String chainName = request.getParameter("chainName");
        String centralOfficeAddress = request.getParameter("centralOfficeAddress");
        long phoneNumber = Long.parseLong(request.getParameter("phoneNumber")); // Change this line
        String emailAddress = request.getParameter("emailAddress");
        int numberOfHotels = Integer.parseInt(request.getParameter("numberOfHotels"));

        try {
            HotelChain.insertHotelChain(chainName, centralOfficeAddress, phoneNumber, emailAddress, numberOfHotels);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("adminPage.jsp");
    }
%>

<%
    if (request.getMethod().equals("POST") && request.getParameter("type") != null && request.getParameter("type").equals("Hotel")) {
        String chainName = request.getParameter("chainName");
        String address = request.getParameter("address");
        long phoneNumber = Long.parseLong(request.getParameter("phoneNumber"));
        String emailAddress = request.getParameter("emailAddress");
        int starRating = Integer.parseInt(request.getParameter("starRating"));
        int numberOfRooms = Integer.parseInt(request.getParameter("numberOfRooms"));
        int managerID = Integer.parseInt(request.getParameter("managerID"));

        try {
            Hotel.insertHotel(chainName, address, phoneNumber, emailAddress, starRating, numberOfRooms, managerID);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("adminPage.jsp");
    }
%>

<%
    if (request.getMethod().equals("POST") && request.getParameter("type") != null && request.getParameter("type").equals("HotelRoom")) {
        String address = request.getParameter("address");
        int roomNumber = Integer.parseInt(request.getParameter("roomNumber"));
        String amenities = request.getParameter("amenities");
        double price = Double.parseDouble(request.getParameter("price"));
        String capacity = request.getParameter("capacity");
        String problemsAndDamages = request.getParameter("problemsAndDamages");
        String viewType = request.getParameter("viewType");
        String extensionCapabilities = request.getParameter("extensionCapabilities");
        String status = request.getParameter("status");

        try {
            HotelRoom.insertHotelRoom(address, roomNumber, amenities, price, capacity, problemsAndDamages, viewType, extensionCapabilities, status);
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
        long sinSsn = Long.parseLong(request.getParameter("sinSsn"));
        String jobPosition = request.getParameter("jobPosition");

        try {
            Employee.insertEmployee(firstName, middleName, lastName, address, sinSsn, jobPosition);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("adminPage.jsp");
    }
%>

<%
    String action = request.getParameter("action");
    String type = request.getParameter("type");
    String chainName = request.getParameter("chainName");

    if ("delete".equals(action) && "HotelChain".equals(type) && chainName != null) {
        try {
            HotelChain.deleteHotelChain(chainName);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("adminPage.jsp");
    }
%>

<%
    action = request.getParameter("action");
    type = request.getParameter("type");
    String address = request.getParameter("hotelID");

    if ("delete".equals(action) && "Hotel".equals(type) && address != null) {
        try {
            System.out.println(address);
            Hotel.deleteHotel(address);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("adminPage.jsp");
    }
%>

<%
    action = request.getParameter("action");
    type = request.getParameter("type");
    address = request.getParameter("address");
    String roomNumberStr = request.getParameter("roomNumber");
    int roomNumber = 0;
    if (roomNumberStr != null && !roomNumberStr.isEmpty()) {
        roomNumber = Integer.parseInt(roomNumberStr);
    }

    if ("delete".equals(action) && "HotelRoom".equals(type) && address != null && roomNumber != 0) {
        try {
            System.out.println(address + "" + roomNumber);
            HotelRoom.deleteHotelRoom(address, roomNumber);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("adminPage.jsp");
    }
%>

<%
    action = request.getParameter("action");
    type = request.getParameter("type");

    String sinSsnStr = request.getParameter("sinSsn");
    long sinSsn = 0;
    if (sinSsnStr != null && !sinSsnStr.isEmpty()) {
        sinSsn = Long.parseLong(sinSsnStr);
    }

    if ("delete".equals(action) && "Employee".equals(type) && sinSsn != 0) {
        try {
            Employee.deleteEmployee(sinSsn);
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
                            <% if (chains == null || chains.size() == 0) { %>
                            <h1 style="margin-top: 5rem;">No Hotel Chains found!</h1>
                            <% } else { %>

                            <!-- First table -->
                            <h2>Hotel chains</h2>
                            <div>
                                <table class="table center-table">
                                    <thead>
                                    <tr>
                                        <th class="table-header">Chain Name</th>
                                        <th class="table-header">Central Office Address</th>
                                        <th class="table-header">Contact Phone Number</th>
                                        <th class="table-header">Contact Email</th>
                                        <th class="table-header">Number of Hotels</th>
                                        <th class="table-header">Edit/Update</th>
                                        <th class="table-header">Delete</th>
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
                                        <td class="table-data">
                                            <a href="editUpdateEntry.jsp?type=HotelChain&chainName=<%= URLEncoder.encode(hc.getChainName(), "UTF-8") %>&centralOfficeAddress=<%= URLEncoder.encode(hc.getCentralOfficeAddress(), "UTF-8") %>&phoneNumber=<%= URLEncoder.encode(String.valueOf(hc.getPhoneNumber()), "UTF-8") %>&emailAddress=<%= URLEncoder.encode(String.valueOf(hc.getEmailAddress()), "UTF-8") %>&numberOfHotels=<%= URLEncoder.encode(String.valueOf(hc.getNumberOfHotels()), "UTF-8") %>">
                                                <button type="button" class="edit-update-button">Edit/update entry</button>
                                            </a>
                                        </td>
                                        <td class="table-data">
                                            <a href="adminPage.jsp?action=delete&type=HotelChain&chainName=<%= URLEncoder.encode(hc.getChainName(), "UTF-8") %>">
                                                <button type="button" class="delete-button">Delete entry</button>
                                            </a>
                                        </td>
                                    </tr>
                                    <% } %>
                                    <tr>
                                        <form action="adminPage.jsp" method="post">
                                            <td class="table-data"><input class="table-insert-input" type="text" name="chainName" required></td>
                                            <td class="table-data"><input class="table-insert-input" type="text" name="centralOfficeAddress" required></td>
                                            <td class="table-data"><input class="table-insert-input" type="number" name="phoneNumber" required></td>
                                            <td class="table-data"><input class="table-insert-input" type="email" name="emailAddress" required></td>
                                            <td class="table-data"><input class="table-insert-input" type="number" name="numberOfHotels" required></td>
                                            <td class="table-data">
                                                <input type="hidden" name="type" value="HotelChain">
                                                <input type="submit" value="Insert new entry" class="edit-update-button">
                                            </td>
                                            <td class="table-data"></td>
                                        </form>
                                    </tr>
                                </table>
                            </div>



                            <!-- Second table -->
                            <h2 style="margin-top: 50px;">Hotels</h2>
                            <div>
                                <table class="table center-table">
                                    <thead>
                                    <tr>
                                        <th class="table-header">Chain name</th>
                                        <th class="table-header">Address</th>
                                        <th class="table-header">Phone number</th>
                                        <th class="table-header">Email address</th>
                                        <th class="table-header">Star rating</th>
                                        <th class="table-header">Total number of rooms</th>
                                        <th class="table-header">Manager ID</th>
                                        <th class="table-header">Edit/Update</th>
                                        <th class="table-header">Delete</th>
                                    </tr>
                                    </thead>
                                    <%
                                        for (Hotel h : hotels) { %>
                                    <tr>
                                        <td class="table-data"><%= h.getChainName() %></td>
                                        <td class="table-data"><%= h.getAddress() %></td>
                                        <td class="table-data"><%= h.getPhoneNumber() %></td>
                                        <td class="table-data"><%= h.getEmailAddress() %></td>
                                        <td class="table-data"><%= h.getStarRating() %></td>
                                        <td class="table-data"><%= h.getNumberOfRooms() %></td>
                                        <td class="table-data"><%= h.getManagerID() %></td>
                                        <td class="table-data">
                                            <a href="editUpdateEntry.jsp?type=Hotel&chainName=<%= URLEncoder.encode(h.getChainName(), "UTF-8") %>&address=<%= URLEncoder.encode(h.getAddress(), "UTF-8") %>&phoneNumber=<%= URLEncoder.encode(String.valueOf(h.getPhoneNumber()), "UTF-8") %>&emailAddress=<%= URLEncoder.encode(String.valueOf(h.getEmailAddress()), "UTF-8") %>&starRating=<%= URLEncoder.encode(String.valueOf(h.getStarRating()), "UTF-8") %>&numberOfRooms=<%= URLEncoder.encode(String.valueOf(h.getNumberOfRooms()), "UTF-8") %>&managerID=<%= URLEncoder.encode(String.valueOf(h.getManagerID()), "UTF-8") %>">
                                                <button type="button" class="edit-update-button">Edit/update entry</button>
                                            </a>
                                        </td>
                                        <td class="table-data">
                                            <a href="adminPage.jsp?action=delete&type=Hotel&hotelID=<%= URLEncoder.encode(h.getAddress(), "UTF-8") %>">
                                                <button type="button" class="delete-button">Delete entry</button>
                                            </a>
                                        </td>
                                    </tr>
                                    <% } %>
                                    <tr>
                                        <form action="adminPage.jsp" method="post">
                                            <td class="table-data">
                                                <select class="table-insert-input" name="chainName" required>
                                                    <% for (HotelChain hc : chains) { %>
                                                    <option value="<%= hc.getChainName() %>"><%= hc.getChainName() %></option>
                                                    <% } %>
                                                </select>
                                            </td>
                                            <td class="table-data"><input class="table-insert-input" type="text" name="address" required></td>
                                            <td class="table-data"><input class="table-insert-input" type="number" name="phoneNumber" required></td>
                                            <td class="table-data"><input class="table-insert-input" type="email" name="emailAddress" required></td>
                                            <td class="table-data">
                                                <select class="table-insert-input" name="starRating" required>
                                                    <option value="1">1/5</option>
                                                    <option value="2">2/5</option>
                                                    <option value="3">3/5</option>
                                                    <option value="4">4/5</option>
                                                    <option value="5">5/5</option>
                                                </select>
                                            </td>
                                            <td class="table-data"><input class="table-insert-input" type="number" name="numberOfRooms" required></td>
                                            <td class="table-data"><input class="table-insert-input" type="number" name="managerID" required></td>
                                            <td class="table-data">
                                                <input type="hidden" name="type" value="Hotel">
                                                <input type="submit" value="Insert new entry" class="edit-update-button">
                                            </td>
                                            <td class="table-data"></td>
                                        </form>
                                    </tr>
                                </table>
                            </div>



                            <!-- Third table -->
                            <h2 style="margin-top: 50px;">Hotel rooms</h2>
                            <div>
                                <table class="table center-table">
                                    <thead>
                                    <tr>
                                        <th class="table-header">Hotel chain</th>
                                        <th class="table-header">Address</th>
                                        <th class="table-header">Room number</th>
                                        <th class="table-header">Amenities</th>
                                        <th class="table-header">Price</th>
                                        <th class="table-header">Capacity</th>
                                        <th class="table-header">Problems and damages</th>
                                        <th class="table-header">View type</th>
                                        <th class="table-header">Extension capabilities</th>
                                        <th class="table-header">Status</th>
                                        <th class="table-header">Edit/Update</th>
                                        <th class="table-header">Delete</th>
                                    </tr>
                                    </thead>
                                    <%
                                        for (HotelRoom r : rooms) { %>
                                    <tr>
                                        <td class="table-data"><%= r.getHotelChain()%></td>
                                        <td class="table-data"><%= r.getAddress() %></td>
                                        <td class="table-data"><%= r.getRoomNumber() %></td>
                                        <td class="table-data"><%= r.getAmenities() %></td>
                                        <td class="table-data"><%= r.getPrice() %></td>
                                        <td class="table-data">
                                            <%= r.getCapacity() %>
                                            <%
                                                switch(r.getCapacity()) {
                                                    case "Single":
                                                        out.print(" (1)");
                                                        break;
                                                    case "Double":
                                                        out.print(" (2)");
                                                        break;
                                                    case "Triple":
                                                        out.print(" (3)");
                                                        break;
                                                    case "Quadruple":
                                                        out.print(" (4)");
                                                        break;
                                                    case "Suite":
                                                        out.print(" (5+)");
                                                        break;
                                                }
                                            %>
                                        </td>
                                        <td class="table-data"><%= r.getProblemsAndDamages() == null ? "None" : r.getProblemsAndDamages() %></td>
                                        <td class="table-data" style="color:<%= r.getViewType().equalsIgnoreCase("Sea") ? "blue" : (r.getViewType().equalsIgnoreCase("Mountain") ? "green" : "black") %>;"><%= r.getViewType() %></td>
                                        <td class="table-data"><%= r.getExtensionCapabilities() %></td>
                                        <td class="table-data" style="color:<%= r.getStatus().equalsIgnoreCase("available") ? "green" : (r.getStatus().equalsIgnoreCase("booked") ? "#f2ba10" : "red") %>;"><%= r.getStatus() %></td>
                                        <td class="table-data">
                                            <a href="editUpdateEntry.jsp?type=HotelRoom&hotelChain=<%= URLEncoder.encode(r.getHotelChain(), "UTF-8") %>&address=<%= URLEncoder.encode(r.getAddress(), "UTF-8") %>&roomNumber=<%= URLEncoder.encode(String.valueOf(r.getRoomNumber()), "UTF-8") %>&amenities=<%= URLEncoder.encode(String.valueOf(r.getAmenities()), "UTF-8") %>&price=<%= URLEncoder.encode(String.valueOf(r.getPrice()), "UTF-8") %>&capacity=<%= URLEncoder.encode(String.valueOf(r.getCapacity()), "UTF-8") %>&problemsAndDamages=<%= URLEncoder.encode(String.valueOf(r.getProblemsAndDamages()), "UTF-8") %>&viewType=<%= URLEncoder.encode(String.valueOf(r.getViewType()), "UTF-8") %>&extensionCapabilities=<%= URLEncoder.encode(String.valueOf(r.getExtensionCapabilities()), "UTF-8") %>&status=<%= URLEncoder.encode(String.valueOf(r.getStatus()), "UTF-8") %>">
                                                <button type="button" class="edit-update-button">Edit/update entry</button>
                                            </a>
                                        </td>
                                        <td class="table-data">
                                            <a href="adminPage.jsp?action=delete&type=HotelRoom&address=<%= URLEncoder.encode(r.getAddress(), "UTF-8")%>&roomNumber=<%= URLEncoder.encode(String.valueOf(r.getRoomNumber()), "UTF-8") %>">
                                                <button type="button" class="delete-button">Delete entry</button>
                                            </a>
                                        </td>
                                    </tr>
                                    <% } %>
                                    <tr>
                                        <form action="adminPage.jsp" method="post">
                                            <td class="table-data">
                                                <select class="table-insert-input" name="chainNameTable3" required>
                                                    <% for (HotelChain hc : chains) { %>
                                                    <option value="<%= hc.getChainName() %>"><%= hc.getChainName() %></option>
                                                    <% } %>
                                                </select>
                                            </td>
                                            <td class="table-data">
                                                <select class="table-insert-input" name="address" id="address" required>
                                                    <% for (Hotel h : hotels) { %>
                                                    <option value="<%= h.getAddress() %>"><%= h.getAddress() %></option>
                                                    <% } %>
                                                </select>
                                            </td>
                                            <td class="table-data"><input class="table-insert-input" type="number" name="roomNumber" required></td>
                                            <td class="table-data"><input class="table-insert-input" type="text" name="amenities" required></td>
                                            <td class="table-data"><input class="table-insert-input" type="number" name="price" required></td>
                                            <td class="table-data">
                                                <select class="table-insert-input" name="capacity" required>
                                                    <option value="Single">Single (1)</option>
                                                    <option value="Double">Double (2)</option>
                                                    <option value="Triple">Triple (3)</option>
                                                    <option value="Quadruple">Quadruple (4)</option>
                                                    <option value="Suite">Suite (5+)</option>
                                                </select>
                                            </td>
                                            <td class="table-data"><input class="table-insert-input" type="text" name="problemsAndDamages" required></td>
                                            <td class="table-data">
                                                <select class="table-insert-input" name="viewType" required>
                                                    <option style="color: green;" value="Mountain">Mountain</option>
                                                    <option style="color: blue;" value="Sea">Sea</option>
                                                </select>
                                            </td>
                                            <td class="table-data">
                                                <select class="table-insert-input" name="extensionCapabilities" required>
                                                    <option value="Possible">Possible</option>
                                                    <option value="Not possible">Not possible</option>
                                                </select>
                                            </td>
                                            <td class="table-data">
                                                <select class="table-insert-input" name="status" required>
                                                    <option style="color: green;" value="available">available</option>
                                                    <option style="color: #f2ba10;" value="booked">booked</option>
                                                    <option style="color: red;" value="rented">rented</option>
                                                </select>
                                            </td>
                                            <td class="table-data">
                                                <input type="hidden" name="type" value="HotelRoom">
                                                <input type="submit" value="Insert new entry" class="edit-update-button">
                                            </td>
                                            <td class="table-data"></td>
                                        </form>
                                    </tr>
                                </table>
                            </div>



                            <!-- Fourth table -->
                            <h2 style="margin-top: 50px;">Employees</h2>
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
                                        <th class="table-header">Edit/Update</th>
                                        <th class="table-header">Delete</th>
                                    </tr>
                                    </thead>
                                    <%
                                        for (Employee e : employees) { %>
                                    <tr>
                                        <td class="table-data"><%= e.getFirstName() %></td>
                                        <td class="table-data"><%= e.getMiddleName() %></td>
                                        <td class="table-data"><%= e.getLastName() %></td>
                                        <td class="table-data"><%= e.getAddress() %></td>
                                        <td class="table-data"><%= e.getSinSsn() %></td>
                                        <td class="table-data"><%= e.getJobPosition() %></td>
                                        <td class="table-data">
                                            <a href="editUpdateEntry.jsp?type=Employee&firstName=<%= URLEncoder.encode(e.getFirstName(), "UTF-8") %>&middleName=<%= URLEncoder.encode(e.getMiddleName(), "UTF-8") %>&lastName=<%= URLEncoder.encode(e.getLastName(), "UTF-8") %>&address=<%= URLEncoder.encode(e.getAddress(), "UTF-8") %>&sinSsn=<%= URLEncoder.encode(String.valueOf(e.getSinSsn()), "UTF-8") %>&jobPosition=<%= URLEncoder.encode(e.getJobPosition(), "UTF-8") %>">
                                                <button type="button" class="edit-update-button">Edit/update entry</button>
                                            </a>
                                        </td>
                                        <td class="table-data">
                                            <a href="adminPage.jsp?action=delete&type=Employee&sinSsn=<%= URLEncoder.encode(String.valueOf(e.getSinSsn()), "UTF-8") %>">
                                                <button type="button" class="delete-button">Delete entry</button>
                                            </a>
                                        </td>
                                    </tr>
                                    <% } %>
                                    <tr>
                                        <form action="adminPage.jsp" method="post">
                                            <td class="table-data"><input class="table-insert-input" type="text" name="firstName" required></td>
                                            <td class="table-data"><input class="table-insert-input" type="text" name="middleName" required></td>
                                            <td class="table-data"><input class="table-insert-input" type="text" name="lastName" required></td>
                                            <td class="table-data">
                                                <select class="table-insert-input" name="address" required>
                                                    <% for (HotelChain hc : chains) { %>
                                                    <option value="<%= hc.getCentralOfficeAddress() %>"><%= hc.getCentralOfficeAddress() %></option>
                                                    <% } %>
                                                    <% for (Hotel h : hotels) { %>
                                                    <option value="<%= h.getAddress() %>"><%= h.getAddress() %></option>
                                                    <% } %>
                                                </select>
                                            </td>
                                            <td class="table-data"><input class="table-insert-input" type="number" name="sinSsn" required></td>
                                            <td class="table-data"><input class="table-insert-input" type="text" name="jobPosition" required></td>
                                            <td class="table-data">
                                                <input type="hidden" name="type" value="Employee">
                                                <input type="submit" value="Insert new entry" class="edit-update-button">
                                            </td>
                                            <td class="table-data"></td>
                                        </form>
                                    </tr>
                                </table>
                            </div>



                            <!-- Fifth table -->
                            <h2 style="margin-top: 50px;">Customers</h2>
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
                                        <th class="table-header">Edit/Update</th>
                                        <th class="table-header">Delete</th>
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
                                        <td class="table-data">
                                            <a href="editUpdateEntry.jsp?type=Customer&customerID=<%= URLEncoder.encode(String.valueOf(c.getCustomerID()), "UTF-8") %>&IDType=<%= URLEncoder.encode(c.getIDType(), "UTF-8") %>&registerDate=<%= URLEncoder.encode(String.valueOf(c.getRegisterDate()), "UTF-8") %>&firstName=<%= URLEncoder.encode(c.getFirstName(), "UTF-8") %>&middleName=<%= URLEncoder.encode(c.getMiddleName(), "UTF-8") %>&lastName=<%= URLEncoder.encode(c.getLastName(), "UTF-8") %>&address=<%= URLEncoder.encode(c.getAddress(), "UTF-8") %>">
                                                <button type="button" class="edit-update-button">Edit/update entry</button>
                                            </a>
                                        </td>
                                        <td class="table-data">
                                            <a href="adminPage.jsp?type=Customer&customerID=<%= URLEncoder.encode(String.valueOf(c.getCustomerID()), "UTF-8") %>&IDType=<%= URLEncoder.encode(c.getIDType(), "UTF-8") %>&registerDate=<%= URLEncoder.encode(String.valueOf(c.getRegisterDate()), "UTF-8") %>&firstName=<%= URLEncoder.encode(c.getFirstName(), "UTF-8") %>&middleName=<%= URLEncoder.encode(c.getMiddleName(), "UTF-8") %>&lastName=<%= URLEncoder.encode(c.getLastName(), "UTF-8") %>&address=<%= URLEncoder.encode(c.getAddress(), "UTF-8") %>">
                                                <button type="button" class="delete-button">Delete entry</button>
                                            </a>
                                        </td>
                                    </tr>
                                    <% } %>
                                    <tr>
                                        <form action="adminPage.jsp" method="post">
                                            <td class="table-data"><input class="table-insert-input" type="number" name="customerID" required></td>
                                            <td class="table-data"><input class="table-insert-input" type="text" name="IDType" required></td>
                                            <td class="table-data"><input class="table-insert-input" type="date" name="registerDate" required></td>
                                            <td class="table-data"><input class="table-insert-input" type="text" name="firstName" required></td>
                                            <td class="table-data"><input class="table-insert-input" type="text" name="middleName" required></td>
                                            <td class="table-data"><input class="table-insert-input" type="text" name="lastName" required></td>
                                            <td class="table-data"><input class="table-insert-input" type="text" name="address" required></td>
                                            <td class="table-data">
                                                <input type="hidden" name="type" value="Customer">
                                                <input type="submit" value="Insert new entry" class="edit-update-button">
                                            </td>
                                            <td class="table-data"></td>
                                        </form>
                                    </tr>
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