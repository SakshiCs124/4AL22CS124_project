package com.dao;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.model.Product;

public class ProductDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/product_db";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    // Get DB Connection
    protected Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");  // MySQL 8+ driver
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("MySQL Driver not found.", e);
        }
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    // Helper method to map ResultSet row to Product object
    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        return new Product(
            rs.getInt("ProductID"),
            rs.getString("ProductName"),
            rs.getString("Category"),
            rs.getDouble("Price"),
            rs.getInt("Quantity")
        );
    }

    // Add a product
    public void addProduct(Product product) throws SQLException {
        String sql = "INSERT INTO Products (ProductID, ProductName, Category, Price, Quantity) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, product.getProductID());
            stmt.setString(2, product.getProductName());
            stmt.setString(3, product.getCategory());
            stmt.setDouble(4, product.getPrice());
            stmt.setInt(5, product.getQuantity());
            stmt.executeUpdate();
        }
    }

    // Update a product
    public void updateProduct(Product product) throws SQLException {
        String sql = "UPDATE Products SET ProductName=?, Category=?, Price=?, Quantity=? WHERE ProductID=?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, product.getProductName());
            stmt.setString(2, product.getCategory());
            stmt.setDouble(3, product.getPrice());
            stmt.setInt(4, product.getQuantity());
            stmt.setInt(5, product.getProductID());
            stmt.executeUpdate();
        }
    }

    // Delete a product by ID
    public void deleteProduct(int productId) throws SQLException {
        String sql = "DELETE FROM Products WHERE ProductID=?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            stmt.executeUpdate();
        }
    }

    // Get all products
    public List<Product> getAllProducts() throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Products";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        }
        return products;
    }

    // Get products by category
    public List<Product> getProductsByCategory(String category) throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE Category=?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToProduct(rs));
                }
            }
        }
        return products;
    }

    // Get products with price greater than given value
    public List<Product> getProductsAbovePrice(double price) throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE Price > ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDouble(1, price);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToProduct(rs));
                }
            }
        }
        return products;
    }

    // Get top N products by quantity
    public List<Product> getTopNProducts(int n) throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Products ORDER BY Quantity DESC LIMIT ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, n);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToProduct(rs));
                }
            }
        }
        return products;
    }
    public Product getProductById(int productId) throws SQLException {
        String sql = "SELECT * FROM Products WHERE ProductID = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Product(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("Category"),
                        rs.getDouble("Price"),
                        rs.getInt("Quantity")
                    );
                }
            }
        }
        return null;
    }

}
