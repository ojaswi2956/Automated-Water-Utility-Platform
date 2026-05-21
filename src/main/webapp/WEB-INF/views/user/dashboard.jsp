<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AquaFlow User - Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
        .alert-maintenance {
            background: linear-gradient(45deg, #17a2b8, #138496);
            color: white;
            border: none;
            border-radius: 10px;
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
        .chart-container {
            position: relative;
            height: 300px;
        }
        .bill-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
        }
        .bill-amount {
            font-size: 2.5rem;
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
            <a class="nav-link active" href="/user/dashboard">
                <i class="fas fa-tachometer-alt me-2"></i>My Dashboard
            </a>
            <a class="nav-link" href="/user/bills">
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
            <h2>My Dashboard</h2>
            <a href="/auth/logout" class="btn btn-outline-danger">
                <i class="fas fa-sign-out-alt me-2"></i>Logout
            </a>
        </div>

        <!-- Maintenance Alert -->
        <div class="alert alert-maintenance mb-4">
            <i class="fas fa-info-circle me-2"></i>
            <strong>Scheduled maintenance in your area on 15-09-2025.</strong> Expect low pressure between 10 AM - 2 PM.
        </div>

        <!-- Metrics Cards -->
        <div class="row mb-4">
            <div class="col-md-4 mb-3">
    <div class="metric-card text-center">
        <i class="fas fa-rupee-sign fa-2x text-primary mb-2"></i>
        <h4 class="text-primary">
            <c:choose>
                <c:when test="${not empty dashboardBill}">₹${dashboardBill.amount}</c:when>
                <c:otherwise>₹0.00</c:otherwise>
            </c:choose>
        </h4>
        <p class="text-muted">Current Bill</p>        
    </div>
</div>
            <div class="col-md-4 mb-3">
                <div class="metric-card text-center">
                    <i class="fas fa-tint fa-2x text-info mb-2"></i>
                    <h4>1,250 L</h4>
                    <p class="text-muted">Monthly Consumption</p>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="metric-card text-center">
                    <i class="fas fa-check-circle fa-2x text-success mb-2"></i>
                    <h4 class="text-success">Active</h4>
                    <p class="text-muted">Service Status</p>
                </div>
            </div>
        </div>

        <!-- Charts and Billing -->
        <div class="row">
            <div class="col-md-8">
                <div class="metric-card">
                    <h5 class="mb-3">Your Recent Consumption</h5>
                    <div class="chart-container">
                        <canvas id="consumptionChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="bill-card">
            <h5 class="mb-3">Current Bill</h5>
            <div class="bill-amount">
                <c:choose>
                    <c:when test="${not empty dashboardBill}">₹${dashboardBill.amount}</c:when>
                    <c:otherwise>₹0.00</c:otherwise>
                </c:choose>
            </div>
            <p class="mb-2">
                Due Date:
                <c:choose>
                    <c:when test="${not empty dashboardBill}">${dashboardBill.dueDate}</c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </p>
            <c:if test="${not empty dashboardBill && not dashboardBill.paid}">
                <button class="pay-btn w-100">
                    <i class="fas fa-credit-card me-2"></i>Pay Now
                </button>
            </c:if>
        </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Consumption Chart
        const ctx = document.getElementById('consumptionChart').getContext('2d');
        const consumptionChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                datasets: [{
                    label: 'Litres',
                    data: [180, 220, 190, 250, 280, 200, 150],
                    backgroundColor: [
                        'rgba(102, 126, 234, 0.8)',
                        'rgba(102, 126, 234, 0.8)',
                        'rgba(102, 126, 234, 0.8)',
                        'rgba(102, 126, 234, 0.8)',
                        'rgba(102, 126, 234, 0.8)',
                        'rgba(102, 126, 234, 0.8)',
                        'rgba(102, 126, 234, 0.8)'
                    ],
                    borderColor: [
                        'rgba(102, 126, 234, 1)',
                        'rgba(102, 126, 234, 1)',
                        'rgba(102, 126, 234, 1)',
                        'rgba(102, 126, 234, 1)',
                        'rgba(102, 126, 234, 1)',
                        'rgba(102, 126, 234, 1)',
                        'rgba(102, 126, 234, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 300,
                        ticks: {
                            stepSize: 50
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    }
                }
            }
        });
    </script>
</body>
</html>