package com.DatabaseProjectWebsite.Tables;

import com.DatabaseProjectWebsite.DatabaseConnection;

import java.sql.*;
import java.util.*;

public class Employee {
    private String firstName;
    private String middleName;
    private String lastName;
    private String address;
    private long sin_ssn;
    private String jobPosition;

    public Employee(String fn, String mn, String ln, String ad, long ss, String jp) {
        firstName = fn;
        middleName = mn;
        lastName = ln;
        address = ad;
        sin_ssn = ss;
        jobPosition = jp;
    }

    public String getFirstName() { return firstName; }
    public String getMiddleName() { return middleName; }
    public String getLastName() { return lastName; }
    public String getAddress() { return address; }
    public long getSinSsn() { return sin_ssn; }
    public String getJobPosition() { return jobPosition; }

    public void setFirstName(String fn) { firstName = fn; }
    public void setMiddleName(String mn) { middleName = mn; }
    public void setLastName(String ln) { lastName = ln; }
    public void setAddress(String ad) { address = ad; }
    public void setSin_ssn(long ss) { sin_ssn = ss; }
    public void setJobPosition(String jp) { jobPosition = jp; }

    @Override
    public String toString() {
        return "<ul>"
                + "<li>" + firstName + "</li>"
                + "<li>" + middleName + "</li>"
                + "<li>" + lastName + "</li>"
                + "<li>" + address + "</li>"
                + "<li>" + sin_ssn + "</li>"
                + "<li>" + jobPosition + "</li>"
            + "</ul>";
    }


    public List<HotelRoom> getAvailableRooms() throws Exception {
        String sql = "SELECT * FROM dbproj.hotelroom where address=? AND status=?;";
        DatabaseConnection db = new DatabaseConnection();
        List<HotelRoom> availableRooms = new ArrayList<>();

        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            // Set parameters for the prepared statement
            stmt.setString(1, getAddress());
            stmt.setString(2, "available");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                HotelRoom room = new HotelRoom(
                        rs.getString("address"),
                        rs.getInt("room_number"),
                        rs.getString("amenities"),
                        rs.getInt("price"),
                        rs.getString("capacity"),
                        rs.getString("problems_and_damages"),
                        rs.getString("view_type"),
                        rs.getString("extension_capabilities"),
                        rs.getString("status")
                );
                availableRooms.add(room);
            }

            rs.close();
            stmt.close();
            con.close();
            db.close();

            return availableRooms;
        } catch (Exception e) {
            throw new Exception("err: " + e.getMessage());
        }
    }

    public static Employee login(String lastName, int sin_ssn) {
        String sql = "SELECT * FROM dbproj.employee where last_name=? AND sin_ssn_number=?;";
        DatabaseConnection db = new DatabaseConnection();
        List<Employee> employees = new ArrayList<Employee>();

        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, lastName);
            stmt.setInt(2, sin_ssn);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Employee(
                        rs.getString("first_name"),
                        rs.getString("middle_name"),
                        rs.getString("last_name"),
                        rs.getString("address"),
                        rs.getLong("sin_ssn_number"),
                        rs.getString("job_position")
                );

            }

            rs.close();
            stmt.close();
            con.close();
            db.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static List<Employee> getAllEmployees() throws Exception {
        String sql = "SELECT * FROM dbproj.employee";
        DatabaseConnection db = new DatabaseConnection();
        List<Employee> employees = new ArrayList<Employee>();

        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Employee employee = new Employee(
                        rs.getString("first_name"),
                        rs.getString("middle_name"),
                        rs.getString("last_name"),
                        rs.getString("address"),
                        rs.getLong("sin_ssn_number"),
                        rs.getString("job_position")
                );
                employees.add(employee);
            }

            rs.close();
            stmt.close();
            con.close();
            db.close();

            return employees;
        } catch (Exception e) {
            throw new Exception("Could not retrieve employees: " + e.getMessage());
        }
    }

    public static String updateEmployee(String firstName, String middleName, String lastName, String address, int sinSsn, String jobPosition) throws Exception {
        Connection con = null;
        String message = "";

        String sql = "UPDATE dbproj.employee SET first_name = ?, middle_name = ?, last_name = ?, address = ?, job_position = ? WHERE sin_ssn_number = ?";
        DatabaseConnection db = new DatabaseConnection();

        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setString(1, firstName);
            stmt.setString(2, middleName);
            stmt.setString(3, lastName);
            stmt.setString(4, address);
            stmt.setLong(5, sinSsn);
            stmt.setString(6, jobPosition);

            stmt.executeUpdate();

            stmt.close();
        } catch (Exception e) {
            message = "Could not update employee: " + e.getMessage();
        } finally {
            if (con != null) {
                con.close();
            }
            if (message.equals("")) {
                message = "Employee updated!";
            }
        }

        return message;
    }

    public static void insertEmployee(String firstName, String middleName, String lastName, String address, long sinSsn, String jobPosition) throws Exception {
        String sql = "INSERT INTO dbproj.employee (first_name, middle_name, last_name, address, sin_ssn_number, job_position) VALUES (?, ?, ?, ?, ?, ?)";
        DatabaseConnection db = new DatabaseConnection();

        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, firstName);
            stmt.setString(2, middleName);
            stmt.setString(3, lastName);
            stmt.setString(4, address);
            stmt.setLong(5, sinSsn);
            stmt.setString(6, jobPosition);

            stmt.executeUpdate();

            stmt.close();
        } catch (SQLException e) {
            throw new Exception("Could not insert employee: " + e.getMessage());
        } finally {
            db.close();
        }
    }

    public static void deleteEmployee(long sinSsn) throws Exception {
        // SQL query
        String sql = "DELETE FROM dbproj.employee WHERE sin_ssn_number = ?";

        // Connection object
        DatabaseConnection db = new DatabaseConnection();

        try (Connection con = db.getConnection()) {
            // Prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setLong(1, sinSsn);

            // Execute the query
            int rowsAffected = stmt.executeUpdate();

            // Check if any rows were affected
            if (rowsAffected == 0) {
                throw new Exception("No employee found with the provided SIN/SSN.");
            }

            // Close the statement
            stmt.close();
        } catch (SQLException e) {
            throw new Exception("Could not delete employee: " + e.getMessage());
        } finally {
            // Close the connection
            db.close();
        }
    }
}
