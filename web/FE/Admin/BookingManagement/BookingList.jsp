<%-- 
    Document   : BookingList
    Created on : Jul 3, 2025, 2:32:29 PM
    Author     : nongducdai
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
        <title>Booking List</title>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            primary: '#FF6B35',
                            secondary: '#FF8E53',
                        }
                    }
                }
            }
        </script>
    </head>
    <body class="bg-gradient-to-br from-orange-200 to-white-50 min-h-screen">
        <!-- Header -->
        <header class="bg-white shadow-md sticky top-0 z-50">
            <div class="max-w-7xl mx-auto px-4 py-3">
                <div class="flex items-center justify-between">
                    <div class="flex items-center gap-4">
                        <!-- Logo -->
                        <div class="flex items-center gap-2">
                            <a href="${pageContext.request.contextPath}/feeds"><img src="${pageContext.request.contextPath}/Asset/FUHF Logo/3.svg" width="30"/></a>
                        </div>

                        <!-- Logo -->
                        <div class="flex items-center gap-2">
                            <p class="font-bold text-orange-500 text-xl">FUHF Admin</p>
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
                                <a href="${pageContext.request.contextPath}/feeds">
                                    <button class="p-1 px-2 bg-orange-500 hover:bg-orange-600 text-white rounded-lg text-sm transition-colors">
                                        Back to feeds
                                    </button>
                                </a>
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

        <!-- Container for Sidebar and Main Content -->
        <div class="flex">
            <!-- Admin Sidebar -->
            <aside class="bg-white shadow-lg w-64 min-h-screen sticky top-20 z-40">
                <nav class="p-6">
                    <c:if test="${sessionScope.user.role.id == 1}">
                        <h2 class="text-lg font-semibold text-gray-800 mb-6">Admin Panel</h2>
                    </c:if>
                    <c:if test="${sessionScope.user.role.id == 3}">
                        <h2 class="text-lg font-semibold text-gray-800 mb-6">Homestay Owner Panel</h2>
                    </c:if>

                    <c:if test="${sessionScope.user.role.id == 1}">
                        <div class="mb-6">
                            <h3 class="text-sm font-semibold text-gray-500 uppercase tracking-wider mb-3">User Management</h3>
                            <div class="space-y-2">
                                <a href="${pageContext.request.contextPath}/manage/user" 
                                   class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
                                    <i class="fas fa-users w-5"></i>
                                    <span>All Users</span>
                                </a>
<!--                                <a href="${pageContext.request.contextPath}/manage/user/permissions" 
                                   class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
                                    <i class="fas fa-shield-alt w-5"></i>
                                    <span>Permissions</span>
                                </a>-->
                            </div>
                        </div>
                    </c:if>

                    <!-- Homestay Management -->
                    <!--                    <div class="mb-6">
                                            <h3 class="text-sm font-semibold text-gray-500 uppercase tracking-wider mb-3">Homestay Management</h3>
                                            <div class="space-y-2">
                                                <a href="${pageContext.request.contextPath}/manage/homestay" 
                                                   class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
                                                    <i class="fas fa-home w-5"></i>
                                                    <span>All Homestays</span>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/manage/homestay/pending" 
                                                   class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
                                                    <i class="fas fa-clock w-5"></i>
                                                    <span>Pending Approval</span>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/manage/homestay/categories" 
                                                   class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
                                                    <i class="fas fa-tags w-5"></i>
                                                    <span>Categories</span>
                                                </a>
                                            </div>
                                        </div>-->

                    <!-- Booking Management -->
                    <div class="mb-6">
                        <h3 class="text-sm font-semibold text-gray-500 uppercase tracking-wider mb-3">Booking Management</h3>
                        <div class="space-y-2">
                            <a href="${pageContext.request.contextPath}/manage/booking" 
                               class="flex items-center gap-3 p-3 rounded-lg bg-orange-50 text-primary font-medium">
                                <i class="fas fa-calendar-check w-5"></i>
                                <span>All Bookings</span>
                            </a>
