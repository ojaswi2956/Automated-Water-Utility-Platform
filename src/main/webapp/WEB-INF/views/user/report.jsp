<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AquaFlow User - Report Issue</title>
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
        .issue-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .issue-type {
            background: #f8f9fa;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 15px;
            margin: 10px 0;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .issue-type:hover {
            border-color: #667eea;
            background: #f0f2ff;
        }
        .issue-type.selected {
            border-color: #667eea;
            background: #e3f2fd;
        }
        .priority-high { border-left: 5px solid #dc3545; }
        .priority-medium { border-left: 5px solid #ffc107; }
        .priority-low { border-left: 5px solid #28a745; }
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
            <a class="nav-link" href="/user/bills">
                <i class="fas fa-file-invoice me-2"></i>Billing
            </a>
            <a class="nav-link active" href="/user/report">
                <i class="fas fa-exclamation-triangle me-2"></i>Report Issue
            </a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Report Issue</h2>
            <a href="/auth/logout" class="btn btn-outline-danger">
                <i class="fas fa-sign-out-alt me-2"></i>Logout
            </a>
        </div>

        <!-- Issue Types -->
        <div class="issue-card">
            <h5 class="mb-3">Select Issue Type</h5>
            <div class="row">
                <div class="col-md-4 mb-3">
                    <div class="issue-type priority-high" onclick="selectIssueType('no-water')">
                        <i class="fas fa-tint-slash fa-2x text-danger mb-2"></i>
                        <h6>No Water Supply</h6>
                        <small class="text-muted">Complete water outage</small>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="issue-type priority-medium" onclick="selectIssueType('low-pressure')">
                        <i class="fas fa-tint fa-2x text-warning mb-2"></i>
                        <h6>Low Water Pressure</h6>
                        <small class="text-muted">Reduced water flow</small>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="issue-type priority-low" onclick="selectIssueType('water-quality')">
                        <i class="fas fa-exclamation-triangle fa-2x text-info mb-2"></i>
                        <h6>Water Quality Issue</h6>
                        <small class="text-muted">Taste, color, or smell</small>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="issue-type priority-medium" onclick="selectIssueType('leak')">
                        <i class="fas fa-tools fa-2x text-warning mb-2"></i>
                        <h6>Water Leak</h6>
                        <small class="text-muted">Visible water leak</small>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="issue-type priority-low" onclick="selectIssueType('billing')">
                        <i class="fas fa-file-invoice fa-2x text-primary mb-2"></i>
                        <h6>Billing Issue</h6>
                        <small class="text-muted">Payment or bill related</small>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="issue-type priority-low" onclick="selectIssueType('other')">
                        <i class="fas fa-question-circle fa-2x text-secondary mb-2"></i>
                        <h6>Other</h6>
                        <small class="text-muted">Other issues</small>
                    </div>
                </div>
            </div>
        </div>

        <!-- Issue Form -->
        <div class="issue-card">
            <h5 class="mb-3">Issue Details</h5>
            <form id="issueForm">
                <div class="mb-3">
                    <label for="issueTitle" class="form-label">Issue Title</label>
                    <input type="text" class="form-control" id="issueTitle" placeholder="Brief description of the issue" required>
                </div>
                <div class="mb-3">
                    <label for="issueDescription" class="form-label">Detailed Description</label>
                    <textarea class="form-control" id="issueDescription" rows="4" placeholder="Please provide detailed information about the issue..." required></textarea>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="issueLocation" class="form-label">Location</label>
                        <input type="text" class="form-control" id="issueLocation" placeholder="Your address or area" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="issuePriority" class="form-label">Priority</label>
                        <select class="form-select" id="issuePriority" required>
                            <option value="">Select Priority</option>
                            <option value="high">High - Urgent</option>
                            <option value="medium">Medium - Important</option>
                            <option value="low">Low - General</option>
                        </select>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="contactPhone" class="form-label">Contact Phone</label>
                    <input type="tel" class="form-control" id="contactPhone" placeholder="Your phone number for updates">
                </div>
                <div class="mb-3">
                    <label class="form-label">Upload Photos (Optional)</label>
                    <input type="file" class="form-control" id="issuePhotos" multiple accept="image/*">
                    <small class="text-muted">You can upload up to 3 photos to help us understand the issue better.</small>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary btn-lg">
                        <i class="fas fa-paper-plane me-2"></i>Submit Issue Report
                    </button>
                </div>
            </form>
        </div>

        <!-- Recent Issues -->
        <div class="issue-card">
            <h5 class="mb-3">Your Recent Issues</h5>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Issue ID</th>
                            <th>Type</th>
                            <th>Status</th>
                            <th>Date</th>
                            <th>Priority</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="issue" items="${userIssues}">
                            <tr>
                                <td>${issue.issueId}</td>
                                <td>${issue.title}</td>
                                <td>
                                    <span class="badge bg-${issue.status eq 'OPEN' ? 'danger' : issue.status eq 'IN_PROGRESS' ? 'warning' : 'success'}">
                                        ${issue.status eq 'OPEN' ? 'Open' : issue.status eq 'IN_PROGRESS' ? 'In Progress' : 'Resolved'}
                                    </span>
                                </td>
                                <td>${issue.createdAt}</td>
                                <td>
                                    <span class="badge bg-${issue.priority eq 'HIGH' ? 'danger' : issue.priority eq 'MEDIUM' ? 'warning' : 'info'}">
                                        ${issue.priority}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty userIssues}">
                            <tr>
                                <td colspan="5" class="text-center text-muted">No issues reported yet</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let selectedIssueType = '';

        function selectIssueType(type) {
            // Remove previous selection
            document.querySelectorAll('.issue-type').forEach(el => {
                el.classList.remove('selected');
            });
            
            // Add selection to clicked element
            event.currentTarget.classList.add('selected');
            selectedIssueType = type;
            
            // Auto-fill title based on type
            const titleField = document.getElementById('issueTitle');
            const typeMap = {
                'no-water': 'No Water Supply',
                'low-pressure': 'Low Water Pressure',
                'water-quality': 'Water Quality Issue',
                'leak': 'Water Leak',
                'billing': 'Billing Issue',
                'other': 'Other Issue'
            };
            titleField.value = typeMap[type] || '';
        }

        document.getElementById('issueForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            if (!selectedIssueType) {
                alert('Please select an issue type first.');
                return;
            }
            
            const formData = {
                issueType: selectedIssueType,
                title: document.getElementById('issueTitle').value,
                description: document.getElementById('issueDescription').value,
                location: document.getElementById('issueLocation').value,
                priority: document.getElementById('issuePriority').value,
                contactPhone: document.getElementById('contactPhone').value
            };
            
            fetch('/user/report/submit', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(formData)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Issue report submitted successfully! Issue ID: ' + data.issueId);
                    // Reset form
                    this.reset();
                    document.querySelectorAll('.issue-type').forEach(el => {
                        el.classList.remove('selected');
                    });
                    selectedIssueType = '';
                    // Reload the page to show updated issues
                    location.reload();
                } else {
                    alert('Error: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error submitting issue:', error);
                alert('Error submitting issue report');
            });
        });
    </script>
</body>
</html>


