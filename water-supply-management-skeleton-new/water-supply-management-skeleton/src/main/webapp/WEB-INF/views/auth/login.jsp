
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AquaFlow - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #f5f7fb; }
        .login-wrapper { min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 24px; }
        .card-login { max-width: 520px; width: 100%; border: 0; border-radius: 16px; box-shadow: 0 10px 30px rgba(0,0,0,0.08); }
        .brand {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-top: 24px;
        }
        .brand-icon {
            font-size: 2.5rem;
            color: #2f6fed;
        }
        
        .brand h3 { margin: 0; color: #0f172a; font-weight: 700; }
        .hint { color: #6b7280; font-size: 0.9rem; }
        .btn-primary { background-color: #2f6fed; border-color: #2f6fed; }
        .btn-primary:hover { background-color: #255ee8; border-color: #255ee8; }
    </style>
</head>
<body>
<div class="login-wrapper">
    <div class="card card-login">
        <div class="card-body p-4 p-md-5">
            
            <div class="brand flex-column">
                <i class="fas fa-water brand-icon" style="font-size:2.5rem; color:#2f6fed;"></i>
                <h3 class="mt-2">AquaFlow</h3>
            </div>
            <h5 class="text-center mt-3 mb-1">Welcome Back</h5>
            <p class="text-center text-muted mb-4">Sign in to continue to your dashboard.</p>

            <c:if test="${not empty param.error}">
                <div class="alert alert-danger">Invalid username or password</div>
            </c:if>
            <c:if test="${not empty param.logout}">
                <div class="alert alert-success">You have been logged out successfully</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <form id="loginForm" class="mt-2">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" placeholder="e.g., admin or user" value="${loginRequest.username}" required>
                </div>
                <div class="mb-4">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" placeholder="Hint: use 'admin' or 'user'" required>
                </div>
                <button type="submit" class="btn btn-primary w-100 py-2">Login</button>
            </form>
            <div class="text-center mt-3">
            <span class="hint">Don't have an account?</span>
            <a href="/auth/signup" class="ms-1">Sign Up</a>
</div>

        </div>
    </div>
</div>

<script>
document.getElementById('loginForm').addEventListener('submit', async function (e) {
    e.preventDefault();
    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value.trim();
    const res = await fetch('/api/auth/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ username, password })
    });
    const data = await res.json();
    if (!res.ok || data.error) {
        alert(data.error || 'Login failed');
        return;
    }
    // Store token in cookie for filter or in localStorage
    document.cookie = 'AUTH_TOKEN=' + data.token + '; Path=/; SameSite=Lax';
    if (data.role === 'ROLE_ADMIN' || data.role === 'ADMIN' || data.role === 'admin') {
        window.location.href = '/admin/dashboard';
    } else {
        window.location.href = '/user/dashboard';
    }
});
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
