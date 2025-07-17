<%-- 
    Document   : PaymentHistory
    Created on : Jul 17, 2025, 1:58:32 PM
    Author     : Ha
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment History</title>

        <!-- Libs -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <link href="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
            
            body {
                font-family: 'Inter', sans-serif;
                background-color: #f8fafc;
            }
            
            .simple-card {
                background: white;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                border: 1px solid #e2e8f0;
            }
            
            .simple-card:hover {
                box-shadow: 0 4px 16px rgba(0, 0, 0, 0.15);
                transition: box-shadow 0.2s ease;
            }
            
            .status-badge {
                display: inline-flex;
                align-items: center;
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 500;
                background-color: #f1f5f9;
                color: #475569;
                border: 1px solid #e2e8f0;
            }
            
            .btn-primary {
                background-color: #3b82f6;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 8px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.2s ease;
            }
            
            .btn-primary:hover {
                background-color: #2563eb;
            }
            
            .btn-secondary {
                background-color: #6b7280;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 8px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.2s ease;
            }
            
            .btn-secondary:hover {
                background-color: #4b5563;
            }
            
            .form-input {
                width: 100%;
                padding: 10px 12px;
                border: 1px solid #d1d5db;
                border-radius: 8px;
                font-size: 14px;
                transition: border-color 0.2s ease;
            }
            
            .form-input:focus {
                outline: none;
                border-color: #3b82f6;
                box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
            }
            
            .table-row {
                border-bottom: 1px solid #f1f5f9;
                transition: background-color 0.2s ease;
            }
            
            .table-row:hover {
                background-color: #f8fafc;
            }
            
            .action-btn {
                width: 32px;
                height: 32px;
                border-radius: 6px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 12px;
                border: none;
                cursor: pointer;
                transition: all 0.2s ease;
                text-decoration: none;
            }
            
            .action-btn:hover {
                transform: translateY(-1px);
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
            }
            
            .action-btn.view {
                background-color: #3b82f6;
                color: white;
            }
            
            .action-btn.cancel {
                background-color: #ef4444;
                color: white;
            }
            
            .action-btn.confirm {
                background-color: #10b981;
                color: white;
            }
            
            .pagination-btn {
                width: 36px;
                height: 36px;
                border-radius: 6px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 14px;
                font-weight: 500;
                border: 1px solid #d1d5db;
                background-color: white;
                color: #374151;
                cursor: pointer;
                transition: all 0.2s ease;
                text-decoration: none;
            }
            
            .pagination-btn:hover {
                background-color: #f3f4f6;
                border-color: #9ca3af;
            }
            
            .pagination-btn.active {
                background-color: #3b82f6;
                color: white;
                border-color: #3b82f6;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <header class="bg-white shadow-md sticky top-0 z-50">
            <div class="max-w-7xl mx-auto px-4 py-3">
                <div class="flex items-center justify-between">
                    <div class="flex items-center gap-4">
                        <!-- Logo -->
                        <div class="flex items-center gap-2">
                            <a href="${pageContext.request.contextPath}/feeds"><img src="${pageContext.request.contextPath}/Asset/FUHF Logo/3.svg" width="30"/></a>
                        </div>

                        <!-- Search -->
                        <div class="relative">
                            <form action="search" method="GET">
                                <input 
                                    type="text" 
                                    placeholder="Search..." 
                                    name="searchKey"
                                    required=""
                                    tabindex="1"
                                    class="search-focus w-80 px-4 py-2 bg-gray-100 rounded-full border-none outline-none"
                                    />
                                <i class="icon-search-focus fas fa-search absolute right-4 top-2.5 text-gray-400"></i>
                            </form>
                        </div>
                    </div>

                    <!-- Right Section -->
                    <div class="flex items-center gap-4">
                        <c:if test="${empty sessionScope.user.id}">
                            <a href="${pageContext.request.contextPath}/login">
                                <button class="bg-orange-500 hover:bg-orange-600 text-white px-6 py-2 rounded-full font-medium transition-colors">
                                    Join Community
                                </button>
                            </a>
                        </c:if>
                        <c:if test="${not empty sessionScope.user.id}">
                            <div class="user-info flex items-center gap-3">
                                <c:if test="${sessionScope.user.role.id == 1}">
                                    <a href="${pageContext.request.contextPath}/manage/user">
                                        <button class="p-1 px-2 bg-orange-500 hover:bg-orange-600 text-white rounded-lg text-sm transition-colors">
                                            Admin Panel
                                        </button>
                                    </a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/logout">
                                    <button class="p-1 px-2 bg-orange-500 hover:bg-orange-600 text-white rounded-lg text-sm transition-colors">
                                        Logout
                                    </button>
                                </a>
                                <div class="name">
                                    <p><b>${sessionScope.user.first_name} ${sessionScope.user.last_name}</b></p>
                                </div>
                                <a href="${pageContext.request.contextPath}/profile?uid=${sessionScope.user.id}">
                                    <div class="avatar w-12 h-12 rounded-full border-white overflow-hidden shadow-lg bg-white">
                                        <img class="w-full h-full object-cover" src="${pageContext.request.contextPath}/Asset/Common/Avatar/${sessionScope.user.avatar}" width="40"/>
                                    </div>
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </header>

        <div class="container mx-auto px-4 py-8 max-w-7xl">
            <!-- Page Title -->
            <div class="mb-8">
                <div class="simple-card p-6 text-center">
                    <h1 class="text-3xl font-bold text-gray-800 mb-2">Payment History</h1>
                    <p class="text-gray-600">Manage and track all your payment records</p>
                </div>
            </div>

            <!-- Filters Section -->
            <div class="simple-card p-6 mb-8">
                <h2 class="text-xl font-semibold text-gray-800 mb-4">
                    <i class="fas fa-filter mr-2"></i>Filters
                </h2>
                <form action="${pageContext.request.contextPath}/payment/history" method="GET" class="space-y-4">
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                        <!-- Search Input -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Search</label>
                            <input type="text" 
                                   name="search" 
                                   value="${param.search}"
                                   placeholder="Search payments..."
                                   class="form-input">
                        </div>

                        <!-- Status Filter -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
                            <select name="status" class="form-input">
                                <option value="">All Status</option>
                                <c:forEach items="${sList}" var="s">
                                    <option value="${s.id}" ${s.id == status ? 'selected' : ''}>${s.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Date Range -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Create Date</label>
                            <input type="date" 
                                   name="createDate" 
                                   value="${param.createDate}"
                                   class="form-input">
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Min Price</label>
                            <input type="number" min="0" max="100000000"
                                   name="minPrice" 
                                   value="${param.minPrice}"
                                   placeholder="0"
                                   class="form-input">
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Max Price</label>
                            <input type="number" min="0" max="100000000"
                                   name="maxPrice" 
                                   value="${param.maxPrice}"
                                   placeholder="100000000"
                                   class="form-input">
                        </div>
                    </div>

                    <!-- Filter Actions -->
                    <div class="flex gap-3 pt-4 border-t border-gray-200">
                        <button type="submit" class="btn-primary">
                            <i class="fas fa-search mr-2"></i>Apply Filters
                        </button>
                        <a href="${pageContext.request.contextPath}/payment/history" class="btn-secondary">
                            <i class="fas fa-times mr-2"></i>Clear Filters
                        </a>
                    </div>
                </form>
            </div>

            <!-- Results Summary -->
            <div class="simple-card p-4 mb-6">
                <div class="flex items-center justify-between">
                    <div class="text-gray-700">
                        Showing <span class="font-semibold">${(currentPage - 1) * pageSize + 1}</span> - <span class="font-semibold">${fn:length(pList) + (currentPage - 1) * pageSize}</span> of <span class="font-semibold">${totalCount}</span> payments
                    </div>
                    <div class="flex items-center gap-2">
                        <label class="text-sm text-gray-700">Show:</label>
                        <select onchange="changePageSize(this.value)" class="form-input w-20">
                            <option value="5" ${pageSize == 5 ? 'selected' : ''}>5</option>
                            <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                            <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
                            <option value="50" ${pageSize == 50 ? 'selected' : ''}>50</option>
                        </select>
                        <span class="text-sm text-gray-700">per page</span>
                    </div>
                </div>
            </div>

            <!-- Payment Table -->
            <div class="simple-card overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="min-w-full">
                        <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Payment ID</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Property</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Amount</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Method</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Created At</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white">
                            <c:forEach items="${pList}" var="p">
                                <tr class="table-row">
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm font-medium text-gray-900">#${p.id}</div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm font-medium text-gray-900">${p.booking.homestay.name}</div>
                                        <div class="text-xs text-gray-500">
                                            <c:choose>
                                                <c:when test="${not empty p.booking.homestay and p.booking.homestay.is_whole_house == true}">
                                                    <i class="fas fa-home mr-1"></i>Homestay
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-bed mr-1"></i>Room
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm font-medium text-gray-900">
                                            <fmt:formatNumber value="${p.amount}" type="currency" currencySymbol="₫" />
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm text-gray-900">${p.method}</div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm text-gray-900">
                                            <fmt:formatDate value="${p.created_at}" pattern="dd/MM/yyyy" />
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="status-badge">
                                            ${p.status.name}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center space-x-2">
                                            <a href="${pageContext.request.contextPath}/payment/detail?payId=${p.id}" 
                                               class="action-btn view" title="View Details">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <c:if test="${p.status.id == 33 || p.status.id == 31 || p.status.id == 35}">
                                                <button onclick="updatePaymentStatus('${p.id}', 39)" 
                                                        class="action-btn cancel" title="Cancel">
                                                    <i class="fas fa-times"></i>
                                                </button>
                                            </c:if>
                                            <form action="${pageContext.request.contextPath}/booking/contract/preview" method="GET" class="inline">
                                                <input type="hidden" name="bookId" value="${p.booking.id}" />
                                                <button type="submit" class="action-btn confirm" title="Confirm">
                                                    <i class="fas fa-check"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Empty State -->
                <c:if test="${empty pList}">
                    <div class="text-center py-12">
                        <div class="text-gray-400 text-6xl mb-4">
                            <i class="fas fa-calendar-times"></i>
                        </div>
                        <h3 class="text-lg font-medium text-gray-900 mb-2">No payments found</h3>
                        <p class="text-gray-500">Try adjusting your search criteria or filters.</p>
                    </div>
                </c:if>
            </div>

            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <div class="simple-card mt-6 p-4">
                    <div class="flex items-center justify-between">
                        <div class="text-sm text-gray-700">
                            Page <span class="font-medium">${currentPage}</span> of <span class="font-medium">${totalPages}</span>
                        </div>
                        <nav class="flex items-center space-x-1">
                            <!-- Previous Page -->
                            <c:if test="${currentPage > 1}">
                                <a href="?${queryString}&page=${currentPage - 1}" class="pagination-btn">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </c:if>

                            <!-- Page Numbers -->
                            <c:set var="startPage" value="${currentPage - 2 > 1 ? currentPage - 2 : 1}" />
                            <c:set var="endPage" value="${startPage + 4 < totalPages ? startPage + 4 : totalPages}" />

                            <c:if test="${startPage > 1}">
                                <a href="?${queryString}&page=1" class="pagination-btn">1</a>
                                <c:if test="${startPage > 2}">
                                    <span class="pagination-btn" style="cursor: default;">...</span>
                                </c:if>
                            </c:if>

                            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <span class="pagination-btn active">${i}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="?${queryString}&page=${i}" class="pagination-btn">${i}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${endPage < totalPages}">
                                <c:if test="${endPage < totalPages - 1}">
                                    <span class="pagination-btn" style="cursor: default;">...</span>
                                </c:if>
                                <a href="?${queryString}&page=${totalPages}" class="pagination-btn">${totalPages}</a>
                            </c:if>

                            <!-- Next Page -->
                            <c:if test="${currentPage < totalPages}">
                                <a href="?${queryString}&page=${currentPage + 1}" class="pagination-btn">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </c:if>
                        </nav>
                    </div>
                </div>
            </c:if>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
            function changePageSize(pageSize) {
                const url = new URL(window.location);
                url.searchParams.set('pageSize', pageSize);
                url.searchParams.set('page', '1');
                window.location.href = url.toString();
            }

            function updatePaymentStatus(payId, statusId) {
                const statusText = {
                    39: 'Force Cancel'
                };

                const statusName = statusText[statusId];

                Swal.fire({
                    title: statusName.charAt(0).toUpperCase() + statusName.slice(1) + ` Booking`,
                    text: `Are you sure you want to ` + statusName + ` this payment (this action can not be undo)?`,
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: statusId === 2 ? '#10b981' : statusId === 3 ? '#ef4444' : '#3b82f6',
                    cancelButtonColor: '#6b7280',
                    confirmButtonText: `Yes, ` + statusName + ` it!`
                }).then((result) => {
                    if (result.isConfirmed) {
                        Swal.fire({
                            title: 'Processing...',
                            text: 'Please wait while we update the payment status.',
                            allowOutsideClick: false,
                            allowEscapeKey: false,
                            showConfirmButton: false,
                            didOpen: () => {
                                Swal.showLoading();
                            }
                        });

                        $.ajax({
                            url: '${pageContext.request.contextPath}/payment/update',
                            type: 'POST',
                            data: {
                                payId: payId,
                                statusId: statusId
                            },
                            success: function (response) {
                                Swal.close();
                                if (response.ok) {
                                    Swal.fire({
                                        title: 'Success!',
                                        text: `Booking has been ` + statusName + `ed successfully.`,
                                        icon: 'success',
                                        confirmButtonColor: '#3b82f6'
                                    }).then(() => {
                                        window.location.reload();
                                    });
                                } else {
                                    Swal.fire({
                                        title: 'Error!',
                                        text: response.message || 'Something went wrong. Please try again.',
                                        icon: 'error',
                                        confirmButtonColor: '#ef4444'
                                    });
                                }
                            },
                            error: function (xhr, status, error) {
                                Swal.close();
                                Swal.fire({
                                    title: 'Error!',
                                    text: 'Network error. Please check your connection and try again.',
                                    icon: 'error',
                                    confirmButtonColor: '#ef4444'
                                });
                                console.error('Error updating booking status:', error);
                            }
                        });
                    }
                });
            }

            function formatDate(dateString) {
                const date = new Date(dateString);
                return date.toLocaleDateString('vi-VN');
            }

            function formatDateTime(dateString) {
                const date = new Date(dateString);
                return date.toLocaleString('vi-VN');
            }

            function formatCurrency(amount) {
                return new Intl.NumberFormat('vi-VN', {
                    style: 'currency',
                    currency: 'VND'
                }).format(amount);
            }
        </script>
    </body>
</html>