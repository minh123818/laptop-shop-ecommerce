package laptopshop.controller.client;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import laptopshop.domain.dto.AverageRatingDTO;
import laptopshop.domain.dto.ReviewRequestDTO;
import laptopshop.domain.dto.ReviewResponseDTO;
import laptopshop.service.ReviewService;

@RestController
@RequestMapping("/api/reviews")
public class ReviewController {

    private final ReviewService reviewService;

    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    /**
     * Tạo mới review
     * POST /api/reviews
     */
    @PostMapping
    public ResponseEntity<?> createReview(
            @Valid @RequestBody ReviewRequestDTO requestDTO,
            BindingResult bindingResult,
            HttpServletRequest request) {
        
        // Validate request body
        if (bindingResult.hasErrors()) {
            Map<String, String> errors = new HashMap<>();
            for (FieldError error : bindingResult.getFieldErrors()) {
                errors.put(error.getField(), error.getDefaultMessage());
            }
            return ResponseEntity.badRequest().body(Map.of(
                "success", false,
                "message", "Dữ liệu không hợp lệ",
                "errors", errors
            ));
        }

        // Get current user from session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of(
                "success", false,
                "message", "Vui lòng đăng nhập để đánh giá sản phẩm"
            ));
        }

        long userId = (long) session.getAttribute("id");

        try {
            ReviewResponseDTO responseDTO = reviewService.createReview(userId, requestDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(Map.of(
                "success", true,
                "message", "Đánh giá sản phẩm thành công",
                "data", responseDTO
            ));
        } catch (AccessDeniedException e) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(Map.of(
                "success", false,
                "message", e.getMessage()
            ));
        } catch (IllegalStateException e) {
            return ResponseEntity.badRequest().body(Map.of(
                "success", false,
                "message", e.getMessage()
            ));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
                "success", false,
                "message", e.getMessage()
            ));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of(
                "success", false,
                "message", "Có lỗi xảy ra, vui lòng thử lại sau"
            ));
        }
    }

    /**
     * Lấy danh sách reviews của một product
     * GET /api/reviews/product/{id}
     */
    @GetMapping("/product/{id}")
    public ResponseEntity<?> getReviewsByProductId(
            @PathVariable("id") Long productId,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "10") int size) {
        
        try {
            if (page < 1) page = 1;
            if (size < 1) size = 10;
            if (size > 50) size = 50; // Limit max size

            Pageable pageable = PageRequest.of(page - 1, size);
            Page<ReviewResponseDTO> reviews = reviewService.getReviewsByProductId(productId, pageable);

            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("data", reviews.getContent());
            response.put("currentPage", page);
            response.put("totalPages", reviews.getTotalPages());
            response.put("totalItems", reviews.getTotalElements());

            return ResponseEntity.ok(response);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
                "success", false,
                "message", e.getMessage()
            ));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of(
                "success", false,
                "message", "Có lỗi xảy ra, vui lòng thử lại sau"
            ));
        }
    }

    /**
     * Lấy tất cả reviews của một product (không phân trang)
     * GET /api/reviews/product/{id}/all
     */
    @GetMapping("/product/{id}/all")
    public ResponseEntity<?> getAllReviewsByProductId(@PathVariable("id") Long productId) {
        try {
            List<ReviewResponseDTO> reviews = reviewService.getReviewsByProductId(productId);
            return ResponseEntity.ok(Map.of(
                "success", true,
                "data", reviews,
                "totalItems", reviews.size()
            ));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
                "success", false,
                "message", e.getMessage()
            ));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of(
                "success", false,
                "message", "Có lỗi xảy ra, vui lòng thử lại sau"
            ));
        }
    }

    /**
     * Lấy thông tin rating trung bình của một product
     * GET /api/reviews/product/{id}/rating
     */
    @GetMapping("/product/{id}/rating")
    public ResponseEntity<?> getAverageRatingByProductId(@PathVariable("id") Long productId) {
        try {
            AverageRatingDTO averageRating = reviewService.getAverageRatingByProductId(productId);
            return ResponseEntity.ok(Map.of(
                "success", true,
                "data", averageRating
            ));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
                "success", false,
                "message", e.getMessage()
            ));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of(
                "success", false,
                "message", "Có lỗi xảy ra, vui lòng thử lại sau"
            ));
        }
    }

    /**
     * Kiểm tra user đã review product chưa
     * GET /api/reviews/check?productId={productId}
     */
    @GetMapping("/check")
    public ResponseEntity<?> checkUserReviewed(
            @RequestParam("productId") Long productId,
            HttpServletRequest request) {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of(
                "success", false,
                "message", "Vui lòng đăng nhập"
            ));
        }

        long userId = (long) session.getAttribute("id");
        boolean hasReviewed = reviewService.hasUserReviewedProduct(userId, productId);
        boolean canReview = !hasReviewed && reviewService.hasCompletedPurchase(userId, productId);

        return ResponseEntity.ok(Map.of(
            "success", true,
            "hasReviewed", hasReviewed,
            "canReview", canReview
        ));
    }

    /**
     * Cập nhật review
     * PUT /api/reviews/{id}
     */
    @PutMapping("/{id}")
    public ResponseEntity<?> updateReview(
            @PathVariable("id") Long reviewId,
            @Valid @RequestBody ReviewRequestDTO requestDTO,
            BindingResult bindingResult,
            HttpServletRequest request) {
        
        if (bindingResult.hasErrors()) {
            Map<String, String> errors = new HashMap<>();
            for (FieldError error : bindingResult.getFieldErrors()) {
                errors.put(error.getField(), error.getDefaultMessage());
            }
            return ResponseEntity.badRequest().body(Map.of(
                "success", false,
                "message", "Dữ liệu không hợp lệ",
                "errors", errors
            ));
        }

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of(
                "success", false,
                "message", "Vui lòng đăng nhập"
            ));
        }

        long userId = (long) session.getAttribute("id");

        try {
            ReviewResponseDTO responseDTO = reviewService.updateReview(reviewId, userId, requestDTO);
            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Cập nhật đánh giá thành công",
                "data", responseDTO
            ));
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(Map.of(
                "success", false,
                "message", e.getMessage()
            ));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
                "success", false,
                "message", e.getMessage()
            ));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of(
                "success", false,
                "message", "Có lỗi xảy ra, vui lòng thử lại sau"
            ));
        }
    }

    /**
     * Xóa review (soft delete)
     * DELETE /api/reviews/{id}
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteReview(
            @PathVariable("id") Long reviewId,
            HttpServletRequest request) {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of(
                "success", false,
                "message", "Vui lòng đăng nhập"
            ));
        }

        long userId = (long) session.getAttribute("id");

        try {
            reviewService.deleteReview(reviewId, userId);
            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Xóa đánh giá thành công"
            ));
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(Map.of(
                "success", false,
                "message", e.getMessage()
            ));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
                "success", false,
                "message", e.getMessage()
            ));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of(
                "success", false,
                "message", "Có lỗi xảy ra, vui lòng thử lại sau"
            ));
        }
    }
}
