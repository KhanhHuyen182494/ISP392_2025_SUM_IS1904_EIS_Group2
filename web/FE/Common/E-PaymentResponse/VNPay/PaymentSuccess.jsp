<%-- 
    Document   : PaymentSuccess
    Created on : Jul 2, 2025, 7:40:08 AM
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
        <title>Payment - Success</title>

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
                            <div class="w-8 h-8 bg-green-500 text-white rounded-full flex items-center justify-center text-sm font-semibold">
                                <i class="fas fa-check"></i>
                            </div>
                            <div class="ml-2 text-sm font-medium text-green-600">Booking Details</div>
                        </div>
                        <div class="flex-1 h-1 bg-green-500 mx-4"></div>

                        <!-- Step 2 -->
                        <div class="flex items-center flex-1">
                            <div class="w-8 h-8 bg-green-500 text-white rounded-full flex items-center justify-center text-sm font-semibold">
                                <i class="fas fa-check"></i>
                            </div>
                            <div class="ml-2 text-sm font-medium text-green-600">Booking Options</div>
                        </div>
                        <div class="flex-1 h-1 bg-green-500 mx-4"></div>

                        <!-- Step 3 -->
                        <div class="flex items-center flex-1">
                            <div class="w-8 h-8 bg-green-500 text-white rounded-full flex items-center justify-center text-sm font-semibold">
                                <i class="fas fa-check"></i>
                            </div>
                            <div class="ml-2 text-sm font-medium text-green-600">Contract Preview</div>
                        </div>
                        <div class="flex-1 h-1 bg-green-500 mx-4"></div>

                        <!-- Step 4 - Completed -->
                        <div class="flex items-center flex-1">
                            <div class="w-8 h-8 bg-green-500 text-white rounded-full flex items-center justify-center text-sm font-semibold">
                                <i class="fas fa-check"></i>
                            </div>
                            <div class="ml-2 text-sm font-medium text-green-600">Payment</div>
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
                    <a href="#" class="hover:text-blue-600">Contract Preview</a>
                    <span>/</span>
                    <a href="#" class="hover:text-blue-600">Payment</a>
                    <span>/</span>
                    <span class="text-green-600 font-medium">Success</span>
                </nav>
            </div>

            <!-- Main Content Grid -->
            <div class="grid grid-cols-1 lg:grid-cols-4 gap-8">
                <!-- Left Side - Payment Success -->
                <div class="lg:col-span-3">
                    <!-- Success Header -->
                    <div class="bg-gradient-to-r from-green-500 to-emerald-600 rounded-lg shadow-lg p-8 mb-6 text-white text-center">
                        <div class="mb-4">
                            <div class="w-20 h-20 bg-white rounded-full flex items-center justify-center mx-auto mb-4">
                                <i class="fas fa-check text-green-500 text-3xl"></i>
                            </div>
                            <h1 class="text-3xl font-bold mb-2">Payment Successful!</h1>
                            <p class="text-green-100 text-lg">Your booking has been confirmed and payment processed successfully.</p>
                        </div>
                        <div class="bg-white bg-opacity-20 rounded-lg p-4 inline-block">
                            <div class="text-sm font-medium">Transaction ID</div>
                            <div class="text-xl font-bold">${param.vnp_TxnRef}</div>
                        </div>
                    </div>

                    <!-- Payment Details Card -->
                    <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                        <h2 class="text-2xl font-semibold text-gray-900 mb-4 flex items-center">
                            <i class="fas fa-receipt text-blue-500 mr-3"></i>
                            Payment Details
                        </h2>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="space-y-3">
                                <div class="flex justify-between items-center py-2 border-b border-gray-100">
                                    <span class="text-gray-600">Payment Method:</span>
                                    <div class="flex items-center">
                                        <img src="${pageContext.request.contextPath}/Asset/Common/Payment/vnpay.jfif" alt="VNPay" class="w-6 h-6 mr-2 rounded-full">
                                        <span class="font-medium">VNPay</span>
                                    </div>
                                </div>
                                <div class="flex justify-between items-center py-2 border-b border-gray-100">
                                    <span class="text-gray-600">Transaction ID:</span>
                                    <span class="font-medium">${param.vnp_TxnRef}</span>
                                </div>
                                <div class="flex justify-between items-center py-2 border-b border-gray-100">
                                    <span class="text-gray-600">Payment Date:</span>
                                    <span class="font-medium">
                                        <fmt:formatDate value="${p.updated_at}" pattern="dd/MM/yyyy HH:mm:ss" />
                                    </span>
                                </div>
                            </div>
                            <div class="space-y-3">
                                <div class="flex justify-between items-center py-2 border-b border-gray-100">
                                    <span class="text-gray-600">Amount Paid:</span>
                                    <span class="font-semibold text-green-600">₫<fmt:formatNumber value="${param.vnp_Amount / 100}" pattern="#,###" /></span>
                                </div>
                                <div class="flex justify-between items-center py-2 border-b border-gray-100">
                                    <span class="text-gray-600">Bank Code:</span>
                                    <span class="font-medium">${param.vnp_BankCode}</span>
                                </div>
                                <div class="flex justify-between items-center py-2 border-b border-gray-100">
                                    <span class="text-gray-600">Status:</span>
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                        <i class="fas fa-check-circle mr-1"></i>
                                        Completed
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Booking Summary Card -->
                    <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                        <h2 class="text-2xl font-semibold text-gray-900 mb-4 flex items-center">
                            <i class="fas fa-calendar-check text-green-500 mr-3"></i>
                            Booking Confirmation
                        </h2>

                        <!-- Booking Details would come from your backend -->
                        <div class="bg-gray-50 rounded-lg p-4 mb-4">
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 text-sm">
                                <div>
                                    <div class="text-gray-600 mb-1">Booking ID</div>
                                    <div class="font-semibold">BK-${param.bookingId}-<fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyyMMdd" /></div>
                                </div>
                                <div>
                                    <div class="text-gray-600 mb-1">Property</div>
                                    <div class="font-semibold">${booking.homestay.name}</div>
                                </div>
                                <div>
                                    <div class="text-gray-600 mb-1">Guests</div>
                                    <div class="font-semibold">${sessionScope.user.first_name} ${sessionScope.user.last_name}</div>
                                </div>
                            </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <h4 class="font-medium text-gray-900 mb-3">Check-in Details</h4>
                                <div class="space-y-2 text-sm">
                                    <div class="flex justify-between">
                                        <span class="text-gray-600">Date:</span>
                                        <span class="font-medium">${booking.check_in != null ? booking.check_in : 'TBD'}</span>
                                    </div>
                                    <div class="flex justify-between">
                                        <span class="text-gray-600">Time:</span>
                                        <span class="font-medium">After 12:00 PM</span>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <h4 class="font-medium text-gray-900 mb-3">Check-out Details</h4>
                                <div class="space-y-2 text-sm">
                                    <div class="flex justify-between">
                                        <span class="text-gray-600">Date:</span>
                                        <span class="font-medium">${booking.checkout != null ? booking.checkout : 'TBD'}</span>
                                    </div>
                                    <div class="flex justify-between">
                                        <span class="text-gray-600">Time:</span>
                                        <span class="font-medium">Before 11:00 AM</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Payment Breakdown -->
                        <div class="mt-6 pt-6 border-t border-gray-200">
                            <h4 class="font-medium text-gray-900 mb-3">Payment Breakdown</h4>
                            <div class="space-y-2 text-sm">
                                <div class="flex justify-between">
                                    <span class="text-gray-600">Deposit Paid (20%):</span>
                                    <span class="font-medium">₫<fmt:formatNumber value="${param.vnp_Amount / 100}" pattern="#,###" /></span>
                                </div>
                                <div class="flex justify-between text-orange-600 font-medium">
                                    <span>Balance Due at Check-in:</span>
                                    <span>₫<fmt:formatNumber value="${(param.vnp_Amount / 100) * 4}" pattern="#,###" /></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- What's Next Card -->
                    <div class="bg-blue-50 border border-blue-200 rounded-lg p-6">
                        <h3 class="text-lg font-semibold text-blue-900 mb-4 flex items-center">
                            <i class="fas fa-info-circle text-blue-600 mr-2"></i>
                            What's Next?
                        </h3>
                        <div class="space-y-4">
                            <div class="flex items-start gap-3">
                                <div class="w-8 h-8 bg-blue-100 rounded-full flex items-center justify-center flex-shrink-0">
                                    <span class="text-blue-600 font-semibold text-sm">1</span>
                                </div>
                                <div>
                                    <div class="font-medium text-blue-900">Check Your Email</div>
                                    <div class="text-blue-700 text-sm">A confirmation email with your booking details and contract has been sent to ${sessionScope.user.email}</div>
                                </div>
                            </div>
                            <div class="flex items-start gap-3">
                                <div class="w-8 h-8 bg-blue-100 rounded-full flex items-center justify-center flex-shrink-0">
                                    <span class="text-blue-600 font-semibold text-sm">2</span>
                                </div>
                                <div>
                                    <div class="font-medium text-blue-900">Contact Host (Optional)</div>
                                    <div class="text-blue-700 text-sm">Feel free to reach out to your host for any special arrangements or questions</div>
                                </div>
                            </div>
                            <div class="flex items-start gap-3">
                                <div class="w-8 h-8 bg-blue-100 rounded-full flex items-center justify-center flex-shrink-0">
                                    <span class="text-blue-600 font-semibold text-sm">3</span>
                                </div>
                                <div>
                                    <div class="font-medium text-blue-900">Prepare for Check-in</div>
                                    <div class="text-blue-700 text-sm">Bring valid ID and be ready to pay the remaining balance at check-in</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Side - Actions Panel -->
                <div class="lg:col-span-1">
                    <div class="bg-white rounded-lg shadow-lg p-6 sticky top-24 space-y-6">
                        <!-- Success Status -->
                        <div class="text-center">
                            <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-3">
                                <i class="fas fa-check-circle text-green-600 text-2xl"></i>
                            </div>
                            <h3 class="text-lg font-semibold text-gray-900 mb-2">Payment Complete</h3>
                            <p class="text-sm text-gray-600">Your booking is confirmed and ready!</p>
                        </div>

                        <!-- Quick Actions -->
                        <div class="border-t pt-4 space-y-3">
                            <a href="${pageContext.request.contextPath}/booking/contract/preview?bookId=${booking.id}" 
                               class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-4 rounded-lg transition-colors flex items-center justify-center gap-2">
                                <i class="fas fa-file-contract"></i>
                                View Contract
                            </a>
                        </div>

                        <!-- Payment Summary -->
                        <div class="border-t pt-4">
                            <h4 class="font-medium text-gray-900 mb-3">Payment Summary</h4>
                            <div class="space-y-2 text-sm">
                                <div class="flex justify-between">
                                    <span class="text-gray-600">Amount:</span>
                                    <span class="font-medium">₫<fmt:formatNumber value="${param.vnp_Amount / 100}" pattern="#,###" /></span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="text-gray-600">Method:</span>
                                    <span class="font-medium">VNPay</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="text-gray-600">Status:</span>
                                    <span class="text-green-600 font-medium">Completed</span>
                                </div>
                            </div>
                        </div>

                        <!-- Host Contact -->
                        <div class="border-t pt-4">
                            <h4 class="font-medium text-gray-900 mb-3">Host Contact</h4>
                            <div class="space-y-2 text-sm">
                                <div class="flex items-center gap-2">
                                    <i class="fas fa-user text-gray-400"></i>
                                    <span>${booking.homestay.owner.first_name} ${booking.homestay.owner.last_name}</span>
                                </div>
                                <div class="flex items-center gap-2">
                                    <i class="fas fa-phone text-gray-400"></i>
                                    <span>${booking.homestay.owner.phone}</span>
                                </div>
                                <div class="flex items-center gap-2">
                                    <i class="fas fa-envelope text-gray-400"></i>
                                    <span>${booking.homestay.owner.email}</span>
                                </div>
                            </div>
                        </div>

                        <!-- Navigation -->
                        <div class="border-t pt-4 space-y-3">
                            <a href="${pageContext.request.contextPath}/booking/history" 
                               class="w-full block text-center bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold py-3 px-4 rounded-lg transition-colors">
                                View All Bookings
                            </a>

                            <a href="${pageContext.request.contextPath}/feeds" 
                               class="w-full block text-center bg-orange-500 hover:bg-orange-600 text-white font-semibold py-3 px-4 rounded-lg transition-colors">
                                Back to Home
                            </a>
                        </div>

                        <!-- Support -->
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
                                    <span>24/7 Support</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>

        </script>
    </body>
</html>