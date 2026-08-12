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
                    <meta name="description" content=" Dự án laptopshop" />
                    <meta name="author" />
                    <link href="/css/styles.css" rel="stylesheet" />

                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>


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
                                        <li class="breadcrumb-item active">Cập nhật</li>
                                    </ol>
                                    <div class="mt-5">
                                        <div class="row">
                                            <div class="col-md-8 col-12 mx-auto">
                                                <div class="card shadow-sm">
                                                    <div class="card-header bg-primary text-white">
                                                        <h5 class="mb-0">Cập nhật đơn hàng #${newOrder.id}</h5>
                                                    </div>
                                                    <div class="card-body">
                                                        <div class="alert alert-light border mb-4">
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <p class="mb-1"><strong>Ngày đặt:</strong> ${newOrder.purchaseTimeFormatted}</p>
                                                                    <p class="mb-1"><strong>Khách hàng:</strong> ${newOrder.user.fullName}</p>
                                                                </div>
                                                                <div class="col-md-6">
                                                                     <p class="mb-1"><strong>Tổng tiền:</strong> <span class="text-danger fw-bold"><fmt:formatNumber type="number" value="${newOrder.totalPrice}" /> đ</span></p>
                                                                     <p class="mb-1"><strong>Địa chỉ:</strong> ${newOrder.receiverAddress}</p>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <form:form method="post" action="/admin/order/update" class="row g-3" modelAttribute="newOrder">
                                                            <div class="d-none">
                                                                <form:input type="hidden" path="id" />
                                                                <form:input type="hidden" path="user.fullName" /> <!-- Bind to avoid errors if needed, though disabled input usually not sent -->
                                                            </div>

                                                            <div class="col-md-12">
                                                                <label class="form-label fw-bold">Trạng thái đơn hàng:</label>
                                                                <form:select class="form-select form-select-lg" path="status">
                                                                    <form:option value="PENDING">PENDING</form:option>
                                                                    <form:option value="SHIPPING">SHIPPING</form:option>
                                                                    <form:option value="COMPLETE">COMPLETE</form:option>
                                                                    <form:option value="CANCEL">CANCEL</form:option>
                                                                </form:select>
                                                            </div>

                                                            <div class="col-12 mt-4 d-flex justify-content-between">
                                                                <a href="/admin/order" class="btn btn-secondary">Hủy</a>
                                                                <button type="submit" class="btn btn-warning px-4 fw-bold">Cập nhật</button>
                                                            </div>
                                                        </form:form>
                                                    </div>
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