// Review Management JavaScript
var csrfToken = $("meta[name='_csrf']").attr("content");
var csrfHeader = $("meta[name='_csrf_header']").attr("content");

// Initialize tabs and counts
$(document).ready(function() {
    updateTabCounts();
    filterReviews();
    
    // Tab change event
    $('button[data-bs-toggle="tab"]').on('shown.bs.tab', function(e) {
        filterReviews();
    });
});

function updateTabCounts() {
    var pending = 0, replied = 0;
    $('.review-card').each(function() {
        if ($(this).data('replied')) {
            replied++;
        } else {
            pending++;
        }
    });
    $('#count-pending').text(pending);
    $('#count-replied').text(replied);
}

function filterReviews() {
    var activeTab = $('.review-tabs .nav-link.active').attr('id');
    
    if (activeTab === 'pending-tab') {
        $('#pending-reviews').empty();
        $('.review-card[data-replied="false"]').clone(true).appendTo('#pending-reviews');
        if ($('#pending-reviews').children().length === 0) {
            $('#pending-reviews').html('<div class="empty-state"><i class="fas fa-check-circle"></i><h5>Tuyệt vời!</h5><p>Bạn đã trả lời tất cả đánh giá.</p></div>');
        }
    } else if (activeTab === 'replied-tab') {
        $('#replied-reviews').empty();
        $('.review-card[data-replied="true"]').clone(true).appendTo('#replied-reviews');
        if ($('#replied-reviews').children().length === 0) {
            $('#replied-reviews').html('<div class="empty-state"><i class="fas fa-inbox"></i><h5>Chưa có phản hồi</h5><p>Bạn chưa trả lời đánh giá nào.</p></div>');
        }
    }
}

function showReplyForm(reviewId) {
    $('#reply-btn-' + reviewId).addClass('d-none');
    $('#reply-form-' + reviewId).removeClass('d-none');
    $('#reply-text-' + reviewId).focus();
}

function hideReplyForm(reviewId) {
    $('#reply-form-' + reviewId).addClass('d-none');
    $('#reply-text-' + reviewId).val('');
    $('#reply-btn-' + reviewId).removeClass('d-none');
}

function editReply(reviewId, existingReply) {
    $('#reply-box-' + reviewId).addClass('d-none');
    $('#reply-form-' + reviewId).removeClass('d-none');
    $('#reply-text-' + reviewId).val(existingReply).focus();
}

function submitReply(reviewId) {
    var reply = $('#reply-text-' + reviewId).val().trim();
    if (!reply) {
        alert('Vui lòng nhập nội dung phản hồi');
        return;
    }
    
    var btn = $('#reply-form-' + reviewId + ' .btn-reply');
    btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-1"></i>Đang gửi...');
    
    $.ajax({
        url: '/admin/review/' + reviewId + '/reply',
        method: 'POST',
        contentType: 'application/json',
        beforeSend: function(xhr) {
            xhr.setRequestHeader(csrfHeader, csrfToken);
        },
        data: JSON.stringify({ reply: reply }),
        success: function(response) {
            if (response.success) {
                location.reload();
            } else {
                alert('Lỗi: ' + response.message);
                btn.prop('disabled', false).html('<i class="fas fa-paper-plane me-1"></i>Gửi phản hồi');
            }
        },
        error: function() {
            alert('Có lỗi xảy ra, vui lòng thử lại');
            btn.prop('disabled', false).html('<i class="fas fa-paper-plane me-1"></i>Gửi phản hồi');
        }
    });
}

function deleteReply(reviewId) {
    if (!confirm('Bạn có chắc muốn xóa phản hồi này?')) return;
    
    $.ajax({
        url: '/admin/review/' + reviewId + '/reply',
        method: 'DELETE',
        beforeSend: function(xhr) {
            xhr.setRequestHeader(csrfHeader, csrfToken);
        },
        success: function(response) {
            if (response.success) {
                location.reload();
            } else {
                alert('Lỗi: ' + response.message);
            }
        },
        error: function() {
            alert('Có lỗi xảy ra, vui lòng thử lại');
        }
    });
}
