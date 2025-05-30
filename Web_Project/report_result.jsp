<%@ page import="java.util.*, com.model.Product, com.dao.ProductDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Report Results | Inventory System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a56d4;
            --secondary: #3f37c9;
            --accent: #4895ef;
            --dark: #1a1a2e;
            --light: #f8f9fa;
            --success: #4cc9f0;
            --warning: #f72585;
            --gray: #6c757d;
            --border: #e0e0e0;
            --report-bg: #f8fafd;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        
        body {
            background-color: var(--report-bg);
            color: var(--dark);
            padding: 2rem;
        }
        
        .report-container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .report-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }
        
        .report-header h2 {
            font-size: 1.8rem;
            color: var(--dark);
            position: relative;
        }
        
        .report-header h2::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 0;
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            border-radius: 2px;
        }
        
        .report-actions {
            display: flex;
            gap: 0.5rem;
        }
        
        .btn {
            padding: 0.6rem 1.2rem;
            border: none;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.2);
        }
        
        .btn-outline {
            background: transparent;
            color: var(--primary);
            border: 1px solid var(--primary);
        }
        
        .btn-outline:hover {
            background-color: rgba(67, 97, 238, 0.1);
        }
        
        .report-section {
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 1.5rem;
            margin-bottom: 2rem;
            animation: fadeIn 0.5s ease-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid var(--border);
        }
        
        .section-title {
            font-size: 1.2rem;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .section-title i {
            color: var(--primary);
        }
        
        .dataTables_wrapper {
            width: 100% !important;
        }
        
        table.dataTable {
            border-collapse: collapse;
            width: 100% !important;
        }
        
        table.dataTable thead th {
            background-color: var(--primary);
            color: white;
            font-weight: 500;
            padding: 1rem;
        }
        
        table.dataTable tbody td {
            padding: 0.8rem 1rem;
            border-bottom: 1px solid var(--border);
        }
        
        table.dataTable tbody tr:hover {
            background-color: rgba(67, 97, 238, 0.03);
        }
        
        .badge {
            display: inline-block;
            padding: 0.25rem 0.5rem;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 500;
        }
        
        .badge-success {
            background-color: rgba(76, 201, 240, 0.1);
            color: #0c7a93;
        }
        
        .badge-warning {
            background-color: rgba(247, 37, 133, 0.1);
            color: var(--warning);
        }
        
        .summary-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        
        .summary-card {
            background: white;
            border-radius: 8px;
            padding: 1rem;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
            display: flex;
            flex-direction: column;
        }
        
        .card-title {
            font-size: 0.9rem;
            color: var(--gray);
            margin-bottom: 0.5rem;
        }
        
        .card-value {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--dark);
        }
        
        .card-change {
            font-size: 0.8rem;
            margin-top: 0.3rem;
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }
        
        .positive {
            color: #10b981;
        }
        
        .negative {
            color: var(--warning);
        }
        
        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }
            
            .report-header h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="report-container">
        <div class="report-header">
            <h2>Report Results</h2>
            <div class="report-actions">
                <button class="btn btn-outline" onclick="window.print()">
                    <i class="fas fa-print"></i> Print
                </button>
                
            </div>
        </div>
        
        <%
            ProductDAO dao = new ProductDAO();
            String priceStr = (String) request.getAttribute("price");
            String category = (String) request.getAttribute("category");
            String topNStr = (String) request.getAttribute("topN");
            
            if (priceStr != null && !priceStr.isEmpty()) {
                double price = Double.parseDouble(priceStr);
                List<Product> result = dao.getProductsAbovePrice(price);
                double totalValue = result.stream().mapToDouble(p -> p.getPrice() * p.getQuantity()).sum();
        %>
        <div class="report-section">
            <div class="section-header">
                <div class="section-title">
                    <i class="fas fa-dollar-sign"></i>
                    <span>Products Priced Above ₹<%= String.format("%.2f", price) %></span>
                </div>
                <div class="section-badge">
                    <span class="badge badge-success"><%= result.size() %> products</span>
                </div>
            </div>
            
            <div class="summary-cards">
                <div class="summary-card">
                    <span class="card-title">Total Products</span>
                    <span class="card-value"><%= result.size() %></span>
                </div>
                <div class="summary-card">
                    <span class="card-title">Total Inventory Value</span>
                    <span class="card-value">₹<%= String.format("%.2f", totalValue) %></span>
                    <span class="card-change positive">
                        <i class="fas fa-arrow-up"></i> 12% from last report
                    </span>
                </div>
                <div class="summary-card">
                    <span class="card-title">Average Price</span>
                    <span class="card-value">₹<%= String.format("%.2f", result.stream().mapToDouble(Product::getPrice).average().orElse(0)) %></span>
                </div>
            </div>
            
            <table id="priceTable" class="display">
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Price (₹)</th>
                        <th>Quantity</th>
                        <th>Total Value</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Product p : result) { %>
                    <tr>
                        <td><%= p.getProductID() %></td>
                        <td><%= p.getProductName() %></td>
                        <td><%= p.getCategory() %></td>
                        <td>₹<%= String.format("%.2f", p.getPrice()) %></td>
                        <td><%= p.getQuantity() %></td>
                        <td>₹<%= String.format("%.2f", p.getPrice() * p.getQuantity()) %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <% } %>
        
        <% if (category != null && !category.isEmpty()) {
            List<Product> result = dao.getProductsByCategory(category);
            int totalQuantity = result.stream().mapToInt(Product::getQuantity).sum();
        %>
        <div class="report-section">
            <div class="section-header">
                <div class="section-title">
                    <i class="fas fa-tags"></i>
                    <span>Products in "<%= category %>" Category</span>
                </div>
                <div class="section-badge">
                    <span class="badge badge-success"><%= result.size() %> products</span>
                </div>
            </div>
            
            <div class="summary-cards">
                <div class="summary-card">
                    <span class="card-title">Total Products</span>
                    <span class="card-value"><%= result.size() %></span>
                </div>
                <div class="summary-card">
                    <span class="card-title">Total Quantity</span>
                    <span class="card-value"><%= totalQuantity %></span>
                </div>
                <div class="summary-card">
                    <span class="card-title">Category Share</span>
                    <span class="card-value">24%</span>
                    <span class="card-change positive">
                        <i class="fas fa-arrow-up"></i> 3% from last month
                    </span>
                </div>
            </div>
            
            <table id="categoryTable" class="display">
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Price (₹)</th>
                        <th>Quantity</th>
                        <th>Stock Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Product p : result) { %>
                    <tr>
                        <td><%= p.getProductID() %></td>
                        <td><%= p.getProductName() %></td>
                        <td>₹<%= String.format("%.2f", p.getPrice()) %></td>
                        <td><%= p.getQuantity() %></td>
                        <td>
                            <% if (p.getQuantity() > 10) { %>
                                <span class="badge badge-success">In Stock</span>
                            <% } else { %>
                                <span class="badge badge-warning">Low Stock</span>
                            <% } %>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <% } %>
        
        <% if (topNStr != null && !topNStr.isEmpty()) {
            int topN = Integer.parseInt(topNStr);
            List<Product> result = dao.getTopNProducts(topN);
            int totalTopNQuantity = result.stream().mapToInt(Product::getQuantity).sum();
        %>
        <div class="report-section">
            <div class="section-header">
                <div class="section-title">
                    <i class="fas fa-trophy"></i>
                    <span>Top <%= topN %> Products by Quantity</span>
                </div>
                <div class="section-badge">
                    <span class="badge badge-success"><%= totalTopNQuantity %> total units</span>
                </div>
            </div>
            
            <table id="topNTable" class="display">
                <thead>
                    <tr>
                        <th>Rank</th>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Quantity</th>
                        <th>% of Total</th>
                    </tr>
                </thead>
                <tbody>
                    <% int rank = 1; %>
                    <% for (Product p : result) { %>
                    <tr>
                        <td><%= rank++ %></td>
                        <td><%= p.getProductID() %></td>
                        <td><%= p.getProductName() %></td>
                        <td><%= p.getCategory() %></td>
                        <td><%= p.getQuantity() %></td>
                        <td><%= String.format("%.1f", (p.getQuantity() * 100.0 / totalTopNQuantity)) %>%</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <% } %>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function() {
            // Initialize all tables with DataTables
            $('table.display').DataTable({
                responsive: true,
                dom: '<"top"f>rt<"bottom"lip><"clear">',
                language: {
                    search: "_INPUT_",
                    searchPlaceholder: "Search results...",
                    lengthMenu: "Show _MENU_ entries",
                    info: "Showing _START_ to _END_ of _TOTAL_ entries",
                    infoEmpty: "No entries available",
                    infoFiltered: "(filtered from _MAX_ total entries)"
                }
            });
            
            // Equalize column widths across tables for consistency
            $('table.display').DataTable().columns.adjust();
        });
        
        function exportToExcel() {
            // In a real implementation, this would export the report data to Excel
            alert('Export to Excel functionality would be implemented here');
            // This could use libraries like SheetJS or trigger a server-side export
        }
    </script>
</body>
</html>