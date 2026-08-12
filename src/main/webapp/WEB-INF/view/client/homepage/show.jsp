<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ - Laptopshop</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
    <link href="/client/css/style.css" rel="stylesheet">
</head>

<body>

<jsp:include page="../layout/header.jsp"/>
<jsp:include page="../layout/banner.jsp"/>

<!-- FEATURED PRODUCTS -->
<div class="container-fluid py-5">
    <div class="container">
        <div class="row mb-4 align-items-center">
            <div class="col-6">
                <h2>Sản phẩm nổi bật</h2>
            </div>
            <div class="col-6 text-end">
                <a href="/products" class="btn btn-outline-primary rounded-pill px-4">Xem thêm</a>
            </div>
        </div>

        <div class="row g-4">
            <c:forEach var="product" items="${featuredProducts}">
                <div class="col-md-6 col-lg-4 col-xl-3">
                    <div class="fruite-item h-100 d-flex flex-column rounded position-relative">

                        <!-- IMAGE -->
                        <div class="fruite-img">
                            <img src="/images/product/${product.image}"
                                 class="img-fluid w-100 rounded-top"
                                 style="height:200px; object-fit:contain;">
                        </div>

                        <!-- BADGE -->
                        <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                             style="top:10px; left:10px;">
                            ${empty product.factory ? 'Laptop' : product.factory}
                        </div>

                        <!-- CONTENT -->
                        <div class="p-4 border border-secondary border-top-0 rounded-bottom
                                    d-flex flex-column h-100 text-center">

                            <h4 style="
                                font-size:15px;
                                min-height:42px;
                                display:-webkit-box;
                                -webkit-line-clamp:2;
                                -webkit-box-orient:vertical;
                                overflow:hidden;">
                                <a href="/product/${product.id}">
                                    ${product.name}
                                </a>
                            </h4>

                            <p class="fw-bold my-2">
                                <fmt:formatNumber value="${product.price}" type="number"/> đ
                            </p>

                            <button data-product-id="${product.id}"
                                    class="btnAddToCartHomepage btn border border-secondary
                                           rounded-pill px-3 text-primary mt-auto mx-auto">
                                <i class="fa fa-shopping-bag me-2"></i>
                                Add to cart
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<!-- FACTORY PRODUCTS -->
<c:if test="${not empty factories}">
    <div class="container-fluid py-5 bg-light">
        <div class="container">
            <c:forEach var="factory" items="${factories}">
                <c:set var="currentProducts" value="${factoryProducts[factory]}"/>

                <div class="mb-5">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h3>${factory}</h3>
                        <a href="/products?factory=${factory}"
                           class="btn btn-outline-secondary rounded-pill px-4">
                            Xem thêm
                        </a>
                    </div>

                    <div class="row g-4">
                        <c:forEach var="product" items="${currentProducts}">
                            <div class="col-md-6 col-lg-4 col-xl-3">
                                <div class="fruite-item h-100 d-flex flex-column rounded position-relative">

                                    <div class="fruite-img">
                                        <img src="/images/product/${product.image}"
                                             class="img-fluid w-100 rounded-top"
                                             style="height:200px; object-fit:contain;">
                                    </div>

                                    <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                         style="top:10px; left:10px;">
                                        ${product.factory}
                                    </div>

                                    <div class="p-4 border border-secondary border-top-0
                                                rounded-bottom d-flex flex-column h-100 text-center">

                                        <h4 style="
                                            font-size:15px;
                                            min-height:42px;
                                            display:-webkit-box;
                                            -webkit-line-clamp:2;
                                            -webkit-box-orient:vertical;
                                            overflow:hidden;">
                                            <a href="/product/${product.id}">
                                                ${product.name}
                                            </a>
                                        </h4>

                                        <p class="fw-bold my-2">
                                            <fmt:formatNumber value="${product.price}" type="number"/> đ
                                        </p>

                                        <button data-product-id="${product.id}"
                                                class="btnAddToCartHomepage btn border border-secondary
                                                       rounded-pill px-3 text-primary mt-auto mx-auto">
                                            <i class="fa fa-shopping-bag me-2"></i>
                                            Add to cart
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</c:if>

<jsp:include page="../chatbox/show.jsp"/>
<jsp:include page="../layout/footer.jsp"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/client/js/main.js"></script>

</body>
</html>
