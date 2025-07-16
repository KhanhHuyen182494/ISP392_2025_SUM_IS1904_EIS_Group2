<%-- 
    Document   : ReviewDetails
    Created on : Jul 15, 2025, 9:55:20 PM
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
        <title>Review Detail</title>

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
                    <h2 class="text-lg font-semibold text-gray-800 mb-6">Admin Panel</h2>

                    <!-- Dashboard -->
                    <!--                    <div class="mb-6">
                                            <a href="${pageContext.request.contextPath}/admin/dashboard" 
                                               class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
                                                <i class="fas fa-tachometer-alt w-5"></i>
                                                <span class="font-medium">Dashboard</span>
                                            </a>
                                        </div>-->

                    <!-- User Management -->
                    <div class="mb-6">
                        <h3 class="text-sm font-semibold text-gray-500 uppercase tracking-wider mb-3">User Management</h3>
                        <div class="space-y-2">
                            <a href="${pageContext.request.contextPath}/manage/user" 
                               class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
                                <i class="fas fa-users w-5"></i>
                                <span>All Users</span>
                            </a>
<!--                            <a href="${pageContext.request.contextPath}/manage/user/permissions" 
                               class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
                                <i class="fas fa-shield-alt w-5"></i>
                                <span>Permissions</span>
                            </a>-->
                        </div>
                    </div>

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
                               class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
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
                    <div class="mb-6">
                        <h3 class="text-sm font-semibold text-gray-500 uppercase tracking-wider mb-3">Content</h3>
                        <div class="space-y-2">
                            <a href="${pageContext.request.contextPath}/manage/post" 
                               class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
                                <i class="fas fa-pen-to-square w-5"></i>
                                <span>All Posts</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/manage/reviews" 
                               class="flex items-center gap-3 p-3 rounded-lg bg-orange-50 text-primary font-medium">
                                <i class="fas fa-star w-5"></i>
                                <span>All Reviews</span>
                            </a>
                        </div>
                    </div>

                    <!-- System Settings -->
                    <!--                    <div class="mb-6">
                                            <h3 class="text-sm font-semibold text-gray-500 uppercase tracking-wider mb-3">System</h3>
                                            <div class="space-y-2">
                                                <a href="${pageContext.request.contextPath}/manage/settings" 
                                                   class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
                                                    <i class="fas fa-cog w-5"></i>
                                                    <span>Settings</span>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/manage/logs" 
                                                   class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
                                                    <i class="fas fa-file-alt w-5"></i>
                                                    <span>System Logs</span>
                                                </a>
                                            </div>
                                        </div>-->
                </nav>
            </aside>

            <!-- Main Content -->
            <main class="flex-1 px-4 sm:px-6 lg:px-8 py-8">

                <!-- Review Detail Header -->
                <div class="bg-white rounded-lg shadow-sm border border-gray-200 mb-6">
                    <div class="px-6 py-4 border-b border-gray-200">
                        <div class="flex items-center justify-between">
                            <h1 class="text-2xl font-bold text-gray-900">Review Detail</h1>
                            <div class="flex items-center gap-3">
                                <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium ${review.status.name == 'Public' ? 'bg-green-100 text-green-800' : review.status.name == 'Hidden' ? 'bg-red-100 text-yellow-800' : 'bg-red-100 text-red-800'}">
                                    ${review.status.name}
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Main Review Content -->
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                    <!-- Review Details -->
                    <div class="lg:col-span-2">
                        <div class="bg-white rounded-lg shadow-sm border border-gray-200">
                            <div class="p-6">
                                <h2 class="text-lg font-semibold text-gray-900 mb-4">Review Information</h2>

                                <!-- Review Content -->
                                <div class="mb-6">
                                    <div class="flex items-center mb-3">
                                        <div class="flex items-center">
                                            <c:forEach begin="1" end="5" var="i">
                                                <i class="fas fa-star ${i <= review.star ? 'text-yellow-400' : 'text-gray-300'} text-lg"></i>
                                            </c:forEach>
                                            <span class="ml-2 text-lg font-medium text-gray-900">${review.star}/5</span>
                                        </div>
                                    </div>

                                    <div class="bg-gray-50 rounded-lg p-4">
                                        <p class="text-gray-800 leading-relaxed">${review.content}</p>
                                    </div>
                                </div>

                                <!-- Review Meta -->
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Review ID</label>
                                        <p class="text-sm text-gray-900 font-mono">${review.id}</p>
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Status</label>
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${review.status.name == 'Public' ? 'bg-green-100 text-green-800' : review.status.name == 'Hidden' ? 'bg-red-100 text-yellow-800' : 'bg-red-100 text-red-800'}">
                                            ${review.status.name}
                                        </span>
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Created At</label>
                                        <p class="text-sm text-gray-900">
                                            <fmt:formatDate value="${review.created_at}" pattern="MMM dd, yyyy 'at' HH:mm" />
                                        </p>
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Last Updated</label>
                                        <c:if test="${not empty review.updated_at}">
                                            <p class="text-sm text-gray-900">
                                                <fmt:formatDate value="${review.updated_at}" pattern="MMM dd, yyyy 'at' HH:mm" />
                                            </p>
                                        </c:if>
                                        <c:if test="${empty review.updated_at}">
                                            <p class="text-sm text-gray-900">
                                                Not Yet
                                            </p>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Sidebar Information -->
                    <div class="space-y-6">
                        <!-- Reviewer Information -->
                        <div class="bg-white rounded-lg shadow-sm border border-gray-200">
                            <div class="p-6">
                                <h3 class="text-lg font-semibold text-gray-900 mb-4">Reviewer</h3>
                                <div class="flex items-center mb-4">
                                    <div class="w-12 h-12 rounded-full overflow-hidden bg-gray-200">
                                        <img class="w-full h-full object-cover" src="${pageContext.request.contextPath}/Asset/Common/Avatar/${review.owner.avatar}" alt="${review.owner.first_name}" />
                                    </div>
                                    <div class="ml-4">
                                        <p class="font-medium text-gray-900">${review.owner.first_name} ${review.owner.last_name}</p>
                                        <p class="text-sm text-gray-500">${review.owner.email}</p>
                                    </div>
                                </div>
                                <div class="space-y-2">
                                    <div class="flex justify-between">
                                        <span class="text-sm text-gray-600">User ID:</span>
                                        <span class="text-sm text-gray-900 font-mono">${review.owner.id}</span>
                                    </div>
                                    <div class="flex justify-between">
                                        <span class="text-sm text-gray-600">Phone:</span>
                                        <c:if test="${not empty review.owner.phone}">
                                            <span class="text-sm text-gray-900">${review.owner.phone}</span>
                                        </c:if>
                                        <c:if test="${empty review.owner.phone}">
                                            <span class="text-sm text-gray-900">None</span>
                                        </c:if>
                                    </div>
                                    <div class="flex justify-between">
                                        <span class="text-sm text-gray-600">Status:</span>
                                        <span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium ${review.owner.status.name == 'Active' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                            ${review.owner.status.name}
                                        </span>
                                    </div>
                                </div>
                                <div class="mt-4">
                                    <a href="${pageContext.request.contextPath}/manage/user?id=${review.owner.id}" class="text-orange-600 hover:text-orange-700 text-sm font-medium">
                                        <i class="fas fa-external-link-alt mr-1"></i>View Profile
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- Homestay Information -->
                        <div class="bg-white rounded-lg shadow-sm border border-gray-200">
                            <div class="p-6">
                                <h3 class="text-lg font-semibold text-gray-900 mb-4">Homestay</h3>
                                <div class="mb-4">
                                    <c:if test="${not empty review.homestay.medias}">
                                        <img class="w-full h-32 object-cover rounded-lg" src="${pageContext.request.contextPath}/Asset/Common/House/${review.homestay.medias[0].path}" alt="${review.homestay.name}" />
                                    </c:if>
                                    <c:if test="${empty review.homestay.medias}">
                                        <div class="w-full h-32 bg-gray-200 rounded-lg flex items-center justify-center">
                                            <i class="fas fa-home text-gray-400 text-2xl"></i>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="space-y-2">
                                    <h4 class="font-medium text-gray-900">${review.homestay.name}</h4>
                                    <p class="text-sm text-gray-600"> ${review.homestay.address.detail} ${review.homestay.address.ward}, ${review.homestay.address.district}, ${review.homestay.address.province}, ${review.homestay.address.country}</p>
                                    <div class="flex justify-between">
                                        <span class="text-sm text-gray-600">Homestay ID:</span>
                                        <span class="text-sm text-gray-900 font-mono">${review.homestay.id}</span>
                                    </div>
                                    <div class="flex justify-between">
                                        <span class="text-sm text-gray-600">Owner:</span>
                                        <span class="text-sm text-gray-900">${review.homestay.owner.first_name} ${review.homestay.owner.last_name}</span>
                                    </div>
                                </div>
                                <div class="mt-4">
                                    <a href="${pageContext.request.contextPath}/owner-house/detail?hid=${review.homestay.id}" class="text-orange-600 hover:text-orange-700 text-sm font-medium">
                                        <i class="fas fa-external-link-alt mr-1"></i>View Homestay
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- Room Information -->
                        <c:if test="${not empty review.room}">
                            <div class="bg-white rounded-lg shadow-sm border border-gray-200">
                                <div class="p-6">
                                    <h3 class="text-lg font-semibold text-gray-900 mb-4">Room</h3>
                                    <div class="space-y-2">
                                        <h4 class="font-medium text-gray-900">${review.room.name}</h4>
                                        <div class="flex justify-between">
                                            <span class="text-sm text-gray-600">Room ID:</span>
                                            <span class="text-sm text-gray-900 font-mono">${review.room.id}</span>
                                        </div>
                                        <div class="flex justify-between">
                                            <span class="text-sm text-gray-600">Price:</span>
                                            <span class="text-sm text-gray-900">
                                                <fmt:formatNumber value="${review.room.price}" type="currency" currencyCode="VND" />
                                            </span>
                                        </div>
                                        <div class="flex justify-between">
                                            <span class="text-sm text-gray-600">Capacity:</span>
                                            <span class="text-sm text-gray-900">${review.room.capacity} guests</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <!-- Action Buttons -->
                        <div class="bg-white rounded-lg shadow-sm border border-gray-200">
                            <div class="p-6">
                                <h3 class="text-lg font-semibold text-gray-900 mb-4">Actions</h3>
                                <div class="space-y-3">
                                    <c:if test="${review.status.name == 'Public'}">
                                        <button onclick="updateReview('${review.id}', 'hide')" class="w-full bg-yellow-500 hover:bg-yellow-600 text-white px-4 py-2 rounded-lg transition-colors">
                                            <i class="fas fa-eye-slash mr-2"></i>Hide Review
                                        </button>
                                    </c:if>
                                    <c:if test="${review.status.name == 'Hidden'}">
                                        <button onclick="updateReview('${review.id}', 'show')" class="w-full bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-lg transition-colors">
                                            <i class="fas fa-eye mr-2"></i>Show Review
                                        </button>
                                    </c:if>
                                </div>
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
                                            function updateReview(rid, type) {
                                                if (type == 'hide') {
                                                    Swal.fire({
                                                        title: 'Are you sure wanted to hide this review?',
                                                        imageUrl: `${pageContext.request.contextPath}/Asset/FUHF Logo/3.svg`,
                                                        imageWidth: 150,
                                                        imageHeight: 150,
                                                        imageAlt: 'Custom icon',
                                                        showCancelButton: true,
                                                        confirmButtonText: 'Hide it',
                                                        cancelButtonText: 'Cancel',
                                                        reverseButtons: false,
                                                        focusConfirm: false,
                                                        focusCancel: false,
                                                        customClass: {
                                                            popup: 'rounded-xl shadow-lg',
                                                            title: 'text-xl font-semibold',
                                                            confirmButton: 'bg-[#FF7700] text-white px-4 py-2 rounded',
                                                            cancelButton: 'bg-gray-300 text-black px-4 py-2 rounded',
                                                            actions: 'space-x-4'
                                                        },
                                                        buttonsStyling: false
                                                    }).then((result) => {
                                                        if (result.isConfirmed) {
                                                            $.ajax({
                                                                url: '${pageContext.request.contextPath}/manage/reviews/update',
                                                                type: 'POST',
                                                                beforeSend: function (xhr) {
                                                                    Swal.showLoading();
                                                                },
                                                                data: {
                                                                    typeUpdate: 'status',
                                                                    rid: rid,
                                                                    status: 24
                                                                },
                                                                success: function (response) {
                                                                    if (response.ok) {
                                                                        showToast(response.message);
                                                                        setTimeout(function () {
                                                                            location.reload();
                                                                        }, 2000);
                                                                    } else {
                                                                        showToast(response.message, 'error');
                                                                    }
                                                                },
                                                                complete: function (jqXHR, textStatus) {
                                                                    Swal.close();
                                                                }
                                                            });
                                                        } else if (result.dismiss === Swal.DismissReason.cancel) {
                                                            Swal.close();
                                                        }
                                                    });
                                                } else if (type == 'show') {
                                                    Swal.fire({
                                                        title: 'Are you sure wanted to show this review?',
                                                        imageUrl: `${pageContext.request.contextPath}/Asset/FUHF Logo/3.svg`,
                                                        imageWidth: 150,
                                                        imageHeight: 150,
                                                        imageAlt: 'Custom icon',
                                                        showCancelButton: true,
                                                        confirmButtonText: 'Show it',
                                                        cancelButtonText: 'Cancel',
                                                        reverseButtons: false,
                                                        focusConfirm: false,
                                                        focusCancel: false,
                                                        customClass: {
                                                            popup: 'rounded-xl shadow-lg',
                                                            title: 'text-xl font-semibold',
                                                            confirmButton: 'bg-[#FF7700] text-white px-4 py-2 rounded',
                                                            cancelButton: 'bg-gray-300 text-black px-4 py-2 rounded',
                                                            actions: 'space-x-4'
                                                        },
                                                        buttonsStyling: false
                                                    }).then((result) => {
                                                        if (result.isConfirmed) {
                                                            $.ajax({
                                                                url: '${pageContext.request.contextPath}/manage/reviews/update',
                                                                type: 'POST',
                                                                beforeSend: function (xhr) {
                                                                    Swal.showLoading();
                                                                },
                                                                data: {
                                                                    typeUpdate: 'status',
                                                                    rid: rid,
                                                                    status: 23
                                                                },
                                                                success: function (response) {
                                                                    if (response.ok) {
                                                                        showToast(response.message);
                                                                        setTimeout(function () {
                                                                            location.reload();
                                                                        }, 2000);
                                                                    } else {
                                                                        showToast(response.message, 'error');
                                                                    }
                                                                },
                                                                complete: function (jqXHR, textStatus) {
                                                                    Swal.close();
                                                                }
                                                            });
                                                        } else if (result.dismiss === Swal.DismissReason.cancel) {
                                                            Swal.close();
                                                        }
                                                    });
                                                }
                                            }

                                            function showToast(message, type = 'success') {
                                                let backgroundColor;
                                                if (type === "success") {
                                                    backgroundColor = "linear-gradient(to right, #00b09b, #96c93d)"; // Green
                                                } else if (type === "error") {
                                                    backgroundColor = "linear-gradient(to right, #ff416c, #ff4b2b)"; // Red
                                                } else if (type === "warning") {
                                                    backgroundColor = "linear-gradient(to right, #ffa502, #ff6348)"; // Orange
                                                } else if (type === "info") {
                                                    backgroundColor = "linear-gradient(to right, #1e90ff, #3742fa)"; // Blue
                                                } else {
                                                    backgroundColor = "#333"; // Default color (dark gray)
                                                }

                                                Toastify({
                                                    text: message, // Dynamically set message
                                                    duration: 2000,
                                                    close: true,
                                                    gravity: "top",
                                                    position: "right",
                                                    backgroundColor: backgroundColor, // Dynamically set background color
                                                    stopOnFocus: true
                                                }).showToast();
                                            }
        </script>
    </body>
</html>