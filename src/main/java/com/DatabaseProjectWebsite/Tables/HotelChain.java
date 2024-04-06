package com.DatabaseProjectWebsite.Tables;

import com.DatabaseProjectWebsite.DatabaseConnection;

import java.sql.*;
import java.util.*;

public class HotelChain {
    private String chainName;
    private String centralOfficeAddress;
    private long phoneNumber;
    private String emailAddress;
    private int numberOfHotels;


    public HotelChain(String cn,String coa, long pn, String ea, int noh) {
        chainName = cn;
        centralOfficeAddress = coa;
        phoneNumber = pn;
        emailAddress = ea;
        numberOfHotels = noh;
    }


    public String getChainName(){ return chainName; }
    public String getCentralOfficeAddress(){ return centralOfficeAddress; }
    public long getPhoneNumber(){ return phoneNumber; }
    public String getEmailAddress(){ return emailAddress; }
    public int getNumberOfHotels(){ return  numberOfHotels; }


    public void setChainName(String cn){ chainName = cn; }
    public void setCentralOfficeAddress(String coa ){ centralOfficeAddress = coa; }
    public void setPhoneNumber(long pn ){ phoneNumber = pn; }
    public void setEmailAddress(String ea ){ emailAddress = ea; }
    public void setNumberOfHotels(int noh ){ numberOfHotels = noh; }

    @Override
    public String toString() {
        return  "<ul>"
                +"<li>"+chainName+"</li>"
                +"<li>"+centralOfficeAddress+"</li>"
                +"<li>"+phoneNumber+"</li>"
                +"<li>"+ emailAddress +"</li>"
                +"<li>"+numberOfHotels+"</li>"
            +"</ul>";
    }

    public static List<HotelChain> getAllHotelChains() throws Exception {

        // sql query
        String sql = "SELECT * FROM dbproj.hotelchain";
        // connection object
        DatabaseConnection db = new DatabaseConnection();

        // data structure to keep all students retrieved from database
        List<HotelChain> chains = new ArrayList<HotelChain>();

        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // get the results from executing the query
            ResultSet rs = stmt.executeQuery();

            // iterate through the result set
            while (rs.next()) {
                // create new student object
                HotelChain chain = new HotelChain(
                        ((ResultSet) rs).getString("chain_name"),
                        rs.getString("central_office_address"),
                        rs.getLong("phone_number"),
                        rs.getString("email_address"),
                        rs.getInt("number_of_hotels")
                );

                // append student in students list
                chains.add(chain);
            }

            // close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();

            // return result
            return chains;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }


    public static String updateChain(String chainName, String centralOfficeAddress, long phoneNumber, String emailAddress, int numberOfHotels) throws Exception {
        Connection con = null;
        String message = "";

        // sql query
        String sql = "UPDATE dbproj.HotelChain SET central_office_address=?, phone_number=?, email_address=?, number_of_chains=? WHERE chain_name=?;";
        // connection object
        DatabaseConnection db = new DatabaseConnection();

        // try connect to database, catch any exceptions
        try {
            // get connection
            con = db.getConnection();

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // set every ? of statement
            stmt.setString(1, centralOfficeAddress);
            stmt.setLong(2, phoneNumber);
            stmt.setString(3, emailAddress);
            stmt.setInt(4, numberOfHotels);
            stmt.setString(5, chainName);

            // execute the query
            stmt.executeUpdate();

            // close the statement
            stmt.close();

        } catch (Exception e) {
            message = "Error while updating hotel chain: " + e.getMessage();

        } finally {
            if (con != null) con.close();
            if (message.equals("")) message = "Hotel chain successfully updated!";
        }

        // return respective message
        return message;
    }

    public static void insertHotelChain(String chainName, String centralOfficeAddress, long phoneNumber, String emailAddress, int numberOfHotels) throws Exception {
        // sql query
        String sql = "INSERT INTO dbproj.hotelchain (chain_name, central_office_address, phone_number, email_address, number_of_hotels) VALUES (?, ?, ?, ?, ?)";
        // connection object
        DatabaseConnection db = new DatabaseConnection();

        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // set parameters
            stmt.setString(1, chainName);
            stmt.setString(2, centralOfficeAddress);
            stmt.setLong(3, phoneNumber);
            stmt.setString(4, emailAddress);
            stmt.setInt(5, numberOfHotels);

            // execute the query
            stmt.executeUpdate();

            // close statement
            stmt.close();
            con.close();
            db.close();
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public static void deleteHotelChain(String chainName) throws Exception {
        // sql query
        String sql = "DELETE FROM dbproj.hotelchain WHERE chain_name = ?";
        // connection object
        DatabaseConnection db = new DatabaseConnection();

        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // set parameters
            stmt.setString(1, chainName);

            // execute the query
            stmt.executeUpdate();

            // close statement
            stmt.close();
            con.close();
            db.close();
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }
}
