<%-- 
    Document   : Newsfeed
    Created on : May 24, 2025, 9:21:47 PM
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
        <title>Feeds</title>

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
            .review-badge {
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

            .review-item {
                transition: all 0.2s ease;
            }

            .review-item:hover {
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

            /* Comment Form Styles */
            .comment-form {
                background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            }

            .comment-input {
                transition: all 0.3s ease;
                resize: vertical;
                min-height: 60px;
            }

            .comment-input:focus {
                transform: scale(1.01);
                box-shadow: 0 0 20px rgba(59, 130, 246, 0.2);
            }

            .comment-submit-btn {
                transition: all 0.2s ease;
            }

            .comment-submit-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(59, 130, 246, 0.4);
            }

            .comment-submit-btn:disabled {
                opacity: 0.6;
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
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

        <!-- Main Content -->
        <div class="max-w-7xl mx-auto px-4 py-8 grid grid-cols-12 gap-8">
            <!-- Sidebar  -->
            <div class="col-span-12 sticky top-20 z-50">
                <div class="bg-white rounded-2xl shadow-md p-4 sticky top-24">
                    <div class="group-button">
                        <button class="flex-1 bg-yellow-400 hover:bg-yellow-500 px-2 py-1 text-white-700 rounded-lg font-medium transition-colors text-white">
                            <i class="fa-solid fa-star"></i>
                            Top House
                        </button>
                        <a href="${pageContext.request.contextPath}/house/available">
                            <button class="flex-1 bg-green-400 hover:bg-green-500 px-2 py-1 text-white-700 rounded-lg font-medium transition-colors text-white">
                                <i class="fa-solid fa-house"></i>
                                View Available House
                            </button>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Main Feed -->
            <div class="col-span-12">
                <!-- Feed Items -->
                <c:choose>
                    <c:when test="${not empty requestScope.posts}">
                        <c:forEach items="${requestScope.posts}" var="post" varStatus="postStatus">
                            <div class="bg-white rounded-2xl shadow-lg mb-8 overflow-hidden card-hover post-container" data-post-index="${postStatus.index}">
                                <!-- User Info -->
                                <div class="p-6 pb-4">
                                    <div class="flex items-center justify-between mb-4">
                                        <div class="flex items-center gap-3">
                                            <div class="w-12 h-12 rounded-full border-white overflow-hidden shadow-lg bg-white">
                                                <a href="${pageContext.request.contextPath}/profile?uid=${post.owner.id}">
                                                    <img class="w-full h-full object-cover" src="${pageContext.request.contextPath}/Asset/Common/Avatar/${post.owner.avatar}" />
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
                                    </div>

                                    <p class="text-lg mb-4">
                                        ${post.content}
                                    </p>

                                    <!-- Share/Repost Section -->
                                    <c:if test="${post.post_type.id == 5 and not empty post.parent_post}">
                                        <div class="bg-gray-50 rounded-lg p-4 mb-4 border-l-4 border-blue-500">
                                            <div class="flex items-center gap-3 mb-3">
                                                <div class="w-10 h-10 rounded-full overflow-hidden shadow-sm bg-white">
                                                    <a href="${pageContext.request.contextPath}/profile?uid=${post.parent_post.owner.id}">
                                                        <img class="w-full h-full object-cover" 
                                                             src="${pageContext.request.contextPath}/Asset/Common/Avatar/${post.parent_post.owner.avatar}" 
                                                             alt="Avatar" loading="lazy" />
                                                    </a>
                                                </div>
                                                <div>
                                                    <c:choose>
                                                        <c:when test="${sessionScope.user_id == post.parent_post.owner.id}">
                                                            <a href="${pageContext.request.contextPath}/profile?uid=${post.parent_post.owner.id}" 
                                                               class="font-medium text-gray-700 hover:text-blue-600">You</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="${pageContext.request.contextPath}/profile?uid=${post.parent_post.owner.id}" 
                                                               class="font-medium text-gray-700 hover:text-blue-600">
                                                                ${post.parent_post.owner.first_name} ${post.parent_post.owner.last_name}
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <p class="text-xs text-gray-500">
                                                        <fmt:formatDate value="${post.parent_post.created_at}" pattern="HH:mm dd/MM/yyyy" />
                                                    </p>
                                                </div>
                                            </div>
                                            <c:if test="${post.parent_post.post_type.id == 1}">
                                                <!-- Property Title -->
                                                <h2 class="text-xl font-bold text-gray-800 mb-3">${post.parent_post.house.name}</h2>

                                                <!-- Description -->
                                                <p class="text-gray-600 mb-4">
                                                    ${post.parent_post.house.description}
                                                </p>

                                                <!-- Property Details -->
                                                <div class="space-y-2 mb-4">
                                                    <div class="flex items-center gap-2">
                                                        <i class="fas fa-dollar-sign text-green-500"></i>
                                                        <span class="text-sm"><strong>Giá 1 đêm:</strong> <fmt:formatNumber value="${post.parent_post.house.price_per_night}" type="number" groupingUsed="true" maxFractionDigits="0" /> vnđ / đêm</span>
                                                    </div>
                                                    <div class="flex items-center gap-2">
                                                        <i class="fas fa-map-marker-alt text-red-500"></i>
                                                        <span class="text-sm"><strong>Địa chỉ:</strong> ${post.parent_post.house.address.detail} ${post.parent_post.house.address.ward}, ${post.parent_post.house.address.district}, ${post.parent_post.house.address.province}, ${post.parent_post.house.address.country}</span>
                                                    </div>
                                                </div>
                                            </c:if>

                                            <div class="px-6 pb-4">
                                                <div class="grid grid-cols-2 gap-4">
                                                    <!-- Calculate total images count for shared post -->
                                                    <c:set var="sharedPostMediaCount" value="${fn:length(post.parent_post.medias)}" />
                                                    <c:set var="sharedHouseMediaCount" value="${post.parent_post.post_type.id == 1 ? fn:length(post.parent_post.house.medias) : 0}" />
                                                    <c:set var="sharedTotalImages" value="${sharedPostMediaCount + sharedHouseMediaCount}" />
                                                    <c:set var="sharedMaxDisplay" value="4" />
                                                    <c:set var="sharedRemainingCount" value="${sharedTotalImages - sharedMaxDisplay}" />
                                                    <c:set var="sharedDisplayedCount" value="0" />

                                                    <!-- Display Shared Post Media Images -->
                                                    <c:forEach items="${post.parent_post.medias}" var="media" varStatus="status">
                                                        <c:if test="${sharedDisplayedCount < sharedMaxDisplay}">
                                                            <c:choose>
                                                                <c:when test="${sharedDisplayedCount == 3 && sharedTotalImages > sharedMaxDisplay}">
                                                                    <!-- Last image with overlay for remaining count -->
                                                                    <div class="bg-gray-200 h-96 rounded-[20px] flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer relative overflow-hidden"
                                                                         onclick="openImageCarousel(${sharedDisplayedCount}, this.closest('.post-container'))">
                                                                        <img class="rounded-[20px] h-96 w-full object-cover" 
                                                                             src="${pageContext.request.contextPath}/Asset/Common/Post/${media.path}"/>
                                                                        <!-- Overlay -->
                                                                        <div class="absolute inset-0 bg-black bg-opacity-60 rounded-[20px] flex items-center justify-center">
                                                                            <span class="text-white text-2xl font-bold">+${sharedRemainingCount}</span>
                                                                        </div>
                                                                    </div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <!-- Regular image -->
                                                                    <div class="bg-gray-200 h-96 rounded-[20px] flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer"
                                                                         onclick="openImageCarousel(${sharedDisplayedCount}, this.closest('.post-container'))">
                                                                        <img class="rounded-[20px] h-96 w-full object-cover" 
                                                                             src="${pageContext.request.contextPath}/Asset/Common/Post/${media.path}"/>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <c:set var="sharedDisplayedCount" value="${sharedDisplayedCount + 1}" />
                                                        </c:if>
                                                    </c:forEach>

                                                    <!-- Display Shared House Media Images -->
                                                    <c:if test="${post.parent_post.post_type.id == 1}">
                                                        <c:forEach items="${post.parent_post.house.medias}" var="mediaH" varStatus="status">
                                                            <c:if test="${sharedDisplayedCount < sharedMaxDisplay}">
                                                                <c:choose>
                                                                    <c:when test="${sharedDisplayedCount == 3 && sharedTotalImages > sharedMaxDisplay}">
                                                                        <!-- Last image with overlay for remaining count -->
                                                                        <div class="bg-gray-200 h-96 rounded-[20px] flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer relative overflow-hidden"
                                                                             onclick="openImageCarousel(${sharedDisplayedCount}, this.closest('.post-container'))">
                                                                            <img class="rounded-[20px] h-96 w-full object-cover" 
                                                                                 src="${pageContext.request.contextPath}/Asset/Common/House/${mediaH.path}"/>
                                                                            <!-- Overlay -->
                                                                            <div class="absolute inset-0 bg-black bg-opacity-60 rounded-[20px] flex items-center justify-center">
                                                                                <span class="text-white text-2xl font-bold">+${sharedRemainingCount}</span>
                                                                            </div>
                                                                        </div>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <!-- Regular image -->
                                                                        <div class="bg-gray-200 h-96 rounded-[20px] flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer"
                                                                             onclick="openImageCarousel(${sharedDisplayedCount}, this.closest('.post-container'))">
                                                                            <img class="rounded-[20px] h-96 w-full object-cover" 
                                                                                 src="${pageContext.request.contextPath}/Asset/Common/House/${mediaH.path}"/>
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <c:set var="sharedDisplayedCount" value="${sharedDisplayedCount + 1}" />
                                                            </c:if>
                                                        </c:forEach>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>

                                    <c:if test="${post.post_type.id == 1}">
                                        <!-- Property Title -->
                                        <h2 class="text-xl font-bold text-gray-800 mb-3">${post.house.name} ${not empty post.room.id ? ' - ' + post.room.id : ''}</h2>

                                        <!-- Description -->
                                        <p class="text-gray-600 mb-4">
                                            ${post.house.description}
                                        </p>

                                        <!-- Property Details -->
                                        <div class="space-y-2 mb-4">
                                            <div class="flex items-center gap-2">
                                                <i class="fas fa-dollar-sign text-green-500"></i>
                                                <span class="text-sm"><strong>Giá 1 đêm:</strong> <fmt:formatNumber value="${post.house.price_per_night}" type="number" groupingUsed="true" maxFractionDigits="0" /> vnđ / đêm</span>
                                            </div>
                                            <div class="flex items-center gap-2">
                                                <i class="fas fa-map-marker-alt text-red-500"></i>
                                                <span class="text-sm"><strong>Địa chỉ:</strong> ${post.house.address.detail} ${post.house.address.ward}, ${post.house.address.district}, ${post.house.address.province}, ${post.house.address.country}</span>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>

                                <!-- Images -->
                                <div class="px-6 pb-4">
                                    <div class="grid grid-cols-2 gap-4">
                                        <!-- Calculate total images count -->
                                        <c:set var="postMediaCount" value="${fn:length(post.medias)}" />
                                        <c:set var="houseMediaCount" value="${post.post_type.id == 1 ? fn:length(post.house.medias) : 0}" />
                                        <c:set var="totalImages" value="${postMediaCount + houseMediaCount}" />
                                        <c:set var="maxDisplay" value="4" />
                                        <c:set var="remainingCount" value="${totalImages - maxDisplay}" />

                                        <!-- Create a counter for displayed images -->
                                        <c:set var="displayedCount" value="0" />

                                        <!-- Display Post Media Images -->
                                        <c:forEach items="${post.medias}" var="media" varStatus="status">
                                            <c:if test="${displayedCount < maxDisplay}">
                                                <c:choose>
                                                    <c:when test="${displayedCount == 3 && totalImages > maxDisplay}">
                                                        <!-- Last image with overlay for remaining count -->
                                                        <div class="bg-gray-200 h-96 rounded-[20px] flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer relative overflow-hidden"
                                                             onclick="openImageCarousel(${displayedCount}, this.closest('.post-container'))">
                                                            <img class="rounded-[20px] h-96 w-full object-cover" 
                                                                 src="${pageContext.request.contextPath}/Asset/Common/Post/${media.path}"/>
                                                            <!-- Overlay -->
                                                            <div class="absolute inset-0 bg-black bg-opacity-60 rounded-[20px] flex items-center justify-center">
                                                                <span class="text-white text-2xl font-bold">+${remainingCount}</span>
                                                            </div>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <!-- Regular image -->
                                                        <div class="bg-gray-200 h-96 rounded-[20px] flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer"
                                                             onclick="openImageCarousel(${displayedCount}, this.closest('.post-container'))">
                                                            <img class="rounded-[20px] h-96 w-full object-cover" 
                                                                 src="${pageContext.request.contextPath}/Asset/Common/Post/${media.path}"/>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:set var="displayedCount" value="${displayedCount + 1}" />
                                            </c:if>
                                        </c:forEach>

                                        <!-- Display House Media Images (if post type is 1 and we haven't reached max display) -->
                                        <c:if test="${post.post_type.id == 1}">
                                            <c:forEach items="${post.house.medias}" var="mediaH" varStatus="status">
                                                <c:if test="${displayedCount < maxDisplay}">
                                                    <c:choose>
                                                        <c:when test="${displayedCount == 3 && totalImages > maxDisplay}">
                                                            <!-- Last image with overlay for remaining count -->
                                                            <div class="bg-gray-200 h-96 rounded-[20px] flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer relative overflow-hidden"
                                                                 onclick="openImageCarousel(${displayedCount}, this.closest('.post-container'))">
                                                                <img class="rounded-[20px] h-96 w-full object-cover" 
                                                                     src="${pageContext.request.contextPath}/Asset/Common/House/${mediaH.path}"/>
                                                                <!-- Overlay -->
                                                                <div class="absolute inset-0 bg-black bg-opacity-60 rounded-[20px] flex items-center justify-center">
                                                                    <span class="text-white text-2xl font-bold">+${remainingCount}</span>
                                                                </div>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <!-- Regular image -->
                                                            <div class="bg-gray-200 h-96 rounded-[20px] flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer"
                                                                 onclick="openImageCarousel(${displayedCount}, this.closest('.post-container'))">
                                                                <img class="rounded-[20px] h-96 w-full object-cover" 
                                                                     src="${pageContext.request.contextPath}/Asset/Common/House/${mediaH.path}"/>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <c:set var="displayedCount" value="${displayedCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                    </div>
                                </div>

                                <!-- Hidden divs to store image data for JavaScript - UNIQUE ID per post -->
                                <div id="imageDataContainer" style="display: none;">
                                    <!-- Include current post's images if it has any -->
                                    <c:forEach items="${post.medias}" var="media" varStatus="status">
                                        <div class="image-data" 
                                             data-path="${media.path}" 
                                             data-type="Post" 
                                             data-full-path="${pageContext.request.contextPath}/Asset/Common/Post/${media.path}">
                                        </div>
                                    </c:forEach>
                                    <!-- Include house images if this is a property post -->
                                    <c:if test="${post.post_type.id == 1}">
                                        <c:forEach items="${post.house.medias}" var="mediaH" varStatus="status">
                                            <div class="image-data" 
                                                 data-path="${mediaH.path}" 
                                                 data-type="House" 
                                                 data-full-path="${pageContext.request.contextPath}/Asset/Common/House/${mediaH.path}">
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                    <!-- If this is a shared post, also include the shared post's images -->
                                    <c:if test="${post.post_type.id == 5 and not empty post.parent_post}">
                                        <c:forEach items="${post.parent_post.medias}" var="sharedMedia" varStatus="status">
                                            <div class="image-data" 
                                                 data-path="${sharedMedia.path}" 
                                                 data-type="Post" 
                                                 data-full-path="${pageContext.request.contextPath}/Asset/Common/Post/${sharedMedia.path}">
                                            </div>
                                        </c:forEach>
                                        <c:if test="${post.parent_post.post_type.id == 1}">
                                            <c:forEach items="${post.parent_post.house.medias}" var="sharedMediaH" varStatus="status">
                                                <div class="image-data" 
                                                     data-path="${sharedMediaH.path}" 
                                                     data-type="House" 
                                                     data-full-path="${pageContext.request.contextPath}/Asset/Common/House/${sharedMediaH.path}">
                                                </div>
                                            </c:forEach>
                                        </c:if>
                                    </c:if>
                                </div>

                                <!-- Action Bar -->
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

                                    <c:if test="${post.post_type.id == 1}">
                                        <div class="flex items-center gap-2">
                                            <div class="review-badge text-white px-3 py-1 rounded-full text-xs font-medium">
                                                ${fn:length(post.reviews)} reviews
                                            </div>
                                        </div>
                                    </c:if>
                                </div>

                                <!-- Action Buttons -->
                                <c:if test="${post.post_type.id == 1}"> 
                                    <div class="px-6 py-4 flex gap-3">
                                        <button class="flex-1 bg-orange-500 hover:bg-orange-600 text-white py-3 rounded-lg font-medium transition-colors">
                                            <i class="fas fa-key mr-2"></i>
                                            Book
                                        </button>
                                        <button class="flex-1 bg-green-500 hover:bg-green-600 text-white-700 py-3 rounded-lg font-medium transition-colors text-white">
                                            <a href="${pageContext.request.contextPath}/owner-house/detail?hid=${post.house.id}">
                                                <i class="fa-solid fa-house text-white"></i>
                                                View Detail
                                            </a>
                                        </button>
                                        <button class="flex-1 bg-gray-200 hover:bg-gray-300 text-white-700 py-3 rounded-lg font-medium transition-colors view-review-btn" 
                                                data-house-id="${post.house.id}" 
                                                data-house-name="${post.house.name}">
                                            <i class="fas fa-comment mr-2"></i>
                                            View Review
                                        </button>
                                    </div>
                                </c:if>
                                <div class="px-6 py-4 gap-3 grid grid-cols-9">
                                    <button class="col-span-6 bg-blue-500 hover:bg-blue-600 text-white py-3 rounded-lg font-medium transition-colors"
                                            data-post-id="${post.id}">
                                        <i class="fas fa-comments mr-2"></i>
                                        Comment
                                    </button>
                                    <button class="col-span-3 bg-white-500 hover:bg-blue-500 hover:text-white border-[1px] border-blue-600 text-blue-600 py-3 rounded-lg font-medium transition-colors"
                                            data-post-share-id="${post.id}">
                                        <i class="fas fa-comments mr-2"></i>
                                        Share
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

        <!-- Review Modal -->
        <div id="reviewModal" class="fixed inset-0 z-50 modal-overlay">
            <div class="flex items-center justify-center min-h-screen px-4 py-8">
                <div class="modal-content bg-white rounded-2xl shadow-2xl max-w-4xl w-full max-h-[90vh] overflow-hidden">

                    <!-- Modal Header -->
                    <div class="bg-gradient-to-r from-blue-500 to-purple-600 px-6 py-4">
                        <div class="flex items-center justify-between">
                            <div class="flex gap-2 items-center">
                                <h2 class="text-xl font-bold text-[#FF7700]">Reviews</h2>
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
                        <div id="reviewLoading" class="text-center py-8">
                            <div class="loading-spinner mx-auto mb-4"></div>
                            <p class="text-gray-500">Loading reviews...</p>
                        </div>

                        <!-- Error State -->
                        <div id="reviewError" class="text-center py-8 hidden">
                            <i class="fas fa-exclamation-triangle text-red-500 text-3xl mb-4"></i>
                            <p class="text-red-500 font-medium">Failed to load reviews</p>
                            <button id="retryReview" class="mt-2 bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-lg transition-colors">
                                <i class="fas fa-redo mr-2"></i>
                                Retry
                            </button>
                        </div>

                        <!-- No Review State -->
                        <div id="noReview" class="text-center py-8 hidden">
                            <i class="fas fa-comment-slash text-gray-400 text-3xl mb-4"></i>
                            <p class="text-gray-500">No reviews available for this property</p>
                        </div>

                        <!-- Reviews Container -->
                        <div id="reviewContainer" class="space-y-4">
                            <!-- Dynamic review items will be inserted here -->
                        </div>

                        <!-- Load More Reviews -->
                        <div id="loadMoreReview" class="text-center mt-6 hidden">
                            <button id="loadMoreReviewBtn" class="bg-orange-500 hover:bg-orange-600 text-white px-6 py-2 rounded-lg transition-colors">
                                <i class="fas fa-chevron-down mr-2"></i>
                                Load More reviews
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Comment Modal -->
        <div id="commentModal" class="fixed inset-0 z-50 modal-overlay">
            <div class="flex items-center justify-center min-h-screen px-4 py-8">
                <div class="modal-content bg-white rounded-2xl shadow-2xl max-w-4xl w-full max-h-[90vh] overflow-hidden">

                    <!-- Modal Header -->
                    <div class="bg-gradient-to-r from-green-500 to-blue-600 px-6 py-4">
                        <div class="flex items-center justify-between">
                            <div class="flex gap-2 items-center">
                                <h2 class="text-xl font-bold">Comments</h2>
                                <p class=""> <b>-</b> </p>
                                <p id="modalCommentHouseName" class="text-orange-500 text-xl font-bold"></p>
                            </div>
                            <button id="closeCommentModalBtn" class="modal-close-btn w-10 h-10 rounded-full bg-red-500 bg-opacity-30 flex items-center justify-center hover:bg-opacity-30 transition-all">
                                <i class="fas fa-times text-lg text-white"></i>
                            </button>
                        </div>
                    </div>

                    <!-- Modal Body -->
                    <div class="p-6 overflow-y-auto max-h-[calc(90vh-200px)]">

                        <!-- Comment Form -->
                        <c:if test="${not empty sessionScope.user.id}">
                            <div class="comment-form rounded-xl p-4 mb-6 border-2 border-blue-100">
                                <div class="flex items-start gap-3">
                                    <div class="w-10 h-10 rounded-full bg-gradient-to-r from-blue-400 to-purple-500 flex items-center justify-center flex-shrink-0">
                                        <img class="w-10 h-10 rounded-full object-cover" src="${pageContext.request.contextPath}/Asset/Common/Avatar/${sessionScope.user.avatar}" 
                                             onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                                        <i class="fas fa-user text-white text-sm" style="display: none;"></i>
                                    </div>
                                    <div class="flex-1">
                                        <textarea id="commentInput" 
                                                  class="comment-input w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200" 
                                                  placeholder="Write your comment here..." 
                                                  rows="3"></textarea>
                                        <div class="flex justify-between items-center mt-3">
                                            <span class="text-xs text-gray-500">
                                                <i class="fas fa-info-circle mr-1"></i>
                                                Be respectful and constructive in your comments
                                            </span>
                                            <button id="submitCommentBtn" 
                                                    class="comment-submit-btn bg-blue-500 hover:bg-blue-600 text-white px-6 py-2 rounded-lg font-medium transition-all disabled:opacity-50 disabled:cursor-not-allowed">
                                                <i class="fas fa-paper-plane mr-2"></i>
                                                Post Comment
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <!-- Loading State -->
                        <div id="commentLoading" class="text-center py-8">
                            <div class="loading-spinner mx-auto mb-4"></div>
                            <p class="text-gray-500">Loading comments...</p>
                        </div>

                        <!-- Error State -->
                        <div id="commentError" class="text-center py-8 hidden">
                            <i class="fas fa-exclamation-triangle text-red-500 text-3xl mb-4"></i>
                            <p class="text-red-500 font-medium">Failed to load comments</p>
                            <button id="retryComment" class="mt-2 bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-lg transition-colors">
                                <i class="fas fa-redo mr-2"></i>
                                Retry
                            </button>
                        </div>

                        <!-- No Comment State -->
                        <div id="noComment" class="text-center py-8 hidden">
                            <i class="fas fa-comments text-gray-400 text-3xl mb-4"></i>
                            <p class="text-gray-500">No comments yet. Be the first to comment!</p>
                        </div>

                        <!-- Comments Container -->
                        <div id="commentContainer" class="space-y-4">
                            <!-- Dynamic comment items will be inserted here -->
                        </div>

                        <!-- Load More Comments -->
                        <div id="loadMoreComment" class="text-center mt-6 hidden">
                            <button id="loadMoreCommentBtn" class="bg-blue-500 hover:bg-blue-600 text-white px-6 py-2 rounded-lg transition-colors">
                                <i class="fas fa-chevron-down mr-2"></i>
                                Load More Comments
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
                                                        const modalReview = $('#reviewModal');
                                                        const modalHouseName = $('#modalHouseName');
                                                        const reviewContainer = $('#reviewContainer');
                                                        const loadingDiv = $('#reviewLoading');
                                                        const errorDiv = $('#reviewError');
                                                        const noReviewDiv = $('#noReview');
                                                        const loadMoreDiv = $('#loadMoreReview');
                                                        let currentHouseId = null;
                                                        let currentReviewPage = 1;
                                                        let isLoadingReview = false;
                                                        $('.view-review-btn').on('click', function () {
                                                            const houseId = $(this).data('house-id');
                                                            const houseName = $(this).data('house-name');
                                                            currentHouseId = houseId;
                                                            currentReviewPage = 1;
                                                            modalHouseName.text(houseName);
                                                            modalReview.addClass('active');
                                                            $('body').addClass('overflow-hidden');
                                                            loadReviews(houseId, 1, true);
                                                        });
                                                        // Close modal
                                                        $('#closeModalBtn').on('click', function (e) {
                                                            closeModal();
                                                        });
                                                        modalReview.on('click', function (e) {
                                                            if (e.target === this) {
                                                                closeModal();
                                                            }
                                                        });
                                                        modalReview.on('click', function (e) {
                                                            if (!$(e.target).closest('.modal-content').length) {
                                                                closeModal();
                                                            }
                                                        });
                                                        // Retry loading reviews
                                                        $('#retryReview').on('click', function () {
                                                            if (currentHouseId) {
                                                                loadReviews(currentHouseId, 1, true);
                                                            }
                                                        });
                                                        // Load more reviews
                                                        $('#loadMoreReviewBtn').on('click', function () {
                                                            if (currentHouseId && !isLoadingReview) {
                                                                loadReviews(currentHouseId, currentReviewPage + 1, false);
                                                            }
                                                        });
                                                        // ESC key to close modal
                                                        $(document).on('keydown', function (e) {
                                                            if (e.key === 'Escape' && modalReview.hasClass('active')) {
                                                                closeModal();
                                                            }
                                                        });
                                                        function closeModal() {
                                                            modalReview.removeClass('active');
                                                            $('body').removeClass('overflow-hidden');
                                                            // Reset modal state after animation
                                                            setTimeout(() => {
                                                                resetModalState();
                                                            }, 300);
                                                        }

                                                        function resetModalState() {
                                                            reviewContainer.empty();
                                                            loadingDiv.show();
                                                            errorDiv.addClass('hidden');
                                                            noReviewDiv.addClass('hidden');
                                                            loadMoreDiv.addClass('hidden');
                                                            currentHouseId = null;
                                                            currentReviewPage = 1;
                                                        }

                                                        function loadReviews(houseId, page, isNewLoad) {
                                                            if (isLoadingReview)
                                                                return;
                                                            isLoadingReview = true;
                                                            if (isNewLoad) {
                                                                //  S how loadi n g for new load
                                                                loadingDiv.show();
                                                                errorDiv.addClass('hidden');
                                                                noReviewDiv.addClass('hidden');
                                                                loadMoreDiv.addClass('hidden');
                                                                reviewContainer.empty();
                                                            } else {
                                                                // Show loading on load more button
                                                                $('#loadMoreReviewBtn').html('<div class="loading-spinner inline-block mr-2"></div>Loading...');
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
                                                                        reviewContainer.empty();
                                                                    }

                                                                    if (response.reviews && response.reviews.length > 0) {
                                                                        appendReviews(response.reviews);
                                                                        currentReviewPage = page;
                                                                        // Show load more if there are more reviews
                                                                        if (response.hasMore) {
                                                                            loadMoreDiv.removeClass('hidden');
                                                                        } else {
                                                                            loadMoreDiv.addClass('hidden');
                                                                        }

                                                                        errorDiv.addClass('hidden');
                                                                        noReviewDiv.addClass('hidden');
                                                                    } else if (isNewLoad) {
                                                                        // No reviews found
                                                                        noReviewDiv.removeClass('hidden');
                                                                        errorDiv.addClass('hidden');
                                                                        loadMoreDiv.addClass('hidden');
                                                                    }
                                                                },
                                                                error: function (xhr, status, error) {
                                                                    console.error('Error loading reviews:', error);
                                                                    loadingDiv.hide();
                                                                    if (isNewLoad) {
                                                                        errorDiv.removeClass('hidden');
                                                                        noReviewDiv.addClass('hidden');
                                                                    } else {
                                                                        // Show error toast for load more
                                                                        showToast('Failed to load more reviews', 'error');
                                                                    }
                                                                },
                                                                complete: function () {
                                                                    isLoadingReview = false;
                                                                    $('#loadMoreReviewBtn').html('<i class="fas fa-chevron-down mr-2"></i>Load More Reviews');
                                                                }
                                                            });
                                                        }

                                                        function appendReviews(reviews) {
                                                            reviews.forEach(function (review) {
                                                                const reviewHtml = createReviewHtml(review);
                                                                reviewContainer.append(reviewHtml);
                                                            });
                                                        }

                                                        function createReviewHtml(review) {
                                                            const stars = generateStarRating(review.Star);
                                                            return `
                                                        <div class="review-item p-4 border border-gray-200 rounded-xl bg-gray-50">
                                                            <div class="flex items-start gap-4">
                                                                <div class="w-12 h-12 bg-gradient-to-r from-blue-400 to-purple-500 rounded-full flex items-center justify-center flex-shrink-0">
                                                                    <img class="w-12 h-12 rounded-full object-cover" src=${pageContext.request.contextPath}/Asset/Common/Avatar/` + review.owner.avatar + ` 
                                                                         onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                                                                    <i class="fas fa-user text-white text-sm" style="display: none;"></i>
                                                                </div>
                                                                <div class="flex-1">
                                                                    <div class="flex items-center justify-between mb-2">
                                                                        <div class="flex items-center gap-3">
                                                                            <a href="${pageContext.request.contextPath}/profile?uid=` + review.owner.id + `" class="font-semibold text-gray-800">` + review.owner.first_name + ` ` + review.owner.last_name + `</a>
                                                                            <div class="star-rating flex">
                                                                                ` + stars + `
                                                                            </div>
                                                                        </div>
                                                                        <span class="text-xs text-gray-500">` + review.created_at + ` </span>
                                                                    </div>
                                                                    <p class="text-gray-700 text-sm leading-relaxed">` + review.content + `</p>
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

                                                        //Comment script section
                                                        const modalComment = $('#commentModal');
                                                        const modalCommentHouseName = $('#modalCommentHouseName');
                                                        const commentContainer = $('#commentContainer');
                                                        const commentLoadingDiv = $('#commentLoading');
                                                        const commentErrorDiv = $('#commentError');
                                                        const noCommentDiv = $('#noComment');
                                                        const loadMoreCommentDiv = $('#loadMoreComment');
                                                        const commentInput = $('#commentInput');
                                                        const submitCommentBtn = $('#submitCommentBtn');
                                                        let currentCommentPostId = null;
                                                        let currentCommentPage = 1;
                                                        let isLoadingComment = false;
                                                        let isSubmittingComment = false;
                                                        $('button:contains("Comment")').each(function () {
                                                            const postId = $(this).closest('.card-hover').find('button[data-post-id]').first().data('post-id');
                                                            $(this).attr('data-post-id', postId);
                                                        });
                                                        // Open Comment Modal
                                                        $(document).on('click', 'button:contains("Comment")', function () {
                                                            const postId = $(this).data('post-id');
                                                            const houseName = $(this).closest('.card-hover').find('h2').first().text().trim();
                                                            if (!postId) {
                                                                showToast('Unable to load comments', 'error');
                                                                return;
                                                            }

                                                            currentCommentPostId = postId;
                                                            currentCommentPage = 1;
                                                            modalCommentHouseName.text(houseName);
                                                            modalComment.addClass('active');
                                                            $('body').addClass('overflow-hidden');
                                                            loadComments(postId, 1, true);
                                                        });
                                                        // Close Comment Modal
                                                        $('#closeCommentModalBtn').on('click', function (e) {
                                                            closeCommentModal();
                                                        });
                                                        modalComment.on('click', function (e) {
                                                            if (e.target === this || !$(e.target).closest('.modal-content').length) {
                                                                closeCommentModal();
                                                            }
                                                        });
                                                        // Submit Comment
                                                        submitCommentBtn.on('click', function () {
                                                            submitComment();
                                                        });
                                                        // Submit comment on Enter (Ctrl+Enter)
                                                        commentInput.on('keydown', function (e) {
                                                            if (e.ctrlKey && e.key === 'Enter') {
                                                                e.preventDefault();
                                                                submitComment();
                                                            }
                                                        });
                                                        // Enable/disable submit button based on input
                                                        commentInput.on('input', function () {
                                                            const hasContent = $(this).val().trim().length > 0;
                                                            submitCommentBtn.prop('disabled', !hasContent || isSubmittingComment);
                                                        });
                                                        // Retry loading comments
                                                        $('#retryComment').on('click', function () {
                                                            if (currentCommentPostId) {
                                                                loadComments(currentCommentPostId, 1, true);
                                                            }
                                                        });
                                                        // Load more comments
                                                        $('#loadMoreCommentBtn').on('click', function () {
                                                            if (currentCommentPostId && !isLoadingComment) {
                                                                loadComments(currentCommentPostId, currentCommentPage + 1, false);
                                                            }
                                                        });
                                                        // ESC key to close comment modal
                                                        $(document).on('keydown', function (e) {
                                                            if (e.key === 'Escape' && modalComment.hasClass('active')) {
                                                                closeCommentModal();
                                                            }
                                                        });
                                                        function closeCommentModal() {
                                                            modalComment.removeClass('active');
                                                            $('body').removeClass('overflow-hidden');
                                                            // Reset modal state after animation
                                                            setTimeout(() => {
                                                                resetCommentModalState();
                                                            }, 300);
                                                        }

                                                        function resetCommentModalState() {
                                                            commentContainer.empty();
                                                            commentLoadingDiv.show();
                                                            commentErrorDiv.addClass('hidden');
                                                            noCommentDiv.addClass('hidden');
                                                            loadMoreCommentDiv.addClass('hidden');
                                                            commentInput.val('');
                                                            submitCommentBtn.prop('disabled', true);
                                                            currentCommentPostId = null;
                                                            currentCommentPage = 1;
                                                        }

                                                        function submitComment() {
                                                            const content = commentInput.val().trim();
                                                            const uid = '${sessionScope.user_id}';
                                                            if (!content) {
                                                                showToast('Please enter a comment', 'error');
                                                                return;
                                                            }

                                                            if (!uid) {
                                                                showToast('Please login to comment', 'error');
                                                                return;
                                                            }

                                                            if (isSubmittingComment)
                                                                return;
                                                            isSubmittingComment = true;
                                                            submitCommentBtn.prop('disabled', true);
                                                            submitCommentBtn.html('<div class="loading-spinner inline-block mr-2"></div>Posting...');
                                                            $.ajax({
                                                                url: '${pageContext.request.contextPath}/comment',
                                                                method: 'POST',
                                                                data: {
                                                                    postId: currentCommentPostId,
                                                                    content: content,
                                                                    type: "add"
                                                                },
                                                                success: function (response) {
                                                                    if (response.ok) {
                                                                        showToast(response.message ? response.message : 'Comment success!', 'success');
                                                                        commentInput.val('');
                                                                        // Add the new comment to the top of the list
                                                                        if (response.comment) {
                                                                            const newCommentHtml = createCommentHtml(response.comment);
                                                                            console.log(response.comment);
                                                                            commentContainer.prepend(newCommentHtml);
                                                                            noCommentDiv.addClass('hidden');
                                                                        } else {
                                                                            loadComments(currentCommentPostId, 1, true);
                                                                        }
                                                                    } else {
                                                                        showToast(response.message || 'Failed to post comment', 'error');
                                                                    }
                                                                },
                                                                error: function (xhr, status, error) {
                                                                    console.error('Error posting comment:', error);
                                                                    showToast('Failed to post comment. Please try again.', 'error');
                                                                },
                                                                complete: function () {
                                                                    isSubmittingComment = false;
                                                                    submitCommentBtn.prop('disabled', commentInput.val().trim().length === 0);
                                                                    submitCommentBtn.html('<i class="fas fa-paper-plane mr-2"></i>Post Comment');
                                                                }
                                                            });
                                                        }

                                                        function loadComments(postId, page, isNewLoad) {
                                                            if (isLoadingComment)
                                                                return;
                                                            isLoadingComment = true;
                                                            if (isNewLoad) {
                                                                // Show loading for new load
                                                                commentLoadingDiv.show();
                                                                commentErrorDiv.addClass('hidden');
                                                                noCommentDiv.addClass('hidden');
                                                                loadMoreCommentDiv.addClass('hidden');
                                                                commentContainer.empty();
                                                            } else {
                                                                // Show loading on load more button
                                                                $('#loadMoreCommentBtn').html('<div class="loading-spinner inline-block mr-2"></div>Loading...');
                                                            }

                                                            $.ajax({
                                                                url: '${pageContext.request.contextPath}/comment',
                                                                method: 'GET',
                                                                data: {
                                                                    postId: postId,
                                                                    page: page,
                                                                    limit: 10
                                                                },
                                                                success: function (response) {
                                                                    commentLoadingDiv.hide();
                                                                    if (isNewLoad) {
                                                                        commentContainer.empty();
                                                                    }

                                                                    if (response.comments && response.comments.length > 0) {
                                                                        appendComments(response.comments);
                                                                        currentCommentPage = page;
                                                                        // Show load more if there are more comments
                                                                        if (response.hasMore) {
                                                                            loadMoreCommentDiv.removeClass('hidden');
                                                                        } else {
                                                                            loadMoreCommentDiv.addClass('hidden');
                                                                        }

                                                                        commentErrorDiv.addClass('hidden');
                                                                        noCommentDiv.addClass('hidden');
                                                                    } else if (isNewLoad) {
                                                                        // No comments found
                                                                        noCommentDiv.removeClass('hidden');
                                                                        commentErrorDiv.addClass('hidden');
                                                                        loadMoreCommentDiv.addClass('hidden');
                                                                    }
                                                                },
                                                                error: function (xhr, status, error) {
                                                                    console.error('Error loading comments:', error);
                                                                    commentLoadingDiv.hide();
                                                                    if (isNewLoad) {
                                                                        commentErrorDiv.removeClass('hidden');
                                                                        noCommentDiv.addClass('hidden');
                                                                    } else {
                                                                        // Show error toast for load more
                                                                        showToast('Failed to load more comments', 'error');
                                                                    }
                                                                },
                                                                complete: function () {
                                                                    isLoadingComment = false;
                                                                    $('#loadMoreCommentBtn').html('<i class="fas fa-chevron-down mr-2"></i>Load More Comments');
                                                                }
                                                            });
                                                        }

                                                        function appendComments(comments) {
                                                            comments.forEach(function (comment) {
                                                                const commentHtml = createCommentHtml(comment);
                                                                commentContainer.append(commentHtml);
                                                            });
                                                        }

                                                        function createCommentHtml(comment) {
                                                            const isCurrentUser = comment.owner && comment.owner.id == '${sessionScope.user_id}';
                                                            const ownerName = comment.owner ? (comment.owner.first_name + ' ' + comment.owner.last_name) : 'Anonymous';
                                                            const ownerAvatar = comment.owner ? comment.owner.avatar : 'default.png';
                                                            const ownerId = comment.owner ? comment.owner.id : '';
                                                            let deleteButton = '';
                                                            if (isCurrentUser) {
                                                                deleteButton = '<button class="text-xs text-gray-500 hover:text-red-600 transition-colors" onclick="deleteComment(`' + comment.id + '`)">' +
                                                                        '<i class="fas fa-trash mr-1"></i>' +
                                                                        'Delete' +
                                                                        '</button>';
                                                            }

                                                            if (isCurrentUser) {
                                                                return `
                                                                <div class="comment-item p-4 border border-gray-200 rounded-xl bg-gray-50 hover:bg-gray-100 transition-colors" data-comment-id="` + comment.id + `">
                                                                    <div class="flex items-start gap-3">
                                                                        <div class="w-10 h-10 bg-gradient-to-r from-green-400 to-blue-500 rounded-full flex items-center justify-center flex-shrink-0">
                                                                            <img class="w-10 h-10 rounded-full object-cover" src="${pageContext.request.contextPath}/Asset/Common/Avatar/` + ownerAvatar + `" 
                                                                                 onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                                                                            <i class="fas fa-user text-white text-sm" style="display: none;"></i>
                                                                        </div>
                                                                        <div class="flex-1">
                                                                            <div class="flex items-center justify-between mb-2">
                                                                                <div class="flex items-center gap-2">
                                                                                    <a href="${pageContext.request.contextPath}/profile?uid=` + ownerId + `" 
                                                                                       class="font-semibold text-gray-800 hover:text-blue-600 transition-colors">
                                                                                        ` + ownerName + `
                                                                                    </a>
                                                                                 <span class="text-xs bg-blue-100 text-blue-600 px-2 py-1 rounded-full">You</span>
                                                                                </div>
                                                                                <span class="text-xs text-gray-500" title="` + comment.created_at + `">` + comment.created_at + `</span>
                                                                            </div>
                                                                            <p class="text-gray-700 text-sm leading-relaxed whitespace-pre-wrap">` + comment.content + `</p>

                                                                            <div class="flex items-center gap-3 mt-3">
                                                                                ` + deleteButton + `
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            `;
                                                            } else {
                                                                return `
                                                                <div class="comment-item p-4 border border-gray-200 rounded-xl bg-gray-50 hover:bg-gray-100 transition-colors" data-comment-id="` + comment.id + `">
                                                                    <div class="flex items-start gap-3">
                                                                        <div class="w-10 h-10 bg-gradient-to-r from-green-400 to-blue-500 rounded-full flex items-center justify-center flex-shrink-0">
                                                                            <img class="w-10 h-10 rounded-full object-cover" src="${pageContext.request.contextPath}/Asset/Common/Avatar/` + ownerAvatar + `" 
                                                                                 onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                                                                            <i class="fas fa-user text-white text-sm" style="display: none;"></i>
                                                                        </div>
                                                                        <div class="flex-1">
                                                                            <div class="flex items-center justify-between mb-2">
                                                                                <div class="flex items-center gap-2">
                                                                                    <a href="${pageContext.request.contextPath}/profile?uid=` + ownerId + `" 
                                                                                       class="font-semibold text-gray-800 hover:text-blue-600 transition-colors">
                                                                                        ` + ownerName + `
                                                                                    </a>
                                                                                </div>
                                                                                <span class="text-xs text-gray-500" title="` + comment.created_at + `">` + comment.created_at + `</span>
                                                                            </div>
                                                                            <p class="text-gray-700 text-sm leading-relaxed whitespace-pre-wrap">` + comment.content + `</p>

                                                                            <div class="flex items-center gap-3 mt-3">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            `;
                                                            }
                                                        }

                                                        // Global function for deleting comments
                                                        window.deleteComment = function (commentId) {
                                                            Swal.fire({
                                                                title: 'Delete comment ?',
                                                                html: 'This action can not be undo, please sure you have make decision!',
                                                                imageUrl: `${pageContext.request.contextPath}/Asset/FUHF Logo/3.svg`,
                                                                imageWidth: 150,
                                                                imageHeight: 150,
                                                                imageAlt: 'Custom icon',
                                                                showCancelButton: true,
                                                                confirmButtonText: 'Delete',
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
                                                                        url: '${pageContext.request.contextPath}/comment',
                                                                        method: 'POST',
                                                                        data: {commentId: commentId, type: "delete"},
                                                                        success: function (response) {
                                                                            if (response.ok) {
                                                                                showToast('Comment deleted successfully', 'success');
                                                                                // Remove the comment from the DOM
                                                                                $(`[data-comment-id="` + commentId + `"]`).fadeOut(300, function () {
                                                                                    $(this).remove();
                                                                                    // Show no comments message if container is empty
                                                                                    if (commentContainer.children().length === 0) {
                                                                                        noCommentDiv.removeClass('hidden');
                                                                                    }
                                                                                });
                                                                            } else {
                                                                                showToast(response.message || 'Failed to delete comment', 'error');
                                                                            }
                                                                        },
                                                                        error: function () {
                                                                            showToast('Failed to delete comment', 'error');
                                                                        }
                                                                    });
                                                                } else if (result.dismiss === Swal.DismissReason.cancel) {
                                                                    Swal.close();
                                                                }
                                                            });
                                                        };
                                                        $('button:contains("Share")').each(function () {
                                                            const postId = $(this).closest('.card-hover').find('button[data-post-share-id]').first().data('post-id');
                                                            $(this).attr('data-post-share-id', postId);
                                                        });
                                                        $(document).on('click', 'button:contains("Share")', function () {
                                                            let user = '${sessionScope.user_id}';
                                                            if (user.trim() === '') {
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
                                                            } else {
                                                                let sharePost = $(this).data('post-share-id');
                                                                Swal.fire({
                                                                    title: 'Wanna share this post?',
                                                                    html: 'Say something about this post or leave blank?',
                                                                    input: 'text',
                                                                    inputPlaceholder: 'Add a message...',
                                                                    imageUrl: `${pageContext.request.contextPath}/Asset/FUHF Logo/3.svg`,
                                                                    imageWidth: 150,
                                                                    imageHeight: 150,
                                                                    imageAlt: 'Custom icon',
                                                                    showCancelButton: true,
                                                                    confirmButtonText: 'Share',
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
                                                                        const inputValue = result.value;
                                                                        $.ajax({
                                                                            url: '${pageContext.request.contextPath}/post',
                                                                            type: 'POST',
                                                                            data: {
                                                                                typeWork: 'share',
                                                                                postId: sharePost,
                                                                                content: inputValue
                                                                            }
                                                                            , success: function (response) {
                                                                                if (response.ok) {
                                                                                    showToast(response.message);
                                                                                } else {
                                                                                    showToast(response.message, 'error');
                                                                                }
                                                                            }
                                                                        });
                                                                    } else if (result.dismiss === Swal.DismissReason.cancel) {
                                                                        Swal.close();
                                                                    }
                                                                });
                                                            }
                                                        });
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

                                                    // Store current post's images and slide index
                                                    let currentPostImages = [];
                                                    let currentSlideIndex = 0;

                                                    function getPostImagesData(postElement) {
                                                        const imageDataContainer = postElement.querySelector('#imageDataContainer');
                                                        if (!imageDataContainer)
                                                            return [];

                                                        const imageElements = imageDataContainer.querySelectorAll('.image-data');
                                                        const imagesData = [];

                                                        imageElements.forEach(element => {
                                                            imagesData.push({
                                                                path: element.getAttribute('data-path'),
                                                                type: element.getAttribute('data-type'),
                                                                fullPath: element.getAttribute('data-full-path')
                                                            });
                                                        });

                                                        return imagesData;
                                                    }

                                                    function openImageCarousel(clickedIndex, postElement) {
                                                        // Get images for this specific post
                                                        currentPostImages = getPostImagesData(postElement);

                                                        if (currentPostImages.length === 0)
                                                            return;

                                                        currentSlideIndex = clickedIndex;

                                                        // Create HTML for carousel
                                                        let carouselHtml = `
        <div class="image-carousel-container">
            <div class="carousel-wrapper">
                <button class="carousel-nav prev-btn" onclick="changeSlide(-1)" ` + (currentPostImages.length <= 1 ? 'style="display: none;"' : '') + `>‹</button>
                <div class="carousel-content">
                    <img id="carousel-image" src="` + currentPostImages[currentSlideIndex].fullPath + `" alt="Image">
                </div>
                <button class="carousel-nav next-btn" onclick="changeSlide(1)" ` + (currentPostImages.length <= 1 ? 'style="display: none;"' : '') + `>›</button>
            </div>
            <div class="carousel-indicators">
                <span id="image-counter">` + (currentSlideIndex + 1) + ` / ` + currentPostImages.length + `</span>
            </div>
        </div>
    `;

                                                        Swal.fire({
                                                            html: carouselHtml,
                                                            showCloseButton: true,
                                                            showConfirmButton: false,
                                                            width: '90%',
                                                            padding: '20px',
                                                            customClass: {
                                                                popup: 'carousel-popup'
                                                            },
                                                            didOpen: () => {
                                                                // Add CSS styles
                                                                const style = document.createElement('style');
                                                                style.textContent = `
                .carousel-popup {
                    background: rgba(0, 0, 0, 0.9) !important;
                }
                .image-carousel-container {
                    position: relative;
                    width: 100%;
                    height: 80vh;
                }
                .carousel-wrapper {
                    position: relative;
                    width: 100%;
                    height: 100%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }
                .carousel-content {
                    flex-grow: 1;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100%;
                }
                .carousel-content img {
                    max-width: 100%;
                    max-height: 100%;
                    object-fit: contain;
                    border-radius: 10px;
                }
                .carousel-nav {
                    position: absolute;
                    top: 50%;
                    transform: translateY(-50%);
                    background: rgba(255, 255, 255, 0.8);
                    border: none;
                    width: 50px;
                    height: 50px;
                    border-radius: 50%;
                    font-size: 24px;
                    cursor: pointer;
                    z-index: 1000;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    transition: background 0.3s;
                }
                .carousel-nav:hover {
                    background: rgba(255, 255, 255, 1);
                }
                .prev-btn {
                    left: 20px;
                }
                .next-btn {
                    right: 20px;
                }
                .carousel-indicators {
                    position: absolute;
                    bottom: 20px;
                    left: 50%;
                    transform: translateX(-50%);
                    background: rgba(0, 0, 0, 0.7);
                    color: white;
                    padding: 10px 20px;
                    border-radius: 20px;
                    font-size: 14px;
                }
            `;
                                                                document.head.appendChild(style);
                                                            }
                                                        });
                                                    }

                                                    function changeSlide(direction) {
                                                        if (currentPostImages.length <= 1)
                                                            return;

                                                        currentSlideIndex += direction;

                                                        // Loop around
                                                        if (currentSlideIndex >= currentPostImages.length) {
                                                            currentSlideIndex = 0;
                                                        } else if (currentSlideIndex < 0) {
                                                            currentSlideIndex = currentPostImages.length - 1;
                                                        }

                                                        // Update image and counter
                                                        const carouselImage = document.getElementById('carousel-image');
                                                        const imageCounter = document.getElementById('image-counter');

                                                        if (carouselImage && imageCounter) {
                                                            carouselImage.src = currentPostImages[currentSlideIndex].fullPath;
                                                            imageCounter.textContent = currentSlideIndex + 1 + ` / ` + currentPostImages.length;
                                                        }
                                                    }

                                                    function showImageModal(imageSrc, type, postElement) {
                                                        // Get images for this specific post
                                                        const postImages = getPostImagesData(postElement);

                                                        // Find the index of the clicked image
                                                        const clickedIndex = postImages.findIndex(img =>
                                                            img.path === imageSrc && img.type === type
                                                        );

                                                        if (clickedIndex !== -1) {
                                                            openImageCarousel(clickedIndex, postElement);
                                                        }
                                                    }
        </script>
    </body>
</html>