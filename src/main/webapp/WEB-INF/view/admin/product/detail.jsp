<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
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
                                <h1 class="mt-4">Quản lý sản phẩm</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Trang chủ</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/product">Sản phẩm</a></li>
                                    <li class="breadcrumb-item active">Chi tiết</li>
                                </ol>
                                <div class="container mt-5">
                                    <div class="row">
                                        <div class="col-12 mx-auto">
                                            <div class="card shadow-sm border-0">
                                                <div class="card-header bg-primary text-white">
                                                    <h5 class="mb-0">Chi tiết sản phẩm #${id}</h5>
                                                </div>
                                                <div class="card-body">
                                                    <div class="row">
                                                        <!-- Customer Image Column -->
                                                        <div class="col-md-5 d-flex justify-content-center align-items-center bg-light rounded p-3">
                                                            <img src="/images/product/${product.image}"
                                                                class="img-fluid shadow-sm" style="max-height: 400px;"
                                                                alt="${product.name}">
                                                        </div>

                                                        <!-- Product Info Column -->
                                                        <div class="col-md-7">
                                                            <h3 class="fw-bold text-primary mb-3">${product.name}</h3>
                                                            
                                                            <div class="mb-3">
                                                                <h4 class="text-danger fw-bold">
                                                                    <fmt:formatNumber type="number" value="${product.price}" /> đ
                                                                </h4>
                                                            </div>

                                                            <hr>

                                                            <div class="row mb-2">
                                                                <div class="col-sm-4 fw-bold">ID:</div>
                                                                <div class="col-sm-8">${product.id}</div>
                                                            </div>
                                                            <div class="row mb-2">
                                                                <div class="col-sm-4 fw-bold">Hãng sản xuất:</div>
                                                                <div class="col-sm-8"><span class="badge bg-info text-dark">${product.factory}</span></div>
                                                            </div>
                                                            <div class="row mb-2">
                                                                <div class="col-sm-4 fw-bold">Trạng thái:</div>
                                                                <div class="col-sm-8">
                                                                    <span class="badge bg-success">Đang kinh doanh</span>
                                                                </div>
                                                            </div>

                                                            <div class="mt-4">
                                                                <h6 class="fw-bold">Mô tả ngắn:</h6>
                                                                <div class="p-3 bg-light rounded text-muted small">
                                                                     ${product.shortDesc}
                                                                </div>
                                                            </div>
                                                            
                                                             <div class="mt-3">
                                                                <h6 class="fw-bold">Chi tiết:</h6>
                                                                <p class="text-muted small">${product.detailDesc}</p>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="card-footer bg-white">
                                                    <div class="d-flex justify-content-start">
                                                        <a href="/admin/product" class="btn btn-secondary">
                                                            <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
                                                        </a>
                                                        <a href="/admin/product/update/${product.id}" class="btn btn-warning ms-2">
                                                            <i class="fas fa-pen-to-square me-2"></i>Cập nhật
                                                        </a>
                                                    </div>
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