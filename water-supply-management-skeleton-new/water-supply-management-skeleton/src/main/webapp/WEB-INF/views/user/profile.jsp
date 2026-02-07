<%@ include file="../shared/header.jsp" %>

<div class="container mt-4">
    <div class="row">
        <div class="col-12">
            <h2 class="mb-4"><i class="fas fa-user me-2"></i>User Profile</h2>
        </div>
    </div>

    <div class="row">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-edit me-2"></i>Edit Profile</h5>
                </div>
                <div class="card-body">
                    <form action="/user/profile/update" method="post">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Username</label>
                                <input type="text" class="form-control" name="username" value="${user.username}" readonly>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" value="${user.email}" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">New Password (leave blank to keep current)</label>
                                <input type="password" class="form-control" name="password">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Role</label>
                                <input type="text" class="form-control" value="${user.role}" readonly>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>Update Profile
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card">
                <div class="card-header bg-info text-white">
                    <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Account Information</h5>
                </div>
                <div class="card-body">
                    <div class="row mb-2">
                        <div class="col-6">
                            <strong>Username:</strong>
                        </div>
                        <div class="col-6">
                            ${user.username}
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-6">
                            <strong>Email:</strong>
                        </div>
                        <div class="col-6">
                            ${user.email}
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-6">
                            <strong>Role:</strong>
                        </div>
                        <div class="col-6">
                            <span class="badge bg-${user.role eq 'ADMIN' ? 'danger' : 'primary'}">
                                ${user.role}
                            </span>
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-6">
                            <strong>Status:</strong>
                        </div>
                        <div class="col-6">
                            <span class="badge bg-${user.enabled ? 'success' : 'secondary'}">
                                ${user.enabled ? 'Active' : 'Inactive'}
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../shared/footer.jsp" %>
