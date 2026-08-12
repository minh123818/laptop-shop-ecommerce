<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <title>Update User - Laptop Shop</title>

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
                                <h1 class="mt-4">Manage Users</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Trang chủ</a></li>
                                    <li class="breadcrumb-item active">Người dùng</li>
                                </ol>
                                <div class=" mt-5">
                                    <div class="row">
                                        <div class="col-md-10 mx-auto">
                                            <h3>Cập nhật người dùng</h3>
                                            <hr />
                                            <form:form method="post" action="/admin/user/update"
                                                modelAttribute="newUser">
                                                
                                                <div class="mb-3" style="display: none;">
                                                    <label class="form-label">Id:</label>
                                                    <form:input type="text" class="form-control" path="id" />
                                                </div>

                                                <div class="row">
                                                    <!-- Account Info -->
                                                    <div class="col-md-6">
                                                        <div class="card mb-4">
                                                            <div class="card-header bg-light fw-bold">Thông tin tài khoản</div>
                                                            <div class="card-body">
                                                                <div class="form-floating mb-3">
                                                                    <form:input type="email" class="form-control" path="email"
                                                                        disabled="true" id="emailInput" placeholder="name@example.com"/>
                                                                    <label for="emailInput">Email (Không thể thay đổi)</label>
                                                                </div>
                                                                <div class="form-floating mb-3">
                                                                    <select class="form-select" disabled>
                                                                        <option>${newUser.role.name}</option>
                                                                    </select>
                                                                    <label>Vai trò</label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Personal Info -->
                                                    <div class="col-md-6">
                                                        <div class="card mb-4">
                                                            <div class="card-header bg-light fw-bold">Thông tin cá nhân</div>
                                                            <div class="card-body">
                                                                <div class="form-floating mb-3">
                                                                    <form:input type="text" class="form-control" path="fullName" id="fullNameInput" placeholder="Full Name"/>
                                                                    <label for="fullNameInput">Họ và tên</label>
                                                                </div>
                                                                <div class="form-floating mb-3">
                                                                    <form:input type="text" class="form-control" path="phone" id="phoneInput" placeholder="Phone"/>
                                                                    <label for="phoneInput">Số điện thoại</label>
                                                                </div>
                                                                <div class="form-floating mb-3">
                                                                    <form:input type="text" class="form-control" path="address" id="addressInput" placeholder="Address"/>
                                                                    <label for="addressInput">Địa chỉ</label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <button type="submit" class="btn btn-warning">Cập nhật</button>
                                                <a href="/admin/user" class="btn btn-secondary">Quay lại</a>
                                            </form:form>
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