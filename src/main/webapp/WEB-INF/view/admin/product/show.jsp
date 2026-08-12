<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

           <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <title>Quản lý sản phẩm - Laptop Shop</title>

    <link href="/css/styles.css" rel="stylesheet" />

    <c:if test="${not empty _csrf}">
        <meta name="_csrf" content="${_csrf.token}" />
        <meta name="_csrf_header" content="${_csrf.headerName}" />
    </c:if>

    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Quản lý sản phẩm</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Trang chủ</a></li>
                                    <li class="breadcrumb-item active">Sản phẩm</li>
                                </ol>
                                <div class="mt-5">
                                    <div class="row">
                                        <div class="col-12 mx-auto">
                                            <div class="d-flex justify-content-between">
                                                <h3>Danh sách sản phẩm</h3>
                                                <a href="/admin/product/create" class="btn btn-primary">
                                                    <i class="fas fa-plus me-2"></i>Thêm mới sản phẩm
                                                </a>
                                            </div>

                                            <hr />
                                            <table class=" table table-bordered table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Tên sản phẩm</th>
                                                        <th>Giá</th>
                                                        <th>Hãng sản xuất</th>
                                                        <th>Hành động</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="product" items="${products}">
                                                        <tr>
                                                            <th>${product.id}</th>
                                                            <td>${product.name}</td>
                                                            <td>
                                                                <fmt:formatNumber type="number"
                                                                    value="${product.price}" /> đ
                                                            </td>
                                                            <td>${product.factory}</td>
                                                            <td>
                                                                <a href="/admin/product/${product.id}" class="btn btn-sm btn-success">
                                                                    <i class="fas fa-eye"></i> Xem
                                                                </a>
                                                                <a href="/admin/product/update/${product.id}" class="btn btn-sm btn-warning mx-2">
                                                                    <i class="fas fa-pen-to-square"></i> Cập nhật
                                                                </a>
                                                                <button type="button" class="btn btn-sm btn-danger btn-delete-product" data-product-id="${product.id}">
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
                                                            href="/admin/product?page=${currentPage - 1}"
                                                            aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>
                                                    <c:if test="${totalPages > 0}">
                                                        <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                                            <li class="page-item">
                                                                <a class="${(loop.index + 1) eq currentPage ? 'active page-link' : 'page-link'}"
                                                                    href="/admin/product?page=${loop.index + 1}">
                                                                    ${loop.index + 1}
                                                                </a>
                                                            </li>
                                                        </c:forEach>
                                                    </c:if>
                                                    <li class="page-item">
                                                        <a class="${totalPages eq currentPage ? 'disabled page-link' : 'page-link'}"
                                                            href="/admin/product?page=${currentPage + 1}"
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
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>

<jsp:include page="delete.jsp" />

            </body>

            </html>