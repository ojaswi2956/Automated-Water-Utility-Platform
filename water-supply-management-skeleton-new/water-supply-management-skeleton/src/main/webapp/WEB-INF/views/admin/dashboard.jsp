
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AquaFlow Admin - Dashboard</title>
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
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Dashboard</h2>
            <a href="/auth/logout" class="btn btn-outline-danger">
                <i class="fas fa-sign-out-alt me-2"></i>Logout
            </a>
        </div>

        <!-- Active Shortage Alert -->
        <div class="alert alert-shortage mb-4">
            <i class="fas fa-exclamation-triangle me-2"></i>
            <strong>Active Shortage Alert:</strong> Low water levels detected in Tank C, affecting Sector 4 and Sector 12. Supply is currently reduced by 50%.
        </div>

        <!-- Metrics Cards -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="metric-card text-center">
                    <i class="fas fa-tint fa-2x text-primary mb-2"></i>
                    <h4>${totalCapacity}L</h4>
                    <p class="text-muted">Total Capacity</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="metric-card text-center">
                    <i class="fas fa-water fa-2x text-info mb-2"></i>
                    <h4>${currentWater}L</h4>
                    <p class="text-muted">Current Water</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="metric-card text-center">
                    <i class="fas fa-users fa-2x text-success mb-2"></i>
                    <h4>${totalPopulation}</h4>
                    <p class="text-muted">Total Population</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="metric-card text-center">
                    <i class="fas fa-chart-line fa-2x text-warning mb-2"></i>
                    <h4>${totalDemand}L/day</h4>
                    <p class="text-muted">Daily Demand</p>
                </div>
            </div>
        </div>

        <!-- Charts Row -->
        <div class="row mb-4">
            <div class="col-md-8">
                <div class="metric-card">
                    <h5 class="mb-3">Water Distribution Overview</h5>
                    <div class="chart-container">
                        <canvas id="distributionChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="metric-card">
                    <h5 class="mb-3">System Status</h5>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span>Overall Health</span>
                        <span class="status-badge status-${systemStatus eq 'OK' ? 'normal' : 'critical'}">${systemStatus}</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span>Water Coverage</span>
                        <span class="badge bg-primary">${(currentWater / totalDemand * 100) > 100 ? 100 : (currentWater / totalDemand * 100)}%</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span>Active Alerts</span>
                        <span class="badge bg-danger">3</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Activity -->
        <div class="metric-card">
            <h5 class="mb-3">Recent Activity & Notifications</h5>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Type</th>
                            <th>Description</th>
                            <th>Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><i class="fas fa-exclamation-triangle text-danger me-2"></i>Shortage</td>
                            <td>Low pressure reported in Sector 12. Tank level at 15%.</td>
                            <td>11-09-2025 11:30 PM</td>
                            <td><span class="status-badge status-critical">Active</span></td>
                        </tr>
                        <tr>
                            <td><i class="fas fa-dollar-sign text-success me-2"></i>Payment</td>
                            <td>Bill for August 2025 successfully paid.</td>
                            <td>11-09-2025 02:15 PM</td>
                            <td><span class="status-badge status-normal">Completed</span></td>
                        </tr>
                        <tr>
                            <td><i class="fas fa-cog text-primary me-2"></i>Maintenance</td>
                            <td>Scheduled maintenance for main pump on 15-09-2025.</td>
                            <td>10-09-2025 09:00 AM</td>
                            <td><span class="badge bg-primary">Scheduled</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Distribution Chart
        const ctx = document.getElementById('distributionChart').getContext('2d');
        const distributionChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Available Water', 'Reserved Water'],
                datasets: [{
                    data: [75, 25],
                    backgroundColor: [
                        '#28a745',
                        '#007bff'
                    ],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });
    </script>
</body>
</html>
