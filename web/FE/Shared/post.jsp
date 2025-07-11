<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN" />

<c:choose>
    <c:when test="${not empty requestScope.posts}">
        <c:forEach items="${requestScope.posts}" var="post" varStatus="postStatus">
            <div class="bg-white rounded-2xl shadow-lg mb-8 overflow-hidden card-hover post-container" data-post-index="${postStatus.index}">
                <!-- User Info -->
                <div class="p-6 pb-4">
                    <div class="flex items-center justify-between mb-4">
                        <div class="flex items-center gap-3">
                            <div class="w-12 h-12 rounded-full border-white overflow-hidden shadow-lg bg-white">
                                <a href="${pageContext.request.contextPath}/profile?uid=${post.owner.id}">
                                    <img class="w-full h-full object-cover" src="${pageContext.request.contextPath}/Asset/Common/Avatar/${post.owner.avatar}" />
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
                    </div>

                    <p class="text-lg mb-4">
                        ${post.content}
                    </p>

                    <!-- Share/Repost Section -->
                    <c:if test="${post.post_type.id == 5 and not empty post.parent_post}">
                        <div class="bg-gray-50 rounded-lg p-4 mb-4 border-l-4 border-blue-500">
                            <div class="flex items-center gap-3 mb-3">
                                <div class="w-10 h-10 rounded-full overflow-hidden shadow-sm bg-white">
                                    <a href="${pageContext.request.contextPath}/profile?uid=${post.parent_post.owner.id}">
                                        <img class="w-full h-full object-cover" 
                                             src="${pageContext.request.contextPath}/Asset/Common/Avatar/${post.parent_post.owner.avatar}" 
                                             alt="Avatar" loading="lazy" />
                                    </a>
                                </div>
                                <div>
                                    <c:choose>
                                        <c:when test="${sessionScope.user_id == post.parent_post.owner.id}">
                                            <a href="${pageContext.request.contextPath}/profile?uid=${post.parent_post.owner.id}" 
                                               class="font-medium text-gray-700 hover:text-blue-600">You</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/profile?uid=${post.parent_post.owner.id}" 
                                               class="font-medium text-gray-700 hover:text-blue-600">
                                                ${post.parent_post.owner.first_name} ${post.parent_post.owner.last_name}
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                    <p class="text-xs text-gray-500">
                                        <fmt:formatDate value="${post.parent_post.created_at}" pattern="HH:mm dd/MM/yyyy" />
                                    </p>
                                </div>
                            </div>
                            <c:if test="${post.parent_post.post_type.id == 1}">
                                <!-- Property Title -->
                                <h2 class="text-xl font-bold text-gray-800 mb-3">${post.parent_post.house.name}</h2>

                                <!-- Description -->
                                <p class="text-gray-600 mb-4">
                                    ${post.parent_post.house.description}
                                </p>

                                <!-- Property Details -->
                                <div class="space-y-2 mb-4">
                                    <div class="flex items-center gap-2">
                                        <i class="fas fa-dollar-sign text-green-500"></i>
                                        <span class="text-sm"><strong>Price per night:</strong> <fmt:formatNumber value="${post.parent_post.house.price_per_night}" type="number" groupingUsed="true" maxFractionDigits="0" /> vnđ / đêm</span>
                                    </div>
                                    <div class="flex items-center gap-2">
                                        <i class="fas fa-map-marker-alt text-red-500"></i>
                                        <span class="text-sm"><strong>Address:</strong> ${post.parent_post.house.address.detail} ${post.parent_post.house.address.ward}, ${post.parent_post.house.address.district}, ${post.parent_post.house.address.province}, ${post.parent_post.house.address.country}</span>
                                    </div>
                                </div>
                            </c:if>

                            <div class="px-6 pb-4">
                                <div class="grid grid-cols-2 gap-4">
                                    <!-- Calculate total images count for shared post -->
                                    <c:set var="sharedPostMediaCount" value="${fn:length(post.parent_post.medias)}" />
                                    <c:set var="sharedHouseMediaCount" value="${post.parent_post.post_type.id == 1 ? fn:length(post.parent_post.house.medias) : 0}" />
                                    <c:set var="sharedTotalImages" value="${sharedPostMediaCount + sharedHouseMediaCount}" />
                                    <c:set var="sharedMaxDisplay" value="4" />
                                    <c:set var="sharedRemainingCount" value="${sharedTotalImages - sharedMaxDisplay}" />
                                    <c:set var="sharedDisplayedCount" value="0" />

                                    <!-- Display Shared Post Media Images -->
                                    <c:forEach items="${post.parent_post.medias}" var="media" varStatus="status">
                                        <c:if test="${sharedDisplayedCount < sharedMaxDisplay}">
                                            <c:choose>
                                                <c:when test="${sharedDisplayedCount == 3 && sharedTotalImages > sharedMaxDisplay}">
                                                    <!-- Last image with overlay for remaining count -->
                                                    <div class="bg-gray-200 h-96 rounded-[20px] flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer relative overflow-hidden"
                                                         onclick="openImageCarousel(${sharedDisplayedCount}, this.closest('.post-container'))">
                                                        <img class="rounded-[20px] h-96 w-full object-cover" 
                                                             src="${pageContext.request.contextPath}/Asset/Common/Post/${media.path}"/>
                                                        <!-- Overlay -->
                                                        <div class="absolute inset-0 bg-black bg-opacity-60 rounded-[20px] flex items-center justify-center">
                                                            <span class="text-white text-2xl font-bold">+${sharedRemainingCount}</span>
                                                        </div>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <!-- Regular image -->
                                                    <div class="bg-gray-200 h-96 rounded-[20px] flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer"
                                                         onclick="openImageCarousel(${sharedDisplayedCount}, this.closest('.post-container'))">
                                                        <img class="rounded-[20px] h-96 w-full object-cover" 
                                                             src="${pageContext.request.contextPath}/Asset/Common/Post/${media.path}"/>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:set var="sharedDisplayedCount" value="${sharedDisplayedCount + 1}" />
                                        </c:if>
                                    </c:forEach>

                                    <!-- Display Shared House Media Images -->
                                    <c:if test="${post.parent_post.post_type.id == 1}">
                                        <c:forEach items="${post.parent_post.house.medias}" var="mediaH" varStatus="status">
                                            <c:if test="${sharedDisplayedCount < sharedMaxDisplay}">
                                                <c:choose>
                                                    <c:when test="${sharedDisplayedCount == 3 && sharedTotalImages > sharedMaxDisplay}">
                                                        <!-- Last image with overlay for remaining count -->
                                                        <div class="bg-gray-200 h-96 rounded-[20px] flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer relative overflow-hidden"
                                                             onclick="openImageCarousel(${sharedDisplayedCount}, this.closest('.post-container'))">
                                                            <img class="rounded-[20px] h-96 w-full object-cover" 
                                                                 src="${pageContext.request.contextPath}/Asset/Common/House/${mediaH.path}"/>
                                                            <!-- Overlay -->
                                                            <div class="absolute inset-0 bg-black bg-opacity-60 rounded-[20px] flex items-center justify-center">
                                                                <span class="text-white text-2xl font-bold">+${sharedRemainingCount}</span>
                                                            </div>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <!-- Regular image -->
                                                        <div class="bg-gray-200 h-96 rounded-[20px] flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer"
                                                             onclick="openImageCarousel(${sharedDisplayedCount}, this.closest('.post-container'))">
                                                            <img class="rounded-[20px] h-96 w-full object-cover" 
                                                                 src="${pageContext.request.contextPath}/Asset/Common/House/${mediaH.path}"/>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:set var="sharedDisplayedCount" value="${sharedDisplayedCount + 1}" />
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${post.post_type.id == 1}">
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
                                <c:if test="${post.house.is_whole_house == true}">
                                    <span class="text-sm"><strong>Price per night:</strong> <fmt:formatNumber value="${post.house.price_per_night}" type="number" groupingUsed="true" maxFractionDigits="0" /> vnd / night</span>
                                </c:if>
                                <c:if test="${post.house.is_whole_house == false}">
                                    <span class="text-sm"><strong>Price per night:</strong> Different for each room</span>
                                </c:if>
                            </div>
                            <div class="flex items-center gap-2">
                                <i class="fas fa-map-marker-alt text-red-500"></i>
                                <span class="text-sm"><strong>Address:</strong> ${post.house.address.detail} ${post.house.address.ward}, ${post.house.address.district}, ${post.house.address.province}, ${post.house.address.country}</span>
                            </div>
                        </div>
                    </c:if>
                </div>

                <!-- Images -->
                <div class="px-6 pb-4">
                    <div class="grid grid-cols-2 gap-4">
                        <!-- Calculate total images count -->
                        <c:set var="postMediaCount" value="${fn:length(post.medias)}" />
                        <c:set var="houseMediaCount" value="${post.post_type.id == 1 ? fn:length(post.house.medias) : 0}" />
                        <c:set var="totalImages" value="${postMediaCount + houseMediaCount}" />
                        <c:set var="maxDisplay" value="4" />
                        <c:set var="remainingCount" value="${totalImages - maxDisplay}" />

                        <!-- Create a counter for displayed images -->
                        <c:set var="displayedCount" value="0" />

                        <!-- Display Post Media Images -->
                        <c:forEach items="${post.medias}" var="media" varStatus="status">
                            <c:if test="${displayedCount < maxDisplay}">
                                <c:choose>
                                    <c:when test="${displayedCount == 3 && totalImages > maxDisplay}">
                                        <!-- Last image with overlay for remaining count -->
                                        <div class="bg-gray-200 h-96 rounded-[20px] flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer relative overflow-hidden"
                                             onclick="openImageCarousel(${displayedCount}, this.closest('.post-container'))">
                                            <img class="rounded-[20px] h-96 w-full object-cover" 
                                                 src="${pageContext.request.contextPath}/Asset/Common/Post/${media.path}"/>
                                            <!-- Overlay -->
                                            <div class="absolute inset-0 bg-black bg-opacity-60 rounded-[20px] flex items-center justify-center">
                                                <span class="text-white text-2xl font-bold">+${remainingCount}</span>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Regular image -->
                                        <div class="bg-gray-200 h-96 rounded-[20px] flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer"
                                             onclick="openImageCarousel(${displayedCount}, this.closest('.post-container'))">
                                            <img class="rounded-[20px] h-96 w-full object-cover" 
                                                 src="${pageContext.request.contextPath}/Asset/Common/Post/${media.path}"/>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <c:set var="displayedCount" value="${displayedCount + 1}" />
                            </c:if>
                        </c:forEach>

                        <!-- Display House Media Images (if post type is 1 and we haven't reached max display) -->
                        <c:if test="${post.post_type.id == 1}">
                            <c:forEach items="${post.house.medias}" var="mediaH" varStatus="status">
                                <c:if test="${displayedCount < maxDisplay}">
                                    <c:choose>
                                        <c:when test="${displayedCount == 3 && totalImages > maxDisplay}">
                                            <!-- Last image with overlay for remaining count -->
                                            <div class="bg-gray-200 h-96 rounded-[20px] flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer relative overflow-hidden"
                                                 onclick="openImageCarousel(${displayedCount}, this.closest('.post-container'))">
                                                <img class="rounded-[20px] h-96 w-full object-cover" 
                                                     src="${pageContext.request.contextPath}/Asset/Common/House/${mediaH.path}"/>
                                                <!-- Overlay -->
                                                <div class="absolute inset-0 bg-black bg-opacity-60 rounded-[20px] flex items-center justify-center">
                                                    <span class="text-white text-2xl font-bold">+${remainingCount}</span>
                                                </div>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Regular image -->
                                            <div class="bg-gray-200 h-96 rounded-[20px] flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer"
                                                 onclick="openImageCarousel(${displayedCount}, this.closest('.post-container'))">
                                                <img class="rounded-[20px] h-96 w-full object-cover" 
                                                     src="${pageContext.request.contextPath}/Asset/Common/House/${mediaH.path}"/>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:set var="displayedCount" value="${displayedCount + 1}" />
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </div>
                </div>

                <!-- Hidden divs to store image data for JavaScript - UNIQUE ID per post -->
                <div id="imageDataContainer" style="display: none;">
                    <!-- Include current post's images if it has any -->
                    <c:forEach items="${post.medias}" var="media" varStatus="status">
                        <div class="image-data" 
                             data-path="${media.path}" 
                             data-type="Post" 
                             data-full-path="${pageContext.request.contextPath}/Asset/Common/Post/${media.path}">
                        </div>
                    </c:forEach>
                    <!-- Include house images if this is a property post -->
                    <c:if test="${post.post_type.id == 1}">
                        <c:forEach items="${post.house.medias}" var="mediaH" varStatus="status">
                            <div class="image-data" 
                                 data-path="${mediaH.path}" 
                                 data-type="House" 
                                 data-full-path="${pageContext.request.contextPath}/Asset/Common/House/${mediaH.path}">
                            </div>
                        </c:forEach>
                    </c:if>
                    <!-- If this is a shared post, also include the shared post's images -->
                    <c:if test="${post.post_type.id == 5 and not empty post.parent_post}">
                        <c:forEach items="${post.parent_post.medias}" var="sharedMedia" varStatus="status">
                            <div class="image-data" 
                                 data-path="${sharedMedia.path}" 
                                 data-type="Post" 
                                 data-full-path="${pageContext.request.contextPath}/Asset/Common/Post/${sharedMedia.path}">
                            </div>
                        </c:forEach>
                        <c:if test="${post.parent_post.post_type.id == 1}">
                            <c:forEach items="${post.parent_post.house.medias}" var="sharedMediaH" varStatus="status">
                                <div class="image-data" 
                                     data-path="${sharedMediaH.path}" 
                                     data-type="House" 
                                     data-full-path="${pageContext.request.contextPath}/Asset/Common/House/${sharedMediaH.path}">
                                </div>
                            </c:forEach>
                        </c:if>
                    </c:if>
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
                    </div>

                    <c:if test="${post.post_type.id == 1}">
                        <div class="flex items-center gap-2">
                            <div class="review-badge text-white px-3 py-1 rounded-full text-xs font-medium">
                                ${fn:length(post.reviews)} reviews
                            </div>
                        </div>
                    </c:if>
                </div>

                <!-- Action Buttons -->
                <c:if test="${post.post_type.id == 1}"> 
                    <div class="px-6 py-4 flex gap-3">
                        <button data-house-id="${post.house.id}" onclick="book(this)" class="flex-1 bg-orange-500 hover:bg-orange-600 text-white py-3 rounded-lg font-medium transition-colors">
                            <i class="fas fa-key mr-2"></i>
                            Book
                        </button>
                        <button class="flex-1 bg-green-500 hover:bg-green-600 text-white-700 py-3 rounded-lg font-medium transition-colors text-white">
                            <a href="${pageContext.request.contextPath}/owner-house/detail?hid=${post.house.id}">
                                <i class="fa-solid fa-house text-white"></i>
                                View Detail
                            </a>
                        </button>
                        <button class="flex-1 bg-gray-200 hover:bg-gray-300 text-white-700 py-3 rounded-lg font-medium transition-colors view-review-btn" 
                                data-house-id="${post.house.id}" 
                                data-house-name="${post.house.name}">
                            <i class="fas fa-comment mr-2"></i>
                            View Review
                        </button>
                    </div>
                </c:if>
                <div class="px-6 py-4 gap-3 grid grid-cols-9">
                    <button class="col-span-6 bg-blue-500 hover:bg-blue-600 text-white py-3 rounded-lg font-medium transition-colors"
                            data-post-id="${post.id}">
                        <i class="fas fa-comments mr-2"></i>
                        Comment
                    </button>
                    <button class="col-span-3 bg-white-500 hover:bg-blue-500 hover:text-white border-[1px] border-blue-600 text-blue-600 py-3 rounded-lg font-medium transition-colors"
                            data-post-share-id="${not empty post.parent_post.id ? post.parent_post.id : post.id}">
                        <i class="fas fa-comments mr-2"></i>
                        Share
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

<div id="pagination-meta" style="display: none;">
    <span id="canLoadMore">${canLoadMore}</span>
    <span id="currentPage">${page}</span>
    <span id="totalPages">${totalPage}</span>
</div>

<script>
    $(document).ready(function () {
        const canLoadMore = $('#canLoadMore').text() === 'true';
        const currentPage = parseInt($('#currentPage').text());

        $('#loadmoreitems').data('can-load-more', canLoadMore);
        $('#loadmoreitems').data('current-page', currentPage);

        if (!canLoadMore) {
            $('#loadMoreBtn').hide();
        }

        $('#pagination-meta').remove();
    });
</script>