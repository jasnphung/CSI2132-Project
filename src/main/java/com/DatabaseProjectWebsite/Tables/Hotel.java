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
}
