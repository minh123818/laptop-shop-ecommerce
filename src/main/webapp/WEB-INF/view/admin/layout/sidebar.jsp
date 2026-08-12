<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <div class="sb-sidenav-menu-heading">Tổng quan</div>
                        <a class="nav-link" href="/admin">
                            <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                            Dashboard
                        </a>

                        <div class="sb-sidenav-menu-heading">Quản lý</div>
                        
                        <a class="nav-link" href="/admin/user">
                            <div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>
                            Người dùng
                        </a>

                        <a class="nav-link" href="/admin/product">
                            <div class="sb-nav-link-icon"><i class="fas fa-box-open"></i></div>
                            Sản phẩm
                        </a>

                        <a class="nav-link" href="/admin/order">
                            <div class="sb-nav-link-icon"><i class="fas fa-shopping-cart"></i></div>
                            Đơn hàng
                        </a>

                        <div class="sb-sidenav-menu-heading">Khác</div>
                        <a class="nav-link" href="/admin/review">
                            <div class="sb-nav-link-icon"><i class="fas fa-star"></i></div>
                            Đánh giá KH
                        </a>
                    </div>
                </div>
                <div class="sb-sidenav-footer">
                    <div class="small">Xin chào:</div>
                    <div class="d-flex align-items-center mt-1">
                        <i class="fas fa-user-circle fa-lg me-2"></i>
                        <span class="fw-bold"><%=request.getUserPrincipal().getName()%></span>
                    </div>
                </div>
            </nav>
        </div>