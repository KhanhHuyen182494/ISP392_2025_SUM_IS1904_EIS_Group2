<%-- 
    Document   : Edit User
    Created on : Jul 16, 2025, 11:31:40 AM
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
        <title>Edit User</title>
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
                                    <a href="${pageContext.request.contextPath}/manage/user/detail?uid=${u.id}" class="text-gray-700 hover:text-primary">
                                        User Detail
                                    </a>
                                </div>
                            </li>
                            <li>
                                <div class="flex items-center">
                                    <i class="fas fa-chevron-right text-gray-400 mx-2"></i>
                                    <span class="text-gray-500">Edit User</span>
                                </div>
                            </li>
                        </ol>
                    </nav>
                </div>

                <!-- Edit User Form -->
                <div class="bg-white rounded-2xl shadow-xl p-8 mb-8">
                    <div class="flex items-center justify-between mb-8">
                        <div class="flex items-center space-x-4">
                            <div class="w-16 h-16 rounded-full bg-gradient-to-r from-primary to-secondary flex items-center justify-center">
                                <i class="fas fa-user-edit text-white text-2xl"></i>
                            </div>
                            <div>
                                <h1 class="text-3xl font-bold text-gray-900">Edit User</h1>
                                <p class="text-gray-600">Modify user information and settings (NOTICE: you can not update user in same role)</p>
                            </div>
                        </div>
                        <div class="flex space-x-3">
                            <a href="${pageContext.request.contextPath}/manage/user" 
                               class="bg-gray-500 hover:bg-gray-600 text-white px-6 py-2 rounded-lg font-semibold transition-colors duration-300">
                                <i class="fas fa-arrow-left mr-2"></i>Back to List
                            </a>
                        </div>
                    </div>

                    <form id="editUserForm" action="${pageContext.request.contextPath}/manage/user/edit" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="uid" value="${u.id}">
                        <input type="hidden" name="typeUpdate" value="profile">

                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                            <!-- Form Fields -->
                            <div class="lg:col-span-2">
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <!-- First Name -->
                                    <div>
                                        <label for="firstName" class="block text-sm font-medium text-gray-700 mb-2">
                                            First Name <span class="text-red-500">*</span>
                                        </label>
                                        <input type="text" id="firstName" name="firstName" value="${u.first_name}" required ${u.role.id == sessionScope.user.role.id and u.id != sessionScope.user.id ? 'readonly' : ''}
                                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                    </div>

                                    <!-- Last Name -->
                                    <div>
                                        <label for="lastName" class="block text-sm font-medium text-gray-700 mb-2">
                                            Last Name <span class="text-red-500">*</span>
                                        </label>
                                        <input type="text" id="lastName" name="lastName" value="${u.last_name}" required ${u.role.id == sessionScope.user.role.id and u.id != sessionScope.user.id ? 'readonly' : ''}
                                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                    </div>

                                    <!-- Email -->
                                    <div>
                                        <label for="email" class="block text-sm font-medium text-gray-700 mb-2">
                                            Email <span class="text-red-500">*</span>
                                        </label>
                                        <input type="email" id="email" name="email" value="${u.email}" required ${u.role.id == sessionScope.user.role.id and u.id != sessionScope.user.id ? 'readonly' : ''}
                                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                    </div>

                                    <!-- Phone -->
                                    <div>
                                        <label for="phone" class="block text-sm font-medium text-gray-700 mb-2">
                                            Phone Number
                                        </label>
                                        <input type="tel" id="phone" name="phone" value="${u.phone}" ${u.role.id == sessionScope.user.role.id and u.id != sessionScope.user.id ? 'readonly' : ''}
                                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                    </div>

                                    <!-- Date of Birth -->
                                    <div>
                                        <label for="birthdate" class="block text-sm font-medium text-gray-700 mb-2">
                                            Date of Birth
                                        </label>
                                        <input type="date" id="birthdate" name="birthdate" ${u.role.id == sessionScope.user.role.id and u.id != sessionScope.user.id ? 'readonly' : ''}
                                               value="<fmt:formatDate value='${u.birthdate}' pattern='yyyy-MM-dd'/>"
                                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                    </div>

                                    <!-- Gender -->
                                    <div>
                                        <label for="gender" class="block text-sm font-medium text-gray-700 mb-2">
                                            Gender
                                        </label>
                                        <select id="gender" name="gender" ${u.role.id == sessionScope.user.role.id and u.id != sessionScope.user.id ? 'disabled' : ''}
                                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                            <option value="">Select Gender</option>
                                            <option value="male" ${u.gender == 'male' ? 'selected' : ''}>Male</option>
                                            <option value="female" ${u.gender == 'female' ? 'selected' : ''}>Female</option>
                                            <option value="other" ${u.gender == 'other' ? 'selected' : ''}>Other</option>
                                        </select>
                                    </div>

                                    <!-- Role -->
                                    <div>
                                        <label for="roleId" class="block text-sm font-medium text-gray-700 mb-2">
                                            Role <span class="text-red-500">*</span>
                                        </label>
                                        <select id="roleId" name="roleId" required
                                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                            <c:forEach var="role" items="${rList}">
                                                <option value="${role.id}" ${u.role.id == role.id ? 'selected' : ''}>
                                                    ${role.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <!-- Status -->
                                    <div>
                                        <label for="statusId" class="block text-sm font-medium text-gray-700 mb-2">
                                            Status <span class="text-red-500">*</span>
                                        </label>
                                        <select id="statusId" name="statusId" required
                                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                            <c:forEach var="status" items="${sList}">
                                                <option value="${status.id}" ${u.status.id == status.id ? 'selected' : ''}>
                                                    ${status.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Form Actions -->
                        <div class="flex justify-between items-center mt-8 pt-6 border-t border-gray-200">
                            <div class="text-sm text-gray-500">
                                <span class="text-red-500">*</span> Required fields
                            </div>
                            <div class="flex space-x-4">
                                <button type="button" id="submitBtn"
                                        class="bg-gradient-to-r from-primary to-secondary hover:from-secondary hover:to-primary text-white px-8 py-3 rounded-lg font-semibold transition-all duration-300 shadow-lg hover:shadow-xl">
                                    <i class="fas fa-save mr-2"></i>Update User
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </main>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
            // Form validation
            document.getElementById('submitBtn').addEventListener('click', function (e) {
                e.preventDefault();

                const firstName = document.getElementById('firstName').value.trim();
                const lastName = document.getElementById('lastName').value.trim();
                const email = document.getElementById('email').value.trim();
                const phone = document.getElementById('phone').value.trim();
                const gender = document.getElementById('gender').value;
                const birthdate = document.getElementById('birthdate').value;
                const roleId = document.getElementById('roleId').value;
                const statusId = document.getElementById('statusId').value;

                if (!firstName || !lastName || !email || !roleId || !statusId || !gender) {
                    showToast('Please fill in all required fields marked with *', 'error');
                    return;
                }

                if (firstName.length === 0 || firstName.length > 50) {
                    showToast('First name must be between 1 and 50 characters.', 'error');
                    return;
                }

                if (lastName.length === 0 || lastName.length > 50) {
                    showToast('Last name must be between 1 and 50 characters.', 'error');
                    return;
                }

                if (email.length > 80) {
                    showToast('Email must be less than 80 characters.', 'error');
                    return;
                }

                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    showToast('Please enter a valid email address.', 'error');
                    return;
                }

                if (phone) {
                    const vietnamPhoneRegex = /^(?:\+?84|0)(3|5|7|8|9)\d{8}$/;
                    if (!vietnamPhoneRegex.test(phone)) {
                        showToast('Please enter a valid vietnamese phone number.', 'error');
                        return;
                    }
                }

                if (birthdate) {
                    const date = new Date(birthdate);
                    const today = new Date();
                    if (isNaN(date.getTime()) || date >= today) {
                        showToast('Please enter a valid birthdate (must be in the past).', 'error');
                        return;
                    }
                }

                Swal.fire({
                    title: 'Updating User...',
                    text: 'Please wait while we save the changes.',
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
                        uid: '${u.id}',
                        firstName: firstName,
                        lastName: lastName,
                        email: email,
                        phone: phone,
                        gender: gender,
                        birthdate: birthdate,
                        roleId: roleId,
                        statusId: statusId,
                        typeUpdate: "user"
                    },
                    success: function (response) {
                        Swal.close();
                        if (response.ok) {
                            Swal.fire({
                                title: 'Success!',
                                text: 'User has been updated successfully.',
                                icon: 'success',
                                confirmButtonColor: '#3b82f6'
                            }).then(() => {
                                location.reload();
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
                    error: function () {
                        Swal.close();
                        Swal.fire({
                            title: 'Error!',
                            text: 'Network error. Please check your connection and try again.',
                            icon: 'error',
                            confirmButtonColor: '#ef4444'
                        });
                    }
                });
            });

            // Toast notification function
            function showToast(message, type = 'success') {
                let backgroundColor;
                if (type === "success") {
                    backgroundColor = "linear-gradient(to right, #00b09b, #96c93d)";
                } else if (type === "error") {
                    backgroundColor = "linear-gradient(to right, #ff416c, #ff4b2b)";
                } else if (type === "warning") {
                    backgroundColor = "linear-gradient(to right, #ffa502, #ff6348)";
                } else if (type === "info") {
                    backgroundColor = "linear-gradient(to right, #1e90ff, #3742fa)";
                } else {
                    backgroundColor = "#333";
                }

                Toastify({
                    text: message,
                    duration: 3000,
                    close: true,
                    gravity: "top",
                    position: "right",
                    backgroundColor: backgroundColor,
                    stopOnFocus: true
                }).showToast();
            }
        </script>
    </body>
</html>