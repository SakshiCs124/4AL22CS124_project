<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Delete Product | Inventory System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --danger: #f72585;
            --danger-dark: #e5177b;
            --dark: #1a1a2e;
            --light: #f8f9fa;
            --gray: #6c757d;
            --border: #e0e0e0;
            --warning-bg: #fff3f5;
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
            max-width: 500px;
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
            background: linear-gradient(90deg, var(--danger), #f55d8a);
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
            border-color: var(--danger);
            box-shadow: 0 0 0 3px rgba(247, 37, 133, 0.1);
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
        
        .btn-danger {
            background: linear-gradient(135deg, var(--danger), var(--danger-dark));
            color: white;
            width: 100%;
            margin-top: 1rem;
        }
        
        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(247, 37, 133, 0.3);
        }
        
        .btn-danger:active {
            transform: translateY(0);
        }
        
        .warning-box {
            background-color: var(--warning-bg);
            border-left: 4px solid var(--danger);
            padding: 1rem;
            margin-bottom: 1.5rem;
            border-radius: 0 8px 8px 0;
            display: flex;
            align-items: flex-start;
            gap: 0.8rem;
        }
        
        .warning-icon {
            color: var(--danger);
            font-size: 1.2rem;
            margin-top: 2px;
        }
        
        .warning-content h4 {
            color: var(--danger);
            margin-bottom: 0.3rem;
            font-size: 1rem;
        }
        
        .warning-content p {
            color: var(--gray);
            font-size: 0.85rem;
            line-height: 1.5;
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
            <h2>Delete Product</h2>
        </div>
        
        <div class="warning-box">
            <i class="fas fa-exclamation-triangle warning-icon"></i>
            <div class="warning-content">
                <h4>Warning: Permanent Action</h4>
                <p>Deleting a product will permanently remove it from the inventory system. This action cannot be undone. Please verify the product ID before proceeding.</p>
            </div>
        </div>
        
        <form action="deleteProduct" method="post" id="deleteForm">
            <div class="form-group">
                <label for="productID">Product ID to Delete</label>
                <input type="number" id="productID" name="productID" class="form-control" required>
                <i class="fas fa-barcode input-icon"></i>
            </div>
            
            <div class="form-group">
                <label for="confirmation">Type "DELETE" to confirm</label>
                <input type="text" id="confirmation" name="confirmation" class="form-control" required 
                       pattern="DELETE" title="Please type DELETE to confirm">
                <i class="fas fa-check-circle input-icon"></i>
            </div>
            
            <button type="submit" class="btn btn-danger">
                <i class="fas fa-trash-alt"></i> Permanently Delete Product
            </button>
        </form>
        
        <% if (request.getAttribute("message") != null) { %>
            <div class="message success-message">
                <i class="fas fa-check-circle"></i> <%= request.getAttribute("message") %>
            </div>
        <% } %>
        
        <div class="form-footer">
            <div>
    <button type="button" class="btn btn-primary custom-back-btn" onclick="window.location.href='index.jsp';">
        <i class="fas fa-arrow-left"></i> Back To Home
    </button>
</div>
        </div>
    </div>

    <script>
        document.getElementById('deleteForm').addEventListener('submit', function(e) {
            const confirmation = document.getElementById('confirmation');
            if (confirmation.value !== 'DELETE') {
                e.preventDefault();
                confirmation.style.borderColor = 'var(--danger)';
                alert('Please type "DELETE" in the confirmation field to proceed');
            }
        });

        // Add confirmation dialog for extra safety
        document.getElementById('deleteForm').addEventListener('submit', function(e) {
            if (!confirm('Are you absolutely sure you want to delete this product?\n\nThis action cannot be undone.')) {
                e.preventDefault();
            }
        });
    </script>
</body>
</html>