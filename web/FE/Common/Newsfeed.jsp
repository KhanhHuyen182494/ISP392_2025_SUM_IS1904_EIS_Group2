<%-- 
    Document   : Newsfeed
    Created on : May 24, 2025, 9:21:47 PM
    Author     : Huyen
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
            .feedback-badge {
                background: linear-gradient(45deg, #ff6b6b, #feca57);
            }
            .search-focus {
                transition: all 0.3s ease;
            }
            .search-focus:focus {
                transform: scale(1.02);
                box-shadow: 0 0 20px rgba(59, 130, 246, 0.3);
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
                            <img src="${pageContext.request.contextPath}/Asset/FUHF Logo/3.svg" width="30"/>
                        </div>

                        <!-- Search -->
                        <div class="relative">
                            <input 
                                type="text" 
                                placeholder="Search..." 
                                class="search-focus w-80 px-4 py-2 bg-gray-100 rounded-full border-none outline-none"
                                />
                            <i class="fas fa-search absolute right-4 top-2.5 text-gray-400"></i>
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

        <!-- Main Content -->
        <div class="max-w-7xl mx-auto px-4 py-8 grid grid-cols-12 gap-8">
            <!-- Sidebar - Top Feedback Section -->
            <div class="col-span-4">
                <div class="bg-white rounded-2xl shadow-lg p-6 sticky top-24">
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-xl font-bold text-gray-800">Top House/Room</h2>
                        <i class="fas fa-star text-yellow-500"></i>
                    </div>

                    <!-- Top Feedback Items -->
                    <div class="space-y-4">
                        <!-- Feedback items -->
                        <c:choose>
                            <c:when test="${not empty requestScope.topHouseRoom}">
                                <div class="flex items-start gap-3 p-3 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors cursor-pointer items-center">
                                    <div class="w-10 h-10 bg-gradient-to-r from-green-400 to-blue-500 rounded-full flex items-center justify-center flex-shrink-0">
                                        <i class="fas fa-user text-white text-sm"></i>
                                    </div>
                                    <div class="flex-1 min-w-0">
                                        <div class="flex items-center gap-2 mb-1">
                                            <span class="font-semibold text-sm text-gray-800">An Thu House - Phong 402</span>
                                            <div class="flex text-yellow-400">
                                                <i class="fas fa-star text-xs"></i>
                                                <i class="fas fa-star text-xs"></i>
                                                <i class="fas fa-star text-xs"></i>
                                                <i class="fas fa-star text-xs"></i>
                                                <i class="fas fa-star text-xs"></i>
                                            </div>
                                        </div>
                                        <p class="text-xs text-gray-600 line-clamp-2">104 Feedbacks</p>
                                        <span class="text-xs text-gray-400">2 days ago</span>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center p-2 mb-3">
                                    <p class="text-gray-500 decoration-wavy">No top house/room available!</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- View All Button -->
                    <button class="w-full mt-6 bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700 text-white py-2 rounded-lg text-sm font-medium transition-all">
                        View All Feedback
                    </button>
                </div>
            </div>

            <!-- Main Feed -->
            <div class="col-span-8">
                <!-- Feed Items -->
                <c:choose>
                    <c:when test="${not empty requestScope.posts}">
                        <c:forEach items="${requestScope.posts}" var="post">
                            <div class="bg-white rounded-2xl shadow-lg mb-8 overflow-hidden card-hover">
                                <!-- User Info -->
                                <div class="p-6 pb-4">
                                    <div class="flex items-center justify-between mb-4">
                                        <div class="flex items-center gap-3">
                                            <div class="w-12 h-12 bg-gray-200 rounded-full flex items-center justify-center">
                                                <i class="fas fa-user text-gray-400"></i>
                                            </div>
                                            <div>
                                                <h3 class="font-semibold text-gray-800">Khoai</h3>
                                                <p class="text-sm text-gray-500">Posted 2 hours ago</p>
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
                                    
                                    <!-- Property Title -->
                                    <h2 class="text-xl font-bold text-gray-800 mb-3">${post.house.name}</h2>

                                    <!-- Description -->
                                    <p class="text-gray-600 mb-4">
                                        ${post.house.description}
                                    </p>

                                    <!-- Property Details -->
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
                                            <span class="text-sm"><strong>Địa chỉ:</strong> Thôn 4, Thạch Hoà, Thạch Thất, Hà Nội</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Images -->
                                <div class="px-6 pb-4">
                                    <div class="grid grid-cols-2 gap-4">
                                        <div class="bg-gray-200 h-48 rounded-lg flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer">
                                            <i class="fas fa-image text-gray-400 text-2xl"></i>
                                        </div>
                                        <div class="bg-gray-200 h-48 rounded-lg flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer">
                                            <i class="fas fa-image text-gray-400 text-2xl"></i>
                                        </div>
                                    </div>
                                </div>

                                <!-- Action Bar -->
                                <div class="px-6 py-4 bg-gray-50 flex items-center justify-between">
                                    <div class="flex items-center gap-4">
                                        <button class="like-btn flex items-center gap-2 px-3 py-2 rounded-lg bg-white text-blue-500 border border-blue-500 hover:bg-blue-500 hover:text-white transition-colors" onclick="toggleLike(this)">
                                            <i class="fas fa-thumbs-up"></i>
                                            <span class="like-count">1</span>
                                        </button>
                                    </div>

                                    <div class="flex items-center gap-2">
                                        <div class="feedback-badge text-white px-3 py-1 rounded-full text-xs font-medium">
                                            4 feedbacks
                                        </div>
                                    </div>
                                </div>

                                <!-- Action Buttons -->
                                <div class="px-6 py-4 flex gap-3">
                                    <button class="flex-1 bg-orange-500 hover:bg-orange-600 text-white py-3 rounded-lg font-medium transition-colors">
                                        <i class="fas fa-key mr-2"></i>
                                        Rent
                                    </button>
                                    <button class="flex-1 bg-gray-200 hover:bg-gray-300 text-gray-700 py-3 rounded-lg font-medium transition-colors">
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

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
    </body>
</html>
