package laptopshop.controller.admin;

import java.util.HashMap;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import laptopshop.domain.dto.AdminReplyDTO;
import laptopshop.domain.dto.ReviewResponseDTO;
import laptopshop.service.ReviewService;

@Controller
public class ReviewAdminController {

    private final ReviewService reviewService;

    public ReviewAdminController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    /**
     * Trang quản lý reviews
     */
    @GetMapping("/admin/review")
    public String getReviewManagementPage(
            Model model,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "10") int size) {
        
        if (page < 1) page = 1;
        Pageable pageable = PageRequest.of(page - 1, size, Sort.by("createdAt").descending());
        Page<ReviewResponseDTO> reviews = reviewService.getAllReviews(pageable);

        model.addAttribute("reviews", reviews.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", reviews.getTotalPages());
        model.addAttribute("totalItems", reviews.getTotalElements());

        return "admin/review/show";
    }

    /**
     * Admin phản hồi review
     * POST /admin/review/{id}/reply
     */
    @PostMapping("/admin/review/{id}/reply")
    @ResponseBody
    public ResponseEntity<?> replyToReview(
            @PathVariable("id") Long reviewId,
            @Valid @RequestBody AdminReplyDTO replyDTO,
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

        long adminId = (long) session.getAttribute("id");

        try {
            ReviewResponseDTO responseDTO = reviewService.adminReplyReview(reviewId, adminId, replyDTO.getReply());
            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Phản hồi thành công",
                "data", responseDTO
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
     * Xóa phản hồi của admin
     * DELETE /admin/review/{id}/reply
     */
    @DeleteMapping("/admin/review/{id}/reply")
    @ResponseBody
    public ResponseEntity<?> deleteReply(@PathVariable("id") Long reviewId) {
        try {
            reviewService.deleteAdminReply(reviewId);
            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Đã xóa phản hồi"
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
     * Toggle visibility của review
     * POST /admin/review/{id}/toggle-visibility
     */
    @PostMapping("/admin/review/{id}/toggle-visibility")
    @ResponseBody
    public ResponseEntity<?> toggleVisibility(@PathVariable("id") Long reviewId) {
        try {
            ReviewResponseDTO responseDTO = reviewService.toggleVisibility(reviewId);
            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", responseDTO.getVisible() ? "Đã hiển thị đánh giá" : "Đã ẩn đánh giá",
                "data", responseDTO
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
     * Lấy chi tiết review
     * GET /admin/review/{id}
     */
    @GetMapping("/admin/review/{id}")
    @ResponseBody
    public ResponseEntity<?> getReviewDetail(@PathVariable("id") Long reviewId) {
        try {
            return reviewService.getReviewById(reviewId)
                    .map(review -> ResponseEntity.ok(Map.of(
                        "success", true,
                        "data", review
                    )))
                    .orElse(ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
                        "success", false,
                        "message", "Không tìm thấy review"
                    )));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of(
                "success", false,
                "message", "Có lỗi xảy ra"
            ));
        }
    }
}
