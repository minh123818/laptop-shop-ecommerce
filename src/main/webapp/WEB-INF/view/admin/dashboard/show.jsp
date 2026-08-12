<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="Laptop Shop" />
                <meta name="author" content="Laptop Shop" />
                <title>Bảng điều khiển - LaptopShop Admin</title>
                <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <style>
                    .card-box {
                        position: relative;
                        color: #fff;
                        padding: 20px 10px 40px;
                        margin: 20px 0px;
                        border-radius: 10px;
                    }

                    .card-box:hover {
                        text-decoration: none;
                        color: #f1f1f1;
                    }

                    .card-box:hover .icon i {
                        font-size: 100px;
                        transition: 1s;
                        -webkit-transition: 1s;
                    }

                    .card-box .inner {
                        padding: 5px 10px 0 10px;
                    }

                    .card-box h3 {
                        font-size: 27px;
                        font-weight: bold;
                        margin: 0 0 8px 0;
                        white-space: nowrap;
                        padding: 0;
                        text-align: left;
                    }

                    .card-box p {
                        font-size: 15px;
                    }

                    .card-box .icon {
                        position: absolute;
                        top: auto;
                        bottom: 5px;
                        right: 5px;
                        z-index: 0;
                        font-size: 72px;
                        color: rgba(0, 0, 0, 0.15);
                    }

                    .card-box .card-box-footer {
                        position: absolute;
                        left: 0px;
                        bottom: 0px;
                        text-align: center;
                        padding: 3px 0;
                        color: rgba(255, 255, 255, 0.8);
                        background: rgba(0, 0, 0, 0.1);
                        width: 100%;
                        text-decoration: none;
                        border-bottom-left-radius: 10px;
                        border-bottom-right-radius: 10px;
                    }

                    .bg-blue {
                        background-color: #007bff !important;
                    }

                    .bg-green {
                        background-color: #28a745 !important;
                    }

                    .bg-orange {
                        background-color: #fd7e14 !important;
                    }

                    .bg-red {
                        background-color: #dc3545 !important;
                    }
                </style>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Tổng quan bảng điều khiển</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item active">Hiệu năng & Thống kê hệ thống</li>
                                </ol>

                                <!-- KPI Cards Section -->
                                <div class="row">
                                    <div class="col-lg-3 col-6">
                                        <div class="card-box bg-blue">
                                            <div class="inner">
                                                <h3>${countUsers}</h3>
                                                <p>Tổng thành viên</p>
                                            </div>
                                            <div class="icon">
                                                <i class="fa fa-users" aria-hidden="true"></i>
                                            </div>
                                            <a href="/admin/user" class="card-box-footer">Xem thêm <i
                                                    class="fa fa-arrow-circle-right"></i></a>
                                        </div>
                                    </div>

                                    <div class="col-lg-3 col-6">
                                        <div class="card-box bg-green">
                                            <div class="inner">
                                                <h3>${countProducts}</h3>
                                                <p>Tổng sản phẩm</p>
                                            </div>
                                            <div class="icon">
                                                <i class="fa fa-laptop" aria-hidden="true"></i>
                                            </div>
                                            <a href="/admin/product" class="card-box-footer">Xem thêm <i
                                                    class="fa fa-arrow-circle-right"></i></a>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-6">
                                        <div class="card-box bg-orange">
                                            <div class="inner">
                                                <h3>${countOrders}</h3>
                                                <p>Tổng đơn hàng</p>
                                            </div>
                                            <div class="icon">
                                                <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                            </div>
                                            <a href="/admin/order" class="card-box-footer">Xem thêm <i
                                                    class="fa fa-arrow-circle-right"></i></a>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-6">
                                        <div class="card-box bg-red">
                                            <div class="inner">
                                                <h3>
                                                    <fmt:formatNumber type="number" value="${totalRevenue}"
                                                        pattern="###,###" /> ₫
                                                </h3>
                                                <p>Doanh thu trọn đời</p>
                                            </div>
                                            <div class="icon">
                                                <i class="fa fa-dollar-sign"></i>
                                            </div>
                                            <a href="#" class="card-box-footer">Xem chi tiết <i
                                                    class="fa fa-arrow-circle-right"></i></a>
                                        </div>
                                    </div>
                                </div>

                                <!-- Charts Section -->
                                <div class="row">
                                    <div class="col-xl-6">
                                        <div class="card mb-4">
                                            <div class="card-header">
                                                <i class="fas fa-chart-area me-1"></i>
                                                Tăng trưởng doanh thu (6 tháng gần đây)
                                            </div>
                                            <div class="card-body"><canvas id="myAreaChart" width="100%"
                                                    height="40"></canvas></div>
                                        </div>
                                    </div>
                                    <div class="col-xl-6">
                                        <div class="card mb-4">
                                            <div class="card-header">
                                                <i class="fas fa-chart-pie me-1"></i>
                                                Phân bố trạng thái đơn hàng
                                            </div>
                                            <div class="card-body"><canvas id="myPieChart" width="100%"
                                                    height="40"></canvas></div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Recent Orders Table -->
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-table me-1"></i>
                                        Đơn hàng gần đây (Cần xử lý)
                                    </div>
                                    <div class="card-body">
                                        <table class="table table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Mã ĐH</th>
                                                    <th>Khách hàng</th>
                                                    <th>Sản phẩm</th>
                                                    <th>Tổng tiền</th>
                                                    <th>Trạng thái</th>
                                                    <th>Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="order" items="${recentOrders}">
                                                    <tr>
                                                        <td>#ORD-${order.id}</td>
                                                        <td>${order.receiverName}</td>
                                                        <td>
                                                            <c:forEach var="detail" items="${order.orderDetails}"
                                                                varStatus="status">
                                                                ${detail.product.name}${!status.last ? ', ' : ''}
                                                            </c:forEach>
                                                        </td>
                                                        <td>
                                                            <fmt:formatNumber type="number" value="${order.totalPrice}"
                                                                pattern="###,###" /> ₫
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${order.status == 'PENDING'}">
                                                                    <span class="badge bg-warning text-dark">Chờ xử
                                                                        lý</span>
                                                                </c:when>
                                                                <c:when test="${order.status == 'SHIPPING'}">
                                                                    <span class="badge bg-info text-dark">Đang
                                                                        giao</span>
                                                                </c:when>
                                                                <c:when test="${order.status == 'COMPLETE'}">
                                                                    <span class="badge bg-success">Hoàn thành</span>
                                                                </c:when>
                                                                <c:when test="${order.status == 'CANCELLED'}">
                                                                    <span class="badge bg-danger">Đã hủy</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span
                                                                        class="badge bg-secondary">${order.status}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td><a href="/admin/order/${order.id}"
                                                                class="btn btn-sm btn-primary">Chi tiết</a></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
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
                <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
                    crossorigin="anonymous"></script>

                <script>
                    // Set new default font family and font color to mimic Bootstrap's default styling
                    Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
                    Chart.defaults.global.defaultFontColor = '#292b2c';

                    // Area Chart Example
                    var ctx = document.getElementById("myAreaChart");
                    var myLineChart = new Chart(ctx, {
                        type: 'line',
                        data: {
                            labels: [
                                <c:forEach var="label" items="${revenueLabels}" varStatus="status">
                                    "${label}"${!status.last ? ',' : ''}
                                </c:forEach>
                            ],
                            datasets: [{
                                label: "Doanh thu",
                                lineTension: 0.3,
                                backgroundColor: "rgba(2,117,216,0.2)",
                                borderColor: "rgba(2,117,216,1)",
                                pointRadius: 5,
                                pointBackgroundColor: "rgba(2,117,216,1)",
                                pointBorderColor: "rgba(255,255,255,0.8)",
                                pointHoverRadius: 5,
                                pointHoverBackgroundColor: "rgba(2,117,216,1)",
                                pointHitRadius: 50,
                                pointBorderWidth: 2,
                                data: [
                                    <c:forEach var="rev" items="${revenueData}" varStatus="status">
                                        ${rev}${!status.last ? ',' : ''}
                                    </c:forEach>
                                ],
                            }],
                        },
                        options: {
                            scales: {
                                xAxes: [{
                                    time: {
                                        unit: 'date'
                                    },
                                    gridLines: {
                                        display: false
                                    },
                                    ticks: {
                                        maxTicksLimit: 7
                                    }
                                }],
                                yAxes: [{
                                    ticks: {
                                        min: 0,
                                        maxTicksLimit: 5,
                                        callback: function (value, index, values) {
                                            return value.toLocaleString('vi-VN') + ' ₫';
                                        }
                                    },
                                    gridLines: {
                                        color: "rgba(0, 0, 0, .125)",
                                    }
                                }],
                            },
                            legend: {
                                display: false
                            },
                            tooltips: {
                                callbacks: {
                                    label: function (tooltipItem, chart) {
                                        return chart.datasets[tooltipItem.datasetIndex].label + ': ' + tooltipItem.yLabel.toLocaleString('vi-VN') + ' ₫';
                                    }
                                }
                            }
                        }
                    });

                    // Pie Chart Example
                    var ctx = document.getElementById("myPieChart");
                    var myPieChart = new Chart(ctx, {
                        type: 'doughnut',
                        data: {
                            labels: ["Hoàn thành", "Chờ xử lý", "Đã hủy", "Vận chuyển"],
                            datasets: [{
                                data: [
                                    ${ completeCount != null ? completeCount : 0},
                                ${ pendingCount != null ? pendingCount : 0},
                        ${ cancelledCount != null ? cancelledCount : 0}, 
                        ${ shippingCount != null ? shippingCount : 0 }
                    ],
                    backgroundColor: ['#28a745', '#ffc107', '#dc3545', '#17a2b8'],
                }],
            },
        });
                </script>
            </body>

            </html>