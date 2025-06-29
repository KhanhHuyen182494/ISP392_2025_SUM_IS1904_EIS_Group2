<%-- 
    Document   : AvailableHouse
    Created on : Jun 30, 2025, 12:21:55 AM
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
        <title>Available House</title>

        <!-- Libs -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <link href="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            primary: {
                                50: '#eff6ff',
                                100: '#dbeafe',
                                500: '#3b82f6',
                                600: '#2563eb',
                                700: '#1d4ed8'
                            }
                        }
                    }
                }
            }
        </script>
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

        <div class="container mx-auto px-4 py-8 max-w-6xl">
            <div class="col-span-12 sticky top-20 z-50">
                <div class="bg-white rounded-2xl shadow-md p-4 sticky top-24">
                    <div class="group-button">
                        <button class="flex-1 bg-yellow-400 hover:bg-yellow-500 px-2 py-1 text-white-700 rounded-lg font-medium transition-colors text-white">
                            <i class="fa-solid fa-star"></i>
                            Top House
                        </button>
                        <a href="${pageContext.request.contextPath}/feeds">
                            <button class="flex-1 bg-blue-400 hover:bg-blue-500 px-2 py-1 text-white-700 rounded-lg font-medium transition-colors text-white">
                                <i class="fa-solid fa-house"></i>
                                Newsfeed
                            </button>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Page Title -->
            <div class="mb-8 mt-8">
                <h1 class="text-3xl font-bold text-gray-800 mb-2">Available Houses</h1>
                <p class="text-gray-600">Find your perfect home from our available listings</p>
            </div>

            <!-- Filters Section -->
            <div class="bg-white rounded-lg shadow-md p-6 mb-8">
                <form action="${pageContext.request.contextPath}/house/available" method="GET" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-6 gap-4">
                    <!-- Keyword Search -->
                    <div class="lg:col-span-2">
                        <label class="block text-sm font-medium text-gray-700 mb-2">Search</label>
                        <input 
                            type="text" 
                            name="keyword" 
                            value="${keyword}"
                            placeholder="Search houses..."
                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary-500"
                            />
                    </div>

                    <!-- Star Rating Filter -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Min Rating</label>
                        <select name="star" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary-500">
                            <option value="">Any Rating</option>
                            <option value="1" ${minStar == 1 ? 'selected' : ''}>1+ Stars</option>
                            <option value="2" ${minStar == 2 ? 'selected' : ''}>2+ Stars</option>
                            <option value="3" ${minStar == 3 ? 'selected' : ''}>3+ Stars</option>
                            <option value="4" ${minStar == 4 ? 'selected' : ''}>4+ Stars</option>
                            <option value="5" ${minStar == 5 ? 'selected' : ''}>5 Stars</option>
                        </select>
                    </div>

                    <!-- Price Range -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Min Price</label>
                        <input 
                            type="number" 
                            name="minPrice" 
                            value="${minPrice}"
                            placeholder="Min Price"
                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary-500"
                            />
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Max Price</label>
                        <input 
                            type="number" 
                            name="maxPrice" 
                            value="${maxPrice}"
                            placeholder="Max Price"
                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary-500"
                            />
                    </div>

                    <!-- Filter Buttons -->
                    <div class="lg:col-span-6 flex gap-3 pt-4">
                        <button type="submit" class="bg-orange-500 hover:bg-orange-600 text-white px-6 py-2 rounded-md font-medium transition-colors">
                            <i class="fas fa-filter mr-2"></i>Apply Filters
                        </button>
                        <a href="${pageContext.request.contextPath}/house/available" class="bg-gray-500 hover:bg-gray-600 text-white px-6 py-2 rounded-md font-medium transition-colors">
                            <i class="fas fa-times mr-2"></i>Clear Filters
                        </a>
                    </div>
                </form>
            </div>

            <!-- Results Summary -->
            <div class="flex justify-between items-center mb-6">
                <div class="text-gray-600">
                    <c:choose>
                        <c:when test="${not empty houseList}">
                            Showing ${(currentPage - 1) * limit + 1} - ${fn:length(houseList) + (currentPage - 1) * limit} of ${totalCount} houses
                        </c:when>
                        <c:otherwise>
                            No houses found
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="flex items-center gap-2">
                    <label class="text-sm text-gray-600">Show:</label>
                    <select onchange="changeLimit(this.value)" class="px-6 py-1 border border-gray-300 rounded-md text-sm">
                        <option value="10" ${limit == 10 ? 'selected' : ''}>10</option>
                        <option value="20" ${limit == 20 ? 'selected' : ''}>20</option>
                        <option value="50" ${limit == 50 ? 'selected' : ''}>50</option>
                    </select>
                </div>
            </div>

            <!-- Houses Grid -->
            <c:choose>
                <c:when test="${not empty houseList}">
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
                        <c:forEach var="house" items="${houseList}">
                            <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow">
                                <!-- House Image -->
                                <div class="relative h-48 bg-gray-200">
                                    <c:choose>
                                        <c:when test="${not empty house.medias}">
                                            <c:set var="firstImage" value="${house.medias[0]}" />
                                            <img src="${pageContext.request.contextPath}/Asset/Common/House/${firstImage.path}" 
                                                 alt="${house.name}" 
                                                 class="w-full h-full object-cover"/>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="w-full h-full flex items-center justify-center bg-gray-100">
                                                <i class="fas fa-home text-4xl text-gray-400"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>

                                    <!-- Status Badge -->
                                    <div class="absolute top-3 left-3">
                                        <c:choose>
                                            <c:when test="${house.status.id == 6}">
                                                <span class="bg-green-500 text-white px-2 py-1 rounded-full text-xs font-medium">${house.status.name}</span>
                                            </c:when>
                                            <c:when test="${house.status.id == 2}">
                                                <span class="bg-red-500 text-white px-2 py-1 rounded-full text-xs font-medium">${house.status.name}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="bg-yellow-500 text-white px-2 py-1 rounded-full text-xs font-medium">${house.status.name}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <!-- Star Rating -->
                                    <c:if test="${not empty house.star}">
                                        <div class="absolute top-3 right-3 bg-white bg-opacity-90 px-2 py-1 rounded-full">
                                            <div class="flex items-center gap-1">
                                                <i class="fas fa-star text-yellow-400 text-sm"></i>
                                                <span class="text-sm font-medium">${house.star}</span>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>

                                <!-- House Details -->
                                <div class="p-4">
                                    <h3 class="text-lg font-semibold text-gray-800 mb-2">${house.name}</h3>

                                    <div class="flex items-center text-gray-600 mb-2">
                                        <i class="fas fa-map-marker-alt mr-2"></i>
                                        <span class="text-sm">${house.address.detail} ${house.address.ward}, ${house.address.district}, ${house.address.province}, ${house.address.country}</span>
                                    </div>

                                    <div class="flex items-center justify-between mb-3">
                                        <div class="text-2xl font-bold text-orange-600">
                                            <fmt:formatNumber value="${house.price_per_night}" type="currency"/>
                                        </div>
                                        <div class="text-sm text-gray-500">
                                            /night
                                        </div>
                                    </div>

                                    <!-- Description -->
                                    <p class="text-gray-600 text-sm mb-4 line-clamp-2">
                                        ${fn:substring(house.description, 0, 100)}${fn:length(house.description) > 100 ? '...' : ''}
                                    </p>

                                    <!-- Action Buttons -->
                                    <div class="flex gap-2">
                                        <a href="${pageContext.request.contextPath}/owner-house/detail?hid=${house.id}" 
                                           class="flex-1 bg-orange-500 hover:bg-orange-600 text-white text-center py-2 px-4 rounded-md font-medium transition-colors">
                                            View Details
                                        </a>
                                        <c:if test="${house.status.id == 1}">
                                            <button onclick="contactOwner('${house.id}')" 
                                                    class="bg-orange-500 hover:bg-orange-600 text-white px-4 py-2 rounded-md transition-colors">
                                                <i class="fas fa-phone"></i>
                                            </button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- No Results -->
                    <div class="text-center py-12">
                        <div class="mb-4">
                            <i class="fas fa-home text-6xl text-gray-300"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-gray-600 mb-2">No Houses Found</h3>
                        <p class="text-gray-500 mb-4">Try adjusting your filters or search criteria</p>
