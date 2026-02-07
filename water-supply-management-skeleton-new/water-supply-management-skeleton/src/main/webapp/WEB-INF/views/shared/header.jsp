<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AquaFlow</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-water me-2"></i>AquaFlow
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <c:if test="${not empty pageContext.request.userPrincipal}">
                        <c:if test="${pageContext.request.isUserInRole('ADMIN')}">
                            <li class="nav-item">
                                <a class="nav-link" href="/admin/dashboard">Dashboard</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/admin/tanks">Tanks</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/admin/areas">Areas</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/admin/schedules">Schedules</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/admin/users">Users</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/admin/issues">Issues</a>
                            </li>
                            
                        </c:if>
                        <c:if test="${pageContext.request.isUserInRole('USER')}">
                            <li class="nav-item">
                                <a class="nav-link" href="/user/dashboard">Dashboard</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/user/profile">Profile</a>
                            </li>
                        </c:if>
                    </c:if>
                </ul>
                <ul class="navbar-nav">
                    <c:if test="${not empty pageContext.request.userPrincipal}">
                        <li class="nav-item">
                            <span class="navbar-text me-3">Welcome, ${pageContext.request.userPrincipal.name}</span>
                        </li>
                        <li class="nav-item">
                            <form action="/auth/logout" method="post" class="d-inline">
                                <button type="submit" class="btn btn-outline-light btn-sm">Logout</button>
                            </form>
                        </li>
                    </c:if>
                    <c:if test="${empty pageContext.request.userPrincipal}">
                        <li class="nav-item">
                            <a class="nav-link" href="/auth/login">Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/auth/signup">Sign Up</a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </nav>
