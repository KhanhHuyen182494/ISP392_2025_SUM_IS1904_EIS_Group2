<%-- 
    Document   : ReviewAdd
    Created on : Jul 3, 2025, 7:28:15 PM
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
        <title>Add Review</title>

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

            .star-rating {
                display: flex;
                gap: 5px;
                margin: 10px 0;
            }

            .star {
                font-size: 2rem;
                color: #ddd;
                cursor: pointer;
                transition: color 0.2s ease;
            }

            .star:hover,
            .star.active {
                color: #fbbf24;
            }

            .star:hover ~ .star {
                color: #ddd;
            }

            .form-container {
                background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            }

            .form-input {
                transition: all 0.3s ease;
            }

            .form-input:focus {
                transform: scale(1.01);
                box-shadow: 0 0 20px rgba(59, 130, 246, 0.2);
            }

            .submit-btn {
                transition: all 0.3s ease;
            }

            .submit-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 30px rgba(249, 115, 22, 0.4);
            }

            .submit-btn:disabled {
                opacity: 0.6;
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
            }

            .loading-spinner {
                border: 2px solid #f3f3f3;
                border-top: 2px solid #f97316;
                border-radius: 50%;
                width: 20px;
                height: 20px;
                animation: spin 1s linear infinite;
                display: none;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }
                100% {
                    transform: rotate(360deg);
                }
            }

            .success-message {
                display: none;
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                color: white;
                padding: 1rem;
                border-radius: 0.5rem;
                margin-bottom: 1rem;
                animation: slideIn 0.3s ease;
            }

            @keyframes slideIn {
                from {
                    transform: translateY(-20px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }

            .error-message {
                display: none;
                background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
                color: white;
                padding: 1rem;
                border-radius: 0.5rem;
                margin-bottom: 1rem;
                animation: slideIn 0.3s ease;
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
                <!-- Page Title -->
                <div class="bg-white rounded-2xl shadow-md p-6 mb-6">
                    <h1 class="text-3xl font-bold text-gray-800 mb-2">
                        <i class="fas fa-plus-circle mr-3 text-orange-500"></i>
                        Review a homestay
                    </h1>
                    <p class="text-gray-600">Share your experience and help others make informed decisions.</p>
                </div>

                <!-- Add Review Form -->
                <div class="bg-white rounded-2xl shadow-md overflow-hidden">
                    <div class="form-container p-8">
                        <!-- Success/Error Messages -->
                        <div id="successMessage" class="success-message">
                            <i class="fas fa-check-circle mr-2"></i>
                            <span id="successText">Review submitted successfully!</span>
                        </div>

                        <div id="errorMessage" class="error-message">
                            <i class="fas fa-exclamation-circle mr-2"></i>
                            <span id="errorText">Please fill in all required fields.</span>
                        </div>

                        <form id="reviewForm" class="space-y-6">
                            <!-- Property Selection -->
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div>
                                    <label for="homestayId" class="block text-sm font-medium text-gray-700 mb-2">
                                        <i class="fas fa-home mr-2 text-orange-500"></i>
                                        Property *
                                    </label>
                                    <select id="homestayId" name="homestayId" disabled=""
                                            class="bg-gray-300 form-input w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent">
                                        <option value="${b.homestay.id}" selected="">${b.homestay.name}</option>
                                    </select>
                                </div>

                                <c:if test="${b.homestay.is_whole_house == false}">
                                    <div>
                                        <label for="roomId" class="block text-sm font-medium text-gray-700 mb-2">
                                            <i class="fas fa-bed mr-2 text-orange-500"></i>
                                            Room
                                        </label>
                                        <select id="roomId" name="roomId" disabled=""
                                                class="bg-gray-300 form-input w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent">
                                            <option value="${b.room.id}" selected="">${b.room.name}</option>
                                        </select>
                                    </div>
                                </c:if>
                            </div>

                            <!-- Star Rating -->
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">
                                    <i class="fas fa-star mr-2 text-orange-500"></i>
                                    Your Rating *
                                </label>
                                <div class="star-rating" id="starRating">
                                    <i class="star fas fa-star" data-rating="1"></i>
                                    <i class="star fas fa-star" data-rating="2"></i>
                                    <i class="star fas fa-star" data-rating="3"></i>
                                    <i class="star fas fa-star" data-rating="4"></i>
                                    <i class="star fas fa-star" data-rating="5"></i>
                                </div>
                                <input type="hidden" id="starValue" name="star" value="0">
                                <p class="text-sm text-gray-500 mt-1">Click on stars to rate your experience</p>
                            </div>

                            <!-- Review Content -->
                            <div>
                                <label for="content" class="block text-sm font-medium text-gray-700 mb-2">
                                    <i class="fas fa-comment mr-2 text-orange-500"></i>
                                    Your Review *
                                </label>
                                <textarea id="content" name="content" rows="6" required
                                          placeholder="Share your detailed experience about this property. What did you like? What could be improved? Your honest feedback helps others make better decisions."
                                          class="form-input w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent resize-vertical"></textarea>
                                <div class="flex justify-between items-center mt-2">
                                    <p class="text-sm text-gray-500">Minimum 50 characters required</p>
                                    <span id="charCount" class="text-sm text-gray-400">0/1000</span>
                                </div>
                            </div>

                            <!-- Submit Button -->
                            <div class="flex items-center justify-between pt-6 border-t border-gray-200">
                                <div class="text-sm text-gray-500">
                                    <i class="fas fa-info-circle mr-1"></i>
                                    All fields marked with * are required
                                </div>
                                <div class="flex items-center gap-4">
                                    <a href="${pageContext.request.contextPath}/review" 
                                       class="px-6 py-3 bg-gray-500 hover:bg-gray-600 text-white rounded-lg font-medium transition-colors">
                                        <i class="fas fa-times mr-2"></i>Cancel
                                    </a>
                                    <button type="submit" id="submitBtn" 
                                            class="submit-btn px-8 py-3 bg-orange-500 hover:bg-orange-600 text-white rounded-lg font-medium transition-colors flex items-center gap-2">
                                        <div class="loading-spinner" id="loadingSpinner"></div>
                                        <i class="fas fa-paper-plane" id="submitIcon"></i>
                                        <span id="submitText">Submit Review</span>
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Tips Section -->
                <div class="bg-blue-50 rounded-2xl shadow-md p-6 mt-6">
                    <h3 class="text-lg font-semibold text-blue-800 mb-4">
                        <i class="fas fa-lightbulb mr-2"></i>
                        Tips for Writing a Great Review
                    </h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm text-blue-700">
                        <div class="flex items-start gap-2">
                            <i class="fas fa-check text-green-500 mt-1"></i>
                            <span>Be specific about your experience</span>
                        </div>
                        <div class="flex items-start gap-2">
                            <i class="fas fa-check text-green-500 mt-1"></i>
                            <span>Mention both positives and areas for improvement</span>
                        </div>
                        <div class="flex items-start gap-2">
                            <i class="fas fa-check text-green-500 mt-1"></i>
                            <span>Include details about cleanliness, location, and amenities</span>
                        </div>
                        <div class="flex items-start gap-2">
                            <i class="fas fa-check text-green-500 mt-1"></i>
                            <span>Be honest and helpful for future guests</span>
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
                // Character count for review content
                $('#content').on('input', function () {
                    const length = $(this).val().length;
                    $('#charCount').text(length + '/1000');

                    if (length > 1000) {
                        $(this).val($(this).val().substring(0, 1000));
                        $('#charCount').text('1000/1000').addClass('text-red-500');
                    } else {
                        $('#charCount').removeClass('text-red-500');
                    }
                });

                // Star rating functionality
                $('.star').on('click', function () {
                    const rating = $(this).data('rating');
                    $('#starValue').val(rating);

                    $('.star').removeClass('active');
                    for (let i = 1; i <= rating; i++) {
                        $(`.star[data-rating="` + i + `"]`).addClass('active');
                    }
                });

                // Star hover effect
                $('.star').on('mouseenter', function () {
                    const rating = $(this).data('rating');
                    $('.star').removeClass('active');
                    for (let i = 1; i <= rating; i++) {
                        $(`.star[data-rating="` + i + `"]`).addClass('active');
                    }
                });

                // Reset stars on mouse leave
                $('#starRating').on('mouseleave', function () {
                    const currentRating = $('#starValue').val();
                    $('.star').removeClass('active');
                    for (let i = 1; i <= currentRating; i++) {
                        $(`.star[data-rating="` + i + `"]`).addClass('active');
                    }
                });

                // Form submission
                $('#reviewForm').on('submit', function (e) {
                    e.preventDefault();

                    // Hide previous messages
                    $('#successMessage, #errorMessage').hide();

                    // Validate form
                    if (!validateForm()) {
                        return;
                    }

                    // Show loading state
                    showLoadingState();

                    // Prepare form data
                    const formData = {
                        homestayId: $('#homestayId').val(),
                        roomId: $('#roomId').val() || null,
                        star: $('#starValue').val(),
                        content: $('#content').val()
                    };

                    // Submit via AJAX
                    $.ajax({
                        url: '${pageContext.request.contextPath}/review/add',
                        method: 'POST',
                        data: formData,
                        success: function (response) {
                            hideLoadingState();

                            // Reset form
                            $('#reviewForm')[0].reset();
                            $('#starValue').val(0);
                            $('.star').removeClass('active');
                            $('#charCount').text('0/1000');

                            // Show success toast
                            Toastify({
                                text: "Review submitted successfully!",
                                duration: 3000,
                                gravity: "top",
                                position: "right",
                                backgroundColor: "linear-gradient(to right, #00b09b, #96c93d)",
                            }).showToast();

                            // Redirect after 2 seconds
                            setTimeout(function () {
                                window.location.href = '${pageContext.request.contextPath}/review';
                            }, 2000);
                        },
                        error: function (xhr) {
                            hideLoadingState();
                            let errorMsg = 'An error occurred while submitting your review.';

                            if (xhr.responseJSON && xhr.responseJSON.message) {
                                errorMsg = xhr.responseJSON.message;
                            }

                            // Show error toast
                            Toastify({
                                text: errorMsg,
                                duration: 3000,
                                gravity: "top",
                                position: "right",
                                backgroundColor: "linear-gradient(to right, #ff5f6d, #ffc371)",
                            }).showToast();
                        }
                    });
                });

                // Form validation
                function validateForm() {
                    const homestayId = $('#homestayId').val();
                    const star = $('#starValue').val();
                    const content = $('#content').val();

                    if (!homestayId) {
                        showToast('Please select a property.', 'error');
                        return false;
                    }

                    if (!star || star == 0) {
                        showToast('Please provide a star rating.', 'error');
                        return false;
                    }

                    if (!content || content.length < 50) {
                        showToast('Review content must be at least 50 characters long.', 'error');
                        return false;
                    }

                    return true;
                }

                // Show loading state
                function showLoadingState() {
                    $('#submitBtn').prop('disabled', true);
                    $('#loadingSpinner').show();
                    $('#submitIcon').hide();
                    $('#submitText').text('Submitting...');
                }

                function showToast(message, type = 'success') {
                    Toastify({
                        text: message,
                        duration: 3000,
                        gravity: "top",
                        position: "right",
                        backgroundColor: type === 'success' ? '#10B981' : '#EF4444',
                        stopOnFocus: true
                    }).showToast();
                }

                // Hide loading state
                function hideLoadingState() {
                    $('#submitBtn').prop('disabled', false);
                    $('#loadingSpinner').hide();
                    $('#submitIcon').show();
                    $('#submitText').text('Submit Review');
                }
            });
        </script>
    </body>
</html>