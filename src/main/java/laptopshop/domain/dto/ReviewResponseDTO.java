package laptopshop.domain.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReviewResponseDTO {

    private Long id;
    private Integer rating;
    private String comment;
    private Long userId;
    private String userFullName;
    private String userAvatar;
    private Long productId;
    private String productName;
    private LocalDateTime createdAt;
    private Boolean visible;
    
    // Admin reply fields
    private String adminReply;
    private LocalDateTime adminReplyAt;
    private String adminName;
}
