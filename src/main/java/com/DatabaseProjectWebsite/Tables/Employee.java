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
    public long getSin_ssn() { return sin_ssn; }
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

    public String updateEmployee(Employee employee) throws Exception {
        Connection con = null;
        String message = "";

        String sql = "UPDATE dbproj.employee SET first_name = ?, middle_name = ?, last_name = ?, address = ?, job_position = ? WHERE sin_ssn_number = ?";
        DatabaseConnection db = new DatabaseConnection();

        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setString(1, employee.getFirstName());
            stmt.setString(2, employee.getMiddleName());
            stmt.setString(3, employee.getLastName());
            stmt.setString(4, employee.getAddress());
            stmt.setLong(5, employee.getSin_ssn());
            stmt.setString(6, employee.getJobPosition());

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
}
