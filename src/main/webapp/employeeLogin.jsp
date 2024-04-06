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
            text-align: center;
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
<%@ page import="com.DatabaseProjectWebsite.Tables.Employee" %>
<%@ page import="java.util.ArrayList" %>
<%
    List<Employee> employees = null;
    try {
        employees = Employee.getAllEmployees();
    } catch (Exception e) {
        e.printStackTrace();
    }

    String SSNSIN = request.getParameter("SSNSIN");
    String lastName = request.getParameter("lastName");
    boolean loginSuccessful = false;

    if (SSNSIN != null && lastName != null) {
        for (Employee employee : employees) {
            if ((employee.getSinSsn() == (Long.parseLong(SSNSIN))) && employee.getLastName().equals(lastName)) {
                loginSuccessful = true;
                break;
            }
        }
    }

    System.out.println("SSNSIN: " + SSNSIN); // Debug line
    System.out.println("lastName: " + lastName); // Debug line
    System.out.println("loginSuccessful: " + loginSuccessful); // Debug line
%>

<main>
    <div class="foreground-div">
        <h2>Hotel Employee Login</h2>
        <form action="<%= loginSuccessful ? "employeePage.jsp" : "employeeLogin.jsp" %>" method="post">
            <label for="SSNSIN" class="label-size">SSN/SIN:</label>
            <input type="number" name="SSNSIN" id="SSNSIN" class="input-spacing" required>
            <br>
            <label for="lastName" class="label-size">Last name:</label>
            <input type="password" name="lastName" id="lastName" class="input-spacing" required>
            <br>
            <input type="hidden" id="loginSuccessful" value="<%= loginSuccessful ? "true" : "false" %>">
            <input type="submit" value="Login" class="search-button">
        </form>
    </div>
</main>

<script>
    document.querySelector('form').addEventListener('submit', function(event) {
        event.preventDefault(); // Prevent the form from submitting immediately

        let username = document.querySelector('#SSNSIN').value;
        let password = document.querySelector('#lastName').value;
        let loginSuccessful = false;

        let employees = [
            <% for (Employee employee : employees) { %>
            {sinSsn: '<%= employee.getSinSsn() %>', lastName: '<%= employee.getLastName() %>'},
            <% } %>
        ];

        for (let i = 0; i < employees.length; i++) {
            if (username === employees[i].sinSsn && password === employees[i].lastName) {
                loginSuccessful = true;
                break;
            }
        }

        // Test employee
        if (username == '123456789' && password == 'password') {
            loginSuccessful = true;
        }

        if (loginSuccessful) {
            this.action = "employeePage.jsp"; // Set the form's action attribute to "employeePage.jsp"
            this.submit(); // Submit the form
        } else {
            alert('Invalid SSN/SIN or Last Name');
        }
    })
</script>

<footer style=background-color:#0b1021;>
    <a href="adminLogin.jsp" style="color: white;">Admin? Login here</a>
</footer>


</body></body>
</html>
