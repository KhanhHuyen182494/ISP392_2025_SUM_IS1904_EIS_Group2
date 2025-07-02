<%-- 
    Document   : BookingDetail
    Created on : Jul 1, 2025, 3:07:54 PM
    Author     : Hien
--%>

<%-- 
    Document   : BookingContract
    Created on : Jun 30, 2025, 5:58:16 PM
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
        <title>Booking Detail</title>

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

        <!-- Breadcum -->
        <div class="mt-2">
            <div class="max-w-7xl mx-auto px-4 py-3">
                <nav class="flex" aria-label="Breadcrumb">
                    <ol class="inline-flex items-center space-x-1 md:space-x-3">
                        <li class="inline-flex items-center">
                            <a href="${pageContext.request.contextPath}/feeds" class="text-gray-700 hover:text-blue-600">
                                <i class="fas fa-home mr-2"></i>Home
                            </a>
                        </li>
                        <li>
                            <div class="flex items-center">
                                <i class="fas fa-chevron-right text-gray-400 mx-2"></i>
                                <a href="${pageContext.request.contextPath}/booking/history" class="text-gray-700 hover:text-blue-600">Bookings</a>
                            </div>
                        </li>
                        <li aria-current="page">
                            <div class="flex items-center">
                                <i class="fas fa-chevron-right text-gray-400 mx-2"></i>
                                <span class="text-gray-500">Booking Detail</span>
                            </div>
                        </li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="container mx-auto px-4 py-8 max-w-6xl">
            <div class="bg-white rounded-lg shadow-md p-4 mb-6">
                <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-800">Booking #${booking.id}</h1>
                        <p class="text-gray-600">Created on <fmt:formatDate value="${booking.created_at}" pattern="dd/MM/yyyy"/></p>
                    </div>
                    <div class="flex flex-wrap gap-2">
                        <c:if test="${booking.status.id == 9}">
                            <button onclick="printBooking()" 
                                    class="bg-orange-600 hover:bg-orange-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition-colors">
                                <i class="fas fa-download mr-1"></i>Download Contract
                            </button>
                        </c:if>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <!-- Representative Info -->
                <div class="bg-white rounded-lg shadow-md p-4 sm:p-6">
                    <h2 class="text-lg sm:text-xl font-bold text-gray-800 mb-4 flex items-center">
                        <i class="fas fa-user-tie text-blue-600 mr-2"></i>
                        Representative Information
                    </h2>
                    <div class="space-y-3">
                        <c:choose>
                            <c:when test="${booking.status.id != 8}">
                                <div class="flex flex-col sm:flex-row sm:items-center">
                                    <img src="${pageContext.request.contextPath}/Asset/Common/Avatar/default-avatar.jpg" 
                                         alt="Booker" class="w-16 h-16 rounded-full object-cover mb-3 sm:mb-0 sm:mr-4 mx-auto sm:mx-0">
                                    <div class="text-center sm:text-left">
                                        <h3 class="font-semibold text-base sm:text-lg">${booking.representative.full_name}</h3>
                                        <p class="text-gray-600 text-sm sm:text-base">${booking.representative.email}</p>
                                        <p class="text-gray-600 text-sm sm:text-base">${booking.representative.phone}</p>

                                        <div class="flex justify-center sm:justify-start gap-2 mt-2">
                                            <a href="mailto:${booking.representative.email}" 
                                               class="bg-blue-100 hover:bg-blue-200 text-blue-700 px-3 py-1 rounded-lg text-sm transition-colors">
                                                <i class="fas fa-envelope mr-1"></i>Email
                                            </a>
                                            <a href="tel:${booking.representative.phone}" 
                                               class="bg-green-100 hover:bg-green-200 text-green-700 px-3 py-1 rounded-lg text-sm transition-colors">
                                                <i class="fas fa-phone mr-1"></i>Call
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 mt-4">
                                    <div>
                                        <label class="text-sm font-medium text-gray-500">Relation</label>
                                        <p class="text-gray-800">${booking.representative.relationship}</p>
                                    </div>
                                    <div>
                                        <label class="text-sm font-medium text-gray-500">Additionals Note</label>
                                        <p class="text-gray-800">${empty booking.representative.additional_notes ? 'None' : booking.representative.additional}</p>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="flex justify-center items-center rounded-lg">
                                    <p class="text-center text-gray-600">You have not confirmed this booking yet!</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Booker Account Info -->
                <div class="bg-white rounded-lg shadow-md p-4 sm:p-6">
                    <h2 class="text-lg sm:text-xl font-bold text-gray-800 mb-4 flex items-center">
                        <i class="fas fa-user text-green-600 mr-2"></i>
                        Booker Information
                    </h2>

                    <div class="space-y-3">
                        <div class="flex flex-col sm:flex-row sm:items-center">
                            <img src="${pageContext.request.contextPath}/Asset/Common/Avatar/${sessionScope.user.avatar}" 
                                 alt="Booker" class="w-16 h-16 rounded-full object-cover mb-3 sm:mb-0 sm:mr-4 mx-auto sm:mx-0">
                            <div class="text-center sm:text-left">
                                <h3 class="font-semibold text-base sm:text-lg">${sessionScope.user.first_name} ${sessionScope.user.last_name}</h3>
                                <p class="text-gray-600 text-sm sm:text-base">${sessionScope.user.email}</p>
                                <p class="text-gray-600 text-sm sm:text-base">${empty sessionScope.user.phone ? 'No Phone Given' : sessionScope.user.phone}</p>
                            </div>
                        </div>
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-10 mt-4">
                            <div>
                                <label class="text-sm font-medium text-gray-500">ID</label>
                                <p class="text-gray-800 truncate">${sessionScope.user.id}</p>
                            </div>
                            <div>
                                <label class="text-sm font-medium text-gray-500">Join Date</label>
                                <p class="text-gray-800">
                                    <fmt:formatDate value="${sessionScope.user.created_at}" pattern="dd/MM/yyyy"/>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Booking Information Info -->
                <div class="bg-white rounded-lg shadow-md p-4 sm:p-6 lg:col-span-2">
                    <h2 class="text-lg sm:text-xl font-bold text-gray-800 mb-4 flex items-center">
                        <i class="fas fa-calendar-alt text-purple-600 mr-2"></i>
                        Booking Details
                    </h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="space-y-4">
                            <div>
                                <label class="text-sm font-medium text-gray-500">Booking ID</label>
                                <p class="text-gray-800 font-mono">#${booking.id}</p>
                            </div>
                            <div>
                                <label class="text-sm font-medium text-gray-500">Checkin</label>
                                <p class="text-gray-800">
                                    <fmt:formatDate value="${booking.check_in}" pattern="dd/MM/yyyy 12:00"/>
                                </p>
                            </div>
                            <div>
                                <label class="text-sm font-medium text-gray-500">Checkout</label>
                                <p class="text-gray-800">
                                    <fmt:formatDate value="${booking.checkout}" pattern="dd/MM/yyyy 12:00"/>
                                </p>
                            </div>
                            <div>
                                <label class="text-sm font-medium text-gray-500">Status</label>
                                <p class="inline-flex px-3 py-1 text-sm font-semibold rounded-full
                                   <c:choose>
                                       <c:when test="${booking.status.id == 8}">bg-yellow-100 text-yellow-800</c:when>
                                       <c:when test="${booking.status.id == 9}">bg-green-100 text-yellow-800</c:when>
                                       <c:when test="${booking.status.id == 10}">bg-red-100 text-red-800</c:when>
                                       <c:when test="${booking.status.id == 11}">bg-red-100 text-green-800</c:when>
                                       <c:when test="${booking.status.id == 12}">bg-red-100 text-blue-800</c:when>
                                       <c:otherwise>bg-gray-100 text-gray-800</c:otherwise>
                                   </c:choose>">
                                    ${booking.status.name}
                                </p>
                            </div>

                            <div class="mt-4 flex flex-wrap gap-2">
                                <c:if test="${booking.status.id == 8}">
                                    <button onclick="location.href = '${pageContext.request.contextPath}/booking/contract?bookId=${booking.id}'" 
                                            class="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition-colors">
                                        <i class="fas fa-check mr-1"></i>Confirm Booking
                                    </button>
                                    <button onclick="cancelBooking('${booking.id}')" 
                                            class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition-colors">
                                        <i class="fas fa-times mr-1"></i>Cancel Booking
                                    </button>
                                </c:if>

                                <c:if test="${booking.status.id == 9}">
                                    <button onclick="doPayment('${booking.id}')" 
                                            class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition-colors">
                                        <i class="fas fa-sign-in-alt mr-1"></i>Continue Payment
                                    </button>
                                </c:if>

                                <c:if test="${booking.status.id == 12}">
                                    <button onclick="checkOutBooking('${booking.id}')" 
                                            class="bg-purple-600 hover:bg-purple-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition-colors">
                                        <i class="fas fa-sign-out-alt mr-1"></i>Check Out
                                    </button>
                                </c:if>
                            </div>
                        </div>
                        <div class="space-y-4">
                            <div>
                                <label class="text-sm font-medium text-gray-500">Services fee</label>
                                <p class="text-gray-800">₫<fmt:formatNumber value="${booking.service_fee}" pattern="#,###" /></p>
                            </div>
                            <div>
                                <label class="text-sm font-medium text-gray-500">Cleaning fee</label>
                                <p class="text-gray-800">₫<fmt:formatNumber value="${booking.cleaning_fee}" pattern="#,###" /></p>
                            </div>
                            <div>
                                <label class="text-sm font-medium text-gray-500">Total Amount</label>
                                <p class="text-gray-800">₫<fmt:formatNumber value="${booking.total_price}" pattern="#,###" /></p>
                            </div>
                            <div>
                                <label class="text-sm font-medium text-gray-500">Deposit</label>
                                <p class="text-gray-800">₫<fmt:formatNumber value="${booking.deposit}" pattern="#,###" /></p>
                            </div>
                            <div>
                                <label class="text-sm font-medium text-gray-500">Special Requirements</label>
                                <p class="text-gray-800">${booking.note != null ? booking.note : 'None'}</p>
                            </div>
                        </div>
                    </div>

                    <c:if test="${not empty booking.representative.additional_notes}">
                        <div class="mt-6 p-4 bg-blue-50 rounded-lg">
                            <label class="text-sm font-medium text-gray-500">Additional Notes</label>
                            <p class="text-gray-800 mt-1">${booking.representative.additional_notes}</p>
                        </div>
                    </c:if>
                </div>

                <div class="bg-white rounded-lg shadow-md p-4 sm:p-6 lg:col-span-2">
                    <h2 class="text-lg sm:text-xl font-bold text-gray-800 mb-4 flex items-center">
                        <i class="fas fa-house text-orange-600 mr-2"></i>
                        Homestay Details
                    </h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="space-y-4">
                            <div>
                                <label class="text-sm font-medium text-gray-500">Homestay</label>
                                <p class="text-gray-800">${booking.homestay.name}</p>
                            </div>
                            <div>
                                <label class="text-sm font-medium text-gray-500">Price / night</label>
                                <c:if test="${booking.homestay.is_whole_house == true}">
                                    <p class="text-gray-800">₫<fmt:formatNumber value="${booking.homestay.price_per_night}" pattern="#,###" /></p>
                                </c:if>
                                <c:if test="${booking.homestay.is_whole_house == false}">
                                    <p class="text-gray-800">Different each room</p>
                                </c:if>
                            </div>
                            <div>
                                <label class="text-sm font-medium text-gray-500">Type</label>
                                <c:if test="${booking.homestay.is_whole_house == true}">
                                    <p class="text-gray-800">Whole House</p>
                                </c:if>
                                <c:if test="${booking.homestay.is_whole_house == false}">
                                    <p class="text-gray-800">Rooms</p>
                                </c:if>
                            </div>
                            <div>
                                <label class="text-sm font-medium text-gray-500">Address</label>
                                <p class="text-gray-800">
                                    ${booking.homestay.address.detail} ${booking.homestay.address.ward}, ${booking.homestay.address.district}, ${booking.homestay.address.province}, ${booking.homestay.address.country}
                                </p>
                            </div>
                        </div>
                        <c:if test="${booking.homestay.is_whole_house == false}">
                            <div class="space-y-4">
                                <div>
                                    <label class="text-sm font-medium text-gray-500">Room</label>
                                    <p class="text-gray-800">${booking.room.name}</p>
                                </div>
                                <div>
                                    <label class="text-sm font-medium text-gray-500">Position</label>
                                    <p class="text-gray-800">${booking.room.room_position}</p>
                                </div>
                                <div>
                                    <label class="text-sm font-medium text-gray-500">Price / night</label>
                                    <p class="text-gray-800">₫<fmt:formatNumber value="${booking.room.price_per_night}" pattern="#,###" /></p>
                                </div>
                                <div>
                                    <label class="text-sm font-medium text-gray-500">Type</label>
                                    <p class="text-gray-800">${booking.room.roomType.name}</p>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <c:if test="${not empty booking.representative.additional_notes}">
                        <div class="mt-6 p-4 bg-blue-50 rounded-lg">
                            <label class="text-sm font-medium text-gray-500">Additional Notes</label>
                            <p class="text-gray-800 mt-1">${booking.representative.additional_notes}</p>
                        </div>
                    </c:if>
                </div>

                <!-- Contract Info -->
                <div class="bg-white rounded-lg shadow-md p-4 sm:p-6 lg:col-span-2">
                    <h2 class="text-lg sm:text-xl font-bold text-gray-800 mb-4 flex items-center">
                        <i class="fas fa-file-contract text-orange-600 mr-2"></i>
                        Contract Information
                    </h2>

                    <c:choose>
                        <c:when test="${booking.status.id == 9}">

                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-8">
                                <i class="fas fa-file-contract text-gray-400 text-4xl mb-4"></i>
                                <p class="text-gray-500 text-lg">No contract available for this booking</p>
                                <c:if test="${sessionScope.user.role.id == 1}">
                                    <button onclick="generateContract(${booking.id})" 
                                            class="bg-orange-600 hover:bg-orange-700 text-white px-6 py-2 rounded-lg font-medium transition-colors mt-4 w-full sm:w-auto">
                                        <i class="fas fa-plus mr-2"></i>Generate Contract
                                    </button>
                                </c:if>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
                                        function signContract(contractId) {
                                            Swal.fire({
                                                title: 'Sign Contract',
                                                text: 'Are you sure you want to sign this contract? This action cannot be undone.',
                                                icon: 'question',
                                                showCancelButton: true,
                                                confirmButtonColor: '#16a34a',
                                                cancelButtonColor: '#dc2626',
                                                confirmButtonText: 'Yes, Sign Contract',
                                                cancelButtonText: 'Cancel'
                                            }).then((result) => {
                                                if (result.isConfirmed) {
                                                    $.ajax({
                                                        url: '${pageContext.request.contextPath}/contract/sign',
                                                        type: 'POST',
                                                        data: {contractId: contractId},
                                                        success: function (response) {
                                                            if (response.success) {
                                                                Swal.fire({
                                                                    title: 'Success!',
                                                                    text: 'Contract has been signed successfully.',
                                                                    icon: 'success'
                                                                }).then(() => {
                                                                    location.reload();
                                                                });
                                                            } else {
                                                                Swal.fire({
                                                                    title: 'Error!',
                                                                    text: response.message || 'Failed to sign contract.',
                                                                    icon: 'error'
                                                                });
                                                            }
                                                        },
                                                        error: function () {
                                                            Swal.fire({
                                                                title: 'Error!',
                                                                text: 'An error occurred while signing the contract.',
                                                                icon: 'error'
                                                            });
                                                        }
                                                    });
                                                }
                                            });
                                        }

                                        function generateContract(bookingId) {
                                            Swal.fire({
                                                title: 'Generate Contract',
                                                text: 'Generate a new contract for this booking?',
                                                icon: 'question',
                                                showCancelButton: true,
                                                confirmButtonColor: '#ea580c',
                                                cancelButtonColor: '#dc2626',
                                                confirmButtonText: 'Generate',
                                                cancelButtonText: 'Cancel'
                                            }).then((result) => {
                                                if (result.isConfirmed) {
                                                    $.ajax({
                                                        url: '${pageContext.request.contextPath}/contract/generate',
                                                        type: 'POST',
                                                        data: {bookingId: bookingId},
                                                        success: function (response) {
                                                            if (response.success) {
                                                                Swal.fire({
                                                                    title: 'Success!',
                                                                    text: 'Contract has been generated successfully.',
                                                                    icon: 'success'
                                                                }).then(() => {
                                                                    location.reload();
                                                                });
                                                            } else {
                                                                Swal.fire({
                                                                    title: 'Error!',
                                                                    text: response.message || 'Failed to generate contract.',
                                                                    icon: 'error'
                                                                });
                                                            }
                                                        },
                                                        error: function () {
                                                            Swal.fire({
                                                                title: 'Error!',
                                                                text: 'An error occurred while generating the contract.',
                                                                icon: 'error'
                                                            });
                                                        }
                                                    });
                                                }
                                            });
                                        }

                                        $(document).ready(function () {
                                            $('.search-focus').focus(function () {
                                                $(this).addClass('ring-2 ring-blue-500');
                                                $('.icon-search-focus').addClass('text-blue-500');
                                            });

                                            $('.search-focus').blur(function () {
                                                $(this).removeClass('ring-2 ring-blue-500');
                                                $('.icon-search-focus').removeClass('text-blue-500');
                                            });
                                        });
        </script>
    </body>
</html>