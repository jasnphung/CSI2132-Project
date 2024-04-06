<%@ page import="java.time.LocalDate" %>
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
            box-sizing: border-box;
            border: 1px solid #000000
        }
        .search-button {
            font-size: 20px;
            width: 530px; /* 270 + 10 + 270 */
            height: 60px;
            margin: 20px;
            border-radius: 5px;
            font-family: Gilroy-ExtraBold, sans-serif;
            box-sizing: border-box;
            border: 1px solid #000000
        }
        .view-all-button {
            font-size: 20px;
            width: 300px;
            height: 40px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-family: Gilroy-ExtraBold, sans-serif;
            box-sizing: border-box;
            background-color: #0b1021;
            color: #ffffff;
            border: 1px solid #ffffff
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
<%@ page import="com.DatabaseProjectWebsite.Index" %>

<main class="search">
    <div class="background-div">
        <div class="foreground-div">
            <h2 class="search-heading">Search for available hotel rooms</h2>

            <a href="allHotelRoomsView.jsp">
                <button type="button" class="view-all-button">Or, view all available rooms</button>
            </a>

            <form action="searchResult.jsp" method="post">
                <div class="search-items">
                    <div class="search-individual-items">
                        <!-- TODO: Change so it selects from what locations are in the database -->
                        <label for="area" class="label-size">Area:</label>
                        <select id="area" name="location" class="input-spacing">
                            <option value="" disabled selected>Select city</option>
                            <%
                                List<String> cities = Index.getCities();
                                for (String city : cities) {
                            %>
                            <option value="<%= city %>"><%= city %></option>
                            <%
                                }
                            %>
                        </select>
                    </div>

                    <div class="search-individual-items">
                        <label for="numberOfGuests" class="label-size">Number of guests:</label>
                        <input type="number" id="numberOfGuests" name="numberOfGuests" placeholder="0" min="1" max="100" class="input-spacing">
                    </div>

                    <div class="search-individual-items">
                        <label for="checkInDate" class="label-size">Check-in date:</label>
                        <input type="date" id="checkInDate" name="checkInDate" min="<%= LocalDate.now() %>" class="input-spacing">
                    </div>

                    <div class="search-individual-items">
                        <label for="checkOutDate" class="label-size">Check-out date:</label>
                        <input type="date" id="checkOutDate" name="checkOutDate" min="<%= LocalDate.now().plusDays(1) %>" class="input-spacing">
                    </div>

                    <div class="search-individual-items">
                        <label for="hotelChain" class="label-size">Hotel chain:</label>
                        <select id="hotelChain" name="hotelChain" class="input-spacing">
                            <option value="" disabled selected>Select hotel chain</option>
                            <%
                                List<String> chains = Index.getHotelChains();
                                for (String chain : chains) {
                            %>
                            <option value="<%= chain %>"><%= chain %></option>
                            <%
                                }
                            %>
                        </select>
                    </div>

                    <div class="search-individual-items">
                        <label for="category" class="label-size">Category:</label>
                        <select id="category" name="roomType" class="input-spacing">
                            <option value="" disabled selected>Select min. rating</option>
                            <option value="1/5">1/5 ★</option>
                            <option value="2/5">2/5 ★</option>
                            <option value="3/5">3/5 ★</option>
                            <option value="4/5">4/5 ★</option>
                            <option value="5/5">5/5 ★</option>
                        </select>
                    </div>

                    <div class="search-individual-items">
                        <label for="numberOfRooms" class="label-size">Number of hotel rooms:</label>
                        <input type="number" id="numberOfRooms" name="numberOfRooms" placeholder="Min. total rooms" min="1" max="1000" class="input-spacing">
                    </div>

                    <div class="search-individual-items">
                        <label for="priceOfRooms" class="label-size">Price per night:</label>
                        <input type="number" id="priceOfRooms" name="priceOfRooms" placeholder="Max. price per night" min="1" max="10000" class="input-spacing">
                    </div>
                </div>
                <button type="submit" class="search-button">Search</button>
            </form>
        </div>
    </div>
</main>
<footer style=background-color:#0b1021;>
    <a href="adminLogin.jsp" style="color: white;">Admin? Login here</a>
</footer>

<script>
    // Set the minimum check-out date to the day after the check-in date
    document.getElementById('checkInDate').addEventListener('change', function() {
        var checkInDate = new Date(this.value);
        checkInDate.setDate(checkInDate.getDate() + 1);

        var dd = String(checkInDate.getDate()).padStart(2, '0');
        var mm = String(checkInDate.getMonth() + 1).padStart(2, '0'); //January is 0
        var yyyy = checkInDate.getFullYear();

        var minCheckOutDate = yyyy + '-' + mm + '-' + dd;

        document.getElementById('checkOutDate').min = minCheckOutDate;
    });

    // Form validation
    document.querySelector('button[type="submit"]').addEventListener('click', function(event) {
        var area = document.getElementById('area').value;
        var numberOfGuests = Number(document.getElementById('numberOfGuests').value);
        var checkInDate = new Date(document.getElementById('checkInDate').value);
        var checkOutDate = new Date(document.getElementById('checkOutDate').value);
        var hotelChain = document.getElementById('hotelChain').value;
        var categoryRating = document.getElementById('category').value;
        var numberOfRooms = Number(document.getElementById('numberOfRooms').value);
        var priceOfRooms = Number(document.getElementById('priceOfRooms').value);

        var errorMessage = '';

        // Checks if an area is selected
        if (!area) {
            errorMessage += '- Please select a booking area.\n';
        }
        // Checks if the number of guests is at least 1
        if (numberOfGuests < 1) {
            errorMessage += '- Number of guests must be at least 1.\n';
        }
        // Checks if a check-in date is selected and valid
        if (!checkInDate || isNaN(checkInDate.getTime())) {
            errorMessage += '- Please select a valid check-in date.\n';
        }
        // Checks if a check-out date is selected and valid
        if (!checkOutDate || isNaN(checkOutDate.getTime())) {
            errorMessage += '- Please select a valid check-out date.\n';
        }
        // Check if the check-out date is after the check-in date
        if (checkInDate >= checkOutDate) {
            errorMessage += '- Check-out date must be after check-in date.\n';
        }
        // Checks if a hotel chain is selected
        if (!hotelChain) {
            errorMessage += '- Please select a hotel chain.\n';
        }
        // Checks if a category rating is selected
        if (!categoryRating) {
            errorMessage += '- Please select a category rating.\n';
        }
        // Checks if the total number of hotel rooms is at least 0
        if (numberOfRooms < 1) {
            errorMessage += '- Number of rooms must be at least 1.\n';
        }
        // Checks if the price of rooms is at least 0
        if (priceOfRooms < 1) {
            errorMessage += '- Price of rooms must be at least 1.\n';
        }

        // Display error message if there are any errors
        if (errorMessage) {
            alert("Please correct the following to continue:\n" + errorMessage);
            event.preventDefault(); // Prevent form from being submitted
        }
    });
</script>
</body>
</html>