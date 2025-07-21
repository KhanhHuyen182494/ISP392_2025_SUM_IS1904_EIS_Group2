<%-- 
    Document   : UserDetail
    Created on : Jul 16, 2025, 11:31:04 AM
    Author     : Huyen
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
        <title>User Detail</title>
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

                    <!-- User Management -->
                    <div class="mb-6">
                        <h3 class="text-sm font-semibold text-gray-500 uppercase tracking-wider mb-3">User Management</h3>
                        <div class="space-y-2">
                            <a href="${pageContext.request.contextPath}/manage/user" 
                               class="flex items-center gap-3 p-3 rounded-lg bg-orange-50 text-primary font-medium">
                                <i class="fas fa-users w-5"></i>
                                <span>All Users</span>
                            </a>
                        </div>
                    </div>

                    <!-- Booking Management -->
                    <div class="mb-6">
                        <h3 class="text-sm font-semibold text-gray-500 uppercase tracking-wider mb-3">Booking Management</h3>
                        <div class="space-y-2">
                            <a href="${pageContext.request.contextPath}/manage/booking" 
                               class="flex items-center gap-3 p-3 rounded-lg hover:bg-orange-50 hover:text-primary transition-colors duration-200">
                                <i class="fas fa-calendar-check w-5"></i>
                                <span>All Bookings</span>
                            </a>
                        </div>
                    </div>

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
                        </div>
                    </div>
                </nav>
            </aside>

            <!-- Main Content -->
            <main class="flex-1 px-4 sm:px-6 lg:px-8 py-8">
                <!-- Breadcrumb -->
                <div class="mb-6">
                    <nav class="flex" aria-label="Breadcrumb">
                        <ol class="inline-flex items-center space-x-1 md:space-x-3">
                            <li class="inline-flex items-center">
                                <a href="${pageContext.request.contextPath}/manage/user" class="text-gray-700 hover:text-primary">
                                    <i class="fas fa-users mr-2"></i>
                                    Users
                                </a>
                            </li>
                            <li>
                                <div class="flex items-center">
                                    <i class="fas fa-chevron-right text-gray-400 mx-2"></i>
                                    <span class="text-gray-500">User Detail</span>
                                </div>
                            </li>
                        </ol>
                    </nav>
                </div>

                <!-- User Profile Header -->
                <div class="bg-white rounded-2xl shadow-xl p-8 mb-8">
                    <div class="flex items-center justify-between mb-6">
                        <div class="flex items-center space-x-6">
                            <div class="relative">
                                <img class="w-24 h-24 rounded-full object-cover border-4 border-orange-100" 
                                     src="${pageContext.request.contextPath}/Asset/Common/Avatar/${u.avatar}" 
                                     alt="${u.first_name} ${u.last_name}">
                                <div class="absolute -bottom-2 -right-2">
                                    <c:choose>
                                        <c:when test="${u.status.id == 1}">
                                            <span class="bg-green-500 text-white rounded-full p-2 text-xs">
                                                <i class="fas fa-check"></i>
                                            </span>
                                        </c:when>
                                        <c:when test="${u.status.id == 4}">
                                            <span class="bg-red-500 text-white rounded-full p-2 text-xs">
                                                <i class="fas fa-ban"></i>
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="bg-yellow-500 text-white rounded-full p-2 text-xs">
                                                <i class="fas fa-clock"></i>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div>
                                <h1 class="text-3xl font-bold text-gray-900">${u.first_name} ${u.last_name}</h1>
                                <p class="text-gray-600 text-lg">${u.email}</p>
                                <div class="flex items-center space-x-4 mt-2">
                                    <c:choose>
                                        <c:when test="${u.role.id == 1}">
                                            <span class="inline-flex px-3 py-1 text-sm font-semibold rounded-full bg-red-100 text-red-800">
                                                <i class="fas fa-crown mr-1"></i>Administrator
                                            </span>
                                        </c:when>
                                        <c:when test="${u.role.id == 2}">
                                            <span class="inline-flex px-3 py-1 text-sm font-semibold rounded-full bg-gray-100 text-gray-800">
                                                <i class="fas fa-user mr-1"></i>Guest
                                            </span>
                                        </c:when>
                                        <c:when test="${u.role.id == 3}">
                                            <span class="inline-flex px-3 py-1 text-sm font-semibold rounded-full bg-purple-100 text-purple-800">
                                                <i class="fas fa-home mr-1"></i>Homestay Owner
                                            </span>
                                        </c:when>
                                        <c:when test="${u.role.id == 4}">
                                            <span class="inline-flex px-3 py-1 text-sm font-semibold rounded-full bg-blue-100 text-blue-800">
                                                <i class="fas fa-shield-alt mr-1"></i>Moderator
                                            </span>
                                        </c:when>
                                        <c:when test="${u.role.id == 5}">
                                            <span class="inline-flex px-3 py-1 text-sm font-semibold rounded-full bg-green-100 text-green-800">
                                                <i class="fas fa-bed mr-1"></i>Tenant
                                            </span>
                                        </c:when>
                                    </c:choose>

                                    <c:choose>
                                        <c:when test="${u.status.id == 1}">
                                            <span class="inline-flex px-3 py-1 text-sm font-semibold rounded-full bg-green-100 text-green-800">Active</span>
                                        </c:when>
                                        <c:when test="${u.status.id == 2}">
                                            <span class="inline-flex px-3 py-1 text-sm font-semibold rounded-full bg-orange-100 text-orange-800">Inactive</span>
                                        </c:when>
                                        <c:when test="${u.status.id == 3}">
                                            <span class="inline-flex px-3 py-1 text-sm font-semibold rounded-full bg-yellow-100 text-yellow-800">Pending Verification</span>
                                        </c:when>
                                        <c:when test="${u.status.id == 4}">
                                            <span class="inline-flex px-3 py-1 text-sm font-semibold rounded-full bg-red-100 text-red-800">Banned</span>
                                        </c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        <div class="flex space-x-3">
                            <a href="${pageContext.request.contextPath}/manage/user/edit?uid=${u.id}">
                                <button id="editUserBtn" class="bg-gradient-to-r from-primary to-secondary text-white px-6 py-2 rounded-lg font-semibold hover:shadow-lg transition-all duration-300">
                                    <i class="fas fa-edit mr-2"></i>Edit User
                                </button>
                            </a>
                            <c:choose>
                                <c:when test="${u.status.id == 4}">
                                    <button onclick="updateUserStatus('${u.id}', 1)" id="unbanUserBtn" class="bg-green-500 hover:bg-green-600 text-white px-6 py-2 rounded-lg font-semibold transition-colors duration-300">
                                        <i class="fas fa-check mr-2"></i>Unban User
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button onclick="updateUserStatus('${u.id}', 4)" id="banUserBtn" class="bg-red-500 hover:bg-red-600 text-white px-6 py-2 rounded-lg font-semibold transition-colors duration-300">
                                        <i class="fas fa-ban mr-2"></i>Ban User
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- User Information Grid -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-8">
                    <!-- Personal Information -->
                    <div class="bg-white rounded-xl shadow-lg p-6">
                        <h2 class="text-xl font-bold text-gray-900 mb-4 flex items-center">
                            <i class="fas fa-user-circle mr-2 text-primary"></i>
                            Personal Information
                        </h2>
                        <div class="space-y-4">
                            <div class="flex justify-between items-center py-2 border-b border-gray-100">
                                <span class="text-gray-600 font-medium">First Name:</span>
                                <span class="text-gray-900">${u.first_name}</span>
                            </div>
                            <div class="flex justify-between items-center py-2 border-b border-gray-100">
                                <span class="text-gray-600 font-medium">Last Name:</span>
                                <span class="text-gray-900">${u.last_name}</span>
                            </div>
                            <div class="flex justify-between items-center py-2 border-b border-gray-100">
                                <span class="text-gray-600 font-medium">Email:</span>
                                <span class="text-gray-900">${u.email}</span>
                            </div>
                            <div class="flex justify-between items-center py-2 border-b border-gray-100">
                                <span class="text-gray-600 font-medium">Phone:</span>
                                <span class="text-gray-900">${not empty u.phone ? u.phone : 'Not provided'}</span>
                            </div>
                            <div class="flex justify-between items-center py-2 border-b border-gray-100">
                                <span class="text-gray-600 font-medium">Date of Birth:</span>
                                <span class="text-gray-900">
                                    <c:choose>
                                        <c:when test="${not empty u.birthdate}">
                                            <fmt:formatDate value="${u.birthdate}" pattern="dd/MM/yyyy"/>
                                        </c:when>
                                        <c:otherwise>Not provided</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="flex justify-between items-center py-2">
                                <span class="text-gray-600 font-medium">Gender:</span>
                                <span class="text-gray-900">${not empty u.gender ? u.gender : 'Not specified'}</span>
                            </div>
                        </div>
                    </div>

                    <!-- Account Information -->
                    <div class="bg-white rounded-xl shadow-lg p-6">
                        <h2 class="text-xl font-bold text-gray-900 mb-4 flex items-center">
                            <i class="fas fa-cog mr-2 text-primary"></i>
                            Account Information
                        </h2>
                        <div class="space-y-4">
                            <div class="flex justify-between items-center py-2 border-b border-gray-100">
                                <span class="text-gray-600 font-medium">User ID:</span>
                                <span class="text-gray-900 font-mono">#${u.id}</span>
                            </div>
                            <div class="flex justify-between items-center py-2 border-b border-gray-100">
                                <span class="text-gray-600 font-medium">Join Date:</span>
                                <span class="text-gray-900">
                                    <fmt:formatDate value="${u.created_at}" pattern="dd/MM/yyyy HH:mm"/>
                                </span>
                            </div>
                            <div class="flex justify-between items-center py-2 border-b border-gray-100">
                                <span class="text-gray-600 font-medium">Last Updated:</span>
                                <span class="text-gray-900">
                                    <fmt:formatDate value="${u.updated_at}" pattern="dd/MM/yyyy HH:mm"/>
                                </span>
                            </div>
                            <div class="flex justify-between items-center py-2 border-b border-gray-100">
                                <span class="text-gray-600 font-medium">Email Verified:</span>
                                <span class="text-gray-900">
                                    <c:choose>
                                        <c:when test="${u.is_verified}">
                                            <span class="text-green-600"><i class="fas fa-check-circle mr-1"></i>Verified</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-red-600"><i class="fas fa-times-circle mr-1"></i>Not verified</span>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="flex justify-between items-center py-2">
                                <span class="text-gray-600 font-medium">Address:</span>
                                <span class="text-gray-900">${not empty u.address ? u.address : 'Not provided'}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
                                        function updateUserStatus(uid, statusId) {
                                            const currentRoleId = '${sessionScope.user.role.id}';
                                            const detailRoleId = '${u.role.id}';

                                            if ('${u.id}' === '${sessionScope.user.id}') {
                                                showToast('You cannot adjust yourself!', 'error');
                                                return;
                                            }

                                            if (currentRoleId == detailRoleId) {
                                                showToast('You cannot adjust user have the same role!', 'error');
                                                return;
                                            }

                                            const statusText = {
                                                4: 'ban',
                                                1: 'active'
                                            };

                                            const statusName = statusText[statusId];

                                            Swal.fire({
                                                title: statusName.charAt(0).toUpperCase() + statusName.slice(1) + ` User`,
                                                text: `Are you sure you want to ` + statusName + ` this user ?`,
                                                icon: 'warning',
                                                showCancelButton: true,
                                                confirmButtonColor: statusId === 2 ? '#10b981' : statusId === 3 ? '#ef4444' : '#3b82f6',
                                                cancelButtonColor: '#6b7280',
                                                confirmButtonText: `Yes`
                                            }).then((result) => {
                                                if (result.isConfirmed) {
                                                    Swal.fire({
                                                        title: 'Processing...',
                                                        text: 'Please wait while we update this user status.',
                                                        allowOutsideClick: false,
                                                        allowEscapeKey: false,
                                                        showConfirmButton: false,
                                                        didOpen: () => {
                                                            Swal.showLoading();
                                                        }
                                                    });

                                                    $.ajax({
                                                        url: '${pageContext.request.contextPath}/manage/user/edit',
                                                        type: 'POST',
                                                        data: {
                                                            uid: uid,
                                                            statusId: statusId,
                                                            typeUpdate: "status"
                                                        },
                                                        success: function (response) {
                                                            Swal.close();
                                                            if (response.ok) {
                                                                Swal.fire({
                                                                    title: 'Success!',
                                                                    text: `User has been ` + statusName + `ed successfully.`,
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
                                                            console.error('Error updating user status:', error);
                                                        }
                                                    });
                                                }
                                            });
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
