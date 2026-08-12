<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Quản lý đơn hàng - Laptop Shop</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Quản lý đơn hàng</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Trang chủ</a></li>
                                    <li class="breadcrumb-item active">Đơn hàng</li>
                                </ol>
                                <div class="mt-5">
                                    <div class="row">
                                        <div class="col-12 mx-auto">
                                            <div class="d-flex">
                                                <h3>Danh sách đơn hàng</h3>
                                            </div>

                                            <hr />
                                            <table class=" table table-bordered table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Tổng giá</th>
                                                        <th>Người đặt</th>
                                                        <th>Trạng thái</th>
                                                        <th>Hành động</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="order" items="${orders}">
                                                        <tr>
                                                            <th>${order.id}</th>
                                                            <td>
                                                                <fmt:formatNumber type="number"
                                                                    value="${order.totalPrice}" /> đ
                                                            </td>
                                                            <td>${order.user.fullName}</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${order.status == 'PENDING'}">
                                                                        <span class="badge bg-warning text-dark">PENDING</span>
                                                                    </c:when>
                                                                    <c:when test="${order.status == 'SHIPPING'}">
                                                                        <span class="badge bg-info text-dark">SHIPPING</span>
                                                                    </c:when>
                                                                    <c:when test="${order.status == 'COMPLETE'}">
                                                                        <span class="badge bg-success">COMPLETE</span>
                                                                    </c:when>
                                                                    <c:when test="${order.status == 'CANCEL'}">
                                                                        <span class="badge bg-danger">CANCEL</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-secondary">${order.status}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>
                                                                <a href="/admin/order/${order.id}" class="btn btn-sm btn-success">
                                                                    <i class="fas fa-eye"></i> Xem
                                                                </a>
                                                                <a href="/admin/order/update/${order.id}" class="btn btn-sm btn-warning mx-2">
                                                                    <i class="fas fa-pen-to-square"></i> Cập nhật
                                                                </a>
                                                                <button type="button" class="btn btn-sm btn-danger btn-delete-order" data-order-id="${order.id}">
                                                                    <i class="fas fa-trash"></i> Xóa
                                                                </button>
                                                            </td>
                                                        </tr>

                                                    </c:forEach>

                                                </tbody>
                                            </table>
                                            <nav aria-label="Page navigation example">
                                                <ul class="pagination justify-content-center">
                                                    <li class="page-item">
                                                        <a class="${1 eq currentPage ? 'disabled page-link' : 'page-link'}"
                                                            href="/admin/order?page=${currentPage - 1}"
                                                            aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>
                                                    <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                                        <li class="page-item">
                                                            <a class="${(loop.index + 1) eq currentPage ? 'active page-link' : 'page-link'}"
                                                                href="/admin/order?page=${loop.index + 1}">
                                                                ${loop.index + 1}
                                                            </a>
                                                        </li>
                                                    </c:forEach>
                                                    <li class="page-item">
                                                        <a class="${totalPages eq currentPage ? 'disabled page-link' : 'page-link'}"
                                                            href="/admin/order?page=${currentPage + 1}"
                                                            aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>
                                        </div>

                                    </div>

                                </div>
                            </div>
                        </main>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>
                <jsp:include page="delete.jsp" />
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>

            </body>

            </html>