<!--                            <a href="${pageContext.request.contextPath}/manage/booking/disputes" 
                               class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
                                <i class="fas fa-exclamation-triangle w-5"></i>
                                <span>Disputes</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/manage/booking/refunds" 
                               class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
                                <i class="fas fa-undo w-5"></i>
                                <span>Refunds</span>
                            </a>-->
                        </div>
                    </div>

                    <!-- Financial Management -->
                    <!--                    <div class="mb-6">
                                            <h3 class="text-sm font-semibold text-gray-500 uppercase tracking-wider mb-3">Financial</h3>
                                            <div class="space-y-2">
                                                <a href="${pageContext.request.contextPath}/manage/payments" 
                                                   class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
                                                    <i class="fas fa-credit-card w-5"></i>
                                                    <span>Payments</span>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/manage/commissions" 
                                                   class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
                                                    <i class="fas fa-percentage w-5"></i>
                                                    <span>Commissions</span>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/manage/reports" 
                                                   class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
                                                    <i class="fas fa-chart-bar w-5"></i>
                                                    <span>Financial Reports</span>
                                                </a>
                                            </div>
                                        </div>-->

                    <!-- Content Management -->
                    <c:if test="${sessionScope.user.role.id == 1 || sessionScope.user.role.id == 4}">
                        <div class="mb-6">
                            <h3 class="text-sm font-semibold text-gray-500 uppercase tracking-wider mb-3">Content</h3>
                            <div class="space-y-2">
                                <a href="${pageContext.request.contextPath}/manage/post" 
                                   class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
                                    <i class="fas fa-pen-to-square w-5"></i>
                                    <span>All Posts</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/manage/reviews" 
                                   class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
                                    <i class="fas fa-star w-5"></i>
                                    <span>All Reviews</span>
                                </a>
                            </div>
                        </div>


                        <!-- System Settings -->
                        <div class="mb-6">
                            <h3 class="text-sm font-semibold text-gray-500 uppercase tracking-wider mb-3">System</h3>
                            <div class="space-y-2">
                                <a href="${pageContext.request.contextPath}/manage/authorization" 
                                   class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200   ">
                                    <i class="fas fa-cog w-5"></i>
                                    <span>Authorizations</span>
                                </a>
    <!--                            <a href="${pageContext.request.contextPath}/manage/logs" 
                                   class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
                                    <i class="fas fa-file-alt w-5"></i>
                                    <span>System Logs</span>
                                </a>-->
                            </div>
                        </div>
                    </c:if>
                </nav>
            </aside>

            <!-- Main Content -->
            <main class="flex-1 px-4 sm:px-6 lg:px-8 py-8">
                <!-- Dashboard Header -->
                <c:if test="${sessionScope.user.role.id == 1}">
                    <div class="bg-white rounded-2xl shadow-xl p-8 mb-8">
                        <h1 class="text-4xl font-bold bg-gradient-to-r from-primary to-secondary bg-clip-text text-transparent mb-2">
                            Booking Management (Admin)
                        </h1>
                        <p class="text-gray-600">Manage and monitor all bookings in FUHF homestay booking system</p>
                    </div>
                </c:if>
                <c:if test="${sessionScope.user.role.id == 3}">
                    <div class="bg-white rounded-2xl shadow-xl p-8 mb-8">
                        <h1 class="text-4xl font-bold bg-gradient-to-r from-primary to-secondary bg-clip-text text-transparent mb-2">
                            Booking Management (Homestay Owner)
                        </h1>
                        <p class="text-gray-600">Manage and monitor your bookings in FUHF homestay booking system</p>
                    </div>
                </c:if>

                <!-- Filters and Actions -->
                <div class="bg-white rounded-xl shadow-lg p-6 mb-8">
                    <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between space-y-4 lg:space-y-0">
                        <!-- Filters -->
                        <form action="${pageContext.request.contextPath}/manage/booking" method="GET">
                            <div class="flex items-center space-x-4">
                                <!-- Search Input -->
                                <input name="keyword" value="${keyword}" type="text" 
                                       class="border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-primary" 
                                       placeholder="Search ...">

                                <!-- Status Select -->
                                <select name="statusId" 
                                        class="border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-primary">
                                    <option value="">All Status</option>
                                    <c:forEach items="${sList}" var="s">
                                        <option value="${s.id}" ${s.id == statusId ? 'selected' : ''}>${s.name}</option>
                                    </c:forEach>
                                </select>

                                <!-- Date Input -->
                                <input name="date" type="date" value="${date}"
                                       class="border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-primary">

                                <!-- Action Buttons -->
                                <button type="submit" 
                                        class="bg-gradient-to-r from-primary to-secondary text-white px-6 py-2 rounded-lg font-semibold hover:shadow-lg transition-all duration-300">
                                    Filter
                                </button>
                                <button type="button" onclick="location.href = '${pageContext.request.contextPath}/manage/booking'"
                                        class="bg-gray-100 text-gray-700 px-6 py-2 rounded-lg font-semibold hover:bg-gray-200 transition-colors duration-300">
                                    Clear Filter
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Users Table -->
                <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">

                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Booking ID</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tenant</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Homestay</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Room</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Checkin</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Checkout</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <c:forEach var="booking" items="${bookingList}">
                                    <tr class="hover:bg-gray-50 transition-colors duration-200">
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <input type="checkbox" class="rounded border-gray-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="text-sm font-medium text-gray-900"><p class="truncate">${booking.id}</p></div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="text-sm font-medium text-gray-900">${booking.tenant.first_name} ${booking.tenant.last_name}</div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="text-sm font-medium text-gray-900">${booking.homestay.name}</div>   
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <c:if test="${booking.homestay.is_whole_house == true}">
                                                <div class="text-sm font-medium text-gray-900">Wholehouse Type</div>
                                            </c:if>
                                            <c:if test="${booking.homestay.is_whole_house == false}">
                                                <div class="text-sm font-medium text-gray-900">${booking.room.name}</div>
                                            </c:if>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <fmt:formatDate value="${booking.check_in}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <fmt:formatDate value="${booking.checkout}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <c:choose>
                                                <c:when test="${booking.status.id == 8}">
                                                    <span class="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-orange-100 text-orange-800">${booking.status.name}</span>
                                                </c:when>
                                                <c:when test="${booking.status.id == 9}">
                                                    <span class="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-yellow-100 text-yellow-800">${booking.status.name}</span>
                                                </c:when>
                                                <c:when test="${booking.status.id == 10}">
                                                    <span class="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-red-100 text-red-800">${booking.status.name}</span>
                                                </c:when>
                                                <c:when test="${booking.status.id == 11}">
                                                    <span class="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800">${booking.status.name}</span>
                                                </c:when>
                                                <c:when test="${booking.status.id == 12}">
                                                    <span class="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-blue-100 text-blue-800">${booking.status.name}</span>
                                                </c:when>
                                                <c:when test="${booking.status.id == 34}">
                                                    <span class="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800">${booking.status.name}</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium space-x-2">
                                            <a href="${pageContext.request.contextPath}/manage/booking/detail?bookId=${booking.id}" class="text-blue-500 hover:text-blue-900 transition-colors duration-200">View</a>
                                            <c:choose>
                                                <c:when test="${(booking.status.id == 8 || booking.status.id == 9) and session.user.role.id == 3}">
                                                    <a href="#" class="text-red-600 hover:text-red-900 transition-colors duration-200">Cancel</a>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <div class="bg-white px-4 py-3 flex items-center justify-between border-t border-gray-200 sm:px-6">
                        <div class="flex-1 flex justify-between sm:hidden">
                            <c:if test="${currentPage > 1}">
                                <a href="?page=${currentPage - 1}&keyword=${keyword}&statusId=${statusId}&roleId=${roleId}&joinDate=<fmt:formatDate value='${joinDate}' pattern='yyyy-MM-dd'/>" class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">Previous</a>
                            </c:if>
                            <c:if test="${currentPage < totalPages}">
                                <a href="?page=${currentPage + 1}&keyword=${keyword}&statusId=${statusId}&roleId=${roleId}&joinDate=<fmt:formatDate value='${joinDate}' pattern='yyyy-MM-dd'/>" class="ml-3 inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">Next</a>
                            </c:if>
                        </div>
                        <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                            <div>
                                <p class="text-sm text-gray-700">
                                    Showing <span class="font-medium">${(currentPage - 1) * 7 + 1}</span>
                                    to <span class="font-medium">${(currentPage * 7 > totalCount) ? totalCount : (currentPage * 7)}</span>
                                    of <span class="font-medium">${totalCount}</span> results
                                </p>
                            </div>
                            <div>
                                <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px">
                                    <c:if test="${currentPage > 1}">
                                        <a href="?page=${currentPage - 1}&keyword=${keyword}&statusId=${statusId}&roleId=${roleId}&joinDate=<fmt:formatDate value='${joinDate}' pattern='yyyy-MM-dd'/>" class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">Previous</a>
                                    </c:if>

                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <a href="?page=${i}&keyword=${keyword}&statusId=${statusId}&roleId=${roleId}&joinDate=<fmt:formatDate value='${joinDate}' pattern='yyyy-MM-dd'/>"
                                           class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium ${i == currentPage ? 'bg-primary text-white' : 'bg-white text-gray-700 hover:bg-gray-50'}">
                                            ${i}
                                        </a>
                                    </c:forEach>

                                    <c:if test="${currentPage < totalPages}">
                                        <a href="?page=${currentPage + 1}&keyword=${keyword}&statusId=${statusId}&roleId=${roleId}&joinDate=<fmt:formatDate value='${joinDate}' pattern='yyyy-MM-dd'/>" class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">Next</a>
                                    </c:if>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
                                    // Simple interactivity for demo purposes
                                    document.addEventListener('DOMContentLoaded', function () {
                                        // Handle checkbox selections
                                        const checkboxes = document.querySelectorAll('input[type="checkbox"]');
                                        checkboxes.forEach(checkbox => {
                                            checkbox.addEventListener('change', function () {
                                                if (this.checked) {
                                                    this.closest('tr')?.classList.add('bg-blue-50');
                                                } else {
                                                    this.closest('tr')?.classList.remove('bg-blue-50');
                                                }
                                            });
                                        });

                                        // Handle action buttons
                                        const actionButtons = document.querySelectorAll('button');
                                        actionButtons.forEach(button => {
                                            button.addEventListener('click', function (e) {
                                                if (this.textContent.includes('Ban') || this.textContent.includes('Unban')) {
                                                    e.preventDefault();
                                                    const action = this.textContent.trim();
                                                    const userName = this.closest('tr').querySelector('.text-sm.font-medium.text-gray-900').textContent;
                                                    alert(`${action} action for ${userName} - This would normally show a confirmation dialog.`);
                                                }
                                            });
                                        });
                                    });
        </script>
    </body>
</html>