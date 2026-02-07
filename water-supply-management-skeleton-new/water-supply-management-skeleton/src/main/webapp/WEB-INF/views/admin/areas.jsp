<%@ include file="../shared/header.jsp" %>

<div class="container mt-4">
    <div class="row">
        <div class="col-12">
            <h2 class="mb-4"><i class="fas fa-map-marked-alt me-2"></i>Manage Areas</h2>
        </div>
    </div>

    <!-- DEBUG SECTION - Remove after testing -->
    <!-- <div class="alert alert-info">
        <h5>Debug Information:</h5>
        <c:forEach var="area" items="${areas}" varStatus="status">
            <div>
                <strong>${area.name}:</strong><br>
                Primary Tank: ${area.primaryTankName != null ? area.primaryTankName : 'Not Assigned'} (ID: ${area.primaryTankId})<br>
                Backup Tank: ${area.backupTankName != null ? area.backupTankName : 'Not Assigned'} (ID: ${area.backupTankId})<br>
                <hr>
            </div>
        </c:forEach>
    </div> -->

    <!-- Add Area Form -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-plus-circle me-2"></i>Add New Area</h5>
                </div>
                <div class="card-body">
                    <form action="/admin/areas/create" method="post">
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="form-label">Name</label>
                                <input type="text" class="form-control" name="name" required>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label">Zone</label>
                                <input type="text" class="form-control" name="zone" required>
                            </div>
                            <div class="col-md-2 mb-3">
                                <label class="form-label">Population</label>
                                <input type="number" class="form-control" name="population" required>
                            </div>
                            <div class="col-md-2 mb-3">
                                <label class="form-label">Water Demand (L/day)</label>
                                <input type="number" class="form-control" name="waterDemand" step="0.01" required>
                            </div>
                            <div class="col-md-2 mb-3">
                                <label class="form-label">Status</label>
                                <select class="form-select" name="status" required>
                                    <option value="SERVED">Served</option>
                                    <option value="LOW_SUPPLY">Low Supply</option>
                                    <option value="CRITICAL">Critical</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Primary Tank</label>
                                <select class="form-select" name="primaryTankId">
                                    <option value="">Select Tank</option>
                                    <c:forEach var="tank" items="${tanks}">
                                        <option value="${tank.id}">${tank.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Backup Tank</label>
                                <select class="form-select" name="backupTankId">
                                    <option value="">Select Tank</option>
                                    <c:forEach var="tank" items="${tanks}">
                                        <option value="${tank.id}">${tank.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-plus me-2"></i>Add Area
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Areas Table -->
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-info text-white">
                    <h5 class="mb-0"><i class="fas fa-list me-2"></i>Existing Areas</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Zone</th>
                                    <th>Population</th>
                                    <th>Water Demand</th>
                                    <th>Status</th>
                                    <th>Primary Tank</th>
                                    <th>Backup Tank</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="area" items="${areas}">
                                    <tr>
                                        <td>${area.name}</td>
                                        <td>${area.zone}</td>
                                        <td>${area.population}</td>
                                        <td>${area.waterDemand}L/day</td>
                                        <td>
                                            <span class="badge bg-${area.status eq 'SERVED' ? 'success' : area.status eq 'LOW_SUPPLY' ? 'warning' : 'danger'}">
                                                ${area.status}
                                            </span>
                                        </td>
                                        <td>
                                            ${area.primaryTankName != null ? area.primaryTankName : 'Not Assigned'}
                                            <!-- DEBUG: Primary Tank ID: ${area.primaryTankId} -->
                                        </td>
                                        <td>
                                            ${area.backupTankName != null ? area.backupTankName : 'Not Assigned'}
                                            <!-- DEBUG: Backup Tank ID: ${area.backupTankId} -->
                                        </td>
                                        <td>
                                            <button class="btn btn-sm btn-primary" onclick="editArea('${area.id}')">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button class="btn btn-sm btn-danger" onclick="deleteArea('${area.id}')">
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

<!-- Edit Area Modal -->
<div class="modal fade" id="editAreaModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Area</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="editAreaForm">
                    <input type="hidden" id="editAreaId" name="id">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Name</label>
                            <input type="text" class="form-control" id="editAreaName" name="name" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Zone</label>
                            <input type="text" class="form-control" id="editAreaZone" name="zone" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Population</label>
                            <input type="number" class="form-control" id="editAreaPopulation" name="population" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Water Demand (L/day)</label>
                            <input type="number" class="form-control" id="editAreaWaterDemand" name="waterDemand" step="0.01" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Primary Tank</label>
                            <select class="form-select" id="editAreaPrimaryTankId" name="primaryTankId">
                                <option value="">Select Tank</option>
                                <c:forEach var="tank" items="${tanks}">
                                    <option value="${tank.id}">${tank.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Backup Tank</label>
                            <select class="form-select" id="editAreaBackupTankId" name="backupTankId">
                                <option value="">Select Tank</option>
                                <c:forEach var="tank" items="${tanks}">
                                    <option value="${tank.id}">${tank.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Status</label>
                        <select class="form-select" id="editAreaStatus" name="status" required>
                            <option value="SERVED">Served</option>
                            <option value="LOW_SUPPLY">Low Supply</option>
                            <option value="CRITICAL">Critical</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="updateArea()">Update Area</button>
            </div>
        </div>
    </div>
</div>

<script>
let editAreaModal;

document.addEventListener('DOMContentLoaded', function() {
    editAreaModal = new bootstrap.Modal(document.getElementById('editAreaModal'));
});

function editArea(id) {
    fetch('/admin/areas/edit/' + id)
        .then(response => response.json())
        .then(area => {
            document.getElementById('editAreaId').value = area.id;
            document.getElementById('editAreaName').value = area.name;
            document.getElementById('editAreaZone').value = area.zone;
            document.getElementById('editAreaPopulation').value = area.population;
            document.getElementById('editAreaWaterDemand').value = area.waterDemand;
            document.getElementById('editAreaPrimaryTankId').value = area.primaryTankId || '';
            document.getElementById('editAreaBackupTankId').value = area.backupTankId || '';
            document.getElementById('editAreaStatus').value = area.status;
            editAreaModal.show();
        })
        .catch(error => {
            console.error('Error fetching area:', error);
            alert('Error loading area data');
        });
}

function updateArea() {
    const formData = {
        id: document.getElementById('editAreaId').value,
        name: document.getElementById('editAreaName').value,
        zone: document.getElementById('editAreaZone').value,
        population: parseInt(document.getElementById('editAreaPopulation').value),
        waterDemand: parseFloat(document.getElementById('editAreaWaterDemand').value),
        primaryTankId: document.getElementById('editAreaPrimaryTankId').value,
        backupTankId: document.getElementById('editAreaBackupTankId').value,
        status: document.getElementById('editAreaStatus').value
    };

    fetch('/admin/areas/update-ajax', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData)
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            editAreaModal.hide();
            location.reload();
        } else {
            alert('Error: ' + data.message);
        }
    })
    .catch(error => {
        console.error('Error updating area:', error);
        alert('Error updating area');
    });
}

function deleteArea(id) {
    if (confirm('Are you sure you want to delete this area?')) {
        fetch('/admin/areas/delete-ajax/' + id, {
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
            console.error('Error deleting area:', error);
            alert('Error deleting area');
        });
    }
}
</script>

<%@ include file="../shared/footer.jsp" %>