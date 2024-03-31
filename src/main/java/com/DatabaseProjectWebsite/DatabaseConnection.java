package com.DatabaseProjectWebsite;

import java.sql.*;

public class DatabaseConnection {
    private final String databaseName = "jdbc:postgresql://localhost:5432/postgres";
    private final String databaseUsername = "postgres";
    private final String databasePassword = "admin";

    private Connection connection = null;

    public Connection getConnection() throws Exception {
        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(databaseName, databaseUsername, databasePassword);
            return connection;
        } catch (Exception exception) {
            throw new Exception("Could not establish connection with the database server: " + exception.getMessage());
        }
    }

    public void close() throws SQLException {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException sqlException) {
            throw new SQLException("Could not close connection with the database server: " + sqlException.getMessage());
        }
    }
}
