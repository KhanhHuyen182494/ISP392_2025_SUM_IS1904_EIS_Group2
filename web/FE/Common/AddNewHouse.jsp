<%-- 
    Document   : AddNewHouse
    Created on : Jun 21, 2025, 2:09:55 PM
    Author     : Ha
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
        <title>Add new house</title>

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
            <!-- Header -->
            <div class="text-center mb-8">
                <h1 class="text-4xl font-bold    mb-2">
                    Create New Homestay
                </h1>
                <p class="text-gray-600 text-lg">Share your beautiful space with travelers from around the world</p>
            </div>

            <!-- Main Form Card -->
            <div class="bg-white/80 backdrop-blur-sm rounded-2xl shadow-xl border border-white/20 overflow-hidden">
                <div class="bg-gradient-to-r from-blue-600 to-indigo-600 p-6">
                    <div class="flex items-center">
                        <i class="fas fa-home text-2xl mr-3"></i>
                        <h2 class="text-2xl font-semibold">Homestay Details</h2>
                    </div>
                </div>

                <div class="p-8 space-y-8">
                    <!-- Homestay Name -->
                    <div class="group">
                        <label class="block text-sm font-semibold text-gray-700 mb-3 flex items-center">
                            <i class="fas fa-tag text-blue-500 mr-2"></i>
                            Homestay Name
                        </label>
                        <div class="relative">
                            <input name="homestayName" required id="homestayName"
                                   class="w-full px-4 py-4 bg-gray-50 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-4 focus:ring-blue-100 focus:border-blue-500 transition-all duration-300 text-gray-900 placeholder-gray-500"
                                   placeholder="Give your homestay a memorable name..." />
                            <div class="absolute inset-y-0 right-0 flex items-center pr-4">
                                <i class="fas fa-edit text-gray-400 group-hover:text-blue-500 transition-colors"></i>
                            </div>
                        </div>
                    </div>

                    <!-- Description Section -->
                    <div class="group">
                        <label class="block text-sm font-semibold text-gray-700 mb-3 flex items-center">
                            <i class="fas fa-align-left text-blue-500 mr-2"></i>
                            Description
                        </label>
                        <textarea name="homestayDescription" required rows="6" id="homestayDescription"
                                  class="w-full px-4 py-4 bg-gray-50 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-4 focus:ring-blue-100 focus:border-blue-500 transition-all duration-300 text-gray-900 placeholder-gray-500 resize-none"
                                  placeholder="Describe what makes your homestay special. Include amenities, nearby attractions, and what guests can expect..."></textarea>
                    </div>

                    <!-- Rental Type and Pricing -->
                    <div class="bg-gradient-to-r from-blue-50 to-indigo-50 rounded-xl p-6 border border-blue-100">
                        <h3 class="text-lg font-semibold text-gray-800 mb-6 flex items-center">
                            <i class="fas fa-money-bill-wave text-green-500 mr-2"></i>
                            Rental Options & Pricing
                        </h3>

                        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                            <!-- Rental Type -->
                            <div class="lg:col-span-1">
                                <label class="block text-sm font-medium text-gray-700 mb-4">Rental Type</label>
                                <div class="space-y-3">
                                    <label class="flex items-center p-4 bg-white rounded-lg border-2 border-gray-200 cursor-pointer hover:border-blue-300 hover:bg-blue-50 transition-all duration-200">
                                        <input type="radio" name="wholeHouse" value="yes" id="wholeHouseYes"
                                               class="w-5 h-5 text-blue-600 border-gray-300 focus:ring-blue-500 focus:ring-2"/>
                                        <div class="ml-3">
                                            <div class="text-sm font-medium text-gray-900">Whole House</div>
                                            <div class="text-xs text-gray-500">Rent entire property</div>
                                        </div>
                                        <i class="fas fa-home ml-auto text-blue-500"></i>
                                    </label>

                                    <label class="flex items-center p-4 bg-white rounded-lg border-2 border-gray-200 cursor-pointer hover:border-blue-300 hover:bg-blue-50 transition-all duration-200">
                                        <input type="radio" name="wholeHouse" value="no" id="wholeHouseNo"
                                               class="w-5 h-5 text-blue-600 border-gray-300 focus:ring-blue-500 focus:ring-2"/>
                                        <div class="ml-3">
                                            <div class="text-sm font-medium text-gray-900">Room Only</div>
                                            <div class="text-xs text-gray-500">Rent individual rooms</div>
                                        </div>
                                        <i class="fas fa-bed ml-auto text-blue-500"></i>
                                    </label>
                                </div>
                            </div>

                            <!-- Price Per Night -->
                            <div class="lg:col-span-1" id="wholePriceSection" style="display: none;">
                                <label class="block text-sm font-medium text-gray-700 mb-4">Price Per Night</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                        <span class="text-gray-500 text-sm font-medium">VND</span>
                                    </div>
                                    <input name="homestayPrice" id="homestayPrice" type="number" min="0"
                                           class="w-full pl-16 pr-4 py-4 bg-white border-2 border-gray-200 rounded-lg focus:outline-none focus:ring-4 focus:ring-blue-100 focus:border-blue-500 transition-all duration-300"
                                           placeholder="0" />
                                    <div class="absolute inset-y-0 right-0 pr-4 flex items-center pointer-events-none">
                                        <i class="fas fa-dong-sign text-gray-400"></i>
                                    </div>
                                </div>
                            </div>

                            <!-- Status -->
                            <div class="lg:col-span-1">
                                <label class="block text-sm font-medium text-gray-700 mb-4">Availability Status</label>
                                <div class="relative">
                                    <select name="status" id="status" 
                                            class="w-full px-4 py-4 bg-white border-2 border-gray-200 rounded-lg focus:outline-none focus:ring-4 focus:ring-blue-100 focus:border-blue-500 transition-all duration-300 appearance-none">
                                        <c:forEach items="${statuses}" var="s">
                                            <option value="${s.id}">${s.name}</option>
                                        </c:forEach>
                                    </select>
                                    <!--                                    <div class="absolute inset-y-0 right-0 pr-4 flex items-center pointer-events-none">
                                                                            <i class="fas fa-chevron-down text-gray-400"></i>
                                                                        </div>-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Location Section -->
                    <div class="bg-gradient-to-r from-green-50 to-emerald-50 rounded-xl p-6 border border-green-100">
                        <h3 class="text-lg font-semibold text-gray-800 mb-6 flex items-center">
                            <i class="fas fa-map-marker-alt text-red-500 mr-2"></i>
                            Location Information
                        </h3>

                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-3">Province</label>
                                <div class="relative">
                                    <select name="province" id="tinh" title="Choose Province"
                                            class="w-full px-4 py-3 bg-white border-2 border-gray-200 rounded-lg focus:outline-none focus:ring-4 focus:ring-green-100 focus:border-green-500 transition-all duration-300 appearance-none">
                                        <option value="">Select Province</option>
                                    </select>
                                    <!--<i class="fas fa-chevron-down absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400 pointer-events-none"></i>-->
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-3">District</label>
                                <div class="relative">
                                    <select name="district" id="quan" title="Choose District"
                                            class="w-full px-4 py-3 bg-white border-2 border-gray-200 rounded-lg focus:outline-none focus:ring-4 focus:ring-green-100 focus:border-green-500 transition-all duration-300 appearance-none">
                                        <option value="">Select District</option>
                                    </select>
                                    <!--<i class="fas fa-chevron-down absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400 pointer-events-none"></i>-->
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-3">Ward</label>
                                <div class="relative">
                                    <select name="ward" id="phuong" title="Choose Ward"
                                            class="w-full px-4 py-3 bg-white border-2 border-gray-200 rounded-lg focus:outline-none focus:ring-4 focus:ring-green-100 focus:border-green-500 transition-all duration-300 appearance-none">
                                        <option value="">Select Ward</option>
                                    </select>
                                    <!--<i class="fas fa-chevron-down absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400 pointer-events-none"></i>-->
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-3">Detailed Address</label>
                                <input name="detailAddress" id="detailAddress"
                                       class="w-full px-4 py-3 bg-white border-2 border-gray-200 rounded-lg focus:outline-none focus:ring-4 focus:ring-green-100 focus:border-green-500 transition-all duration-300"
                                       placeholder="Street, building number..." />
                            </div>
                        </div>
                    </div>

                    <!-- Homestay Images Section -->
                    <div class="bg-gradient-to-r from-purple-50 to-pink-50 rounded-xl p-6 border border-purple-100">
                        <div class="mb-6">
                            <h3 class="text-lg font-semibold text-gray-800 mb-2 flex items-center">
                                <i class="fas fa-camera text-purple-500 mr-2"></i>
                                Homestay Images
                            </h3>
                            <p class="text-sm text-gray-600">Upload beautiful photos that showcase your homestay's best features</p>
                        </div>

                        <div class="relative mb-6">
                            <input type="file" name="homestayImages" id="homestayImageInput" multiple accept="image/*" class="hidden">
                            <div id="homestayUploadBox" 
                                 class="p-10 w-full h-40 border-3 border-dashed border-purple-300 rounded-xl flex items-center justify-center cursor-pointer hover:border-purple-400 hover:bg-purple-100 transition-all duration-300 group">
                                <div class="text-center">
                                    <div class="w-16 h-16 mx-auto mb-4 bg-purple-100 rounded-full flex items-center justify-center group-hover:bg-purple-200 transition-colors">
                                        <i class="fas fa-cloud-upload-alt text-2xl text-purple-500"></i>
                                    </div>
                                    <p class="text-lg font-medium text-gray-700">Click to upload images</p>
                                    <p class="text-sm text-gray-500">or drag and drop your photos here</p>
                                    <p class="text-xs text-gray-400 mt-2">Support: JPG, PNG, WEBP (Max 10MB each)</p>
                                </div>
                            </div>
                        </div>

                        <div id="homestayImagePreview" class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
                            <!-- Image previews will appear here -->
                        </div>
                    </div>

                    <!-- Room Management Section -->
                    <div id="roomSection" style="display: none;" class="bg-gradient-to-r from-orange-50 to-amber-50 rounded-xl p-6 border border-orange-100">
                        <div class="flex justify-between items-center mb-6">
                            <h3 class="text-lg font-semibold text-gray-800 flex items-center">
                                <i class="fas fa-bed text-orange-500 mr-2"></i>
                                Room Management
                            </h3>
                            <button type="button" id="addRoomBtn" 
                                    class="bg-orange-500 hover:from-green-600 hover:to-emerald-600 text-white px-6 py-3 rounded-lg font-medium transition-all duration-300 flex items-center gap-2 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5">
                                <i class="fas fa-plus"></i>
                                Add New Room
                            </button>
                        </div>

                        <div id="roomsContainer" class="space-y-4">
                            <!-- Rooms will be added here dynamically -->
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <div class="text-center pt-8 border-t border-gray-200">
                        <button id="addBtn" type="button" 
                                class="bg-orange-500 hover:from-blue-700 hover:to-indigo-700 text-white px-12 py-4 rounded-xl font-semibold text-lg transition-all duration-300 flex items-center gap-3 mx-auto shadow-lg hover:shadow-xl transform hover:-translate-y-1">
                            <i class="fas fa-rocket"></i>
                            Add My Homestay
                            <i class="fas fa-arrow-right"></i>
                        </button>
                        <p class="text-sm text-gray-500 mt-3">Ready to welcome your first guests?</p>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
            $(document).ready(function () {
                let roomCounter = 0;

                // Load provinces
                $.getJSON('https://esgoo.net/api-tinhthanh/1/0.htm', function (data_tinh) {
                    if (data_tinh.error == 0) {
                        $.each(data_tinh.data, function (key_tinh, val_tinh) {
                            $("#tinh").append('<option data-id="' + val_tinh.id + '" value="' + val_tinh.full_name + '">' + val_tinh.full_name + '</option>');
                        });

                        $("#tinh").change(function () {
                            var tentinh = $(this).val(); // name
                            var idtinh = $(this).find(':selected').data('id'); // id (optional)

                            $.getJSON('https://esgoo.net/api-tinhthanh/2/' + idtinh + '.htm', function (data_quan) {
                                if (data_quan.error == 0) {
                                    $("#quan").html('<option value="">Select District</option>');
                                    $("#phuong").html('<option value="">Select Ward</option>');

                                    $.each(data_quan.data, function (key_quan, val_quan) {
                                        $("#quan").append('<option data-id="' + val_quan.id + '" value="' + val_quan.full_name + '">' + val_quan.full_name + '</option>');
                                    });

                                    $("#quan").off('change').on('change', function () {
                                        var tenquan = $(this).val(); // name
                                        var idquan = $(this).find(':selected').data('id'); // id

                                        $.getJSON('https://esgoo.net/api-tinhthanh/3/' + idquan + '.htm', function (data_phuong) {
                                            if (data_phuong.error == 0) {
                                                $("#phuong").html('<option value="">Select Ward</option>');

                                                $.each(data_phuong.data, function (key_phuong, val_phuong) {
                                                    $("#phuong").append('<option data-id="' + val_phuong.id + '" value="' + val_phuong.full_name + '">' + val_phuong.full_name + '</option>');
                                                });
                                            }
                                        });
                                    });
                                }
                            });
                        });
                    }
                });


                // Handle rental type change
                $('input[name="wholeHouse"]').change(function () {
                    const isWholeHouse = $(this).val() === 'yes';
                    if (isWholeHouse) {
                        $('#wholePriceSection').show();
                        $('#roomSection').hide();
                        $('#roomsContainer').empty();
                        roomCounter = 0;
                    } else {
                        $('#wholePriceSection').hide();
                        $('#roomSection').show();
                        $('#homestayPrice').val('');
                    }
                });

                // Add room functionality
                $('#addRoomBtn').click(function () {
                    roomCounter++;

                    let rtsString = '${rts}';
                    let rstaString = '${roomStatuses}';

                    let roomTypes = [];
                    let roomStatuses = [];
                    const matchesRoomType = rtsString.match(/RoomType\{id=(\d+), name=([^}]+)\}/g);
                    const matchesRoomStatus = rstaString.match(/Status\{id=(\d+), name=([^,]+), category=([^\}]+)\}/g);

                    if (matchesRoomType) {
                        matchesRoomType.forEach(match => {
                            const idMatch = match.match(/id=(\d+)/);
                            const nameMatch = match.match(/name=([^}]+)/);

                            if (idMatch && nameMatch) {
                                roomTypes.push({
                                    id: parseInt(idMatch[1]),
                                    name: nameMatch[1]
                                });
                            }
                        });
                    }

                    if (matchesRoomStatus) {
                        matchesRoomStatus.forEach(match => {
                            const statusRegex = /Status\{id=(\d+), name=([^,]+), category=([^\}]+)\}/;
                            const statusMatch = match.match(statusRegex);

                            if (statusMatch) {
                                roomStatuses.push({
                                    id: parseInt(statusMatch[1]),
                                    name: statusMatch[2].trim(),
                                    category: statusMatch[3].trim()
                                });
                            }
                        });
                    }

                    let roomTypeOptions = '<option value="">Select Room Type</option>';
                    roomTypes.forEach(type => {
                        roomTypeOptions += `<option value="` + type.id + `">` + type.name + `</option>`;
                    });

                    let roomStatusOptions = '<option value="">Select Room Status</option>';
                    roomStatuses.forEach(status => {
                        roomStatusOptions += `<option value="` + status.id + `">` + status.name + `</option>`;
                    });

                    const roomHtml = `
            <div class="room-item border border-gray-300 rounded-lg p-4 mb-4" data-room="` + roomCounter + `">
                <div class="flex justify-between items-center mb-3">
                    <h4 class="font-medium text-gray-700">Room ` + roomCounter + `</h4>
                    <button type="button" class="remove-room-btn bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded text-sm">
                        <i class="fas fa-trash"></i> Remove
                    </button>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Room Type</label>
                        <select name="rooms[` + roomCounter + `][type]" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                            ` + roomTypeOptions + `
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Room Status</label>
                        <select name="rooms[` + roomCounter + `][status]" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                            ` + roomStatusOptions + `
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Price Per Night (VND)</label>
                        <input name="rooms[` + roomCounter + `][price]" type="number" min="0" required
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                            placeholder="Enter room price..." />
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Max Guests</label>
                        <input name="rooms[` + roomCounter + `][maxGuests]" type="number" min="1" max="10" required
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                            placeholder="Max guests..." />
                    </div>
                </div>
                <div class="mb-4">
                    <label class="block text-sm font-medium text-gray-700 mb-2">Room Name</label>
                    <input name="rooms[` + roomCounter + `][name]" rows="3" type="text"
                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                        placeholder="Enter room name..." />
                </div>
                <div class="mb-4">
                    <label class="block text-sm font-medium text-gray-700 mb-2">Room Position</label>
                    <input name="rooms[` + roomCounter + `][position]" rows="3" type="text"
                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                        placeholder="Enter room position..." />
                </div>
                <div class="mb-4">
                    <label class="block text-sm font-medium text-gray-700 mb-2">Room Description</label>
                    <textarea name="rooms[` + roomCounter + `][description]" rows="3"
                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                        placeholder="Describe this room (amenities, features, etc.)..."></textarea>
                </div>
                <div class="mb-4">
                    <label class="block text-sm font-medium text-gray-700 mb-2">Room Images</label>
                    <div class="relative">
                        <input type="file" name="rooms[` + roomCounter + `][images]" multiple accept="image/*" class="hidden" id="roomImageInput` + roomCounter + `">
                        <div class="room-upload-box w-full h-24 border-2 border-dashed border-gray-300 rounded-lg flex items-center justify-center cursor-pointer hover:border-blue-400 hover:bg-blue-50 transition-all duration-200" data-room="` + roomCounter + `">
                            <div class="text-center">
                                <i class="fas fa-camera text-xl text-gray-400 mb-1"></i>
                                <p class="text-xs text-gray-500">Upload room images</p>
                            </div>
                        </div>
                    </div>
                    <div class="room-image-preview grid grid-cols-2 md:grid-cols-4 gap-2 mt-2" data-room="` + roomCounter + `"></div>
                </div>
            </div>
        `;
                    $('#roomsContainer').append(roomHtml);
                });

                // Remove room functionality
                $(document).on('click', '.remove-room-btn', function () {
                    $(this).closest('.room-item').remove();
                });

                // Homestay image upload
                $('#homestayUploadBox').click(function () {
                    $('#homestayImageInput').click();
                });

                $('#homestayImageInput').change(function () {
                    handleImagePreview(this, '#homestayImagePreview');
                });

                // Room image upload
                $(document).on('click', '.room-upload-box', function () {
                    const roomNumber = $(this).data('room');
                    $('#roomImageInput' + roomNumber).click();
                });

                $(document).on('change', 'input[name*="[images]"]', function () {
                    const roomNumber = $(this).closest('.room-item').data('room');
                    handleImagePreview(this, `.room-image-preview[data-room="` + roomNumber + `"]`);
                });

                function handleImagePreview(input, previewContainer) {
                    if (!validateImages(input)) {
                        input.value = ''; // Clear the input if validation fails
                        return;
                    }

                    const files = input.files;
                    $(previewContainer).empty();

                    for (let i = 0; i < files.length; i++) {
                        const file = files[i];
                        if (file.type.startsWith('image/')) {
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                $(previewContainer).append(
                                        `<div class="relative">
                            <img src="` + e.target.result + `" class="w-full h-full object-cover rounded-lg border-2 border-gray-200">
                            <button type="button" class="absolute top-1 right-1 bg-red-500 text-white rounded-full w-5 h-5 flex items-center justify-center text-xs hover:bg-red-600" onclick="$(this).parent().remove()">
                                <i class="fas fa-times"></i>
                            </button>
                        </div>`
                                        );
                            };
                            reader.readAsDataURL(file);
                        }
                    }
                }

                function validateImages(input) {
                    const maxSize = 10 * 1024 * 1024;
                    const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/bmp', 'image/webp'];
                    const files = input.files;

                    for (let i = 0; i < files.length; i++) {
                        const file = files[i];
                        if (file.size > maxSize) {
                            showToast(`File "` + file.name + `" is too large. Maximum size is 10MB.`, 'error');
                            return false;
                        }
                        if (!allowedTypes.includes(file.type)) {
                            showToast(`File "` + file.name + `" is not a valid image format.`, 'error');
                            return false;
                        }
                    }
                    return true;
                }

                // Handle form submission
                $('#addBtn').on('click', function () {
                    const homestayName = $('#homestayName').val().trim();
                    const homestayDescription = $('#homestayDescription').val().trim();
                    const isWholeHouse = $('input[name="wholeHouse"]:checked').val();
                    const tinh = $('#tinh').val().trim();
                    const quan = $('#quan').val().trim();
                    const phuong = $('#phuong').val().trim();
                    const detailAddress = $('#detailAddress').val().trim();
                    const status = $('#status').val();

                    // Basic validations
                    if (!homestayName) {
                        showToast('Homestay name is required!', 'error');
                        return;
                    }

                    if (!homestayDescription) {
                        showToast('Homestay description is required!', 'error');
                        return;
                    }

                    if (!isWholeHouse) {
                        showToast('Please select rental type!', 'error');
                        return;
                    }

                    if (!tinh) {
                        showToast('Please choose Province!', 'error');
                        return;
                    }

                    if (!quan) {
                        showToast('Please choose District!', 'error');
                        return;
                    }

                    if (!phuong) {
                        showToast('Please choose Ward!', 'error');
                        return;
                    }

                    // Validate homestay images
                    const homestayImages = $('#homestayImageInput')[0].files;
                    if (!homestayImages || homestayImages.length === 0) {
                        showToast('Please upload at least one homestay image!', 'error');
                        return;
                    }

                    // Collect data based on rental type
                    let formData = new FormData();

                    // Basic homestay data
                    formData.append('homestayName', homestayName);
                    formData.append('homestayDescription', homestayDescription);
                    formData.append('wholeHouse', isWholeHouse);
                    formData.append('province', tinh);
                    formData.append('district', quan);
                    formData.append('ward', phuong);
                    formData.append('detailAddress', detailAddress);
                    formData.append('status', status);

                    // Add homestay images
                    for (let i = 0; i < homestayImages.length; i++) {
                        formData.append('homestayImages', homestayImages[i]);
                    }

                    if (isWholeHouse === 'yes') {
                        // Whole house rental
                        const price = $('#homestayPrice').val();
                        if (!price || price <= 0) {
                            showToast('Please enter a valid price for the whole house!', 'error');
                            return;
                        }
                        formData.append('homestayPrice', price);

                    } else {
                        // Room rental
                        const rooms = $('.room-item');
                        if (rooms.length === 0) {
                            showToast('Please add at least one room!', 'error');
                            return;
                        }

                        let roomValid = true;
                        let roomData = [];

                        rooms.each(function (index) {
                            const roomNumber = $(this).data('room');
                            const roomType = $(this).find('select[name*="[type]"]').val();
                            const roomStatus = $(this).find('select[name*="[status]"]').val();
                            const roomPrice = $(this).find('input[name*="[price]"]').val();
                            const maxGuests = $(this).find('input[name*="[maxGuests]"]').val();
                            const roomName = $(this).find('input[name*="[name]"]').val().trim();
                            const roomDescription = $(this).find('textarea[name*="[description]"]').val().trim();
                            const roomPosition = $(this).find('input[name*="[position]"]').val().trim();
                            const roomImages = $(this).find('input[name*="[images]"]')[0].files;

                            // Validate room data
                            if (!roomType || !roomPrice || !maxGuests || roomPrice <= 0 || maxGuests <= 0 || !roomName || !roomPosition) {
                                showToast('Please fill in all required room information for Room ' + roomNumber + '!', 'error');
                                roomValid = false;
                                return false;
                            }

                            if (roomName.length > 40) {
                                showToast('Room name for Room ' + roomNumber + ' max length is 40!', 'error');
                                roomValid = false;
                                return false;
                            }

                            if (roomDescription.length > 100) {
                                showToast('Room name for Room ' + roomNumber + ' max length is 100!', 'error');
                                roomValid = false;
                                return false;
                            }

                            if (roomPosition.length > 20) {
                                showToast('Room name for Room ' + roomNumber + ' max length is 20!', 'error');
                                roomValid = false;
                                return false;
                            }

                            // Validate room images
                            if (!roomImages || roomImages.length === 0) {
                                showToast('Please upload at least one image for Room ' + roomNumber + '!', 'error');
                                roomValid = false;
                                return false;
                            }

                            // Collect room data
                            const room = {
                                roomNumber: roomNumber,
                                type: roomType,
                                price: roomPrice,
                                maxGuests: maxGuests,
                                description: roomDescription || ''
                            };

                            roomData.push(room);

                            // Add room data to formData
                            formData.append('rooms[' + index + '][roomNumber]', roomNumber);
                            formData.append('rooms[' + index + '][type]', roomType);
                            formData.append('rooms[' + index + '][price]', roomPrice);
                            formData.append('rooms[' + index + '][maxGuests]', maxGuests);
                            formData.append('rooms[' + index + '][description]', roomDescription || '');
                            formData.append('rooms[' + index + '][name]', roomName);
                            formData.append('rooms[' + index + '][position]', roomPosition);
                            formData.append('rooms[' + index + '][status]', roomStatus);

                            // Add room images
                            for (let i = 0; i < roomImages.length; i++) {
                                formData.append('rooms[' + index + '][images]', roomImages[i]);
                            }
                        });

                        if (!roomValid) {
                            return;
                        }

                        // Add total room count
                        formData.append('totalRooms', rooms.length);
                    }

                    // Show loading and submit
                    Swal.fire({
                        title: 'Creating Homestay...',
                        text: 'Please wait while we create your homestay.',
                        allowOutsideClick: false,
                        didOpen: () => {
                            Swal.showLoading();
                        }
                    });

                    formData.forEach((value, key) => {
                        console.log(key + ": " + value);
                    });

                    $.ajax({
                        processData: false,
                        contentType: false,
                        url: '${pageContext.request.contextPath}/owner-house/add',
                        type: 'POST',
                        data: formData,
                        success: function (response) {
                            Swal.close();
                            if (response.ok) {
                                showToast(response.message, 'success');
                                // Optionally reset form or redirect
                                setTimeout(() => {
                                    window.location.href = '${pageContext.request.contextPath}/owner-house?uid=${sessionScope.user.id}';
                                }, 2000);
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