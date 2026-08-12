<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!-- User delete modal -->
    <div class="modal fade" id="deleteUserModal" tabindex="-1" aria-labelledby="deleteUserLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteUserLabel">Xóa người dùng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa người dùng này không?</p>
                    <!-- Hidden form to submit deletion -->
                    <form id="deleteUserForm" action="/admin/user/delete" method="post">
                        <!-- CSRF Token -->
                        <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        </c:if>
                        <input type="hidden" name="id" id="deleteUserId" />
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-danger"
                        onclick="document.getElementById('deleteUserForm').submit()">Xác nhận</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        (function () {
            var deleteModalEl = document.getElementById('deleteUserModal');
            if (deleteModalEl) {
                var deleteModal = new bootstrap.Modal(deleteModalEl, {});

                // Listen for clicks on functionality buttons that trigger the modal
                document.addEventListener('click', function (e) {
                    var btn = e.target.closest && e.target.closest('.btn-delete-user');
                    if (!btn) return;
                    e.preventDefault();

                    var userId = btn.getAttribute('data-user-id');

                    // Set the ID in the hidden form
                    var inputId = document.getElementById('deleteUserId');
                    if (inputId) {
                        inputId.value = userId;
                    }

                    deleteModal.show();
                });
            }
        })();
    </script>