<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!-- Delete confirmation modal -->
    <div class="modal fade" id="deleteOrderModal" tabindex="-1" aria-labelledby="deleteOrderLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteOrderLabel">Xác nhận xóa đơn hàng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc muốn xóa đơn hàng có id = <strong id="orderIdText"></strong> ?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <!-- Form submission for deletion -->
                    <form id="deleteOrderForm" action="/admin/order/delete" method="post">
                        <!-- CSRF Token -->
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        
                        <!-- Order ID to delete -->
                        <input type="hidden" name="id" id="deleteOrderIdInput" />

                        <button type="button" id="confirmDeleteOrderBtn" class="btn btn-danger">Xóa</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Get the modal element
            var deleteModalEl = document.getElementById('deleteOrderModal');
            if (deleteModalEl) {
                var deleteModal = new bootstrap.Modal(deleteModalEl, {});

                // Listen for clicks on delete buttons
                var deleteBtns = document.querySelectorAll('.btn-delete-order');
                deleteBtns.forEach(function (btn) {
                    btn.addEventListener('click', function (e) {
                        e.preventDefault();
                        
                        // Get order ID from data attribute
                        var orderId = this.getAttribute('data-order-id');
                        
                        // Update the modal text
                        document.getElementById('orderIdText').textContent = orderId;
                        
                        // Update the hidden input in the form
                        document.getElementById('deleteOrderIdInput').value = orderId;
                        
                        // Show the modal
                        deleteModal.show();
                    });
                });

                // Handle the "Xóa" button click inside the modal
                var confirmBtn = document.getElementById('confirmDeleteOrderBtn');
                if (confirmBtn) {
                    confirmBtn.addEventListener('click', function () {
                        // Submit the form
                        document.getElementById('deleteOrderForm').submit();
                    });
                }
            }
        });
    </script>
