<%@ include file="../shared/header.jsp" %>

<div class="container mt-4">
    <div class="row">
        <div class="col-12">
            <h2 class="mb-4"><i class="fas fa-history me-2"></i>System Logs</h2>
        </div>
    </div>

    <!-- Logs Table -->
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-info text-white">
                    <h5 class="mb-0"><i class="fas fa-list me-2"></i>Water Supply Logs</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Timestamp</th>
                                    <th>Tank ID</th>
                                    <th>Area ID</th>
                                    <th>Log Type</th>
                                    <th>Water Amount</th>
                                    <th>Status</th>
                                    <th>Notes</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="log" items="${logs}">
                                    <tr>
                                        <td>${log.timestamp}</td>
                                        <td>${log.tankId}</td>
                                        <td>${log.areaId}</td>
                                        <td>
                                            <span class="badge bg-${log.logType eq 'SUPPLY' ? 'success' : log.logType eq 'CONSUMPTION' ? 'info' : log.logType eq 'REFILL' ? 'primary' : 'warning'}">
                                                ${log.logType}
                                            </span>
                                        </td>
                                        <td>${log.waterAmount}L</td>
                                        <td>
                                            <span class="badge bg-${log.status eq 'SUCCESS' ? 'success' : log.status eq 'FAILED' ? 'danger' : 'warning'}">
                                                ${log.status}
                                            </span>
                                        </td>
                                        <td>${log.notes}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../shared/footer.jsp" %>
