// DeleteProductServlet.java content goes here
package com.servlet;

import com.dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;


public class DeleteProductServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productID"));
            productDAO.deleteProduct(productId);
            request.setAttribute("message", "Product deleted successfully!");
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("message", "Error deleting product: " + e.getMessage());
        }

        request.getRequestDispatcher("productdelete.jsp").forward(request, response);
    }
}
