<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
            background: rgb(255, 255, 255);
            background: linear-gradient(180deg, rgba(255, 255, 255, 1) 0%, rgba(136, 136, 136, 1) 100%);
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

        .book-room-button {
            font-size: 20px;
            border-radius: 5px;
            font-family: Gilroy-Light, sans-serif;
            padding: 10px;
            text-align: center;
            border: 1px solid black;
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
    <a href="Indexes.jsp">Indexes</a>
</nav>

<%@ page import="java.util.List" %>
<%@ page import="com.DatabaseProjectWebsite.Tables.Hotel" %>
<%@ page import="com.DatabaseProjectWebsite.Tables.HotelRoom" %>
<%@ page import="com.DatabaseProjectWebsite.Tables.SearchResult" %>
<%@ page import="java.util.ArrayList" %>
<%
    String area = request.getParameter("location");
    int numberOfGuests = Integer.parseInt(request.getParameter("numberOfGuests"));
    String checkInDate = request.getParameter("checkInDate");
    String checkOutDate = request.getParameter("checkOutDate");
    String hotelChain = request.getParameter("hotelChain");
    String roomType = request.getParameter("roomType");
    int numberOfRooms = Integer.parseInt(request.getParameter("numberOfRooms"));
    float priceOfRooms = Float.parseFloat(request.getParameter("priceOfRooms"));

    SearchResult result = new SearchResult(area, numberOfGuests, hotelChain, roomType, numberOfRooms, priceOfRooms);
    List<Hotel> hotels = null;
    List<HotelRoom> rooms = new ArrayList<>();
    try {
        hotels = result.getSearchResults();
        for (Hotel h : hotels ) {
            rooms.addAll(result.getSearchedRooms(h));
        }
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
                        <% if (rooms == null || rooms.size() == 0) { %>
                         <h1 style="margin-top: 5rem;">No rooms currently available.</h1>
                         <% } else { %>
                            <h2>Available Rooms</h2>
                            <div>
                                <table class="table center-table">
                                    <thead>
                                        <tr>
                                            <th class="table-header">Hotel chain</th>
                                            <th class="table-header">Address</th>
                                            <th class="table-header">Amenities</th>
                                            <th class="table-header">Capacity</th>
                                            <th class="table-header">Problems</th> 
                                            <th class="table-header">View</th>
                                            <th class="table-header">Extendibility</th>
                                            <th class="table-header">Price</th>
                                            <th class="table-header">Book Room</th></tr>
                                    </thead>
                                    <tbody>
                                        <% for (HotelRoom room : rooms) { %>
                                        <tr>
                                            <td class="table-data"><%= room.getHotelChain()%></td>
                                            <td class="table-data"><%= room.getAddress() %></td>
                                            <td class="table-data"><%= room.getAmenities() %></td>
                                            <td class="table-data">
                                                <%= room.getCapacity() %>
                                                <%
                                                    switch(room.getCapacity()) {
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
                                            <td class="table-data"><%= room.getProblemsAndDamages() == null ? "None" : room.getProblemsAndDamages() %></td>
                                            <td class="table-data" style="color:<%= room.getViewType().equalsIgnoreCase("Sea") ? "blue" : (room.getViewType().equalsIgnoreCase("Mountain") ? "green" : "black") %>;"><%= room.getViewType() %></td>
                                            <td class="table-data"><%= room.getExtensionCapabilities() %></td>
                                            <td class="table-data">$<%= room.getPrice() %></td>
                                            <td class="table-data">
                                                <a href="bookRoom.jsp">
                                                    <button type="button" class="book-room-button">Book room</button>
                                                </a>
                                            </td></tr>
                                        <% } %>
                                    </tbody>
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
