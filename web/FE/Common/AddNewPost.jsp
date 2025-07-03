<%-- 
    Document   : AddNewPost
    Created on : Jun 18, 2025, 9:12:26 AM
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
        <title>Create New Post</title>

        <!-- Libs -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <link href="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
            .tag-hover {
                transition: all 0.2s ease;
            }
            .tag-hover:hover {
                background-color: #3b82f6;
                color: white;
            }
            .selected-tag {
                background-color: #3b82f6;
                color: white;
            }
            .preview-image {
                max-width: 200px;
                max-height: 200px;
                object-fit: cover;
            }
            .homestay-media-image {
                width: 100%;
                height: 150px;
                object-fit: cover;
            }
            .homestay-info-card {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }
        </style>
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

        <div class="max-w-7xl mx-auto px-4 py-8">
            <div class="bg-white rounded-lg shadow-lg p-8">
                <h1 class="text-2xl font-bold text-gray-800 mb-6">New Post</h1>

                <form id="postForm" action="${pageContext.request.contextPath}/post" method="POST" enctype="multipart/form-data">
                    <!-- User Info and Tags Section -->
                    <div class="grid grid-cols-1 gap-8 mb-4">
                        <!-- User Info Section -->
                        <div class="border-2 border-gray-200 rounded-lg p-6">
                            <div class="flex items-center gap-4">
                                <div class="w-16 h-16 bg-gray-200 rounded-full flex items-center justify-center overflow-hidden">
                                    <img class="w-full h-full object-cover rounded-full" 
                                         src="${pageContext.request.contextPath}/Asset/Common/Avatar/${sessionScope.user.avatar}" 
                                         alt="User Avatar"/>
                                </div>
                                <div>
                                    <h3 class="font-semibold text-gray-800 text-lg">${sessionScope.user.first_name} ${sessionScope.user.last_name}</h3>
                                    <p class="text-gray-600 text-sm">Creating a new post</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Status and Type Section -->
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-4">
                        <div class="border-2 border-gray-200 rounded-lg p-4">
                            <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
                            <select name="status" id="status" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <c:forEach items="${requestScope.sList}" var="s">
                                    <c:if test="${s.id != 15}">
                                        <option value="${s.id}" ${s.id == 14 ? 'selected' : ''}>${s.name}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="border-2 border-gray-200 rounded-lg p-4">
                            <label class="block text-sm font-medium text-gray-700 mb-2">Type</label>
                            <select name="type" id="type" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <c:forEach items="${requestScope.ptList}" var="pt">
                                    <c:choose>
                                        <c:when test="${sessionScope.user.role.id == 1}">
                                            <option value="${pt.id}">${pt.name}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${pt.id != 3 and pt.id != 2 and pt.id != 5}">
                                                <option value="${pt.id}" ${pt.id == 4 ? 'selected' : ''}>${pt.name}</option>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="border-2 border-gray-200 rounded-lg p-4" id="homestaySection" style="display: none;">
                            <label class="block text-sm font-medium text-gray-700 mb-2">Homestay</label>
                            <select name="homestay" id="homestaySelect" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">

                            </select>
                        </div>

                        <!--                        <div class="border-2 border-gray-200 rounded-lg p-4" id="roomSection" style="display: none;">
                                                    <label class="block text-sm font-medium text-gray-700 mb-2">Room</label>
                                                    <select name="room" id="roomSelect" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        
                                                    </select>
                                                </div>-->
                    </div>

                    <!-- Content Section -->
                    <div class="border-2 border-gray-200 rounded-lg p-6 mb-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Post Content</label>
                            <textarea name="content" required rows="8" id="content"
                                      class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                                      placeholder="Write your post content here..."></textarea>
                        </div>
                    </div>

                    <div id="homestayInfoSection" class="border-2 border-blue-200 rounded-lg p-6 mb-4" style="display: none;">
                        <h3 class="text-md font-semibold text-gray-800 mb-4">
                            <i class="fas fa-home text-blue-600 mr-2"></i>
                            Homestay Information Preview
                        </h3>
                        <div id="homestayInfoContent" class="homestay-info-card rounded-lg p-6">

                        </div>
                    </div>

                    <!-- Image Section -->
                    <div class="border-2 border-gray-200 rounded-lg p-6 mb-4">
                        <div id="homestayMediaSection" style="display: none;">
                            <h4 class="text-md font-medium text-gray-700 mb-4">
                                <i class="fas fa-images text-green-600 mr-2"></i>
                                Homestay Media (Will be included automatically)
                            </h4>
                            <div id="homestayMediaPreview" class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4 mb-6">

                            </div>
                            <hr class="my-4">
                        </div>

                        <p class="text-sm text-gray-600 mb-4">If choosing homestay advertised, this will auto fetch. If normal, user can attach image.</p>

                        <div class="mb-4">
                            <label class="block text-sm font-medium text-gray-700 mb-2">Upload Additional Images</label>
                            <div class="relative">
                                <input type="file" name="images" id="imageInput" multiple accept="image/*" class="hidden">
                                <div id="uploadBox" class="w-full h-32 border-2 border-dashed border-gray-300 rounded-lg flex items-center justify-center cursor-pointer hover:border-blue-400 hover:bg-blue-50 transition-all duration-200">
                                    <div class="text-center">
                                        <i class="fas fa-plus text-3xl text-gray-400 mb-2"></i>
                                        <p class="text-sm text-gray-500">Click to upload additional images</p>
                                        <p class="text-xs text-gray-400 mt-1">You can select multiple images</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="imagePreview" class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
                            <!-- User uploaded image previews will appear here -->
                        </div>
                    </div>

                    <!-- Post Button -->
                    <div class="flex justify-end">
                        <button id="postBtn" type="button" class="bg-blue-600 hover:bg-blue-700 text-white px-8 py-3 rounded-lg font-medium transition-colors flex items-center gap-2">
                            <i class="fas fa-paper-plane"></i>
                            Post
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
            $(document).ready(function () {
                let selectedHomestayData = null;

                // Function to format price to VND
                function formatVND(price) {
                    if (!price || isNaN(price)) {
                        return 'Contact for pricing';
                    }

                    // Convert to number if it's a string
                    const numPrice = parseFloat(price);

                    // Format with thousand separators and add VND
                    return numPrice.toLocaleString('vi-VN', {
                        style: 'currency',
                        currency: 'VND',
                        minimumFractionDigits: 0,
                        maximumFractionDigits: 0
                    });
                }

                // Alternative function for custom formatting (if needed)
                function formatVNDCustom(price) {
                    if (!price || isNaN(price)) {
                        return 'Contact for pricing';
                    }

                    const numPrice = parseFloat(price);
                    // Add thousand separators manually
                    const formatted = numPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.');
                    return formatted + ' VND';
                }

                // Handle post type change
                $('#type').change(function () {
                    const selectedType = $(this).val();

                    if (selectedType === '1') {
                        $('#homestaySection').show();

                        // Call AJAX to fetch homestays
                        $.ajax({
                            url: '${pageContext.request.contextPath}/homestay/get',
                            type: 'GET',
                            dataType: 'json',
                            beforeSend: function () {
                                $('#homestaySelect').html('<option value="">Loading...</option>');
                                $('#roomSection').hide();
                                $('#roomSelect').html('<option value="">Select a room</option>');
                                hideHomestayPreview();
                            },
                            success: function (response) {
                                let homestayOptions = '<option value="">Select a homestay</option>';

                                if (response.homestays && response.homestays.length > 0) {
                                    response.homestays.forEach(function (homestay) {
                                        let houseType = homestay.is_whole_house ? 'Whole House' : 'Rooms';
                                        let isWholeHose = homestay.is_whole_house;
                                        homestayOptions += `<option value="` + homestay.id + `" data-whole-house="` + isWholeHose + `">` + homestay.name + ` - ` + houseType + `</option>`;
                                    });
                                } else {
                                    homestayOptions = '<option value="">No homestays available</option>';
                                }

                                $('#homestaySelect').html(homestayOptions);
                            },
                            error: function (xhr, status, error) {
                                console.error('Error fetching homestays:', error);
                                $('#homestaySelect').html('<option value="">Error loading homestays</option>');
                            }
                        });
                    } else {
                        $('#homestaySection').hide();
                        $('#roomSection').hide();
                        hideHomestayPreview();

                        // Reset selects
                        $('#homestaySelect').html('<option value="">Select a homestay</option>');
                        $('#roomSelect').html('<option value="">Select a room</option>');
                    }
                });

                // Handle homestay selection change
                $(document).on('change', '#homestaySelect', function () {
                    $('#homestayMediaPreview').html('');
                    $('#homestayInfoContent').html('');

                    const selectedHomestay = $(this).val();
                    const isWholeHouse = $(this).find('option:selected').data('whole-house');

                    console.log('Homestay selected:', selectedHomestay);
                    console.log('Is whole house:', isWholeHouse);

                    if (selectedHomestay) {
                        // Fetch homestay details including media
//                        fetchHomestayDetails(selectedHomestay);

//                        if (isWholeHouse == true) {
//                            $('#roomSection').hide();
//                        } else if (isWholeHouse == false) {
//                            $('#roomSection').show();

                        $.ajax({
                            url: `${pageContext.request.contextPath}/homestay/room/get`,
                            type: 'GET',
                            dataType: 'json',
                            data: {homestayId: selectedHomestay},
                            beforeSend: function () {
                                $('#roomSelect').html('<option value="">Loading rooms...</option>');
                            },
                            success: function (response) {
//                                    let roomOptions = '<option value="">Leave room blank to post about homestay</option>';
//
//                                    if (response.rooms && response.rooms.length > 0) {
//                                        response.rooms.forEach(function (room) {
//                                            roomOptions += `<option value="` + room.id + `">` + room.name + ` - ` + room.roomType.name + `</option>`;
//                                        });
//                                    } else {
//                                        roomOptions = '<option value="">No rooms available</option>';
//                                    }

                                selectedHomestayData = response.homestay;
                                displayHomestayPreview(response.homestay);

//                                    $('#roomSelect').html(roomOptions);
                            },
                            error: function (xhr, status, error) {
                                console.error('Error fetching rooms:', error);
                                $('#roomSelect').html('<option value="">Error loading rooms</option>');
                            }
                        });
//                        }
                    } else {
                        $('#roomSection').hide();
                        $('#roomSelect').html('<option value="">Select a room</option>');
                        hideHomestayPreview();
                    }
                });

                // Function to display homestay preview
                function displayHomestayPreview(homestay) {
                    // Display homestay media
                    if (homestay.medias && homestay.medias.length > 0) {
                        let mediaHtml = '';
                        homestay.medias.forEach(function (media) {
//                            mediaHtml += `
//                                <div class="relative">
//                                    <img src="${pageContext.request.contextPath}/Asset/Common/Media/` + media.url + `" 
//                                         class="homestay-media-image rounded-lg border-2 border-green-200" 
//                                         alt="Homestay Media">
//                                    <div class="absolute top-2 left-2 bg-green-500 text-white px-2 py-1 rounded text-xs">
//                                        <i class="fas fa-home mr-1"></i>Auto
//                                    </div>
//                                </div>
//                            `;
                            mediaHtml += `
                                <div class="relative">
                                    <img src="${pageContext.request.contextPath}/Asset/Common/House/` + media.path + `" 
                                         class="homestay-media-image rounded-lg border-2 border-green-200" 
                                         alt="Homestay Media">
                                    <div class="absolute top-2 left-2 bg-green-500 text-white px-2 py-1 rounded text-xs">
                                        <i class="fas fa-home mr-1"></i>Auto
                                    </div>
                                </div>
                            `;
                        });
                        $('#homestayMediaPreview').html(mediaHtml);
                        $('#homestayMediaSection').show();
                    } else {
                        $('#homestayMediaSection').hide();
                    }

                    // Display homestay information
                    let infoHtml = `
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <h4 class="text-xl font-bold mb-2">
                                    <i class="fas fa-home mr-2"></i>` + homestay.name + `
                                </h4>
                                <p class="mb-2">
                                    <i class="fas fa-map-marker-alt mr-2"></i>
                                    <span class="text-sm">` + (homestay.address.detail ? homestay.address.detail : '') + ' ' + homestay.address.ward + `, ` + homestay.address.district + `, ` + homestay.address.province + `, ` + homestay.address.country + `</span>
                                </p>
                                <p class="mb-2">
                                    <i class="fas fa-home mr-2"></i>
                                    <span class="text-sm">` + (homestay.is_whole_house ? 'Whole House' : 'Rooms Available') + `</span>
                                </p>
                                <p class="mb-2">
                                    <i class="fas fa-info-circle mr-2"></i>
                                    <span class="text-sm">` + (homestay.description || 'No description available') + `</span>
                                </p>
                            </div>
                            <div>
                                <div class="bg-white bg-opacity-20 rounded-lg p-4">
                                    <h5 class="font-semibold mb-2">
                                        <i class="fas fa-dollar-sign mr-2"></i>Pricing Information
                                    </h5>
                                    <p class="text-sm mb-1">
                                        <span class="font-medium">Price:</span> 
                                        ` + formatVND(homestay.price_per_night) + `
                                    </p>
                                    <p class="text-sm">
                                        <span class="font-medium">Status:</span> 
                                        <span class="px-2 py-1 rounded-full text-xs bg-white bg-opacity-20">
                                            ` + (homestay.status.name || 'Available') + `
                                        </span>
                                    </p>
                                </div>
                            </div>
                        </div>
                    `;

                    $('#homestayInfoContent').html(infoHtml);
                    $('#homestayInfoSection').show();
                }

                // Function to hide homestay preview
                function hideHomestayPreview() {
                    $('#homestayInfoSection').hide();
                    $('#homestayMediaSection').hide();
                    selectedHomestayData = null;
                }

                // Handle upload box click
                $('#uploadBox').click(function () {
                    $('#imageInput').click();
                });

                // Handle image preview
                $('#imageInput').change(function () {
                    const files = this.files;
                    $('#imagePreview').empty();

                    for (let i = 0; i < files.length; i++) {
                        const file = files[i];
                        if (file.type.startsWith('image/')) {
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                $('#imagePreview').append(
                                        '<div class="relative">' +
                                        '<img src="' + e.target.result + '" class="preview-image rounded-lg border-2 border-gray-200">' +
                                        '<div class="absolute top-2 left-2 bg-blue-500 text-white px-2 py-1 rounded text-xs">' +
                                        '<i class="fas fa-user mr-1"></i>User' +
                                        '</div>' +
                                        '<button type="button" class="absolute top-2 right-2 bg-red-500 text-white rounded-full w-6 h-6 flex items-center justify-center text-xs hover:bg-red-600" onclick="$(this).parent().remove()">' +
                                        '<i class="fas fa-times"></i>' +
                                        '</button>' +
                                        '</div>'
                                        );
                            };
                            reader.readAsDataURL(file);
                        }
                    }
                });

                $('#imageInput').on('input', function () {
                    const maxSize = 10 * 1024 * 1024; // 10MB in bytes
                    const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/bmp', 'image/webp'];
                    const allowedExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];

                    const files = this.files;
                    const validFiles = [];
                    let hasError = false;

                    if (files.length > 0) {
                        for (let i = 0; i < files.length; i++) {
                            const file = files[i];
                            let isValid = true;

                            // Check file size
                            if (file.size > maxSize) {
                                showToast(`File "` + file.name + `" is too large. Maximum size is 10MB.`, 'error');
                                hasError = true;
                                isValid = false;
                            }

                            // Check file type by MIME type and extension
                            if (isValid) {
                                const fileName = file.name.toLowerCase();
                                const hasValidType = allowedTypes.includes(file.type);
                                const hasValidExtension = allowedExtensions.some(ext => fileName.endsWith(ext));

                                if (!hasValidType && !hasValidExtension) {
                                    showToast(`File "` + file.name + `" is not a valid image. Only JPG, JPEG, PNG, GIF, BMP, and WEBP files are allowed.`, 'error');
                                    hasError = true;
                                    isValid = false;
                                    return;
                                }
                            }

                            // Add valid files to array
                            if (isValid) {
                                validFiles.push(file);
                            }
                        }

                        // If there are errors, clear the input and show message
                        if (hasError) {
                            $(this).val(''); // Clear the input
                            showToast('Please select valid image files under 10MB each.', 'warning');
                        } else {
                            // Optional: Show success message for valid files
                            if (validFiles.length === 1) {
//                                showToast('Image selected successfully!', 'success');
                            } else {
                                showToast(validFiles.length + ` images selected successfully!`, 'success');
                            }
                        }
                    }
                });

                // Handle form submission
                $('#postBtn').on('click', function () {
                    let statusId = $('#status').val();
                    let typePost = $('#type').val();
                    let content = $('#content').val();
                    let homestaychoosed = null;

                    if (typePost == 1) {
                        homestaychoosed = $('#homestaySelect').val();
                        if (homestaychoosed.trim() === "") {
                            showToast('If advertise homestay, please choose a homestay to advertise!', 'error');
                            return;
                        }
                    }

                    if (content.trim() === "") {
                        showToast('Content can not be blank!', 'error');
                        return;
                    }

                    let imageInput = document.getElementById('imageInput');
                    let imageFiles = imageInput.files;

                    if (imageFiles.length > 0) {
                        const maxSize = 10 * 1024 * 1024;
                        const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/bmp', 'image/webp'];
                        const allowedExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];

                        for (let i = 0; i < imageFiles.length; i++) {
                            const file = imageFiles[i];

                            if (file.size > maxSize) {
                                showToast(`File "` + file.name + `" is too large. Maximum size is 10MB.`, 'error');
                                return;
                            }

                            if (!allowedTypes.includes(file.type)) {
                                const fileName = file.name.toLowerCase();
                                const hasValidExtension = allowedExtensions.some(ext => fileName.endsWith(ext));

                                if (!hasValidExtension) {
                                    showToast(`File "` + file.name + `" is not a valid image. Only JPG, JPEG, PNG, GIF, BMP, and WEBP files are allowed.`, 'error');
                                    return;
                                }
                            }
                        }
                    }

                    let formData = new FormData();
                    formData.append('status', statusId);
                    formData.append('type', typePost);
                    formData.append('content', content);

                    if (homestaychoosed) {
                        formData.append('homestay', homestaychoosed);
                    }

                    if (imageFiles.length > 0) {
                        for (let i = 0; i < imageFiles.length; i++) {
                            formData.append('images', imageFiles[i]);
                        }
                    }

                    Swal.fire({
                        title: 'Creating Post...',
                        text: 'Please wait while we create your post.',
                        allowOutsideClick: false,
                        didOpen: () => {
                            Swal.showLoading();
                        }
                    });

                    formData.append("typeWork", "post");

                    $.ajax({
                        processData: false,
                        contentType: false,
                        url: '${pageContext.request.contextPath}/post',
                        type: 'POST',
                        data: formData,
                        success: function (response) {
                            Swal.close();
                            if (response.ok) {
                                showToast(response.message, 'success');

                                Swal.fire({
                                    title: 'Post success, continue post or go to feeds?',
                                    imageUrl: `${pageContext.request.contextPath}/Asset/FUHF Logo/3.svg`,
                                    imageWidth: 150,
                                    imageHeight: 150,
                                    imageAlt: 'Custom icon',
                                    showCancelButton: true,
                                    confirmButtonText: 'Continue',
                                    cancelButtonText: 'Back to Newsfeed',
                                    reverseButtons: false,
                                    focusConfirm: true,
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
                                        location.href = '${pageContext.request.contextPath}/post';
                                    } else if (result.dismiss === Swal.DismissReason.cancel) {
                                        location.href = '${pageContext.request.contextPath}/feeds';
                                    }
                                });

//                                setTimeout(function () {
//                                    location.href = '${pageContext.request.contextPath}/feeds';
//                                }, 2000);
                            } else {
                                showToast(response.message, 'error');
                            }
                        },
                        error: function (xhr, status, error) {
                            Swal.close();
                            showToast(xhr.responseText || 'Something went wrong.', 'error');
                        }
                    });
                });

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
        </script>
    </body>
</html>