<%@page contentType="text/html" pageEncoding="UTF-8" %>    
<!-- Product delete modal -->
<div class="modal fade" id="deleteProductModal" tabindex="-1" aria-labelledby="deleteProductLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteProductLabel">Xác nhận xóa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc muốn xóa sản phẩm này?</p>
                <!-- Hidden form to submit deletion -->
                <form id="deleteProductForm" action="/admin/product/delete" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <input type="hidden" name="id" id="deleteProductId" />
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-danger" onclick="document.getElementById('deleteProductForm').submit()">Xóa</button>
            </div>
        </div>
    </div>
</div>

<script>
    (function(){
            var deleteModalEl = document.getElementById('deleteProductModal');
            var deleteModal = new bootstrap.Modal(deleteModalEl, {});
            
            // Listen for clicks on functionality buttons that trigger the modal
            document.addEventListener('click', function(e){
                    var btn = e.target.closest && e.target.closest('.btn-delete-product');
                    if(!btn) return;
                    e.preventDefault();
                    
                    var productId = btn.getAttribute('data-product-id');
                    
                    // Set the ID in the hidden form
                    var inputId = document.getElementById('deleteProductId');
                    if(inputId) {
                        inputId.value = productId;
                    }
                    
                    deleteModal.show();
            });
    })();
</script>
