<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.model.Product" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Product Inventory | Inventory System</title>
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
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            min-height: 100vh;
            color: var(--dark);
            padding: 2rem;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }
        
        .header h2 {
            font-size: 1.8rem;
            color: var(--dark);
            position: relative;
        }
        
        .header h2::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 0;
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            border-radius: 2px;
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
        
        .message {
            padding: 0.8rem 1rem;
            border-radius: 6px;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            animation: slideIn 0.3s ease-out;
        }
        
        @keyframes slideIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .error-message {
            background-color: rgba(247, 37, 133, 0.1);
            color: var(--warning);
            border: 1px solid rgba(247, 37, 133, 0.3);
        }
        
        .success-message {
            background-color: rgba(76, 201, 240, 0.1);
            color: #0c7a93;
            border: 1px solid rgba(76, 201, 240, 0.3);
        }
        
        .dataTables_wrapper {
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
            padding: 1.5rem;
            overflow: hidden;
        }
        
        table.dataTable {
            width: 100% !important;
            border-collapse: collapse;
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
        
        .action-btns {
            display: flex;
            gap: 0.5rem;
        }
        
        .action-btn {
            width: 30px;
            height: 30px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
        }
        
        .action-btn.edit {
            background-color: rgba(67, 97, 238, 0.1);
            color: var(--primary);
        }
        
        .action-btn.edit:hover {
            background-color: rgba(67, 97, 238, 0.2);
        }
        
        .action-btn.delete {
            background-color: rgba(247, 37, 133, 0.1);
            color: var(--warning);
        }
        
        .action-btn.delete:hover {
            background-color: rgba(247, 37, 133, 0.2);
        }
        
        .no-products {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            text-align: center;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
        }
        
        .no-products i {
            font-size: 2.5rem;
            color: var(--gray);
            margin-bottom: 1rem;
        }
        
        .no-products p {
            margin-bottom: 1.5rem;
            color: var(--gray);
        }
        
        .dataTables_filter input {
            padding: 0.5rem 0.8rem;
            border: 1px solid var(--border);
            border-radius: 6px;
        }
        
        .dataTables_length select {
            padding: 0.4rem 0.8rem;
            border: 1px solid var(--border);
            border-radius: 6px;
        }
        
        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }
            
            .header h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>



<body>
    <div class="container">
        <div class="header">
            <h2>Product Inventory</h2>
            <div>
            <a href="index.jsp" class="btn btn-outline" style="text-decoration:none">
                    <i class="fas fa-arrow-left"></i> Back to Home
                </a>
                <a href="productadd.jsp" class="btn btn-primary" style="text-decoration:none">
                    <i class="fas fa-plus"></i> Add Product
                </a>
                <a href="report_form.jsp" class="btn btn-outline" style="text-decoration:none">
                    <i class="fas fa-chart-pie"></i> Generate Report
                </a>
            </div>
        </div>
        
        <% 
            String message = (String) request.getAttribute("message");
            if (message != null) { 
        %>
            <div class="message error-message">
                <i class="fas fa-exclamation-circle"></i> <%= message %>
            </div>
        <% } %>
        
        <% 
            List<Product> products = (List<Product>) request.getAttribute("products");
            if (products != null && !products.isEmpty()) { 
        %>
            <div class="dataTables_wrapper">
                <table id="productsTable" class="display" style="width:100%">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Product Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Product product : products) { %>
                            <tr>
                                <td style="text-align:center;"><%= product.getProductID() %></td>
                                <td style="text-align:center;"><%= product.getProductName() %></td>
                                <td style="text-align:center;"><%= product.getCategory() %></td>
                                <td style="text-align:center;">$<%= String.format("%.2f", product.getPrice()) %></td>
                                <td style="text-align:center;">
                                    <% if (product.getQuantity() > 10) { %>
                                        <span class="badge badge-success"><%= product.getQuantity() %> in stock</span>
                                    <% } else { %>
                                        <span class="badge badge-warning"><%= product.getQuantity() %> remaining</span>
                                    <% } %>
                                </td>
                             <!--    <td>
                                    <div class="action-btns">
                                        <a href="productupdate.jsp?id=<%= product.getProductID() %>" class="action-btn edit" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="productdelete.jsp?id=<%= product.getProductID() %>" class="action-btn delete" title="Delete">
                                            <i class="fas fa-trash-alt"></i>
                                        </a>
                                    </div>
                                </td>  -->
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } else { %>
            <div class="no-products">
                <i class="fas fa-box-open"></i>
                <h3>No Products Found</h3>
                <p>Your inventory is currently empty. Add your first product to get started.</p>
                <a href="productadd.jsp" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add Product
                </a>
            </div>
        <% } %>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#productsTable').DataTable({
                responsive: true,
                language: {
                    search: "_INPUT_",
                    searchPlaceholder: "Search products...",
                    lengthMenu: "Show _MENU_ products per page",
                    info: "Showing _START_ to _END_ of _TOTAL_ products",
                    infoEmpty: "No products available",
                    infoFiltered: "(filtered from _MAX_ total products)",
                    paginate: {
                        first: "First",
                        last: "Last",
                        next: "Next",
                        previous: "Previous"
                    }
                },
                dom: '<"top"f>rt<"bottom"lip><"clear">',
                initComplete: function() {
                    $('.dataTables_filter input').addClass('form-control');
                    $('.dataTables_length select').addClass('form-control');
                }
            });
            
            // Add confirmation for delete actions
            $('.action-btn.delete').on('click', function(e) {
                if (!confirm('Are you sure you want to delete this product?\n\nThis action cannot be undone.')) {
                    e.preventDefault();
                }
            });
        });
    </script>
</body>
</html>