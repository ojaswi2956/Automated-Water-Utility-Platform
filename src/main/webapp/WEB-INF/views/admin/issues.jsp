<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AquaFlow Admin - Issue Management</title>
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
            <h2>Issue Management</h2>
            <a href="/auth/logout" class="btn btn-outline-danger">
                <i class="fas fa-sign-out-alt me-2"></i>Logout
            </a>
        </div>

        <!-- Error Message (if any) -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>
                <strong>Error:</strong> ${error}
                <br><small>The page will still display with limited functionality.</small>
            </div>
        </c:if>

        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="fas fa-exclamation-triangle fa-2x text-primary mb-2"></i>
                    <h4 class="text-primary">${totalIssues}</h4>
                    <p class="text-muted">Total Issues</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="fas fa-clock fa-2x text-danger mb-2"></i>
                    <h4 class="text-danger">${openIssues}</h4>
                    <p class="text-muted">Open Issues</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="fas fa-tools fa-2x text-warning mb-2"></i>
                    <h4 class="text-warning">${inProgressIssues}</h4>
                    <p class="text-muted">In Progress</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="fas fa-check-circle fa-2x text-success mb-2"></i>
                    <h4 class="text-success">${resolvedIssues}</h4>
                    <p class="text-muted">Resolved</p>
                </div>
            </div>
        </div>

        <!-- Issues Table -->
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0"><i class="fas fa-list me-2"></i>All Issues</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Issue ID</th>
                                <th>User</th>
                                <th>Title</th>
                                <th>Type</th>
                                <th>Priority</th>
                                <th>Status</th>
                                <th>Assigned To</th>
                                <th>Created</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="issue" items="${issues}">
                                <tr class="status-${issue.status.toLowerCase().replace('_', '')}">
                                    <td>${issue.issueId}</td>
                                    <td>
                                        <div>
                                            <strong>${issue.username}</strong><br>
                                            <small class="text-muted">${issue.userEmail}</small>
                                        </div>
                                    </td>
                                    <td>${issue.title}</td>
                                    <td>
                                        <span class="badge bg-secondary">${issue.issueType}</span>
                                    </td>
                                    <td>
                                        <span class="badge bg-${issue.priority eq 'HIGH' ? 'danger' : issue.priority eq 'MEDIUM' ? 'warning' : 'info'}">
                                            ${issue.priority}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge bg-${issue.status eq 'OPEN' ? 'danger' : issue.status eq 'IN_PROGRESS' ? 'warning' : 'success'}">
                                            ${issue.status eq 'OPEN' ? 'Open' : issue.status eq 'IN_PROGRESS' ? 'In Progress' : 'Resolved'}
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty issue.assignedTo}">
                                                <span class="badge bg-primary">${issue.assignedTo}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Unassigned</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${issue.createdAt}</td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <button class="btn btn-sm btn-outline-primary" onclick="viewIssue('${issue.id}')" title="View Details">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <c:if test="${issue.status eq 'OPEN'}">
                                                <button class="btn btn-sm btn-outline-warning" onclick="assignIssue('${issue.id}')" title="Assign">
                                                    <i class="fas fa-user-plus"></i>
                                                </button>
                                            </c:if>
                                            <c:if test="${issue.status eq 'IN_PROGRESS'}">
                                                <button class="btn btn-sm btn-outline-success" onclick="resolveIssue('${issue.id}')" title="Resolve">
                                                    <i class="fas fa-check"></i>
                                                </button>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Assign Issue Modal -->
    <div class="modal fade" id="assignModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Assign Issue</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="assignForm">
                        <input type="hidden" id="assignIssueId">
                        <div class="mb-3">
                            <label class="form-label">Assign to Admin</label>
                            <select class="form-select" id="assignedTo" required>
                                <option value="">Select Admin</option>
                                <c:forEach var="admin" items="${admins}">
                                    <option value="${admin.id}">${admin.username}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="confirmAssign()">Assign</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Resolve Issue Modal -->
    <div class="modal fade" id="resolveModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Resolve Issue</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="resolveForm">
                        <input type="hidden" id="resolveIssueId">
                        <div class="mb-3">
                            <label class="form-label">Resolution Details</label>
                            <textarea class="form-control" id="resolution" rows="4" placeholder="Describe how the issue was resolved..." required></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-success" onclick="confirmResolve()">Mark as Resolved</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let assignModal, resolveModal;

        document.addEventListener('DOMContentLoaded', function() {
            assignModal = new bootstrap.Modal(document.getElementById('assignModal'));
            resolveModal = new bootstrap.Modal(document.getElementById('resolveModal'));
        });

        function viewIssue(id) {
            // Implementation for viewing issue details
            console.log('View issue:', id);
        }

        function assignIssue(id) {
            document.getElementById('assignIssueId').value = id;
            assignModal.show();
        }

        function confirmAssign() {
            const issueId = document.getElementById('assignIssueId').value;
            const assignedTo = document.getElementById('assignedTo').value;

            fetch('/admin/issues/assign/' + issueId + '?assignedTo=' + assignedTo, {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    assignModal.hide();
                    location.reload();
                } else {
                    alert('Error: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error assigning issue:', error);
                alert('Error assigning issue');
            });
        }

        function resolveIssue(id) {
            document.getElementById('resolveIssueId').value = id;
            resolveModal.show();
        }

        function confirmResolve() {
            const issueId = document.getElementById('resolveIssueId').value;
            const resolution = document.getElementById('resolution').value;

            fetch('/admin/issues/resolve/' + issueId + '?resolution=' + encodeURIComponent(resolution), {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    resolveModal.hide();
                    location.reload();
                } else {
                    alert('Error: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error resolving issue:', error);
                alert('Error resolving issue');
            });
        }
    </script>
</body>
</html>