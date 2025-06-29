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