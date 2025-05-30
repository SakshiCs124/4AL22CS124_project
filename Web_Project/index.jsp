<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Inventory System</title>
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
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            min-height: 100vh;
            color: var(--dark);
            padding: 2rem;
        }
        
        h1 {
            text-align: center;
            margin: 2rem 0;
            font-size: 2.5rem;
            color: var(--dark);
            position: relative;
            display: inline-block;
            left: 50%;
            transform: translateX(-50%);
        }
        
        h1::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            border-radius: 2px;
        }
        
        .container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            max-width: 1200px;
            margin: 0 auto;
            padding: 1rem;
        }
        
        .card {
            background: white;
            border-radius: 12px;
            padding: 2rem 1.5rem;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.12);
        }
        
        .card a {
            text-decoration: none;
            color: var(--dark);
            font-weight: 500;
            font-size: 1.1rem;
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            transition: color 0.3s ease;
        }
        
        .card i {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: var(--primary);
            transition: all 0.3s ease;
        }
        
        .card:hover i {
            color: var(--accent);
            transform: scale(1.1);
        }
        
        .card:hover a {
            color: var(--primary-dark);
        }
        
        .extra-buttons {
            grid-column: 1 / -1;
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 1rem;
        }
        
        .btn {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.95rem;
        }
        
        .btn-primary {
            background-color: var(--primary);
            color: white;
        }
        
        .btn-primary:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }
        
        .btn-secondary {
            background-color: white;
            color: var(--primary);
            border: 1px solid var(--primary);
        }
        
        .btn-secondary:hover {
            background-color: var(--primary);
            color: white;
            transform: translateY(-2px);
        }
        
        .btn-warning {
            background-color: var(--warning);
            color: white;
        }
        
        .btn-warning:hover {
            background-color: #e5177b;
            transform: translateY(-2px);
        }
        .stats-bar {
    grid-column: 1 / -1;
    background: white;
    border-radius: 12px;
    padding: 1.5rem;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
    gap: 1.5rem;
    margin-bottom: 1rem;
    border: 1px solid rgba(0, 0, 0, 0.03);
}

.stat-item {
    text-align: center;
    padding: 1rem;
    min-width: 200px;
    flex: 1;
    position: relative;
    transition: all 0.3s ease;
}

.stat-item:hover {
    transform: translateY(-5px);
}

.stat-icon {
    position: relative;
    width: 60px;
    height: 60px;
    margin: 0 auto 1rem;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
    color: white;
    background: linear-gradient(135deg, var(--primary), var(--accent));
    border-radius: 50%;
    box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
}

.pulse-effect {
    position: absolute;
    width: 100%;
    height: 100%;
    border-radius: 50%;
    background: inherit;
    opacity: 0;
    animation: pulse 2s infinite;
}

.stat-label {
    font-weight: 600;
    font-size: 1.1rem;
    color: var(--dark);
    margin-bottom: 0.5rem;
}

.stat-desc {
    font-size: 0.85rem;
    color: var(--gray);
    line-height: 1.4;
}

@keyframes pulse {
    0% {
        transform: scale(1);
        opacity: 0.7;
    }
    70% {
        transform: scale(1.4);
        opacity: 0;
    }
    100% {
        transform: scale(1);
        opacity: 0;
    }
}

/* Different colors for each icon */
.stat-item:nth-child(1) .stat-icon {
    background: linear-gradient(135deg, #4361ee, #4895ef);
}
.stat-item:nth-child(2) .stat-icon {
    background: linear-gradient(135deg, #4cc9f0, #3f37c9);
}
.stat-item:nth-child(3) .stat-icon {
    background: linear-gradient(135deg, #f72585, #b5179e);
}
.stat-item:nth-child(4) .stat-icon {
    background: linear-gradient(135deg, #3a0ca3, #7209b7);
}
        
        .btn-success {
            background-color: var(--success);
            color: white;
        }
        
        .btn-success:hover {
            background-color: #3ab5d9;
            transform: translateY(-2px);
        }
        
        .stats-bar {
            grid-column: 1 / -1;
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 1rem;
            margin-bottom: 1rem;
        }
        
        .stat-item {
            text-align: center;
            padding: 0.5rem 1rem;
        }
        
        .stat-value {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 0.2rem;
        }
        
        .stat-label {
            font-size: 0.9rem;
            color: var(--gray);
        }
        
        @media (max-width: 768px) {
            .container {
                grid-template-columns: 1fr;
            }
            
            h1 {
                font-size: 2rem;
            }
        }
        
        /* Animation classes */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .animate {
            animation: fadeIn 0.6s ease forwards;
        }
        
        .delay-1 { animation-delay: 0.1s; }
        .delay-2 { animation-delay: 0.2s; }
        .delay-3 { animation-delay: 0.3s; }
        .delay-4 { animation-delay: 0.4s; }
        .delay-5 { animation-delay: 0.5s; }
    </style>
</head>
<body>
    <h1 class="animate">Product Inventory Dashboard</h1>
    
    <div class="stats-bar animate delay-1">
    <div class="stat-item">
        <div class="stat-icon">
            <i class="fas fa-boxes"></i>
            <div class="pulse-effect"></div>
        </div>
        <div class="stat-label">Track All Products</div>
        <div class="stat-desc">Complete inventory overview</div>
    </div>
    
    <div class="stat-item">
        <div class="stat-icon">
            <i class="fas fa-dollar-sign"></i>
            <div class="pulse-effect"></div>
        </div>
        <div class="stat-label">Monitor Inventory Value</div>
        <div class="stat-desc">Real-time financial insights</div>
    </div>
    
    <div class="stat-item">
        <div class="stat-icon">
            <i class="fas fa-exclamation-triangle"></i>
            <div class="pulse-effect"></div>
        </div>
        <div class="stat-label">Low Stock Alerts</div>
        <div class="stat-desc">Never run out of stock</div>
    </div>
    
    <div class="stat-item">
        <div class="stat-icon">
            <i class="fas fa-tags"></i>
            <div class="pulse-effect"></div>
        </div>
        <div class="stat-label">Organized Categories</div>
        <div class="stat-desc">Efficient product grouping</div>
    </div>
</div>
    
    <div class="container">
        <div class="card animate delay-1">
            <a href="productadd.jsp">
                <i class="fas fa-plus-circle"></i>
                Add New Product
                <span class="hint">Create new inventory items</span>
            </a>
        </div>
        
        <div class="card animate delay-2">
            <a href="productupdate.jsp">
                <i class="fas fa-edit"></i>
                Update Product
                <span class="hint">Modify existing items</span>
            </a>
        </div>
        
        <div class="card animate delay-3">
            <a href="productdelete.jsp">
                <i class="fas fa-trash-alt"></i>
                Delete Product
                <span class="hint">Remove items from inventory</span>
            </a>
        </div>
        
       <div class="card animate delay-4">
            <a href="displayProducts">
                <i class="fas fa-list-ul"></i>
                View All Products
                <span class="hint">Browse complete inventory</span>
            </a>
        </div>
        
        <div class="card animate delay-5">
            <a href="report_form.jsp">
                <i class="fas fa-chart-bar"></i>
                Generate Reports
                <span class="hint">Create inventory analytics</span>
            </a>
        </div>  
        
       
    </div>
    


    <script>
        // Add animation class to elements as they come into view
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.classList.add(`delay-${(index % 5) + 1}`);
            });
            
            // Simple fade-in animation on load
            setTimeout(() => {
                cards.forEach(card => {
                    card.classList.add('animate');
                });
            }, 100);
        });
    </script>
</body>
</html>