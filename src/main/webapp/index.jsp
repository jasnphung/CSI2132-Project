<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>e-Hotel Booking - Book the best hotels today</title>
    <style>
        body {
            font-family: Helvetica, sans-serif;
            margin: 0;
            padding: 0;
            background: rgb(255,255,255);
            background: linear-gradient(180deg, rgba(255,255,255,1) 0%, rgba(193,193,193,1) 100%);
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
        header {
            color: #000000;
            padding: 10px 0;
            text-align: center;
        }
        h1 {
            margin-top: 30px;
            font-size: 50px;
        }
        h2 {
            margin-top: 0;
            font-size: 50px;
        }
        nav {
            padding: 10px 0;
            text-align: center;
        }
        nav a {
            color: #000000;
            text-decoration: none;
            margin: 0 10px;
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
            border-radius: 10px;
        }
        .foreground-div {
            background-color: rgba(0, 0, 0, 0.55);
            /* padding: 10px; */
            border-radius: 10px;
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
            width: 200px;
            height: 50px;
        }
        .search-size {
            font-size: 20px;
            width: 400px;
            height: 50px;
            margin: 20px;
            border-radius: 5px;
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
        .search-labels {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
    </style>
</head>

<body>
<header>
    <h1>e-Hotel Booking - Find your next stay today</h1>
</header>
<nav>
    <a href="index.jsp">Home</a>
    <a href="page2.jsp">Page 2</a>
    <a href="#">Contact</a>
</nav>
<main class="search">
    <div class="background-div">
        <div class="foreground-div">
            <h2 class="search-heading">Search for available hotels</h2>
            <div class="search-items">
                <div class="search-labels">
                    <!-- TODO: Change so it selects from what locations are in the database -->
                    <label for="area" class="label-size">Area:</label>
                    <select id="area" name="location" class="input-spacing">
                        <option value="london">London</option>
                        <option value="paris">Paris</option>
                        <option value="newyork">New York</option>
                    </select>
                </div>

                <div class="search-labels">
                    <label for="numberOfGuests" class="label-size">Number of guests:</label>
                    <input type="number" id="numberOfGuests" name="numberOfGuests" min="1" max="100" class="input-spacing">
                </div>

                <div class="search-labels">
                    <label for="checkInDate" class="label-size">Check-in date:</label>
                    <input type="date" id="checkInDate" name="checkInDate" min="<%= LocalDate.now() %>" class="input-spacing">
                </div>

                <div class="search-labels">
                    <label for="checkOutDate" class="label-size">Check-out date:</label>
                    <input type="date" id="checkOutDate" name="checkOutDate" min="<%= LocalDate.now().plusDays(1) %>" class="input-spacing">
                </div>

                <div class="search-labels">
                    <label for="hotelChain" class="label-size">Hotel chain:</label>
                    <select id="hotelChain" name="hotelChain" class="input-spacing">
                        <option value="hilton">Hilton</option>
                        <option value="marriott">Marriott</option>
                        <option value="sheraton">Sheraton</option>
                        <option value="holidayinn">Holiday Inn</option>
                        <option value="bestwestern">Best Western</option>
                    </select>
                </div>

                <div class="search-labels">
                    <label for="category" class="label-size">Category:</label>
                    <select id="category" name="roomType" class="input-spacing">
                        <option value="1/5">1/5 ★</option>
                        <option value="2/5">2/5 ★</option>
                        <option value="3/5">3/5 ★</option>
                        <option value="4/5">4/5 ★</option>
                        <option value="5/5">5/5 ★</option>
                    </select>
                </div>

                <div class="search-labels">
                    <label for="numberOfRooms" class="label-size">Number of rooms:</label>
                    <input type="number" id="numberOfRooms" name="numberOfRooms" min="1" max="1000" class="input-spacing">
                </div>

                <div class="search-labels">
                    <label for="priceOfRooms" class="label-size">Price of rooms:</label>
                    <input type="number" id="priceOfRooms" name="priceOfRooms" min="1" max="10000" class="input-spacing">
                </div>
            </div>
            <button type="submit" class="search-size">Search</button>
        </div>
    </div>
</main>
<footer>
    <a href="adminLogin.jsp" style="color: white;">Admin? Login here</a>
</footer>

<script>
    document.getElementById('checkInDate').addEventListener('change', function() {
        var checkInDate = new Date(this.value);
        checkInDate.setDate(checkInDate.getDate() + 1);

        var dd = String(checkInDate.getDate()).padStart(2, '0');
        var mm = String(checkInDate.getMonth() + 1).padStart(2, '0'); //January is 0
        var yyyy = checkInDate.getFullYear();

        var minCheckOutDate = yyyy + '-' + mm + '-' + dd;

        document.getElementById('checkOutDate').min = minCheckOutDate;
    });

    document.querySelector('button[type="submit"]').addEventListener('click', function(event) {
        var numberOfGuests = Number(document.getElementById('numberOfGuests').value);
        var checkInDate = new Date(document.getElementById('checkInDate').value);
        var checkOutDate = new Date(document.getElementById('checkOutDate').value);

        var errorMessage = '';

        if (checkInDate >= checkOutDate) {
            errorMessage += '- Check-out date must be after check-in date.\n';
        }
        if (numberOfGuests < 1) {
            errorMessage += '- Number of guests must be at least 1.\n';
        }

        if (errorMessage) {
            alert("Please correct:\n" + errorMessage);
            event.preventDefault(); // Prevent form from being submitted
        }
    });
</script>
</body>
</html>