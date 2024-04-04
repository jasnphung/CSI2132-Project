package com.DatabaseProjectWebsite;

import com.DatabaseProjectWebsite.DatabaseConnection;

import java.sql.*;
import java.util.*;

public class Index {
    private String city;
    private int numberOfGuests;
    private String checkInDate;
    private String checkOutDate;
    private String hotelChain;
    private String ratingCategory;
    private int totalNumberOfRooms;
    private int maxPrice;

    public Index(String c, int nG, String cID, String cOD, String hC, String rC, int tNOR, int mP) {
        city = c;
        numberOfGuests = nG;
        checkInDate = cID;
        checkOutDate = cOD;
        hotelChain = hC;
        ratingCategory = rC;
        totalNumberOfRooms = tNOR;
        maxPrice = mP;
    }

    public String getCity() { return city; };
    public int getNumberOfGuests() { return numberOfGuests; };
    public String getCheckInDate() { return checkInDate; };
    public String getCheckOutDate() { return checkOutDate; };
    public String getHotelChain() { return hotelChain; };
    public String getRatingCategory() { return ratingCategory; };
    public int getTotalNumberOfRooms() { return totalNumberOfRooms; };
    public int getMaxPrice() { return maxPrice; };

    public void setCity(String c) { city = c; };
    public void setNumberOfGuests(int nG) { numberOfGuests = nG; };
    public void setCheckInDate(String cID) { checkInDate = cID; };
    public void setCheckOutDate(String cOD) { checkOutDate = cOD; };
    public void setHotelChain(String hC) { hotelChain = hC; };
    public void setRatingCategory(String rC) { ratingCategory = rC; };
    public void setTotalNumberOfRooms(int tNOR) { totalNumberOfRooms = tNOR; };
    public void setMaxPrice(int mP) { maxPrice = mP; };

    @Override
    public String toString() {
        return "<ul>"
                + "<li>" + city + "</li>"
                + "<li>" + numberOfGuests + "</li>"
                + "<li>" + checkInDate + "</li>"
                + "<li>" + checkOutDate + "</li>"
                + "<li>" + hotelChain + "</li>"
                + "<li>" + ratingCategory + "</li>"
                + "<li>" + totalNumberOfRooms + "</li>"
                + "<li>" + maxPrice + "</li>"
                + "</ul>";
    }

    public static List<String> getCities() throws Exception {
        String sql = "SELECT DISTINCT SUBSTRING(address FROM POSITION(',' IN address) + 1) AS city FROM dbproj.hotelroom";
        DatabaseConnection db = new DatabaseConnection();
        List<String> cities = new ArrayList<String>();

        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                cities.add(rs.getString("city").trim());
            }

            rs.close();
            stmt.close();
            con.close();
            db.close();

            return cities;
        } catch (Exception e) {
            throw new Exception("Could not retrieve cities: " + e.getMessage());
        }
    }

    public static List<String> getHotelChains() throws Exception {
        String sql = "SELECT DISTINCT h.chain_name FROM dbproj.hotel h INNER JOIN dbproj.hotelroom hr ON h.address = hr.address";
        DatabaseConnection db = new DatabaseConnection();
        List<String> chains = new ArrayList<String>();

        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                chains.add(rs.getString("chain_name").trim());
            }

            rs.close();
            stmt.close();
            con.close();
            db.close();

            return chains;
        } catch (Exception e) {
            throw new Exception("Could not retrieve hotel chains: " + e.getMessage());
        }
    }
}
