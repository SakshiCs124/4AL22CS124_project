// DisplayProductsServlet.java content goes here
package com.servlet;

import com.dao.ProductDAO;
import com.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


public class DisplayProductsServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Product> products = productDAO.getAllProducts();
            request.setAttribute("products", products);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Error fetching products: " + e.getMessage());
        }

        request.getRequestDispatcher("productdisplay.jsp").forward(request, response);
    }
}
