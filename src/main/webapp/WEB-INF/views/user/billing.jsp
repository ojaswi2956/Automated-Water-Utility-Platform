<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AquaFlow User - Billing</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .sidebar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            z-index: 1000;
        }
        .sidebar .nav-link {
            color: rgba(255,255,255,0.8);
            padding: 12px 20px;
            border-radius: 8px;
            margin: 4px 12px;
            transition: all 0.3s ease;
        }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            background: rgba(255,255,255,0.2);
            color: white;
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        .bill-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
        }
        .bill-amount {
            font-size: 3rem;
            font-weight: bold;
            margin: 10px 0;
        }
        .pay-btn {
            background: rgba(255,255,255,0.2);
            border: 2px solid white;
            color: white;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        .pay-btn:hover {
            background: white;
            color: #667eea;
        }
        .history-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .status-paid {
            background: #d4edda;
            color: #155724;
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: bold;
        }
        .status-pending {
            background: #fff3cd;
            color: #856404;
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="p-4">
            <h4 class="text-white mb-4">
                <i class="fas fa-water me-2"></i>AquaFlow
                <span class="badge bg-light text-dark ms-2">User</span>
            </h4>
        </div>
        <nav class="nav flex-column">
            <a class="nav-link" href="/user/dashboard">
                <i class="fas fa-tachometer-alt me-2"></i>My Dashboard
            </a>
            <a class="nav-link active" href="/user/billing">
                <i class="fas fa-file-invoice me-2"></i>Billing
            </a>
            <a class="nav-link" href="/user/report">
                <i class="fas fa-exclamation-triangle me-2"></i>Report Issue
            </a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Billing</h2>
            <a href="/auth/logout" class="btn btn-outline-danger">
                <i class="fas fa-sign-out-alt me-2"></i>Logout
            </a>
        </div>

        <!-- Current Bill -->
        <div class="bill-card">
            <h5 class="mb-3">Current Bill (August 2025)</h5>
            <div class="bill-amount">₹750.00</div>
            <p class="mb-3">Due Date: 20-09-2025</p>
            <button class="pay-btn">
                <i class="fas fa-credit-card me-2"></i>Pay Now
            </button>
        </div>

        <!-- Billing History -->
        <div class="history-card">
            <h5 class="mb-3">Billing History</h5>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Period</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Due Date</th>
                            <th>Paid Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><strong>July 2025</strong></td>
                            <td>₹720.00</td>
                            <td><span class="status-paid">Paid</span></td>
                            <td>20-08-2025</td>
                            <td>18-08-2025</td>
                        </tr>
                        <tr>
                            <td><strong>June 2025</strong></td>
                            <td>₹685.00</td>
                            <td><span class="status-paid">Paid</span></td>
                            <td>20-07-2025</td>
                            <td>15-07-2025</td>
                        </tr>
                        <tr>
                            <td><strong>May 2025</strong></td>
                            <td>₹712.00</td>
                            <td><span class="status-paid">Paid</span></td>
                            <td>20-06-2025</td>
                            <td>22-06-2025</td>
                        </tr>
                        <tr>
                            <td><strong>April 2025</strong></td>
                            <td>₹698.00</td>
                            <td><span class="status-paid">Paid</span></td>
                            <td>20-05-2025</td>
                            <td>19-05-2025</td>
                        </tr>
                        <tr>
                            <td><strong>March 2025</strong></td>
                            <td>₹653.00</td>
                            <td><span class="status-paid">Paid</span></td>
                            <td>20-04-2025</td>
                            <td>18-04-2025</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Pay Now button functionality
        document.querySelector('.pay-btn').addEventListener('click', function() {
            alert('Payment gateway integration coming soon!');
        });
    </script>
</body>
</html>



