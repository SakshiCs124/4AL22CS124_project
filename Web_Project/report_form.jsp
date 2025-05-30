<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Generate Reports | Inventory System</title>
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
            --report-bg: #f0f4ff;
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
        
        .report-container {
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            width: 100%;
            max-width: 800px;
            padding: 2.5rem;
            animation: fadeIn 0.5s ease-out;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .report-header {
            text-align: center;
            margin-bottom: 2rem;
            position: relative;
        }
        
        .report-header h2 {
            color: var(--dark);
            font-size: 1.8rem;
            font-weight: 600;
        }
        
        .report-header::after {
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
        
        .report-criteria {
            background-color: var(--report-bg);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }
        
        .criteria-group {
            margin-bottom: 1.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px dashed rgba(67, 97, 238, 0.3);
        }
        
        .criteria-group:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }
        
        .criteria-title {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1rem;
            color: var(--primary-dark);
            font-weight: 500;
        }
        
        .criteria-title i {
            font-size: 1.1rem;
        }
        
        .form-row {
            display: flex;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
        }
        
        .form-control {
            padding: 0.8rem 1rem;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background-color: white;
            min-width: 200px;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.8rem 1.8rem;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.95rem;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }
        
        .btn-primary:active {
            transform: translateY(0);
        }
        
        .btn-outline {
            background: transparent;
            color: var(--primary);
            border: 1px solid var(--primary);
        }
        
        .btn-outline:hover {
            background-color: rgba(67, 97, 238, 0.1);
        }
        
        .report-actions {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 1rem;
            margin-top: 1.5rem;
        }
        
        .report-types {
            margin-bottom: 2rem;
        }
        
        .report-type-title {
            margin-bottom: 1rem;
            color: var(--dark);
            font-weight: 500;
        }
        
        .type-buttons {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        
        .type-btn {
            padding: 0.6rem 1rem;
            border-radius: 6px;
            background-color: white;
            border: 1px solid var(--border);
            cursor: pointer;
            transition: all 0.2s ease;
            font-size: 0.9rem;
        }
        
        .type-btn:hover {
            border-color: var(--primary);
            color: var(--primary);
        }
        
        .type-btn.active {
            background-color: var(--primary);
            color: white;
            border-color: var(--primary);
        }
        
        @media (max-width: 768px) {
            .report-container {
                padding: 1.5rem;
            }
            
            .report-header h2 {
                font-size: 1.5rem;
            }
            
            .form-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }
            
            .form-control {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="report-container">
        <div class="report-header">
            <h2>Generate Inventory Reports</h2>
        </div>
        
        
        
        <form action="reportCriteria" method="post" id="reportForm">
            <div class="report-criteria">
                <div class="criteria-group">
                    <div class="criteria-title">
                        <i class="fas fa-dollar-sign"></i>
                        <span>Price Filter</span>
                    </div>
                    <div class="form-row">
                        <span>Show products with price greater than:</span>
                        <input type="number" step="0.01" name="price" class="form-control" placeholder="0.00">
                    </div>
                </div>
                
                <div class="criteria-group">
                    <div class="criteria-title">
                        <i class="fas fa-tags"></i>
                        <span>Category Filter</span>
                    </div>
                    <div class="form-row">
                        <span>Show products in category:</span>
                        <input type="text" name="category" class="form-control" placeholder="All categories">
                    </div>
                </div>
                
                <div class="criteria-group">
                    <div class="criteria-title">
                        <i class="fas fa-sort-amount-down"></i>
                        <span>Quantity Filter</span>
                    </div>
                    <div class="form-row">
                        <span>Show top</span>
                        <input type="number" name="topN" class="form-control" placeholder="10" style="width: 80px;">
                        <span>products by quantity</span>
                    </div>
                </div>
            </div>
            
            <div class="report-actions">
                <div>
                <button type="button" class="btn btn-primary" onclick="window.location.href='index.jsp';">
    <i class="fas fa-arrow-left"></i> Back To Home
</button>

                </div>
                <div style="display: flex; gap: 0.5rem;">
                    <button type="reset" class="btn btn-outline">
                        <i class="fas fa-undo"></i> Reset
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-file-export"></i> Generate Report
                    </button>
                </div>
            </div>
        </form>
    </div>

    <script>
        // Handle report type selection
        document.querySelectorAll('.type-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                document.querySelectorAll('.type-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                
                // In a real application, you would update form fields based on report type
                console.log('Selected report type:', this.dataset.type);
            });
        });
        
        // Form validation
        document.getElementById('reportForm').addEventListener('submit', function(e) {
            // Add any specific validation logic here
            console.log('Generating report with criteria...');
        });
    </script>
</body>
</html>