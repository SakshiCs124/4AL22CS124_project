// AddProductServlet.java content goes here
package com.servlet;

import com.dao.ProductDAO;
import com.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;


public class AddProductServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("productID"));
            String name = request.getParameter("productName");
            String category = request.getParameter("category");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            Product product = new Product(id, name, category, price, quantity);
            productDAO.addProduct(product);

            request.setAttribute("message", "Product added successfully!");
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("message", "Error adding product: " + e.getMessage());
        }

        request.getRequestDispatcher("productadd.jsp").forward(request, response);
    }
}
