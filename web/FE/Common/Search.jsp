<%-- 
    Document   : Search
    Created on : Jun 1, 2025, 2:47:43 PM
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
        <title>Search - Homestay Community</title>

        <!-- Libs -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <link href="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
            :root {
                --primary-orange: #FF7700;
                --orange-light: #FFA366;
                --orange-dark: #DE6800;
                --gray-50: #F8FAFC;
                --gray-100: #F1F5F9;
                --gray-200: #E2E8F0;
                --gray-300: #CBD5E1;
                --gray-400: #94A3B8;
                --gray-500: #64748B;
                --gray-600: #475569;
                --gray-700: #334155;
                --gray-800: #1E293B;
                --gray-900: #0F172A;
            }

            .gradient-bg {
                background: linear-gradient(135deg, var(--primary-orange) 0%, var(--orange-light) 100%);
            }

            .search-container {
                background: linear-gradient(135deg, var(--primary-orange) 0%, var(--orange-light) 100%);
                border-radius: 24px;
                padding: 2rem;
                box-shadow: 0 20px 40px rgba(255, 119, 0, 0.15);
            }

            .search-input {
                background: rgba(255, 255, 255, 0.95);
                border: 2px solid transparent;
                border-radius: 16px;
                padding: 1rem 1.5rem;
                font-size: 1.1rem;
                transition: all 0.3s ease;
                backdrop-filter: blur(10px);
            }

            .search-input:focus {
                border-color: white;
                box-shadow: 0 0 0 4px rgba(255, 255, 255, 0.2);
                outline: none;
                transform: translateY(-2px);
            }

            .search-tabs {
                display: flex;
                gap: 0.5rem;
                background: rgba(255, 255, 255, 0.1);
                border-radius: 12px;
                padding: 0.5rem;
                backdrop-filter: blur(10px);
            }

            .search-tab {
                flex: 1;
                text-align: center;
                padding: 0.75rem 1rem;
                border-radius: 8px;
                color: white;
                font-weight: 500;
                transition: all 0.3s ease;
                cursor: pointer;
                border: 2px solid transparent;
            }

            .search-tab:hover {
                background: rgba(255, 255, 255, 0.1);
                transform: translateY(-1px);
            }

            .search-tab.active {
                background: white;
                color: var(--primary-orange);
                border-color: white;
                box-shadow: 0 4px 12px rgba(255, 255, 255, 0.3);
            }

            .result-card {
                background: white;
                border-radius: 16px;
                padding: 1.5rem;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                border: 1px solid var(--gray-200);
                transition: all 0.3s ease;
            }

            .result-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);
                border-color: var(--primary-orange);
            }

            .user-card {
                border-left: 4px solid #3B82F6;
            }

            .post-card {
                border-left: 4px solid #10B981;
            }

            .house-card {
                border-left: 4px solid var(--primary-orange);
            }

            .tag {
                background: var(--gray-100);
                color: var(--gray-700);
                padding: 0.25rem 0.75rem;
                border-radius: 8px;
                font-size: 0.8rem;
                font-weight: 500;
            }

            .tag.orange {
                background: rgba(255, 119, 0, 0.1);
                color: var(--primary-orange);
            }

            .tag.blue {
                background: rgba(59, 130, 246, 0.1);
                color: #3B82F6;
            }

            .tag.green {
                background: rgba(16, 185, 129, 0.1);
                color: #10B981;
            }

            .floating-action {
                position: fixed;
                bottom: 2rem;
                right: 2rem;
                background: var(--primary-orange);
                color: white;
                border: none;
                border-radius: 50%;
                width: 60px;
                height: 60px;
                font-size: 1.5rem;
                cursor: pointer;
                box-shadow: 0 8px 24px rgba(255, 119, 0, 0.3);
                transition: all 0.3s ease;
                z-index: 40;
            }

            .floating-action:hover {
                transform: scale(1.1);
                box-shadow: 0 12px 32px rgba(255, 119, 0, 0.4);
            }

            .search-stats {
                background: rgba(255, 255, 255, 0.1);
                border-radius: 12px;
                padding: 1rem;
                backdrop-filter: blur(10px);
                color: white;
                margin-top: 1rem;
            }

            .no-results {
                text-align: center;
                padding: 4rem 2rem;
                color: var(--gray-500);
                background: white;
                border-radius: 16px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            }

            .action-btn {
                padding: 0.5rem 1rem;
                border-radius: 8px;
                font-size: 0.9rem;
                font-weight: 500;
                transition: all 0.3s ease;
                cursor: pointer;
                border: 2px solid transparent;
                text-decoration: none;
                display: inline-block;
            }

            .action-btn.primary {
                background: var(--primary-orange);
                color: white;
            }

            .action-btn.primary:hover {
                background: var(--orange-dark);
                transform: translateY(-1px);
            }

            .action-btn.secondary {
                background: var(--gray-100);
                color: var(--gray-700);
            }

            .action-btn.secondary:hover {
                background: var(--gray-200);
            }

            .result-actions {
                display: flex;
                gap: 0.5rem;
                margin-top: 1rem;
            }

            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 0.5rem;
                margin-top: 2rem;
            }

            .pagination-btn {
                padding: 0.5rem 1rem;
                border: 1px solid var(--gray-300);
                border-radius: 8px;
                background: white;
                color: var(--gray-700);
                text-decoration: none;
                transition: all 0.3s ease;
            }

            .pagination-btn:hover {
                background: var(--primary-orange);
                color: white;
                border-color: var(--primary-orange);
            }

            .pagination-btn.active {
                background: var(--primary-orange);
                color: white;
                border-color: var(--primary-orange);
            }

            .pagination-btn.disabled {
                opacity: 0.5;
                cursor: not-allowed;
            }

            .pagination-btn.disabled:hover {
                background: white;
                color: var(--gray-700);
                border-color: var(--gray-300);
            }

            .media-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(80px, 1fr));
                gap: 0.5rem;
                margin-top: 1rem;
            }

            .media-item {
                aspect-ratio: 1;
                border-radius: 8px;
                overflow: hidden;
                background: var(--gray-100);
            }

            .media-item img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
                gap: 1rem;
                margin-top: 1rem;
            }

            .stat-card {
                background: rgba(255, 255, 255, 0.1);
                border-radius: 12px;
                padding: 1rem;
                text-align: center;
                color: white;
                backdrop-filter: blur(10px);
            }

            .stat-number {
                font-size: 1.5rem;
                font-weight: bold;
                margin-bottom: 0.25rem;
            }

            .stat-label {
                font-size: 0.9rem;
                opacity: 0.8;
            }
        </style>
    </head>
    <body class="bg-gray-50 min-h-screen">

        <!-- Header -->
        <header class="bg-white shadow-md sticky top-0 z-50">
            <div class="max-w-7xl mx-auto px-4 py-3">
                <div class="flex items-center justify-between">
                    <div class="flex items-center gap-4">
                        <!-- Logo -->
                        <div class="flex items-center gap-2">
                            <a href="${pageContext.request.contextPath}/feeds">
                                <img src="${pageContext.request.contextPath}/Asset/FUHF Logo/3.svg" width="30"/>
                            </a>
                            <span class="text-xl font-bold text-gray-800">Search</span>
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
        <div class="max-w-7xl mx-auto px-4 py-8">

            <!-- Search Section -->
            <div class="search-container mb-8">
                <div class="text-center mb-6">
                    <h1 class="text-3xl font-bold text-white mb-2">Find Your Perfect Match</h1>
                    <p class="text-white/80 text-lg">Search for users, posts, or houses in our community</p>
                </div>

                <!-- Search Tabs -->
                <div class="search-tabs mb-6">
                    <a href="${pageContext.request.contextPath}/search?searchKey=${searchKey}&type=users&page=1">
                        <div class="search-tab ${type eq 'users' ? 'active' : ''}" data-tab="users">
                            <i class="fas fa-users mr-2"></i>
                            Users
                        </div>
                    </a>
                    <a href="${pageContext.request.contextPath}/search?searchKey=${searchKey}&type=posts&page=1">
                        <div class="search-tab ${type eq 'posts' ? 'active' : ''}" data-tab="posts">
                            <i class="fas fa-newspaper mr-2"></i>
                            Posts
                        </div>
                    </a>
                    <a href="${pageContext.request.contextPath}/search?searchKey=${searchKey}&type=houses&page=1">
                        <div class="search-tab ${type eq 'houses' ? 'active' : ''}" data-tab="houses">
                            <i class="fas fa-home mr-2"></i>
                            Houses
                        </div>
                    </a>
                </div>

                <c:if test="${empty type}">
                    <c:set var="type" value="all" scope="request"/>
                </c:if>

                <!-- Search Input -->
                <div class="relative mb-4">
                    <form id="searchForm" action="search" method="GET" class="relative">
                        <input 
                            type="text" 
                            id="searchInput"
                            name="searchKey"
                            placeholder="Search for anything..." 
                            class="search-input w-full pr-16"
                            value="${searchKey}"
                            />
                        <input type="hidden" id="searchType" name="type" value="${type}">
                        <button type="submit" class="absolute right-4 top-1/2 transform -translate-y-1/2 bg-orange-500 hover:bg-orange-600 text-white px-4 py-2 rounded-lg transition-colors">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                </div>

                <!-- Search Stats -->
                <div class="search-stats">
                    <c:choose>
                        <c:when test="${not empty searchKey}">
                            <div class="stats-grid">
                                <div class="stat-card">
                                    <div class="stat-number">${totalResults}</div>
                                    <div class="stat-label">Total Results</div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-number">${totalUsers}</div>
                                    <div class="stat-label">Users</div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-number">${totalPosts}</div>
                                    <div class="stat-label">Posts</div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-number">${totalHouses}</div>
                                    <div class="stat-label">Houses</div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center">
                                <span>Search for something to see results</span>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Results Section -->
            <div class="space-y-6">
                <c:choose>
                    <c:when test="${totalResults eq 0 && not empty searchKey}">
                        <!-- No Results -->
                        <div class="no-results">
                            <div class="text-center">
                                <i class="fas fa-search text-6xl text-gray-300 mb-4"></i>
                                <h3 class="text-xl font-semibold text-gray-700 mb-2">No results found</h3>
                                <p class="text-gray-500 mb-6">Try adjusting your search terms or try different keywords</p>
                                <a href="${pageContext.request.contextPath}/feeds" class="action-btn primary">
                                    <i class="fas fa-arrow-left mr-2"></i>
                                    Back to Feeds
                                </a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- User Results -->
                        <c:if test="${not empty users}">
                            <c:forEach var="user" items="${users}">
                                <div class="result-card user-card">
                                    <div class="flex items-center gap-4 mb-4">
                                        <div class="w-16 h-16 rounded-full overflow-hidden bg-gray-100">
                                            <c:choose>
                                                <c:when test="${not empty user.avatar}">
                                                    <img class="w-full h-full object-cover" src="${pageContext.request.contextPath}/Asset/Common/Avatar/${user.avatar}" alt="${user.first_name}"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="w-full h-full bg-blue-100 flex items-center justify-center">
                                                        <i class="fas fa-user text-blue-600 text-xl"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="flex-1">
                                            <h3 class="text-lg font-semibold text-gray-800">${user.first_name} ${user.last_name}</h3>
                                            <p class="text-gray-600">
                                                <c:if test="${not empty user.email}">${user.email}</c:if>
                                                <c:if test="${not empty user.phone}"> • ${user.phone}</c:if>
                                                </p>
                                                <div class="flex items-center gap-2 mt-2">
                                                <c:if test="${user.is_verified eq true}">
                                                    <span class="tag blue">Verified</span>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                    <c:if test="${not empty user.description}">
                                        <p class="text-gray-700 mb-4">${fn:substring(user.description, 0, 150)}${fn:length(user.description) > 150 ? '...' : ''}</p>
                                    </c:if>
                                    <div class="result-actions">
                                        <a href="${pageContext.request.contextPath}/profile?uid=${user.id}" class="action-btn primary">
                                            <i class="fas fa-eye mr-2"></i>
                                            View Profile
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>

                        <!-- Post Results -->
                        <c:if test="${not empty posts}">
                            <c:forEach var="post" items="${posts}">
                                <div class="result-card post-card">
                                    <div class="flex items-center gap-4 mb-4">
                                        <div class="w-16 h-16 rounded-full overflow-hidden bg-gray-100">
                                            <c:choose>
                                                <c:when test="${not empty post.owner.avatar}">
                                                    <img class="w-full h-full object-cover" src="${pageContext.request.contextPath}/Asset/Common/Avatar/${post.owner.avatar}" alt="${post.owner.first_name}"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="w-full h-full bg-green-100 flex items-center justify-center">
                                                        <i class="fas fa-newspaper text-green-600 text-xl"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="flex-1">
                                            <h3 class="text-lg font-semibold text-gray-800">
                                                <c:choose>
                                                    <c:when test="${not empty post.house.name}">
                                                        ${post.house.name}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Post by ${post.owner.first_name} ${post.owner.last_name}
                                                    </c:otherwise>
                                                </c:choose>
                                            </h3>
                                            <p class="text-gray-600">
                                                by ${post.owner.first_name} ${post.owner.last_name} • 
                                                <fmt:formatDate value="${post.created_at}" pattern="MMM dd, yyyy"/>
                                            </p>
                                            <div class="flex items-center gap-2 mt-2">
                                                <c:if test="${not empty post.post_type}">
                                                    <span class="tag green">${post.post_type.name}</span>
                                                </c:if>
                                                <c:if test="${not empty post.house.address and post.post_type.id == 1}">
                                                    <span class="tag">${post.house.address.district}, ${post.house.address.province}</span>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                    <c:if test="${not empty post.content}">
                                        <p class="text-gray-700 mb-4">${fn:substring(post.content, 0, 200)}${fn:length(post.content) > 200 ? '...' : ''}</p>
                                    </c:if>
                                    <div class="flex items-center gap-4 text-gray-500 text-sm mb-4 mt-4">
                                        <span><i class="fas fa-heart mr-1"></i>${fn:length(post.likes)} likes</span>
                                        <span><i class="fas fa-comment mr-1"></i>${fn:length(post.reviews)} comments</span>
                                    </div>
                                    <div class="result-actions">
                                        <a href="${pageContext.request.contextPath}/post-request/detail?pid=${post.id}">
                                            <button class="px-3 py-1.5 text-gray-700 hover:text-blue-600 hover:bg-gray-100 rounded transition-colors duration-150 text-sm font-medium">
                                                Detail
                                            </button>
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>

                        <!-- House Results -->
                        <c:if test="${not empty houses}">
                            <c:forEach var="house" items="${houses}">
                                <div class="result-card house-card">
                                    <div class="flex items-center gap-4 mb-4">
                                        <div class="w-16 h-16 rounded-full overflow-hidden bg-gray-100">
                                            <c:choose>
                                                <c:when test="${not empty house.medias && fn:length(house.medias) > 0}">
                                                    <img class="w-full h-full object-cover" src="${pageContext.request.contextPath}/Asset/Common/Media/${house.medias[0].url}" alt="${house.name}"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="w-full h-full bg-orange-100 flex items-center justify-center">
                                                        <i class="fas fa-home text-orange-600 text-xl"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="flex-1">
                                            <h3 class="text-lg font-semibold text-gray-800">${house.name}</h3>
                                            <p class="text-gray-600">
                                                <c:if test="${not empty house.address}">
                                                    ${house.address.district}, ${house.address.province} • 
                                                </c:if>
                                                <c:if test="${not empty house.owner}">
                                                    by ${house.owner.first_name} ${house.owner.last_name}
                                                </c:if>
                                            </p>
                                            <div class="flex items-center gap-2 mt-2">
                                                <c:if test="${house.status.id eq 1}">
                                                    <span class="tag orange">Available</span>
                                                </c:if>
                                                <c:if test="${house.is_whole_house}">
                                                    <span class="tag">Whole House</span>
                                                </c:if>
                                                <c:if test="${house.is_whole_house == false}">
                                                    <span class="tag">Rooms only</span>
                                                </c:if>
                                                <c:if test="${house.star gt 0}">
                                                    <span class="tag">★ ${house.star}</span>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                    <c:if test="${not empty house.description}">
                                        <p class="text-gray-700 mb-4">${fn:substring(house.description, 0, 200)}${fn:length(house.description) > 200 ? '...' : ''}</p>
                                    </c:if>
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                                        <div class="flex items-center gap-2">
                                            <i class="fas fa-dollar-sign text-green-500"></i>
                                            <c:if test="${house.is_whole_house == true}">
                                                <span class="text-sm">
                                                    <strong>Price:</strong> 
                                                    <fmt:formatNumber value="${house.price_per_night}" type="currency" currencyCode="VND"/>
                                                </span>
                                            </c:if>
                                            <c:if test="${house.is_whole_house == false}">
                                                <span class="text-sm">
                                                    <strong>Price: Different for each room</strong>
                                                </span>
                                            </c:if>
                                        </div>
                                        <c:if test="${not empty house.address}">
                                            <div class="flex items-center gap-2">
                                                <i class="fas fa-map-marker-alt text-blue-500"></i>
                                                <span class="text-sm">
                                                    <strong>Location:</strong> ${house.address.district}
                                                </span>
                                            </div>
                                        </c:if>
                                    </div>
                                    <c:if test="${not empty house.medias}">
                                        <div class="media-grid">
                                            <c:forEach var="media" items="${house.medias}" varStatus="status">
                                                <c:if test="${status.index < 4}">
                                                    <div class="media-item">
                                                        <img src="${pageContext.request.contextPath}/Asset/Common/Media/${media.url}" alt="House media"/>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </c:if>
                                    <div class="result-actions">
                                        <a href="${pageContext.request.contextPath}/house-detail?hid=${house.id}" class="action-btn primary">
                                            <i class="fas fa-eye mr-2"></i>
                                            View Details
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <div class="pagination">
                                <c:if test="${currentPage > 1}">
                                    <a href="?searchKey=${searchKey}&type=${type}&page=${currentPage - 1}" class="pagination-btn">
                                        <i class="fas fa-chevron-left"></i>
                                    </a>
                                </c:if>

                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <c:choose>
                                        <c:when test="${i == currentPage}">
                                            <span class="pagination-btn active">${i}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="?searchKey=${searchKey}&type=${type}&page=${i}" class="pagination-btn">${i}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <a href="?searchKey=${searchKey}&type=${type}&page=${currentPage + 1}" class="pagination-btn">
                                        <i class="fas fa-chevron-right"></i>
                                    </a>
                                </c:if>
                            </div>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>

        <script>
            // Tab switching functionality
            document.addEventListener('DOMContentLoaded', function () {
                const tabs = document.querySelectorAll('.search-tab');
                const searchType = document.getElementById('searchType');
                const searchForm = document.getElementById('searchForm');

                // Search input enhancement
                const searchInput = document.getElementById('searchInput');
                searchInput.addEventListener('keyup', function (e) {
                    if (e.key === 'Enter') {
                        searchForm.submit();
                    }
                });

                // Auto-focus search input
                searchInput.focus();
            });

            // Image lazy loading
            document.addEventListener('DOMContentLoaded', function () {
                const images = document.querySelectorAll('img[data-src]');
                const imageObserver = new IntersectionObserver((entries, observer) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            const img = entry.target;
                            img.src = img.dataset.src;
                            img.classList.remove('lazy');
                            observer.unobserve(img);
                        }
                    });
                });

                images.forEach(img => imageObserver.observe(img));
            });

            document.addEventListener('keydown', function (e) {
                // Ctrl/Cmd + K to focus search
                if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
                    e.preventDefault();
                    document.getElementById('searchInput').focus();
                }

                if (e.key === 'Escape') {
                    document.getElementById('searchInput').value = '';
                    document.getElementById('searchInput').focus();
                }
            });
        </script>
    </body>
</html>