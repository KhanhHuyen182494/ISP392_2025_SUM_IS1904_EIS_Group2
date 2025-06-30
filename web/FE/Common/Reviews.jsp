<%-- 
    Document   : Reviews
    Created on : Jun 30, 2025, 11:07:24 AM
    Author     : Huyen
--%>

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

            <div class="main-reviews col-span-12">
                <!-- Filter Section -->
                <div class="bg-white rounded-2xl shadow-md p-6 mb-6">
                    <h2 class="text-2xl font-bold text-gray-800 mb-4">
                        <i class="fas fa-filter mr-2 text-orange-500"></i>
                        Filter Reviews
                    </h2>

                    <form action="${pageContext.request.contextPath}/review" method="GET" class="grid grid-cols-1 md:grid-cols-4 gap-4">
                        <!-- Keyword Search -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Search Keyword</label>
                            <input type="text" 
                                   name="keyword" 
                                   value="${keyword}"
                                   placeholder="Search in reviews..."
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent">
                        </div>

                        <!-- Star Rating Filter -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Star Rating</label>
                            <select name="star" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent">
                                <option value="">All Ratings</option>
                                <option value="5" ${param.star == '5' ? 'selected' : ''}>⭐⭐⭐⭐⭐ (5 Stars)</option>
                                <option value="4" ${param.star == '4' ? 'selected' : ''}>⭐⭐⭐⭐ (4 Stars)</option>
                                <option value="3" ${param.star == '3' ? 'selected' : ''}>⭐⭐⭐ (3 Stars)</option>
                                <option value="2" ${param.star == '2' ? 'selected' : ''}>⭐⭐ (2 Stars)</option>
                                <option value="1" ${param.star == '1' ? 'selected' : ''}>⭐ (1 Star)</option>
                            </select>
                        </div>

                        <!-- Room ID Filter -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Room ID</label>
                            <input type="text" 
                                   name="roomId" 
                                   value="${roomId}"
                                   placeholder="Enter Room ID..."
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent">
                        </div>

                        <!-- Date Filter -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Created From</label>
                            <input type="date" 
                                   name="createdFrom" 
                                   value="${joinDate}"
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent">
                        </div>

                        <!-- Filter Buttons -->
                        <div class="md:col-span-4 flex gap-3 pt-4">
                            <button type="submit" 
                                    class="bg-orange-500 hover:bg-orange-600 text-white px-6 py-2 rounded-lg font-medium transition-colors">
                                <i class="fas fa-search mr-2"></i>Apply Filters
                            </button>
                            <a href="${pageContext.request.contextPath}/review" 
                               class="bg-gray-500 hover:bg-gray-600 text-white px-6 py-2 rounded-lg font-medium transition-colors">
                                <i class="fas fa-times mr-2"></i>Clear Filters
                            </a>
                        </div>
                    </form>
                </div>

                <!-- Results Summary -->
                <div class="bg-white rounded-2xl shadow-md p-4 mb-6">
                    <div class="flex items-center justify-between">
                        <div class="text-gray-600">
                            <i class="fas fa-info-circle mr-2 text-blue-500"></i>
                            Showing <span class="font-semibold">${fn:length(rList)}</span> of <span class="font-semibold">${totalCount}</span> reviews
                        </div>
                        <div class="text-sm text-gray-500">
                            Page ${currentPage} of ${totalPages}
                        </div>
                    </div>
                </div>

                <!-- Reviews List -->
                <div class="space-y-6">
                    <c:forEach var="review" items="${rList}" varStatus="status">
                        <div class="bg-white rounded-2xl shadow-md hover:shadow-lg transition-shadow duration-300 overflow-hidden">
                            <div class="p-6">
                                <!-- Review Header -->
                                <div class="flex items-start justify-between mb-4">
                                    <div class="flex items-center gap-4">
                                        <!-- Reviewer Avatar -->
                                        <div class="w-12 h-12 rounded-full overflow-hidden bg-gray-200">
                                            <c:choose>
                                                <c:when test="${not empty review.owner.avatar}">
                                                    <img src="${pageContext.request.contextPath}/Asset/Common/Avatar/${review.owner.avatar}" 
                                                         alt="Avatar" class="w-full h-full object-cover">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="w-full h-full bg-gradient-to-br from-orange-400 to-orange-600 flex items-center justify-center text-white font-bold">
                                                        ${fn:substring(review.owner.first_name, 0, 1)}${fn:substring(review.owner.last_name, 0, 1)}
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <!-- Reviewer Info -->
                                        <div>
                                            <h3 class="font-semibold text-gray-800">
                                                ${review.owner.first_name} ${review.owner.last_name}
                                            </h3>
                                            <div class="flex items-center gap-2 text-sm text-gray-500">
                                                <span>Review ID: ${review.id}</span>
                                                <span>•</span>
                                                <span><fmt:formatDate value="${review.created_at}" pattern="dd/MM/yyyy HH:mm"/></span>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Star Rating -->
                                    <div class="flex items-center gap-2">
                                        <div class="flex">
                                            <c:forEach begin="1" end="5" var="i">
                                                <c:choose>
                                                    <c:when test="${i <= review.star}">
                                                        <i class="fas fa-star text-yellow-400"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="far fa-star text-gray-300"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </div>
                                        <span class="text-sm font-medium text-gray-600">(${review.star}/5)</span>
                                    </div>
                                </div>

                                <!-- Property Info -->
                                <div class="bg-gray-50 rounded-lg p-4 mb-4">
                                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 text-sm">
                                        <div>
                                            <span class="text-gray-500">Property:</span>
                                            <span class="font-medium ml-2">${review.homestay.name}</span>
                                        </div>
                                        <c:if test="${not empty review.room.name}">
                                            <div>
                                                <span class="text-gray-500">Room:</span>
                                                <span class="font-medium ml-2">${review.room.name}</span>
                                            </div>
                                        </c:if>
                                        <!--                                        <div>
                                                                                    <span class="text-gray-500">Status:</span>
                                                                                    <span class="inline-flex ml-2 px-2 py-1 rounded-full text-xs font-medium
                                        <c:choose>
                                            <c:when test="${review.status.id == 1}">bg-green-100 text-green-800</c:when>
                                            <c:when test="${review.status.id == 2}">bg-yellow-100 text-yellow-800</c:when>
                                            <c:otherwise>bg-red-100 text-red-800</c:otherwise>
                                        </c:choose>">
                                        ${review.status.name}
                                    </span>
                                </div>-->
                                    </div>
                                </div>

                                <!-- Review Content -->
                                <div class="mb-4">
                                    <h4 class="font-medium text-gray-800 mb-2">Review Content:</h4>
                                    <div class="bg-blue-50 rounded-lg p-4 border-l-4 border-blue-400">
                                        <p class="text-gray-700 leading-relaxed">${review.content}</p>
                                    </div>
                                </div>

                                <!-- Action Buttons -->
                                <div class="flex items-center justify-between pt-4 border-t border-gray-200">
                                    <div class="text-xs text-gray-500">
                                        <c:if test="${not empty review.updated_at}">
                                            Last updated: <fmt:formatDate value="${review.updated_at}" pattern="dd/MM/yyyy HH:mm"/>
                                        </c:if>
                                    </div>

                                    <div class="flex gap-2">
                                        <button class="text-blue-600 hover:text-blue-800 text-sm font-medium transition-colors">
                                            <i class="fas fa-eye mr-1"></i>View Details
                                        </button>
                                        <c:if test="${sessionScope.user.role.id == 1 || sessionScope.user.role.id == 3}">
                                            <button class="text-green-600 hover:text-green-800 text-sm font-medium transition-colors">
                                                <i class="fas fa-edit mr-1"></i>Edit
                                            </button>
                                            <button class="text-red-600 hover:text-red-800 text-sm font-medium transition-colors">
                                                <i class="fas fa-trash mr-1"></i>Delete
                                            </button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <!-- Empty State -->
                    <c:if test="${empty rList}">
                        <div class="bg-white rounded-2xl shadow-md p-12 text-center">
                            <i class="fas fa-comment-slash text-6xl text-gray-300 mb-4"></i>
                            <h3 class="text-xl font-semibold text-gray-600 mb-2">No Reviews Found</h3>
                            <p class="text-gray-500">Try adjusting your filters or search criteria.</p>
                        </div>
                    </c:if>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div class="mt-8 flex justify-center">
                        <nav class="flex items-center space-x-2">
                            <!-- Previous Button -->
                            <c:if test="${currentPage > 1}">
                                <a href="?page=${currentPage - 1}&keyword=${keyword}&star=${param.star}&roomId=${roomId}&createdFrom=${joinDate}" 
                                   class="px-4 py-2 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </c:if>

                            <!-- Page Numbers -->
                            <c:set var="startPage" value="${currentPage - 2 > 1 ? currentPage - 2 : 1}"/>
                            <c:set var="endPage" value="${startPage + 4 <= totalPages ? startPage + 4 : totalPages}"/>

                            <c:if test="${startPage > 1}">
                                <a href="?page=1&keyword=${keyword}&star=${param.star}&roomId=${roomId}&createdFrom=${joinDate}" 
                                   class="px-4 py-2 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors">1</a>
                                <c:if test="${startPage > 2}">
                                    <span class="px-2 py-2 text-gray-500">...</span>
                                </c:if>
                            </c:if>

                            <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                                <c:choose>
                                    <c:when test="${pageNum == currentPage}">
                                        <span class="px-4 py-2 bg-orange-500 text-white rounded-lg font-medium">${pageNum}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="?page=${pageNum}&keyword=${keyword}&star=${param.star}&roomId=${roomId}&createdFrom=${joinDate}" 
                                           class="px-4 py-2 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors">${pageNum}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${endPage < totalPages}">
                                <c:if test="${endPage < totalPages - 1}">
                                    <span class="px-2 py-2 text-gray-500">...</span>
                                </c:if>
                                <a href="?page=${totalPages}&keyword=${keyword}&star=${param.star}&roomId=${roomId}&createdFrom=${joinDate}" 
                                   class="px-4 py-2 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors">${totalPages}</a>
                            </c:if>

                            <!-- Next Button -->
                            <c:if test="${currentPage < totalPages}">
                                <a href="?page=${currentPage + 1}&keyword=${keyword}&star=${param.star}&roomId=${roomId}&createdFrom=${joinDate}" 
                                   class="px-4 py-2 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </c:if>
                        </nav>
                    </div>
                </c:if>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>

        </script>
    </body>
</html>