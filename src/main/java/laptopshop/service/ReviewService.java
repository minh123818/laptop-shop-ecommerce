package laptopshop.service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import laptopshop.domain.Product;
import laptopshop.domain.Review;
import laptopshop.domain.User;
import laptopshop.domain.dto.AverageRatingDTO;
import laptopshop.domain.dto.ReviewRequestDTO;
import laptopshop.domain.dto.ReviewResponseDTO;
import laptopshop.repository.ProductRepository;
import laptopshop.repository.ReviewRepository;
import laptopshop.repository.UserRepository;

@Service
@Transactional
public class ReviewService {

    private final ReviewRepository reviewRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;

    public ReviewService(ReviewRepository reviewRepository, 
                        UserRepository userRepository, 
                        ProductRepository productRepository) {
        this.reviewRepository = reviewRepository;
        this.userRepository = userRepository;
        this.productRepository = productRepository;
    }

    /**
     * Tạo mới review
     * @param userId ID của user đang đăng nhập
     * @param requestDTO Thông tin review
     * @return ReviewResponseDTO
     * @throws IllegalArgumentException nếu user đã review product này rồi
     */
    public ReviewResponseDTO createReview(Long userId, ReviewRequestDTO requestDTO) {
        // Validate user exists
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy user với ID: " + userId));

        // Validate product exists
        Product product = productRepository.findById(requestDTO.getProductId())
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy sản phẩm với ID: " + requestDTO.getProductId()));

        // Check if user already reviewed this product
        if (reviewRepository.existsByUserIdAndProductId(userId, requestDTO.getProductId())) {
            throw new IllegalStateException("Bạn đã đánh giá sản phẩm này rồi. Mỗi người chỉ được đánh giá 1 lần cho mỗi sản phẩm.");
        }

        // Create review
        Review review = Review.builder()
                .rating(requestDTO.getRating())
                .comment(requestDTO.getComment())
                .user(user)
                .product(product)
                .visible(true)
                .build();

        Review savedReview = reviewRepository.save(review);
        
        return convertToResponseDTO(savedReview);
    }

    /**
     * Lấy danh sách reviews của một product
     * @param productId ID của product
     * @return List<ReviewResponseDTO>
     */
    @Transactional(readOnly = true)
    public List<ReviewResponseDTO> getReviewsByProductId(Long productId) {
        // Validate product exists
        if (!productRepository.existsById(productId)) {
            throw new IllegalArgumentException("Không tìm thấy sản phẩm với ID: " + productId);
        }

        List<Review> reviews = reviewRepository.findAllByProductId(productId);
        return reviews.stream()
                .map(this::convertToResponseDTO)
                .collect(Collectors.toList());
    }

    /**
     * Lấy danh sách reviews của một product với phân trang
     * @param productId ID của product
     * @param pageable Thông tin phân trang
     * @return Page<ReviewResponseDTO>
     */
    @Transactional(readOnly = true)
    public Page<ReviewResponseDTO> getReviewsByProductId(Long productId, Pageable pageable) {
        // Validate product exists
        if (!productRepository.existsById(productId)) {
            throw new IllegalArgumentException("Không tìm thấy sản phẩm với ID: " + productId);
        }

        Page<Review> reviews = reviewRepository.findAllByProductId(productId, pageable);
        return reviews.map(this::convertToResponseDTO);
    }

    /**
     * Lấy thông tin rating trung bình của một product
     * @param productId ID của product
     * @return AverageRatingDTO
     */
    @Transactional(readOnly = true)
    public AverageRatingDTO getAverageRatingByProductId(Long productId) {
        // Validate product exists
        if (!productRepository.existsById(productId)) {
            throw new IllegalArgumentException("Không tìm thấy sản phẩm với ID: " + productId);
        }

        Double averageRating = reviewRepository.calculateAverageRatingByProductId(productId);
        Long totalReviews = reviewRepository.countByProductId(productId);

        // Đếm số reviews theo từng rating
        Long fiveStarCount = reviewRepository.countByProductIdAndRating(productId, 5);
        Long fourStarCount = reviewRepository.countByProductIdAndRating(productId, 4);
        Long threeStarCount = reviewRepository.countByProductIdAndRating(productId, 3);
        Long twoStarCount = reviewRepository.countByProductIdAndRating(productId, 2);
        Long oneStarCount = reviewRepository.countByProductIdAndRating(productId, 1);

        return AverageRatingDTO.builder()
                .productId(productId)
                .averageRating(averageRating != null ? Math.round(averageRating * 10.0) / 10.0 : 0.0)
                .totalReviews(totalReviews != null ? totalReviews : 0L)
                .fiveStarCount(fiveStarCount != null ? fiveStarCount : 0L)
                .fourStarCount(fourStarCount != null ? fourStarCount : 0L)
                .threeStarCount(threeStarCount != null ? threeStarCount : 0L)
                .twoStarCount(twoStarCount != null ? twoStarCount : 0L)
                .oneStarCount(oneStarCount != null ? oneStarCount : 0L)
                .build();
    }

