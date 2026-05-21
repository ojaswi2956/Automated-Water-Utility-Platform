<!-- filepath: c:\Users\Manan\Downloads\Final_Java_project\water-supply-management-skeleton-new\water-supply-management-skeleton\src\main\webapp\WEB-INF\views\user\bills.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>AquaFlow User - Billing</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: #f6f8fb;
        }
        .sidebar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            width: 240px;
            position: fixed;
            top: 0;
            left: 0;
            color: #fff;
            padding: 32px 0 0 0;
            z-index: 100;
        }
        .sidebar .brand {
            font-size: 1.7rem;
            font-weight: 700;
            margin-bottom: 32px;
            text-align: center;
        }
        .sidebar .brand i {
            margin-right: 8px;
        }
        .sidebar .user-badge {
            background: #fff;
            color: #764ba2;
            font-weight: 600;
            border-radius: 8px;
            padding: 2px 12px;
            font-size: 1rem;
            margin-bottom: 24px;
            display: inline-block;
        }
        .sidebar .nav-link {
            color: #e0e7ff;
            font-size: 1.1rem;
            margin-bottom: 8px;
            border-radius: 8px;
            padding: 10px 24px;
            transition: background 0.2s;
        }
        .sidebar .nav-link.active, .sidebar .nav-link:hover {
            background: rgba(255,255,255,0.15);
            color: #fff;
        }
        .main-content {
            margin-left: 240px;
            padding: 40px 40px 20px 40px;
        }
        .current-bill-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff;
            border-radius: 20px;
            padding: 32px 32px 24px 32px;
            margin-bottom: 32px;
            box-shadow: 0 4px 24px 0 rgba(80, 80, 120, 0.10);
        }
        .current-bill-card h4 {
            font-weight: 600;
            margin-bottom: 12px;
        }
        .current-bill-amount {
            font-size: 2.8rem;
            font-weight: 700;
            margin-bottom: 8px;
        }
        .current-bill-date {
            font-size: 1.1rem;
            margin-bottom: 18px;
        }
        .pay-btn {
            border: 2px solid #fff;
            background: transparent;
            color: #fff;
            border-radius: 30px;
            padding: 8px 32px;
            font-size: 1.1rem;
            font-weight: 500;
            transition: background 0.2s, color 0.2s;
        }
        .pay-btn:hover {
            background: #fff;
            color: #764ba2;
        }
        .billing-history-card {
            background: #fff;
            border-radius: 16px;
            padding: 24px 24px 8px 24px;
            box-shadow: 0 2px 12px 0 rgba(80, 80, 120, 0.07);
        }
        .billing-history-card h5 {
            font-weight: 600;
            margin-bottom: 18px;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .badge-paid {
            background: #d1fae5;
            color: #059669;
            font-weight: 500;
            border-radius: 12px;
            padding: 6px 18px;
            font-size: 1rem;
        }
        .badge-pending {
            background: #fef3c7;
            color: #b45309;
            font-weight: 500;
            border-radius: 12px;
            padding: 6px 18px;
            font-size: 1rem;
        }
        .logout-btn {
            position: absolute;
            top: 24px;
            right: 32px;
        }
        @media (max-width: 900px) {
            .sidebar { width: 100%; position: static; min-height: auto; }
            .main-content { margin-left: 0; padding: 20px 5vw; }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="brand mb-2">
            <i class="fas fa-water"></i> AquaFlow
        </div>
        <div class="user-badge mb-4">User</div>
        <nav class="nav flex-column">
            <a class="nav-link" href="/user/dashboard"><i class="fas fa-home me-2"></i>My Dashboard</a>
            <a class="nav-link active" href="/user/bills"><i class="fas fa-file-invoice-dollar me-2"></i>Billing</a>
            <a class="nav-link" href="/user/report"><i class="fas fa-exclamation-circle me-2"></i>Report Issue</a>
        </nav>
    </div>

    <!-- Logout Button -->
    <a href="/logout" class="btn btn-outline-danger logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Current Bill Card -->
        <div class="current-bill-card">
            <h4>Current Bill <c:if test="${not empty currentBill}">(${currentBill.period})</c:if></h4>
            <div class="current-bill-amount">
                <c:choose>
                    <c:when test="${not empty currentBill}">₹${currentBill.amount}</c:when>
                    <c:otherwise>₹0.00</c:otherwise>
                </c:choose>
            </div>
            <div class="current-bill-date">
                Due Date:
                <c:choose>
                    <c:when test="${not empty currentBill}">${currentBill.dueDate}</c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </div>
            <c:if test="${not empty currentBill && not currentBill.paid}">
                <button class="pay-btn">Pay Now</button>
            </c:if>
        </div>

        <!-- Billing History -->
        <div class="billing-history-card">
            <h5>Billing History</h5>
            <table class="table table-borderless align-middle">
                <thead>
                    <tr>
                        <th>Period</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Due Date</th>
                        <th>Paid Date</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="bill" items="${billingHistory}">
                        <tr>
                            <td>${bill.period}</td>
                            <td>₹${bill.amount}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${bill.paid}">
                                        <span class="badge badge-paid">Paid</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-pending">Pending</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${bill.dueDate}</td>
                            <td>
                                <c:if test="${bill.paid}">${bill.paidDate}</c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty billingHistory}">
                        <tr>
                            <td colspan="5" class="text-center text-muted">No bills found.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>