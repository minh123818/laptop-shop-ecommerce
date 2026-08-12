<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <title>Chi tiết đơn hàng -</title>
                    <link href="/css/styles.css" rel="stylesheet" />

                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                </head>

                <body class="sb-nav-fixed">
                    <jsp:include page="../layout/header.jsp" />
                    <div id="layoutSidenav">
                        <jsp:include page="../layout/sidebar.jsp" />
                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid px-4">
                                    <h1 class="mt-4">Orders</h1>
                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item"><a href="/admin">Trang chủ</a></li>
                                        <li class="breadcrumb-item"><a href="/admin/order">Đơn hàng</a></li>
                                        <li class="breadcrumb-item active">Chi tiết</li>
                                    </ol>
                                    <div class="mt-5">
                                        <div class="row">
                                            <div class="col-12 mx-auto">
                                                <!-- Header -->
                                                <div
                                                    class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-4">
                                                    <div>
                                                        <h3>Đơn hàng #${order.id}</h3>
                                                        <span class="text-muted">Ngày đặt:
                                                            ${order.purchaseTimeFormatted}</span>
                                                    </div>
                                                    <div>
                                                        <c:choose>
                                                            <c:when test="${order.status == 'PENDING'}">
                                                                <span
                                                                    class="badge bg-warning text-dark fs-6">PENDING</span>
                                                            </c:when>
                                                            <c:when test="${order.status == 'SHIPPING'}">
                                                                <span
                                                                    class="badge bg-info text-dark fs-6">SHIPPING</span>
                                                            </c:when>
                                                            <c:when test="${order.status == 'COMPLETE'}">
                                                                <span class="badge bg-success fs-6">COMPLETE</span>
                                                            </c:when>
                                                            <c:when test="${order.status == 'CANCEL'}">
                                                                <span class="badge bg-danger fs-6">CANCEL</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span
                                                                    class="badge bg-secondary fs-6">${order.status}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>

                                                <!-- Info Cards -->
                                                <div class="row mb-4">
                                                    <div class="col-md-6">
                                                        <div class="card h-100 shadow-sm">
                                                            <div class="card-header bg-light">
                                                                <h6 class="mb-0"><i class="fas fa-user me-2"></i>Thông
                                                                    tin khách hàng</h6>
                                                            </div>
                                                            <div class="card-body">
                                                                <p class="mb-1"><strong>Tên:</strong>
                                                                    ${order.user.fullName}</p>
                                                                <p class="mb-1"><strong>Email:</strong>
                                                                    ${order.user.email}</p>
                                                                <p class="mb-0"><strong>ID:</strong> ${order.user.id}
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="card h-100 shadow-sm">
                                                            <div class="card-header bg-light">
                                                                <h6 class="mb-0"><i class="fas fa-truck me-2"></i>Địa
                                                                    chỉ giao hàng</h6>
                                                            </div>
                                                            <div class="card-body">
                                                                <p class="mb-1"><strong>Người nhận:</strong>
                                                                    ${order.receiverName}</p>
                                                                <p class="mb-1"><strong>SĐT:</strong>
                                                                    ${order.receiverPhone}</p>
                                                                <p class="mb-0"><strong>Địa chỉ:</strong>
                                                                    ${order.receiverAddress}</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="table-responsive">
                                                    <table class="table table-bordered table-hover">
                                                        <thead class="table-light">
                                                            <tr>
                                                                <th scope="col">Hình ảnh</th>
                                                                <th scope="col">Tên sản phẩm</th>
                                                                <th scope="col">Giá</th>
                                                                <th scope="col">Số lượng</th>
                                                                <th scope="col">Thành tiền</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:if test="${ empty orderDetails}">
                                                                <tr>
                                                                    <td colspan="5" class="text-center">
                                                                        Không có sản phẩm nào
                                                                    </td>
                                                                </tr>
                                                            </c:if>
                                                            <c:forEach var="orderDetail" items="${orderDetails}">
                                                                <tr>
                                                                    <td style="width: 100px;">
                                                                        <img src="/images/product/${orderDetail.product.image}"
                                                                            class="img-fluid rounded"
                                                                            style="width: 60px; height: 60px; object-fit: cover;"
                                                                            alt="">
                                                                    </td>
                                                                    <td class="align-middle">
                                                                        <a href="/product/${orderDetail.product.id}"
                                                                            target="_blank"
                                                                            class="text-decoration-none fw-bold">
                                                                            ${orderDetail.product.name}
                                                                        </a>
                                                                    </td>
                                                                    <td class="align-middle">
                                                                        <fmt:formatNumber type="number"
                                                                            value="${orderDetail.price}" /> đ
                                                                    </td>
                                                                    <td class="align-middle text-center">
                                                                        ${orderDetail.quantity}
                                                                    </td>
                                                                    <td class="align-middle fw-bold text-primary">
                                                                        <fmt:formatNumber type="number"
                                                                            value="${orderDetail.price * orderDetail.quantity}" />
                                                                        đ
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                            <!-- Grand Total Row -->
                                                            <tr class="table-light">
                                                                <td colspan="4" class="text-end fw-bold fs-5">Tổng tiền:
                                                                </td>
                                                                <td class="fw-bold fs-5 text-danger">
                                                                    <fmt:formatNumber type="number"
                                                                        value="${order.totalPrice}" /> đ
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                                <div class="d-flex justify-content-start mt-3">
                                                    <a href="/admin/order" class="btn btn-secondary">
                                                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                                                    </a>
                                                    <a href="/admin/order/update/${order.id}"
                                                        class="btn btn-warning ms-2">
                                                        <i class="fas fa-pen-to-square me-2"></i>Cập nhật đơn hàng
                                                    </a>
                                                </div>

                                            </div>

                                        </div>

                                    </div>
                                </div>
                            </main>
                            <jsp:include page="../layout/footer.jsp" />
                        </div>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                        crossorigin="anonymous"></script>
                    <script src="/js/scripts.js"></script>

                </body>

                </html>