<%-- 
    Document   : ChangePassword
    Created on : Jun 1, 2025, 4:43:19 AM
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
        <title>Change Password</title>

        <!-- Libs -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <link href="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://cdn.tailwindcss.com"></script>
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
        <div class="max-w-[40rem] mx-auto mt-16 px-4">
            <!-- Title with Icon -->
            <div class="text-center mb-8">
                <div class="inline-flex items-center">
                    <div class="w-15 h-15 rounded-full flex items-center justify-center mr-3">
                        <img src="${pageContext.request.contextPath}/Asset/FUHF Logo/3.svg" width="80" />
                    </div>
                    <h1 class="text-[35px] font-medium text-orange-500">Change password</h1>
                </div>
            </div>

            <!-- OTP Form -->
            <div class="bg-white rounded-lg border border-orange-200 p-6">
                <h2 class="text-lg font-medium text-gray-900 mb-4">OTP sent to your mail</h2>

                <p class="text-sm text-gray-600 mb-6">
                    We have sent a OTP to ${sessionScope.user.email}
                </p>

                <div class="mb-6">
                    <input 
                        id="otp"
                        type="text" 
                        placeholder="OTP" 
                        class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent"
                        >
                </div>

                <div class="flex justify-end space-x-3">
                    <button class="px-6 py-2 bg-gray-400 text-white rounded-md hover:bg-gray-500 transition-colors" onclick="location.href = '${pageContext.request.contextPath}/profile?uid=${sessionScope.user.id}'">
                        Cancel
                    </button>
                    <button id="confirmOtp" class="px-8 py-2 bg-orange-500 text-white rounded-md hover:bg-orange-600 transition-colors">
                        Next
                    </button>
                </div>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
                        $('document').ready(function () {
                            const confirmBtn = $('#confirmOtp');
                            const otpInput = $('#otp');

                            otpInput.on('keypress', function (e) {
                                if (e.which === 13) {
                                    confirmBtn.click();
                                }
                            });

                            confirmBtn.on('click', function () {
                                let otp = otpInput.val().trim();

                                if (!otp) {
                                    showToast("OTP cannot be blank!", "error");
                                    otpInput.focus();
                                    return;
                                }

                                confirmBtn.prop('disabled', true);
                                confirmBtn.html('<i class="fas fa-spinner fa-spin mr-2"></i>Verifying...');

                                $.ajax({
                                    url: '${pageContext.request.contextPath}/verify-otp',
                                    type: 'GET',
                                    data: {
                                        otp: otp
                                    },
                                    success: function (response) {
                                        if (response.ok) {
                                            showToast("OTP verified successfully!", "success");
                                            setTimeout(() => {
                                                location.href = '${pageContext.request.contextPath}/change-password';
                                            }, 1000);
                                        } else {
                                            showToast(response.message, 'error');
                                            otpInput.focus();
                                        }
                                    },
                                    error: function (xhr, status, error) {
                                        console.error('AJAX Error:', error);
                                        showToast("An error occurred while verifying OTP. Please try again.", 'error');
                                    },
                                    complete: function () {
                                        confirmBtn.prop('disabled', false);
                                        confirmBtn.html('Next');
                                    }
                                });
                            });
                        });

                        function showToast(message, type = 'success') {
                            let backgroundColor;
                            if (type === "success") {
                                backgroundColor = "linear-gradient(to right, #00b09b, #96c93d)";
                            } else if (type === "error") {
                                backgroundColor = "linear-gradient(to right, #ff416c, #ff4b2b)";
                            } else if (type === "warning") {
                                backgroundColor = "linear-gradient(to right, #ffa502, #ff6348)";
                            } else if (type === "info") {
                                backgroundColor = "linear-gradient(to right, #1e90ff, #3742fa)";
                            } else {
                                backgroundColor = "#333";
                            }

                            Toastify({
                                text: message,
                                duration: 3000, // Increased duration for better UX
                                close: true,
                                gravity: "top",
                                position: "right",
                                backgroundColor: backgroundColor,
                                stopOnFocus: true
                            }).showToast();
                        }
        </script>
    </body>
</html>