<!--                        <a href="${pageContext.request.contextPath}/available-houses" 
                           class="bg-primary-500 hover:bg-primary-600 text-white px-6 py-2 rounded-md font-medium transition-colors inline-block">
                            View All Houses
                        </a>-->
                    </div>
                </c:otherwise>
            </c:choose>

            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <div class="flex justify-center items-center gap-2 mt-8">
                    <!-- Previous Button -->
                    <c:if test="${currentPage > 1}">
                        <a href="?page=${currentPage - 1}&limit=${limit}&keyword=${keyword}&statusId=${statusId}&star=${minStar}&minPrice=${minPrice}&maxPrice=${maxPrice}" 
                           class="px-3 py-2 bg-gray-200 hover:bg-gray-300 rounded-md transition-colors">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </c:if>

                    <!-- Page Numbers -->
                    <c:forEach begin="1" end="${totalPages}" var="pageNum">
                        <c:choose>
                            <c:when test="${pageNum == currentPage}">
                                <span class="px-3 py-2 bg-primary-500 text-white rounded-md font-medium">${pageNum}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="?page=${pageNum}&limit=${limit}&keyword=${keyword}&statusId=${statusId}&star=${minStar}&minPrice=${minPrice}&maxPrice=${maxPrice}" 
                                   class="px-3 py-2 bg-gray-200 hover:bg-gray-300 rounded-md transition-colors">${pageNum}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <!-- Next Button -->
                    <c:if test="${currentPage < totalPages}">
                        <a href="?page=${currentPage + 1}&limit=${limit}&keyword=${keyword}&statusId=${statusId}&star=${minStar}&minPrice=${minPrice}&maxPrice=${maxPrice}" 
                           class="px-3 py-2 bg-gray-200 hover:bg-gray-300 rounded-md transition-colors">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </c:if>
                </div>
            </c:if>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
                                                function changeLimit(newLimit) {
                                                    const urlParams = new URLSearchParams(window.location.search);
                                                    urlParams.set('limit', newLimit);
                                                    urlParams.set('page', '1'); // Reset to first page when changing limit
                                                    window.location.search = urlParams.toString();
                                                }

                                                function contactOwner(houseId) {
                                                    Swal.fire({
                                                        title: 'Contact Owner',
                                                        text: 'Would you like to contact the house owner?',
                                                        icon: 'question',
                                                        showCancelButton: true,
                                                        confirmButtonColor: '#3b82f6',
                                                        cancelButtonColor: '#6b7280',
                                                        confirmButtonText: 'Yes, contact now!'
                                                    }).then((result) => {
                                                        if (result.isConfirmed) {
                                                            // Redirect to contact page or show contact form
                                                            window.location.href = '${pageContext.request.contextPath}/contact-owner?houseId=' + houseId;
                                                        }
                                                    });
                                                }

                                                // Search focus effects
                                                $('.search-focus').focus(function () {
                                                    $(this).addClass('ring-2 ring-primary-500');
                                                    $('.icon-search-focus').addClass('text-primary-500');
                                                }).blur(function () {
                                                    $(this).removeClass('ring-2 ring-primary-500');
                                                    $('.icon-search-focus').removeClass('text-primary-500');
                                                });
        </script>
    </body>
</html>