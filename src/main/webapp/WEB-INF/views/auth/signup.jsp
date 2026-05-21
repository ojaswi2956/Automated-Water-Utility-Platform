<!-- filepath: c:\Users\Manan\Downloads\Final_Java_project\water-supply-management-skeleton-new\water-supply-management-skeleton\src\main\webapp\WEB-INF\views\auth\signup.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AquaFlow - Sign Up</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: #f6f8fb;
            min-height: 100vh;
        }
        .signup-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card-signup {
            width: 100%;
            max-width: 420px;
            border-radius: 18px;
            box-shadow: 0 4px 32px 0 rgba(80, 80, 120, 0.10);
            border: none;
            padding: 32px 32px 24px 32px;
        }
        .brand-icon {
            font-size: 2.5rem;
            color: #3b82f6;
        }
        .signup-title {
            font-weight: 700;
            font-size: 1.7rem;
            margin-bottom: 0.5rem;
        }
        .signup-subtitle {
            color: #6b7280;
            font-size: 1rem;
            margin-bottom: 1.5rem;
        }
        .form-label {
            font-weight: 500;
        }
        .btn-signup {
            background: #3b82f6;
            color: #fff;
            font-weight: 600;
            border-radius: 8px;
            transition: background 0.2s;
        }
        .btn-signup:hover {
            background: #2563eb;
        }
        .hint {
            color: #6b7280;
            font-size: 0.95rem;
        }
        .card-signup .alert {
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
<div class="signup-wrapper">
    <div class="card card-signup">
        <div class="text-center mb-3">
            <i class="fas fa-water brand-icon"></i>
            <div class="signup-title mt-2">AquaFlow</div>
            <div class="signup-subtitle">Create your account to get started.</div>
        </div>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <form action="/auth/signup" method="post" autocomplete="off">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control" id="username" name="username"
                       value="${signupRequest.username}" required minlength="3" maxlength="20" placeholder="Choose a username">
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email"
                       value="${signupRequest.email}" required placeholder="Enter your email">
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password"
                       required minlength="6" placeholder="Create a password">
            </div>
            <button type="submit" class="btn btn-signup w-100 py-2 mt-2">
                Sign Up
            </button>
        </form>
        <div class="text-center mt-3">
            <span class="hint">Already have an account?</span>
            <a href="/auth/login" class="ms-1">Login</a>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>