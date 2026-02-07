<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AquaFlow Admin - Distribution</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
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
        .network-map {
            background: #f8f9fa;
            border: 2px dashed #dee2e6;
            border-radius: 15px;
            min-height: 400px;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .network-node {
            position: absolute;
            background: white;
            border-radius: 50%;
            width: 80px;
            height: 80px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            cursor: pointer;
            transition: transform 0.3s ease;
        }
        .network-node:hover {
            transform: scale(1.1);
        }
        .node-reservoir { top: 20px; left: 50px; background: #007bff; color: white; }
        .node-tank { top: 20px; right: 50px; background: #28a745; color: white; }
        .node-pump { top: 50%; left: 50%; transform: translate(-50%, -50%); background: #ffc107; color: #212529; }
        .node-sector { bottom: 20px; background: #6c757d; color: white; }
        .node-sector-1 { left: 20px; }
        .node-sector-2 { right: 20px; }
        .control-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 34px;
        }
        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 34px;
        }
        .slider:before {
            position: absolute;
            content: "";
            height: 26px;
            width: 26px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }
        input:checked + .slider {
            background-color: #28a745;
        }
        input:checked + .slider:before {
            transform: translateX(26px);
        }
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
            <h2>Distribution</h2>
            <a href="/auth/logout" class="btn btn-outline-danger">
                <i class="fas fa-sign-out-alt me-2"></i>Logout
            </a>
        </div>

        <!-- Distribution Network Map -->
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title mb-3">Distribution Network Map</h5>
                <div class="network-map">
                    <!-- Reservoir A -->
                    <div class="network-node node-reservoir" title="Reservoir A - 1,000,000L (85%)">
                        <i class="fas fa-water-tower fa-2x mb-1"></i>
                        <small>Reservoir A</small>
                    </div>
                    
                    <!-- Tank B -->
                    <div class="network-node node-tank" title="Tank B - 250,000L (80%)">
                        <i class="fas fa-tint fa-2x mb-1"></i>
                        <small>Tank B</small>
                    </div>
                    
                    <!-- Pump 1 -->
                    <div class="network-node node-pump" title="Pump 1 - Active">
                        <i class="fas fa-cog fa-2x mb-1"></i>
                        <small>Pump 1</small>
                    </div>
                    
                    <!-- Sector 4 -->
                    <div class="network-node node-sector node-sector-1" title="Sector 4 - 12,500 people">
                        <i class="fas fa-building fa-2x mb-1"></i>
                        <small>Sector 4</small>
                    </div>
                    
                    <!-- Sector 8 -->
                    <div class="network-node node-sector node-sector-2" title="Sector 8 - 15,000 people">
                        <i class="fas fa-building fa-2x mb-1"></i>
                        <small>Sector 8</small>
                    </div>
                </div>
            </div>
        </div>

        <!-- Control Panels -->
        <div class="row">
            <div class="col-md-6">
                <div class="control-card">
                    <h5 class="mb-3">Device Control Panel</h5>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div>
                            <strong>Main Pump 1</strong>
                            <br>
                            <small class="text-muted">Status: <span class="text-success">ON</span></small>
                        </div>
                        <label class="toggle-switch">
                            <input type="checkbox" checked>
                            <span class="slider"></span>
                        </label>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div>
                            <strong>Valve S4-A</strong>
                            <br>
                            <small class="text-muted">Status: <span class="text-danger">OFF</span></small>
                        </div>
                        <label class="toggle-switch">
                            <input type="checkbox">
                            <span class="slider"></span>
                        </label>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <strong>Valve S8-B</strong>
                            <br>
                            <small class="text-muted">Status: <span class="text-success">ON</span></small>
                        </div>
                        <label class="toggle-switch">
                            <input type="checkbox" checked>
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="control-card">
                    <h5 class="mb-3">Maintenance Schedule</h5>
                    <div class="list-group list-group-flush">
                        <div class="list-group-item d-flex justify-content-between align-items-center border-0 px-0">
                            <div>
                                <strong>Pump 1</strong>
                                <br>
                                <small class="text-muted">Routine Check</small>
                            </div>
                            <span class="badge bg-primary">15/09/2025</span>
                        </div>
                        <div class="list-group-item d-flex justify-content-between align-items-center border-0 px-0">
                            <div>
                                <strong>Valve S4-A</strong>
                                <br>
                                <small class="text-muted">Replacement</small>
                            </div>
                            <span class="badge bg-warning">20/09/2025</span>
                        </div>
                        <div class="list-group-item d-flex justify-content-between align-items-center border-0 px-0">
                            <div>
                                <strong>Reservoir A</strong>
                                <br>
                                <small class="text-muted">Cleaning</small>
                            </div>
                            <span class="badge bg-info">25/09/2025</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Add click handlers for network nodes
        document.querySelectorAll('.network-node').forEach(node => {
            node.addEventListener('click', function() {
                const title = this.getAttribute('title');
                alert(title);
            });
        });

        // Add toggle switch functionality
        document.querySelectorAll('.toggle-switch input').forEach(toggle => {
            toggle.addEventListener('change', function() {
                // Find the status span in the same row
                const row = this.closest('.d-flex');
                const statusSpan = row.querySelector('small span');
                if (this.checked) {
                    statusSpan.textContent = 'ON';
                    statusSpan.className = 'text-success';
                } else {
                    statusSpan.textContent = 'OFF';
                    statusSpan.className = 'text-danger';
                }
            });
        });
    </script>
</body>
</html>



