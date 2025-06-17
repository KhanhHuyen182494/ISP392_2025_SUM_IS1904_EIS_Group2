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
                                        <img class="rounded-[50%]" src="${pageContext.request.contextPath}/Asset/Common/Avatar/${sessionScope.user.avatar}" width="40"/>
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
            <!-- Sidebar - Top Review Section -->
            <!--            <div class="col-span-4">
                            <div class="bg-white rounded-2xl shadow-md p-6 sticky top-24">
                                <div class="flex items-center justify-between mb-6">
                                    <h2 class="text-xl font-bold text-gray-800">Top House/Room</h2>
                                    <div class="filter-top-house-room flex items-center gap-5">
                                        <div class="filter-button">
                                            <button class="bg-gray-200 hover:bg-gray-300 text-gray-600 rounded-lg font-medium transition-colors px-2">Booking</button>
                                            <button class="bg-gray-200 hover:bg-gray-300 text-gray-600 rounded-lg font-medium transition-colors px-2">Star</button>
                                        </div>
                                        <i class="fas fa-star text-yellow-500"></i>
                                    </div>
                                </div>
            
                                 Top Review Items 
                                <div class="space-y-4">
                                     Review items 
            <c:choose>
                <c:when test="${not empty requestScope.topHouseRoom}">
                    <div class="flex items-start gap-3 p-3 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors cursor-pointer items-center">
                        <div class="w-10 h-10 bg-gradient-to-r from-green-400 to-blue-500 rounded-full flex items-center justify-center flex-shrink-0">
                            <i class="fas fa-user text-white text-sm"></i>
                        </div>
                        <div class="flex-1 min-w-0">
                            <div class="flex items-center gap-2 mb-1">
                                <span class="font-semibold text-sm text-gray-800">An Thu House - Phong 402</span>
                                <div class="flex text-yellow-400">
                                    <i class="fas fa-star text-xs"></i>
                                    <i class="fas fa-star text-xs"></i>
                                    <i class="fas fa-star text-xs"></i>
                                    <i class="fas fa-star text-xs"></i>
                                    <i class="fas fa-star text-xs"></i>
                                </div>
                            </div>
                            <p class="text-xs text-gray-600 line-clamp-2">104 Reviews</p>
                            <span class="text-xs text-gray-400">2 days ago</span>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center p-2 mb-3">
                        <p class="text-gray-500 decoration-wavy">No top house/room available!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

         View All Button 
        <button class="w-full mt-6 bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700 text-white py-2 rounded-lg text-sm font-medium transition-all">
            View All Review
        </button>
    </div>
