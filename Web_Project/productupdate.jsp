<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Product | Inventory System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
        }
        
        .form-container {
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            width: 100%;
            max-width: 600px;
            padding: 2.5rem;
            animation: fadeIn 0.5s ease-out;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 2rem;
            position: relative;
        }
        
        .form-header h2 {
            color: var(--dark);
            font-size: 1.8rem;
            font-weight: 600;
        }
        
        .form-header::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            border-radius: 2px;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--dark);
            font-size: 0.95rem;
        }
        
        .form-control {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background-color: #f9fafb;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
            background-color: white;
        }
        
        .input-icon {
            position: absolute;
            right: 15px;
            top: 38px;
            color: var(--gray);
            font-size: 1rem;
        }
        
        .btn {
            display: inline-block;
            padding: 0.8rem 1.8rem;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.95rem;
            text-align: center;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            color: white;
            width: 100%;
            margin-top: 0.5rem;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }
        
        .btn-primary:active {
            transform: translateY(0);
        }
        
        .message {
            padding: 0.8rem 1rem;
            border-radius: 8px;
            margin-top: 1.5rem;
            text-align: center;
            font-size: 0.9rem;
            animation: slideIn 0.3s ease-out;
        }
        
        @keyframes slideIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .success-message {
            background-color: rgba(76, 201, 240, 0.1);
            color: #0c7a93;
            border: 1px solid rgba(76, 201, 240, 0.3);
        }
        
        .form-footer {
            text-align: center;
            margin-top: 1.5rem;
            font-size: 0.9rem;
            color: var(--gray);
        }
        
        .form-footer a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
        }
        
        .form-footer a:hover {
            text-decoration: underline;
        }
        
        .search-section {
            background-color: rgba(67, 97, 238, 0.05);
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border: 1px dashed rgba(67, 97, 238, 0.3);
        }
        
        .search-btn {
            background: linear-gradient(135deg, var(--secondary), var(--primary-dark));
        }
        
        @media (max-width: 768px) {
            .form-container {
                padding: 1.5rem;
            }
            
            .form-header h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <div class="form-header">
            <h2>Update Product Details</h2>
        </div>
        
  <!--       <div class="search-section">
            <div class="form-group">
                <label for="searchID">Find Product by ID</label>
                <div style="display: flex; gap: 0.5rem;">
                    <input type="number" id="searchID" class="form-control" placeholder="Enter product ID">
                    <button type="button" class="btn btn-primary search-btn" onclick="fetchProduct()">
                        <i class="fas fa-search"></i> Search
                    </button>
                </div>
            </div>
        </div> -->

        
        <form action="updateProduct" method="post" id="productForm">
            <div class="form-group">
                <label for="productID">Product ID</label>
                <input type="number" id="productID" name="productID" class="form-control" required >
                <i class="fas fa-barcode input-icon"></i>
            </div>
            
            <div class="form-group">
                <label for="productName">Product Name</label>
                <input type="text" id="productName" name="productName" class="form-control" required>
                <i class="fas fa-tag input-icon"></i>
            </div>
            
            <div class="form-group">
                <label for="category">Category</label>
                <input type="text" id="category" name="category" class="form-control" required>
                <i class="fas fa-folder input-icon"></i>
            </div>
            
            <div class="form-group">
                <label for="price">Price ($)</label>
                <input type="number" step="0.01" id="price" name="price" class="form-control" required>
                <i class="fas fa-dollar-sign input-icon"></i>
            </div>
            
            <div class="form-group">
                <label for="quantity">Quantity</label>
                <input type="number" id="quantity" name="quantity" class="form-control" required>
                <i class="fas fa-boxes input-icon"></i>
            </div>
            
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-save"></i> Update Product
            </button>
        </form>
        
        <% if (request.getAttribute("message") != null) { %>
            <div class="message success-message">
                <i class="fas fa-check-circle"></i> <%= request.getAttribute("message") %>
            </div>
        <% } %>
        
        <div>
    <button type="button" class="btn btn-primary custom-back-btn" onclick="window.location.href='index.jsp';">
        <i class="fas fa-arrow-left"></i> Back To Home
    </button>
</div>
    </div>

    <script>
        // Function to fetch product details (simulated for this example)
        function fetchProduct() {
            const productId = document.getElementById('searchID').value;
            if (!productId) {
                alert('Please enter a product ID');
                return;
            }
            
            // In a real application, you would make an AJAX call here
            // This is just a simulation with sample data
            const sampleProducts = {
                '1001': {
                    name: 'Wireless Headphones',
                    category: 'Electronics',
                    price: 89.99,
                    quantity: 25
                },
                '1002': {
                    name: 'Bluetooth Speaker',
                    category: 'Electronics',
                    price: 45.50,
                    quantity: 15
                },
                '1003': {
                    name: 'Smart Watch',
                    category: 'Wearables',
                    price: 199.99,
                    quantity: 8
                }
            };
            
            if (sampleProducts[productId]) {
                const product = sampleProducts[productId];
                document.getElementById('productID').value = productId;
                document.getElementById('productName').value = product.name;
                document.getElementById('category').value = product.category;
                document.getElementById('price').value = product.price;
                document.getElementById('quantity').value = product.quantity;
                
                // Enable all fields except ID
                document.querySelectorAll('#productForm input:not(#productID)').forEach(input => {
                    input.removeAttribute('readonly');
                });
            } else {
                alert('Product not found. Please check the ID and try again.');
            }
        }
        
        // Form validation
        document.getElementById('productForm').addEventListener('submit', function(e) {
            const inputs = this.querySelectorAll('input[required]');
            let isValid = true;
            
            inputs.forEach(input => {
                if (!input.value.trim()) {
                    input.style.borderColor = 'var(--warning)';
                    isValid = false;
                } else {
                    input.style.borderColor = 'var(--border)';
                }
            });
            
            if (!isValid) {
                e.preventDefault();
                alert('Please fill in all required fields');
            }
        });
    </script>
</body>
</html>