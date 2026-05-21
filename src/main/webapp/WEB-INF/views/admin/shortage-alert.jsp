<!-- filepath: alert-service/src/main/webapp/WEB-INF/jsp/shortage-alert.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Send Water Shortage Alert</title>
</head>
<body>
    <h2>Send Water Shortage Alert</h2>
    <form action="${pageContext.request.contextPath}/alerts/send-shortage-alert" method="post">
        <label for="email">User Email:</label>
        <input type="email" id="email" name="email" required /><br/><br/>
        <label for="date">Shortage Date:</label>
        <input type="date" id="date" name="date" required /><br/><br/>
        <button type="submit">Send Alert</button>
    </form>
    <p style="color:green;">
        ${message != null ? message : ""}
    </p>
</body>
</html>