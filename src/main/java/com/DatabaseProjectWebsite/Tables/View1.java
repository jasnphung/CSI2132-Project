package com.DatabaseProjectWebsite.Tables;

import com.DatabaseProjectWebsite.DatabaseConnection;

import java.sql.*;
import java.util.*;

public class View1 {

    private String address;
    private int numberOfAvailableRooms;

    public View1(String a, int n) {
        address = a;
        numberOfAvailableRooms = n;
    }

    public String getAddress() {
        return address;
    }

    public int getAvailability() {
        return numberOfAvailableRooms;
    }


    public static List<View1> getData() throws Exception {
        String sql = "SELECT * FROM dbproj.hotelroomcapacity";
        DatabaseConnection db = new DatabaseConnection();
        List<View1> data = new ArrayList<View1>();

        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                View1 row = new View1(
                        rs.getString("address"),
                        rs.getInt("total_capacity")
                );
                data.add(row);
            }

            rs.close();
            stmt.close();
            con.close();
            db.close();

            return data;
        } catch (Exception e) {
            throw new Exception("Failed to retrieve data from View 1: " + e.getMessage());
        }

    }
}
