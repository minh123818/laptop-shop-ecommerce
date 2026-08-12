package laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import laptopshop.domain.Order;
import laptopshop.domain.User;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUser(User user);

    @Query("SELECT SUM(o.totalPrice) FROM Order o")
    Double getTotalRevenue();

    @Query("SELECT SUM(o.totalPrice) FROM Order o WHERE o.status = :status")
    Double getTotalRevenueByStatus(String status);

    @Query("SELECT SUM(o.totalPrice) FROM Order o WHERE MONTH(o.purchaseTime) = :month AND YEAR(o.purchaseTime) = :year AND o.status = 'COMPLETE'")
    Double getRevenueByMonthAndYear(int month, int year);

    long countByStatus(String status);

    List<Order> findTop10ByOrderByPurchaseTimeDesc();
}
