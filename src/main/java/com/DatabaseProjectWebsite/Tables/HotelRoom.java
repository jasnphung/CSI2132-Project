package com.DatabaseProjectWebsite.Tables;

import com.DatabaseProjectWebsite.DatabaseConnection;

import java.sql.*;
import java.util.*;

public class HotelRoom {
    private String hotelChain;
    private String address;
    private int roomNumber;
    private String amenities;
    private float price;
    private String capacity;
    private String problemsAndDamages;
    private String viewType;
    private String extensionCapabilities;
    private String status;

    public HotelRoom(String ad, int rn, String am, float pr, String ca, String pad, String vt, String ec, String st) {
        address = ad;
        roomNumber = rn;
        amenities = am;
        price = pr;
        capacity = ca;
        problemsAndDamages = pad;
        viewType = vt;
        extensionCapabilities = ec;
        status = st;
    }
    public String getHotelChain() { return hotelChain; }
    public String getAddress() { return address; }
    public int getRoomNumber() { return roomNumber; }
    public String getAmenities() { return amenities; }
    public float getPrice() { return price; }
    public String getCapacity() { return capacity; }
    public String getProblemsAndDamages() { return problemsAndDamages; }
    public String getViewType() { return viewType; }
    public String getExtensionCapabilities() { return extensionCapabilities; }
    public String getStatus() { return status; }

    public void setHotelChain(String hotelChain) { this.hotelChain = hotelChain; }
    public void setAddress(String ad) { address = ad; }
    public void setRoomNumber(int rn) { roomNumber = rn; }
    public void setAmenities(String am) { amenities = am; }
    public void setPrice(int pr) { price = pr; }
    public void setCapacity(String ca) { capacity = ca; }
    public void setProblemsAndDamages(String pad) { problemsAndDamages = pad; }
    public void setViewType(String vt) { viewType = vt; }
    public void setExtensionCapabilities(String ec) { extensionCapabilities = ec; }
    public void setStatus(String st) { status = st; }

    @Override
    public String toString() {
        return "<ul>"
                + "<li>" + hotelChain + "</li>"
                + "<li>" + address + "</li>"
                + "<li>" + roomNumber + "</li>"
                + "<li>" + amenities + "</li>"
                + "<li>" + price + "</li>"
                + "<li>" + capacity + "</li>"
                + "<li>" + problemsAndDamages + "</li>"
                + "<li>" + viewType + "</li>"
                + "<li>" + extensionCapabilities + "</li>"
                + "<li>" + status + "</li>"
            + "</ul>";
    }

    public static List<HotelRoom> getAllHotelRooms() throws Exception {
        String sql = "SELECT HotelRoom.*, Hotel.chain_name FROM dbproj.HotelRoom JOIN dbproj.Hotel ON dbproj.HotelRoom.Address = dbproj.Hotel.Address;";
        DatabaseConnection db = new DatabaseConnection();
        List<HotelRoom> rooms = new ArrayList<HotelRoom>();

        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

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
                room.setHotelChain(rs.getString("chain_name"));
                rooms.add(room);
            }
            rs.close();
            stmt.close();
            con.close();
            db.close();

            return rooms;
        } catch (Exception e) {
            throw new Exception("Could not retrieve hotel rooms: " + e.getMessage());
        }
    }

    public String updateHotelroom(HotelRoom hotelRoom) throws Exception {
        Connection con = null;
        String message = "";

        String sql = "UPDATE dbproj.hotelroom SET address = ?, room_number = ?, amenities = ?, price = ?, capacity = ?, problems_and_damages = ?, view_type = ?, extension_capabilities = ?, status = ? WHERE address = ? AND room_number = ?";

        DatabaseConnection db = new DatabaseConnection();

        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setString(1, hotelRoom.getAddress());
            stmt.setInt(2, hotelRoom.getRoomNumber());
            stmt.setString(3, hotelRoom.getAmenities());
            stmt.setFloat(4, hotelRoom.getPrice());
            stmt.setString(5, hotelRoom.getCapacity());
            stmt.setString(6, hotelRoom.getProblemsAndDamages());
            stmt.setString(7, hotelRoom.getViewType());
            stmt.setString(8, hotelRoom.getExtensionCapabilities());
            stmt.setString(9, hotelRoom.getStatus());

            stmt.executeUpdate();

            stmt.close();
        } catch (Exception e) {
            message = "Could not update hotel room: " + e.getMessage();
        } finally {
            if (con != null) {
                con.close();
            }
            if (message.equals("")) {
                message = "Hotel room updated successfully";
            }
        }

        return message;
    }


    public String bookRoom() throws SQLException {
        Connection con = null;
        String message = "";

        String sql = "UPDATE dbproj.hotelroom SET status ='booked' WHERE address = ? AND room_number = ?";

        DatabaseConnection db = new DatabaseConnection();

        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setString(1, this.getAddress());
            stmt.setInt(2, this.getRoomNumber());

            stmt.executeUpdate();

            stmt.close();
        } catch (Exception e) {
            message = "Could not book hotel room: " + e.getMessage();
        } finally {
            if (con != null) {
                con.close();
            }
            if (message.equals("")) {
                message = "Hotel room booked.";
            }
        }
        return message;
    }

    public String rentRoom() throws SQLException {
        Connection con = null;
        String message = "";

        String sql = "UPDATE dbproj.hotelroom SET status ='rented' WHERE address = ? AND room_number = ?";

        DatabaseConnection db = new DatabaseConnection();

        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setString(1, this.getAddress());
            stmt.setInt(2, this.getRoomNumber());

            stmt.executeUpdate();

            stmt.close();
        } catch (Exception e) {
            message = "Could not rent hotel room: " + e.getMessage();
        } finally {
            if (con != null) {
                con.close();
            }
            if (message.equals("")) {
                message = "Hotel room rented.";
            }
        }
        return message;
    }

    public static void insertHotelRoom(String address, int roomNumber, String amenities, double price, String  capacity, String problemsAndDamages, String viewType, String extensionCapabilities, String status) throws Exception {
        String sql = "INSERT INTO dbproj.hotelRoom (address, room_number, amenities, price, capacity, problems_and_damages, view_type, extension_capabilities, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        DatabaseConnection db = new DatabaseConnection();

        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setString(1, address);
            stmt.setInt(2, roomNumber);
            stmt.setString(3, amenities);
            stmt.setDouble(4, price);
            stmt.setString(5, capacity);
            stmt.setString(6, problemsAndDamages);
            stmt.setString(7, viewType);
            stmt.setString(8, extensionCapabilities);
            stmt.setString(9, status);

            stmt.executeUpdate();

            stmt.close();
            con.close();
            db.close();
        } catch (Exception e) {
            throw new Exception("Could not insert hotel room: " + e.getMessage());
        }
    }

    public static void deleteHotelRoom(String address, int roomNumber) throws Exception {
        System.out.println(address + " , " + roomNumber);
        String sql = "DELETE FROM dbproj.hotelRoom WHERE address = ? AND room_number = ?";

        DatabaseConnection db = new DatabaseConnection();

        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setString(1, address);
            stmt.setInt(2, roomNumber);

            stmt.executeUpdate();

            stmt.close();
            con.close();
            db.close();
        } catch (Exception e) {
            throw new Exception("Could not delete hotel room: " + e.getMessage());
        }
    }
}