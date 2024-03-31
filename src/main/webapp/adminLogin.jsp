<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>e-Hotel Booking - Book the best hotels today</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #333;
            color: #fff;
            padding: 10px 0;
            text-align: center;
        }
        h1 {
            margin-top: 0;
        }
        nav {
            background-color: #444;
            padding: 10px 0;
            text-align: center;
        }
        nav a {
            color: #fff;
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
    </style>
</head>

<body>
<header>
    <h1>Admin Login</h1>
</header>
<nav>
    <a href="index.jsp">Home</a>
    <a href="page2.jsp">Page 2</a>
    <a href="#">Contact</a>
</nav>

<%@ page import="java.util.List" %>
<%@ page import="com.DatabaseProjectWebsite.Tables.HotelChain" %>
<%@ page import="java.util.ArrayList" %>
<%

    // get all hotel chains from database
    List<HotelChain> chains = null;
    try {
        chains = HotelChain.getAllHotelChains();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<main>
    <h2>Main Content Area</h2>
    <p>This is a sample HTML page. You can replace this content with your own.</p>

     <div class="container">
            <div class="row" id="row">
                <div class="col-md-12">
                    <div class="card" id="card-container">
                        <div class="card-body" id="card">
                            <% if (chains == null || chains.size() == 0) { %>
                            <h1 style="margin-top: 5rem;">No Hotel Chains found!</h1>
                            <% } else { %>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th>Chain Name</th>
                                        <th>Central Office Address</th>
                                        <th>Contact Phone Number</th>
                                        <th>Contact Email</th>
                                        <th>Number of Hotels</th>
                                        <th></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                    for (HotelChain hc : chains) { %>
                                    <tr>
                                        <td><%= hc.getChainName() %></td>
                                        <td><%= hc.getCentralOfficeAddress() %></td>
                                        <td><%= hc.getPhoneNumber() %></td>
                                        <td><%= hc.getEmailAddress() %></td>
                                        <td><%= hc.getNumberOfHotels() %></td>
                                        <td>
                                            <a type="button" onclick="setModalFields(this)"
                                               data-toggle="modal" data-id="<%= hc.getChainName() %>"
                                               data-address="<%= hc.getCentralOfficeAddress() %>"                                               data-phone="<%= hc.getPhoneNumber() %>"
                                               data-email="<%= hc.getEmailAddress() %>"
                                               data-numHotels="<%= hc.getNumberOfHotels() %>"
                                               data-target="#editModal">
                                                <i class="fa fa-edit"></i>
                                            </a>
                                        </td>
                                    </tr>
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
<footer>
    <p>&copy; 2024 My Website. All rights reserved.</p>
</footer>
</body>

</html>
