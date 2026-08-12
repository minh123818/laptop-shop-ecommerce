<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="Admin - Cập nhật sản phẩm" />
                <meta name="author" content="Laptopshop" />
                <title>Cập nhật sản phẩm - Admin</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <link href="/css/admin-product-form.css" rel="stylesheet" />
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <!-- CKEditor 5 -->
                <script src="https://cdn.ckeditor.com/ckeditor5/41.1.0/classic/ckeditor.js"></script>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Cập nhật sản phẩm</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/product">Sản phẩm</a></li>
                                    <li class="breadcrumb-item active">Cập nhật</li>
                                </ol>
                                
                                <form:form method="post" action="/admin/product/update" 
                                    enctype="multipart/form-data" modelAttribute="newProduct" id="productForm">
                                    
                                    <c:set var="errorName">
                                        <form:errors path="name" cssClass="invalid-feedback" />
                                    </c:set>
                                    <c:set var="errorPrice">
                                        <form:errors path="price" cssClass="invalid-feedback" />
                                    </c:set>
                                    <c:set var="errorDetailDesc">
                                        <form:errors path="detailDesc" cssClass="invalid-feedback" />
                                    </c:set>
                                    <c:set var="errorShortDesc">
                                        <form:errors path="shortDesc" cssClass="invalid-feedback" />
                                    </c:set>
                                    <c:set var="errorQuantity">
                                        <form:errors path="quantity" cssClass="invalid-feedback" />
                                    </c:set>

                                    <!-- Hidden ID -->
                                    <form:hidden path="id" />

                                    <div class="product-form-container">
                                        <div class="row">
                                            <!-- Left Column -->
                                            <div class="col-12">
                                                <!-- Basic Info Card -->
                                                <div class="product-form-card card-basic">
                                                    <div class="product-form-card-header">
                                                        <i class="fas fa-info-circle"></i>
                                                        <h5>Thông tin cơ bản</h5>
                                                    </div>
                                                    <div class="product-form-card-body">
                                                        <div class="row">
                                                            <div class="col-12 mb-3">
                                                                <label class="form-label-custom">
                                                                    Tên sản phẩm <span class="required">*</span>
                                                                </label>
                                                                <form:input type="text" path="name"
                                                                    class="form-control form-control-custom ${not empty errorName ? 'is-invalid' : ''}"
                                                                    placeholder="Nhập tên sản phẩm..." />
                                                                ${errorName}
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <label class="form-label-custom">
                                                                    Giá bán <span class="required">*</span>
                                                                </label>
                                                                <div class="input-group">
                                                                    <form:input type="number" path="price"
                                                                        class="form-control form-control-custom ${not empty errorPrice ? 'is-invalid' : ''}"
                                                                        placeholder="0" />
                                                                    <span class="input-group-text">VNĐ</span>
                                                                </div>
                                                                ${errorPrice}
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <label class="form-label-custom">
                                                                    Số lượng <span class="required">*</span>
                                                                </label>
                                                                <form:input type="number" path="quantity"
                                                                    class="form-control form-control-custom ${not empty errorQuantity ? 'is-invalid' : ''}"
                                                                    placeholder="0" />
                                                                ${errorQuantity}
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <label class="form-label-custom">Hãng sản xuất</label>
                                                                <form:select class="form-select form-select-custom" path="factory">
                                                                    <form:option value="APPLE">Apple (MacBook)</form:option>
                                                                    <form:option value="ASUS">Asus</form:option>
                                                                    <form:option value="LENOVO">Lenovo</form:option>
                                                                    <form:option value="DELL">Dell</form:option>
                                                                    <form:option value="LG">LG</form:option>
                                                                    <form:option value="ACER">Acer</form:option>
                                                                    <form:option value="HP">HP</form:option>
                                                                    <form:option value="MSI">MSI</form:option>
                                                                </form:select>
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <label class="form-label-custom">Đối tượng sử dụng</label>
                                                                <form:select class="form-select form-select-custom" path="target">
                                                                    <form:option value="GAMING">Gaming</form:option>
                                                                    <form:option value="SINHVIEN-VANPHONG">Sinh viên - Văn phòng</form:option>
                                                                    <form:option value="THIET-KE-DO-HOA">Thiết kế đồ họa</form:option>
                                                                    <form:option value="MONG-NHE">Mỏng nhẹ</form:option>
                                                                    <form:option value="DOANH-NHAN">Doanh nhân</form:option>
                                                                </form:select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Specifications Card -->
                                                <div class="product-form-card card-specs">
                                                    <div class="product-form-card-header">
                                                        <i class="fas fa-microchip"></i>
                                                        <h5>Thông số kỹ thuật</h5>
                                                    </div>
                                                    <div class="product-form-card-body">
                                                        <div class="specs-builder">
                                                            <div class="specs-builder-header">
                                                                <h6><i class="fas fa-list-ul me-2"></i>Danh sách thông số</h6>
                                                                <span class="badge bg-secondary" id="specCount">0 thông số</span>
                                                            </div>
                                                            
                                                            <div class="specs-list" id="specsList">
                                                                <!-- Specs items will be loaded here -->
                                                            </div>
                                                            
                                                            <button type="button" class="btn-add-spec mt-3" id="btnAddSpec">
                                                                <i class="fas fa-plus"></i>
                                                                Thêm thông số mới
                                                            </button>
                                                            
                                                            <!-- Quick Templates -->
                                                            <div class="specs-templates">
                                                                <div class="specs-templates-title">
                                                                    <i class="fas fa-magic me-1"></i>Thêm nhanh theo mẫu:
                                                                </div>
                                                                <div class="specs-template-btns">
                                                                    <button type="button" class="btn-template" data-template="cpu">
                                                                        <i class="fas fa-microchip me-1"></i>CPU
                                                                    </button>
                                                                    <button type="button" class="btn-template" data-template="ram">
                                                                        <i class="fas fa-memory me-1"></i>RAM
                                                                    </button>
                                                                    <button type="button" class="btn-template" data-template="storage">
                                                                        <i class="fas fa-hdd me-1"></i>Ổ cứng
                                                                    </button>
                                                                    <button type="button" class="btn-template" data-template="display">
                                                                        <i class="fas fa-desktop me-1"></i>Màn hình
                                                                    </button>
                                                                    <button type="button" class="btn-template" data-template="gpu">
                                                                        <i class="fas fa-tv me-1"></i>Card đồ họa
                                                                    </button>
                                                                    <button type="button" class="btn-template" data-template="battery">
                                                                        <i class="fas fa-battery-full me-1"></i>Pin
                                                                    </button>
                                                                    <button type="button" class="btn-template" data-template="weight">
                                                                        <i class="fas fa-weight me-1"></i>Trọng lượng
                                                                    </button>
                                                                    <button type="button" class="btn-template" data-template="os">
                                                                        <i class="fab fa-windows me-1"></i>Hệ điều hành
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        
                                                        <!-- Hidden input to store specs as HTML table -->
                                                        <form:hidden path="shortDesc" id="shortDescInput" />
                                                        ${errorShortDesc}
                                                    </div>
                                                </div>

                                                <!-- Description Card -->
                                                <div class="product-form-card card-description">
                                                    <div class="product-form-card-header">
                                                        <i class="fas fa-file-alt"></i>
                                                        <h5>Mô tả chi tiết</h5>
                                                    </div>
                                                    <div class="product-form-card-body">
                                                        <label class="form-label-custom">
                                                            Nội dung mô tả <span class="required">*</span>
                                                            <span class="hint">(Rich Text Editor)</span>
                                                        </label>
                                                        <form:textarea path="detailDesc" id="detailDescEditor"
                                                            class="form-control ${not empty errorDetailDesc ? 'is-invalid' : ''}"
                                                            rows="10"
                                                            placeholder="Nhập mô tả chi tiết sản phẩm..." />
                                                        ${errorDetailDesc}
                                                    </div>
                                                </div>

                                                <!-- Image Card -->
                                                <div class="product-form-card card-media">
                                                    <div class="product-form-card-header">
                                                        <i class="fas fa-image"></i>
                                                        <h5>Hình ảnh sản phẩm</h5>
                                                    </div>
                                                    <div class="product-form-card-body">
                                                        <div class="image-upload-area" id="imageUploadArea">
                                                            <input type="file" id="avatarFile" name="productFile" 
                                                                accept=".png, .jpg, .jpeg" style="display: none;" />
                                                            <div id="uploadPlaceholder">
                                                                <div class="image-upload-icon">
                                                                    <i class="fas fa-cloud-upload-alt"></i>
                                                                </div>
                                                                <div class="image-upload-text">
                                                                    Click để chọn ảnh hoặc kéo thả vào đây
                                                                </div>
                                                                <div class="image-upload-hint">
                                                                    PNG, JPG, JPEG (Tối đa 5MB)
                                                                </div>
                                                            </div>
                                                            <img id="avatarPreview" class="image-preview" 
                                                                alt="Preview" style="display: none;" />
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Form Actions -->
                                                <div class="form-actions">
                                                    <button type="submit" class="btn-submit btn-submit-primary" style="background: linear-gradient(135deg, #ffc107 0%, #ffca2c 100%);">
                                                        <i class="fas fa-save"></i>
                                                        Cập nhật
                                                    </button>
                                                    <a href="/admin/product" class="btn-submit btn-submit-secondary">
                                                        <i class="fas fa-times"></i>
                                                        Hủy bỏ
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form:form>
                            </div>
                        </main>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>
                
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
                
                <script>
                    // Initialize CKEditor 5
                    let detailDescEditor;
                    ClassicEditor
                        .create(document.querySelector('#detailDescEditor'), {
                            toolbar: {
                                items: [
                                    'heading', '|',
                                    'bold', 'italic', 'underline', 'strikethrough', '|',
                                    'bulletedList', 'numberedList', '|',
                                    'outdent', 'indent', '|',
                                    'link', 'blockQuote', 'insertTable', '|',
                                    'undo', 'redo'
                                ]
                            },
                            heading: {
                                options: [
                                    { model: 'paragraph', title: 'Paragraph', class: 'ck-heading_paragraph' },
                                    { model: 'heading1', view: 'h1', title: 'Heading 1', class: 'ck-heading_heading1' },
                                    { model: 'heading2', view: 'h2', title: 'Heading 2', class: 'ck-heading_heading2' },
                                    { model: 'heading3', view: 'h3', title: 'Heading 3', class: 'ck-heading_heading3' }
                                ]
                            },
                            table: {
                                contentToolbar: ['tableColumn', 'tableRow', 'mergeTableCells']
                            },
                            placeholder: 'Nhập mô tả chi tiết sản phẩm...'
                        })
                        .then(editor => {
                            detailDescEditor = editor;
                            // Sync editor content to textarea on form submit
                            document.querySelector('#productForm').addEventListener('submit', function() {
                                document.querySelector('#detailDescEditor').value = editor.getData();
                            });
                        })
                        .catch(error => {
                            console.error('CKEditor initialization error:', error);
                        });
                </script>
                
                <script>
                    $(document).ready(function() {
                        // ===== Image Upload =====
                        const imageUploadArea = $('#imageUploadArea');
                        const avatarFile = $('#avatarFile');
                        const avatarPreview = $('#avatarPreview');
                        const uploadPlaceholder = $('#uploadPlaceholder');
                        const orgImage = "${newProduct.image}";

                        // Load existing image
                        if (orgImage) {
                            const urlImage = "/images/product/" + orgImage;
                            avatarPreview.attr('src', urlImage).show();
                            uploadPlaceholder.hide();
                            imageUploadArea.addClass('has-image');
                        }

                        imageUploadArea.on('click', function(e) {
                            if (e.target !== avatarFile[0]) {
                                avatarFile.trigger('click');
                            }
                        });

                        avatarFile.on('change', function(e) {
                            if (e.target.files && e.target.files[0]) {
                                const imgURL = URL.createObjectURL(e.target.files[0]);
                                avatarPreview.attr('src', imgURL).show();
                                uploadPlaceholder.hide();
                                imageUploadArea.addClass('has-image');
                            }
                        });

                        // Stop propagation from input to prevent double trigger
                        avatarFile.on('click', function(e) {
                            e.stopPropagation();
                        });

                        // Drag and drop
                        imageUploadArea.on('dragover', function(e) {
                            e.preventDefault();
                            $(this).css('border-color', '#0d6efd');
                        });

                        imageUploadArea.on('dragleave', function(e) {
                            e.preventDefault();
                            $(this).css('border-color', '#dee2e6');
                        });

                        imageUploadArea.on('drop', function(e) {
                            e.preventDefault();
                            $(this).css('border-color', '#dee2e6');
                            const files = e.originalEvent.dataTransfer.files;
                            if (files.length > 0) {
                                avatarFile[0].files = files;
                                avatarFile.trigger('change');
                            }
                        });

                        // ===== Specifications Builder =====
                        let specCounter = 0;

                        // Template data
                        const specTemplates = {
                            cpu: { key: 'CPU', value: '' },
                            ram: { key: 'RAM', value: '' },
                            storage: { key: 'Ổ cứng', value: '' },
                            display: { key: 'Màn hình', value: '' },
                            gpu: { key: 'Card đồ họa', value: '' },
                            battery: { key: 'Pin', value: '' },
                            weight: { key: 'Trọng lượng', value: '' },
                            os: { key: 'Hệ điều hành', value: '' }
                        };

                        function addSpecItem(key = '', value = '') {
                            specCounter++;
                            var html = '';
                            html += '<div class="spec-item" data-id="' + specCounter + '">';
                            html += '<div class="spec-key">';
                            html += '<input type="text" class="spec-key-input" placeholder="Tên thông số (VD: CPU)" value="' + escapeHtml(key) + '">';
                            html += '</div>';
                            html += '<div class="spec-value">';
                            html += '<input type="text" class="spec-value-input" placeholder="Giá trị (VD: Intel Core i7-12700H)" value="' + escapeHtml(value) + '">';
                            html += '</div>';
                            html += '<button type="button" class="btn-remove-spec" title="Xóa">';
                            html += '<i class="fas fa-trash"></i>';
                            html += '</button>';
                            html += '</div>';
                            $('#specsList').append(html);
                            updateSpecCount();
                        }

                        function updateSpecCount() {
                            const count = $('.spec-item').length;
                            $('#specCount').text(count + ' thông số');
                        }

                        function updateShortDesc() {
                            const specs = [];
                            $('.spec-item').each(function() {
                                const key = $(this).find('.spec-key-input').val().trim();
                                const value = $(this).find('.spec-value-input').val().trim();
                                if (key || value) {
                                    specs.push({ key: key, value: value });
                                }
                            });

                            // Generate HTML table
                            if (specs.length > 0) {
                                let html = '<table class="table table-bordered table-striped">';
                                html += '<tbody>';
                                specs.forEach(function(spec) {
                                    html += '<tr>';
                                    html += '<td><strong>' + escapeHtml(spec.key) + '</strong></td>';
                                    html += '<td>' + escapeHtml(spec.value) + '</td>';
                                    html += '</tr>';
                                });
                                html += '</tbody></table>';
                                $('#shortDescInput').val(html);
                            } else {
                                $('#shortDescInput').val('');
                            }
                        }

                        function escapeHtml(text) {
                            if (!text) return '';
                            const div = document.createElement('div');
                            div.textContent = text;
                            return div.innerHTML;
                        }

                        function decodeHtml(html) {
                            const txt = document.createElement('textarea');
                            txt.innerHTML = html;
                            return txt.value;
                        }

                        // Parse existing shortDesc HTML table to specs
                        function parseExistingSpecs() {
                            const shortDescHtml = $('#shortDescInput').val();
                            if (!shortDescHtml) return;

                            // Create a temporary element to parse HTML
                            const temp = $('<div>').html(shortDescHtml);
                            const rows = temp.find('tr');
                            
                            if (rows.length > 0) {
                                rows.each(function() {
                                    const cells = $(this).find('td');
                                    if (cells.length >= 2) {
                                        const key = $(cells[0]).text().trim();
                                        const value = $(cells[1]).text().trim();
                                        if (key || value) {
                                            addSpecItem(key, value);
                                        }
                                    }
                                });
                            } else {
                                // If not a table, try to parse as plain text or add as single item
                                const plainText = temp.text().trim();
                                if (plainText) {
                                    addSpecItem('Mô tả', plainText);
                                }
                            }
                        }

                        // Add spec button
                        $('#btnAddSpec').on('click', function() {
                            addSpecItem();
                            updateShortDesc();
                        });

                        // Remove spec button
                        $(document).on('click', '.btn-remove-spec', function() {
                            $(this).closest('.spec-item').remove();
                            updateSpecCount();
                            updateShortDesc();
                        });

                        // Update on input change
                        $(document).on('input', '.spec-key-input, .spec-value-input', function() {
                            updateShortDesc();
                        });

                        // Template buttons
                        $('.btn-template').on('click', function() {
                            const template = $(this).data('template');
                            const data = specTemplates[template];
                            
                            if (data) {
                                // Check if already exists
                                let exists = false;
                                $('.spec-key-input').each(function() {
                                    if ($(this).val() === data.key) {
                                        exists = true;
                                        return false;
                                    }
                                });
                                if (!exists) {
                                    addSpecItem(data.key, data.value);
                                    updateShortDesc();
                                }
                            }
                        });

                        // Form submit - ensure specs are updated
                        $('#productForm').on('submit', function() {
                            updateShortDesc();
                        });

                        // Initialize - parse existing specs
                        parseExistingSpecs();
                    });
                </script>
            </body>

            </html>