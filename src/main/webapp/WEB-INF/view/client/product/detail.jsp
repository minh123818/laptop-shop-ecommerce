<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="utf-8">
                    <title>${product.name} - Laptopshop</title>
                    <meta content="width=device-width, initial-scale=1.0" name="viewport">
                    <meta content="${product.name}, laptop, ${product.factory}" name="keywords">
                    <meta content="${product.name}" name="description">


                    <!-- Google Web Fonts -->
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

                    <!-- Icon Font Stylesheet -->
                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

                    <!-- Libraries Stylesheet -->
                    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

                    <!-- Customized Bootstrap Stylesheet -->
                    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                    <!-- Template Stylesheet -->
                    <link href="/client/css/style.css" rel="stylesheet">
                    
                    <!-- Product Detail Stylesheet -->
                    <link href="/client/css/product-detail.css" rel="stylesheet">

                    <meta name="_csrf" content="${_csrf.token}" />
                    <meta name="_csrf_header" content="${_csrf.headerName}" />

                    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css" rel="stylesheet">
                </head>

                <body>

                    <!-- Spinner Start -->
                    <div id="spinner"
                        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
                        <div class="spinner-grow text-primary" role="status"></div>
                    </div>
                    <!-- Spinner End -->

                    <jsp:include page="../layout/header.jsp" />

                    <!-- Breadcrumb Start -->
                    <div class="container-fluid py-3 mt-5" style="background: var(--pd-light, #f8f9fa);">
                        <div class="container">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb mb-0">
                                    <li class="breadcrumb-item"><a href="/"><i class="fas fa-home me-1"></i>Trang chủ</a></li>
                                    <li class="breadcrumb-item"><a href="/products">Sản phẩm</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">${product.name}</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                    <!-- Breadcrumb End -->

                    <!-- Product Detail Start -->
                    <div class="container product-detail-container">
                        <div class="row">
                            <!-- Left Column: Product Gallery -->
                            <div class="col-lg-5 col-xl-5">
                                <div class="product-gallery">
                                    <div class="product-main-image">
                                        <img src="/images/product/${product.image}" alt="${product.name}" id="main-product-image">
                                    </div>
                                </div>
                            </div>

                            <!-- Right Column: Product Info -->
                            <div class="col-lg-7 col-xl-7">
                                <div class="product-info">
                                    <!-- Brand Badge -->
                                    <span class="product-brand">${product.factory}</span>
                                    
                                    <!-- Product Title -->
                                    <h1 class="product-title">${product.name}</h1>
                                    
                                    <!-- Rating Display -->
                                    <div class="product-rating-display" id="product-rating">
                                        <div class="stars">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                        </div>
                                        <span class="rating-value" id="rating-value">0</span>
                                        <span class="rating-count" id="rating-text">(0 đánh giá)</span>
                                    </div>
                                    
                                    <!-- Price Box -->
                                    <div class="product-price-box">
                                        <div class="product-price">
                                            <fmt:formatNumber type="number" value="${product.price}" />
                                            <span class="currency">đ</span>
                                        </div>
                                    </div>
                                    
                                    <!-- Stock Status -->
                                    <div class="product-stock">
                                        <span class="stock-badge in-stock">
                                            <i class="fas fa-check-circle me-1"></i>Còn hàng
                                        </span>
                                    </div>
                                    
                                    <!-- Quantity Selector -->
                                    <div class="quantity-selector">
                                        <label>Số lượng:</label>
                                        <div class="quantity-input-group">
                                            <button type="button" class="btn-qty-minus">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                            <input type="number" value="1" min="1" max="99" id="product-quantity" data-cart-detail-index="0">
                                            <button type="button" class="btn-qty-plus">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    
                                    <!-- Hidden fields for cart -->
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <input type="hidden" id="product-id" value="${product.id}" />
                                    
                                    <!-- Action Buttons -->
                                    <div class="product-actions">
                                        <button data-product-id="${product.id}" class="btn-add-cart btnAddToCartDetail">
                                            <i class="fas fa-shopping-cart"></i>
                                            Thêm vào giỏ
                                        </button>
                                        <button class="btn-buy-now" onclick="buyNow(${product.id})">
                                            <i class="fas fa-bolt"></i>
                                            Mua ngay
                                        </button>
                                    </div>
                                    
                                    <!-- Product Highlights -->
                                    <div class="product-highlights">
                                        <h6><i class="fas fa-shield-alt me-2"></i>Cam kết từ Laptopshop</h6>
                                        <div class="highlight-item">
                                            <i class="fas fa-check-circle"></i>
                                            <span>Sản phẩm chính hãng 100%</span>
                                        </div>
                                        <div class="highlight-item">
                                            <i class="fas fa-check-circle"></i>
                                            <span>Bảo hành 12 tháng tại hãng</span>
                                        </div>
                                        <div class="highlight-item">
                                            <i class="fas fa-check-circle"></i>
                                            <span>Đổi trả trong 30 ngày nếu lỗi</span>
                                        </div>
                                        <div class="highlight-item">
                                            <i class="fas fa-check-circle"></i>
                                            <span>Giao hàng miễn phí toàn quốc</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Description & Specs Section - 2 Columns -->
                        <div class="row mt-4">
                            <!-- Left Column: Mô tả chi tiết -->
                            <div class="col-lg-8">
                                <div class="detail-description-section">
                                    <div class="section-card">
                                        <div class="section-header description-header">
                                            <h5><i class="fas fa-file-alt me-2"></i>Mô tả chi tiết</h5>
                                        </div>
                                        <div class="section-body">
                                            <div class="detail-description-content">
                                                ${product.detailDesc}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Right Column: Thông số kỹ thuật -->
                            <div class="col-lg-4">
                                <div class="specs-section-sidebar">
                                    <div class="section-card">
                                        <div class="section-header specs-header">
                                            <h5><i class="fas fa-microchip me-2"></i>Thông số kỹ thuật</h5>
                                        </div>
                                        <div class="section-body specs-body">
                                            ${product.shortDesc}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Reviews Section - Full Width Below -->
                        <div class="row mt-4">
                            <div class="col-12">
                                <div class="reviews-section-full">
                                    <div class="section-card">
                                        <div class="section-header reviews-header">
                                            <h5><i class="fas fa-star me-2"></i>Đánh giá sản phẩm (<span id="tab-review-count">0</span>)</h5>
                                        </div>
                                        <div class="section-body">
                                            <!-- Rating Summary -->
                                            <div class="rating-summary" id="rating-summary">
                                                <div class="rating-overview">
                                                    <div class="rating-number" id="avg-rating">0</div>
                                                    <div class="rating-stars-display" id="avg-stars">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                    </div>
                                                    <div class="rating-count-text"><span id="total-reviews">0</span> đánh giá</div>
                                                </div>
                                                <div class="rating-bars">
                                                    <div class="rating-bar-item">
                                                        <span class="rating-bar-label">5 <i class="fa fa-star"></i></span>
                                                        <div class="rating-bar-progress">
                                                            <div class="rating-bar-fill" id="bar-5" style="width: 0%"></div>
                                                        </div>
                                                        <span class="rating-bar-count" id="count-5">0</span>
                                                    </div>
                                                    <div class="rating-bar-item">
                                                        <span class="rating-bar-label">4 <i class="fa fa-star"></i></span>
                                                        <div class="rating-bar-progress">
                                                            <div class="rating-bar-fill" id="bar-4" style="width: 0%"></div>
                                                        </div>
                                                        <span class="rating-bar-count" id="count-4">0</span>
                                                    </div>
                                                    <div class="rating-bar-item">
                                                        <span class="rating-bar-label">3 <i class="fa fa-star"></i></span>
                                                        <div class="rating-bar-progress">
                                                            <div class="rating-bar-fill" id="bar-3" style="width: 0%"></div>
                                                        </div>
                                                        <span class="rating-bar-count" id="count-3">0</span>
                                                    </div>
                                                    <div class="rating-bar-item">
                                                        <span class="rating-bar-label">2 <i class="fa fa-star"></i></span>
                                                        <div class="rating-bar-progress">
                                                            <div class="rating-bar-fill" id="bar-2" style="width: 0%"></div>
                                                        </div>
                                                        <span class="rating-bar-count" id="count-2">0</span>
                                                    </div>
                                                    <div class="rating-bar-item">
                                                        <span class="rating-bar-label">1 <i class="fa fa-star"></i></span>
                                                        <div class="rating-bar-progress">
                                                            <div class="rating-bar-fill" id="bar-1" style="width: 0%"></div>
                                                        </div>
                                                        <span class="rating-bar-count" id="count-1">0</span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Review Form -->
                                            <c:if test="${not empty pageContext.request.userPrincipal}">
                                                <p id="review-status" class="text-muted" role="status"></p>
                                                <div class="review-form-card d-none" id="review-form-container">
                                                    <h5 class="review-form-title">
                                                        <i class="fas fa-pen me-2"></i>Viết đánh giá của bạn
                                                    </h5>
                                                    <form id="review-form">
                                                        <input type="hidden" id="review-product-id" value="${product.id}">
                                                        <div class="mb-3">
                                                            <label class="form-label fw-semibold">Đánh giá của bạn:</label>
                                                            <div class="star-rating-input">
                                                                <i class="fa fa-star star-input" data-rating="1"></i>
                                                                <i class="fa fa-star star-input" data-rating="2"></i>
                                                                <i class="fa fa-star star-input" data-rating="3"></i>
                                                                <i class="fa fa-star star-input" data-rating="4"></i>
                                                                <i class="fa fa-star star-input" data-rating="5"></i>
                                                            </div>
                                                            <input type="hidden" id="rating-input" value="0">
                                                        </div>
                                                        <div class="mb-3">
                                                            <label for="comment-input" class="form-label fw-semibold">Nhận xét:</label>
                                                            <textarea class="form-control" id="comment-input" rows="4" 
                                                                placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm này..."></textarea>
                                                        </div>
                                                        <button type="submit" class="btn btn-primary px-4" id="submit-review-btn">
                                                            <i class="fas fa-paper-plane me-2"></i>Gửi đánh giá
                                                        </button>
                                                    </form>
                                                </div>
                                            </c:if>
                                            <c:if test="${empty pageContext.request.userPrincipal}">
                                                <div class="login-prompt">
                                                    <i class="fas fa-sign-in-alt"></i>
                                                    <span>Vui lòng <a href="/login">đăng nhập</a> để đánh giá sản phẩm.</span>
                                                </div>
                                            </c:if>

                                            <!-- Reviews List -->
                                            <h5 class="fw-bold mb-3 mt-4">
                                                <i class="fas fa-list me-2"></i>Tất cả đánh giá
                                            </h5>
                                            <div id="reviews-list" class="review-list">
                                                <div class="text-center py-4">
                                                    <div class="spinner-border text-primary" role="status">
                                                        <span class="visually-hidden">Loading...</span>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <!-- Load More Button -->
                                            <div class="load-more-container d-none" id="load-more-container">
                                                <button class="btn-load-more" id="load-more-btn">
                                                    <i class="fas fa-chevron-down me-2"></i>Xem thêm đánh giá
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Product Detail End -->

                    <jsp:include page="../chatbox/show.jsp" />

                    <jsp:include page="../layout/footer.jsp" />

                    <!-- Back to Top -->
                    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                            class="fa fa-arrow-up"></i></a>

                    <!-- JavaScript Libraries -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/lib/easing/easing.min.js"></script>
                    <script src="/client/lib/waypoints/waypoints.min.js"></script>
                    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                    <!-- Template Javascript -->
                    <script src="/client/js/main.js"></script>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>

                    <!-- Product Detail JavaScript -->
                    <script>
                        window.PRODUCT_ID = ${product.id};
                        
                        // Tab Switching
                        document.querySelectorAll('.product-tab').forEach(tab => {
                            tab.addEventListener('click', function() {
                                // Remove active class from all tabs
                                document.querySelectorAll('.product-tab').forEach(t => t.classList.remove('active'));
                                document.querySelectorAll('.tab-pane').forEach(p => p.classList.remove('active'));
                                
                                // Add active class to clicked tab
                                this.classList.add('active');
                                const tabId = 'tab-' + this.dataset.tab;
                                document.getElementById(tabId).classList.add('active');
                            });
                        });
                        
                        // Quantity Controls
                        document.querySelector('.btn-qty-minus').addEventListener('click', function() {
                            const input = document.getElementById('product-quantity');
                            let value = parseInt(input.value) || 1;
                            if (value > 1) {
                                input.value = value - 1;
                            }
                        });
                        
                        document.querySelector('.btn-qty-plus').addEventListener('click', function() {
                            const input = document.getElementById('product-quantity');
                            let value = parseInt(input.value) || 1;
                            if (value < 99) {
                                input.value = value + 1;
                            }
                        });
                        
                        // Image Gallery
                        function changeMainImage(src, thumbnail) {
                            document.getElementById('main-product-image').src = src;
                            document.querySelectorAll('.product-thumbnail').forEach(t => t.classList.remove('active'));
                            thumbnail.classList.add('active');
                        }
                        
                        // Buy Now Function
                        function buyNow(productId) {
                            const quantity = document.getElementById('product-quantity').value;
                            // Add to cart and redirect to checkout
                            const csrfToken = document.querySelector('meta[name="_csrf"]').content;
                            const csrfHeader = document.querySelector('meta[name="_csrf_header"]').content;
                            
                            $.ajax({
                                url: '/api/add-product-to-cart',
                                type: 'POST',
                                headers: { [csrfHeader]: csrfToken },
                                contentType: 'application/json',
                                data: JSON.stringify({
                                    productId: productId,
                                    quantity: parseInt(quantity)
                                }),
                                success: function() {
                                    window.location.href = '/checkout';
                                },
                                error: function() {
                                    $.toast({
                                        heading: 'Lỗi',
                                        text: 'Không thể thêm sản phẩm vào giỏ hàng',
                                        icon: 'error',
                                        position: 'top-right'
                                    });
                                }
                            });
                        }
                    </script>

                    <!-- Review JavaScript -->
                    <script src="/client/js/review.js"></script>

                </body>

                </html>
