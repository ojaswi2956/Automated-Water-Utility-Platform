<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AquaFlow Admin - Operations</title>
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
        .alert-shortage {
            background: linear-gradient(45deg, #ff6b6b, #ee5a52);
            color: white;
            border: none;
            border-radius: 10px;
        }
        .tank-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            border-left: 5px solid #28a745;
        }
        .tank-card.critical {
            border-left-color: #dc3545;
        }
        .tank-card.warning {
            border-left-color: #ffc107;
        }
        .progress-custom {
            height: 20px;
            border-radius: 10px;
        }
        .nav-tabs .nav-link {
            border: none;
            color: #6c757d;
            font-weight: 500;
        }
        .nav-tabs .nav-link.active {
            color: #495057;
            border-bottom: 3px solid #007bff;
        }
        .table th {
            border-top: none;
            font-weight: 600;
            color: #495057;
        }
        .status-badge {
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
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
            <h2>Operations</h2>
            <a href="/auth/logout" class="btn btn-outline-danger">
                <i class="fas fa-sign-out-alt me-2"></i>Logout
            </a>
        </div>

        <!-- Active Shortage Alert -->
        <div class="alert alert-shortage mb-4">
            <i class="fas fa-exclamation-triangle me-2"></i>
            <strong>Active Shortage Alert:</strong> Low water levels detected in Tank C, affecting Sector 4 and Sector 12. Supply is currently reduced by 50%.
        </div>

        <!-- Management Actions -->
		<div class="row mb-4">
		    <div class="col-md-4 d-flex">
		        <div class="card text-center h-100 w-100">
		            <div class="card-body d-flex flex-column">
		                <i class="fas fa-water-tower fa-3x text-primary mb-3"></i>
		                <h5 class="card-title">Tank Management</h5>
		                <p class="card-text flex-grow-1">Manage water tanks, monitor levels, and update status</p>
		                <a href="/admin/tanks" class="btn btn-primary mt-auto">
		                    <i class="fas fa-cogs me-2"></i>Manage Tanks
		                </a>
		            </div>
		        </div>
		    </div>

		    <div class="col-md-4 d-flex">
		        <div class="card text-center h-100 w-100">
		            <div class="card-body d-flex flex-column">
		                <i class="fas fa-map-marked-alt fa-3x text-success mb-3"></i>
		                <h5 class="card-title">Area Management</h5>
		                <p class="card-text flex-grow-1">Manage service areas, population, and water demand</p>
		                <a href="/admin/areas" class="btn btn-success mt-auto">
		                    <i class="fas fa-cogs me-2"></i>Manage Areas
		                </a>
		            </div>
		        </div>
		    </div>

		    <div class="col-md-4 d-flex">
		        <div class="card text-center h-100 w-100">
		            <div class="card-body d-flex flex-column">
		                <i class="fas fa-calendar-alt fa-3x text-warning mb-3"></i>
		                <h5 class="card-title">Schedule Management</h5>
		                <p class="card-text flex-grow-1">Create and manage water supply schedules</p>
		                <a href="/admin/schedules" class="btn btn-warning mt-auto">
		                    <i class="fas fa-cogs me-2"></i>Manage Schedules
		                </a>
		            </div>
		        </div>
		    </div>
		</div>


        <!-- Tabs -->
        <ul class="nav nav-tabs mb-4" id="operationsTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="tanks-tab" data-bs-toggle="tab" data-bs-target="#tanks" type="button" role="tab">
                    <i class="fas fa-water-tower me-2"></i>Tanks Overview
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="areas-tab" data-bs-toggle="tab" data-bs-target="#areas" type="button" role="tab">
                    <i class="fas fa-map-marked-alt me-2"></i>Areas Overview
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="schedule-tab" data-bs-toggle="tab" data-bs-target="#schedule" type="button" role="tab">
                    <i class="fas fa-calendar-alt me-2"></i>Schedule Overview
                </button>
            </li>
        </ul>

        <div class="tab-content" id="operationsTabContent">
            <!-- Tanks Tab -->
            <div class="tab-pane fade show active" id="tanks" role="tabpanel">
                <div class="row">
                    <c:forEach var="tank" items="${tanks}">
                        <div class="col-md-4 mb-3">
                            <div class="tank-card ${tank.percentage < 20 ? 'critical' : ''}">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h5 class="mb-0">${tank.name}</h5>
                                    <c:choose>
                                        <c:when test="${tank.percentage < 20}">
                                            <span class="status-badge status-critical">Critical Low</span>
                                        </c:when>
                                        <c:when test="${tank.percentage < 50}">
                                            <span class="status-badge status-warning">Low</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-normal">Normal</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <p class="text-muted mb-2">Capacity: ${tank.capacity} L</p>
                                <p class="mb-2">Current Level: ${tank.currentLevel} L (<fmt:formatNumber value="${tank.percentage}" pattern="#.#"/>%)</p>
                                <div class="progress progress-custom">
                                    <c:choose>
                                        <c:when test="${tank.percentage < 20}">
                                            <div class="progress-bar bg-danger" data-width="${tank.percentage}"></div>
                                        </c:when>
                                        <c:when test="${tank.percentage < 50}">
                                            <div class="progress-bar bg-warning" data-width="${tank.percentage}"></div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="progress-bar bg-primary" data-width="${tank.percentage}"></div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty tanks}">
                        <div class="col-12">
                            <div class="alert alert-info text-center">
                                <i class="fas fa-info-circle me-2"></i>No tanks found. <a href="/admin/tanks">Create your first tank</a> to get started.
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Areas Tab -->
            <div class="tab-pane fade" id="areas" role="tabpanel">
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Area/Sector</th>
                                        <th>Population</th>
                                        <th>Avg. Consumption</th>
                                        <th>Supply Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="area" items="${areas}">
                                        <tr>
                                            <td><strong>${area.name}</strong></td>
                                            <td>${area.population}</td>
                                            <td>${area.waterDemand} L/hr</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${area.waterDemand > 600}">
                                                        <span class="status-badge status-critical">High Demand</span>
                                                    </c:when>
                                                    <c:when test="${area.waterDemand > 400}">
                                                        <span class="status-badge status-warning">Moderate</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge status-normal">Normal</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty areas}">
                                        <tr>
                                            <td colspan="4" class="text-center text-muted">
                                                <i class="fas fa-info-circle me-2"></i>No areas found. <a href="/admin/areas">Create your first area</a> to get started.
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Supply Schedule Tab -->
            <div class="tab-pane fade" id="schedule" role="tabpanel">
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Area/Sector</th>
                                        <th>Day</th>
                                        <th>Start Time</th>
                                        <th>End Time</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="schedule" items="${schedules}">
                                        <tr>
                                            <td><strong>${schedule.areaId}</strong></td>
                                            <td>${schedule.frequency}</td>
                                            <td>${schedule.startTime}</td>
                                            <td>${schedule.endTime}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${schedule.active}">
                                                        <span class="status-badge status-normal">Active</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge status-critical">Inactive</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty schedules}">
                                        <tr>
                                            <td colspan="5" class="text-center text-muted">
                                                <i class="fas fa-info-circle me-2"></i>No schedules found. <a href="/admin/schedules">Create your first schedule</a> to get started.
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Set progress bar widths from data attributes
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.progress-bar[data-width]').forEach(function(bar) {
                const width = bar.getAttribute('data-width');
                bar.style.width = width + '%';
            });
        });
    </script>
</body>
</html>


