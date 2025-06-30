<%-- 
    Document   : DetailHouse
    Created on : Jun 28, 2025, 8:19:35 AM
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
        <title>Homestay Detail</title>

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
        <style>
            .carousel-container {
                position: relative;
                overflow: hidden;
                border-radius: 1rem;
                width: 100%;
            }

            .carousel-track {
                display: flex;
                transition: transform 0.5s ease-in-out;
                width: 100%;
            }

            .carousel-slide {
                min-width: 100%;
                width: 100%;
                height: 300px;
                flex-shrink: 0;
            }

            .small-carousel .carousel-slide {
                height: 200px;
            }

            .carousel-slide img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
            }

            .carousel-nav {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                background: rgba(0, 0, 0, 0.5);
                color: white;
                border: none;
                padding: 10px 15px;
                cursor: pointer;
                border-radius: 50%;
                transition: background 0.3s;
                z-index: 10;
            }

            .carousel-nav:hover {
                background: rgba(0, 0, 0, 0.7);
            }

            .carousel-prev {
                left: 10px;
            }

            .carousel-next {
                right: 10px;
            }

            .carousel-dots {
                display: flex;
                justify-content: center;
                gap: 8px;
                margin-top: 15px;
            }

            .carousel-dot {
                width: 12px;
                height: 12px;
                border-radius: 50%;
                background: rgba(0, 0, 0, 0.3);
                cursor: pointer;
                transition: background 0.3s;
            }

            .carousel-dot.active {
                background: #f97316;
            }

            .room-card {
                border: 1px solid #e5e7eb;
                border-radius: 1rem;
                padding: 1.5rem;
                margin-bottom: 1rem;
                transition: shadow 0.3s;
            }

            .room-card:hover {
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            }

            .star-rating {
                color: #fbbf24;
            }

            .status-badge {
                display: inline-flex;
                align-items: center;
                padding: 0.375rem 0.75rem;
                border-radius: 9999px;
                font-size: 0.875rem;
                font-weight: 500;
            }

            .status-available {
                background-color: #dcfce7;
                color: #166534;
            }

            .status-booked {
                background-color: #fef3c7;
                color: #92400e;
            }

            .status-maintenance {
                background-color: #fee2e2;
                color: #991b1b;
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

        <div class="container mx-auto px-4 py-8 max-w-6xl">
            <!-- Header -->
            <div class="text-center mb-8">
                <h1 class="text-3xl font-bold mb-2">
                    <i class="fas fa-home text-2xl mr-3"></i>
                    Homestay Details
                </h1>
            </div>

            <!-- Main -->
            <div class="main space-y-5">
                <!--Homestay section-->
                <div class="bg-white backdrop-blur-sm rounded-2xl shadow-xl border border-white overflow-hidden p-6">
                    <a class="text-blue-500" href="#" onclick="history.back()">
                        <i class="fa-solid fa-arrow-left mr-2"></i>
                        Go back
                    </a>
                    <div class="flex items-center justify-between mb-6 mt-3">
                        <label class="block text-xl font-semibold text-gray-700 flex items-center">
                            <i class="fas fa-tag text-blue-500 mr-2"></i>
                            Homestay Basic Information
                        </label>
                        <c:if test="${sessionScope.user.id == h.owner.id}">
                            <button type="button" onclick="editHomestay('${h.id}')" 
                                    class="bg-orange-500 hover:bg-orange-600 text-white px-4 py-2 rounded-lg font-medium transition-all duration-300 flex items-center gap-2 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5">
                                <i class="fas fa-edit"></i>
                                Edit Homestay
                            </button>
                        </c:if>
                    </div>

                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                        <!-- Information Section -->
                        <div class="space-y-4">
                            <div class="flex items-start">
                                <label class="text-lg font-semibold text-gray-700 w-32 flex-shrink-0">
                                    Name: 
                                </label>
                                <span class="text-lg text-gray-800">${h.name}</span>
                            </div>

                            <div class="flex items-start">
                                <label class="text-lg font-semibold text-gray-700 w-32 flex-shrink-0">
                                    Description: 
                                </label>
                                <span class="text-lg text-gray-800">${h.description}</span>
                            </div>

                            <div class="flex items-start">
                                <label class="text-lg font-semibold text-gray-700 w-32 flex-shrink-0">
                                    Star: 
                                </label>
                                <div class="star-rating">
                                    <c:forEach var="i" begin="1" end="5">
                                        <i class="fas fa-star ${i <= h.star ? '' : 'text-gray-300'}"></i>
                                    </c:forEach>
                                    <span class="ml-2 text-gray-600">(${h.star}/5)</span>
                                </div>
                            </div>

                            <div class="flex items-start">
                                <label class="text-lg font-semibold text-gray-700 w-32 flex-shrink-0">
                                    Type: 
                                </label>
                                <c:if test="${h.is_whole_house == true}">
                                    <span class="text-lg text-gray-800">Whole House</span>
                                </c:if>
                                <c:if test="${h.is_whole_house == false}">
                                    <span class="text-lg text-gray-800">Rooms</span>
                                </c:if>
                            </div>

                            <div class="flex items-start">
                                <label class="text-lg font-semibold text-gray-700 w-32 flex-shrink-0">
                                    Price: 
                                </label>
                                <span class="text-lg font-bold text-orange-600">
                                    <c:if test="${h.is_whole_house == true}">
                                        <fmt:formatNumber value="${h.price_per_night}" type="currency" currencySymbol="VND" />
                                        <span class="text-sm font-normal text-gray-600">/night</span>
                                    </c:if>
                                    <c:if test="${h.is_whole_house == false}">
                                        <span class="text-lg text-gray-800">Different for each room</span>
                                    </c:if>
                                </span>
                            </div>

                            <div class="flex items-start">
                                <label class="text-lg font-semibold text-gray-700 w-32 flex-shrink-0">
                                    Status: 
                                </label>
                                <span class="status-badge ${h.status.name == 'Available' ? 'status-available' : h.status == 'Booked' ? 'status-booked' : 'status-maintenance'}">
                                    <i class="fas fa-circle mr-1"></i>
                                    ${h.status.name}
                                </span>
                            </div>

                            <div class="flex items-start">
                                <label class="text-lg font-semibold text-gray-700 w-32 flex-shrink-0">
                                    Address: 
                                </label>
                                <span class="text-lg text-gray-800">${h.address.detail} ${h.address.ward}, ${h.address.district}, ${h.address.province}, ${h.address.country}</span>
                            </div>
                        </div>

                        <!--Image section-->
                        <div class="carousel-container" id="homestayCarousel">
                            <div class="carousel-track" id="homestayTrack">
                                <c:forEach var="image" items="${h.medias}" varStatus="status">
                                    <div class="carousel-slide">
                                        <img src="${pageContext.request.contextPath}/Asset/Common/House/${image.path}" 
                                             alt="${h.name}" 
                                             class="w-full h-full object-cover">
                                    </div>
                                </c:forEach>
                                <c:if test="${empty h.medias}">
                                    <div class="carousel-slide">
                                        <img src="${pageContext.request.contextPath}/Asset/Common/House/no-image.webp" 
                                             alt="No image available" 
                                             class="w-full h-full object-cover">
                                    </div>
                                </c:if>
                            </div>

                            <c:if test="${fn:length(h.medias) > 1}">
                                <button class="carousel-nav carousel-prev" onclick="prevSlide('homestay'); pauseAutoSlide();">
                                    <i class="fas fa-chevron-left"></i>
                                </button>
                                <button class="carousel-nav carousel-next" onclick="nextSlide('homestay'); pauseAutoSlide();">
                                    <i class="fas fa-chevron-right"></i>
                                </button>

                                <div class="carousel-dots">
                                    <c:forEach var="image" items="${h.medias}" varStatus="status">
                                        <div class="carousel-dot ${status.index == 0 ? 'active' : ''}" 
                                             onclick="goToSlide('homestay', ${status.index}); pauseAutoSlide();"></div>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <c:if test="${h.is_whole_house == false}">
                    <!--Room Section-->
                    <div class="bg-white backdrop-blur-sm rounded-2xl shadow-xl border border-white overflow-hidden p-6">
                        <div class="flex items-center justify-between mb-6">
                            <label class="block text-xl font-semibold text-gray-700 flex items-center">
                                <i class="fas fa-bed text-blue-500 mr-2"></i>
                                Available Rooms
                            </label>
                            <c:if test="${sessionScope.user.id == h.owner.id}">
                                <button type="button" onclick="addRoom('${h.id}')" 
                                        class="bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-lg font-medium transition-all duration-300 flex items-center gap-2 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5">
                                    <i class="fas fa-plus"></i>
                                    Add Room
                                </button>
                            </c:if>
                        </div>

                        <c:choose>
                            <c:when test="${not empty h.rooms}">
                                <div class="grid grid-cols-1 gap-6">
                                    <c:forEach var="room" items="${h.rooms}">
                                        <c:if test="${room.status.id != 27 || h.owner.id == sessionScope.user.id}">
                                            <div class="room-card">
                                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                                    <!-- Room Info -->
                                                    <div class="space-y-3">
                                                        <h3 class="text-xl font-bold text-gray-800">${room.name}</h3>

                                                        <div class="space-y-2">
                                                            <div class="flex items-center gap-2">
                                                                <i class="fas fa-users text-blue-500"></i>
                                                                <span class="text-sm text-gray-600">Capacity: ${room.max_guests} guests</span>
                                                            </div>
                                                            <div class="flex items-center gap-2">
                                                                <i class="fas fa-dollar-sign text-green-500"></i>
                                                                <span class="text-lg font-bold text-orange-600">
                                                                    <fmt:formatNumber value="${room.price_per_night}" type="currency" currencySymbol="VND" />
                                                                    <span class="text-sm font-normal text-gray-600">/night</span>
                                                                </span>
                                                            </div>
                                                            <div class="flex items-center gap-2">
                                                                <span class="text-lg font-bold text-orange-600">
                                                                    <div class="star-rating">
                                                                        <c:forEach var="i" begin="1" end="5">
                                                                            <i class="fas fa-star ${i <= room.star ? '' : 'text-gray-300'}"></i>
                                                                        </c:forEach>
                                                                        <span class="ml-2 text-gray-600">(${room.star}/5)</span>
                                                                    </div>
                                                                </span>
                                                            </div>
                                                            <div class="flex items-center gap-2">
                                                                <i class="fas fa-circle text-xs ${room.status.name == 'Available' ? 'text-green-500' : room.status.name == 'Booked' ? 'text-yellow-500' : 'text-red-500'}"></i>
                                                                <span class="text-sm text-gray-600">${room.status.name}</span>
                                                            </div>
                                                        </div>

                                                        <div class="flex gap-2 mt-4">
                                                            <c:if test="${sessionScope.user.id == h.owner.id}">
                                                                <button type="button" onclick="editRoom('${room.id}')" 
                                                                        class="bg-orange-500 hover:bg-orange-600 text-white px-3 py-1 rounded-lg text-sm font-medium transition-all duration-300 flex items-center gap-1">
                                                                    <i class="fas fa-edit"></i>
                                                                    Edit
                                                                </button>
<!--                                                                <button type="button" onclick="deleteRoom('${room.id}')" 
                                                                        class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded-lg text-sm font-medium transition-all duration-300 flex items-center gap-1">
                                                                    <i class="fas fa-trash"></i>
                                                                    Delete
                                                                </button>-->
                                                            </c:if>
                                                            <button type="button" onclick="detail('${room.id}')" 
                                                                    class="bg-green-500 hover:bg-green-600 text-white px-3 py-1 rounded-lg text-sm font-medium transition-all duration-300 flex items-center gap-1">
                                                                <i class="fa-solid fa-circle-info"></i>
                                                                Detail
                                                            </button>
                                                        </div>
                                                    </div>

                                                    <!-- Room Images -->
                                                    <div class="small-carousel carousel-container" id="roomCarousel${room.id}">
                                                        <div class="carousel-track" id="room${room.id}Track">
                                                            <c:forEach var="image" items="${room.medias}" varStatus="status">
                                                                <div class="carousel-slide">
                                                                    <img src="${pageContext.request.contextPath}/Asset/Common/Room/${image.path}" 
                                                                         alt="${room.name}" 
                                                                         class="w-full h-full object-cover rounded-lg">
                                                                </div>
                                                            </c:forEach>
                                                            <c:if test="${empty room.medias}">
                                                                <div class="carousel-slide">
                                                                    <img src="${pageContext.request.contextPath}/Asset/Common/Room/no-image.webp" 
                                                                         alt="No image available" 
                                                                         class="w-full h-full object-cover rounded-lg">
                                                                </div>
                                                            </c:if>
                                                        </div>

                                                        <c:if test="${fn:length(room.medias) > 1}">
                                                            <button class="carousel-nav carousel-prev" onclick="prevSlide('room${room.id}'); pauseAutoSlide();">
                                                                <i class="fas fa-chevron-left"></i>
                                                            </button>
                                                            <button class="carousel-nav carousel-next" onclick="nextSlide('room${room.id}'); pauseAutoSlide();">
                                                                <i class="fas fa-chevron-right"></i>
                                                            </button>

                                                            <!--                                                        <div class="carousel-dots">
                                                            <c:forEach var="image" items="${room.medias}" varStatus="status">
                                                                <div class="carousel-dot ${status.index == 0 ? 'active' : ''}" 
                                                                     onclick="goToSlide('room${room.id}', ${status.index}); pauseAutoSlide();"></div>
                                                            </c:forEach>
                                                        </div>-->
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-12">
                                    <i class="fas fa-bed text-6xl text-gray-300 mb-4"></i>
                                    <h3 class="text-xl font-semibold text-gray-500 mb-2">No Rooms Available</h3>
                                    <p class="text-gray-400">This homestay doesn't have any rooms listed yet.</p>
                                    <c:if test="${sessionScope.user.id == h.owner.id}">
                                        <button type="button" onclick="addRoom(${h.id})" 
                                                class="mt-4 bg-green-500 hover:bg-green-600 text-white px-6 py-3 rounded-lg font-medium transition-all duration-300 flex items-center gap-2 mx-auto shadow-lg hover:shadow-xl transform hover:-translate-y-0.5">
                                            <i class="fas fa-plus"></i>
                                            Add Your First Room
                                        </button>
                                    </c:if>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>

                <!-- Booking Section for non-owners -->
                <c:if test="${sessionScope.user.id != h.owner.id}">
                    <div class="bg-white backdrop-blur-sm rounded-2xl shadow-xl border border-white overflow-hidden p-6">
                        <label class="block text-xl font-semibold text-gray-700 mb-6 flex items-center">
                            <i class="fas fa-calendar-check text-blue-500 mr-2"></i>
                            Book This Homestay
                        </label>

                        <form action="${pageContext.request.contextPath}/booking" method="POST" class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">
                            <input type="hidden" name="homestay_id" value="${h.id}">

                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Check-in Date</label>
                                <input type="date" name="checkin_date" required 
                                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Check-out Date</label>
                                <input type="date" name="checkout_date" required 
                                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                            </div>

                            <button type="submit" 
                                    class="bg-blue-500 hover:bg-blue-600 text-white px-6 py-2 rounded-lg font-medium transition-colors">
                                <i class="fas fa-calendar-plus mr-2"></i>
                                Book Now
                            </button>
                        </form>
                    </div>
                </c:if>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
                                            let currentSlides = {};
                                            let autoSlideInterval;

                                            function initCarousel(carouselId) {
                                                console.log('Initializing carousel:', carouselId);

                                                // Initialize slide index
                                                currentSlides[carouselId] = 0;

                                                // Get the track element
                                                const trackId = carouselId + 'Track';
                                                const track = document.getElementById(trackId);

                                                if (!track) {
                                                    console.error('Track not found:', trackId);
                                                    return false;
                                                }

                                                const slides = track.children;
                                                if (slides.length === 0) {
                                                    console.warn('No slides found for carousel:', carouselId);
                                                    return false;
                                                }

                                                console.log(`Carousel ` + carouselId + ` initialized with ` + slides.length + ` slides`);

                                                // Set initial position
                                                track.style.transform = 'translateX(0%)';

                                                // Update dots
                                                updateCarouselDots(carouselId);

                                                return true;
                                            }

                                            function nextSlide(carouselId) {
                                                const trackId = carouselId + 'Track';
                                                const track = document.getElementById(trackId);

                                                if (!track) {
                                                    console.error('Track not found:', trackId);
                                                    return;
                                                }

                                                const slides = track.children;
                                                const maxSlide = slides.length - 1;

                                                // Move to next slide or loop back to first
                                                if (currentSlides[carouselId] >= maxSlide) {
                                                    currentSlides[carouselId] = 0;
                                                } else {
                                                    currentSlides[carouselId]++;
                                                }

                                                updateCarousel(carouselId);
                                            }

                                            function prevSlide(carouselId) {
                                                const trackId = carouselId + 'Track';
                                                const track = document.getElementById(trackId);

                                                if (!track) {
                                                    console.error('Track not found:', trackId);
                                                    return;
                                                }

                                                const slides = track.children;
                                                const maxSlide = slides.length - 1;

                                                if (currentSlides[carouselId] <= 0) {
                                                    currentSlides[carouselId] = maxSlide;
                                                } else {
                                                    currentSlides[carouselId]--;
                                                }

                                                updateCarousel(carouselId);
                                            }

                                            function goToSlide(carouselId, slideIndex) {
                                                const trackId = carouselId + 'Track';
                                                const track = document.getElementById(trackId);

                                                if (!track) {
                                                    console.error('Track not found:', trackId);
                                                    return;
                                                }

                                                const slides = track.children;

                                                // Validate slide index
                                                if (slideIndex < 0 || slideIndex >= slides.length) {
                                                    console.error('Invalid slide index:', slideIndex);
                                                    return;
                                                }

                                                currentSlides[carouselId] = slideIndex;
                                                updateCarousel(carouselId);
                                            }

                                            function updateCarousel(carouselId) {
                                                const trackId = carouselId + 'Track';
                                                const track = document.getElementById(trackId);

                                                if (!track) {
                                                    console.error('Track not found in updateCarousel:', trackId);
                                                    return;
                                                }

                                                const slideWidth = 100;
                                                const moveX = currentSlides[carouselId] * slideWidth;
                                                const transformValue = `translateX(-` + moveX + `%)`;

                                                track.style.transform = transformValue;

                                                updateCarouselDots(carouselId);

                                                console.log(`Carousel ${carouselId} moved to slide ` + currentSlides[carouselId]);
                                            }

                                            function updateCarouselDots(carouselId) {
                                                const carouselContainerId = carouselId + 'Carousel';
                                                const carousel = document.getElementById(carouselContainerId);

                                                if (!carousel) {
                                                    console.warn('Carousel container not found:', carouselContainerId);
                                                    return;
                                                }

                                                const dots = carousel.querySelectorAll('.carousel-dot');

                                                dots.forEach((dot, index) => {
                                                    if (index === currentSlides[carouselId]) {
                                                        dot.classList.add('active');
                                                    } else {
                                                        dot.classList.remove('active');
                                                    }
                                                });
                                            }

                                            function startAutoSlide() {
                                                if (autoSlideInterval) {
                                                    clearInterval(autoSlideInterval);
                                                }

                                                autoSlideInterval = setInterval(() => {
                                                    const homestayTrack = document.getElementById('homestayTrack');
                                                    if (homestayTrack && homestayTrack.children.length > 1) {
                                                        nextSlide('homestay');
                                                    }
                                                }, 5000);
                                            }

                                            function pauseAutoSlide() {
                                                if (autoSlideInterval) {
                                                    clearInterval(autoSlideInterval);
                                                    autoSlideInterval = null;
                                                }
                                            }

                                            function resumeAutoSlide() {
                                                pauseAutoSlide();
                                                setTimeout(startAutoSlide, 3000);
                                            }

                                            document.addEventListener('DOMContentLoaded', function () {
                                                console.log('DOM loaded - initializing carousels');

                                                if (initCarousel('homestay')) {
                                                    console.log('Homestay carousel initialized successfully');
                                                }

                                                const roomCarousels = document.querySelectorAll('[id^="roomCarousel"]');
                                                console.log(`Found ` + roomCarousels.length + ` room carousels`);

                                                roomCarousels.forEach(carousel => {
                                                    const carouselId = carousel.id.replace('Carousel', '');
                                                    console.log(`Initializing room carousel: ` + carouselId);
                                                    initCarousel(carouselId);
                                                });

                                                setupBookingDates();

                                                setTimeout(() => {
                                                    const homestayTrack = document.getElementById('homestayTrack');
                                                    if (homestayTrack && homestayTrack.children.length > 1) {
                                                        startAutoSlide();
                                                        console.log('Auto-slide started for homestay carousel');
                                                    }
                                                }, 2000);
                                            });

                                            function setupBookingDates() {
                                                const today = new Date().toISOString().split('T')[0];
                                                const checkinInput = document.querySelector('input[name="checkin_date"]');
                                                const checkoutInput = document.querySelector('input[name="checkout_date"]');

                                                if (checkinInput) {
                                                    checkinInput.min = today;

                                                    checkinInput.addEventListener('change', function () {
                                                        if (checkoutInput) {
                                                            const checkinDate = new Date(this.value);
                                                            checkinDate.setDate(checkinDate.getDate() + 1);
                                                            checkoutInput.min = checkinDate.toISOString().split('T')[0];

                                                            if (checkoutInput.value && checkoutInput.value <= this.value) {
                                                                checkoutInput.value = '';
                                                            }
                                                        }
                                                    });
                                                }
                                            }

                                            function editHomestay(homestayId) {
                                                window.location.href = `${pageContext.request.contextPath}/owner-house/edit?hid=` + homestayId;
                                            }

                                            function addRoom(homestayId) {
                                                window.location.href = `${pageContext.request.contextPath}/room/add?hid=` + homestayId;
                                            }

                                            function editRoom(roomId) {
                                                window.location.href = `${pageContext.request.contextPath}/room/edit?id=` + roomId;
                                            }

                                            function detail(roomId) {
                                                window.location.href = `${pageContext.request.contextPath}/room?id=` + roomId;
                                            }

                                            function deleteRoom(roomId) {
                                                Swal.fire({
                                                    title: 'Are you sure?',
                                                    text: "You won't be able to revert this!",
                                                    icon: 'warning',
                                                    showCancelButton: true,
                                                    confirmButtonColor: '#d33',
                                                    cancelButtonColor: '#3085d6',
                                                    confirmButtonText: 'Yes, delete it!'
                                                }).then((result) => {
                                                    if (result.isConfirmed) {
                                                        window.location.href = `${pageContext.request.contextPath}/delete-room?id=` + roomId;
                                                    }
                                                });
                                            }

                                            function showToast(message, type = 'success') {
                                                const backgroundColor = {
                                                    'success': '#10b981',
                                                    'error': '#ef4444',
                                                    'warning': '#f59e0b',
                                                    'info': '#3b82f6'
                                                };

                                                Toastify({
                                                    text: message,
                                                    duration: 3000,
                                                    gravity: "top",
                                                    position: "right",
                                                    backgroundColor: backgroundColor[type] || backgroundColor.success,
                                                    stopOnFocus: true,
                                                    close: true
                                                }).showToast();
                                            }
        </script>
    </body>
</html>