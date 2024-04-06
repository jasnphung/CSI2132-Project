package com.DatabaseProjectWebsite.Tables;

import com.DatabaseProjectWebsite.DatabaseConnection;

import java.sql.*;
import java.util.*;

public class Hotel {
    private String address;
    private long phoneNumber;
    private String emailAddress;
    private int starRating;
    private int numberOfRooms;
    private String chainName;
    private int managerID;

    public Hotel(String ad, long pn, String ea, int sr, int nor, String cn, int mid) {
        address = ad;
        phoneNumber = pn;
        emailAddress = ea;
        starRating = sr;
        numberOfRooms = nor;
        chainName = cn;
        managerID = mid;
    }

    public String getAddress() { return address; }
    public long getPhoneNumber() { return phoneNumber; }
    public String getEmailAddress() { return emailAddress; }
    public int getStarRating() { return starRating; }
    public int getNumberOfRooms() { return numberOfRooms; }
    public String getChainName() { return chainName; }
    public int getManagerID() { return managerID; }

    public void setAddress(String ad) { address = ad; }
    public void setPhoneNumber(long pn) { phoneNumber = pn; }
    public void setEmailAddress(String ea) { emailAddress = ea; }
    public void setStarRating(int sr) { starRating = sr; }
    public void setNumberOfRooms(int nor) { numberOfRooms = nor; }
    public void setChainName(String cn) { chainName = cn; }
    public void setManagerID(int mid) { managerID = mid; }

    @Override
    public String toString() {
        return "<ul>"
                + "<li>" + address + "</li>"
                + "<li>" + phoneNumber + "</li>"
                + "<li>" + emailAddress + "</li>"
                + "<li>" + starRating + "</li>"
                + "<li>" + numberOfRooms + "</li>"
                + "<li>" + chainName + "</li>"
                + "<li>" + managerID + "</li>"
            + "</ul>";
    }

    public static List<Hotel> getAllHotels() throws Exception {
        String sql = "SELECT * FROM dbproj.hotel";
        DatabaseConnection db = new DatabaseConnection();
        List<Hotel> hotels = new ArrayList<Hotel>();

        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Hotel hotel = new Hotel(
                        ((ResultSet) rs).getString("address"),
                        rs.getLong("phone_number"),
                        rs.getString("email_address"),
                        rs.getInt("star_rating"),
                        rs.getInt("number_of_rooms"),
                        rs.getString("chain_name"),
                        rs.getInt("manager"));
                hotels.add(hotel);
            }

            rs.close();
            stmt.close();
            con.close();
            db.close();

