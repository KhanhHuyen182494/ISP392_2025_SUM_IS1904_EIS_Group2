<%-- 
    Document   : Profile
    Created on : May 31, 2025, 8:30:33 PM
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
        <title>Profile</title>

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
                            <input 
                                type="text" 
                                placeholder="Search..." 
                                class="search-focus w-80 px-4 py-2 bg-gray-100 rounded-full border-none outline-none"
                                />
                            <i class="icon-search-focus fas fa-search absolute right-4 top-2.5 text-gray-400"></i>
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
                                <div class="name">
                                    <p><b>${sessionScope.user.first_name} ${sessionScope.user.last_name}</b></p>
                                </div>
                                <a href="${pageContext.request.contextPath}/profile">
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
                        <!--<a href="${pageContext.request.contextPath}/change-password">-->
                        <button class="bg-red-400 hover:bg-red-500 text-white px-6 py-2 rounded-lg transition-colors flex items-center gap-2" onclick="showChangePassword()" >
                            <i class="fa-solid fa-lock"></i>
                            Change Password
                        </button>
                        <!--</a>-->
                        <button class="bg-green-500 hover:bg-green-600 text-white px-6 py-2 rounded-lg transition-colors flex items-center gap-2">
                            <i class="fas fa-plus"></i>
                            Add Post
                        </button>
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

        <!-- Main Content -->
        <div class="max-w-7xl mx-auto px-4 py-8 grid grid-cols-12 gap-8">
            <!-- Sidebar - Infomation Section -->
            <div class="col-span-4">
                <div class="bg-white rounded-2xl shadow-md p-6 sticky top-24">
                    <div class="flex items-center mb-6">
                        <h2 class="text-center text-xl font-bold text-gray-800">About me</h2>
                    </div>

                    <div class="space-y-4">
                        <p>BOD: ${not empty requestScope.profile.birthdate ? requestScope.profile.birthdate : 'Nothing here!'}</p>
                        <p>Gender: ${not empty requestScope.profile.gender ? requestScope.profile.gender : 'Nothing here!'}</p></p>
                        <p>Email: ${not empty requestScope.profile.email ? requestScope.profile.email : 'Nothing here!'}</p></p>
                    </div>
                </div>
            </div>

            <div class="col-span-8">
                <c:choose>
                    <c:when test="${not empty requestScope.posts}">
                        <c:forEach items="${requestScope.posts}" var="post">
                            <div class="bg-white rounded-2xl shadow-lg mb-8 overflow-hidden card-hover">
                                <div class="p-6 pb-4">
                                    <div class="flex items-center justify-between mb-4">
                                        <div class="flex items-center gap-3">
                                            <div class="w-12 h-12 bg-gray-200 rounded-full flex items-center justify-center">
                                                <a href="${pageContext.request.contextPath}/profile?uid=${post.owner.id}">
                                                    <img class="rounded-[50%]" src="${post.owner.avatar}" />
                                                </a>
                                            </div>
                                            <div>
                                                <c:choose>
                                                    <c:when test="${sessionScope.user_id == post.owner.id}">
                                                        <a href="${pageContext.request.contextPath}/profile?uid=${post.owner.id}"><h3 class="font-semibold text-gray-800">Posted by You</h3></a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="${pageContext.request.contextPath}/profile?uid=${post.owner.id}"><h3 class="font-semibold text-gray-800">${post.owner.first_name} ${post.owner.last_name}</h3></a>
                                                    </c:otherwise>
                                                </c:choose>
                                                <p class="text-sm text-gray-500">Posted on <fmt:formatDate value="${post.created_at}" pattern="HH:mm dd/MM/yyyy" /></p>
                                            </div>
                                        </div>
                                        <div class="flex gap-2">
                                            <span class="tag-hover bg-gray-100 text-gray-600 px-3 py-1 rounded-full text-xs cursor-pointer">Tag</span>
                                            <span class="tag-hover bg-gray-100 text-gray-600 px-3 py-1 rounded-full text-xs cursor-pointer">Tag</span>
                                            <span class="tag-hover bg-gray-100 text-gray-600 px-3 py-1 rounded-full text-xs cursor-pointer">Tag</span>
                                            <span class="tag-hover bg-gray-100 text-gray-600 px-3 py-1 rounded-full text-xs cursor-pointer">Tag</span>
                                        </div>
                                    </div>

                                    <p class="text-lg mb-4">
                                        ${post.content}
                                    </p>

                                    <h2 class="text-xl font-bold text-gray-800 mb-3">${post.house.name} ${not empty post.room.id ? ' - ' + post.room.id : ''}</h2>

                                    <p class="text-gray-600 mb-4">
                                        ${post.house.description}
                                    </p>

                                    <div class="space-y-2 mb-4">
                                        <div class="flex items-center gap-2">
                                            <i class="fas fa-dollar-sign text-green-500"></i>
                                            <span class="text-sm"><strong>Giá thuê:</strong> <fmt:formatNumber value="${post.house.price_per_month}" type="number" groupingUsed="true" maxFractionDigits="0" /> vnđ / tháng</span>
                                        </div>
                                        <div class="flex items-center gap-2">
                                            <i class="fas fa-bolt text-yellow-500"></i>
                                            <span class="text-sm"><strong>Tiền điện:</strong> <fmt:formatNumber value="${post.house.electricity_price}" type="number" groupingUsed="true" maxFractionDigits="0" /> vnđ / số</span>
                                        </div>
                                        <div class="flex items-center gap-2">
                                            <i class="fas fa-tint text-blue-500"></i>
                                            <span class="text-sm"><strong>Tiền nước:</strong> <fmt:formatNumber value="${post.house.water_price}" type="number" groupingUsed="true" maxFractionDigits="0" /> vnđ / khối</span>
                                        </div>
                                        <div class="flex items-center gap-2">
                                            <i class="fa-solid fa-money-bill-1-wave text-green-500"></i>
                                            <span class="text-sm"><strong>Tiền cọc:</strong> <fmt:formatNumber value="${post.house.down_payment}" type="number" groupingUsed="true" maxFractionDigits="0" /> vnđ</span>
                                        </div>
                                        <div class="flex items-center gap-2">
                                            <i class="fas fa-map-marker-alt text-red-500"></i>
                                            <span class="text-sm"><strong>Địa chỉ:</strong> ${post.house.address.detail} ${post.house.address.ward}, ${post.house.address.district}, ${post.house.address.province}, ${post.house.address.country}</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="px-6 pb-4">
                                    <div class="grid grid-cols-2 gap-4">
                                        <c:forEach items="${post.images}" var="image">
                                            <div class="bg-gray-200 h-48 rounded-[20px] flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer">
                                                <img class="rounded-[20px] h-48 w-full object-cover" src="${image.path}" onclick="showImageModal('${image.path}')"/>
                                            </div>
                                        </c:forEach> 
                                    </div>
                                </div>


                                <div class="px-6 py-4 flex items-center justify-between">
                                    <div class="flex items-center gap-4">
                                        <button data-post-id="${post.id}" 
                                                class="like-btn ${post.likedByCurrentUser ? 'liked' : ''} flex items-center gap-2 px-3 py-2 rounded-lg bg-white text-blue-500 border border-blue-500 hover:bg-blue-500 hover:text-white transition-colors" 
                                                onclick="toggleLike(this)"
                                                style="${post.likedByCurrentUser ? 'background-color: #3b82f6; color: white;' : ''}">
                                            <i class="fas fa-thumbs-up"></i>
                                            <span class="like-count">${fn:length(post.likes)}</span>
                                        </button>


                                    </div>

                                    <div class="flex items-center gap-2">
                                        <div class="feedback-badge text-white px-3 py-1 rounded-full text-xs font-medium">
                                            ${fn:length(post.feedbacks)} feedbacks
                                        </div>
                                    </div>
                                </div>

                                <div class="px-6 py-4 flex gap-3">
                                    <button class="flex-1 bg-orange-500 hover:bg-orange-600 text-white py-3 rounded-lg font-medium transition-colors">
                                        <i class="fas fa-key mr-2"></i>
                                        Rent
                                    </button>
                                    <button class="flex-1 bg-green-500 hover:bg-green-600 text-gray-700 py-3 rounded-lg font-medium transition-colors text-white">
                                        <i class="fa-solid fa-house text-white"></i>
                                        View Detail
                                    </button>
                                    <button class="flex-1 bg-gray-200 hover:bg-gray-300 text-gray-700 py-3 rounded-lg font-medium transition-colors view-feedback-btn" 
                                            data-house-id="${post.house.id}" 
                                            data-house-name="${post.house.name}">
                                        <i class="fas fa-comments mr-2"></i>
                                        View Feedback
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center p-2 mb-3">
                            <p class="text-gray-500 decoration-wavy">No post available right now!</p>
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- Load More Button -->
                <c:choose>
                    <c:when test="${not empty requestScope.posts}">
                        <div class="text-center">
                            <button class="bg-gray-400 hover:bg-gray-500 text-white px-8 py-3 rounded-full font-medium transition-all transform hover:scale-105">
                                <i class="fas fa-plus mr-2"></i>
                                Load More Posts
                            </button>
                        </div>
                    </c:when>
                </c:choose>
            </div>
        </div>

        <!-- Feedback Modal -->
        <div id="feedbackModal" class="fixed inset-0 z-50 modal-overlay">
            <div class="flex items-center justify-center min-h-screen px-4 py-8">
                <div class="modal-content bg-white rounded-2xl shadow-2xl max-w-4xl w-full max-h-[90vh] overflow-hidden">

                    <!-- Modal Header -->
                    <div class="bg-gradient-to-r from-blue-500 to-purple-600 px-6 py-4">
                        <div class="flex items-center justify-between">
                            <div class="flex gap-2 items-center">
                                <h2 class="text-xl font-bold text-[#FF7700]">Feedbacks</h2>
                                <p> <b>-</b> </p>
                                <p id="modalHouseName" class="text-blue-500 text-xl font-bold"></p>
                            </div>
                            <button id="closeModalBtn" class="modal-close-btn w-10 h-10 rounded-full bg-red-500 bg-opacity-30 flex items-center justify-center hover:bg-opacity-30 transition-all">
                                <i class="fas fa-times text-lg text-white"></i>
                            </button>
                        </div>
                    </div>

                    <!-- Modal Body -->
                    <div class="p-6 overflow-y-auto max-h-[calc(90vh-120px)]">

                        <!-- Loading State -->
                        <div id="feedbackLoading" class="text-center py-8">
                            <div class="loading-spinner mx-auto mb-4"></div>
                            <p class="text-gray-500">Loading feedbacks...</p>
                        </div>

                        <!-- Error State -->
                        <div id="feedbackError" class="text-center py-8 hidden">
                            <i class="fas fa-exclamation-triangle text-red-500 text-3xl mb-4"></i>
                            <p class="text-red-500 font-medium">Failed to load feedbacks</p>
                            <button id="retryFeedback" class="mt-2 bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-lg transition-colors">
                                <i class="fas fa-redo mr-2"></i>
                                Retry
                            </button>
                        </div>

                        <!-- No Feedback State -->
                        <div id="noFeedback" class="text-center py-8 hidden">
                            <i class="fas fa-comment-slash text-gray-400 text-3xl mb-4"></i>
                            <p class="text-gray-500">No feedbacks available for this property</p>
                        </div>

                        <!-- Feedbacks Container -->
                        <div id="feedbackContainer" class="space-y-4">
                            <!-- Dynamic feedback items will be inserted here -->
                        </div>

                        <!-- Load More Feedbacks -->
                        <div id="loadMoreFeedback" class="text-center mt-6 hidden">
                            <button id="loadMoreFeedbackBtn" class="bg-orange-500 hover:bg-orange-600 text-white px-6 py-2 rounded-lg transition-colors">
                                <i class="fas fa-chevron-down mr-2"></i>
                                Load More Feedbacks
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
                                                    function toggleLike(button) {
                                                        const uid = '${sessionScope.user_id}';

                                                        if (uid || uid.trim()) {
                                                            const likeCount = button.querySelector('.like-count');
                                                            const currentCount = parseInt(likeCount.textContent);
                                                            const pid = $(button).data('post-id');

                                                            if (button.classList.contains('liked')) {
                                                                // Unlike
                                                                button.classList.remove('liked');
                                                                likeCount.textContent = currentCount - 1;
                                                                button.style.backgroundColor = 'white';
                                                                button.style.color = '#3b82f6';
                                                                sendLikeRequest(pid, 'unLike');
                                                            } else {
                                                                // Like
                                                                button.classList.add('liked');
                                                                likeCount.textContent = currentCount + 1;
                                                                button.style.backgroundColor = '#3b82f6';
                                                                button.style.color = 'white';
                                                                sendLikeRequest(pid, 'like');
                                                            }
                                                        } else {
                                                            Swal.fire({
                                                                title: 'You must login to use this feature',
                                                                imageUrl: `${pageContext.request.contextPath}/Asset/FUHF Logo/3.svg`,
                                                                imageWidth: 150,
                                                                imageHeight: 150,
                                                                imageAlt: 'Custom icon',
                                                                showCancelButton: true,
                                                                confirmButtonText: 'Login now',
                                                                cancelButtonText: 'Back to Newsfeed',
                                                                reverseButtons: true,
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
                                                                    location.href = '${pageContext.request.contextPath}/login';
                                                                } else if (result.dismiss === Swal.DismissReason.cancel) {
                                                                    Swal.close();
                                                                }
                                                            });
                                                        }
                                                    }

                                                    function sendLikeRequest(postId, type) {
                                                        $.ajax({
                                                            url: '${pageContext.request.contextPath}/feeds',
                                                            type: 'POST',
                                                            data: {
                                                                pid: postId,
                                                                type: type
                                                            }
                                                        });
                                                    }

                                                    $(document).ready(function () {
                                                        const modal = $('#feedbackModal');
                                                        const modalHouseName = $('#modalHouseName');
                                                        const feedbackContainer = $('#feedbackContainer');
                                                        const loadingDiv = $('#feedbackLoading');
                                                        const errorDiv = $('#feedbackError');
                                                        const noFeedbackDiv = $('#noFeedback');
                                                        const loadMoreDiv = $('#loadMoreFeedback');

                                                        let currentHouseId = null;
                                                        let currentPage = 1;
                                                        let isLoading = false;

                                                        $('.view-feedback-btn').on('click', function () {
                                                            const houseId = $(this).data('house-id');
                                                            const houseName = $(this).data('house-name');

                                                            currentHouseId = houseId;
                                                            currentPage = 1;

                                                            modalHouseName.text(houseName);
                                                            modal.addClass('active');
                                                            $('body').addClass('overflow-hidden');

                                                            loadFeedbacks(houseId, 1, true);
                                                        });

                                                        // Close modal
                                                        $('#closeModalBtn').on('click', function (e) {
                                                            closeModal();

                                                        });

                                                        modal.on('click', function (e) {
                                                            if (e.target === this) {
                                                                closeModal();
                                                            }
                                                        });

                                                        modal.on('click', function (e) {
                                                            if (!$(e.target).closest('.modal-content').length) {
                                                                closeModal();
                                                            }
                                                        });

                                                        // Retry loading feedbacks
                                                        $('#retryFeedback').on('click', function () {
                                                            if (currentHouseId) {
                                                                loadFeedbacks(currentHouseId, 1, true);
                                                            }
                                                        });

                                                        // Load more feedbacks
                                                        $('#loadMoreFeedbackBtn').on('click', function () {
                                                            if (currentHouseId && !isLoading) {
                                                                loadFeedbacks(currentHouseId, currentPage + 1, false);
                                                            }
                                                        });

                                                        // ESC key to close modal
                                                        $(document).on('keydown', function (e) {
                                                            if (e.key === 'Escape' && modal.hasClass('active')) {
                                                                closeModal();
                                                            }
                                                        });

                                                        function closeModal() {
                                                            modal.removeClass('active');
                                                            $('body').removeClass('overflow-hidden');
                                                            // Reset modal state after animation
                                                            setTimeout(() => {
                                                                resetModalState();
                                                            }, 300);
                                                        }

                                                        function resetModalState() {
                                                            feedbackContainer.empty();
                                                            loadingDiv.show();
                                                            errorDiv.addClass('hidden');
                                                            noFeedbackDiv.addClass('hidden');
                                                            loadMoreDiv.addClass('hidden');
                                                            currentHouseId = null;
                                                            currentPage = 1;
                                                        }

                                                        function loadFeedbacks(houseId, page, isNewLoad) {
                                                            if (isLoading)
                                                                return;

                                                            isLoading = true;

                                                            if (isNewLoad) {
                                                                // Show loading for new load
                                                                loadingDiv.show();
                                                                errorDiv.addClass('hidden');
                                                                noFeedbackDiv.addClass('hidden');
                                                                loadMoreDiv.addClass('hidden');
                                                                feedbackContainer.empty();
                                                            } else {
                                                                // Show loading on load more button
                                                                $('#loadMoreFeedbackBtn').html('<div class="loading-spinner inline-block mr-2"></div>Loading...');
                                                            }

                                                            $.ajax({
                                                                url: '${pageContext.request.contextPath}/feedback/house',
                                                                method: 'GET',
                                                                data: {
                                                                    houseId: houseId,
                                                                    page: page,
                                                                    limit: 5
                                                                },
                                                                success: function (response) {
                                                                    loadingDiv.hide();

                                                                    if (isNewLoad) {
                                                                        feedbackContainer.empty();
                                                                    }

                                                                    if (response.feedbacks && response.feedbacks.length > 0) {
                                                                        appendFeedbacks(response.feedbacks);
                                                                        currentPage = page;

                                                                        // Show load more if there are more feedbacks
                                                                        if (response.hasMore) {
                                                                            loadMoreDiv.removeClass('hidden');
                                                                        } else {
                                                                            loadMoreDiv.addClass('hidden');
                                                                        }

                                                                        errorDiv.addClass('hidden');
                                                                        noFeedbackDiv.addClass('hidden');
                                                                    } else if (isNewLoad) {
                                                                        // No feedbacks found
                                                                        noFeedbackDiv.removeClass('hidden');
                                                                        errorDiv.addClass('hidden');
                                                                        loadMoreDiv.addClass('hidden');
                                                                    }
                                                                },
                                                                error: function (xhr, status, error) {
                                                                    console.error('Error loading feedbacks:', error);
                                                                    loadingDiv.hide();

                                                                    if (isNewLoad) {
                                                                        errorDiv.removeClass('hidden');
                                                                        noFeedbackDiv.addClass('hidden');
                                                                    } else {
                                                                        // Show error toast for load more
                                                                        showToast('Failed to load more feedbacks', 'error');
                                                                    }
                                                                },
                                                                complete: function () {
                                                                    isLoading = false;
                                                                    $('#loadMoreFeedbackBtn').html('<i class="fas fa-chevron-down mr-2"></i>Load More Feedbacks');
                                                                }
                                                            });
                                                        }

                                                        function appendFeedbacks(feedbacks) {
                                                            feedbacks.forEach(function (feedback) {
                                                                const feedbackHtml = createFeedbackHtml(feedback);
                                                                feedbackContainer.append(feedbackHtml);
                                                            });
                                                        }

                                                        function createFeedbackHtml(feedback) {
                                                            const stars = generateStarRating(feedback.star);

                                                            return `
                                                        <div class="feedback-item p-4 border border-gray-200 rounded-xl bg-gray-50">
                                                            <div class="flex items-start gap-4">
                                                                <div class="w-12 h-12 bg-gradient-to-r from-blue-400 to-purple-500 rounded-full flex items-center justify-center flex-shrink-0">
                                                                    <img class="w-12 h-12 rounded-full object-cover" src="` + feedback.user.avatar + `" 
                                                                         onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                                                                    <i class="fas fa-user text-white text-sm" style="display: none;"></i>
                                                                </div>
                                                                <div class="flex-1">
                                                                    <div class="flex items-center justify-between mb-2">
                                                                        <div class="flex items-center gap-3">
                                                                            <a href="${pageContext.request.contextPath}/profile?id=` + feedback.user.id + `" class="font-semibold text-gray-800">` + feedback.user.first_name + ` ` + feedback.user.last_name + `</a>
                                                                            <div class="star-rating flex">
                                                                                ` + stars + `
                                                                            </div>
                                                                        </div>
                                                                        <span class="text-xs text-gray-500">` + feedback.created_at + ` </span>
                                                                    </div>
                                                                    <p class="text-gray-700 text-sm leading-relaxed">` + feedback.content + `</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    `;
                                                        }

                                                        function generateStarRating(rating) {
                                                            let stars = '';
                                                            for (let i = 1; i <= 5; i++) {
                                                                if (i <= rating) {
                                                                    stars += '<i class="fas fa-star text-xs"></i>';
                                                                } else {
                                                                    stars += '<i class="far fa-star text-xs"></i>';
                                                                }
                                                            }
                                                            return stars;
                                                        }

                                                        function showToast(message, type = 'success') {
                                                            Toastify({
                                                                text: message,
                                                                duration: 3000,
                                                                gravity: "top",
                                                                position: "right",
                                                                backgroundColor: type === 'success' ? '#10B981' : '#EF4444',
                                                                stopOnFocus: true
                                                            }).showToast();
                                                        }


                                                    });

                                                    function showChangePassword() {
                                                        Swal.fire({
                                                            title: 'Caution',
                                                            html: 'We’ll send a email with a OTP code expired in <b><span class="text-red-500">5 mins</span></b> for you to change password! Do you want to continue change password?',
                                                            imageUrl: `${pageContext.request.contextPath}/Asset/FUHF Logo/3.svg`,
                                                            imageWidth: 150,
                                                            imageHeight: 150,
                                                            imageAlt: 'Custom icon',
                                                            showCancelButton: true,
                                                            confirmButtonText: 'Yes',
                                                            cancelButtonText: 'Cancel',
                                                            reverseButtons: true,
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
                                                                    url: '${pageContext.request.contextPath}/send-otp',
                                                                    type: 'GET',
                                                                    beforeSend: function (xhr) {
                                                                        showLoading();
                                                                    },
                                                                    success: function (response) {
                                                                        Swal.close();
                                                                        if (response.ok == true) {
                                                                            location.href = '${pageContext.request.contextPath}/get-verify-otp';
                                                                        }
                                                                    }
                                                                });
                                                            } else if (result.dismiss === Swal.DismissReason.cancel) {
                                                                Swal.close();
                                                            }
                                                        });
                                                    }

                                                    function showImageModal(imageSrc) {
                                                        Swal.fire({
                                                            imageUrl: imageSrc,
                                                            imageWidth: 'auto',
                                                            imageHeight: 'auto',
                                                            showCloseButton: false,
                                                            showConfirmButton: false,
                                                            customClass: {
                                                                image: 'rounded-lg p-5'
                                                            }
                                                        });
                                                    }

                                                    function showLoading() {
                                                        Swal.fire({
                                                            title: 'Sending OTP ...',
                                                            didOpen: () => {
                                                                Swal.showLoading();
                                                            },
                                                            allowOutsideClick: false,
                                                            showConfirmButton: false,
                                                            customClass: {
                                                                title: 'text-xl font-semibold'
                                                            }
                                                        });
                                                    }
        </script>
    </body>
</html>