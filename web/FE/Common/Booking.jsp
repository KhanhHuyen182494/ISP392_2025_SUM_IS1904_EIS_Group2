<%-- 
    Document   : Booking
    Created on : Jun 30, 2025, 1:24:14 PM
    Author     : Hien
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
        <title>Booking</title>

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

        <div class="container mx-auto px-4 py-8 max-w-6xl">
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <!-- Left Side - House Information -->
                <div class="lg:col-span-2">
                    <!-- Breadcrumb -->
                    <div class="mb-6">
                        <nav class="flex items-center space-x-2 text-sm text-gray-600">
                            <a href="${pageContext.request.contextPath}/feeds" class="hover:text-blue-600">
                                <i class="fas fa-home"></i> Home
                            </a>
                            <span>/</span>
                            <a href="#" class="hover:text-blue-600">Houses</a>
                            <span>/</span>
                            <span class="text-gray-900">Booking</span>
                        </nav>
                    </div>

                    <!-- House Images -->
                    <div class="mb-8">
                        <div class="grid grid-cols-4 gap-2">
                            <c:choose>
                                <c:when test="${not empty h.medias and fn:length(h.medias) > 0}">
                                    <!-- Main large image (first image) -->
                                    <div class="col-span-2 row-span-2">
                                        <img src="${pageContext.request.contextPath}/Asset/Common/House/${h.medias[0].path}" 
                                             alt="Main house image" 
                                             class="w-full h-full object-cover rounded-lg shadow-md cursor-pointer hover:opacity-90 transition-opacity"
                                             onclick="openImageModal('${pageContext.request.contextPath}/Asset/Common/House/${h.medias[0].path}')">
                                    </div>

                                    <!-- Display up to 4 smaller images (index 1-4) -->
                                    <c:forEach var="media" items="${h.medias}" begin="1" end="4" varStatus="status">
                                        <c:choose>
                                            <c:when test="${status.index == 4 and fn:length(h.medias) > 5}">
                                                <!-- Last visible image with "show more" overlay -->
                                                <div class="relative">
                                                    <img src="${pageContext.request.contextPath}/Asset/Common/House/${media.path}" 
                                                         alt="House image ${status.index + 1}" 
                                                         class="w-full h-32 object-cover rounded-lg shadow-md cursor-pointer hover:opacity-90 transition-opacity"
                                                         onclick="showAllImages()">
                                                    <!-- Show more overlay -->
                                                    <div class="absolute inset-0 bg-black bg-opacity-50 rounded-lg flex items-center justify-center cursor-pointer hover:bg-opacity-40 transition-all"
                                                         onclick="showAllImages()">
                                                        <div class="text-white text-center">
                                                            <i class="fas fa-images text-2xl mb-1"></i>
                                                            <div class="text-sm font-medium">+${fn:length(h.medias) - 5} more</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <!-- Regular smaller images -->
                                                <img src="${pageContext.request.contextPath}/Asset/Common/House/${media.path}" 
                                                     alt="House image ${status.index + 1}" 
                                                     class="w-full h-32 object-cover rounded-lg shadow-md cursor-pointer hover:opacity-90 transition-opacity"
                                                     onclick="openImageModal('${pageContext.request.contextPath}/Asset/Common/House/${media.path}')">
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>

                                    <!-- Fill remaining grid spaces if less than 5 images -->
                                    <c:if test="${fn:length(h.medias) < 5}">
                                        <c:forEach begin="${fn:length(h.medias)}" end="4">
                                            <div class="w-full h-32 bg-gray-200 rounded-lg flex items-center justify-center">
                                                <i class="fas fa-image text-gray-400 text-2xl"></i>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <!-- Fallback when no images available -->
                                    <div class="col-span-4 text-center py-16 bg-gray-100 rounded-lg">
                                        <i class="fas fa-images text-gray-400 text-4xl mb-4"></i>
                                        <p class="text-gray-600">No images available for this property</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Room Preview Section (for room-only properties) -->
                    <c:if test="${not h.is_whole_house}">
                        <div id="roomPreview" class="bg-white rounded-lg shadow-md p-6 mb-8 hidden">
                            <h3 class="text-xl font-semibold mb-4">Selected Room</h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div id="roomImageContainer">
                                    <!-- Room image will be loaded here -->
                                </div>
                                <div id="roomDetailsContainer">
                                    <!-- Room details will be loaded here -->
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Image Modal -->
                    <div id="imageModal" class="fixed inset-0 bg-black bg-opacity-75 z-50 hidden flex items-center justify-center p-4">
                        <div class="relative max-w-4xl max-h-full">
                            <button onclick="closeImageModal()" 
                                    class="absolute top-4 right-4 text-white hover:text-gray-300 z-10">
                                <i class="fas fa-times text-2xl"></i>
                            </button>
                            <img id="modalImage" src="" alt="House image" class="max-w-full max-h-full object-contain rounded-lg">
                        </div>
                    </div>

                    <!-- All Images Modal -->
                    <div id="allImagesModal" class="fixed inset-0 bg-white z-50 hidden overflow-y-auto">
                        <div class="sticky top-0 bg-white border-b px-6 py-4 flex items-center justify-between">
                            <h3 class="text-xl font-semibold">All Photos</h3>
                            <button onclick="closeAllImagesModal()" class="text-gray-500 hover:text-gray-700">
                                <i class="fas fa-times text-xl"></i>
                            </button>
                        </div>
                        <div class="p-6">
                            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4" id="allImagesGrid">
                                <!-- Images will be populated by JavaScript -->
                            </div>
                        </div>
                    </div>

                    <!-- House Details -->
                    <div class="bg-white rounded-lg shadow-md p-6 mb-8">
                        <h1 class="text-3xl font-bold text-gray-900 mb-4">${h.name}</h1>

                        <div class="flex items-center mb-4">
                            <div class="flex items-center text-yellow-500 mr-4">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <span class="ml-2 text-gray-600">${h.star}</span>
                            </div>
                            <div class="text-gray-600">
                                <i class="fas fa-map-marker-alt mr-1"></i>
                                ${h.address.detail} ${h.address.ward}, ${h.address.district}, ${h.address.province}, ${h.address.country}
                            </div>
                        </div>

                        <!--                        <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
                                                    <div class="text-center p-3 bg-gray-50 rounded-lg">
                                                        <i class="fas fa-bed text-blue-500 text-xl mb-2"></i>
                                                        <div class="text-sm text-gray-600">Bedrooms</div>
                                                        <div class="font-semibold">3</div>
                                                    </div>
                                                    <div class="text-center p-3 bg-gray-50 rounded-lg">
                                                        <i class="fas fa-bath text-blue-500 text-xl mb-2"></i>
                                                        <div class="text-sm text-gray-600">Bathrooms</div>
                                                        <div class="font-semibold">2</div>
                                                    </div>
                                                    <div class="text-center p-3 bg-gray-50 rounded-lg">
                                                        <i class="fas fa-users text-blue-500 text-xl mb-2"></i>
                                                        <div class="text-sm text-gray-600">Guests</div>
                                                        <div class="font-semibold">6</div>
                                                    </div>
                                                    <div class="text-center p-3 bg-gray-50 rounded-lg">
                                                        <i class="fas fa-expand-arrows-alt text-blue-500 text-xl mb-2"></i>
                                                        <div class="text-sm text-gray-600">Area</div>
                                                        <div class="font-semibold">120m²</div>
                                                    </div>
                                                </div>-->

                        <div class="mb-6">
                            <h3 class="text-xl font-semibold mb-3">Description</h3>
                            <p class="text-gray-700 leading-relaxed">
                                ${h.description}
                            </p>
                        </div>

                        <div class="mb-6">
                            <h3 class="text-xl font-semibold mb-3">Amenities</h3>
                            <div class="grid grid-cols-2 md:grid-cols-3 gap-3">
                                <div class="flex items-center">
                                    <i class="fas fa-wifi text-green-500 mr-2"></i>
                                    <span class="text-sm">Free WiFi</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-car text-green-500 mr-2"></i>
                                    <span class="text-sm">Free Parking</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-snowflake text-green-500 mr-2"></i>
                                    <span class="text-sm">Air Conditioning</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-tv text-green-500 mr-2"></i>
                                    <span class="text-sm">Smart TV</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-utensils text-green-500 mr-2"></i>
                                    <span class="text-sm">Full Kitchen</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-swimming-pool text-green-500 mr-2"></i>
                                    <span class="text-sm">Swimming Pool</span>
                                </div>
                            </div>
                        </div>

                        <!-- Host Information -->
                        <div class="border-t pt-6">
                            <h3 class="text-xl font-semibold mb-3">Hosted by</h3>
                            <div class="flex items-center">
                                <img src="${pageContext.request.contextPath}/Asset/Common/Avatar/${h.owner.avatar}" 
                                     alt="Host avatar" 
                                     class="w-12 h-12 rounded-full object-cover mr-4">
                                <div>
                                    <div class="font-semibold">${h.owner.first_name} ${h.owner.last_name}</div>
                                    <div class="text-sm text-gray-600">Joined on: <fmt:formatDate value="${h.owner.created_at}" pattern="dd/MM/yyyy" /></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Side - Booking & Price Calculation -->
                <div class="lg:col-span-1">
                    <div class="bg-white rounded-lg shadow-lg p-6 sticky top-24">
                        <div class="mb-6">
                            <div class="text-3xl font-bold text-gray-900">
                                <span id="displayPrice">₫<fmt:formatNumber value="${h.price_per_night}" pattern="#,###" /></span>
                                <span class="text-lg font-normal text-gray-600">/ night</span>
                            </div>
                            <div id="bookingTypeDisplay" class="text-sm text-gray-600 mt-1">
                                <c:choose>
                                    <c:when test="${h.is_whole_house}">Whole House</c:when>
                                    <c:otherwise>Room Booking</c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <form id="bookingForm" action="${pageContext.request.contextPath}/booking/confirm" method="POST">
                            <input type="hidden" name="homestayId" value="${h.id}">
                            <input type="hidden" name="subtotal" id="subtotalHidden" value="0">
                            <input type="hidden" name="serviceFee" id="serviceFeeHidden" value="0">
                            <input type="hidden" name="cleaningFee" id="cleaningFeeHidden" value="0">
                            <input type="hidden" name="totalAmount" id="totalAmountHidden" value="0">
                            <input type="hidden" name="depositAmount" id="depositAmountHidden" value="0">
                            <input type="hidden" name="nightCount" id="nightCountHidden" value="0">
                            <input type="hidden" name="pricePerNight" id="pricePerNightHidden" value="${h.price_per_night}">

                            <!-- Booking Type Selection (only for whole house properties) -->
                            <c:if test="${h.is_whole_house}">
                                <div class="mb-6">
                                    <label class="block text-sm font-medium text-gray-700 mb-3">Booking Type</label>
                                    <div class="grid grid-cols-1 gap-3">
                                        <div class="border border-blue-500 bg-blue-50 rounded-lg p-4 cursor-pointer booking-option" data-type="whole">
                                            <div class="flex items-center justify-between">
                                                <div class="flex items-center">
                                                    <input type="radio" name="bookingType" value="whole" id="wholeHouse" class="mr-3" checked>
                                                    <div>
                                                        <div class="font-semibold">Whole House</div>
                                                        <div class="text-sm text-gray-600">Entire property for your group</div>
                                                    </div>
                                                </div>
                                                <div class="text-right">
                                                    <div class="font-semibold text-lg">₫<fmt:formatNumber value="${h.price_per_night}" pattern="#,###" /></div>
                                                    <div class="text-sm text-gray-600">per night</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Room Selection (only for room-only properties) -->
                            <c:if test="${not h.is_whole_house}">
                                <input type="hidden" name="bookingType" value="room">
                                <div id="roomSelection" class="mb-6">
                                    <label class="block text-sm font-medium text-gray-700 mb-3">Select Room</label>
                                    <div class="space-y-3" id="roomsList">
                                        <div class="text-center py-8 text-gray-500">
                                            <i class="fas fa-spinner fa-spin text-2xl mb-2"></i>
                                            <div>Loading available rooms...</div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Date Selection -->
                            <div class="grid grid-cols-2 gap-3 mb-4">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-1">Check-in</label>
                                    <input type="date" 
                                           name="checkIn" 
                                           id="checkIn"
                                           required
                                           class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-1">Check-out</label>
                                    <input type="date" 
                                           name="checkOut" 
                                           id="checkOut"
                                           required
                                           class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                </div>
                            </div>

                            <!-- Price Breakdown -->
                            <div class="border-t border-b py-4 mb-4">
                                <div class="space-y-3">
                                    <div class="flex justify-between">
                                        <span class="text-gray-600">
                                            <span id="pricePerNightDisplay">₫<fmt:formatNumber value="${h.price_per_night}" pattern="#,###" /></span> × <span id="nightCount">0</span> nights
                                        </span>
                                        <span id="subtotal">₫0</span>
                                    </div>
                                    <div class="flex justify-between">
                                        <span class="text-gray-600">Service fee</span>
                                        <span id="serviceFee">₫0</span>
                                    </div>
                                    <div class="flex justify-between" id="cleaningFeeRow">
                                        <span class="text-gray-600">Cleaning fee</span>
                                        <span id="cleaningFeeAmount">₫0</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Total -->
                            <div class="flex justify-between text-lg font-semibold mb-4">
                                <span>Total</span>
                                <span id="totalPrice">₫0</span>
                            </div>

                            <!-- Deposit -->
                            <div class="bg-blue-50 p-4 rounded-lg mb-6">
                                <div class="flex justify-between items-center">
                                    <div>
                                        <div class="font-medium text-blue-900">Required Deposit</div>
                                        <div class="text-sm text-blue-700">20% of total amount</div>
                                    </div>
                                    <div class="text-lg font-bold text-blue-900" id="depositAmount">₫0</div>
                                </div>
                            </div>

                            <!-- Special Requests -->
                            <div class="mb-6">
                                <label class="block text-sm font-medium text-gray-700 mb-1">Special Requests (Optional)</label>
                                <textarea name="specialRequests" 
                                          rows="3" 
                                          placeholder="Any special requests or notes..."
                                          class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 resize-none"></textarea>
                            </div>

                            <!-- Book Button -->
                            <button type="submit" 
                                    id="bookButton"
                                    <c:if test="${not h.is_whole_house}">disabled</c:if>
                                        class="w-full bg-orange-500 hover:bg-orange-600 disabled:bg-gray-400 disabled:cursor-not-allowed text-white font-semibold py-3 px-4 rounded-lg transition-colors">
                                    <c:choose>
                                        <c:when test="${h.is_whole_house}">Book Now</c:when>
                                        <c:otherwise>Select a Room First</c:otherwise>
                                    </c:choose>
                            </button>

                            <div class="text-center text-sm text-gray-600 mt-3">
                                You won't be charged yet
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
                                // Configuration
                                const isWholeHouse = '${h.is_whole_house}' === 'true';
                                const basePricePerNight = '${h.price_per_night}';
                                const homestayId = '${h.id}';

                                const pricing = {
                                    whole: {
                                        price: basePricePerNight,
                                        cleaningFee: 200000,
                                        maxGuests: 6
                                    },
                                    room: {
                                        price: basePricePerNight,
                                        cleaningFee: 50000,
                                        maxGuests: 2
                                    }
                                };

                                let currentBookingType = isWholeHouse ? 'whole' : 'room';
                                let selectedRoomId = null;
                                let selectedRoomData = null;
                                let currentRoomPrice = basePricePerNight;
                                const serviceFeeRate = 0.1; // 10%

                                const allImages = [
            <c:forEach var="media" items="${h.medias}" varStatus="status">
                                '${pageContext.request.contextPath}/Asset/Common/House/${media.path}'<c:if test="${!status.last}">,</c:if>
            </c:forEach>
                                    ];

                                    function openImageModal(src) {
                                        document.getElementById('modalImage').src = src;
                                        document.getElementById('imageModal').classList.remove('hidden');
                                        document.body.style.overflow = 'hidden';
                                    }

                                    function closeImageModal() {
                                        document.getElementById('imageModal').classList.add('hidden');
                                        document.body.style.overflow = 'auto';
                                    }

                                    function showAllImages() {
                                        const grid = document.getElementById('allImagesGrid');
                                        grid.innerHTML = '';

                                        allImages.forEach((imageSrc, index) => {
                                            const imgDiv = document.createElement('div');
                                            imgDiv.className = 'aspect-square';
                                            imgDiv.innerHTML = `
            <img src="` + imageSrc + `" 
                 alt="House image ` + (index + 1) + `" 
                 class="w-full h-full object-cover rounded-lg shadow-md cursor-pointer hover:opacity-90 transition-opacity"
                 onclick="openImageModal('` + imageSrc + `')">
        `;
                                            grid.appendChild(imgDiv);
                                        });

                                        document.getElementById('allImagesModal').classList.remove('hidden');
                                        document.body.style.overflow = 'hidden';
                                    }

                                    function closeAllImagesModal() {
                                        document.getElementById('allImagesModal').classList.add('hidden');
                                        document.body.style.overflow = 'auto';
                                    }

                                    document.getElementById('imageModal').addEventListener('click', function (e) {
                                        if (e.target === this) {
                                            closeImageModal();
                                        }
                                    });

                                    function clearRoomSelection() {
                                        selectedRoomId = null;
                                        selectedRoomData = null;
                                        currentRoomPrice = basePricePerNight;

                                        // Hide room preview
                                        $('#roomPreview').addClass('hidden');

                                        // Reset pricing display to base price
                                        $('#displayPrice').html(`₫` + basePricePerNight.toLocaleString());
                                        $('#pricePerNightDisplay').html(`₫` + basePricePerNight.toLocaleString());

                                        // Disable book button
                                        $('#bookButton').prop('disabled', true).text('Select a Room First');

                                        // Clear price breakdown
                                        clearPriceBreakdown();
                                    }

                                    function clearPriceBreakdown() {
                                        // Clear display
                                        $('#nightCount').text('0');
                                        $('#subtotal').text('₫0');
                                        $('#serviceFee').text('₫0');
                                        $('#cleaningFeeAmount').text('₫0');
                                        $('#totalPrice').text('₫0');
                                        $('#depositAmount').text('₫0');

                                        $('#subtotalHidden').val('0');
                                        $('#serviceFeeHidden').val('0');
                                        $('#cleaningFeeHidden').val('0');
                                        $('#totalAmountHidden').val('0');
                                        $('#depositAmountHidden').val('0');
                                        $('#nightCountHidden').val('0');
                                        $('#pricePerNightHidden').val(basePricePerNight);
                                    }

                                    function loadAvailableRooms(checkIn, checkOut) {
                                        if (!isWholeHouse && checkIn && checkOut) {
                                            // Clear previous room selection
                                            clearRoomSelection();

                                            // Show loading state
                                            $('#roomsList').html(`
                                                <div class="text-center py-8 text-gray-500">
                                                    <i class="fas fa-spinner fa-spin text-2xl mb-2"></i>
                                                    <div>Loading available rooms...</div>
                                                </div>
                                            `);

                                            $.ajax({
                                                url: '${pageContext.request.contextPath}/homestay/room/available',
                                                method: 'GET',
                                                data: {
                                                    hid: homestayId,
                                                    checkIn: checkIn,
                                                    checkOut: checkOut
                                                },
                                                success: function (response) {
                                                    displayRooms(response.rooms);
                                                },
                                                error: function () {
                                                    $('#roomsList').html(`
                                                        <div class="text-center py-8 text-red-500">
                                                            <i class="fas fa-exclamation-triangle text-2xl mb-2"></i>
                                                            <div>Failed to load rooms. Please try again.</div>
                                                        </div>
                                                    `);
                                                }
                                            });
                                        }
                                    }

                                    function displayRooms(rooms) {
                                        const roomsList = $('#roomsList');
                                        roomsList.empty();
                                        console.log(typeof rooms); // should be 'object'
                                        console.log(Array.isArray(rooms)); // should be true
                                        console.log(rooms);

                                        if (rooms && rooms.length > 0) {
                                            rooms.forEach(room => {
                                                const roomOption = `
                <div class="border border-gray-300 rounded-lg p-4 cursor-pointer room-option hover:border-blue-500 hover:bg-blue-50 transition-all" 
                     data-room-id="` + room.id + `" 
                     data-room-price="` + room.price_per_night + `"
                     data-room-max-guests="` + room.max_guests + `">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center">
                            <input type="radio" name="selectedRoom" value="` + room.id + `" class="mr-3">
                            <div>
                                <div class="font-semibold">` + room.name + `</div>
                                <div class="text-sm text-gray-600">` + room.description || 'Private room' + `</div>
                                <div class="text-sm text-gray-500 mt-1">
                                    <i class="fas fa-users mr-1"></i>Max ` + room.max_guests + ` guests
                                </div>
                            </div>
                        </div>
                        <div class="text-right">
                            <div class="font-semibold text-lg">₫` + room.price_per_night.toLocaleString() + `</div>
                            <div class="text-sm text-gray-600">per night</div>
                        </div>
                    </div>
                </div>
            `;
                                                roomsList.append(roomOption);
                                            });

                                            // Add click handlers for room selection
                                            $('.room-option').on('click', function () {
                                                const roomId = $(this).data('room-id');
                                                const roomPrice = $(this).data('room-price');
                                                const roomMaxGuests = $(this).data('room-max-guests');

                                                // Update visual selection
                                                $('.room-option').removeClass('border-blue-500 bg-blue-50').addClass('border-gray-300');
                                                $(this).removeClass('border-gray-300').addClass('border-blue-500 bg-blue-50');

                                                // Check the radio button
                                                $(this).find('input[type="radio"]').prop('checked', true);

                                                // Update selected room data
                                                selectedRoomId = roomId;
                                                currentRoomPrice = roomPrice;

                                                $('#pricePerNightHidden').val(roomPrice);

                                                // Update pricing display
                                                updatePricingDisplay(roomPrice);

                                                // Load and display room details
                                                loadRoomDetails(roomId);

                                                // Enable book button
                                                $('#bookButton').prop('disabled', false).text('Book Now');

                                                // Recalculate total with new room price
                                                calculateTotal();
                                            });
                                        } else {
                                            roomsList.html(`
                                                <div class="text-center py-8 text-gray-500">
                                                    <i class="fas fa-bed text-2xl mb-2"></i>
                                                    <div>No rooms available for these dates</div>
                                                    <div class="text-sm mt-2">Please try different dates</div>
                                                </div>
                                            `);
                                        }
                                    }

                                    function loadRoomDetails(roomId) {
                                        $.ajax({
                                            url: '${pageContext.request.contextPath}/homestay/room',
                                            method: 'GET',
                                            data: {roomId: roomId},
                                            success: function (response) {
                                                displayRoomPreview(response.room);
                                                selectedRoomData = response.room;
                                            },
                                            error: function () {
                                                console.error('Failed to load room details');
                                            }
                                        });
                                    }

                                    function displayRoomPreview(roomData) {
                                        const roomPreview = $('#roomPreview');
                                        const imageContainer = $('#roomImageContainer');
                                        const detailsContainer = $('#roomDetailsContainer');

                                        // Display room image
                                        let imageHtml = '';
                                        if (roomData.medias && roomData.medias.length > 0) {
                                            imageHtml = `
                                                <img src="${pageContext.request.contextPath}/Asset/Common/Room/` + roomData.medias[0].path + `" 
                                                     alt="` + roomData.name + `" 
                                                     class="w-full h-48 object-cover rounded-lg">
                                            `;

                                            // Add additional images if available
                                            if (roomData.medias.length > 1) {
                                                imageHtml += `
                                                <div class="grid grid-cols-3 gap-2 mt-2">
                                            ` + roomData.medias.slice(1, 4).map(img => `
                                              <img src="${pageContext.request.contextPath}/Asset/Common/Room/` + img.path + `" 
                                              alt="` + roomData.name + `" 
                                              class="w-full h-16 object-cover rounded cursor-pointer hover:opacity-80"
                                              onclick="openImageModal('${pageContext.request.contextPath}/Asset/Common/Room/` + img.path + `')">
                                              `).join('') + `
                                                </div>
                                            `;
                                            }
                                        } else {
                                            imageHtml = `
                                                <div class="w-full h-48 bg-gray-200 rounded-lg flex items-center justify-center">
                                                    <i class="fas fa-bed text-gray-400 text-3xl"></i>
                                                </div>
                                            `;
                                        }

                                        imageContainer.html(imageHtml);

                                        // Display room details
                                        const detailsHtml = `
                                            <div>
                                                <h4 class="text-lg font-semibold mb-3">` + roomData.name + `</h4>
                                                <p class="text-gray-600 mb-4">` + roomData.description + `</p>
                                                <div class="space-y-2">
                                                    <div class="flex items-center">
                                                        <i class="fas fa-users text-blue-500 w-5 mr-2"></i>
                                                        <span class="text-sm">Max ` + roomData.max_guests + ` guests</span>
                                                    </div>
                                                    <div class="flex items-center">
                                                        <i class="fas fa-expand-arrows-alt text-blue-500 w-5 mr-2"></i>
                                                        <span class="text-sm">` + roomData.room_position + ` </span>
                                                    </div>
                                                    <div class="flex items-center">
                                                        <i class="fas fa-bed text-blue-500 w-5 mr-2"></i>
                                                        <span class="text-sm">` + roomData.roomType.name + `</span>
                                                    </div>
                                                </div>
                                            </div>
                                        `;

                                        detailsContainer.html(detailsHtml);
                                        roomPreview.removeClass('hidden');
                                    }

                                    function updatePricingDisplay(roomPrice) {
                                        $('#displayPrice').html(`₫` + roomPrice.toLocaleString());
                                        $('#pricePerNightDisplay').html(`₫` + roomPrice.toLocaleString());
                                    }

                                    function calculateTotal() {
                                        const checkIn = $('#checkIn').val();
                                        const checkOut = $('#checkOut').val();

                                        if (checkIn && checkOut) {
                                            const checkInDate = new Date(checkIn);
                                            const checkOutDate = new Date(checkOut);
                                            const nights = Math.ceil((checkOutDate - checkInDate) / (1000 * 60 * 60 * 24));

                                            if (nights > 0) {
                                                // Use current room price or base price for whole house
                                                const pricePerNight = isWholeHouse ? basePricePerNight : currentRoomPrice;
                                                const subtotal = pricePerNight * nights;

                                                if (subtotal > Number.MAX_SAFE_INTEGER) {
                                                    console.error('Subtotal exceeds safe integer limit');
                                                    return;
                                                }

                                                const serviceFee = Math.floor(subtotal * serviceFeeRate);
                                                const cleaningFee = currentBookingType === 'whole' ? pricing.whole.cleaningFee : pricing.room.cleaningFee;
                                                const total = subtotal + serviceFee + cleaningFee;
                                                const deposit = Math.floor(total * 0.2);

                                                // Update display
                                                $('#nightCount').text(nights);
                                                $('#subtotal').text(`₫` + subtotal.toLocaleString());
                                                $('#serviceFee').text(`₫` + serviceFee.toLocaleString());
                                                $('#cleaningFeeAmount').text(`₫` + cleaningFee.toLocaleString());
                                                $('#totalPrice').text(`₫` + total.toLocaleString());
                                                $('#depositAmount').text(`₫` + deposit.toLocaleString());

                                                $('#subtotalHidden').val(subtotal);
                                                $('#serviceFeeHidden').val(serviceFee);
                                                $('#cleaningFeeHidden').val(cleaningFee);
                                                $('#totalAmountHidden').val(total);
                                                $('#depositAmountHidden').val(deposit);
                                                $('#nightCountHidden').val(nights);
                                                $('#pricePerNightHidden').val(pricePerNight);
                                            } else {
                                                clearPriceBreakdown();
                                            }
                                        } else {
                                            clearPriceBreakdown();
                                        }
                                    }

                                    $(document).ready(function () {
                                        // Set minimum date to today
                                        const today = new Date().toISOString().split('T')[0];
                                        $('#checkIn').attr('min', today);
                                        $('#checkOut').attr('min', today);

                                        // Date change handlers
                                        $('#checkIn, #checkOut').on('change', function () {
                                            // Update checkout minimum date
                                            if ($('#checkIn').val()) {
                                                const checkInDate = new Date($('#checkIn').val());
                                                checkInDate.setDate(checkInDate.getDate() + 1);
                                                $('#checkOut').attr('min', checkInDate.toISOString().split('T')[0]);
                                            }

                                            const checkIn = $('#checkIn').val();
                                            const checkOut = $('#checkOut').val();

                                            if (checkIn && checkOut) {
                                                // Validate date range
                                                const checkInDate = new Date(checkIn);
                                                const checkOutDate = new Date(checkOut);

                                                if (checkOutDate <= checkInDate) {
                                                    // Invalid date range
                                                    clearPriceBreakdown();
                                                    if (!isWholeHouse) {
                                                        $('#roomsList').html(`
                                                        <div class="text-center py-8 text-orange-500">
                                                            <i class="fas fa-exclamation-triangle text-2xl mb-2"></i>
                                                            <div>Check-out date must be after check-in date</div>
                                                        </div>
                                                    `);
                                                    }
                                                    return;
                                                }

                                                if (!isWholeHouse) {
                                                    // Load available rooms for the selected dates
                                                    loadAvailableRooms(checkIn, checkOut);
                                                } else {
                                                    // For whole house, directly calculate total
                                                    calculateTotal();
                                                }
                                            } else {
                                                // Clear everything when dates are incomplete
                                                if (!isWholeHouse) {
                                                    clearRoomSelection();
                                                    $('#roomsList').html(`
                                                        <div class="text-center py-8 text-gray-400">
                                                            <i class="fas fa-calendar-alt text-2xl mb-2"></i>
                                                            <div>Please select check-in and check-out dates first</div>
                                                        </div>
                                                    `);
                                                } else {
                                                    clearPriceBreakdown();
                                                }
                                            }
                                        });

                                        // Initial state for room-only properties
                                        if (!isWholeHouse) {
                                            $('#roomsList').html(`
                                                <div class="text-center py-8 text-gray-400">
                                                    <i class="fas fa-calendar-alt text-2xl mb-2"></i>
                                                    <div>Please select check-in and check-out dates first</div>
                                                </div>
                                            `);
                                            clearPriceBreakdown();
                                        } else {
                                            // Initial calculation for whole house
                                            calculateTotal();
                                        }

                                        $('#bookingForm').on('submit', function (e) {
                                            e.preventDefault(); // Prevent default form submission

                                            // Disable the submit button and show loading state
                                            const $submitBtn = $('#bookButton');
                                            const originalText = $submitBtn.text();
                                            $submitBtn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin mr-2"></i>Processing...');

                                            // Gather form data
                                            const formData = {
                                                homestayId: $('input[name="homestayId"]').val(),
                                                bookingType: $('input[name="bookingType"]:checked').val() || 'whole',
                                                checkIn: $('#checkIn').val(),
                                                checkOut: $('#checkOut').val(),
                                                specialRequests: $('textarea[name="specialRequests"]').val(),
                                                subtotal: $('#subtotalHidden').val(),
                                                serviceFee: $('#serviceFeeHidden').val(),
                                                cleaningFee: $('#cleaningFeeHidden').val(),
                                                totalAmount: $('#totalAmountHidden').val(),
                                                depositAmount: $('#depositAmountHidden').val(),
                                                nightCount: $('#nightCountHidden').val(),
                                                pricePerNight: $('#pricePerNightHidden').val()
                                            };

                                            // Add selected room ID for room bookings
                                            if (!isWholeHouse && selectedRoomId) {
                                                formData.selectedRoom = selectedRoomId;
                                                formData.bookingType = 'room';
                                            }

                                            // Validate required fields
                                            if (!formData.checkIn || !formData.checkOut) {
                                                showToast('Please select check-in and check-out dates', 'error');
                                                resetSubmitButton($submitBtn, originalText);
                                                return;
                                            }

                                            if (!isWholeHouse && !selectedRoomId) {
                                                showToast('Please select a room', 'error');
                                                resetSubmitButton($submitBtn, originalText);
                                                return;
                                            }

                                            // Send AJAX request
                                            $.ajax({
                                                url: '${pageContext.request.contextPath}/booking/contract',
                                                method: 'POST',
                                                data: formData,
                                                dataType: 'json',
                                                success: function (response) {
                                                    if (response.ok) {
                                                        // Show success message
                                                        showToast(response.message, 'success');

                                                        setTimeout(function () {
                                                            location.href = '${pageContext.request.contextPath}/booking/contract?bookId=' + response.bookId;
                                                        }, 2000);
                                                    } else {
                                                        // Show error message
                                                        showToast(response.message || 'Booking failed. Please try again.', 'error');
                                                        resetSubmitButton($submitBtn, originalText);
                                                    }
                                                },
                                                error: function (xhr, status, error) {
                                                    showToast(xhr.message, 'error');
                                                    resetSubmitButton($submitBtn, originalText);
                                                }
                                            });
                                        });

                                        // Helper function to reset submit button
                                        function resetSubmitButton($button, originalText) {
                                            $button.prop('disabled', false).text(originalText);
                                        }

                                        // Helper function to show toast notifications
                                        function showToast(message, type = 'info') {
                                            const backgroundColor = type === 'error' ? '#ef4444' :
                                                    type === 'success' ? '#10b981' : '#3b82f6';

                                            Toastify({
                                                text: message,
                                                duration: 4000,
                                                gravity: "top",
                                                position: "right",
                                                style: {
                                                    background: backgroundColor,
                                                },
                                                stopOnFocus: true
                                            }).showToast();
                                        }
                                    });
        </script>
    </body>
</html>