<%-- 
    Document   : BookingDetail
    Created on : Jul 3, 2025, 4:40:09 PM
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
                            Booking Detail (Homestay Owner)
                        </h1>
                        <p class="text-gray-600">Manage booking</p>
                    </div>
                </c:if>

                <c:if test="${sessionScope.user.role.id != 1}">
                    <div class="bg-white rounded-xl shadow-lg p-6 mb-8">
                        <!-- Quick Actions Bar -->
                        <div class="flex flex-wrap gap-3 mb-6 p-4 bg-gradient-to-r from-orange-50 to-red-50 rounded-lg border border-orange-200">
                            <c:if test="${booking.status.id == 8}">
                                <button onclick="rejectBooking('${booking.id}')" 
                                        class="flex items-center gap-2 bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition-all duration-200 hover:scale-105">
                                    <i class="fas fa-ban"></i>Cancel This Booking
                                </button>
                            </c:if>
                            <c:if test="${booking.status.id == 9}">
                                <button onclick="generateContract('${booking.id}')" 
                                        class="flex items-center gap-2 bg-primary hover:bg-secondary text-white px-4 py-2 rounded-lg text-sm font-medium transition-all duration-200 hover:scale-105">
                                    <i class="fas fa-file-contract"></i>Download Contract
                                </button>
                            </c:if>
                        </div>
                    </c:if>

                    <!-- Booking Status Card -->
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-8">
                        <div class="bg-gradient-to-br from-blue-500 to-blue-600 text-white p-6 rounded-xl shadow-lg">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-blue-100 text-sm font-medium">Booking ID</p>
                                    <p class="text-2xl font-bold truncate max-w-[310px]">#${booking.id}</p>
                                </div>
                                <i class="fas fa-hashtag text-3xl text-blue-200"></i>
                            </div>
                        </div>

                        <div class="bg-gradient-to-br from-green-500 to-green-600 text-white p-6 rounded-xl shadow-lg">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-green-100 text-sm font-medium">Total Amount</p>
                                    <p class="text-2xl font-bold">₫<fmt:formatNumber value="${booking.total_price}" pattern="#,###" /></p>
                                </div>
                                <i class="fas fa-money-bill-wave text-3xl text-green-200"></i>
                            </div>
                        </div>

                        <div class="bg-gradient-to-br from-purple-500 to-purple-600 text-white p-6 rounded-xl shadow-lg">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-purple-100 text-sm font-medium">Duration</p>
                                    <c:if test="${booking.homestay.is_whole_house == true}">
                                        <p class="text-2xl font-bold">${(booking.total_price - booking.cleaning_fee - booking.service_fee) / booking.homestay.price_per_night} nights</p>
                                    </c:if>
                                    <c:if test="${booking.homestay.is_whole_house == false}">
                                        <p class="text-2xl font-bold">${(booking.total_price - booking.cleaning_fee - booking.service_fee) / booking.room.price_per_night} nights</p>
                                    </c:if>
                                </div>
                                <i class="fas fa-calendar-alt text-3xl text-purple-200"></i>
                            </div>
                        </div>

                        <div class="bg-gradient-to-br from-orange-500 to-red-500 text-white p-6 rounded-xl shadow-lg">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-orange-100 text-sm font-medium">Status</p>
                                    <p class="text-lg font-bold">${booking.status.name}</p>
                                </div>
                                <i class="fas fa-info-circle text-3xl text-orange-200"></i>
                            </div>
                        </div>
                    </div>

                    <!-- Main Content Grid -->
                    <div class="grid grid-cols-1 xl:grid-cols-3 gap-6">
                        <!-- Left Column - Booking & Guest Info -->
                        <div class="xl:col-span-2 space-y-6">
                            <!-- Booking Timeline -->
                            <div class="bg-gradient-to-r from-gray-50 to-gray-100 rounded-xl p-6 border border-gray-200">
                                <h3 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                                    <i class="fas fa-clock text-primary mr-3"></i>
                                    Booking Timeline
                                </h3>
                                <div class="space-y-4">
                                    <div class="flex items-center gap-4">
                                        <div class="w-4 h-4 bg-blue-500 rounded-full"></div>
                                        <div>
                                            <p class="font-medium text-gray-800">Check-in</p>
                                            <p class="text-gray-600"><fmt:formatDate value="${booking.check_in}" pattern="EEEE, dd MMMM yyyy 'at' HH:mm"/></p>
                                        </div>
                                    </div>
                                    <div class="ml-2 w-0.5 h-6 bg-gray-300"></div>
                                    <div class="flex items-center gap-4">
                                        <div class="w-4 h-4 bg-red-500 rounded-full"></div>
                                        <div>
                                            <p class="font-medium text-gray-800">Check-out</p>
                                            <p class="text-gray-600"><fmt:formatDate value="${booking.checkout}" pattern="EEEE, dd MMMM yyyy 'at' HH:mm"/></p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Guest Information -->
                            <div class="bg-gradient-to-r from-blue-50 to-indigo-50 rounded-xl p-6 border border-blue-200">
                                <h3 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                                    <i class="fas fa-users text-blue-600 mr-3"></i>
                                    Guest Information
                                </h3>

                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <!-- Primary Guest -->
                                    <div class="bg-white rounded-lg p-4 shadow-sm">
                                        <div class="flex items-center gap-4 mb-3">
                                            <img src="${pageContext.request.contextPath}/Asset/Common/Avatar/${booking.tenant.avatar}" 
                                                 alt="Guest" class="w-12 h-12 rounded-full object-cover border-2 border-blue-200">
                                            <div>
                                                <h4 class="font-semibold text-gray-800">Primary Guest</h4>
                                                <p class="text-blue-600 text-sm">${booking.tenant.first_name} ${booking.tenant.last_name}</p>
                                            </div>
                                        </div>
                                        <div class="space-y-2 text-sm">
                                            <p class="text-gray-600"><i class="fas fa-envelope mr-2"></i>${booking.tenant.email}</p>
                                            <p class="text-gray-600"><i class="fas fa-phone mr-2"></i>${empty booking.tenant.phone ? 'Not provided' : booking.tenant.phone}</p>
                                            <p class="text-gray-600"><i class="fas fa-user-tag mr-2"></i>User ID: ${booking.tenant.id}</p>
                                        </div>
                                    </div>

                                    <!-- Representative -->
                                    <div class="bg-white rounded-lg p-4 shadow-sm">
                                        <c:choose>
                                            <c:when test="${booking.status.id != 8 and not empty booking.representative.full_name}">
                                                <div class="flex items-center gap-4 mb-3">
                                                    <img src="${pageContext.request.contextPath}/Asset/Common/Avatar/default-avatar.jpg" 
                                                         alt="Representative" class="w-12 h-12 rounded-full object-cover border-2 border-green-200">
                                                    <div>
                                                        <h4 class="font-semibold text-gray-800">Representative</h4>
                                                        <p class="text-green-600 text-sm">${booking.representative.full_name}</p>
                                                    </div>
                                                </div>
                                                <div class="space-y-2 text-sm">
                                                    <p class="text-gray-600"><i class="fas fa-envelope mr-2"></i>${booking.representative.email}</p>
                                                    <p class="text-gray-600"><i class="fas fa-phone mr-2"></i>${booking.representative.phone}</p>
                                                    <p class="text-gray-600"><i class="fas fa-heart mr-2"></i>${booking.representative.relationship}</p>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="text-center py-4">
                                                    <i class="fas fa-user-clock text-gray-400 text-2xl mb-2"></i>
                                                    <p class="text-gray-500">No representative info received</p>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                            <!-- Homestay Details -->
                            <div class="bg-gradient-to-r from-orange-50 to-red-50 rounded-xl p-6 border border-orange-200">
                                <h3 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                                    <i class="fas fa-home text-orange-600 mr-3"></i>
                                    Homestay Details
                                </h3>

                                <div class="bg-white rounded-lg p-6 shadow-sm">
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                        <div class="space-y-3">
                                            <div>
                                                <label class="text-sm font-medium text-orange-600">Property Name</label>
                                                <p class="text-gray-800 font-semibold">${booking.homestay.name}</p>
                                            </div>
                                            <div>
                                                <label class="text-sm font-medium text-orange-600">Property Type</label>
                                                <p class="text-gray-800">
                                                    <c:choose>
                                                        <c:when test="${booking.homestay.is_whole_house}">
                                                            <i class="fas fa-house-user mr-1"></i>Whole House
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fas fa-door-open mr-1"></i>Room Rental
                                                        </c:otherwise>
                                                    </c:choose>
                                                </p>
                                            </div>
                                            <div>
                                                <label class="text-sm font-medium text-orange-600">Location</label>
                                                <p class="text-gray-800 text-sm">
                                                    ${booking.homestay.address.detail}, ${booking.homestay.address.ward}<br>
                                                    ${booking.homestay.address.district}, ${booking.homestay.address.province}
                                                </p>
                                            </div>
                                        </div>

                                        <div class="space-y-3">
                                            <c:if test="${!booking.homestay.is_whole_house}">
                                                <div>
                                                    <label class="text-sm font-medium text-orange-600">Room Details</label>
                                                    <p class="text-gray-800 font-semibold">${booking.room.name}</p>
                                                    <p class="text-gray-600 text-sm">${booking.room.roomType.name} - ${booking.room.room_position}</p>
                                                </div>
                                            </c:if>
                                            <div>
                                                <label class="text-sm font-medium text-orange-600">Nightly Rate</label>
                                                <p class="text-gray-800 font-semibold">
                                                    ₫<fmt:formatNumber value="${booking.homestay.is_whole_house ? booking.homestay.price_per_night : booking.room.price_per_night}" pattern="#,###" />
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Right Column - Financial & Actions -->
                        <div class="space-y-6">
                            <!-- Financial Summary -->
                            <div class="bg-gradient-to-r from-green-50 to-emerald-50 rounded-xl p-6 border border-green-200">
                                <h3 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                                    <i class="fas fa-calculator text-green-600 mr-3"></i>
                                    Financial Summary
                                </h3>

                                <div class="space-y-4">
                                    <div class="bg-white rounded-lg p-4 shadow-sm">
                                        <div class="flex justify-between items-center mb-2">
                                            <span class="text-gray-600">Base Amount</span>
                                            <span class="font-semibold">₫<fmt:formatNumber value="${booking.total_price - booking.service_fee - booking.cleaning_fee}" pattern="#,###" /></span>
                                        </div>
                                        <div class="flex justify-between items-center mb-2">
                                            <span class="text-gray-600">Service Fee</span>
                                            <span class="font-semibold">₫<fmt:formatNumber value="${booking.service_fee}" pattern="#,###" /></span>
                                        </div>
                                        <div class="flex justify-between items-center mb-2">
                                            <span class="text-gray-600">Cleaning Fee</span>
                                            <span class="font-semibold">₫<fmt:formatNumber value="${booking.cleaning_fee}" pattern="#,###" /></span>
                                        </div>
                                        <hr class="my-3">
                                        <div class="flex justify-between items-center">
                                            <span class="font-bold text-gray-800">Total Amount</span>
                                            <span class="font-bold text-green-600 text-lg">₫<fmt:formatNumber value="${booking.total_price}" pattern="#,###" /></span>
                                        </div>
                                        <div class="flex justify-between items-center mt-2">
                                            <span class="text-gray-600">Deposit Required</span>
                                            <span class="font-semibold text-orange-600">₫<fmt:formatNumber value="${booking.deposit}" pattern="#,###" /></span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Special Notes -->
                            <div class="bg-gradient-to-r from-purple-50 to-pink-50 rounded-xl p-6 border border-purple-200">
                                <h3 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                                    <i class="fas fa-sticky-note text-purple-600 mr-3"></i>
                                    Special Notes
                                </h3>

                                <div class="space-y-4">
                                    <div class="bg-white rounded-lg p-4 shadow-sm">
                                        <label class="text-sm font-medium text-purple-600 block mb-2">Guest Requirements</label>
                                        <p class="text-gray-800">${empty booking.note ? 'No special requirements' : booking.note}</p>
                                    </div>

                                    <c:if test="${not empty booking.representative && not empty booking.representative.additional_notes}">
                                        <div class="bg-white rounded-lg p-4 shadow-sm">
                                            <label class="text-sm font-medium text-purple-600 block mb-2">Representative Notes</label>
                                            <p class="text-gray-800">${booking.representative.additional_notes}</p>
                                        </div>
                                    </c:if>
                                </div>
                            </div>

                            <!-- Admin Actions -->
                            <!--                            <div class="bg-gradient-to-r from-red-50 to-orange-50 rounded-xl p-6 border border-red-200">
                                                            <h3 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                                                                <i class="fas fa-tools text-red-600 mr-3"></i>
                                                                Admin Actions
                                                            </h3>
                            
                                                            <div class="space-y-3">
                                                                <button onclick="viewBookingHistory('${booking.id}')" 
                                                                        class="w-full bg-gray-100 hover:bg-gray-200 text-gray-800 px-4 py-2 rounded-lg text-sm font-medium transition-colors">
                                                                    <i class="fas fa-history mr-2"></i>View History
                                                                </button>
                            
                                                                <button onclick="sendNotification('${booking.id}')" 
                                                                        class="w-full bg-blue-100 hover:bg-blue-200 text-blue-800 px-4 py-2 rounded-lg text-sm font-medium transition-colors">
                                                                    <i class="fas fa-bell mr-2"></i>Send Notification
                                                                </button>
                            
                            <c:if test="${sessionScope.user.role.id == 1}">
                                <button onclick="editBooking('${booking.id}')" 
                                        class="w-full bg-yellow-100 hover:bg-yellow-200 text-yellow-800 px-4 py-2 rounded-lg text-sm font-medium transition-colors">
                                    <i class="fas fa-edit mr-2"></i>Edit Booking
                                </button>
                            </c:if>
                        </div>
                    </div>-->
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

                                    function rejectBooking(bookingId) {
                                        Swal.fire({
                                            title: 'Reject Booking',
                                            text: 'Are you sure you want to reject this booking?',
                                            icon: 'warning',
                                            showCancelButton: true,
                                            confirmButtonColor: '#dc2626',
                                            cancelButtonColor: '#6b7280',
                                            confirmButtonText: 'Yes, Reject',
                                            cancelButtonText: 'Cancel'
                                        }).then((result) => {
                                            if (result.isConfirmed) {
                                                // Add your reject booking logic here
                                                console.log('Rejecting booking:', bookingId);
                                                Swal.fire('Rejected!', 'The booking has been rejected.', 'success');
                                            }
                                        });
                                    }

                                    function generateContract(bookingId) {
                                        $.ajax({
                                            url: '${pageContext.request.contextPath}/contract/generate',
                                            type: 'GET',
                                            data: {
                                                bookId: bookingId,
                                                filename: "No"
                                            },
                                            success: function (response) {
                                                const link = document.createElement('a');
                                                link.href = response.path;
                                                link.download = '';
                                                document.body.appendChild(link);
                                                link.click();
                                                document.body.removeChild(link);
                                            }
                                        });
                                    }
        </script>
    </body>
</html>