    /**
     * Lấy review theo ID
     * @param reviewId ID của review
     * @return Optional<ReviewResponseDTO>
     */
    @Transactional(readOnly = true)
    public Optional<ReviewResponseDTO> getReviewById(Long reviewId) {
        return reviewRepository.findById(reviewId)
                .map(this::convertToResponseDTO);
    }

    /**
     * Cập nhật review (chỉ user tạo review mới được cập nhật)
     * @param reviewId ID của review
     * @param userId ID của user đang đăng nhập
     * @param requestDTO Thông tin cập nhật
     * @return ReviewResponseDTO
     */
    public ReviewResponseDTO updateReview(Long reviewId, Long userId, ReviewRequestDTO requestDTO) {
        Review review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy review với ID: " + reviewId));

        // Check if user is the owner of this review
        if (review.getUser().getId() != userId) {
            throw new IllegalStateException("Bạn không có quyền chỉnh sửa review này.");
        }

        review.setRating(requestDTO.getRating());
        review.setComment(requestDTO.getComment());

        Review updatedReview = reviewRepository.save(review);
        return convertToResponseDTO(updatedReview);
    }

    /**
     * Xóa review (soft delete - đặt visible = false)
     * @param reviewId ID của review
     * @param userId ID của user đang đăng nhập
     */
    public void deleteReview(Long reviewId, Long userId) {
        Review review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy review với ID: " + reviewId));

        // Check if user is the owner of this review
        if (review.getUser().getId() != userId) {
            throw new IllegalStateException("Bạn không có quyền xóa review này.");
        }

        review.setVisible(false);
        reviewRepository.save(review);
    }

    /**
     * Kiểm tra user đã review product chưa
     * @param userId ID của user
     * @param productId ID của product
     * @return true nếu đã review, false nếu chưa
     */
    @Transactional(readOnly = true)
    public boolean hasUserReviewedProduct(Long userId, Long productId) {
        return reviewRepository.existsByUserIdAndProductId(userId, productId);
    }

    /**
     * Admin phản hồi review
     * @param reviewId ID của review
     * @param adminId ID của admin
     * @param reply Nội dung phản hồi
     * @return ReviewResponseDTO
     */
    public ReviewResponseDTO adminReplyReview(Long reviewId, Long adminId, String reply) {
        Review review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy review với ID: " + reviewId));

        User admin = userRepository.findById(adminId)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy admin với ID: " + adminId));

        review.setAdminReply(reply);
        review.setAdminReplyAt(java.time.LocalDateTime.now());
        review.setAdmin(admin);

        Review savedReview = reviewRepository.save(review);
        return convertToResponseDTO(savedReview);
    }

    /**
     * Xóa phản hồi của admin
     * @param reviewId ID của review
     */
    public void deleteAdminReply(Long reviewId) {
        Review review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy review với ID: " + reviewId));

        review.setAdminReply(null);
        review.setAdminReplyAt(null);
        review.setAdmin(null);

        reviewRepository.save(review);
    }

    /**
     * Lấy tất cả reviews (cho admin)
     */
    @Transactional(readOnly = true)
    public Page<ReviewResponseDTO> getAllReviews(Pageable pageable) {
        Page<Review> reviews = reviewRepository.findAll(pageable);
        return reviews.map(this::convertToResponseDTO);
    }

    /**
     * Toggle visibility của review (admin)
     */
    public ReviewResponseDTO toggleVisibility(Long reviewId) {
        Review review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy review với ID: " + reviewId));

        review.setVisible(!review.getVisible());
        Review savedReview = reviewRepository.save(review);
        return convertToResponseDTO(savedReview);
    }

    /**
     * Convert Review entity sang ReviewResponseDTO
     */
    private ReviewResponseDTO convertToResponseDTO(Review review) {
        return ReviewResponseDTO.builder()
                .id(review.getId())
                .rating(review.getRating())
                .comment(review.getComment())
                .userId(review.getUser().getId())
                .userFullName(review.getUser().getFullName())
                .userAvatar(review.getUser().getAvatar())
                .productId(review.getProduct().getId())
                .productName(review.getProduct().getName())
                .createdAt(review.getCreatedAt())
                .visible(review.getVisible())
                .adminReply(review.getAdminReply())
                .adminReplyAt(review.getAdminReplyAt())
                .adminName(review.getAdmin() != null ? review.getAdmin().getFullName() : null)
                .build();
    }
}
