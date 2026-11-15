// Client Review JavaScript
$(document).ready(function() {
    const productId = window.PRODUCT_ID;
    if (!productId) return;
    
    let currentPage = 1;
    let totalPages = 1;
    const csrfToken = $("meta[name='_csrf']").attr("content");
    const csrfHeader = $("meta[name='_csrf_header']").attr("content");

    // Load rating summary
    function loadRatingSummary() {
        $.ajax({
            url: '/api/reviews/product/' + productId + '/rating',
            method: 'GET',
            success: function(response) {
                if (response.success) {
                    const data = response.data;
                    $('#avg-rating').text(data.averageRating.toFixed(1));
                    $('#total-reviews').text(data.totalReviews);
                    $('#rating-text').text('(' + data.totalReviews + ' đánh giá)');
                    $('#tab-review-count').text(data.totalReviews);
                    
                    // Update rating value
                    if ($('#rating-value').length) {
                        $('#rating-value').text(data.averageRating.toFixed(1));
                    }
                    
                    // Update stars
                    updateStars('#avg-stars', data.averageRating);
                    updateStars('#product-rating .stars', data.averageRating);
                    
                    // Update bars
                    const total = data.totalReviews || 1;
                    $('#count-5').text(data.fiveStarCount);
                    $('#count-4').text(data.fourStarCount);
                    $('#count-3').text(data.threeStarCount);
                    $('#count-2').text(data.twoStarCount);
                    $('#count-1').text(data.oneStarCount);
                    
                    $('#bar-5').css('width', (data.fiveStarCount / total * 100) + '%');
                    $('#bar-4').css('width', (data.fourStarCount / total * 100) + '%');
                    $('#bar-3').css('width', (data.threeStarCount / total * 100) + '%');
                    $('#bar-2').css('width', (data.twoStarCount / total * 100) + '%');
                    $('#bar-1').css('width', (data.oneStarCount / total * 100) + '%');
                }
            }
        });
    }

    // Update star display
    function updateStars(selector, rating) {
        $(selector + ' .fa-star').each(function(index) {
            if (index < Math.round(rating)) {
                $(this).addClass('active text-warning');
            } else {
                $(this).removeClass('active text-warning');
            }
        });
    }

    // Load reviews
    function loadReviews(page) {
        $.ajax({
            url: '/api/reviews/product/' + productId + '?page=' + page + '&size=5',
            method: 'GET',
            success: function(response) {
                if (response.success) {
                    totalPages = response.totalPages;
                    currentPage = response.currentPage;
                    
                    if (page === 1) {
                        $('#reviews-list').empty();
                    }
                    
                    if (response.data.length === 0 && page === 1) {
                        $('#reviews-list').html('<p class="text-muted text-center py-3">Chưa có đánh giá nào cho sản phẩm này.</p>');
                    } else {
                        response.data.forEach(function(review) {
                            $('#reviews-list').append(createReviewHtml(review));
                        });
                    }
                    
                    // Show/hide load more button
                    if (currentPage < totalPages) {
                        $('#load-more-container').removeClass('d-none');
                    } else {
                        $('#load-more-container').addClass('d-none');
                    }
                }
            },
            error: function() {
                $('#reviews-list').html('<p class="text-danger text-center py-3">Không thể tải đánh giá. Vui lòng thử lại.</p>');
            }
        });
    }

    function escapeHtml(value) {
        return $('<div>').text(value).html();
    }

    // Create review HTML
    function createReviewHtml(review) {
        var starsHtml = '';
        var rating = review.rating || 0;
        for (var i = 1; i <= 5; i++) {
            if (i <= rating) {
                starsHtml += '<i class="fa fa-star text-warning"></i>';
            } else {
                starsHtml += '<i class="fa fa-star"></i>';
            }
        }
        
        // Handle date - LocalDateTime from Java can be array or string
        var dateStr = '';
        if (review.createdAt) {
            try {
                var date;
                if (Array.isArray(review.createdAt)) {
                    // Java LocalDateTime serialized as array [year, month, day, hour, minute, second, nano]
                    var arr = review.createdAt;
                    date = new Date(arr[0], arr[1] - 1, arr[2], arr[3] || 0, arr[4] || 0, arr[5] || 0);
                } else if (typeof review.createdAt === 'string') {
                    date = new Date(review.createdAt);
                } else {
                    date = new Date(review.createdAt);
                }
                
                if (!isNaN(date.getTime())) {
                    dateStr = date.toLocaleDateString('vi-VN') + ' ' + date.toLocaleTimeString('vi-VN', {hour: '2-digit', minute: '2-digit'});
                }
            } catch(e) {
                console.log('Date parse error:', e);
                dateStr = '';
            }
        }
        
        // Handle comment
        var commentText = '';
        if (review.comment && review.comment.trim() !== '') {
            commentText = escapeHtml(review.comment);
        } else {
            commentText = '<em class="text-muted">Không có nhận xét</em>';
        }
        
        // Handle user name
        var userName = review.userFullName || 'Người dùng';
        var userInitial = userName.charAt(0).toUpperCase();
        
        // Handle admin reply
        var adminReplyHtml = '';
        if (review.adminReply && review.adminReply.trim() !== '') {
            var adminReplyDate = '';
            if (review.adminReplyAt) {
                try {
                    var replyDate;
                    if (Array.isArray(review.adminReplyAt)) {
                        var arr = review.adminReplyAt;
                        replyDate = new Date(arr[0], arr[1] - 1, arr[2], arr[3] || 0, arr[4] || 0, arr[5] || 0);
                    } else {
                        replyDate = new Date(review.adminReplyAt);
                    }
                    if (!isNaN(replyDate.getTime())) {
                        adminReplyDate = replyDate.toLocaleDateString('vi-VN');
                    }
                } catch(e) {}
            }
            
            var adminName = review.adminName || 'Quản trị viên';
            adminReplyHtml = '<div class="admin-reply-box mt-3">' +
                '<div class="admin-reply-header">' +
                    '<span class="admin-reply-label"><i class="fas fa-store me-1"></i>Phản hồi từ ' + escapeHtml(adminName) + '</span>' +
                    '<small class="text-muted">' + adminReplyDate + '</small>' +
                '</div>' +
                '<div class="admin-reply-content">' + escapeHtml(review.adminReply) + '</div>' +
            '</div>';
        }
        
        var purchaseBadge = review.verifiedPurchase === true
            ? ' <span class="badge bg-success">Đã mua hàng</span>'
            : '';
        var html = '<div class="review-item">' +
            '<div class="review-item-header">' +
                '<div class="reviewer-info">' +
                    '<div class="reviewer-avatar">' + escapeHtml(userInitial) + '</div>' +
                    '<div>' +
                        '<div class="reviewer-name">' + escapeHtml(userName) + purchaseBadge + '</div>' +
                        '<div class="review-date">' + dateStr + '</div>' +
                    '</div>' +
                '</div>' +
                '<div class="review-rating">' + starsHtml + '</div>' +
            '</div>' +
            '<div class="review-content">' + commentText + '</div>' +
            adminReplyHtml +
        '</div>';
        
        return html;
    }

    function showReviewStatus(message) {
        $('#review-form-container').addClass('d-none');
        $('#review-status').text(message);
    }

    function checkReviewEligibility() {
        if (!$('#review-form-container').length) return;

        $.ajax({
            url: '/api/reviews/check?productId=' + productId,
            method: 'GET',
            dataType: 'json',
            success: function(response) {
                if (response.hasReviewed === true) {
                    showReviewStatus('Bạn đã đánh giá sản phẩm này.');
                } else if (response.canReview === true) {
                    $('#review-status').empty();
                    $('#review-form-container').removeClass('d-none');
                } else {
                    showReviewStatus('Bạn có thể đánh giá sản phẩm sau khi đơn hàng hoàn tất.');
                }
            },
            error: function() {
                showReviewStatus('Không thể kiểm tra điều kiện đánh giá. Vui lòng tải lại trang.');
            }
        });
    }

    // Star rating input
    $('.star-input').hover(
        function() {
            const rating = $(this).data('rating');
            $('.star-rating-input .star-input, .star-rating .star-input').each(function() {
                if ($(this).data('rating') <= rating) {
                    $(this).addClass('hovered');
                } else {
                    $(this).removeClass('hovered');
                }
            });
        },
        function() {
            $('.star-rating-input .star-input, .star-rating .star-input').removeClass('hovered');
        }
    );

    $('.star-input').click(function() {
        const rating = $(this).data('rating');
        $('#rating-input').val(rating);
        $('.star-rating-input .star-input, .star-rating .star-input').each(function() {
            if ($(this).data('rating') <= rating) {
                $(this).addClass('active');
            } else {
                $(this).removeClass('active');
            }
        });
    });

    // Submit review
    $('#review-form').submit(function(e) {
        e.preventDefault();
        
        const rating = parseInt($('#rating-input').val());
        const comment = $('#comment-input').val().trim();

        if (rating === 0) {
            $.toast({
                heading: 'Lỗi',
                text: 'Vui lòng chọn số sao đánh giá',
                icon: 'error',
                position: 'top-right'
            });
            return;
        }

        $('#submit-review-btn').prop('disabled', true).text('Đang gửi...');

        $.ajax({
            url: '/api/reviews',
            method: 'POST',
            contentType: 'application/json',
            beforeSend: function(xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            data: JSON.stringify({
                productId: productId,
                rating: rating,
                comment: comment
            }),
            success: function(response) {
                if (response.success) {
                    $.toast({
                        heading: 'Thành công',
                        text: 'Cảm ơn bạn đã đánh giá sản phẩm!',
                        icon: 'success',
                        position: 'top-right'
                    });
                    
                    // Hide form and show message
                    showReviewStatus('Bạn đã đánh giá sản phẩm này.');
                    
                    // Reload reviews and rating
                    loadRatingSummary();
                    loadReviews(1);
                } else {
                    $.toast({
                        heading: 'Lỗi',
                        text: response.message,
                        icon: 'error',
                        position: 'top-right'
                    });
                }
            },
            error: function(xhr) {
                const response = xhr.responseJSON;
                if (xhr.status === 403) checkReviewEligibility();
                $.toast({
                    heading: 'Lỗi',
                    text: response ? response.message : 'Có lỗi xảy ra, vui lòng thử lại',
                    icon: 'error',
                    position: 'top-right'
                });
            },
            complete: function() {
                $('#submit-review-btn').prop('disabled', false).text('Gửi đánh giá');
            }
        });
    });

    // Load more button
    $('#load-more-btn').click(function() {
        loadReviews(currentPage + 1);
    });

    // Initial load
    loadRatingSummary();
    loadReviews(1);
    checkReviewEligibility();
});