</div>-->

            <!-- Main Feed -->
            <div class="col-span-12">
                <!-- Feed Items -->
                <c:choose>
                    <c:when test="${not empty requestScope.posts}">
                        <c:forEach items="${requestScope.posts}" var="post">
                            <div class="bg-white rounded-2xl shadow-lg mb-8 overflow-hidden card-hover">
                                <!-- User Info -->
                                <div class="p-6 pb-4">
                                    <div class="flex items-center justify-between mb-4">
                                        <div class="flex items-center gap-3">
                                            <div class="w-12 h-12 bg-gray-200 rounded-full flex items-center justify-center">
                                                <a href="${pageContext.request.contextPath}/profile?uid=${post.owner.id}">
                                                    <img class="rounded-[50%]" src="${pageContext.request.contextPath}/Asset/Common/Avatar/${post.owner.avatar}" />
                                                </a>
                                            </div>
                                            <div>
                                                <c:choose>
                                                    <c:when test="${sessionScope.user_id == post.owner.id}">
                                                        <a href="${pageContext.request.contextPath}/profile?uid=${post.owner.id}"><h3 class="font-semibold text-gray-800">Posted by You</h3></a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="${pageContext.request.contextPath}/profile?uid=${post.owner.id}"><h3 class="font-semibold text-gray-800">${post.owner.first_name} ${post.owner.last_name}</h3></a>
                                                    </c:otherwise>
                                                </c:choose>
                                                <p class="text-sm text-gray-500">Posted on <fmt:formatDate value="${post.created_at}" pattern="HH:mm dd/MM/yyyy" /></p>
                                            </div>
                                        </div>
                                        <div class="flex gap-2">
                                            <span class="tag-hover bg-gray-100 text-gray-600 px-3 py-1 rounded-full text-xs cursor-pointer">Tag</span>
                                            <span class="tag-hover bg-gray-100 text-gray-600 px-3 py-1 rounded-full text-xs cursor-pointer">Tag</span>
                                            <span class="tag-hover bg-gray-100 text-gray-600 px-3 py-1 rounded-full text-xs cursor-pointer">Tag</span>
                                            <span class="tag-hover bg-gray-100 text-gray-600 px-3 py-1 rounded-full text-xs cursor-pointer">Tag</span>
                                        </div>
                                    </div>

                                    <p class="text-lg mb-4">
                                        ${post.content}
                                    </p>

                                    <!-- Property Title -->
                                    <h2 class="text-xl font-bold text-gray-800 mb-3">${post.house.name} ${not empty post.room.id ? ' - ' + post.room.id : ''}</h2>

                                    <!-- Description -->
                                    <p class="text-gray-600 mb-4">
                                        ${post.house.description}
                                    </p>

                                    <!-- Property Details -->
                                    <div class="space-y-2 mb-4">
                                        <div class="flex items-center gap-2">
                                            <i class="fas fa-dollar-sign text-green-500"></i>
                                            <span class="text-sm"><strong>Giá 1 đêm:</strong> <fmt:formatNumber value="${post.house.price_per_night}" type="number" groupingUsed="true" maxFractionDigits="0" /> vnđ / đêm</span>
                                        </div>
                                        <div class="flex items-center gap-2">
                                            <i class="fas fa-map-marker-alt text-red-500"></i>
                                            <span class="text-sm"><strong>Địa chỉ:</strong> ${post.house.address.detail} ${post.house.address.ward}, ${post.house.address.district}, ${post.house.address.province}, ${post.house.address.country}</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Images -->
                                <div class="px-6 pb-4">
                                    <div class="grid grid-cols-2 gap-4"> 
                                        <c:forEach items="${post.medias}" var="media">
                                            <div class="bg-gray-200 h-48 rounded-[20px] flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer">
                                                <img class="rounded-[20px] h-48 w-full object-cover" src="${media.path}" onclick="showImageModal('${media.path}')"/>
                                            </div>
                                        </c:forEach> 
                                    </div>
                                </div>

                                <!-- Action Bar -->
                                <div class="px-6 py-4 flex items-center justify-between">
                                    <div class="flex items-center gap-4">
                                        <button data-post-id="${post.id}" 
                                                class="like-btn ${post.likedByCurrentUser ? 'liked' : ''} flex items-center gap-2 px-3 py-2 rounded-lg bg-white text-blue-500 border border-blue-500 hover:bg-blue-500 hover:text-white transition-colors" 
                                                onclick="toggleLike(this)"
                                                style="${post.likedByCurrentUser ? 'background-color: #3b82f6; color: white;' : ''}">
                                            <i class="fas fa-thumbs-up"></i>
                                            <span class="like-count">${fn:length(post.likes)}</span>
                                        </button>

                                        <!-- Maybe have a like people here, like: Khanh Huyen, TamHS, ... -->

                                    </div>

                                    <div class="flex items-center gap-2">
                                        <div class="review-badge text-white px-3 py-1 rounded-full text-xs font-medium">
                                            ${fn:length(post.reviews)} reviews
                                        </div>
                                    </div>
                                </div>

                                <!-- Action Buttons -->
                                <div class="px-6 py-4 flex gap-3">
                                    <button class="flex-1 bg-orange-500 hover:bg-orange-600 text-white py-3 rounded-lg font-medium transition-colors">
                                        <i class="fas fa-key mr-2"></i>
                                        Book
                                    </button>
                                    <button class="flex-1 bg-green-500 hover:bg-green-600 text-white-700 py-3 rounded-lg font-medium transition-colors text-white">
                                        <i class="fa-solid fa-house text-white"></i>
                                        View Detail
                                    </button>
                                    <button class="flex-1 bg-gray-200 hover:bg-gray-300 text-white-700 py-3 rounded-lg font-medium transition-colors view-review-btn" 
                                            data-house-id="${post.house.id}" 
                                            data-house-name="${post.house.name}">
                                        <i class="fas fa-comments mr-2"></i>
                                        View Review
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center p-2 mb-3">
                            <p class="text-gray-500 decoration-wavy">No post available right now!</p>
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- Load More Button -->
                <c:choose>
                    <c:when test="${not empty requestScope.posts}">
                        <div class="text-center">
                            <button class="bg-gray-400 hover:bg-gray-500 text-white px-8 py-3 rounded-full font-medium transition-all transform hover:scale-105">
                                <i class="fas fa-plus mr-2"></i>
                                Load More Posts
                            </button>
                        </div>
                    </c:when>
                </c:choose>
            </div>
        </div>

        <!-- Review Modal -->
        <div id="reviewModal" class="fixed inset-0 z-50 modal-overlay">
            <div class="flex items-center justify-center min-h-screen px-4 py-8">
                <div class="modal-content bg-white rounded-2xl shadow-2xl max-w-4xl w-full max-h-[90vh] overflow-hidden">

                    <!-- Modal Header -->
                    <div class="bg-gradient-to-r from-blue-500 to-purple-600 px-6 py-4">
                        <div class="flex items-center justify-between">
                            <div class="flex gap-2 items-center">
                                <h2 class="text-xl font-bold text-[#FF7700]">Reviews</h2>
                                <p> <b>-</b> </p>
                                <p id="modalHouseName" class="text-blue-500 text-xl font-bold"></p>
                            </div>
                            <button id="closeModalBtn" class="modal-close-btn w-10 h-10 rounded-full bg-red-500 bg-opacity-30 flex items-center justify-center hover:bg-opacity-30 transition-all">
                                <i class="fas fa-times text-lg text-white"></i>
                            </button>
                        </div>
                    </div>

                    <!-- Modal Body -->
                    <div class="p-6 overflow-y-auto max-h-[calc(90vh-120px)]">

                        <!-- Loading State -->
                        <div id="reviewLoading" class="text-center py-8">
                            <div class="loading-spinner mx-auto mb-4"></div>
                            <p class="text-gray-500">Loading reviews...</p>
                        </div>

                        <!-- Error State -->
                        <div id="reviewError" class="text-center py-8 hidden">
                            <i class="fas fa-exclamation-triangle text-red-500 text-3xl mb-4"></i>
                            <p class="text-red-500 font-medium">Failed to load reviews</p>
                            <button id="retryReview" class="mt-2 bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-lg transition-colors">
                                <i class="fas fa-redo mr-2"></i>
                                Retry
                            </button>
                        </div>

                        <!-- No Review State -->
                        <div id="noReview" class="text-center py-8 hidden">
                            <i class="fas fa-comment-slash text-gray-400 text-3xl mb-4"></i>
                            <p class="text-gray-500">No reviews available for this property</p>
                        </div>

                        <!-- Reviews Container -->
                        <div id="reviewContainer" class="space-y-4">
                            <!-- Dynamic review items will be inserted here -->
                        </div>

                        <!-- Load More Reviews -->
                        <div id="loadMoreReview" class="text-center mt-6 hidden">
                            <button id="loadMoreReviewBtn" class="bg-orange-500 hover:bg-orange-600 text-white px-6 py-2 rounded-lg transition-colors">
                                <i class="fas fa-chevron-down mr-2"></i>
                                Load More reviews
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
                                                    function toggleLike(button) {
                                                        const uid = '${sessionScope.user_id}';

                                                        if (uid || uid.trim()) {
                                                            const likeCount = button.querySelector('.like-count');
                                                            const currentCount = parseInt(likeCount.textContent);
                                                            const pid = $(button).data('post-id');

                                                            if (button.classList.contains('liked')) {
                                                                // Unlike
                                                                button.classList.remove('liked');
                                                                likeCount.textContent = currentCount - 1;
                                                                button.style.backgroundColor = 'white';
                                                                button.style.color = '#3b82f6';
                                                                sendLikeRequest(pid, 'unLike');
                                                            } else {
                                                                // Like
                                                                button.classList.add('liked');
                                                                likeCount.textContent = currentCount + 1;
                                                                button.style.backgroundColor = '#3b82f6';
                                                                button.style.color = 'white';
                                                                sendLikeRequest(pid, 'like');
                                                            }
                                                        } else {
                                                            Swal.fire({
                                                                title: 'You must login to use this feature',
                                                                imageUrl: `${pageContext.request.contextPath}/Asset/FUHF Logo/3.svg`,
                                                                imageWidth: 150,
                                                                imageHeight: 150,
                                                                imageAlt: 'Custom icon',
                                                                showCancelButton: true,
                                                                confirmButtonText: 'Login now',
                                                                cancelButtonText: 'Back to Newsfeed',
                                                                reverseButtons: true,
                                                                focusConfirm: false,
                                                                focusCancel: false,
                                                                customClass: {
                                                                    popup: 'rounded-xl shadow-lg',
                                                                    title: 'text-xl font-semibold',
                                                                    confirmButton: 'bg-[#FF7700] text-white px-4 py-2 rounded',
                                                                    cancelButton: 'bg-gray-300 text-black px-4 py-2 rounded',
                                                                    actions: 'space-x-4'
                                                                },
                                                                buttonsStyling: false
                                                            }).then((result) => {
                                                                if (result.isConfirmed) {
                                                                    location.href = '${pageContext.request.contextPath}/login';
                                                                } else if (result.dismiss === Swal.DismissReason.cancel) {
                                                                    Swal.close();
                                                                }
                                                            });
                                                        }
                                                    }

                                                    function sendLikeRequest(postId, type) {
                                                        $.ajax({
                                                            url: '${pageContext.request.contextPath}/feeds',
                                                            type: 'POST',
                                                            data: {
                                                                pid: postId,
                                                                type: type
                                                            }
                                                        });
                                                    }

                                                    $(document).ready(function () {
                                                        const modal = $('#reviewModal');
                                                        const modalHouseName = $('#modalHouseName');
                                                        const reviewContainer = $('#reviewContainer');
                                                        const loadingDiv = $('#reviewLoading');
                                                        const errorDiv = $('#reviewError');
                                                        const noReviewDiv = $('#noReview');
                                                        const loadMoreDiv = $('#loadMoreReview');

                                                        let currentHouseId = null;
                                                        let currentPage = 1;
                                                        let isLoading = false;

                                                        $('.view-review-btn').on('click', function () {
                                                            const houseId = $(this).data('house-id');
                                                            const houseName = $(this).data('house-name');

                                                            currentHouseId = houseId;
                                                            currentPage = 1;

                                                            modalHouseName.text(houseName);
                                                            modal.addClass('active');
                                                            $('body').addClass('overflow-hidden');

                                                            loadReviews(houseId, 1, true);
                                                        });

                                                        // Close modal
                                                        $('#closeModalBtn').on('click', function (e) {
                                                            closeModal();

                                                        });

                                                        modal.on('click', function (e) {
                                                            if (e.target === this) {
                                                                closeModal();
                                                            }
                                                        });

                                                        modal.on('click', function (e) {
                                                            if (!$(e.target).closest('.modal-content').length) {
                                                                closeModal();
                                                            }
                                                        });

                                                        // Retry loading reviews
                                                        $('#retryReview').on('click', function () {
                                                            if (currentHouseId) {
                                                                loadReviews(currentHouseId, 1, true);
                                                            }
                                                        });

                                                        // Load more reviews
                                                        $('#loadMoreReviewBtn').on('click', function () {
                                                            if (currentHouseId && !isLoading) {
                                                                loadReviews(currentHouseId, currentPage + 1, false);
                                                            }
                                                        });

                                                        // ESC key to close modal
                                                        $(document).on('keydown', function (e) {
                                                            if (e.key === 'Escape' && modal.hasClass('active')) {
                                                                closeModal();
                                                            }
                                                        });

                                                        function closeModal() {
                                                            modal.removeClass('active');
                                                            $('body').removeClass('overflow-hidden');
                                                            // Reset modal state after animation
                                                            setTimeout(() => {
                                                                resetModalState();
                                                            }, 300);
                                                        }

                                                        function resetModalState() {
                                                            reviewContainer.empty();
                                                            loadingDiv.show();
                                                            errorDiv.addClass('hidden');
                                                            noReviewDiv.addClass('hidden');
                                                            loadMoreDiv.addClass('hidden');
                                                            currentHouseId = null;
                                                            currentPage = 1;
                                                        }

                                                        function loadReviews(houseId, page, isNewLoad) {
                                                            if (isLoading)
                                                                return;

                                                            isLoading = true;

                                                            if (isNewLoad) {
                                                                // Show loading for new load
                                                                loadingDiv.show();
                                                                errorDiv.addClass('hidden');
                                                                noReviewDiv.addClass('hidden');
                                                                loadMoreDiv.addClass('hidden');
                                                                reviewContainer.empty();
                                                            } else {
                                                                // Show loading on load more button
                                                                $('#loadMoreReviewBtn').html('<div class="loading-spinner inline-block mr-2"></div>Loading...');
                                                            }

                                                            $.ajax({
                                                                url: '${pageContext.request.contextPath}/feedback/house',
                                                                method: 'GET',
                                                                data: {
                                                                    houseId: houseId,
                                                                    page: page,
                                                                    limit: 5
                                                                },
                                                                success: function (response) {
                                                                    loadingDiv.hide();

                                                                    if (isNewLoad) {
                                                                        reviewContainer.empty();
                                                                    }

                                                                    if (response.reviews && response.reviews.length > 0) {
                                                                        appendReviews(response.reviews);
                                                                        currentPage = page;

                                                                        // Show load more if there are more reviews
                                                                        if (response.hasMore) {
                                                                            loadMoreDiv.removeClass('hidden');
                                                                        } else {
                                                                            loadMoreDiv.addClass('hidden');
                                                                        }

                                                                        errorDiv.addClass('hidden');
                                                                        noReviewDiv.addClass('hidden');
                                                                    } else if (isNewLoad) {
                                                                        // No reviews found
                                                                        noReviewDiv.removeClass('hidden');
                                                                        errorDiv.addClass('hidden');
                                                                        loadMoreDiv.addClass('hidden');
                                                                    }
                                                                },
                                                                error: function (xhr, status, error) {
                                                                    console.error('Error loading reviews:', error);
                                                                    loadingDiv.hide();

                                                                    if (isNewLoad) {
                                                                        errorDiv.removeClass('hidden');
                                                                        noReviewDiv.addClass('hidden');
                                                                    } else {
                                                                        // Show error toast for load more
                                                                        showToast('Failed to load more reviews', 'error');
                                                                    }
                                                                },
                                                                complete: function () {
                                                                    isLoading = false;
                                                                    $('#loadMoreReviewBtn').html('<i class="fas fa-chevron-down mr-2"></i>Load More Reviews');
                                                                }
                                                            });
                                                        }

                                                        function appendReviews(reviews) {
                                                            reviews.forEach(function (review) {
                                                                const reviewHtml = createReviewHtml(review);
                                                                reviewContainer.append(reviewHtml);
                                                            });
                                                        }

                                                        function createReviewHtml(review) {
                                                            const stars = generateStarRating(review.Star);

                                                            return `
                                                        <div class="review-item p-4 border border-gray-200 rounded-xl bg-gray-50">
                                                            <div class="flex items-start gap-4">
                                                                <div class="w-12 h-12 bg-gradient-to-r from-blue-400 to-purple-500 rounded-full flex items-center justify-center flex-shrink-0">
                                                                    <img class="w-12 h-12 rounded-full object-cover" src=${pageContext.request.contextPath}/Asset/Common/Avatar/` + review.owner.avatar + ` 
                                                                         onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                                                                    <i class="fas fa-user text-white text-sm" style="display: none;"></i>
                                                                </div>
                                                                <div class="flex-1">
                                                                    <div class="flex items-center justify-between mb-2">
                                                                        <div class="flex items-center gap-3">
                                                                            <a href="${pageContext.request.contextPath}/profile?uid=` + review.owner.id + `" class="font-semibold text-gray-800">` + review.owner.first_name + ` ` + review.owner.last_name + `</a>
                                                                            <div class="star-rating flex">
                                                                                ` + stars + `
                                                                            </div>
                                                                        </div>
                                                                        <span class="text-xs text-gray-500">` + review.created_at + ` </span>
                                                                    </div>
                                                                    <p class="text-gray-700 text-sm leading-relaxed">` + review.content + `</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    `;
                                                        }

                                                        function generateStarRating(rating) {
                                                            let stars = '';
                                                            for (let i = 1; i <= 5; i++) {
                                                                if (i <= rating) {
                                                                    stars += '<i class="fas fa-star text-xs"></i>';
                                                                } else {
                                                                    stars += '<i class="far fa-star text-xs"></i>';
                                                                }
                                                            }
                                                            return stars;
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
                                                    });

                                                    function showImageModal(imageSrc) {
                                                        Swal.fire({
                                                            imageUrl: imageSrc,
                                                            imageWidth: 'auto',
                                                            imageHeight: 'auto',
                                                            showCloseButton: false,
                                                            showConfirmButton: false,
                                                            customClass: {
                                                                image: 'rounded-lg p-5'
                                                            }
                                                        });
                                                    }
        </script>
    </body>
</html>