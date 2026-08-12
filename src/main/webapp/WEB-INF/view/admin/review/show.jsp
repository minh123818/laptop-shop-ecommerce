<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Quản lý đánh giá" />
    <meta name="author" content="Laptopshop" />
    <title>Quản lý đánh giá - Dashboard</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <link href="/css/review.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
</head>

<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div id="layoutSidenav">
        <jsp:include page="../layout/sidebar.jsp" />
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Quản lý đánh giá</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        <li class="breadcrumb-item active">Reviews</li>
                    </ol>
                    
                    <!-- Filter Tabs -->
                    <ul class="nav review-tabs" id="reviewTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="all-tab" data-bs-toggle="tab" data-bs-target="#all" 
                                    type="button" role="tab">
                                Tất cả <span class="tab-count" id="count-all">${totalItems}</span>
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending" 
                                    type="button" role="tab">
                                <i class="fas fa-clock me-1"></i>Chưa trả lời 
                                <span class="tab-count pending" id="count-pending">0</span>
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="replied-tab" data-bs-toggle="tab" data-bs-target="#replied" 
                                    type="button" role="tab">
                                <i class="fas fa-check-circle me-1"></i>Đã trả lời 
                                <span class="tab-count" id="count-replied">0</span>
                            </button>
                        </li>
                    </ul>
                    
                    <!-- Tab Content -->
                    <div class="tab-content" id="reviewTabsContent">
                        <!-- All Reviews -->
                        <div class="tab-pane fade show active" id="all" role="tabpanel">
                            <c:if test="${empty reviews}">
                                <div class="empty-state">
                                    <i class="fas fa-comments"></i>
                                    <h5>Chưa có đánh giá nào</h5>
                                    <p>Khi khách hàng đánh giá sản phẩm, chúng sẽ xuất hiện ở đây.</p>
                                </div>
                            </c:if>
                            
                            <c:forEach var="review" items="${reviews}">
                                <div class="review-card ${empty review.adminReply ? 'not-replied' : 'replied'}" 
                                     id="review-${review.id}" data-replied="${not empty review.adminReply}">
                                    
                                    <div class="review-header">
                                        <div class="customer-info">
                                            <div class="customer-avatar">
                                                ${review.userFullName.substring(0, 1).toUpperCase()}
                                            </div>
                                            <div>
                                                <div class="customer-name">${review.userFullName}</div>
                                                <div class="review-meta">
                                                    <span class="rating-stars">
                                                        <c:forEach begin="1" end="${review.rating}">
                                                            <i class="fa fa-star"></i>
                                                        </c:forEach>
                                                        <c:forEach begin="${review.rating + 1}" end="5">
                                                            <i class="fa fa-star" style="color: #ddd;"></i>
                                                        </c:forEach>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex align-items-center gap-3">
                                            <a href="/product/${review.productId}" class="product-badge" target="_blank">
                                                <i class="fas fa-laptop me-1"></i>${review.productName}
                                            </a>
                                            <c:if test="${empty review.adminReply}">
                                                <span class="status-badge pending">
                                                    <i class="fas fa-clock me-1"></i>Chưa trả lời
                                                </span>
                                            </c:if>
                                            <c:if test="${not empty review.adminReply}">
                                                <span class="status-badge replied">
                                                    <i class="fas fa-check me-1"></i>Đã trả lời
                                                </span>
                                            </c:if>
                                        </div>
                                    </div>
                                    
                                    <div class="review-body">
                                        <!-- Customer Comment -->
                                        <div class="customer-comment">
                                            <c:choose>
                                                <c:when test="${not empty review.comment}">
                                                    <i class="fas fa-quote-left text-muted me-2" style="font-size: 12px;"></i>
                                                    ${review.comment}
                                                </c:when>
                                                <c:otherwise>
                                                    <em class="text-muted">
                                                        <i class="fas fa-comment-slash me-2"></i>
                                                        Khách hàng không để lại nhận xét
                                                    </em>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        
                                        <!-- Admin Reply -->
                                        <c:if test="${not empty review.adminReply}">
                                            <div class="admin-reply-box" id="reply-box-${review.id}">
                                                <div class="admin-reply-header">
                                                    <span class="admin-reply-label">
                                                        Phản hồi từ Shop
                                                    </span>
                                                    <div>
                                                        <button class="btn btn-sm btn-light" onclick="editReply(${review.id}, '${review.adminReply}')">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <button class="btn btn-sm btn-light text-danger" onclick="deleteReply(${review.id})">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                                <p class="mb-0">${review.adminReply}</p>
                                            </div>
                                        </c:if>
                                        
                                        <!-- Reply Form -->
                                        <div class="reply-form d-none" id="reply-form-${review.id}">
                                            <div class="mb-3">
                                                <textarea class="form-control" id="reply-text-${review.id}" rows="3" 
                                                          placeholder="Nhập phản hồi của bạn để giải đáp thắc mắc của khách hàng..."></textarea>
                                            </div>
                                            <div class="d-flex justify-content-end gap-2">
                                                <button class="btn btn-light" onclick="hideReplyForm(${review.id})">
                                                    Hủy
                                                </button>
                                                <button class="btn btn-primary btn-reply" onclick="submitReply(${review.id})">
                                                    <i class="fas fa-paper-plane me-1"></i>Gửi phản hồi
                                                </button>
                                            </div>
                                        </div>
                                        
                                        <!-- Reply Button -->
                                        <c:if test="${empty review.adminReply}">
                                            <div class="mt-3" id="reply-btn-${review.id}">
                                                <button class="btn btn-outline-primary btn-sm" onclick="showReplyForm(${review.id})">
                                                    <i class="fas fa-reply me-1"></i>Trả lời đánh giá
                                                </button>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <!-- Pending Reviews -->
                        <div class="tab-pane fade" id="pending" role="tabpanel">
                            <div id="pending-reviews"></div>
                        </div>
                        
                        <!-- Replied Reviews -->
                        <div class="tab-pane fade" id="replied" role="tabpanel">
                            <div id="replied-reviews"></div>
                        </div>
                    </div>
                    
                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <nav aria-label="Page navigation" class="mt-4">
                            <ul class="pagination justify-content-center">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="/admin/review?page=${currentPage - 1}">
                                        <i class="fas fa-chevron-left"></i>
                                    </a>
                                </li>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="/admin/review?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="/admin/review?page=${currentPage + 1}">
                                        <i class="fas fa-chevron-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>
                </div>
            </main>
            <jsp:include page="../layout/footer.jsp" />
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="/js/scripts.js"></script>
    <script src="/js/review.js"></script>
</body>
</html>
