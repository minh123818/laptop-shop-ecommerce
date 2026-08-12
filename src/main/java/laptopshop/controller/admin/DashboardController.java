package laptopshop.controller.admin;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import laptopshop.service.OrderService;
import laptopshop.service.UserService;

@Controller
public class DashboardController {

    private final UserService userService;
    private final OrderService orderService;

    public DashboardController(UserService userService, OrderService orderService) {
        this.userService = userService;
        this.orderService = orderService;
    }

    @GetMapping("/admin")
    public String getDashboard(Model model) {
        // Core KPI Stats
        model.addAttribute("countUsers", this.userService.countUsers());
        model.addAttribute("countProducts", this.userService.countProducts());
        model.addAttribute("countOrders", this.orderService.countOrder());

        // Revenue (Standard is to show Completed Revenue)
        model.addAttribute("totalRevenue", this.orderService.countTotalRevenueByStatus("COMPLETE"));

        // Recent Orders
        model.addAttribute("recentOrders", this.orderService.fetchTop10RecentOrders());

        // Status Distribution for Donut Chart
        model.addAttribute("pendingCount", this.orderService.countOrdersByStatus("PENDING"));
        model.addAttribute("shippingCount", this.orderService.countOrdersByStatus("SHIPPING"));
        model.addAttribute("completeCount", this.orderService.countOrdersByStatus("COMPLETE"));
        model.addAttribute("cancelledCount", this.orderService.countOrdersByStatus("CANCELLED"));

        // Revenue Chart Data (Last 6 Months)
        List<Double> revenueList = new ArrayList<>();
        List<String> monthLabels = new ArrayList<>();
        LocalDateTime now = LocalDateTime.now();

        for (int i = 0; i < 6; i++) {
            LocalDateTime targetDate = now.minusMonths(i);
            int month = targetDate.getMonthValue();
            int year = targetDate.getYear();
            revenueList.add(this.orderService.getRevenueByMonthAndYear(month, year));
            monthLabels.add("Tháng " + month);
        }

        Collections.reverse(revenueList);
        Collections.reverse(monthLabels);

        model.addAttribute("revenueData", revenueList);
        model.addAttribute("revenueLabels", monthLabels);

        return "admin/dashboard/show";
    }
}
