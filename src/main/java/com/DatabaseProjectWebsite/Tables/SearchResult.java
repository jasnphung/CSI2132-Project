package com.DatabaseProjectWebsite.Tables;

import com.DatabaseProjectWebsite.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SearchResult {

    private String city;
    private int numGuests;
    private String chain;
    private String roomType;
    private int numberofRooms;
    private float price;

    public SearchResult(String c, int nG, String ch, String r, int nr, float p) {
        city = c;
        numGuests = nG;
        chain = ch;
        roomType = r;
        numberofRooms = nr;
        price = p;
    }

    public String getCity() {
        return city;
    }

    public float getPrice() {
        return price;
    }

    public int getNumberofRooms() {
        return numberofRooms;
    }

    public int getNumGuests() {
        return numGuests;
    }

    public String getRoomType() {
        return roomType;
    }

    public String getChain() {
        return chain;
    }

    public List<Hotel> getSearchResults() throws Exception {
        String sql = "SELECT * FROM dbproj.Hotel WHERE address LIKE ? AND chain_name=? AND number_of_rooms>?";
        DatabaseConnection db = new DatabaseConnection();
        List<Hotel> hotels = new ArrayList<Hotel>();

        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setString(1, "%"+this.city+"%");
            stmt.setString(2, formatChainName(this.chain));
            // stmt.setInt(4, this.rating);
            stmt.setInt(3, this.numberofRooms);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Hotel hotel = new Hotel(
                        ((ResultSet) rs).getString("address"),
                        rs.getLong("phone_number"),
                        rs.getString("email_address"),
                        rs.getInt("star_rating"),
                        rs.getInt("number_of_rooms"),
                        rs.getString("chain_name"),
                        rs.getInt("manager")
                );
                hotels.add(hotel);
            }
            rs.close();
            stmt.close();
            con.close();
            db.close();

            return hotels;
        } catch (Exception e) {
            throw new Exception("Could not retrieve hotels: " + e.getMessage());
        }
    }


    public List<HotelRoom> getSearchedRooms(Hotel hotel) throws Exception {
        String sql = "SELECT * FROM dbproj.HotelRoom WHERE address=? AND price <= ? AND status='available' AND capacity=? ;";
        DatabaseConnection db = new DatabaseConnection();
        List<HotelRoom> rooms = new ArrayList<HotelRoom>();

        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setString(1, hotel.getAddress());
            stmt.setDouble(2, (double) this.price);
            stmt.setString(3, SearchResult.capacity(this.numGuests));
            // stmt.setInt(4, this.rating);
            // stmt.setInt(5, this.numberofRooms);
            ResultSet rs = stmt.executeQuery();
            System.out.println( stmt.toString() );
            while (rs.next()) {
                HotelRoom room = new HotelRoom(
                        ((ResultSet) rs).getString("address"),
                        rs.getInt("room_number"),
                        rs.getString("amenities"),
                        rs.getInt("price"),
                        rs.getString("capacity"),
                        rs.getString("problems_and_damages"),
                        rs.getString("view_type"),
                        rs.getString("extension_capabilities"),
                        rs.getString("status")
                );
                rooms.add(room);
            }
            rs.close();
            stmt.close();
            con.close();
            db.close();

            return rooms;
        } catch (Exception e) {
            throw new Exception("Could not retrieve hotels: " + e.getMessage());
        } 
    }

    private static String formatChainName(String name) {
        switch (name) {
            case "bestwestern" -> { return "Best Western"; }
            case "fourseasons" -> { return "Four Seasons"; }
            case "lessuites" -> { return "Les Suites"; }
            case "hilton" -> { return "Hilton"; }
            case "marriott" -> { return "Marriott"; }
        }
        return "";
    }

    private static String capacity(int n) {
        switch (n) {

            case 1 -> { return "Single"; }
            case 2 -> { return "Double"; }
            case 3 -> { return "Triple"; }
            case 4 -> { return "Quadruple"; }
            default -> {return "Suite"; }

        }
    }

}
