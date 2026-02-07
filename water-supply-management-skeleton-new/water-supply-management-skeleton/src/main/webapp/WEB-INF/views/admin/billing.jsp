<!-- filepath: c:\Users\Manan\Downloads\Final_Java_project\water-supply-management-skeleton-new\water-supply-management-skeleton\src\main\webapp\WEB-INF\views\admin\billing.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AquaFlow Admin - Billing Management</title>
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
        .alert-shortage {
            background: linear-gradient(45deg, #ff6b6b, #ee5a52);
            color: white;
            border: none;
            border-radius: 10px;
        }
        .chart-container {
            position: relative;
            height: 300px;
        }
        .metric-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .metric-card:hover {
            transform: translateY(-5px);
        }
        .status-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: bold;
        }
        .status-normal { background: #d4edda; color: #155724; }
        .status-critical { background: #f8d7da; color: #721c24; }
        .status-revised { background: #fff3cd; color: #856404; }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="p-4">
            <h4 class="text-white mb-4">
                <i class="fas fa-water me-2"></i>AquaFlow
                <span class="badge bg-light text-dark ms-2">Admin</span>
            </h4>
        </div>
        <nav class="nav flex-column">
            <a class="nav-link active" href="/admin/dashboard">
                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
            </a>
            <a class="nav-link" href="/admin/operations">
                <i class="fas fa-cogs me-2"></i>Operations
            </a>
            <a class="nav-link" href="/admin/distribution">
                <i class="fas fa-project-diagram me-2"></i>Distribution
            </a>
            <a class="nav-link" href="/admin/users">
                <i class="fas fa-users me-2"></i>User Management
            </a>
            <a class="nav-link" href="/admin/issues">
                <i class="fas fa-exclamation-triangle me-2"></i>Issue Management
            </a>

            <a class="nav-link" href="http://localhost:8081/alerts/shortage-alert" target="_blank">
            <i class="fas fa-bell me-2"></i>Shortage Alert
            </a>
            <a class="nav-link" href="/admin/billing">
            <i class="fas fa-file-invoice-dollar me-2"></i>Your Bills
            </a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h2>User List - Generate Bill</h2>
        <table class="table table-bordered table-hover bg-white">
            <thead>
                <tr>
                    <th>User</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.username}</td>
                        <td>${user.email}</td>
                        <td>${user.role}</td>
                        <td>
                            <button class="btn btn-sm btn-primary" onclick="generateBill('${user.id}')">
                                <i class="fas fa-file-invoice"></i> Generate Bill
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <h2 class="mt-5">All Bills</h2>
        <button class="btn btn-generate mb-3" onclick="generateAllBills()">
            <i class="fas fa-plus-circle me-2"></i>Generate Bills for All Users
        </button>
        <table class="table table-bordered table-hover bg-white">
            <thead>
                <tr>
                    <th>User</th>
                    <th>Email</th>
                    <th>Consumption (L)</th>
                    <th>Bill Amount (₹)</th>
                    <th>Status</th>
                    <th>Due Date</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="bill" items="${bills}">
                    <tr>
                        <td>${bill.username}</td>
                        <td>${bill.email}</td>
                        <td>${bill.consumption}</td>
                        <td>₹${bill.amount}</td>
                        <td>
                            <span class="badge ${bill.paid ? 'bg-success' : 'bg-warning text-dark'}">
                                ${bill.paid ? 'Paid' : 'Pending'}
                            </span>
                        </td>
                        <td>${bill.dueDate}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <script>
        function generateBill(userId) {
            fetch('/admin/billing/generate/' + userId, { method: 'POST' })
                .then(res => res.json())
                .then(data => {
                    alert(data.message || 'Bill generated!');
                    location.reload();
                });
        }
        function generateAllBills() {
            fetch('/admin/billing/generate-all', { method: 'POST' })
                .then(res => res.json())
                .then(data => {
                    alert(data.message || 'Bills generated for all users!');
                    location.reload();
                });
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>