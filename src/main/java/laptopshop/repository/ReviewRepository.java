package laptopshop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import laptopshop.domain.Product;
import laptopshop.domain.Review;
import laptopshop.domain.User;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

    /**
     * Kiểm tra xem user đã review product này chưa
     */
    boolean existsByUserAndProduct(User user, Product product);

    /**
     * Tìm review của user cho product cụ thể
     */
    Optional<Review> findByUserAndProduct(User user, Product product);

    /**
     * Lấy tất cả reviews của một product (chỉ visible = true)
     */
    List<Review> findByProductAndVisibleTrueOrderByCreatedAtDesc(Product product);

    /**
     * Lấy tất cả reviews của một product với phân trang (chỉ visible = true)
     */
    Page<Review> findByProductAndVisibleTrueOrderByCreatedAtDesc(Product product, Pageable pageable);

    /**
     * Lấy tất cả reviews của một product theo ID
     */
    @Query("SELECT r FROM Review r WHERE r.product.id = :productId AND r.visible = true ORDER BY r.createdAt DESC")
    List<Review> findAllByProductId(@Param("productId") Long productId);

    /**
     * Lấy tất cả reviews của một product theo ID với phân trang
     */
    @Query("SELECT r FROM Review r WHERE r.product.id = :productId AND r.visible = true ORDER BY r.createdAt DESC")
    Page<Review> findAllByProductId(@Param("productId") Long productId, Pageable pageable);

    /**
     * Tính rating trung bình của một product
     */
    @Query("SELECT AVG(r.rating) FROM Review r WHERE r.product.id = :productId AND r.visible = true")
    Double calculateAverageRatingByProductId(@Param("productId") Long productId);

    /**
     * Đếm tổng số reviews của một product
     */
    @Query("SELECT COUNT(r) FROM Review r WHERE r.product.id = :productId AND r.visible = true")
    Long countByProductId(@Param("productId") Long productId);

    /**
     * Đếm số reviews theo từng rating (1-5) của một product
     */
    @Query("SELECT COUNT(r) FROM Review r WHERE r.product.id = :productId AND r.rating = :rating AND r.visible = true")
    Long countByProductIdAndRating(@Param("productId") Long productId, @Param("rating") Integer rating);

    /**
     * Lấy tất cả reviews của một user
     */
    List<Review> findByUserOrderByCreatedAtDesc(User user);

    /**
     * Kiểm tra xem user đã review product này chưa (theo ID)
     */
    @Query("SELECT CASE WHEN COUNT(r) > 0 THEN true ELSE false END FROM Review r WHERE r.user.id = :userId AND r.product.id = :productId")
    boolean existsByUserIdAndProductId(@Param("userId") Long userId, @Param("productId") Long productId);
}
