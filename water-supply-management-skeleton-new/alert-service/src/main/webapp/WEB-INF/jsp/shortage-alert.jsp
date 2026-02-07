<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Send Water Shortage Alert - AquaFlow Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .alert-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
            color: #2c3e50;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .btn-primary {
            background-color: #3498db;
            border-color: #3498db;
            padding: 12px 30px;
            font-weight: 500;
        }
        .btn-primary:hover {
            background-color: #2980b9;
            border-color: #2980b9;
        }
        .alert-success {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
            padding: 15px;
            border-radius: 5px;
            margin-top: 20px;
        }
        .alert-error {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
            padding: 15px;
            border-radius: 5px;
            margin-top: 20px;
        }
        .back-link {
            color: #6c757d;
            text-decoration: none;
            font-size: 14px;
        }
        .back-link:hover {
            color: #495057;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="alert-container">
            <div class="header">
                <i class="fas fa-exclamation-triangle fa-3x text-warning mb-3"></i>
                <h2>Send Water Shortage Alert</h2>
                <p class="text-muted">Notify users about upcoming water shortage</p>
                <!-- <div class="alert alert-info">
                    <i class="fas fa-info-circle me-2"></i>
                    <strong>Note:</strong> If email is not configured, the system will simulate sending the email and display it in the console logs.
                </div> -->
            </div>
            
            <form action="${pageContext.request.contextPath}/alerts/send-shortage-alert" method="post">
                <div class="form-group">
                    <label for="email" class="form-label">
                        <i class="fas fa-envelope me-2"></i>User Email Address
                    </label>
                    <input type="email" class="form-control" id="email" name="email" 
                           placeholder="Enter user email address" required>
                </div>
                
                <div class="form-group">
                    <label for="date" class="form-label">
                        <i class="fas fa-calendar me-2"></i>Shortage Date
                    </label>
                    <input type="date" class="form-control" id="date" name="date" required>
                </div>
                
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-paper-plane me-2"></i>Send Alert
                    </button>
                </div>
            </form>
            
            <c:if test="${not empty message}">
                <div class="alert ${messageType == 'success' ? 'alert-success' : 'alert-error'}">
                    <i class="fas ${messageType == 'success' ? 'fa-check-circle' : 'fa-exclamation-triangle'} me-2"></i>${message}
                </div>
            </c:if>
            
            <div class="text-center mt-4">
                <a href="http://localhost:8080/admin/dashboard" class="back-link">
                    <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                </a>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>