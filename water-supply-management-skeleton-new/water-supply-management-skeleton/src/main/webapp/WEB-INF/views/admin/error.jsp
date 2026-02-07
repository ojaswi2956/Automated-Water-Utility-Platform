<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AquaFlow - System Error</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .error-container {
            background: white;
            border-radius: 15px;
            padding: 40px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            max-width: 600px;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <i class="fas fa-exclamation-triangle fa-4x text-warning mb-4"></i>
        <h1 class="h2 mb-3">System Error</h1>
        <p class="text-muted mb-4">
            The application encountered an error while processing your request. 
            This is likely due to a database connection issue.
        </p>
        
        <div class="alert alert-info text-start">
            <h6><i class="fas fa-info-circle me-2"></i>Troubleshooting Steps:</h6>
            <ul class="mb-0">
                <li>Ensure MongoDB is running on localhost:27017</li>
                <li>Check the application console for detailed error messages</li>
                <li>Try refreshing the page after starting MongoDB</li>
            </ul>
        </div>
        
        <div class="mt-4">
            <a href="/admin/dashboard" class="btn btn-primary me-2">
                <i class="fas fa-home me-2"></i>Return to Dashboard
            </a>
            <a href="/test/issues" class="btn btn-outline-secondary">
                <i class="fas fa-flask me-2"></i>Test Mode
            </a>
        </div>
        
        <hr class="my-4">
        <small class="text-muted">
            <strong>Error Details:</strong><br>
            Status: ${status}<br>
            Path: ${path}<br>
            Timestamp: ${timestamp}
        </small>
    </div>
</body>
</html>