<%-- 
    Document   : PostDetail
    Created on : Jul 9, 2025, 1:41:55 PM
    Author     : Tam
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
        <title>User List</title>

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
                               class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
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
                </nav>
            </aside>

            <main class="flex-1 px-4 sm:px-6 lg:px-8 py-8">
                <!-- Dashboard Header -->
                <div class="bg-white rounded-2xl shadow-xl p-8 mb-4">
                    <div class="flex items-center justify-between">
                        <div>
                            <h1 class="text-4xl font-bold bg-gradient-to-r from-primary to-secondary bg-clip-text text-transparent mb-2">
                                Post Management
                            </h1>
                            <p class="text-gray-600">Manage and monitor all posts in FUHF homestay booking system</p>
                        </div>
                        <button onclick="goBack()" class="bg-gray-100 hover:bg-gray-200 text-gray-700 px-4 py-2 rounded-lg transition-colors duration-200 flex items-center">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
                            </svg>
                            Back to Posts
                        </button>
                    </div>
                </div>

                <!-- User Card -->
                <div class="bg-white rounded-2xl shadow-xl p-8 mb-8">
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-2xl font-bold text-gray-900">Post Author</h2>
                        <c:choose>
                            <c:when test="${p.status.id == 14}">
                                <span class="inline-flex px-4 py-2 text-sm font-semibold rounded-full bg-green-100 text-green-800">${p.status.name}</span>
                            </c:when>
                            <c:when test="${p.status.id == 15}">
                                <span class="inline-flex px-4 py-2 text-sm font-semibold rounded-full bg-orange-100 text-orange-800">${p.status.name}</span>
                            </c:when>
                            <c:when test="${p.status.id == 20}">
                                <span class="inline-flex px-4 py-2 text-sm font-semibold rounded-full bg-yellow-100 text-orange-800">${p.status.name}</span>
                            </c:when>
                            <c:when test="${p.status.id == 37}">
                                <span class="inline-flex px-4 py-2 text-sm font-semibold rounded-full bg-red-100 text-red-800">${p.status.name}</span>
                            </c:when>
                        </c:choose>
                    </div>

                    <div class="flex flex-col md:flex-row gap-6">
                        <!-- User Profile -->
                        <div class="flex items-center gap-4">
                            <img class="h-20 w-20 rounded-full object-cover border-4 border-gray-100" 
                                 src="${pageContext.request.contextPath}/Asset/Common/Avatar/${p.owner.avatar}" 
                                 alt="User Avatar">
                            <div>
                                <h3 class="text-xl font-semibold text-gray-900">${p.owner.first_name} ${p.owner.last_name}</h3>
                                <p class="text-gray-600">${p.owner.email}</p>
                                <div class="mt-2">
                                    <span class="inline-flex px-3 py-1 text-xs font-medium rounded-full bg-green-100 text-green-800">
                                        ${p.owner.status.name}
                                    </span>
                                </div>
                            </div>
                        </div>

                        <!-- User Stats -->
                        <div class="flex gap-4 ml-auto">
                            <div class="bg-blue-50 p-3 rounded-lg text-center min-w-16">
                                <div class="text-xl font-bold text-blue-600">${countTotalOwnerPost}</div>
                                <div class="text-xs text-blue-600">Total</div>
                            </div>
                            <div class="bg-green-50 p-3 rounded-lg text-center min-w-16">
                                <div class="text-xl font-bold text-green-600">${countPublishedOwnerPost}</div>
                                <div class="text-xs text-green-600">Approved</div>
                            </div>
                            <div class="bg-red-50 p-3 rounded-lg text-center min-w-16">
                                <div class="text-xl font-bold text-red-600">${countRejectOwnerPost}</div>
                                <div class="text-xs text-red-600">Rejected</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Post Details -->
                <div class="bg-white rounded-2xl shadow-xl p-8">
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-2xl font-bold text-gray-900">Post Details</h2>
                        <div class="flex space-x-3">
                            <c:if test="${sessionScope.user.role.id != 1}">
                                <c:if test="${p.status.id == 37}">
                                    <form action="${pageContext.request.contextPath}/manage/post/update" method="POST">
                                        <input type="hidden" name="typeUpdate" value="approve" />
                                        <input type="hidden" name="postId" value="${p.id}" />
                                        <button class="text-green-600 hover:text-green-900 transition p-2 bg-green-100 hover:bg-green-200 rounded">
                                            Approve
                                        </button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/manage/post/update" method="POST">
                                        <input type="hidden" name="typeUpdate" value="reject" />
                                        <input type="hidden" name="postId" value="${p.id}" />
                                        <button class="text-red-600 hover:text-red-900 transition p-2 bg-red-100 hover:bg-red-200 rounded">
                                            Reject
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${p.status.id == 38}">
                                    <form action="${pageContext.request.contextPath}/manage/post/update" method="POST">
                                        <input type="hidden" name="typeUpdate" value="approve" />
                                        <input type="hidden" name="postId" value="${p.id}" />
                                        <button class="text-red-600 hover:text-red-900 transition p-2 bg-red-100 hover:bg-red-200 rounded">
                                            Re-Approve
                                        </button>
                                    </form>
                                </c:if>
                            </c:if>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                        <!-- Post Information -->
                        <div class="space-y-6">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Post Type</label>
                                <div class="bg-purple-50 px-4 py-3 rounded-lg">
                                    <span class="text-purple-800 font-medium">${p.post_type.name}</span>
                                </div>
                            </div>

                            <c:if test="${p.post_type.id == 1}">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Associated Homestay</label>
                                    <div class="bg-blue-50 px-4 py-3 rounded-lg">
                                        <div class="flex items-center">
                                            <a href="${pageContext.request.contextPath}/owner-house/detail?hid=${p.house.id}">
                                                <img class="h-10 w-10 rounded-lg object-cover mr-3" 
                                                     src="https://images.unsplash.com/photo-1564013799919-ab600027ffc6?ixlib=rb-1.2.1&auto=format&fit=crop&w=100&q=80" 
                                                     alt="Homestay">
                                            </a>
                                            <div>
                                                <p class="font-medium text-blue-800">${p.house.name}</p>
                                                <p class="text-sm text-blue-600">${p.house.description}</p>
                                                <p class="text-sm text-blue-600 font-bold">Price / night: <fmt:formatNumber value="${p.house.price_per_night}" type="number" groupingUsed="true" maxFractionDigits="0" /></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <div class="grid grid-cols-2 gap-4">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Post Date</label>
                                    <p class="text-gray-900 bg-gray-50 px-3 py-2 rounded-lg"><fmt:formatDate value="${p.created_at}" pattern="dd/MM/yyyy"/></p>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Last Updated</label>
                                    <c:if test="${not empty p.updated_at}">
                                        <p class="text-gray-900 bg-gray-50 px-3 py-2 rounded-lg"><fmt:formatDate value="${p.updated_at}" pattern="dd/MM/yyyy"/></p>
                                    </c:if>
                                    <c:if test="${empty p.updated_at}">
                                        <p class="text-gray-900 bg-gray-50 px-3 py-2 rounded-lg">Not Yet</p>
                                    </c:if>
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Post ID</label>
                                <p class="text-gray-900 bg-gray-50 px-3 py-2 rounded-lg font-mono">#${p.id}</p>
                            </div>
                        </div>

                        <!-- Post Content -->
                        <div class="space-y-6">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Post Content</label>
                                <div class="bg-gray-50 px-4 py-3 rounded-lg">
                                    <p class="text-gray-900 leading-relaxed">
                                        ${p.content}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Additional Information -->
                    <div class="mt-8 border-t pt-6">
                        <h3 class="text-lg font-semibold text-gray-900 mb-4">Additional Information</h3>
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                            <!--                            <div class="bg-gray-50 p-4 rounded-lg">
                                                            <h4 class="font-medium text-gray-900 mb-2">Engagement Stats</h4>
                                                            <div class="space-y-2 text-sm">
                                                                <div class="flex justify-between">
                                                                    <span class="text-gray-600">Views:</span>
                                                                    <span class="font-medium">157</span>
                                                                </div>
                                                                <div class="flex justify-between">
                                                                    <span class="text-gray-600">Responses:</span>
                                                                    <span class="font-medium">23</span>
                                                                </div>
                                                                <div class="flex justify-between">
                                                                    <span class="text-gray-600">Saved:</span>
                                                                    <span class="font-medium">8</span>
                                                                </div>
                                                            </div>
                                                        </div>-->
                            <div class="bg-gray-50 p-4 rounded-lg">
                                <h4 class="font-medium text-gray-900 mb-2">Content Analysis</h4>
                                <div class="space-y-2 text-sm">
                                    <div class="flex justify-between">
                                        <span class="text-gray-600">Word Count:</span>
                                        <span class="font-medium">186</span>
                                    </div>
                                    <div class="flex justify-between">
                                        <span class="text-gray-600">Language:</span>
                                        <span class="font-medium">English</span>
                                    </div>
                                </div>
                            </div>
                            <!--                            <div class="bg-gray-50 p-4 rounded-lg">
                                                            <h4 class="font-medium text-gray-900 mb-2">Moderation</h4>
                                                            <div class="space-y-2 text-sm">
                                                                <div class="flex justify-between">
                                                                    <span class="text-gray-600">Auto-flagged:</span>
                                                                    <span class="font-medium text-green-600">No</span>
                                                                </div>
                                                                <div class="flex justify-between">
                                                                    <span class="text-gray-600">Reports:</span>
                                                                    <span class="font-medium">0</span>
                                                                </div>
                                                                <div class="flex justify-between">
                                                                    <span class="text-gray-600">Priority:</span>
                                                                    <span class="font-medium text-yellow-600">Normal</span>
                                                                </div>
                                                            </div>
                                                        </div>-->
                        </div>
                    </div>

                    <!-- Admin Actions -->
                    <c:if test="${sessionScope.user.role.id == 1}">
                        <div class="mt-8 border-t pt-6">
                            <h3 class="text-lg font-semibold text-gray-900 mb-4">Admin Actions</h3>
                            <div class="flex flex-wrap gap-3">
                                <c:if test="${p.status.id == 37}">
                                    <form action="${pageContext.request.contextPath}/manage/post/update" method="POST">
                                        <input type="hidden" name="typeUpdate" value="approve" />
                                        <input type="hidden" name="postId" value="${p.id}" />
                                        <button class="text-green-600 hover:text-green-900 transition p-2 bg-green-100 hover:bg-green-200 rounded">
                                            Approve
                                        </button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/manage/post/update" method="POST">
                                        <input type="hidden" name="typeUpdate" value="reject" />
                                        <input type="hidden" name="postId" value="${p.id}" />
                                        <button class="text-red-600 hover:text-red-900 transition p-2 bg-red-100 hover:bg-red-200 rounded">
                                            Reject
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${p.status.id == 38}">
                                    <form action="${pageContext.request.contextPath}/manage/post/update" method="POST">
                                        <input type="hidden" name="typeUpdate" value="approve" />
                                        <input type="hidden" name="postId" value="${p.id}" />
                                        <button class="text-red-600 hover:text-red-900 transition p-2 bg-red-100 hover:bg-red-200 rounded">
                                            Re-Approve
                                        </button>
                                    </form>
                                </c:if>
                                <button onclick="goToUser('${p.owner.id}')" class="bg-yellow-600 hover:bg-yellow-700 text-white px-4 py-2 rounded-lg transition-colors duration-200">
                                    Go To Owner Profile
                                </button>
                            </div>
                        </div>
                    </c:if>
                </div>
            </main>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
                                    function goBack() {
                                        window.history.back();
                                    }

                                    function approvePost() {
                                        showModal(
                                                'Approve Post',
                                                'Are you sure you want to approve this post? It will be visible to all users.',
                                                () => {
                                            console.log('Post approved');
                                            alert('Post approved successfully!');
                                            closeModal();
                                        },
                                                'Approve',
                                                'bg-green-600 hover:bg-green-700'
                                                );
                                    }

                                    function rejectPost() {
                                        showModal(
                                                'Reject Post',
                                                'Are you sure you want to reject this post? The user will be notified.',
                                                () => {
                                            console.log('Post rejected');
                                            alert('Post rejected successfully!');
                                            closeModal();
                                        },
                                                'Reject',
                                                'bg-red-600 hover:bg-red-700'
                                                );
                                    }

                                    function goToUser(uid) {
                                        location.href = '${pageContext.request.contextPath}/profile?uid=' + uid;
                                    }
        </script>
    </body>
</html>