// ReportServlet.java content goes here
// ReportCriteriaServlet.java content goes here
package com.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;


public class ReportServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String priceStr = request.getParameter("price");
        String category = request.getParameter("category");
        String topNStr = request.getParameter("topN");

        request.setAttribute("price", priceStr);
        request.setAttribute("category", category);
        request.setAttribute("topN", topNStr);

        request.getRequestDispatcher("report_result.jsp").forward(request, response);
    }
}
