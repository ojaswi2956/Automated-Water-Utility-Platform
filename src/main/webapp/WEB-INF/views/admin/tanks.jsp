<%@ include file="../shared/header.jsp" %>

<div class="container mt-4">
    <div class="row">
        <div class="col-12">
            <h2 class="mb-4"><i class="fas fa-water-tower me-2"></i>Manage Tanks</h2>
        </div>
    </div>

    <!-- Add Tank Form -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-plus-circle me-2"></i>Add New Tank</h5>
                </div>
                <div class="card-body">
                    <form action="/admin/tanks/create" method="post">
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="form-label">Name</label>
                                <input type="text" class="form-control" name="name" required>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label">Location</label>
                                <input type="text" class="form-control" name="location" required>
                            </div>
                            <div class="col-md-2 mb-3">
                                <label class="form-label">Capacity (L)</label>
                                <input type="number" class="form-control" name="capacity" step="0.01" required>
                            </div>
                            <div class="col-md-2 mb-3">
                                <label class="form-label">Current Level (L)</label>
                                <input type="number" class="form-control" name="currentLevel" step="0.01" required>
                            </div>
                            <div class="col-md-2 mb-3">
                                <label class="form-label">Status</label>
                                <select class="form-select" name="status" required>
                                    <option value="ACTIVE">Active</option>
                                    <option value="MAINTENANCE">Maintenance</option>
                                    <option value="OFFLINE">Offline</option>
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-plus me-2"></i>Add Tank
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Tanks Table -->
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-info text-white">
                    <h5 class="mb-0"><i class="fas fa-list me-2"></i>Existing Tanks</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Location</th>
                                    <th>Capacity (L)</th>
                                    <th>Current Level (L)</th>
                                    <th>Percentage</th>
                                    <th>Status</th>
                                    <th>Last Maintenance</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="tank" items="${tanks}">
                                    <tr>
                                        <td>${tank.name}</td>
                                        <td>${tank.location}</td>
                                        <td>${tank.capacity}</td>
                                        <td>${tank.currentLevel}</td>
                                        <td>
                                            <div class="progress" style="height: 20px;">
                                                <div class="progress-bar ${tank.percentage < 20 ? 'bg-danger' : tank.percentage < 50 ? 'bg-warning' : 'bg-success'}" 
                                                    role="progressbar" style="width: ${tank.percentage}%">
                                                    ${String.format("%.1f", tank.percentage)}%
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="badge bg-${tank.status eq 'ACTIVE' ? 'success' : tank.status eq 'MAINTENANCE' ? 'warning' : 'danger'}">
                                                ${tank.status}
                                            </span>
                                        </td>
                                        <td>${tank.lastMaintenance != null ? tank.lastMaintenance : 'Never'}</td>
                                        <td>
                                            <button class="btn btn-sm btn-primary" onclick="editTank('${tank.id}')">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button class="btn btn-sm btn-danger" onclick="deleteTank('${tank.id}')">
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

<!-- Edit Tank Modal -->
<div class="modal fade" id="editTankModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Tank</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="editTankForm">
                    <input type="hidden" id="editTankId" name="id">
                    <div class="mb-3">
                        <label class="form-label">Name</label>
                        <input type="text" class="form-control" id="editTankName" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Location</label>
                        <input type="text" class="form-control" id="editTankLocation" name="location" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Capacity (L)</label>
                        <input type="number" class="form-control" id="editTankCapacity" name="capacity" step="0.01" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Current Level (L)</label>
                        <input type="number" class="form-control" id="editTankCurrentLevel" name="currentLevel" step="0.01" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Status</label>
                        <select class="form-select" id="editTankStatus" name="status" required>
                            <option value="ACTIVE">Active</option>
                            <option value="MAINTENANCE">Maintenance</option>
                            <option value="OFFLINE">Offline</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="updateTank()">Update Tank</button>
            </div>
        </div>
    </div>
</div>

<script>
let editTankModal;

document.addEventListener('DOMContentLoaded', function() {
    editTankModal = new bootstrap.Modal(document.getElementById('editTankModal'));
});

function editTank(id) {
    fetch('/admin/tanks/edit/' + id)
        .then(response => response.json())
        .then(tank => {
            document.getElementById('editTankId').value = tank.id;
            document.getElementById('editTankName').value = tank.name;
            document.getElementById('editTankLocation').value = tank.location;
            document.getElementById('editTankCapacity').value = tank.capacity;
            document.getElementById('editTankCurrentLevel').value = tank.currentLevel;
            document.getElementById('editTankStatus').value = tank.status;
            editTankModal.show();
        })
        .catch(error => {
            console.error('Error fetching tank:', error);
            alert('Error loading tank data');
        });
}

function updateTank() {
    const formData = {
        id: document.getElementById('editTankId').value,
        name: document.getElementById('editTankName').value,
        location: document.getElementById('editTankLocation').value,
        capacity: parseFloat(document.getElementById('editTankCapacity').value),
        currentLevel: parseFloat(document.getElementById('editTankCurrentLevel').value),
        status: document.getElementById('editTankStatus').value
    };

    fetch('/admin/tanks/update-ajax', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData)
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            editTankModal.hide();
            location.reload();
        } else {
            alert('Error: ' + data.message);
        }
    })
    .catch(error => {
        console.error('Error updating tank:', error);
        alert('Error updating tank');
    });
}

function deleteTank(id) {
    if (confirm('Are you sure you want to delete this tank?')) {
        fetch('/admin/tanks/delete-ajax/' + id, {
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
            console.error('Error deleting tank:', error);
            alert('Error deleting tank');
        });
    }
}
</script>

<%@ include file="../shared/footer.jsp" %>