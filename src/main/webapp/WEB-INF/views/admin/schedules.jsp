<%@ include file="../shared/header.jsp" %>

<div class="container mt-4">
    <div class="row">
        <div class="col-12">
            <h2 class="mb-4"><i class="fas fa-calendar-alt me-2"></i>Manage Schedules</h2>
            
            <!-- Success/Error Messages -->
            <c:if test="${param.success != null}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>Schedule created successfully!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${param.error != null}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>Error creating schedule: ${param.message != null ? param.message : 'Please try again.'}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
        </div>
    </div>

    <!-- Add Schedule Form -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-plus-circle me-2"></i>Add New Schedule</h5>
                </div>
                <div class="card-body">
                    <form action="/admin/schedules/create" method="post">
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="form-label">Area</label>
                                <select class="form-select" name="areaId" required>
                                    <option value="">Select Area</option>
                                    <c:forEach var="area" items="${areas}">
                                        <option value="${area.id}">${area.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label">Tank</label>
                                <select class="form-select" name="tankId" required>
                                    <option value="">Select Tank</option>
                                    <c:forEach var="tank" items="${tanks}">
                                        <option value="${tank.id}">${tank.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-2 mb-3">
                                <label class="form-label">Start Time</label>
                                <input type="time" class="form-control" name="startTime" required>
                            </div>
                            <div class="col-md-2 mb-3">
                                <label class="form-label">End Time</label>
                                <input type="time" class="form-control" name="endTime" required>
                            </div>
                            <div class="col-md-2 mb-3">
                                <label class="form-label">Water Amount (L)</label>
                                <input type="number" class="form-control" name="waterAmount" step="0.01" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Frequency</label>
                                <select class="form-select" name="frequency" required>
                                    <option value="DAILY">Daily</option>
                                    <option value="WEEKLY">Weekly</option>
                                    <option value="CUSTOM">Custom</option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Status</label>
                                <select class="form-select" name="isActive">
                                    <option value="true">Active</option>
                                    <option value="false">Inactive</option>
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-plus me-2"></i>Add Schedule
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Schedules Table -->
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-info text-white">
                    <h5 class="mb-0"><i class="fas fa-list me-2"></i>Existing Schedules</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Area</th>
                                    <th>Tank</th>
                                    <th>Start Time</th>
                                    <th>End Time</th>
                                    <th>Water Amount</th>
                                    <th>Frequency</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="schedule" items="${schedules}">
                                    <tr>
                                        <td>${schedule.areaName != null ? schedule.areaName : 'Unknown Area'}</td>
                                        <td>${schedule.tankName != null ? schedule.tankName : 'Unknown Tank'}</td>
                                        <td>${schedule.startTime}</td>
                                        <td>${schedule.endTime}</td>
                                        <td>${schedule.waterAmount}L</td>
                                        <td>${schedule.frequency}</td>
                                        <td>
                                            <span class="badge bg-${schedule.active ? 'success' : 'secondary'}">
                                                ${schedule.active ? 'Active' : 'Inactive'}
                                            </span>
                                        </td>
                                        <td>
                                            <button class="btn btn-sm btn-primary" onclick="editSchedule('${schedule.id}')">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button class="btn btn-sm btn-${schedule.active ? 'warning' : 'success'}" 
                                                    onclick="toggleSchedule('${schedule.id}', ${!schedule.active})">
                                                <i class="fas fa-${schedule.active ? 'pause' : 'play'}"></i>
                                            </button>
                                            <button class="btn btn-sm btn-danger" onclick="deleteSchedule('${schedule.id}')">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </td>
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

<!-- Edit Schedule Modal -->
<div class="modal fade" id="editScheduleModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Schedule</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="editScheduleForm">
                    <input type="hidden" id="editScheduleId" name="id">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Area</label>
                            <select class="form-select" id="editScheduleAreaId" name="areaId" required>
                                <option value="">Select Area</option>
                                <c:forEach var="area" items="${areas}">
                                    <option value="${area.id}">${area.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Tank</label>
                            <select class="form-select" id="editScheduleTankId" name="tankId" required>
                                <option value="">Select Tank</option>
                                <c:forEach var="tank" items="${tanks}">
                                    <option value="${tank.id}">${tank.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Start Time</label>
                            <input type="time" class="form-control" id="editScheduleStartTime" name="startTime" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">End Time</label>
                            <input type="time" class="form-control" id="editScheduleEndTime" name="endTime" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Water Amount (L)</label>
                            <input type="number" class="form-control" id="editScheduleWaterAmount" name="waterAmount" step="0.01" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Frequency</label>
                            <select class="form-select" id="editScheduleFrequency" name="frequency" required>
                                <option value="DAILY">Daily</option>
                                <option value="WEEKLY">Weekly</option>
                                <option value="CUSTOM">Custom</option>
                            </select>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Status</label>
                        <select class="form-select" id="editScheduleIsActive" name="isActive">
                            <option value="true">Active</option>
                            <option value="false">Inactive</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="updateSchedule()">Update Schedule</button>
            </div>
        </div>
    </div>
</div>

<script>
let editScheduleModal;

document.addEventListener('DOMContentLoaded', function() {
    editScheduleModal = new bootstrap.Modal(document.getElementById('editScheduleModal'));
});

function editSchedule(id) {
    fetch('/admin/schedules/edit/' + id)
        .then(response => response.json())
        .then(schedule => {
            document.getElementById('editScheduleId').value = schedule.id;
            document.getElementById('editScheduleAreaId').value = schedule.areaId;
            document.getElementById('editScheduleTankId').value = schedule.tankId;
            
            // Format time for input fields
            const startTime = new Date(schedule.startTime);
            const endTime = new Date(schedule.endTime);
            document.getElementById('editScheduleStartTime').value = startTime.toTimeString().slice(0, 5);
            document.getElementById('editScheduleEndTime').value = endTime.toTimeString().slice(0, 5);
            
            document.getElementById('editScheduleWaterAmount').value = schedule.waterAmount;
            document.getElementById('editScheduleFrequency').value = schedule.frequency;
            document.getElementById('editScheduleIsActive').value = schedule.active;
            editScheduleModal.show();
        })
        .catch(error => {
            console.error('Error fetching schedule:', error);
            alert('Error loading schedule data');
        });
}

function updateSchedule() {
    const formData = {
        id: document.getElementById('editScheduleId').value,
        areaId: document.getElementById('editScheduleAreaId').value,
        tankId: document.getElementById('editScheduleTankId').value,
        startTime: new Date(document.getElementById('editScheduleStartTime').value),
        endTime: new Date(document.getElementById('editScheduleEndTime').value),
        waterAmount: parseFloat(document.getElementById('editScheduleWaterAmount').value),
        frequency: document.getElementById('editScheduleFrequency').value,
        active: document.getElementById('editScheduleIsActive').value === 'true'
    };

    fetch('/admin/schedules/update-ajax', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData)
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            editScheduleModal.hide();
            location.reload();
        } else {
            alert('Error: ' + data.message);
        }
    })
    .catch(error => {
        console.error('Error updating schedule:', error);
        alert('Error updating schedule');
    });
}

function toggleSchedule(id, active) {
    if (confirm('Are you sure you want to ' + (active ? 'activate' : 'deactivate') + ' this schedule?')) {
        fetch('/admin/schedules/toggle-ajax/' + id + '?active=' + active, {
            method: 'POST'
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                location.reload();
            } else {
                alert('Error: ' + data.message);
            }
        })
        .catch(error => {
            console.error('Error toggling schedule:', error);
            alert('Error toggling schedule');
        });
    }
}

function deleteSchedule(id) {
    if (confirm('Are you sure you want to delete this schedule?')) {
        fetch('/admin/schedules/delete-ajax/' + id, {
            method: 'POST'
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                location.reload();
            } else {
                alert('Error: ' + data.message);
            }
        })
        .catch(error => {
            console.error('Error deleting schedule:', error);
            alert('Error deleting schedule');
        });
    }
}

// Form validation
document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('form[action="/admin/schedules/create"]');
    if (form) {
        form.addEventListener('submit', function(e) {
            const areaId = form.querySelector('select[name="areaId"]').value;
            const tankId = form.querySelector('select[name="tankId"]').value;
            const startTime = form.querySelector('input[name="startTime"]').value;
            const endTime = form.querySelector('input[name="endTime"]').value;
            const waterAmount = form.querySelector('input[name="waterAmount"]').value;
            
            if (!areaId || !tankId || !startTime || !endTime || !waterAmount) {
                e.preventDefault();
                alert('Please fill in all required fields.');
                return false;
            }
            
            // Validate time range
            if (startTime >= endTime) {
                e.preventDefault();
                alert('End time must be after start time.');
                return false;
            }
            
            return true;
        });
    }
});
</script>

<%@ include file="../shared/footer.jsp" %>