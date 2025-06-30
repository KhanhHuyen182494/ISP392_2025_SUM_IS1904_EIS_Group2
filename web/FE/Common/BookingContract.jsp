<%-- 
    Document   : BookingContract
    Created on : Jun 30, 2025, 5:58:16 PM
    Author     : Hien
--%>

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
        <title>Booking Contract</title>

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
    <body class="bg-gray-50">
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
            <!-- Progress Bar -->
            <div class="mb-8">
                <div class="flex items-center justify-center">
                    <div class="flex items-center w-full max-w-2xl">
                        <!-- Step 1 -->
                        <div class="flex items-center flex-1">
                            <div class="w-8 h-8 bg-blue-500 text-white rounded-full flex items-center justify-center text-sm font-semibold">
                                <i class="fas fa-check"></i>
                            </div>
                            <div class="ml-2 text-sm font-medium text-blue-600">Booking Details</div>
                        </div>
                        <!-- Connector -->
                        <div class="flex-1 h-1 bg-blue-500 mx-4"></div>
                        <!-- Step 2 -->
                        <div class="flex items-center flex-1">
                            <div class="w-8 h-8 bg-blue-500 text-white rounded-full flex items-center justify-center text-sm font-semibold">
                                2
                            </div>
                            <div class="ml-2 text-sm font-medium text-blue-600">Contract Review</div>
                        </div>
                        <!-- Connector -->
                        <div class="flex-1 h-1 bg-gray-300 mx-4"></div>
                        <!-- Step 3 -->
                        <div class="flex items-center flex-1">
                            <div class="w-8 h-8 bg-gray-300 text-gray-600 rounded-full flex items-center justify-center text-sm font-semibold">
                                3
                            </div>
                            <div class="ml-2 text-sm font-medium text-gray-500">Payment</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content Grid -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <!-- Left Side - Contract Content -->
                <div class="lg:col-span-2">
                    <!-- Breadcrumb -->
                    <div class="mb-6">
                        <nav class="flex items-center space-x-2 text-sm text-gray-600">
                            <a href="${pageContext.request.contextPath}/feeds" class="hover:text-blue-600">
                                <i class="fas fa-home"></i> Home
                            </a>
                            <span>/</span>
                            <a href="#" class="hover:text-blue-600">Booking</a>
                            <span>/</span>
                            <span class="text-gray-900">Contract Review</span>
                        </nav>
                    </div>

                    <!-- Contract Header -->
                    <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                        <div class="flex items-center justify-between mb-4">
                            <h1 class="text-2xl font-bold text-gray-900">Booking Contract</h1>
                            <div class="flex items-center text-green-600">
                                <i class="fas fa-shield-alt mr-2"></i>
                                <span class="text-sm font-medium">Secure Booking</span>
                            </div>
                        </div>
                        <p class="text-gray-600">Please review the terms and conditions of your booking carefully before proceeding to payment.</p>
                    </div>

                    <!-- Property Information -->
                    <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                        <h2 class="text-xl font-semibold text-gray-900 mb-4">Property Information</h2>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <div class="aspect-video rounded-lg overflow-hidden mb-4">
                                    <c:choose>
                                        <c:when test="${not empty b.homestay.medias and fn:length(b.homestay.medias) > 0}">
                                            <img src="${pageContext.request.contextPath}/Asset/Common/House/${b.homestay.medias[0].path}" 
                                                 alt="Property image" 
                                                 class="w-full h-full object-cover">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="w-full h-full bg-gray-200 flex items-center justify-center">
                                                <i class="fas fa-home text-gray-400 text-3xl"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div>
                                <h3 class="text-lg font-semibold text-gray-900 mb-2">${b.homestay.name}</h3>
                                <div class="space-y-2 text-sm text-gray-600">
                                    <div class="flex items-start">
                                        <i class="fas fa-map-marker-alt text-red-500 mr-2 mt-1 flex-shrink-0"></i>
                                        <span>${b.homestay.address.detail} ${b.homestay.address.ward}, ${b.homestay.address.district}, ${b.homestay.address.province}</span>
                                    </div>
                                    <div class="flex items-center">
                                        <i class="fas fa-star text-yellow-500 mr-2"></i>
                                        <span>${b.homestay.star} stars</span>
                                    </div>
                                    <div class="flex items-center">
                                        <i class="fas fa-user text-blue-500 mr-2"></i>
                                        <span>Host: ${b.homestay.owner.first_name} ${b.homestay.owner.last_name}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <c:if test="${b.room.id != null}">
                        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                            <h2 class="text-xl font-semibold text-gray-900 mb-4">Property Information</h2>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div>
                                    <div class="aspect-video rounded-lg overflow-hidden mb-4">
                                        <c:choose>
                                            <c:when test="${not empty b.room.medias and fn:length(b.room.medias) > 0}">
                                                <img src="${pageContext.request.contextPath}/Asset/Common/Room/${b.room.medias[0].path}" 
                                                     alt="Property image" 
                                                     class="w-full h-full object-cover">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="w-full h-full bg-gray-200 flex items-center justify-center">
                                                    <i class="fas fa-home text-gray-400 text-3xl"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div>
                                    <h3 class="text-lg font-semibold text-gray-900 mb-2">${b.room.name}</h3>
                                    <div class="space-y-2 text-sm text-gray-600">
                                        <div class="flex items-center">
                                            <i class="fas fa-star text-yellow-500 mr-2"></i>
                                            <span>${b.room.star} stars</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Booking Details -->
                    <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                        <h2 class="text-xl font-semibold text-gray-900 mb-4">Booking Details</h2>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="space-y-4">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-1">Check-in Date</label>
                                    <div class="flex items-center text-gray-900">
                                        <i class="fas fa-calendar-check text-green-500 mr-2"></i>
                                        <span class="font-medium">
                                            <fmt:formatDate value="${b.check_in}" pattern="EEEE, dd/MM/yyyy" />
                                        </span>
                                    </div>
                                    <div class="text-sm text-gray-500 ml-6">After 12:00 PM</div>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-1">Check-out Date</label>
                                    <div class="flex items-center text-gray-900">
                                        <i class="fas fa-calendar-times text-red-500 mr-2"></i>
                                        <span class="font-medium">
                                            <fmt:formatDate value="${b.checkout}" pattern="EEEE, dd/MM/yyyy" />
                                        </span>
                                    </div>
                                    <div class="text-sm text-gray-500 ml-6">Before 11:00 AM</div>
                                </div>
                            </div>
                            <div class="space-y-4">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-1">Duration</label>
                                    <div class="flex items-center text-gray-900">
                                        <i class="fas fa-clock text-blue-500 mr-2"></i>
                                        <span class="font-medium">${(b.total_price - b.service_fee - b.cleaning_fee) / b.homestay.price_per_night} nights</span>
                                    </div>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-1">Booking Type</label>
                                    <div class="flex items-center text-gray-900">
                                        <c:choose>
                                            <c:when test="${b.homestay.is_whole_house == true}">
                                                <i class="fas fa-home text-purple-500 mr-2"></i>
                                                <span class="font-medium">Whole House</span>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-bed text-purple-500 mr-2"></i>
                                                <span class="font-medium">Room Booking</span>
                                                <c:if test="${not empty bookingData.selectedRoom}">
                                                    <span class="text-gray-600 ml-2">(${bookingData.selectedRoom.name})</span>
                                                </c:if>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <c:if test="${not empty bookingData.specialRequests}">
                            <div class="mt-4 pt-4 border-t">
                                <label class="block text-sm font-medium text-gray-700 mb-2">Special Requests</label>
                                <div class="bg-gray-50 rounded-lg p-3 text-sm text-gray-700">
                                    ${bookingData.specialRequests}
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <!-- Terms and Conditions -->
                    <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                        <h2 class="text-xl font-semibold text-gray-900 mb-4">Terms and Conditions</h2>
                        <div class="space-y-4 text-sm text-gray-700 max-h-64 overflow-y-auto border border-gray-200 rounded-lg p-4">
                            <div>
                                <h4 class="font-semibold text-gray-900 mb-2">1. Booking and Payment Terms</h4>
                                <ul class="list-disc pl-5 space-y-1">
                                    <li>A deposit of 20% of the total booking amount is required to confirm your reservation.</li>
                                    <li>The remaining balance must be paid upon check-in or as agreed with the host.</li>
                                    <li>All payments are processed securely through our platform.</li>
                                    <li>Prices are subject to change until booking is confirmed.</li>
                                </ul>
                            </div>

                            <div>
                                <h4 class="font-semibold text-gray-900 mb-2">2. Cancellation Policy</h4>
                                <ul class="list-disc pl-5 space-y-1">
                                    <li>Free cancellation up to 48 hours before check-in date.</li>
                                    <li>Cancellations within 48 hours will forfeit the deposit.</li>
                                    <li>No-shows will result in full charge of the booking amount.</li>
                                    <li>Weather-related cancellations may be subject to different terms.</li>
                                </ul>
                            </div>

                            <div>
                                <h4 class="font-semibold text-gray-900 mb-2">3. House Rules and Responsibilities</h4>
                                <ul class="list-disc pl-5 space-y-1">
                                    <li>Check-in time is after 3:00 PM, check-out is before 11:00 AM.</li>
                                    <li>Maximum occupancy as specified in booking details must be respected.</li>
                                    <li>No smoking indoors, pets allowed only with prior permission.</li>
                                    <li>Guests are responsible for any damage to the property during their stay.</li>
                                    <li>Quiet hours are from 10:00 PM to 8:00 AM.</li>
                                    <li>Parties and events require prior approval from the host.</li>
                                </ul>
                            </div>

                            <div>
                                <h4 class="font-semibold text-gray-900 mb-2">4. Safety and Security</h4>
                                <ul class="list-disc pl-5 space-y-1">
                                    <li>Guests must follow all safety instructions provided by the host.</li>
                                    <li>Report any safety concerns or damages immediately.</li>
                                    <li>Keep doors locked and secure personal belongings.</li>
                                    <li>Emergency contact numbers will be provided upon check-in.</li>
                                </ul>
                            </div>

                            <div>
                                <h4 class="font-semibold text-gray-900 mb-2">5. Privacy and Data Protection</h4>
                                <ul class="list-disc pl-5 space-y-1">
                                    <li>Your personal information is protected according to our Privacy Policy.</li>
                                    <li>Photos and reviews may be used for promotional purposes with your consent.</li>
                                    <li>Communication between guests and hosts may be monitored for safety.</li>
                                </ul>
                            </div>

                            <div>
                                <h4 class="font-semibold text-gray-900 mb-2">6. Dispute Resolution</h4>
                                <ul class="list-disc pl-5 space-y-1">
                                    <li>Any disputes will be handled through our customer service team first.</li>
                                    <li>Unresolved issues may be subject to mediation or arbitration.</li>
                                    <li>Local laws and regulations apply to all bookings.</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- Agreement Checkbox -->
                    <div class="bg-white rounded-lg shadow-md p-6">
                        <div class="flex items-start space-x-3">
                            <input type="checkbox" 
                                   id="agreeTerms" 
                                   class="mt-1 h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded">
                            <label for="agreeTerms" class="text-sm text-gray-700">
                                <span class="font-medium">I agree to the terms and conditions</span> and confirm that I have read and understood all the booking details, house rules, and cancellation policies outlined above. I acknowledge that I am responsible for adhering to all terms during my stay.
                            </label>
                        </div>

                        <div class="flex items-start space-x-3 mt-4">
                            <input type="checkbox" 
                                   id="agreePrivacy" 
                                   class="mt-1 h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded">
                            <label for="agreePrivacy" class="text-sm text-gray-700">
                                I consent to the collection and processing of my personal data as described in the <a href="#" class="text-blue-600 hover:underline">Privacy Policy</a>.
                            </label>
                        </div>

                        <div class="flex items-start space-x-3 mt-4">
                            <input type="checkbox" 
                                   id="agreeMarketing" 
                                   class="mt-1 h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded">
                            <label for="agreeMarketing" class="text-sm text-gray-700">
                                <span class="font-medium">(Optional)</span> I would like to receive promotional emails and updates about special offers.
                            </label>
                        </div>
                    </div>
                </div>

                <!-- Right Side - Booking Summary -->
                <div class="lg:col-span-1">
                    <div class="bg-white rounded-lg shadow-lg p-6 sticky top-24">
                        <h3 class="text-xl font-semibold text-gray-900 mb-4">Booking Summary</h3>

                        <!-- Guest Information -->
                        <div class="mb-6 pb-4 border-b">
                            <h4 class="font-medium text-gray-900 mb-2">Guest Information</h4>
                            <div class="flex items-center">
                                <img src="${pageContext.request.contextPath}/Asset/Common/Avatar/${sessionScope.user.avatar}" 
                                     alt="Guest avatar" 
                                     class="w-10 h-10 rounded-full object-cover mr-3">
                                <div>
                                    <div class="font-medium text-gray-900">${sessionScope.user.first_name} ${sessionScope.user.last_name}</div>
                                    <div class="text-sm text-gray-600">${sessionScope.user.email}</div>
                                </div>
                            </div>
                        </div>

                        <!-- Price Breakdown -->
                        <div class="space-y-3 mb-6">
                            <div class="flex justify-between">
                                <span class="text-gray-600">
                                    ₫<fmt:formatNumber value="${b.homestay.price_per_night}" pattern="#,###" /> × ${(b.total_price - b.service_fee - b.cleaning_fee) / b.homestay.price_per_night} nights
                                </span>
                                <span>₫<fmt:formatNumber value="${b.total_price - b.service_fee - b.cleaning_fee}" pattern="#,###" /></span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-600">Service fee</span>
                                <span>₫<fmt:formatNumber value="${b.service_fee}" pattern="#,###" /></span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-600">Cleaning fee</span>
                                <span>₫<fmt:formatNumber value="${b.cleaning_fee}" pattern="#,###" /></span>
                            </div>
                        </div>

                        <!-- Total -->
                        <div class="border-t pt-4 mb-6">
                            <div class="flex justify-between text-lg font-semibold">
                                <span>Total</span>
                                <span>₫<fmt:formatNumber value="${b.total_price}" pattern="#,###" /></span>
                            </div>
                        </div>

                        <!-- Deposit Information -->
                        <div class="bg-blue-50 p-4 rounded-lg mb-6">
                            <div class="flex justify-between items-center">
                                <div>
                                    <div class="font-medium text-blue-900">Due Now (Deposit)</div>
                                    <div class="text-sm text-blue-700">20% of total amount</div>
                                </div>
                                <div class="text-lg font-bold text-blue-900">₫<fmt:formatNumber value="${b.deposit}" pattern="#,###" /></div>
                            </div>
                        </div>

                        <!-- Payment Methods -->
                        <div class="mb-6">
                            <h4 class="font-medium text-gray-900 mb-3">Payment Method</h4>
                            <div class="space-y-2">
                                <label class="flex items-center p-3 border border-gray-300 rounded-lg cursor-pointer hover:bg-gray-50">
                                    <input type="radio" name="paymentMethod" value="vnpay" class="mr-3" checked>
                                    <img src="${pageContext.request.contextPath}/Asset/Common/Payment/vnpay.png" alt="VNPay" class="w-8 h-8 mr-3">
                                    <span class="font-medium">VNPay</span>
                                </label>
                                <label class="flex items-center p-3 border border-gray-300 rounded-lg cursor-pointer hover:bg-gray-50">
                                    <input type="radio" name="paymentMethod" value="momo" class="mr-3">
                                    <img src="${pageContext.request.contextPath}/Asset/Common/Payment/momo.png" alt="MoMo" class="w-8 h-8 mr-3">
                                    <span class="font-medium">MoMo</span>
                                </label>
                                <label class="flex items-center p-3 border border-gray-300 rounded-lg cursor-pointer hover:bg-gray-50">
                                    <input type="radio" name="paymentMethod" value="bank" class="mr-3">
                                    <i class="fas fa-university text-blue-500 w-8 text-center mr-3"></i>
                                    <span class="font-medium">Bank Transfer</span>
                                </label>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="space-y-3">
                            <form action="${pageContext.request.contextPath}/booking/process-payment" method="POST">
                                <!-- Include all booking data -->
                                <input type="hidden" name="homestayId" value="${bookingData.homestay.id}">
                                <input type="hidden" name="bookingType" value="${bookingData.bookingType}">
                                <c:if test="${not empty bookingData.selectedRoom}">
                                    <input type="hidden" name="selectedRoom" value="${bookingData.selectedRoom.id}">
                                </c:if>
                                <input type="hidden" name="checkIn" value="<fmt:formatDate value='${bookingData.checkInDate}' pattern='yyyy-MM-dd' />">
                                <input type="hidden" name="checkOut" value="<fmt:formatDate value='${bookingData.checkOutDate}' pattern='yyyy-MM-dd' />">
                                <input type="hidden" name="specialRequests" value="${bookingData.specialRequests}">

                                <button type="submit" 
                                        id="proceedPaymentBtn"
                                        disabled
                                        class="w-full bg-orange-500 hover:bg-orange-600 disabled:bg-gray-400 disabled:cursor-not-allowed text-white font-semibold py-3 px-4 rounded-lg transition-colors">
                                    Proceed to Payment
                                </button>
                            </form>

                            <a href="${pageContext.request.contextPath}/booking?hid=${bookingData.homestay.id}" 
                               class="w-full block text-center bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold py-3 px-4 rounded-lg transition-colors">
                                Back to Booking
                            </a>
                        </div>

                        <div class="text-center text-sm text-gray-600 mt-4">
                            <i class="fas fa-lock mr-1"></i>
                            Your payment information is secure and encrypted
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
                // Handle agreement checkboxes
                function checkAgreements() {
                    const termsChecked = $('#agreeTerms').is(':checked');
                    const privacyChecked = $('#agreePrivacy').is(':checked');

                    if (termsChecked && privacyChecked) {
                        $('#proceedPaymentBtn').prop('disabled', false);
                    } else {
                        $('#proceedPaymentBtn').prop('disabled', true);
                    }
                }

                $('#agreeTerms, #agreePrivacy').on('change', checkAgreements);

                // Handle payment method selection
                $('input[name="paymentMethod"]').on('change', function () {
                    const selectedMethod = $(this).val();

                    // Remove active class from all payment options
                    $('input[name="paymentMethod"]').closest('label').removeClass('border-blue-500 bg-blue-50');

                    // Add active class to selected option
                    $(this).closest('label').addClass('border-blue-500 bg-blue-50');

                    // Store selected payment method for form submission
                    $('<input>').attr({
                        type: 'hidden',
                        name: 'paymentMethod',
                        value: selectedMethod
                    }).appendTo('form');

                    console.log('Selected payment method:', selectedMethod);
                });

                // Form submission validation
                $('form').on('submit', function (e) {
                    const termsChecked = $('#agreeTerms').is(':checked');
                    const privacyChecked = $('#agreePrivacy').is(':checked');
                    const paymentMethodSelected = $('input[name="paymentMethod"]:checked').val();

                    if (!termsChecked || !privacyChecked) {
                        e.preventDefault();

                        Swal.fire({
                            icon: 'warning',
                            title: 'Agreement Required',
                            text: 'Please agree to the terms and conditions and privacy policy to proceed.',
                            confirmButtonColor: '#f97316'
                        });
                        return false;
                    }

                    if (!paymentMethodSelected) {
                        e.preventDefault();

                        Swal.fire({
                            icon: 'warning',
                            title: 'Payment Method Required',
                            text: 'Please select a payment method to proceed.',
                            confirmButtonColor: '#f97316'
                        });
                        return false;
                    }

                    // Show loading state
                    $('#proceedPaymentBtn').html('<i class="fas fa-spinner fa-spin mr-2"></i>Processing...').prop('disabled', true);

                    // Show confirmation dialog
                    Swal.fire({
                        icon: 'info',
                        title: 'Processing Payment',
                        text: 'Redirecting to payment gateway...',
                        timer: 2000,
                        timerProgressBar: true,
                        showConfirmButton: false,
                        allowOutsideClick: false
                    });
                });

                // Smooth scroll for terms and conditions
                $('.terms-scroll').on('scroll', function () {
                    const scrollTop = $(this).scrollTop();
                    const scrollHeight = $(this)[0].scrollHeight - $(this).height();
                    const scrollPercent = (scrollTop / scrollHeight) * 100;

                    // You can add a progress indicator here if needed
                    console.log('Terms scroll progress:', Math.round(scrollPercent) + '%');
                });

                // Auto-save form data to sessionStorage (if needed for page refresh)
                function saveFormData() {
                    const formData = {
                        agreeTerms: $('#agreeTerms').is(':checked'),
                        agreePrivacy: $('#agreePrivacy').is(':checked'),
                        agreeMarketing: $('#agreeMarketing').is(':checked'),
                        paymentMethod: $('input[name="paymentMethod"]:checked').val()
                    };

                    try {
                        sessionStorage.setItem('bookingFormData', JSON.stringify(formData));
                    } catch (e) {
                        console.log('SessionStorage not available');
                    }
                }

                // Restore form data on page load
                function restoreFormData() {
                    try {
                        const savedData = sessionStorage.getItem('bookingFormData');
                        if (savedData) {
                            const formData = JSON.parse(savedData);

                            $('#agreeTerms').prop('checked', formData.agreeTerms);
                            $('#agreePrivacy').prop('checked', formData.agreePrivacy);
                            $('#agreeMarketing').prop('checked', formData.agreeMarketing);

                            if (formData.paymentMethod) {
                                $(`input[name="paymentMethod"][value="${formData.paymentMethod}"]`).prop('checked', true).trigger('change');
                            }

                            checkAgreements();
                        }
                    } catch (e) {
                        console.log('Could not restore form data');
                    }
                }

                // Save form data on checkbox/radio changes
                $('input[type="checkbox"], input[type="radio"]').on('change', saveFormData);

                // Initialize
                restoreFormData();

                // Handle back button confirmation
                $('a[href*="booking?hid="]').on('click', function (e) {
                    const hasChanges = $('#agreeTerms').is(':checked') || $('#agreePrivacy').is(':checked') || $('#agreeMarketing').is(':checked');

                    if (hasChanges) {
                        e.preventDefault();

                        Swal.fire({
                            icon: 'question',
                            title: 'Leave Page?',
                            text: 'You have made selections on this page. Are you sure you want to go back?',
                            showCancelButton: true,
                            confirmButtonText: 'Yes, go back',
                            cancelButtonText: 'Stay here',
                            confirmButtonColor: '#f97316'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                // Clear saved data and navigate
                                try {
                                    sessionStorage.removeItem('bookingFormData');
                                } catch (e) {
                                    console.log('Could not clear saved data');
                                }
                                window.location.href = $(this).attr('href');
                            }
                        });
                    }
                });

                // Add visual feedback for form interactions
                $('input[type="checkbox"]').on('change', function () {
                    const label = $(this).next('label');
                    if ($(this).is(':checked')) {
                        label.addClass('text-blue-700');
                    } else {
                        label.removeClass('text-blue-700');
                    }
                });

                // Add keyboard navigation support
                $(document).on('keydown', function (e) {
                    // Press 'T' to toggle terms agreement
                    if (e.key === 't' || e.key === 'T') {
                        if (!$('input').is(':focus')) {
                            $('#agreeTerms').click();
                        }
                    }

                    // Press 'P' to toggle privacy agreement
                    if (e.key === 'p' || e.key === 'P') {
                        if (!$('input').is(':focus')) {
                            $('#agreePrivacy').click();
                        }
                    }
                });

                // Validate payment method format (if needed for future enhancements)
                function validatePaymentSelection() {
                    const selectedMethod = $('input[name="paymentMethod"]:checked').val();

                    switch (selectedMethod) {
                        case 'vnpay':
                        case 'momo':
                        case 'bank':
                            return true;
                        default:
                            return false;
                    }
                }

                // Add visual loading state for better UX
                function showLoadingState(button) {
                    const originalText = button.html();
                    button.data('original-text', originalText);
                    button.html('<i class="fas fa-spinner fa-spin mr-2"></i>Processing...');
                    button.prop('disabled', true);
                }

                function hideLoadingState(button) {
                    const originalText = button.data('original-text');
                    button.html(originalText);
                    button.prop('disabled', false);
                }

                // Error handling for form submission
                window.addEventListener('beforeunload', function (e) {
                    if ($('#proceedPaymentBtn').prop('disabled') && $('#proceedPaymentBtn').html().includes('Processing')) {
                        e.preventDefault();
                        e.returnValue = 'Payment is being processed. Are you sure you want to leave?';
                    }
                });
            });
        </script>
    </body>
</html>