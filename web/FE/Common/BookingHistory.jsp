<%-- 
    Document   : BookingHistory
    Created on : Jun 30, 2025, 8:08:53 PM
    Author     : Hien
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
        <title>Booking History</title>

        <!-- Libs -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <link href="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            primary: {
                                50: '#eff6ff',
                                100: '#dbeafe',
                                500: '#3b82f6',
                                600: '#2563eb',
                                700: '#1d4ed8'
                            }
                        }
                    }
                }
            }
        </script>
    </head>
    <body class="bg-gray-50">
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

        <div class="container mx-auto px-4 py-8 max-w-6xl">

            <!-- Page Title -->
            <div class="mb-8">
                <h1 class="text-3xl font-bold text-gray-900 mb-2">Booking History</h1>
                <p class="text-gray-600">Manage and track all your booking records</p>
            </div>

            <!-- Filters and Search Section -->
            <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
                <form action="${pageContext.request.contextPath}/booking/history" method="GET" class="space-y-4">
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                        <!--Search Input--> 
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Search</label>
                            <input type="text" 
                                   name="search" 
                                   value="${param.search}"
                                   placeholder="Search by booking ID, tenant name..."
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-transparent">
                        </div>

                        <!--Status Filter--> 
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
                            <select name="status" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-transparent">
                                <option value="">All Status</option>
                                <c:forEach items="${sList}" var="s">
                                    <option value="${s.id}" ${s.id == status ? 'selected' : ''}>${s.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <!--Date Range--> 
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">From Date</label>
                            <input type="date" 
                                   name="fromDate" 
                                   value="${param.fromDate}"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-transparent">
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">To Date</label>
                            <input type="date" 
                                   name="toDate" 
                                   value="${param.toDate}"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-transparent">
                        </div>
                    </div>

                    <!--Filter Actions--> 
                    <div class="flex flex-wrap gap-2 pt-4">
                        <button type="submit" class="bg-primary-600 hover:bg-primary-700 text-white px-6 py-2 rounded-md font-medium transition-colors">
                            <i class="fas fa-search mr-2"></i>Apply Filters
                        </button>
                        <a href="${pageContext.request.contextPath}/booking/history" class="bg-gray-500 hover:bg-gray-600 text-white px-6 py-2 rounded-md font-medium transition-colors">
                            <i class="fas fa-times mr-2"></i>Clear Filters
                        </a>
                    </div>
                </form>
            </div>

            <!-- Results Summary -->
            <div class="bg-white rounded-lg shadow-sm p-4 mb-6">
                <div class="flex flex-wrap items-center justify-between gap-4">
                    <div class="text-sm text-gray-600">
                        Showing ${(currentPage - 1) * pageSize + 1} - ${fn:length(bookings) + (currentPage - 1) * pageSize} of ${totalBookings} bookings
                    </div>
                    <div class="flex items-center gap-2">
                        <label class="text-sm text-gray-600">Show:</label>
                        <select onchange="changePageSize(this.value)" class="px-3 py-1 border border-gray-300 rounded text-sm">
                            <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                            <option value="25" ${pageSize == 25 ? 'selected' : ''}>25</option>
                            <option value="50" ${pageSize == 50 ? 'selected' : ''}>50</option>
                            <option value="100" ${pageSize == 100 ? 'selected' : ''}>100</option>
                        </select>
                        <span class="text-sm text-gray-600">per page</span>
                    </div>
                </div>
            </div>

            <!-- Booking Table -->
            <div class="bg-white rounded-lg shadow-sm overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                            <tr>
                                <!--                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                                    <a href="?${queryString}&sort=id&order=${sortField == 'id' && sortOrder == 'asc' ? 'desc' : 'asc'}" 
                                                                       class="flex items-center hover:text-gray-700">
                                                                        Booking ID
                                                                        <i class="fas fa-sort ml-1 text-gray-400"></i>
                                                                    </a>
                                                                </th>-->
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Tenant
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Property
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Check-in
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Check-out
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Total Price
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Status
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <c:forEach items="${bookings}" var="booking">
                                <tr class="hover:bg-gray-50">
                                    <!--                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                                                            #${booking.id}
                                                                        </td>-->
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 h-8 w-8">
                                                <img class="h-8 w-8 rounded-full object-cover" 
                                                     src="${pageContext.request.contextPath}/Asset/Common/Avatar/${booking.tenant.avatar}" 
                                                     alt="${booking.tenant.first_name}">
                                            </div>
                                            <div class="ml-3">
                                                <div class="text-sm font-medium text-gray-900">
                                                    ${booking.tenant.first_name} ${booking.tenant.last_name}
                                                </div>
                                                <div class="text-sm text-gray-500">
                                                    ${booking.tenant.email}
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm text-gray-900">
                                            <c:choose>
                                                <c:when test="${not empty booking.homestay}">
                                                    ${booking.homestay.name}
                                                </c:when>
                                                <c:otherwise>
                                                    ${booking.room.name}
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="text-sm text-gray-500">
                                            <c:choose>
                                                <c:when test="${not empty booking.homestay}">
                                                    Homestay
                                                </c:when>
                                                <c:otherwise>
                                                    Room
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        <fmt:formatDate value="${booking.check_in}" pattern="dd/MM/yyyy" />
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        <fmt:formatDate value="${booking.checkout}" pattern="dd/MM/yyyy" />
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        <fmt:formatNumber value="${booking.total_price}" type="currency" currencySymbol="₫" />
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <c:choose>
                                            <c:when test="${booking.status.id == 8}">
                                                <span class="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-yellow-100 text-yellow-800">
                                                    ${booking.status.name}
                                                </span>
                                            </c:when>
                                            <c:when test="${booking.status.id == 9}">
                                                <span class="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800">
                                                    ${booking.status.name}
                                                </span>
                                            </c:when>
                                            <c:when test="${booking.status.id == 10}">
                                                <span class="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-red-100 text-red-800">
                                                    ${booking.status.name}
                                                </span>
                                            </c:when>
                                            <c:when test="${booking.status.id == 11}">
                                                <span class="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-blue-100 text-blue-800">
                                                    ${booking.status.name}
                                                </span>
                                            </c:when>
                                            <c:when test="${booking.status.id == 12}">
                                                <span class="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-blue-100 text-green-800">
                                                    ${booking.status.name}
                                                </span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <div class="flex items-center space-x-2">
                                            <a href="${pageContext.request.contextPath}/booking/detail?bookId=${booking.id}" 
                                               class="text-indigo-600 hover:text-indigo-900" title="View Details">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <c:if test="${booking.status.id == 8}">
                                                <button onclick="updateBookingStatus('${booking.id}', 10)" 
                                                        class="text-red-600 hover:text-red-900" title="Cancel">
                                                    <i class="fas fa-times"></i>
                                                </button>
                                                <a href="${pageContext.request.contextPath}/booking/contract?bookId=${booking.id}">
                                                    <button class="text-green-600 hover:text-green-900" title="Confirm">
                                                        <i class="fas fa-check"></i>
                                                    </button>
                                                </a>
                                            </c:if>
                                            <c:if test="${booking.status.id == 11 || booking.status.id == 12}">
                                                <form action="${pageContext.request.contextPath}/booking/contract/preview" method="GET">
                                                    <input type="hidden" name="bookId" value="${booking.id}" />
                                                    <button type="submit" class="text-green-600 hover:text-green-900 transition" title="Confirm">
                                                        <i class="fas fa-check"></i>
                                                    </button>
                                                </form>
                                                <form action="${pageContext.request.contextPath}/review/add" method="GET">
                                                    <input type="hidden" name="bookId" value="${booking.id}" />
                                                    <button type="submit" class="text-green-600 hover:text-green-900 transition" title="Confirm">
                                                        <!--<i class="fa-solid fa-star"></i>-->
                                                        <i class="fa-regular fa-star text-yellow-600 hover:text-yellow-900 transition"></i>
                                                    </button>
                                                </form>
                                            </c:if>
                                            <c:if test="${booking.status.id == 9}">
                                                <form action="${pageContext.request.contextPath}/booking/contract/preview" method="GET">
                                                    <input type="hidden" name="bookId" value="${booking.id}" />
                                                    <button type="submit" class="text-green-600 hover:text-green-900" title="Confirm">
                                                        <i class="fas fa-check"></i>
                                                    </button>
                                                </form>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Empty State -->
                <c:if test="${empty bookings}">
                    <div class="text-center py-12">
                        <i class="fas fa-calendar-times text-gray-300 text-6xl mb-4"></i>
                        <h3 class="text-lg font-medium text-gray-900 mb-2">No bookings found</h3>
                        <p class="text-gray-500">Try adjusting your search criteria or filters.</p>
                    </div>
                </c:if>
            </div>

            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <div class="bg-white rounded-lg shadow-sm mt-6 p-4">
                    <div class="flex items-center justify-between">
                        <div class="text-sm text-gray-700">
                            Page ${currentPage} of ${totalPages}
                        </div>
                        <nav class="flex items-center space-x-1">
                            <!-- Previous Page -->
                            <c:if test="${currentPage > 1}">
                                <a href="?${queryString}&page=${currentPage - 1}" 
                                   class="px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md hover:bg-gray-50 hover:text-gray-700">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </c:if>

                            <!-- Page Numbers -->
                            <c:set var="startPage" value="${currentPage - 2 > 1 ? currentPage - 2 : 1}" />
                            <c:set var="endPage" value="${startPage + 4 < totalPages ? startPage + 4 : totalPages}" />

                            <c:if test="${startPage > 1}">
                                <a href="?${queryString}&page=1" 
                                   class="px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md hover:bg-gray-50 hover:text-gray-700">
                                    1
                                </a>
                                <c:if test="${startPage > 2}">
                                    <span class="px-3 py-2 text-sm font-medium text-gray-500">...</span>
                                </c:if>
                            </c:if>

                            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <span class="px-3 py-2 text-sm font-medium text-white bg-primary-600 border border-primary-600 rounded-md">
                                            ${i}
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="?${queryString}&page=${i}" 
                                           class="px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md hover:bg-gray-50 hover:text-gray-700">
                                            ${i}
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${endPage < totalPages}">
                                <c:if test="${endPage < totalPages - 1}">
                                    <span class="px-3 py-2 text-sm font-medium text-gray-500">...</span>
                                </c:if>
                                <a href="?${queryString}&page=${totalPages}" 
                                   class="px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md hover:bg-gray-50 hover:text-gray-700">
                                    ${totalPages}
                                </a>
                            </c:if>

                            <!-- Next Page -->
                            <c:if test="${currentPage < totalPages}">
                                <a href="?${queryString}&page=${currentPage + 1}" 
                                   class="px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md hover:bg-gray-50 hover:text-gray-700">
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
                                                        url.searchParams.set('page', '1'); // Reset to first page
                                                        window.location.href = url.toString();
                                                    }

                                                    function updateBookingStatus(bookingId, statusId) {
                                                        const statusText = {
                                                            10: 'Cancel'
                                                        };

                                                        const statusName = statusText[statusId];

                                                        Swal.fire({
                                                            title: statusName.charAt(0).toUpperCase() + statusName.slice(1) + ` Booking`,
                                                            text: `Are you sure you want to ` + statusName + ` this booking?`,
                                                            icon: 'warning',
                                                            showCancelButton: true,
                                                            confirmButtonColor: statusId === 2 ? '#10b981' : statusId === 3 ? '#ef4444' : '#3b82f6',
                                                            cancelButtonColor: '#6b7280',
                                                            confirmButtonText: `Yes, ` + statusName + ` it!`
                                                        }).then((result) => {
                                                            if (result.isConfirmed) {
                                                                // Show loading
                                                                Swal.fire({
                                                                    title: 'Processing...',
                                                                    text: 'Please wait while we update the booking status.',
                                                                    allowOutsideClick: false,
                                                                    allowEscapeKey: false,
                                                                    showConfirmButton: false,
                                                                    didOpen: () => {
                                                                        Swal.showLoading();
                                                                    }
                                                                });

                                                                $.ajax({
                                                                    url: 'update-booking-status',
                                                                    type: 'POST',
                                                                    data: {
                                                                        bookingId: bookingId,
                                                                        statusId: statusId
                                                                    },
                                                                    success: function (response) {
                                                                        Swal.close();
                                                                        if (response.success) {
                                                                            Swal.fire({
                                                                                title: 'Success!',
                                                                                text: `Booking has been ${statusName}ed successfully.`,
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