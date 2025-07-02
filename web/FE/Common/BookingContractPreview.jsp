<%-- 
    Document   : BookingContractPreview
    Created on : Jul 1, 2025, 7:47:07 PM
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
        <title>Contract Preview</title>

        <!-- Libs -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
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
                    <div class="flex items-center w-full max-w-7xl">
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
                                <i class="fas fa-check"></i>
                            </div>
                            <div class="ml-2 text-sm font-medium text-blue-600">Booking Options</div>
                        </div>
                        <!-- Connector -->
                        <div class="flex-1 h-1 bg-blue-500 mx-4"></div>
                        <!-- Step 3 -->
                        <div class="flex items-center flex-1">
                            <div class="w-8 h-8 bg-blue-500 text-white rounded-full flex items-center justify-center text-sm font-semibold">
                                3
                            </div>
                            <div class="ml-2 text-sm font-medium text-blue-600">Contract Preview</div>
                        </div>
                        <!-- Connector -->
                        <div class="flex-1 h-1 bg-gray-300 mx-4"></div>
                        <!-- Step 4 -->
                        <div class="flex items-center flex-1">
                            <div class="w-8 h-8 bg-gray-300 text-gray-600 rounded-full flex items-center justify-center text-sm font-semibold">
                                4
                            </div>
                            <div class="ml-2 text-sm font-medium text-gray-500">Payment</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Breadcrumb -->
            <div class="mb-6">
                <nav class="flex items-center space-x-2 text-sm text-gray-600">
                    <a href="${pageContext.request.contextPath}/feeds" class="hover:text-blue-600">
                        <i class="fas fa-home"></i> Home
                    </a>
                    <span>/</span>
                    <a href="#" class="hover:text-blue-600">Booking</a>
                    <span>/</span>
                    <span class="text-gray-900">Contract Preview</span>
                </nav>
            </div>

            <!-- Main Content Grid -->
            <div class="grid grid-cols-1 lg:grid-cols-4 gap-8">
                <!-- Left Side - Contract Preview -->
                <div class="lg:col-span-3">
                    <!-- Contract Header -->
                    <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                        <div class="flex items-center justify-between mb-4">
                            <h1 class="text-3xl font-bold text-gray-900">Booking Contract</h1>
                            <div class="flex items-center gap-4">
                                <div class="flex items-center text-green-600">
                                    <i class="fas fa-file-contract mr-2"></i>
                                    <span class="text-sm font-medium">Ready for Download</span>
                                </div>
                                <button id="downloadPdfBtn" class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-lg font-medium transition-colors flex items-center gap-2">
                                    <i class="fas fa-download"></i>
                                    Download PDF
                                </button>
                            </div>
                        </div>
                        <p class="text-gray-600">Your booking contract is ready. Review the details below and download your copy for your records.</p>
                    </div>

                    <!-- Contract Document Preview -->
                    <div class="bg-white rounded-lg shadow-md overflow-hidden">
                        <!-- Document Header -->
                        <div class="bg-gradient-to-r from-blue-600 to-purple-600 text-white p-6">
                            <div class="text-center">
                                <h2 class="text-2xl font-bold mb-2">HOMESTAY BOOKING CONTRACT</h2>
                                <div class="text-blue-100">Contract #BK-${b.id}-<fmt:formatDate value="${b.created_at}" pattern="yyyyMMdd" /></div>
                            </div>
                        </div>

                        <!-- Contract Content -->
                        <div id="contractContent" class="p-8 space-y-8 bg-white">
                            <!-- Contract Date & Parties -->
                            <div class="border-b pb-6">
                                <div class="text-center mb-6">
                                    <h3 class="text-xl font-semibold text-gray-900 mb-2">BOOKING AGREEMENT</h3>
                                    <p class="text-gray-600">This contract is made on <strong><fmt:formatDate value="${b.created_at}" pattern="EEEE, MMMM dd, yyyy" /></strong></p>
                                </div>

                                <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                                    <!-- Guest Information -->
                                    <div>
                                        <h4 class="font-semibold text-gray-900 mb-3 flex items-center">
                                            <i class="fas fa-user text-blue-500 mr-2"></i>
                                            GUEST INFORMATION
                                        </h4>
                                        <div class="space-y-2 text-sm">
                                            <div><strong>Name:</strong> ${sessionScope.user.first_name} ${sessionScope.user.last_name}</div>
                                            <div><strong>Email:</strong> ${sessionScope.user.email}</div>
                                            <div><strong>Phone:</strong> ${sessionScope.user.phone}</div>
                                            <div><strong>Booking Date:</strong> <fmt:formatDate value="${b.created_at}" pattern="dd/MM/yyyy HH:mm" /></div>
                                        </div>
                                    </div>

                                    <!-- Host Information -->
                                    <div>
                                        <h4 class="font-semibold text-gray-900 mb-3 flex items-center">
                                            <i class="fas fa-home text-green-500 mr-2"></i>
                                            HOST INFORMATION
                                        </h4>
                                        <div class="space-y-2 text-sm">
                                            <div><strong>Name:</strong> ${b.homestay.owner.first_name} ${b.homestay.owner.last_name}</div>
                                            <div><strong>Email:</strong> ${b.homestay.owner.email}</div>
                                            <div><strong>Phone:</strong> ${b.homestay.owner.phone}</div>
                                            <div><strong>Property:</strong> ${b.homestay.name}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Representative Information (if provided) -->
                            <c:if test="${not empty b.representative.full_name}">
                                <div class="border-b pb-6">
                                    <h4 class="font-semibold text-gray-900 mb-3 flex items-center">
                                        <i class="fas fa-user-tie text-purple-500 mr-2"></i>
                                        AUTHORIZED REPRESENTATIVE
                                    </h4>
                                    <div class="bg-gray-50 p-4 rounded-lg">
                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
                                            <div><strong>Name:</strong> ${b.representative.full_name}</div>
                                            <div><strong>Phone:</strong> ${b.representative.phone}</div>
                                            <div><strong>Email:</strong> ${b.representative.email}</div>
                                            <div><strong>Relationship:</strong> ${b.representative.relationship}</div>
                                            <c:if test="${not empty b.representative.additional_notes}">
                                                <div class="md:col-span-2"><strong>Notes:</strong> ${b.representative.additional_notes}</div>
                                            </c:if>
                                        </div>
                                        <div class="mt-3 p-3 bg-yellow-50 border border-yellow-200 rounded text-xs text-yellow-800">
                                            <strong>Note:</strong> The above representative is authorized to check-in on behalf of the primary guest and must present valid identification.
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Property Details -->
                            <div class="border-b pb-6">
                                <h4 class="font-semibold text-gray-900 mb-3 flex items-center">
                                    <i class="fas fa-building text-indigo-500 mr-2"></i>
                                    PROPERTY DETAILS
                                </h4>
                                <div class="grid ${b.room.id != null ? 'grid-cols-1 md:grid-cols-2' : ''}  gap-6">
                                    <div class="space-y-2 text-sm">
                                        <div><strong>Property Name:</strong> ${b.homestay.name}</div>
                                        <div><strong>Property Type:</strong> 
                                            <c:choose>
                                                <c:when test="${b.homestay.is_whole_house == true}">Whole House</c:when>
                                                <c:otherwise>Room Booking</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div><strong>Star Rating:</strong> ${b.homestay.star} stars</div>
                                        <div><strong>Full Address:</strong> ${b.homestay.address.detail}, ${b.homestay.address.ward}, ${b.homestay.address.district}, ${b.homestay.address.province}</div>
                                    </div>
                                    <c:if test="${b.room.id != null}">
                                        <div class="space-y-2 text-sm">
                                            <div><strong>Room Name:</strong> ${b.room.name}</div>
                                            <div><strong>Room Rating:</strong> ${b.room.star} stars</div>
                                            <!--<div><strong>Max Guests:</strong> ${b.room.max_guests} persons</div>-->
                                        </div>
                                    </c:if>
                                </div>
                            </div>

                            <!-- Booking Terms -->
                            <div class="border-b pb-6">
                                <h4 class="font-semibold text-gray-900 mb-3 flex items-center">
                                    <i class="fas fa-calendar-alt text-orange-500 mr-2"></i>
                                    BOOKING TERMS
                                </h4>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 text-sm">
                                    <div class="space-y-3">
                                        <div class="flex justify-between">
                                            <span><strong>Check-in Date:</strong></span>
                                            <span><fmt:formatDate value="${b.check_in}" pattern="EEEE, dd/MM/yyyy" /></span>
                                        </div>
                                        <div class="flex justify-between">
                                            <span><strong>Check-out Date:</strong></span>
                                            <span><fmt:formatDate value="${b.checkout}" pattern="EEEE, dd/MM/yyyy" /></span>
                                        </div>
                                        <div class="flex justify-between">
                                            <span><strong>Duration:</strong></span>
                                            <span>
                                                <c:if test="${b.homestay.is_whole_house == true}">
                                                    ${(b.total_price - b.service_fee - b.cleaning_fee) / b.homestay.price_per_night} nights
                                                </c:if>
                                                <c:if test="${b.homestay.is_whole_house == false}">
                                                    ${(b.total_price - b.service_fee - b.cleaning_fee) / b.room.price_per_night} nights
                                                </c:if>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="space-y-3">
                                        <div class="flex justify-between">
                                            <span><strong>Check-in Time:</strong></span>
                                            <span>After 12:00 PM</span>
                                        </div>
                                        <div class="flex justify-between">
                                            <span><strong>Check-out Time:</strong></span>
                                            <span>Before 11:00 AM</span>
                                        </div>
                                        <div class="flex justify-between">
                                            <span><strong>Booking Status:</strong></span>
                                            <span class="text-yellow-600 font-medium">${b.status.name}</span>
                                        </div>
                                    </div>
                                </div>

                                <c:if test="${not empty b.note}">
                                    <div class="mt-4 p-3 bg-gray-50 rounded-lg">
                                        <strong class="text-sm">Special Requests:</strong>
                                        <p class="text-sm text-gray-700 mt-1">${b.note}</p>
                                    </div>
                                </c:if>
                            </div>

                            <!-- Payment Details -->
                            <div class="border-b pb-6">
                                <h4 class="font-semibold text-gray-900 mb-3 flex items-center">
                                    <i class="fas fa-money-bill-wave text-green-500 mr-2"></i>
                                    PAYMENT BREAKDOWN
                                </h4>
                                <div class="bg-gray-50 p-4 rounded-lg">
                                    <div class="space-y-3 text-sm">
                                        <div class="flex justify-between">
                                            <span>
                                                <c:if test="${b.homestay.is_whole_house == true}">
                                                    Accommodation (₫<fmt:formatNumber value="${b.homestay.price_per_night}" pattern="#,###" /> × ${(b.total_price - b.service_fee - b.cleaning_fee) / b.homestay.price_per_night} nights)
                                                </c:if>
                                                <c:if test="${b.homestay.is_whole_house == false}">
                                                    Room Rate (₫<fmt:formatNumber value="${b.room.price_per_night}" pattern="#,###" /> × ${(b.total_price - b.service_fee - b.cleaning_fee) / b.room.price_per_night} nights)
                                                </c:if>
                                            </span>
                                            <span>₫<fmt:formatNumber value="${b.total_price - b.service_fee - b.cleaning_fee}" pattern="#,###" /></span>
                                        </div>
                                        <div class="flex justify-between">
                                            <span>Service Fee</span>
                                            <span>₫<fmt:formatNumber value="${b.service_fee}" pattern="#,###" /></span>
                                        </div>
                                        <div class="flex justify-between">
                                            <span>Cleaning Fee</span>
                                            <span>₫<fmt:formatNumber value="${b.cleaning_fee}" pattern="#,###" /></span>
                                        </div>
                                        <div class="border-t pt-3 flex justify-between font-semibold text-lg">
                                            <span>Total Amount</span>
                                            <span>₫<fmt:formatNumber value="${b.total_price}" pattern="#,###" /></span>
                                        </div>
                                        <div class="border-t pt-3 flex justify-between text-blue-600 font-semibold">
                                            <span>Deposit Paid (20%)</span>
                                            <span>₫<fmt:formatNumber value="${b.deposit}" pattern="#,###" /></span>
                                        </div>
                                        <div class="flex justify-between text-orange-600 font-semibold">
                                            <span>Balance Due at Check-in</span>
                                            <span>₫<fmt:formatNumber value="${b.total_price - b.deposit}" pattern="#,###" /></span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Terms and Conditions Summary -->
                            <div class="border-b pb-6">
                                <h4 class="font-semibold text-gray-900 mb-3 flex items-center">
                                    <i class="fas fa-gavel text-red-500 mr-2"></i>
                                    TERMS AND CONDITIONS SUMMARY
                                </h4>
                                <div class="text-sm text-gray-700 space-y-3">
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                        <div>
                                            <h5 class="font-medium text-gray-900 mb-2">Cancellation Policy:</h5>
                                            <ul class="space-y-1 text-xs">
                                                <li>• Free cancellation up to 48 hours before check-in</li>
                                                <li>• Cancellations within 48 hours forfeit deposit</li>
                                                <li>• No-shows result in full charge</li>
                                            </ul>
                                        </div>
                                        <div>
                                            <h5 class="font-medium text-gray-900 mb-2">House Rules:</h5>
                                            <ul class="space-y-1 text-xs">
                                                <li>• Check-in: After 12:00 PM</li>
                                                <li>• Check-out: Before 11:00 AM</li>
                                                <li>• Quiet hours: 10:00 PM - 8:00 AM</li>
                                                <li>• No smoking indoors</li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="mt-4 p-3 bg-blue-50 border-l-4 border-blue-400 text-xs">
                                        <strong>Important:</strong> By proceeding with this booking, both parties agree to all terms and conditions as outlined in the full contract agreement. This document serves as a legally binding contract.
                                    </div>
                                </div>
                            </div>

                            <!-- Signatures Section -->
                            <div>
                                <h4 class="font-semibold text-gray-900 mb-4 flex items-center">
                                    <i class="fas fa-signature text-purple-500 mr-2"></i>
                                    DIGITAL AGREEMENT
                                </h4>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                                    <div class="text-center p-4 border-2 border-dashed border-gray-300 rounded-lg">
                                        <div class="mb-2">
                                            <strong>Guest Agreement</strong>
                                        </div>
                                        <div class="text-sm text-gray-600 mb-3">
                                            Digitally agreed on:<br>
                                            <fmt:formatDate value="${b.created_at}" pattern="dd/MM/yyyy HH:mm:ss" />
                                        </div>
                                        <div class="text-lg font-semibold text-blue-600">
                                            ${sessionScope.user.first_name} ${sessionScope.user.last_name}
                                        </div>
                                        <div class="text-xs text-gray-500 mt-2">Digital Signature</div>
                                    </div>
                                    <div class="text-center p-4 border-2 border-dashed border-gray-300 rounded-lg">
                                        <div class="mb-2">
                                            <strong>Host Acknowledgment</strong>
                                        </div>
                                        <div class="text-sm text-gray-600 mb-3">
                                            Property managed by:<br>
                                            FUHF Platform
                                        </div>
                                        <div class="text-lg font-semibold text-green-600">
                                            ${b.homestay.owner.first_name} ${b.homestay.owner.last_name}
                                        </div>
                                        <div class="text-xs text-gray-500 mt-2">Host Representative</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Contract Footer -->
                            <div class="text-center text-xs text-gray-500 border-t pt-4">
                                <p>This contract was generated electronically by FUHF Homestay Platform on <fmt:formatDate value="${b.created_at}" pattern="EEEE, MMMM dd, yyyy 'at' HH:mm:ss" />.</p>
                                <p>Contract Reference: BK-${b.id}-<fmt:formatDate value="${b.created_at}" pattern="yyyyMMdd" /> | Platform Version: 2.0</p>
                                <p class="mt-2">For support, contact: support@fuhf.com | Emergency: +84 123 456 789</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Side - Actions Panel -->
                <div class="lg:col-span-1">
                    <div class="bg-white rounded-lg shadow-lg p-6 sticky top-24 space-y-6">
                        <!-- Contract Status -->
                        <div class="text-center">
                            <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-3">
                                <i class="fas fa-check-circle text-green-600 text-2xl"></i>
                            </div>
                            <h3 class="text-lg font-semibold text-gray-900 mb-2">Contract Ready</h3>
                            <p class="text-sm text-gray-600">Your booking contract has been generated and is ready for download.</p>
                        </div>

                        <!-- Quick Info -->
                        <div class="border-t pt-4">
                            <h4 class="font-medium text-gray-900 mb-3">Contract Details</h4>
                            <div class="space-y-2 text-sm">
                                <div class="flex justify-between gap-2">
                                    <span class="text-gray-600">ContractID:</span>
                                    <span class="font-medium truncate">BK-${b.id}-<fmt:formatDate value="${b.created_at}" pattern="yyyyMMdd" /></span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="text-gray-600">Generated:</span>
                                    <span class="font-medium"><fmt:formatDate value="${b.created_at}" pattern="dd/MM/yyyy" /></span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="text-gray-600">Status:</span>
                                    <span class="text-green-600 font-medium">Active</span>
                                </div>
                            </div>
                        </div>

                        <!-- Actions -->
                        <div class="border-t pt-4 space-y-3">
                            <!-- Payment Methods -->
                            <div class="mb-6">
                                <form action="${pageContext.request.contextPath}/payment" method="POST">
                                    <h4 class="font-medium text-gray-900 mb-3">Payment Method</h4>
                                    <input type="hidden" name="deposit" value="${b.deposit}" />
                                    <input type="hidden" name="bookId" value="${b.id}" />
                                    <div class="space-y-2 mb-2">
                                        <label class="flex items-center p-3 border border-gray-300 rounded-lg cursor-pointer hover:bg-gray-50">
                                            <input type="radio" name="paymentMethod" value="vnpay" class="mr-3" checked>
                                            <img src="${pageContext.request.contextPath}/Asset/Common/Payment/vnpay.jfif" alt="VNPay" class="w-8 h-8 mr-3 rounded-[50%]">
                                            <span class="font-medium">VNPay</span>
                                        </label>
                                    </div>
                                    <div>
                                        <button type="submit" 
                                                id="proceedPaymentBtn"
                                                class="w-full bg-orange-500 hover:bg-orange-600 disabled:bg-gray-400 disabled:cursor-not-allowed text-white font-semibold py-3 px-4 rounded-lg transition-colors">
                                            Pay 
                                        </button>
                                    </div>
                                </form>
                            </div>

                            <button id="downloadPdfBtn2" class="w-full bg-red-600 hover:bg-red-700 text-white font-semibold py-3 px-4 rounded-lg transition-colors flex items-center justify-center gap-2">
                                <i class="fas fa-file-pdf"></i>
                                Download Contract
                            </button>

                            <button id="emailContractBtn" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-4 rounded-lg transition-colors flex items-center justify-center gap-2">
                                <i class="fas fa-envelope"></i>
                                Email Copy
                            </button>
                        </div>

                        <!-- Next Steps -->
                        <div class="border-t pt-4">
                            <h4 class="font-medium text-gray-900 mb-3">Next Steps</h4>
                            <div class="space-y-3 text-sm">
                                <div class="flex items-start gap-3 p-3 bg-blue-50 rounded-lg">
                                    <i class="fas fa-info-circle text-blue-500 mt-0.5"></i>
                                    <div>
                                        <div class="font-medium text-blue-900">Save Your Contract</div>
                                        <div class="text-blue-700">Download and keep a copy for your records</div>
                                    </div>
                                </div>
                                <div class="flex items-start gap-3 p-3 bg-green-50 rounded-lg">
                                    <i class="fas fa-calendar-check text-green-500 mt-0.5"></i>
                                    <div>
                                        <div class="font-medium text-green-900">Prepare for Check-in</div>
                                        <div class="text-green-700">Arrive after 12:00 PM on your check-in date</div>
                                    </div>
                                </div>
                                <div class="flex items-start gap-3 p-3 bg-orange-50 rounded-lg">
                                    <i class="fas fa-credit-card text-orange-500 mt-0.5"></i>
                                    <div>
                                        <div class="font-medium text-orange-900">Balance Payment</div>
                                        <div class="text-orange-700">Pay remaining balance at check-in</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Contact Info -->
                        <div class="border-t pt-4">
                            <h4 class="font-medium text-gray-900 mb-3">Need Help?</h4>
                            <div class="space-y-2 text-sm text-gray-600">
                                <div class="flex items-center gap-2">
                                    <i class="fas fa-phone text-blue-500"></i>
                                    <span>+84 123 456 789</span>
                                </div>
                                <div class="flex items-center gap-2">
                                    <i class="fas fa-envelope text-blue-500"></i>
                                    <span>support@fuhf.com</span>
                                </div>
                                <div class="flex items-center gap-2">
                                    <i class="fas fa-clock text-blue-500"></i>
                                    <span>24/7 Customer Support</span>
                                </div>
                            </div>
                        </div>

                        <!-- Back to Bookings -->
                        <div class="border-t pt-4">
                            <a href="${pageContext.request.contextPath}/booking/history" 
                               class="w-full block text-center bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold py-3 px-4 rounded-lg transition-colors">
                                View All Bookings
                            </a>
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
                $('#downloadPdfBtn, #downloadPdfBtn2').on('click', function () {
                    const button = $(this);
                    const originalHtml = button.html();
                    const bookId = '${b.id}';

                    button.html('<i class="fas fa-spinner fa-spin mr-2"></i>Generating PDF...');
                    button.prop('disabled', true);

                    setTimeout(() => {
                        const contractId = 'BK-' + bookId + '-<fmt:formatDate value="${b.created_at}" pattern="yyyyMMdd" />';
                        const filename = `Contract_` + contractId + `.pdf`;

                        $.ajax({
                            url: '${pageContext.request.contextPath}/contract/generate',
                            type: 'GET',
                            data: {
                                bookId: bookId,
                                filename: filename
                            },
                            success: function (response) {
                                window.open(response.path + '.pdf');
                            }
                        });

                        Swal.fire({
                            icon: 'success',
                            title: 'PDF Generated!',
                            text: 'Your contract PDF has been generated successfully.',
                            timer: 2000,
                            timerProgressBar: true,
                            showConfirmButton: false
                        });

                        button.html(originalHtml);
                        button.prop('disabled', false);

                    }, 2000);
                });

                $('#emailContractBtn').on('click', function () {
                    const button = $(this);
                    const originalHtml = button.html();

                    button.html('<i class="fas fa-spinner fa-spin mr-2"></i>Sending...');
                    button.prop('disabled', true);

                    Swal.fire({
                        title: 'Email Contract',
                        text: 'Send a copy of this contract to your email address?',
                        icon: 'question',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes, Send Email',
                        cancelButtonText: 'Cancel'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            setTimeout(() => {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Email Sent!',
                                    text: 'A copy of your contract has been sent to your email address.',
                                    timer: 3000,
                                    timerProgressBar: true,
                                    showConfirmButton: false
                                });

                                // $.ajax({
                                //     url: '/api/email-contract',
                                //     method: 'POST',
                                //     data: {
                                //         contractId: 'BK-${b.id}',
                                //         email: '${sessionScope.user.email}'
                                //     },
                                //     success: function(response) {
                                //         // Handle success
                                //     },
                                //     error: function(xhr, status, error) {
                                //         // Handle error
                                //     }
                                // });
                            }, 1500);
                        }

                        button.html(originalHtml);
                        button.prop('disabled', false);
                    });
                });

                $('.search-focus').on('focus', function () {
                    $(this).addClass('ring-2 ring-blue-500');
                    $('.icon-search-focus').addClass('text-blue-500');
                });

                $('.search-focus').on('blur', function () {
                    $(this).removeClass('ring-2 ring-blue-500');
                    $('.icon-search-focus').removeClass('text-blue-500');
                });

                $('a[href^="#"]').on('click', function (e) {
                    e.preventDefault();
                    const target = $($(this).attr('href'));
                    if (target.length) {
                        $('html, body').animate({
                            scrollTop: target.offset().top - 100
                        }, 500);
                    }
                });

                function showToast(message, type = 'success') {
                    Toastify({
                        text: message,
                        duration: 3000,
                        gravity: 'top',
                        position: 'right',
                        backgroundColor: type === 'success' ? '#10B981' :
                                type === 'error' ? '#EF4444' :
                                type === 'warning' ? '#F59E0B' : '#3B82F6',
                        stopOnFocus: true,
                        onClick: function () {}
                    }).showToast();
                }

                function showLoadingOverlay() {
                    const overlay = $(`
            <div id="loadingOverlay" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
                <div class="bg-white p-6 rounded-lg flex items-center gap-3">
                    <i class="fas fa-spinner fa-spin text-blue-500"></i>
                    <span>Processing...</span>
                </div>
            </div>
        `);
                    $('body').append(overlay);
                }

                function hideLoadingOverlay() {
                    $('#loadingOverlay').remove();
                }

                $('form').on('submit', function () {
                    showLoadingOverlay();
                });

                $('.alert').each(function () {
                    const alert = $(this);
                    setTimeout(() => {
                        alert.fadeOut();
                    }, 5000);
                });

                $('.action-btn').hover(
                        function () {
                            $(this).addClass('transform scale-105 shadow-lg');
                        },
                        function () {
                            $(this).removeClass('transform scale-105 shadow-lg');
                        }
                );

                $('.progress-bar').each(function () {
                    const progress = $(this);
                    const width = progress.data('width') || '100%';
                    progress.animate({width: width}, 1000);
                });

                $('.mobile-menu-toggle').on('click', function () {
                    $('.mobile-menu').toggleClass('hidden');
                });

                $('.section-toggle').on('click', function () {
                    const target = $($(this).data('target'));
                    target.slideToggle();
                    $(this).find('i').toggleClass('fa-chevron-down fa-chevron-up');
                });

                $('.copy-contract-id').on('click', function () {
                    const contractId = $(this).data('contract-id');
                    navigator.clipboard.writeText(contractId).then(() => {
                        showToast('Contract ID copied to clipboard!');
                    });
                });

                $('#downloadPdfBtn, #downloadPdfBtn2').on('click', function () {
                    trackEvent('download_pdf');
                });

                $('#printContractBtn').on('click', function () {
                    trackEvent('print_contract');
                });

                $('#emailContractBtn').on('click', function () {
                    trackEvent('email_contract');
                });

                $(window).on('scroll', function () {
                    localStorage.setItem('contractScrollPosition', $(window).scrollTop());
                });

                const savedScrollPosition = localStorage.getItem('contractScrollPosition');
                if (savedScrollPosition) {
                    $(window).scrollTop(savedScrollPosition);
                    localStorage.removeItem('contractScrollPosition');
                }

                $('.share-contract').on('click', function () {
                    if (navigator.share) {
                        navigator.share({
                            title: 'Booking Contract',
                            text: 'My homestay booking contract',
                            url: window.location.href
                        });
                    } else {
                        navigator.clipboard.writeText(window.location.href).then(() => {
                            showToast('Contract URL copied to clipboard!');
                        });
                    }
                });

                console.log('Booking contract preview page initialized');
            });
        </script>
    </body>
</html>