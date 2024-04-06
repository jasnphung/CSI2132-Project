package com.DatabaseProjectWebsite.Tables;

import com.DatabaseProjectWebsite.DatabaseConnection;

import java.sql.*;
import java.util.*;

public class Customer {
    private long customerID;
    private String IDType;
    private String registerDate;
    private String firstName;
    private String middleName;
    private String lastName;
    private String address;

    public Customer(long cid, String idt, String rd, String fn, String mn, String ln, String ad) {
        customerID = cid;
        IDType = idt;
        registerDate = rd;
        firstName = fn;
        middleName = mn;
        lastName = ln;
        address = ad;
    }

    public long getCustomerID() { return customerID; }
    public String getIDType() { return IDType; }
    public String getRegisterDate() { return registerDate; }
    public String getFirstName() { return firstName; }
    public String getMiddleName() { return middleName; }
    public String getLastName() { return lastName; }
    public String getAddress() { return address; }

    public void setCustomerID(long cid) { customerID = cid; }
    public void setIDType(String idt) { IDType = idt; }
    public void setRegisterDate(String rd) { registerDate = rd; }
    public void setFirstName(String fn) { firstName = fn; }
    public void setMiddleName(String mn) { middleName = mn; }
    public void setLastName(String ln) { lastName = ln; }
    public void setAddress(String ad) { address = ad; }

    @Override
    public String toString() {
        return "<ul>"
                + "<li>" + customerID + "</li>"
                + "<li>" + IDType + "</li>"
                + "<li>" + registerDate + "</li>"
                + "<li>" + firstName + "</li>"
                + "<li>" + middleName + "</li>"
                + "<li>" + lastName + "</li>"
                + "<li>" + address + "</li>"
            + "</ul>";
    }

    public static List<Customer> getAllCustomers() throws Exception {
        String sql = "SELECT * FROM dbproj.customer";
        DatabaseConnection db = new DatabaseConnection();
        List<Customer> customers = new ArrayList<Customer>();

        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Customer customer = new Customer(
                    rs.getLong("customer_id"),
                    rs.getString("id_type"),
                    rs.getString("register_date"),
                    rs.getString("first_name"),
                    rs.getString("middle_name"),
                    rs.getString("last_name"),
                    rs.getString("address")
                );
                customers.add(customer);
            }

            rs.close();
            stmt.close();
            con.close();
            db.close();

            return customers;
        } catch (Exception e) {
            throw new Exception("Could not retrieve customers: " + e.getMessage());
        }
    }

    public static String updateCustomer(String customerID, String idType, String registerDate, String firstName, String middleName, String lastName, String address) throws Exception {
        Connection con = null;
        String message = "";

        String sql = "UPDATE dbproj.customer SET id_type = ?, register_date = ?, first_name = ?, middle_name = ?, last_name = ?, address = ? WHERE customer_id = ?";
        DatabaseConnection db = new DatabaseConnection();

        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setString(1, idType);
            stmt.setString(2, registerDate);
            stmt.setString(3, firstName);
            stmt.setString(4, middleName);
            stmt.setString(5, lastName);
            stmt.setString(6, address);

            stmt.executeUpdate();

            stmt.close();
        } catch (Exception e) {
            message = "Error updating customer: " + e.getMessage();
        } finally {
            if (con != null) {
                con.close();
            }
            if (message.equals("")) {
                message = "Customer updated successfully!";
            }
        }

        return message;
    }
}