            return hotels;
        } catch (Exception e) {
            throw new Exception("Could not retrieve hotels from the database: " + e.getMessage());
        }
    }

    public String updateHotel(Hotel hotel) throws Exception {
        Connection con = null;
        String message = "";

        String sql = "UPDATE dbproj.hotel SET address = ?, phone_number = ?, email_address = ?, star_rating = ?, number_of_rooms = ?, chain_name = ?, manager = ? WHERE address = ?";

        DatabaseConnection db = new DatabaseConnection();

        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setString(1, hotel.getAddress());
            stmt.setLong(2, hotel.getPhoneNumber());
            stmt.setString(3, hotel.getEmailAddress());
            stmt.setInt(4, hotel.getStarRating());
            stmt.setInt(5, hotel.getNumberOfRooms());
            stmt.setString(6, hotel.getChainName());
            stmt.setInt(7, hotel.getManagerID());

            stmt.executeUpdate();

            stmt.close();
        } catch (Exception e) {
            message = "Could not update hotel: " + e.getMessage();
        } finally {
            if (con != null) {
                con.close();
            }
            if (message.equals("")) {
                message = "Hotel updated successfully";
            }
        }

        return message;
    }

    public static void insertHotel(String chainName, String address, long phoneNumber, String emailAddress, int starRating, int numberOfRooms, int managerID) throws Exception {
        // sql query to insert phone number into contactPhoneNumber table
        String sqlPhone = "INSERT INTO dbproj.contactPhoneNumber (phone_number) VALUES (?)";

        // sql query to insert email into contactEmailAddress table
        String sqlEmail = "INSERT INTO dbproj.contactEmailAddress (email_address) VALUES (?)";

        // sql query to insert hotel data into hotel table
        String sqlHotel = "INSERT INTO dbproj.hotel (chain_name, address, phone_number, email_address, star_rating, number_of_rooms, manager) VALUES (?, ?, ?, ?, ?, ?, ?)";

        // connection object
        DatabaseConnection db = new DatabaseConnection();

        try (Connection con = db.getConnection()) {
            // prepare statement for inserting phone number
            PreparedStatement stmtPhone = con.prepareStatement(sqlPhone);

            // set parameter for phone number
            stmtPhone.setLong(1, phoneNumber);

            // execute the query to insert phone number
            stmtPhone.executeUpdate();

            // prepare statement for inserting email
            PreparedStatement stmtEmail = con.prepareStatement(sqlEmail);

            // set parameter for email
            stmtEmail.setString(1, emailAddress);

            // execute the query to insert email
            stmtEmail.executeUpdate();

            // prepare statement for inserting hotel
            PreparedStatement stmtHotel = con.prepareStatement(sqlHotel);

            // set parameters for hotel
            stmtHotel.setString(1, chainName);
            stmtHotel.setString(2, address);
            stmtHotel.setLong(3, phoneNumber);
            stmtHotel.setString(4, emailAddress);
            stmtHotel.setInt(5, starRating);
            stmtHotel.setInt(6, numberOfRooms);
            stmtHotel.setInt(7, managerID);

            // execute the query to insert hotel
            stmtHotel.executeUpdate();

            // close statements
            stmtPhone.close();
            stmtEmail.close();
            stmtHotel.close();

            // close connection
            con.close();
            db.close();
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public static void deleteHotel(String address) throws Exception {
        // SQL queries
        String sqlGetDetails = "SELECT phone_number, email_address FROM dbproj.hotel WHERE address = ?";
        String sqlDeletePhone = "DELETE FROM dbproj.contactPhoneNumber WHERE phone_number = ?";
        String sqlDeleteEmail = "DELETE FROM dbproj.contactEmailAddress WHERE email_address = ?";
        String sqlDeleteHotel = "DELETE FROM dbproj.hotel WHERE address = ?";
        String sqlDeleteHotelRooms = "DELETE FROM dbproj.hotelroom WHERE address = ?";

        System.out.println(sqlGetDetails);
        System.out.println(sqlDeletePhone);
        System.out.println(sqlDeleteEmail);
        System.out.println(sqlDeleteHotel);

        // Connection object
        DatabaseConnection db = new DatabaseConnection();

        try (Connection con = db.getConnection()) {
            // Prepare statement to get phone number and email address
            PreparedStatement stmtGetDetails = con.prepareStatement(sqlGetDetails);
            stmtGetDetails.setString(1, address);
            ResultSet rs = stmtGetDetails.executeQuery();
            boolean rs_next = rs.next();

            // delete all rooms from that hotel BEFORE deleting the hotel
            // hotel rooms cant exist without a hotel
            if(rs_next) {
                PreparedStatement stmtDeleteHotelRooms = con.prepareStatement(sqlDeleteHotelRooms);
                stmtDeleteHotelRooms.setString(1, address);
                stmtDeleteHotelRooms.executeUpdate();
            }


            // Prepare statement to delete hotel
            PreparedStatement stmtDeleteHotel = con.prepareStatement(sqlDeleteHotel);
            stmtDeleteHotel.setString(1, address);
            stmtDeleteHotel.executeUpdate();

            if (rs_next) {
                String phoneNumber = rs.getString("phone_number");
                String emailAddress = rs.getString("email_address");
                // Prepare statement to delete phone number
                PreparedStatement stmtDeletePhone = con.prepareStatement(sqlDeletePhone);
                stmtDeletePhone.setString(1, phoneNumber);
                stmtDeletePhone.executeUpdate();

                // Prepare statement to delete email address
                PreparedStatement stmtDeleteEmail = con.prepareStatement(sqlDeleteEmail);
                stmtDeleteEmail.setString(1, emailAddress);
                stmtDeleteEmail.executeUpdate();
            }

            // Close statements and result set
            rs.close();
            stmtGetDetails.close();
            con.close();
            db.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
