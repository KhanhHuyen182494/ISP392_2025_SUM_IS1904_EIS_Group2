<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Feed Item -->
<div class="bg-white rounded-2xl shadow-lg mb-8 overflow-hidden card-hover">
    <!-- User Info -->
    <div class="p-6 pb-4">
        <div class="flex items-center justify-between mb-4">
            <div class="flex items-center gap-3">
                <div class="w-12 h-12 bg-gray-200 rounded-full flex items-center justify-center">
                    <i class="fas fa-user text-gray-400"></i>
                </div>
                <div>
                    <h3 class="font-semibold text-gray-800">Khoai</h3>
                    <p class="text-sm text-gray-500">Posted 2 hours ago</p>
                </div>
            </div>
            <div class="flex gap-2">
                <span class="tag-hover bg-gray-100 text-gray-600 px-3 py-1 rounded-full text-xs cursor-pointer">Tag</span>
                <span class="tag-hover bg-gray-100 text-gray-600 px-3 py-1 rounded-full text-xs cursor-pointer">Tag</span>
                <span class="tag-hover bg-gray-100 text-gray-600 px-3 py-1 rounded-full text-xs cursor-pointer">Tag</span>
                <span class="tag-hover bg-gray-100 text-gray-600 px-3 py-1 rounded-full text-xs cursor-pointer">Tag</span>
            </div>
        </div>

        <!-- Property Title -->
        <h2 class="text-xl font-bold text-gray-800 mb-3">An Thu House - Phòng 402</h2>

        <!-- Description -->
        <p class="text-gray-600 mb-4">
            Phòng khép kín mới tinh, điện nước rẻ, có điều hòa bình nóng lạnh, gác xép và khu bếp.
        </p>

        <!-- Property Details -->
        <div class="space-y-2 mb-4">
            <div class="flex items-center gap-2">
                <i class="fas fa-dollar-sign text-green-500"></i>
                <span class="text-sm"><strong>Giá thuê:</strong> 1.800.000 vnđ / tháng</span>
            </div>
            <div class="flex items-center gap-2">
                <i class="fas fa-bolt text-yellow-500"></i>
                <span class="text-sm"><strong>Tiền điện:</strong> 3.000 vnđ / số</span>
            </div>
            <div class="flex items-center gap-2">
                <i class="fas fa-tint text-blue-500"></i>
                <span class="text-sm"><strong>Tiền nước:</strong> 50.000 vnđ / khối</span>
            </div>
            <div class="flex items-center gap-2">
                <i class="fas fa-map-marker-alt text-red-500"></i>
                <span class="text-sm"><strong>Địa chỉ:</strong> Thôn 4, Thạch Hoà, Thạch Thất, Hà Nội</span>
            </div>
        </div>
    </div>

    <!-- Images -->
    <div class="px-6 pb-4">
        <div class="grid grid-cols-2 gap-4">
            <div class="bg-gray-200 h-48 rounded-lg flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer">
                <i class="fas fa-image text-gray-400 text-2xl"></i>
            </div>
            <div class="bg-gray-200 h-48 rounded-lg flex items-center justify-center hover:bg-gray-300 transition-colors cursor-pointer">
                <i class="fas fa-image text-gray-400 text-2xl"></i>
            </div>
        </div>
    </div>

    <!-- Action Bar -->
    <div class="px-6 py-4 bg-gray-50 flex items-center justify-between">
        <div class="flex items-center gap-4">
            <button class="like-btn flex items-center gap-2 px-3 py-2 rounded-lg bg-white text-blue-500 border border-blue-500 hover:bg-blue-500 hover:text-white transition-colors" onclick="toggleLike(this)">
                <i class="fas fa-thumbs-up"></i>
                <span class="like-count">1</span>
            </button>
        </div>

        <div class="flex items-center gap-2">
            <div class="feedback-badge text-white px-3 py-1 rounded-full text-xs font-medium">
                4 feedbacks
            </div>
        </div>
    </div>

    <!-- Action Buttons -->
    <div class="px-6 py-4 flex gap-3">
        <button class="flex-1 bg-blue-500 hover:bg-blue-600 text-white py-3 rounded-lg font-medium transition-colors">
            <i class="fas fa-key mr-2"></i>
            Rent
        </button>
        <button class="flex-1 bg-gray-200 hover:bg-gray-300 text-gray-700 py-3 rounded-lg font-medium transition-colors">
            <i class="fas fa-comments mr-2"></i>
            View Feedback
        </button>
    </div>
</div>