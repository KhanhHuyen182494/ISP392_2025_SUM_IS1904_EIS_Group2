<%-- 
    Document   : AuthorizationEdit
    Created on : Jul 16, 2025, 10:33:22 PM
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
        <title>Edit Authorization</title>

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
                               class="flex items-center gap-3 p-3 rounded-lg bg-orange-50 text-primary font-medium">
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

            <!-- Main Content -->
            <main class="flex-1 px-4 sm:px-6 lg:px-8 py-8">
                <div class="mx-auto">
                    <!-- Page Header -->
                    <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
                        <div class="flex items-center justify-between">
                            <div>
                                <h1 class="text-2xl font-bold text-gray-800">Edit Authorization</h1>
                                <p class="text-gray-600 mt-1">Update authorization endpoint information and assigned roles</p>
                            </div>
                            <div class="flex items-center gap-3">
                                <a href="${pageContext.request.contextPath}/manage/authorization" 
                                   class="inline-flex items-center gap-2 px-4 py-2 bg-gray-500 hover:bg-gray-600 text-white rounded-lg transition-colors">
                                    <i class="fas fa-arrow-left text-sm"></i>
                                    Back to Authorization List
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Authorization Info Card -->
                    <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
                        <div class="flex items-center gap-3 mb-4">
                            <div class="w-10 h-10 bg-primary bg-opacity-10 rounded-lg flex items-center justify-center">
                                <i class="fas fa-shield-alt text-primary"></i>
                            </div>
                            <div>
                                <h3 class="font-semibold text-gray-800">Authorization Details</h3>
                                <p class="text-sm text-gray-600">ID: ${f.id}</p>
                            </div>
                        </div>
                    </div>

                    <div class="bg-white rounded-lg shadow-sm p-6">
                        <form id="editForm" action="${pageContext.request.contextPath}/manage/authorization/edit" method="post">
                            <input type="hidden" name="id" value="${f.id}">

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div>
                                    <label for="name" class="block text-sm font-medium text-gray-700 mb-2">
                                        Name: <span class="text-red-500">*</span>
                                    </label>
                                    <input type="text" id="name" name="name" required value="${f.name}"
                                           class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
                                </div>

                                <div>
                                    <label for="path" class="block text-sm font-medium text-gray-700 mb-2">
                                        Path: <span class="text-red-500">*</span>
                                    </label>
                                    <input type="text" id="path" name="path" required value="${f.path}"
                                           class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
                                </div>

                                <div class="md:col-span-2">
                                    <label class="block text-sm font-medium text-gray-700 mb-3">
                                        Role Permissions: <span class="text-red-500">*</span>
                                    </label>
                                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                                        <c:forEach items="${rList}" var="role">
                                            <c:set var="isAssigned" value="false"/>
                                            <c:forEach items="${rfList}" var="rf">
                                                <c:if test="${rf.role.id == role.id and rf.status.id == 18}">
                                                    <c:set var="isAssigned" value="true"/>
                                                </c:if>
                                            </c:forEach>

                                            <div class="relative">
                                                <input type="checkbox" id="${role.name}" name="role" value="${role.id}" 
                                                       ${isAssigned ? 'checked' : ''}
                                                       data-originally-assigned="${isAssigned}"
                                                       class="peer sr-only">
                                                <label for="${role.name}" 
                                                       class="flex items-center justify-between w-full p-3 bg-white border border-gray-300 rounded-lg cursor-pointer hover:bg-gray-50 peer-checked:bg-primary peer-checked:text-white peer-checked:border-primary transition-all duration-200">
                                                    <div class="flex items-center gap-2">
                                                        <span class="text-sm font-medium">${role.name}</span>
                                                        <c:if test="${isAssigned}">
                                                            <span class="text-xs bg-green-100 text-green-800 px-2 py-1 rounded-full peer-checked:bg-white peer-checked:bg-opacity-20 peer-checked:text-white">
                                                                Enabled
                                                            </span>
                                                        </c:if>
                                                    </div>
                                                    <svg class="w-4 h-4 opacity-0 peer-checked:opacity-100 transition-opacity" 
                                                         fill="currentColor" viewBox="0 0 20 20">
                                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                                                    </svg>
                                                </label>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <p class="text-sm text-gray-500 mt-2">
                                        <i class="fas fa-info-circle"></i>
                                        Check roles to enable access to this endpoint. Uncheck to disable access.
                                    </p>
                                </div>
                            </div>

                            <!-- Form Actions -->
                            <div class="flex items-center justify-end gap-4 mt-8 pt-6 border-t border-gray-200">
                                <a href="${pageContext.request.contextPath}/manage/authorization"
                                   class="px-6 py-2 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition-colors">
                                    Cancel
                                </a>
                                <button type="button" id="submitBtn"
                                        class="px-6 py-2 bg-primary hover:bg-secondary text-white rounded-lg transition-colors flex items-center gap-2">
                                    <i class="fas fa-save"></i>
                                    Update Authorization
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
            // Form validation
            document.getElementById('submitBtn').addEventListener('click', function () {
                var id = $('input[name="id"]').val();
                var name = $('#name').val();
                var path = $('#path').val();
                var enabledRoles = [];

                $('input[name="role"]').each(function () {
                    var roleId = $(this).val();
                    var isCurrentlyAssigned = $(this).data('originally-assigned') === true;
                    var isChecked = $(this).is(':checked');

                    if (isChecked) {
                        // Role is being enabled (newly checked)
                        enabledRoles.push(roleId);
                    }
                });

                

                if (name.trim().length <= 0 || name.trim().length > 50) {
                    showToast("Please enter valid name (> 0 and < 50 length)!", "error");
                    return;
                }

                if (path.trim().length <= 0 || path.trim().length > 50 || !path.trim().startsWith("/")) {
                    showToast("Please enter valid path (> 0 and < 50 length, and must start with '/')!", "error");
                    return;
                }

                var totalEnabledAfterChanges = $('input[name="role"]:checked').length;
                if (totalEnabledAfterChanges === 0) {
                    showToast("Please select at least one role!", "error");
                    return;
                }

                Swal.fire({
                    title: 'Update Authorization?',
                    text: 'Are you sure you want to update this authorization? (CAUTION: If you disable you own role endpoint, you and other user of that role will no longer can reach that endpoint!)',
                    icon: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#FF6B35',
                    cancelButtonColor: '#6b7280',
                    confirmButtonText: 'Yes, update',
                    cancelButtonText: 'Cancel'
                }).then((result) => {
                    if (result.isConfirmed) {
                        const submitBtn = $('#submitBtn');
                        const originalText = submitBtn.innerHTML;
                        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Updating...';
                        submitBtn.disabled = true;

                        $.ajax({
                            url: '${pageContext.request.contextPath}/manage/authorization/edit',
                            method: 'POST',
                            beforeSend: function () {
                                Swal.fire({
                                    title: 'Updating ...',
                                    text: 'Please wait while we update the authorization.',
                                    allowOutsideClick: false,
                                    allowEscapeKey: false,
                                    didOpen: () => {
                                        Swal.showLoading();
                                    }
                                });
                            },
                            data: {
                                id: id,
                                name: name.trim(),
                                path: path.trim(),
                                enabledRoles: enabledRoles
                            },
                            success: function (response) {
                                Swal.close();
                                if (response.ok) {
                                    showToast(response.message);
                                    // Optionally redirect to authorization list after successful update
                                    setTimeout(() => {
                                        location.reload();
                                    }, 2000);
                                } else {
                                    showToast(response.message, "error");
                                }
                                submitBtn.innerHTML = originalText;
                                submitBtn.disabled = false;
                            },
                            error: function () {
                                Swal.close();
                                showToast("Failed to update authorization!", "error");
                                submitBtn.innerHTML = originalText;
                                submitBtn.disabled = false;
                            }
                        });
                    }
                });
            });

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