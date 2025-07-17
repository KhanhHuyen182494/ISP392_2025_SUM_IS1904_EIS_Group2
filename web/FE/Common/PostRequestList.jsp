<%-- 
    Document   : PostRequestList
    Created on : Jul 16, 2025, 4:49:09 PM
    Author     : Tam
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
        <title>Booking History</title>

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
            <!-- Page Title -->
            <div class="mb-8">
                <h1 class="text-3xl font-bold text-gray-900 mb-2">Post Requests</h1>
                <p class="text-gray-600">Manage and review post requests from users</p>
            </div>

            <!-- Filter Options -->
            <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
                <form action="${pageContext.request.contextPath}/post-request" method="GET">
                    <div class="flex flex-wrap gap-4 items-center">
                        <div class="flex items-center gap-2">
                            <label class="text-sm font-medium text-gray-700">Search:</label>
                            <input type="text" name="keyword" placeholder="Search something ..." value="${keyword}" class="px-3 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" />
                        </div>
                        <div class="flex items-center gap-2">
                            <label class="text-sm font-medium text-gray-700">Status:</label>
                            <select name="status" class="px-3 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="">All</option>
                                <c:forEach items="${sList}" var="s">
                                    <option value="${s.id}" ${statusId == s.id ? "selected" : ""}>${s.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="flex items-center gap-2">
                            <label class="text-sm font-medium text-gray-700">Post Type:</label>
                            <select name="postType" class="px-3 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="">All Types</option>
                                <c:forEach items="${tList}" var="t">
                                    <c:if test="${t.id != 5 and t.id != 3 }">
                                        <option value="${t.id}" ${typeId == t.id ? "selected" : ""}>${t.name}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>
                        <!--                        <div class="flex items-center gap-2">
                                                    <label class="text-sm font-medium text-gray-700">Sort by:</label>
                                                    <select name="sortBy" class="px-3 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
                                                        <option value="newest">Newest First</option>
                                                        <option value="oldest">Oldest First</option>
                                                    </select>
                                                </div>-->
                        <div class="flex flex-wrap gap-2 pt-4">
                            <button type="submit" class="bg-primary-600 hover:bg-primary-700 text-white px-6 py-2 rounded-md font-medium transition-colors">
                                <i class="fas fa-search mr-2"></i>Apply Filters
                            </button>
                            <a href="${pageContext.request.contextPath}/post-request" class="bg-gray-500 hover:bg-gray-600 text-white px-6 py-2 rounded-md font-medium transition-colors">
                                <i class="fas fa-times mr-2"></i>Clear Filters
                            </a>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Post List -->
            <div class="space-y-6">
                <c:forEach var="post" items="${requestScope.posts}">
                    <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                        <!-- Post Header -->
                        <div class="p-6 pb-4">
                            <div class="flex items-start justify-between">
                                <div class="flex items-center gap-3">
                                    <a href="${pageContext.request.contextPath}/profile?uid=${post.owner.id}">
                                        <div class="w-12 h-12 rounded-full overflow-hidden bg-gray-200">
                                            <img class="w-full h-full object-cover" 
                                                 src="${pageContext.request.contextPath}/Asset/Common/Avatar/${post.owner.avatar}" 
                                                 alt="User Avatar"/>
                                        </div>
                                    </a>
                                    <div>
                                        <div class="flex items-center gap-2">
                                            <a href="${pageContext.request.contextPath}/profile?uid=${post.owner.id}" 
                                               class="font-semibold text-gray-900 hover:text-blue-600">
                                                ${post.owner.first_name} ${post.owner.last_name}
                                            </a>
                                            <span class="px-2 py-1 text-xs font-medium rounded-full
                                                  <c:choose>
                                                      <c:when test="${post.post_type.name == 'house'}">bg-blue-100 text-blue-800</c:when>
                                                      <c:when test="${post.post_type.name == 'room'}">bg-green-100 text-green-800</c:when>
                                                      <c:otherwise>bg-purple-100 text-purple-800</c:otherwise>
                                                  </c:choose>">
                                                ${post.post_type.name}
                                            </span>
                                        </div>
                                        <div class="flex items-center gap-2 text-sm text-gray-500">
                                            <fmt:formatDate value="${post.created_at}" pattern="dd/MM/yyyy HH:mm"/>
                                            <c:if test="${post.created_at != post.updated_at}">
                                                <span>• Edited</span>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>

                                <!-- Status Badge -->
                                <div class="flex items-center gap-2">
                                    <span class="px-3 py-1 text-sm font-medium rounded-full
                                          <c:choose>
                                              <c:when test="${post.status.name == 'Deleted'}">bg-red-100 text-red-800</c:when>
                                              <c:when test="${post.status.name == 'Private'}">bg-purple-100 text-purple-800</c:when>
                                              <c:when test="${post.status.name == 'Rejected'}">bg-red-100 text-red-800</c:when>
                                              <c:when test="${post.status.name == 'Wait for approval'}">bg-yellow-100 text-yellow-800</c:when>
                                              <c:when test="${post.status.name == 'Published'}">bg-green-100 text-green-800</c:when>
                                              <c:otherwise>bg-gray-100 text-gray-800</c:otherwise>
                                          </c:choose>">
                                        ${post.status.name}
                                    </span>

                                    <!-- Action Dropdown -->
                                    <div class="relative">
                                        <button class="p-2 hover:bg-gray-100 rounded-full transition-colors" 
                                                onclick="toggleDropdown('dropdown-${post.id}')">
                                            <i class="fas fa-ellipsis-v text-gray-500"></i>
                                        </button>
                                        <div id="dropdown-${post.id}" class="hidden absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg z-10 border">
                                            <div class="py-1">
                                                <button onclick="viewPostDetails('${post.id}')" 
                                                        class="w-full text-left px-4 py-2 text-sm text-blue-700 hover:bg-blue-50">
                                                    <i class="fas fa-eye mr-2"></i>View Details
                                                </button>
                                                <c:if test="${post.status.id != 15 and post.status.id != 38}">
                                                    <button onclick="editPost('${post.id}')" 
                                                            class="w-full text-left px-4 py-2 text-sm text-yellow-700 hover:bg-yellow-50">
                                                        <i class="fas fa-edit mr-2"></i>Edit
                                                    </button>
                                                    <button onclick="updatePostStatus('${post.id}', 15)" 
                                                            class="w-full text-left px-4 py-2 text-sm text-red-700 hover:bg-red-50">
                                                        <i class="fas fa-trash mr-2"></i>Delete
                                                    </button>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Post Content -->
                        <div class="px-6 pb-4">
                            <div class="text-gray-800 mb-4">
                                <c:if test="${not empty post.content}">
                                    <p class="whitespace-pre-wrap">${post.content}</p>
                                </c:if>
                                <c:if test="${empty post.content}">
                                    <p class="whitespace-pre-wrap text-gray-500">"This post has no content"</p>
                                </c:if>
                            </div>

                            <!-- House/Room Information -->
                            <c:if test="${not empty post.house}">
                                <div class="bg-gray-50 rounded-lg p-4 mb-4">
                                    <h4 class="font-semibold text-gray-900 mb-2">
                                        <i class="fas fa-home mr-2"></i>House Information
                                    </h4>
                                    <div class="grid grid-cols-2 gap-4 text-sm">
                                        <div>
                                            <span class="font-medium text-gray-700">Name:</span>
                                            <p class="text-gray-600">${post.house.name}</p>
                                        </div>
                                        <div>
                                            <span class="font-medium text-gray-700">Address:</span>
                                            <p class="text-gray-600">${post.house.address.detail} ${post.house.address.ward}, ${post.house.address.district}, ${post.house.address.province}, ${post.house.address.country}</p>
                                        </div>
                                        <div>
                                            <span class="font-medium text-gray-700">Price:</span>
                                            <c:if test="${post.house.is_whole_house == true}">
                                                <p class="text-gray-600">
                                                    <fmt:formatNumber value="${post.house.price_per_night}" type="currency" currencyCode="VND"/>
                                                </p>
                                            </c:if>
                                            <c:if test="${post.house.is_whole_house == false}">
                                                <p class="text-gray-600">
                                                    Different for each room
                                                </p>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <c:if test="${not empty post.room}">
                                <div class="bg-gray-50 rounded-lg p-4 mb-4">
                                    <h4 class="font-semibold text-gray-900 mb-2">
                                        <i class="fas fa-bed mr-2"></i>Room Information
                                    </h4>
                                    <div class="grid grid-cols-2 gap-4 text-sm">
                                        <div>
                                            <span class="font-medium text-gray-700">Room Type:</span>
                                            <p class="text-gray-600">${post.room.type}</p>
                                        </div>
                                        <div>
                                            <span class="font-medium text-gray-700">Price:</span>
                                            <p class="text-gray-600">
                                                <fmt:formatNumber value="${post.room.price}" type="currency" currencyCode="VND"/>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Media Gallery -->
                            <c:if test="${not empty post.medias}">
                                <!--                                <div class="mb-4">
                                                                    <div class="grid grid-cols-2 md:grid-cols-3 gap-2">
                                <c:forEach var="media" items="${post.medias}" varStatus="status">
                                    <c:if test="${status.index < 6}">
                                        <div class="relative aspect-square bg-gray-200 rounded-lg overflow-hidden">
                                            <img src="${pageContext.request.contextPath}/Asset/Common/House/${media.url}" 
                                                 alt="Post media" 
                                                 class="w-full h-full object-cover hover:scale-105 transition-transform cursor-pointer"
                                                 onclick="openImageModal('${media.url}')"/>
                                        <c:if test="${status.index == 5 && fn:length(post.medias) > 6}">
                                            <div class="absolute inset-0 bg-black bg-opacity-50 flex items-center justify-center">
                                                <span class="text-white font-semibold text-lg">+${fn:length(post.medias) - 6}</span>
                                            </div>
                                        </c:if>
                                    </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>-->
                            </c:if>
                        </div>

                        <!-- Post Footer -->
                        <div class="px-6 py-4 bg-gray-50 border-t">
                            <div class="flex items-center justify-between">
                                <div class="flex items-center gap-6">

                                </div>

                                <div class="text-sm text-gray-500">
                                    ID: ${post.id}
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty posts}">
                    <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden p-3">
                        <p class="text-center">Not have these ${not empty keyword ? keyword : ""} post yet!</p>
                    </div>
                </c:if>
            </div>

            <c:if test="${totalPages > 1}">
                <div class="bg-white rounded-lg shadow-sm mt-6 p-4">
                    <div class="flex items-center justify-between">
                        <div class="text-sm text-gray-700">
                            Page ${currentPage} of ${totalPages}
                        </div>
                        <nav class="flex items-center space-x-1">
                            <!-- Previous Page -->
                            <c:if test="${currentPage > 1}">
                                <a href="?${queryString}&page=${currentPage - 1}" 
                                   class="px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md hover:bg-gray-50 hover:text-gray-700">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </c:if>

                            <!-- Page Numbers -->
                            <c:set var="startPage" value="${currentPage - 2 > 1 ? currentPage - 2 : 1}" />
                            <c:set var="endPage" value="${startPage + 4 < totalPages ? startPage + 4 : totalPages}" />

                            <c:if test="${startPage > 1}">
                                <a href="?${queryString}&page=1" 
                                   class="px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md hover:bg-gray-50 hover:text-gray-700">
                                    1
                                </a>
                                <c:if test="${startPage > 2}">
                                    <span class="px-3 py-2 text-sm font-medium text-gray-500">...</span>
                                </c:if>
                            </c:if>

                            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <span class="px-3 py-2 text-sm font-medium text-white bg-primary-600 border border-primary-600 rounded-md">
                                            ${i}
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="?${queryString}&page=${i}" 
                                           class="px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md hover:bg-gray-50 hover:text-gray-700">
                                            ${i}
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${endPage < totalPages}">
                                <c:if test="${endPage < totalPages - 1}">
                                    <span class="px-3 py-2 text-sm font-medium text-gray-500">...</span>
                                </c:if>
                                <a href="?${queryString}&page=${totalPages}" 
                                   class="px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md hover:bg-gray-50 hover:text-gray-700">
                                    ${totalPages}
                                </a>
                            </c:if>

                            <!-- Next Page -->
                            <c:if test="${currentPage < totalPages}">
                                <a href="?${queryString}&page=${currentPage + 1}" 
                                   class="px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md hover:bg-gray-50 hover:text-gray-700">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </c:if>
                        </nav>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- Image Modal -->
        <div id="imageModal" class="fixed inset-0 bg-black bg-opacity-75 hidden z-50 flex items-center justify-center">
            <div class="relative max-w-4xl max-h-4xl m-4">
                <button onclick="closeImageModal()" class="absolute top-4 right-4 text-white hover:text-gray-300 text-2xl">
                    <i class="fas fa-times"></i>
                </button>
                <img id="modalImage" src="" alt="Full size image" class="max-w-full max-h-full object-contain"/>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
                    function toggleDropdown(dropdownId) {
                        const dropdown = document.getElementById(dropdownId);
                        dropdown.classList.toggle('hidden');

                        // Close other dropdowns
                        document.querySelectorAll('[id^="dropdown-"]').forEach(el => {
                            if (el.id !== dropdownId) {
                                el.classList.add('hidden');
                            }
                        });
                    }

                    function editPost(postId) {
                        location.href = '${pageContext.request.contextPath}/post-request/update?pid=' + postId;
                    }
                    
                    function viewPostDetails(postId) {
                        location.href = '${pageContext.request.contextPath}/post-request/detail?pid=' + postId;
                    }

                    function updatePostStatus(postId, status) {
                        Swal.fire({
                            title: 'Delete Post?',
                            text: 'This action cannot be undone!',
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#ef4444',
                            cancelButtonColor: '#6b7280',
                            confirmButtonText: 'Yes, delete it!'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                // Make AJAX request to delete post
                                $.ajax({
                                    url: '${pageContext.request.contextPath}/post-request/update',
                                    method: 'POST',
                                    data: {
                                        postId: postId,
                                        type: 'statusUpdate',
                                        statusId: status
                                    },
                                    success: function (response) {
                                        if (response.ok) {
                                            Swal.fire('Deleted!', 'Post has been updated.', 'success');
                                        } else {
                                            Swal.fire('Deleted failed!', 'Post update failure.', 'error');
                                        }

                                        setTimeout(function () {
                                            location.reload();
                                        }, 2000);
                                    },
                                    error: function () {
                                        Swal.fire('Error!', 'Failed to update post.', 'error');
                                    }
                                });
                            }
                        });
                    }

                    function openImageModal(imageUrl) {
                        document.getElementById('modalImage').src = '${pageContext.request.contextPath}/Asset/Media/' + imageUrl;
                        document.getElementById('imageModal').classList.remove('hidden');
                    }

                    function closeImageModal() {
                        document.getElementById('imageModal').classList.add('hidden');
                    }

                    // Close dropdown when clicking outside
                    document.addEventListener('click', function (event) {
                        if (!event.target.closest('[onclick*="toggleDropdown"]')) {
                            document.querySelectorAll('[id^="dropdown-"]').forEach(el => {
                                el.classList.add('hidden');
                            });
                        }
                    });

                    // Close modal when clicking outside image
                    document.getElementById('imageModal').addEventListener('click', function (event) {
                        if (event.target === this) {
                            closeImageModal();
                        }
                    });
        </script>
    </body>
</html>