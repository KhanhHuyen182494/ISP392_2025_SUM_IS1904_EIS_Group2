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

            .filter-chip {
                background: var(--gray-100);
                color: var(--gray-700);
                border: 2px solid transparent;
                border-radius: 12px;
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
                font-weight: 500;
                transition: all 0.3s ease;
                cursor: pointer;
            }

            .filter-chip:hover {
                background: var(--gray-200);
                transform: translateY(-1px);
            }

            .filter-chip.active {
                background: var(--primary-orange);
                color: white;
                border-color: var(--primary-orange);
                box-shadow: 0 4px 12px rgba(255, 119, 0, 0.3);
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

            .search-suggestions {
                background: white;
                border-radius: 12px;
                border: 1px solid var(--gray-200);
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
                max-height: 300px;
                overflow-y: auto;
                z-index: 50;
            }

            .suggestion-item {
                padding: 0.75rem 1rem;
                border-bottom: 1px solid var(--gray-100);
                cursor: pointer;
                transition: all 0.2s ease;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .suggestion-item:hover {
                background: var(--gray-50);
            }

            .suggestion-item:last-child {
                border-bottom: none;
            }

            .no-results {
                text-align: center;
                padding: 4rem 2rem;
                color: var(--gray-500);
            }

            .loading-shimmer {
                background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
                background-size: 200% 100%;
                animation: shimmer 1.5s infinite;
                border-radius: 8px;
            }

            @keyframes shimmer {
                0% {
                    background-position: -200% 0;
                }
                100% {
                    background-position: 200% 0;
                }
            }

            .quick-filters {
                display: flex;
                gap: 0.5rem;
                flex-wrap: wrap;
                margin-top: 1rem;
            }

            .advanced-search {
                background: rgba(255, 255, 255, 0.1);
                border-radius: 12px;
                padding: 1rem;
                margin-top: 1rem;
                backdrop-filter: blur(10px);
                display: none;
            }

            .advanced-search.active {
                display: block;
            }

            .price-range {
                display: flex;
                gap: 1rem;
                align-items: center;
                margin-top: 0.5rem;
            }

            .price-input {
                background: rgba(255, 255, 255, 0.9);
                border: 1px solid rgba(255, 255, 255, 0.3);
                border-radius: 8px;
                padding: 0.5rem;
                color: var(--gray-700);
                width: 120px;
            }

            .advanced-toggle {
                color: white;
                font-size: 0.9rem;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                margin-top: 1rem;
                transition: all 0.3s ease;
            }

            .advanced-toggle:hover {
                color: rgba(255, 255, 255, 0.8);
            }

            .result-actions {
                display: flex;
                gap: 0.5rem;
                margin-top: 1rem;
            }

            .action-btn {
                padding: 0.5rem 1rem;
                border-radius: 8px;
                font-size: 0.9rem;
                font-weight: 500;
                transition: all 0.3s ease;
                cursor: pointer;
                border: 2px solid transparent;
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

            .search-history {
                background: rgba(255, 255, 255, 0.1);
                border-radius: 12px;
                padding: 1rem;
                margin-top: 1rem;
                backdrop-filter: blur(10px);
                color: white;
            }

            .history-item {
                padding: 0.5rem 0;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                cursor: pointer;
                transition: all 0.2s ease;
                display: flex;
                justify-content: between;
                align-items: center;
            }

            .history-item:hover {
                color: rgba(255, 255, 255, 0.8);
            }

            .history-item:last-child {
                border-bottom: none;
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
                    <div class="search-tab active" data-tab="all">
                        <i class="fas fa-search mr-2"></i>
                        All Results
                    </div>
                    <div class="search-tab" data-tab="users">
                        <i class="fas fa-users mr-2"></i>
                        Users
                    </div>
                    <div class="search-tab" data-tab="posts">
                        <i class="fas fa-newspaper mr-2"></i>
                        Posts
                    </div>
                    <div class="search-tab" data-tab="houses">
                        <i class="fas fa-home mr-2"></i>
                        Houses
                    </div>
                </div>

                <!-- Search Input -->
                <div class="relative mb-4">
                    <form id="searchForm" action="search" method="GET" class="relative">
                        <input 
                            type="text" 
                            id="searchInput"
                            name="searchKey"
                            placeholder="Search for anything..." 
                            class="search-input w-full pr-16"
                            value="${param.searchKey}"
                            required
                            />
                        <input type="hidden" id="searchType" name="type" value="all">
                        <button type="submit" class="absolute right-4 top-1/2 transform -translate-y-1/2 bg-orange-500 hover:bg-orange-600 text-white px-4 py-2 rounded-lg transition-colors">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>

                    <!-- Search Suggestions -->
                    <div id="searchSuggestions" class="search-suggestions absolute top-full left-0 right-0 mt-2 hidden">
                        <!-- Dynamic suggestions will be populated here -->
                    </div>
                </div>

                <!-- Search Stats -->
                <div class="search-stats">
                    <div class="flex items-center justify-between">
                        <span id="searchResults">Search for something to see results</span>
                    </div>
                </div>
            </div>

            <!-- Results Section -->
            <div class="grid grid-cols-1 lg:grid-cols-4 gap-8">

                <!-- Sidebar -->
                <div class="lg:col-span-1">
                    <div class="bg-white rounded-2xl shadow-sm p-6 sticky top-24">
                        <h3 class="text-lg font-bold text-gray-800 mb-4">Search History</h3>
                        <div class="search-history">
                            <div class="history-item">
                                <span>luxury homestay</span>
                                <i class="fas fa-times text-xs opacity-60"></i>
                            </div>
                            <div class="history-item">
                                <span>cheap rooms hanoi</span>
                                <i class="fas fa-times text-xs opacity-60"></i>
                            </div>
                            <div class="history-item">
                                <span>student accommodation</span>
                                <i class="fas fa-times text-xs opacity-60"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Main Results -->
                <div class="lg:col-span-3">
                    <div id="searchResultsContainer">

                        <!-- Loading State -->
                        <div id="loadingState" class="hidden">
                            <div class="space-y-4">
                                <div class="loading-shimmer h-32 w-full"></div>
                                <div class="loading-shimmer h-32 w-full"></div>
                                <div class="loading-shimmer h-32 w-full"></div>
                            </div>
                        </div>

                        <!-- No Results -->
                        <div id="noResults" class="no-results hidden">
                            <div class="text-center">
                                <i class="fas fa-search text-6xl text-gray-300 mb-4"></i>
                                <h3 class="text-xl font-semibold text-gray-700 mb-2">No results found</h3>
                                <p class="text-gray-500 mb-6">Try adjusting your search terms or filters</p>
                                <button class="action-btn primary">
                                    <i class="fas fa-plus mr-2"></i>
                                    Post Something New
                                </button>
                            </div>
                        </div>

                        <!-- Sample Results -->
                        <div id="actualResults" class="space-y-6">

                            <!-- User Result -->
                            <div class="result-card user-card">
                                <div class="flex items-center gap-4 mb-4">
                                    <div class="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center">
                                        <i class="fas fa-user text-blue-600 text-xl"></i>
                                    </div>
                                    <div class="flex-1">
                                        <h3 class="text-lg font-semibold text-gray-800">John Doe</h3>
                                        <p class="text-gray-600">Host • 4.8 rating • 25 reviews</p>
                                        <div class="flex items-center gap-2 mt-2">
                                            <span class="tag blue">Verified Host</span>
                                            <span class="tag">Premium Member</span>
                                        </div>
                                    </div>
                                </div>
                                <p class="text-gray-700 mb-4">Experienced host with beautiful homestays in Hanoi. Specializing in traditional Vietnamese architecture and cultural experiences.</p>
                                <div class="result-actions">
                                    <button class="action-btn primary">
                                        <i class="fas fa-eye mr-2"></i>
                                        View Profile
                                    </button>
                                    <button class="action-btn secondary">
                                        <i class="fas fa-comment mr-2"></i>
                                        Message
                                    </button>
                                </div>
                            </div>

                            <!-- Post Result -->
                            <div class="result-card post-card">
                                <div class="flex items-center gap-4 mb-4">
                                    <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center">
                                        <i class="fas fa-newspaper text-green-600 text-xl"></i>
                                    </div>
                                    <div class="flex-1">
                                        <h3 class="text-lg font-semibold text-gray-800">Tips for First-Time Homestay Guests</h3>
                                        <p class="text-gray-600">by Sarah Johnson • 2 hours ago</p>
                                        <div class="flex items-center gap-2 mt-2">
                                            <span class="tag green">Guide</span>
                                            <span class="tag">Trending</span>
                                        </div>
                                    </div>
                                </div>
                                <p class="text-gray-700 mb-4">Everything you need to know about staying in a Vietnamese homestay. From cultural etiquette to what to pack...</p>
                                <div class="flex items-center gap-4 text-gray-500 text-sm mb-4">
                                    <span><i class="fas fa-heart mr-1"></i>234 likes</span>
                                    <span><i class="fas fa-comment mr-1"></i>45 comments</span>
                                    <span><i class="fas fa-share mr-1"></i>12 shares</span>
                                </div>
                                <div class="result-actions">
                                    <button class="action-btn primary">
                                        <i class="fas fa-eye mr-2"></i>
                                        Read Post
                                    </button>
                                    <button class="action-btn secondary">
                                        <i class="fas fa-heart mr-2"></i>
                                        Like
                                    </button>
                                </div>
                            </div>

                            <!-- House Result -->
                            <div class="result-card house-card">
                                <div class="flex items-center gap-4 mb-4">
                                    <div class="w-16 h-16 bg-orange-100 rounded-full flex items-center justify-center">
                                        <i class="fas fa-home text-orange-600 text-xl"></i>
                                    </div>
                                    <div class="flex-1">
                                        <h3 class="text-lg font-semibold text-gray-800">Cozy Traditional House in Old Quarter</h3>
                                        <p class="text-gray-600">Hanoi, Vietnam • Available Now</p>
                                        <div class="flex items-center gap-2 mt-2">
                                            <span class="tag orange">Available</span>
                                            <span class="tag">Featured</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="grid grid-cols-2 gap-4 mb-4">
                                    <div class="flex items-center gap-2">
                                        <i class="fas fa-dollar-sign text-green-500"></i>
                                        <span class="text-sm"><strong>Price:</strong> 5,000,000 VND/month</span>
                                    </div>
                                    <div class="flex items-center gap-2">
                                        <i class="fas fa-bolt text-yellow-500"></i>
                                        <span class="text-sm"><strong>Electricity:</strong> 3,500 VND/unit</span>
                                    </div>
                                    <div class="flex items-center gap-2">
                                        <i class="fas fa-tint text-blue-500"></i>
                                        <span class="text-sm"><strong>Water:</strong> 15,000 VND/unit</span>
                                    </div>
                                    <div class="flex items-center gap-2">
                                        <i class="fas fa-money-bill-wave text-green-500"></i>
                                        <span class="text-sm"><strong>Deposit:</strong> 10,000,000 VND</span>
                                    </div>
                                </div>
                                <p class="text-gray-700 mb-4">Beautiful traditional house in the heart of Hanoi's Old Quarter. Perfect for cultural immersion with modern amenities.</p>
                                <div class="result-actions">
                                    <button class="action-btn primary">
                                        <i class="fas fa-eye mr-2"></i>
                                        View Details
                                    </button>
                                    <button class="action-btn secondary">
                                        <i class="fas fa-heart mr-2"></i>
                                        Save
                                    </button>
                                    <button class="action-btn secondary">
                                        <i class="fas fa-comments mr-2"></i>
                                        Reviews
                                    </button>
                                </div>
                            </div>

                            <!-- Load More -->
                            <div class="text-center py-8">
                                <button class="action-btn primary px-8 py-3 text-lg">
                                    <i class="fas fa-plus mr-2"></i>
                                    Load More Results
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Floating Action Button -->
        <button class="floating-action" onclick="scrollToTop()">
            <i class="fas fa-arrow-up"></i>
        </button>

        <!-- Scripts -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
            let currentSearchType = 'all';
            let searchHistory = [];
            let searchSuggestions = [];

            $(document).ready(function () {
                initializeSearch();
                setupEventListeners();
                loadSearchHistory();

                const urlParams = new URLSearchParams(window.location.search);
                const searchKey = urlParams.get('searchKey');
                if (searchKey) {
                    updateSearchStats(searchKey);
                    showActualResults();
                }
            });

            function initializeSearch() {
                // Set up search input autocomplete
                $('#searchInput').on('input', function () {
                    const query = $(this).val();
                    if (query.length > 2) {
                        showSearchSuggestions(query);
                    } else {
                        hideSearchSuggestions();
                    }
                });

                $(document).on('click', function (e) {
                    if (!$(e.target).closest('#searchInput, #searchSuggestions').length) {
                        hideSearchSuggestions();
                    }
                });
            }

            function setupEventListeners() {
                $('.search-tab').on('click', function () {
                    $('.search-tab').removeClass('active');
                    $(this).addClass('active');

                    const tabType = $(this).data('tab');
                    currentSearchType = tabType;
                    $('#searchType').val(tabType);

                    updateSearchPlaceholder(tabType);

                    // If there's an active search, filter results
                    const currentQuery = $('#searchInput').val();
                    if (currentQuery) {
                        filterResultsByType(tabType);
                    }
                });

                $('.filter-chip').on('click', function () {
                    $('.filter-chip').removeClass('active');
                    $(this).addClass('active');

                    const filterType = $(this).data('filter');
                    applyQuickFilter(filterType);
                });

                $('#searchForm').on('submit', function (e) {
                    const query = $('#searchInput').val().trim();
                    if (query) {
                        addToSearchHistory(query);
                        showLoadingState();

                        // The form will submit normally, but we can add loading state
                        setTimeout(() => {
                            hideLoadingState();
                        }, 2000);
                    }
                });

                $(document).on('click', '.history-item', function () {
                    const query = $(this).find('span').first().text();
                    $('#searchInput').val(query);
                    $('#searchForm').submit();
                });
            }

            function updateSearchPlaceholder(tabType) {
                const placeholders = {
                    'all': 'Search for anything...',
                    'users': 'Search for users...',
                    'posts': 'Search for posts...',
                    'houses': 'Search for houses...'
                };

                $('#searchInput').attr('placeholder', placeholders[tabType] || placeholders['all']);
            }

            function showSearchSuggestions(query) {
                // Mock suggestions - in real app, this would be an AJAX call
                const mockSuggestions = [
                    {type: 'query', text: query + ' in hanoi', icon: 'fas fa-search'},
                    {type: 'query', text: query + ' cheap', icon: 'fas fa-search'},
                    {type: 'user', text: 'John Doe', icon: 'fas fa-user'},
                    {type: 'location', text: 'Hanoi Old Quarter', icon: 'fas fa-map-marker-alt'},
                    {type: 'tag', text: '#' + query, icon: 'fas fa-hashtag'}
                ];

                let suggestionsHtml = '';
                mockSuggestions.forEach(suggestion => {
                    suggestionsHtml += `
            <div class="suggestion-item" data-query="${suggestion.text}">
                <i class="${suggestion.icon} text-gray-400"></i>
                <span>${suggestion.text}</span>
                <span class="text-xs text-gray-400 ml-auto">${suggestion.type}</span>
            </div>
        `;
                });

                $('#searchSuggestions').html(suggestionsHtml).removeClass('hidden');

                $('.suggestion-item').on('click', function () {
                    const query = $(this).data('query');
                    $('#searchInput').val(query);
                    hideSearchSuggestions();
                    $('#searchForm').submit();
                });
            }

            function hideSearchSuggestions() {
                $('#searchSuggestions').addClass('hidden');
            }

            function toggleAdvancedSearch() {
                const advancedSearch = $('#advancedSearch');
                const icon = $('#advancedIcon');

                if (advancedSearch.hasClass('active')) {
                    advancedSearch.removeClass('active');
                    icon.removeClass('fa-chevron-up').addClass('fa-chevron-down');
                } else {
                    advancedSearch.addClass('active');
                    icon.removeClass('fa-chevron-down').addClass('fa-chevron-up');
                }
            }

            function applyQuickFilter(filterType) {
                showLoadingState();

                setTimeout(() => {
                    hideLoadingState();
                    showActualResults();

                    const messages = {
                        'recent': 'Showing recent results',
                        'popular': 'Showing popular results',
                        'nearby': 'Showing nearby results',
                        'featured': 'Showing featured results'
                    };

                    $('#searchResults').text(messages[filterType] || 'Showing filtered results');
                }, 1000);
            }

            function filterResultsByType(type) {
                const results = $('#actualResults .result-card');

                if (type === 'all') {
                    results.show();
                } else {
                    results.hide();
                    $(`.result-card.${type}-card`).show();
                }

                const visibleCount = results.filter(':visible').length;
                $('#searchResults').text(`Found ` + visibleCount + (type === 'all' ? 'results' : type));
            }

            function addToSearchHistory(query) {
                if (!searchHistory.includes(query)) {
                    searchHistory.unshift(query);
                    if (searchHistory.length > 5) {
                        searchHistory.pop();
                    }

                    saveSearchHistory();
                    updateSearchHistoryUI();
                }
            }

            function loadSearchHistory() {
                const saved = localStorage.getItem('searchHistory');
                if (saved) {
                    searchHistory = JSON.parse(saved);
                    updateSearchHistoryUI();
                }
            }

            function saveSearchHistory() {
                localStorage.setItem('searchHistory', JSON.stringify(searchHistory));
            }

            function updateSearchHistoryUI() {
                const historyContainer = $('.search-history');
                let historyHtml = '';

                if (searchHistory.length === 0) {
                    historyHtml = '<p class="text-center text-white/60">No recent searches</p>';
                } else {
                    searchHistory.forEach(query => {
                        historyHtml += `
                <div class="history-item">
                    <span>` + query + `</span>
                    <i class="fas fa-times text-xs opacity-60" onclick="removeFromHistory('` + query + `')"></i>
                </div>
            `;
                    });
                }

                historyContainer.html(historyHtml);
            }

            function removeFromHistory(query) {
                searchHistory = searchHistory.filter(item => item !== query);
                saveSearchHistory();
                updateSearchHistoryUI();
            }

            function updateSearchStats(query) {
                const resultCount = $('#actualResults .result-card').length;
                $('#searchResults').text(`Found ` + resultCount + ` results for "` + query + `"`);
            }

            function showLoadingState() {
                $('#loadingState').removeClass('hidden');
                $('#actualResults').addClass('hidden');
                $('#noResults').addClass('hidden');
            }

            function hideLoadingState() {
                $('#loadingState').addClass('hidden');
            }

            function showActualResults() {
                $('#actualResults').removeClass('hidden');
                $('#noResults').addClass('hidden');
            }

            function showNoResults() {
                $('#noResults').removeClass('hidden');
                $('#actualResults').addClass('hidden');
            }

            function scrollToTop() {
                $('html, body').animate({
                    scrollTop: 0
                }, 500);
            }

            function setupRealTimeSearch() {
                let searchTimeout;

                $('#searchInput').on('input', function () {
                    const query = $(this).val().trim();

                    clearTimeout(searchTimeout);

                    if (query.length > 2) {
                        searchTimeout = setTimeout(() => {
                            performRealTimeSearch(query);
                        }, 500);
                    }
                });
            }

            function performRealTimeSearch(query) {
                // This would typically be an AJAX call to your backend
                console.log('Performing real-time search for:', query);

                showLoadingState();

                setTimeout(() => {
                    hideLoadingState();
                    showActualResults();
                    updateSearchStats(query);
                }, 1000);
            }

            window.toggleAdvancedSearch = toggleAdvancedSearch;
            window.scrollToTop = scrollToTop;
            window.removeFromHistory = removeFromHistory;
        </script>
    </body>
</html>