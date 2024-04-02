package com.DatabaseProjectWebsite.Tables;

import com.DatabaseProjectWebsite.DatabaseConnection;

import java.sql.*;
import java.util.*;

public class View2 {

    private String address;
    private String city;
    private int numberOfAvailableRooms;

    public View2(String c, String a, int n) {
        address = a;
        city = c;
        numberOfAvailableRooms = n;
    }

    public String getAddress() {
        return address;
    }

    public int getNumberOfAvailableRooms() {
        return numberOfAvailableRooms;
    }

    public String getCity() {
        return city;
    }

    public static List<View2> getData() throws Exception {
        String sql = "SELECT * FROM dbproj.availableRoomsPerCity";
        DatabaseConnection db = new DatabaseConnection();
        List<View2> data = new ArrayList<View2>();

        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                View2 row = new View2(
                        rs.getString("city"),
                        rs.getString("address"),
                        rs.getInt("available_rooms")
                );
                data.add(row);
            }

            rs.close();
            stmt.close();
            con.close();
            db.close();

            return data;
        } catch (Exception e) {
            throw new Exception("Failed to retrieve data from View2: " + e.getMessage());
        }

    }
}
