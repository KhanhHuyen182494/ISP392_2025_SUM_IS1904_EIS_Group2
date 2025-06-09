<%-- 
    Document   : ProfileEdit
    Created on : Jun 5, 2025, 7:09:16 AM
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
        <title>Edit Profile</title>

        <!-- Libs -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <link href="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://cdn.tailwindcss.com"></script>

        <style>
            .gradient-bg {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            }
            .card-hover {
                transition: all 0.3s ease;
            }
            .card-hover:hover {
                transform: translateY(-5px);
                box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            }
            .tag-hover {
                transition: all 0.2s ease;
            }
            .tag-hover:hover {
                background-color: #3b82f6;
                color: white;
            }
            .like-btn {
                transition: all 0.2s ease;
            }
            .like-btn:hover {
                background-color: #3b82f6;
                color: white;
            }
            .like-btn.liked {
                background-color: #3b82f6;
                color: white;
            }
            .feedback-badge {
                background: linear-gradient(45deg, #ff6b6b, #feca57);
            }
            .search-focus {
                transition: all 0.3s ease;
            }
            .search-focus:focus {
                transform: scale(1.02);
                box-shadow: 0 0 20px rgba(255, 165, 0, 0.3);
            }

            /* Modal Styles */
            .modal-overlay {
                background-color: rgba(0, 0, 0, 0.5);
                backdrop-filter: blur(4px);
                opacity: 0;
                visibility: hidden;
                transition: all 0.3s ease;
            }

            .modal-overlay.active {
                opacity: 1;
                visibility: visible;
            }

            .modal-content {
                transform: translateY(-50px);
                transition: transform 0.3s ease;
            }

            .modal-overlay.active .modal-content {
                transform: translateY(0);
            }

            .feedback-item {
                transition: all 0.2s ease;
            }

            .feedback-item:hover {
                background-color: #f8fafc;
                transform: translateX(5px);
            }

            .star-rating {
                color: #fbbf24;
            }

            .loading-spinner {
                border: 2px solid #f3f3f3;
                border-top: 2px solid #3498db;
                border-radius: 50%;
                width: 20px;
                height: 20px;
                animation: spin 1s linear infinite;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }
                100% {
                    transform: rotate(360deg);
                }
            }

            .modal-close-btn {
                transition: all 0.2s ease;
            }

            .modal-close-btn:hover {
                background-color: #ef4444;
                color: white;
                transform: scale(1.1);
            }

            .swal2-loader {
                border-color: #FF7700 !important;
                border-top-color: transparent !important;
            }

            .swal2-loader {
                width: 2.2em !important;
                height: 2.2em !important;
                border-width: 0.22em !important;
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
                                <a href="${pageContext.request.contextPath}/logout">
                                    <button class="p-1 px-2 bg-orange-500 hover:bg-orange-600 text-white rounded-lg text-sm transition-colors">
                                        Logout
                                    </button>
                                </a>
                                <div class="name">
                                    <p><b>${sessionScope.user.first_name} ${sessionScope.user.last_name}</b></p>
                                </div>
                                <a href="${pageContext.request.contextPath}/profile?uid=${sessionScope.user.id}">
                                    <div class="avatar">
                                        <img class="rounded-[50%]" src="${sessionScope.user.avatar}" width="40"/>
                                    </div>
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </header>

        <!-- Avatar, Cover Section -->
        <div class="max-w-7xl mx-auto px-4 py-6">
            <!-- Cover Photo Container -->
            <div class="relative bg-gradient-to-r from-blue-400 via-purple-500 to-pink-500 rounded-2xl overflow-hidden shadow-lg" style="height: 300px;">
                <!-- Cover Image (if available) -->
                <c:if test="${not empty requestScope.profile.cover}">
                    <img src="${requestScope.profile.cover}" 
                         alt="Cover Photo" 
                         class="w-full h-full object-cover"/>
                </c:if>

                <!-- Gradient Overlay -->
                <div class="absolute inset-0 bg-black bg-opacity-20"></div>

                <!-- Edit Cover Button (only for own profile) -->
                <c:if test="${sessionScope.user.id == requestScope.profile.id}">
                    <button class="absolute top-4 right-4 bg-white bg-opacity-20 backdrop-blur-sm hover:bg-opacity-30 text-white px-4 py-2 rounded-lg transition-all duration-300 flex items-center gap-2">
                        <i class="fas fa-camera"></i>
                        <span class="hidden sm:inline">Edit Cover</span>
                    </button>
                </c:if>

                <!-- Profile Info Overlay -->
                <div class="absolute bottom-0 left-0 right-0 p-6">
                    <div class="flex flex-col sm:flex-row items-start sm:items-end gap-4">
                        <!-- Avatar -->
                        <div class="relative">
                            <div class="w-32 h-32 rounded-full border-4 border-white overflow-hidden shadow-lg bg-white">
                                <c:choose>
                                    <c:when test="${not empty requestScope.profile.avatar}">
                                        <img src="${requestScope.profile.avatar}" 
                                             alt="Profile Avatar" 
                                             class="w-full h-full object-cover"/>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="w-full h-full bg-gray-200 flex items-center justify-center">
                                            <i class="fas fa-user text-gray-400 text-4xl"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Edit Avatar Button (only for own profile) -->
                            <c:if test="${sessionScope.user.id == requestScope.profile.id}">
                                <button class="absolute bottom-2 right-2 w-8 h-8 bg-blue-500 hover:bg-blue-600 text-white rounded-full flex items-center justify-center transition-colors shadow-lg">
                                    <i class="fas fa-camera text-xs"></i>
                                </button>
                            </c:if>
                        </div>

                        <!-- User Info -->
                        <div class="flex-1 text-white">
                            <h1 class="text-3xl font-bold mb-2">
                                <c:choose>
                                    <c:when test="${sessionScope.user.id == requestScope.profile.id}">
                                        ${sessionScope.user.first_name} ${sessionScope.user.last_name}
                                    </c:when>
                                    <c:otherwise>
                                        ${requestScope.profile.first_name} ${requestScope.profile.last_name}
                                    </c:otherwise>
                                </c:choose>
                            </h1>

                            <!-- User Stats -->
                            <div class="flex gap-6 text-sm">
                                <div class="flex items-center gap-1">
                                    <i class="fas fa-home"></i>
                                    <span>${fn:length(posts)} Posts</span>
                                </div>
                                <div class="flex items-center gap-1">
                                    <i class="fas fa-thumbs-up"></i>
                                    <span>${requestScope.totalLikes} Likes</span>
                                </div>
                                <div class="flex items-center gap-1">
                                    <i class="fas fa-calendar-alt"></i>
                                    <span>Joined <fmt:formatDate value="${requestScope.profile.created_at}" pattern="MMM yyyy" /></span>
                                </div>
                            </div>

                            <!-- Bio (if available) -->
                            <c:if test="${not empty requestScope.profile.description}">
                                <p class="mt-2 text-gray-100 max-w-md">${requestScope.profile.description}</p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="flex justify-end gap-3 mt-4">
                <c:choose>
                    <c:when test="${sessionScope.user.id == requestScope.profile.id}">
                        <!-- Own Profile Actions -->
                        <c:if test="${sessionScope.user.role.id == 3}">
                            <a href="${pageContext.request.contextPath}/owner-house?uid=${sessionScope.user.id}">
                                <button class="bg-orange-500 hover:bg-orange-600 text-white px-6 py-2 rounded-lg transition-colors flex items-center gap-2">
                                    <i class="fas fa-home"></i>
                                    View your's houses
                                </button>
                            </a>
                        </c:if>
                        <button class="bg-blue-500 hover:bg-blue-600 text-white px-6 py-2 rounded-lg transition-colors flex items-center gap-2">
                            <i class="fas fa-edit"></i>
                            Edit Profile
                        </button>
                        <c:if test="${sessionScope.user.role.id == 3}">
                            <button class="bg-green-500 hover:bg-green-600 text-white px-6 py-2 rounded-lg transition-colors flex items-center gap-2">
                                <i class="fas fa-plus"></i>
                                Add Post
                            </button>
                        </c:if>
                        <!--<a href="${pageContext.request.contextPath}/change-password">-->
                        <button class="bg-red-400 hover:bg-red-500 text-white px-6 py-2 rounded-lg transition-colors flex items-center gap-2" onclick="showChangePassword()" >
                            <i class="fa-solid fa-lock"></i>
                            Change Password
                        </button>
                        <!--</a>-->
                    </c:when>
                    <c:otherwise>
                        <!-- Other User Profile Actions -->
                        <c:if test="${requestScope.profile.role.id == 3}">
                            <a href="${pageContext.request.contextPath}/owner-house?uid=${requestScope.profile.id}">
                                <button class="bg-orange-500 hover:bg-orange-600 text-white px-6 py-2 rounded-lg transition-colors flex items-center gap-2">
                                    <i class="fas fa-home"></i>
                                    View all houses
                                </button>
                            </a>
                        </c:if>
                        <button class="bg-blue-500 hover:bg-blue-600 text-white px-6 py-2 rounded-lg transition-colors flex items-center gap-2">
                            <i class="fas fa-user-plus"></i>
                            Follow
                        </button>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="max-w-7xl mx-auto px-4 py-8 grid grid-cols-8 gap-8">
            <div class="col-span-8">
                <div class="bg-gray-50 rounded-2xl shadow-lg mb-8 overflow-hidden max-h-[80rem] min-h-[20rem] p-4 overflow-y-auto">
                    <div class="grid grid-cols-8 gap-6">
                        <!-- Input 1 - First Name -->
                        <div class="col-span-2 space-y-2">
                            <label class="block text-sm font-medium text-gray-700">First Name</label>
                            <input id="firstname" type="text" name="first_name" value="${profile.first_name}" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200 bg-white shadow-sm hover:shadow-md" placeholder="Enter first name">
                        </div>

                        <!-- Input 2 - Last Name -->
                        <div class="col-span-2 space-y-2">
                            <label class="block text-sm font-medium text-gray-700">Last Name</label>
                            <input id="lastname" type="text" name="last_name" value="${profile.last_name}" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200 bg-white shadow-sm hover:shadow-md" placeholder="Enter last name">
                        </div>

                        <!-- Input 3 - Birthdate -->
                        <div class="col-span-2 space-y-2">
                            <label class="block text-sm font-medium text-gray-700">Birthdate</label>
                            <input id="date" type="date" value="${profile.birthdate}" name="birthdate" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200 bg-white shadow-sm hover:shadow-md">
                        </div>

                        <!-- Input 4 - Gender -->
                        <div class="col-span-2 space-y-2">
                            <label class="block text-sm font-medium text-gray-700">Gender</label>
                            <select id="gender" name="gender" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200 bg-white shadow-sm hover:shadow-md">
                                <option value="" <c:if test="${empty profile.gender}">selected</c:if>>Select gender</option>
                                <option value="male" <c:if test="${profile.gender == 'male'}">selected</c:if>>Male</option>
                                <option value="female" <c:if test="${profile.gender == 'female'}">selected</c:if>>Female</option>
                                <option value="other" <c:if test="${profile.gender == 'other'}">selected</c:if>>Other</option>
                                </select>
                            </div>

                            <!-- Input 5 - Phone -->
                            <div class="col-span-4 space-y-2">
                                <label class="block text-sm font-medium text-gray-700">Phone Number</label>
                                <input id="phone" type="tel" name="phone" value="${profile.phone}" <c:if test="${not empty profile.phone}">disabled=""</c:if> class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200 bg-white shadow-sm hover:shadow-md" placeholder="Enter phone number">
                            </div>

                            <!-- Input 6 - Description -->
                            <div class="col-span-8 space-y-2">
                                <label class="block text-sm font-medium text-gray-700">Description</label>
                                <textarea id="bio" name="description" rows="4" value="${profile.description}" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200 bg-white shadow-sm hover:shadow-md resize-none" placeholder="Tell us about yourself...">${profile.description}</textarea>
                        </div>

                        <!-- Spacer for alignment -->
                        <!--<div class="col-span-8"></div>-->

                        <!-- Submit Button -->
                        <div class="col-span-8 mt-6">
                            <button id="submit" class="w-full bg-orange-500 text-white font-semibold py-3 px-6 rounded-lg hover:from-blue-700 hover:to-purple-700 transform hover:scale-[1.02] transition-all duration-200 shadow-lg hover:shadow-xl">
                                Update Profile
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
                            $(document).ready(function () {
                                const button = $('#submit');

                                button.on('click', function () {
                                    let firstname = $('#firstname').val().trim();
                                    let lastname = $('#lastname').val().trim();
                                    let date = $('#date').val();
                                    let gender = $('#gender').val();
                                    let phone = $('#phone').val().trim();
                                    let bio = $('#bio').val(); 

                                    if (!firstname) {
                                        showToast('First name is required.', 'error');
                                        return;
                                    }
                                    if (!lastname) {
                                        showToast('Last name is required.', 'error');
                                        return;
                                    }
                                    if (!date) {
                                        showToast('Birthdate is required.', 'error');
                                        return;
                                    }
                                    if (!gender) {
                                        showToast('Please select a gender.', 'error');
                                        return;
                                    }

                                    if (phone) {
                                        const vnPhoneRegex = /^0\d{9}$/;
                                        if (!vnPhoneRegex.test(phone)) {
                                            showToast('Invalid Vietnamese phone number. It should be 10 digits starting with 0.', 'error');
                                            return;
                                        }
                                    }

                                    $.ajax({
                                        url: '${pageContext.request.contextPath}/profile-edit',
                                        type: 'POST',
                                        data: {
                                            firstname: firstname,
                                            lastname: lastname,
                                            date: date,
                                            gender: gender,
                                            phone: phone,
                                            bio: bio
                                        },
                                        success: function (response) {
                                            if (response.ok) {
                                                showToast(response.message, 'success');
                                            } else {
                                                showToast(response.message, 'error');
                                            }
                                        },
                                        error: function () {
                                            showToast('An unexpected error occurred.', 'error');
                                        }
                                    });
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
