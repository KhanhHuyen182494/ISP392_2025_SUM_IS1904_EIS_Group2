<%-- 
    Document   : RoomAdd
    Created on : Jun 29, 2025, 6:53:57 AM
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
            <!-- Header -->
            <div class="text-center mb-8">
                <h1 class="text-4xl font-bold text-gray-800 mb-2">
                    <i class="fas fa-bed text-blue-600 mr-3"></i>
                    Create New Rooms
                </h1>
                <p class="text-gray-600 text-lg">Add multiple rooms to your homestay with detailed information</p>
            </div>

            <!-- Main Form Card -->
            <div class="bg-white/80 backdrop-blur-sm rounded-2xl shadow-xl border border-white/20 overflow-hidden">
                <div class="bg-gradient-to-r from-blue-600 to-indigo-600 p-6">
                    <a class="text-blue-500" href="#" onclick="history.back()">
                        <i class="fa-solid fa-arrow-left mr-2"></i>
                        Go back
                    </a>
                    
                    <div class="flex items-center justify-between">
                        <div class="flex items-center">
                            <i class="fas fa-door-open text-2xl mr-3"></i>
                            <h2 class="text-2xl font-semibold">Room Management</h2>
                        </div>
                        <button type="button" id="addRoomBtn" 
                                class="bg-orange-500 text-white px-6 py-3 rounded-lg font-medium transition-all duration-300 flex items-center gap-2 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5">
                            <i class="fas fa-plus"></i>
                            Add New Room
                        </button>
                    </div>
                </div>

                <div class="p-8">
                    <!-- Homestay Selection (if needed) -->
                    <div class="bg-gradient-to-r from-green-50 to-emerald-50 rounded-xl p-6 border border-green-100 mb-8">
                        <h3 class="text-lg font-semibold text-gray-800 mb-4 flex items-center">
                            <i class="fas fa-home text-green-500 mr-2"></i>
                            Select Homestay
                        </h3>
                        <div class="relative">
                            <select name="homestayId" id="homestayId" ${not empty hid ? 'disabled' : ''}
                                    class="w-full px-4 py-4 bg-white border-2 border-gray-200 rounded-lg focus:outline-none focus:ring-4 focus:ring-green-100 focus:border-green-500 transition-all duration-300 appearance-none">
                                    <option value="">Select Homestay</option>
                                <c:forEach items="${houses}" var="h">
                                    <option value="${h.id}" ${not empty hid and h.id == hid ? 'selected' : ''}>${h.name}</option>
                                </c:forEach>
                            </select>
                            <c:if test="${not empty hid}">
                                <input type="hidden" name="hid" value="${not empty hid ? hid : 'none'}" />
                            </c:if>
                        </div>
                    </div>

                    <!-- Room Container -->
                    <div id="roomsContainer" class="space-y-6">
                        <!-- Initial message when no rooms -->
                        <div id="noRoomsMessage" class="text-center py-12 bg-gray-50 rounded-xl border-2 border-dashed border-gray-300">
                            <i class="fas fa-bed text-4xl text-gray-400 mb-4"></i>
                            <h3 class="text-xl font-medium text-gray-600 mb-2">No Rooms Added Yet</h3>
                            <p class="text-gray-500">Click "Add New Room" to start creating rooms</p>
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <div class="text-center pt-8 border-t border-gray-200 mt-8">
                        <button id="submitRoomsBtn" type="button" 
                                class="bg-orange-500 text-white px-12 py-4 rounded-xl font-semibold text-lg transition-all duration-300 flex items-center gap-3 mx-auto shadow-lg hover:shadow-xl transform hover:-translate-y-1 disabled:opacity-50 disabled:cursor-not-allowed">
                            <i class="fas fa-save"></i>
                            Create All Rooms
                            <i class="fas fa-arrow-right"></i>
                        </button>
                        <p class="text-sm text-gray-500 mt-3">Ready to add these rooms to your homestay?</p>
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

                $('#addRoomBtn').click(function () {
                    addNewRoom();
                });

                function addNewRoom() {
                    
                    if(roomCounter > 2){
                        showToast('Maximum room add is 3!', 'error');
                        return;
                    }
                    
                    roomCounter++;
                    $('#noRoomsMessage').hide();
                    
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
                        <div class="room-item bg-gradient-to-r from-orange-50 to-amber-50 rounded-xl p-6 border border-orange-200 shadow-lg" data-room="` + roomCounter + `">
                            <div class="flex justify-between items-center mb-6">
                                <h4 class="text-xl font-semibold text-gray-800 flex items-center">
                                    <i class="fas fa-bed text-orange-500 mr-2"></i>
                                    Room ` + roomCounter + ` (Just count for this page)
                                </h4>
                                <button type="button" class="remove-room-btn bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-lg text-sm font-medium transition-all duration-200 flex items-center gap-2">
                                    <i class="fas fa-trash"></i> Remove Room
                                </button>
                            </div>
                            
                            <!-- Room Basic Info -->
                            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Room Type *</label>
                                    <select name="rooms[` + roomCounter + `][type]" class="w-full px-3 py-3 bg-white border-2 border-gray-200 rounded-lg focus:outline-none focus:ring-4 focus:ring-orange-100 focus:border-orange-500 transition-all duration-300" required>
                                        ` + roomTypeOptions + `
                                    </select>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Room Status *</label>
                                    <select name="rooms[` + roomCounter + `][status]" class="w-full px-3 py-3 bg-white border-2 border-gray-200 rounded-lg focus:outline-none focus:ring-4 focus:ring-orange-100 focus:border-orange-500 transition-all duration-300" required>
                                        ` + roomStatusOptions + `
                                    </select>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Price Per Night (VND) *</label>
                                    <div class="relative">
                                        <input name="rooms[` + roomCounter + `][price]" type="number" min="0" required
                                            class="w-full px-4 py-3 bg-white border-2 border-gray-200 rounded-lg focus:outline-none focus:ring-4 focus:ring-orange-100 focus:border-orange-500 transition-all duration-300"
                                            placeholder="Enter price..." />
                                        <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                            <i class="fas fa-dong-sign text-gray-400"></i>
                                        </div>
                                    </div>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Max Guests *</label>
                                    <input name="rooms[` + roomCounter + `][maxGuests]" type="number" min="1" max="10" required
                                        class="w-full px-4 py-3 bg-white border-2 border-gray-200 rounded-lg focus:outline-none focus:ring-4 focus:ring-orange-100 focus:border-orange-500 transition-all duration-300"
                                        placeholder="Max guests..." />
                                </div>
                            </div>

                            <!-- Room Details -->
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Room Name *</label>
                                    <input name="rooms[` + roomCounter + `][name]" type="text" required maxlength="40"
                                        class="w-full px-4 py-3 bg-white border-2 border-gray-200 rounded-lg focus:outline-none focus:ring-4 focus:ring-orange-100 focus:border-orange-500 transition-all duration-300"
                                        placeholder="Enter room name..." />
                                    <p class="text-xs text-gray-500 mt-1">Maximum 40 characters</p>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Room Position *</label>
                                    <input name="rooms[` + roomCounter + `][position]" type="text" required maxlength="20"
                                        class="w-full px-4 py-3 bg-white border-2 border-gray-200 rounded-lg focus:outline-none focus:ring-4 focus:ring-orange-100 focus:border-orange-500 transition-all duration-300"
                                        placeholder="e.g., 2nd floor, left wing..." />
                                    <p class="text-xs text-gray-500 mt-1">Maximum 20 characters</p>
                                </div>
                            </div>

                            <!-- Room Description -->
                            <div class="mb-6">
                                <label class="block text-sm font-medium text-gray-700 mb-2">Room Description</label>
                                <textarea name="rooms[` + roomCounter + `][description]" rows="4" maxlength="100"
                                    class="w-full px-4 py-3 bg-white border-2 border-gray-200 rounded-lg focus:outline-none focus:ring-4 focus:ring-orange-100 focus:border-orange-500 transition-all duration-300 resize-none"
                                    placeholder="Describe this room (amenities, features, etc.)..."></textarea>
                                <p class="text-xs text-gray-500 mt-1">Maximum 100 characters</p>
                            </div>

                            <!-- Room Images -->
                            <div class="mb-4">
                                <label class="block text-sm font-medium text-gray-700 mb-3">Room Images *</label>
                                <div class="relative">
                                    <input type="file" name="rooms[` + roomCounter + `][images]" multiple accept="image/*" class="hidden" id="roomImageInput` + roomCounter + `">
                                    <div class="room-upload-box w-full h-32 border-3 border-dashed border-orange-300 rounded-xl flex items-center justify-center cursor-pointer hover:border-orange-400 hover:bg-orange-100 transition-all duration-300 group" data-room="` + roomCounter + `">
                                        <div class="text-center">
                                            <div class="w-12 h-12 mx-auto mb-3 bg-orange-100 rounded-full flex items-center justify-center group-hover:bg-orange-200 transition-colors">
                                                <i class="fas fa-camera text-xl text-orange-500"></i>
                                            </div>
                                            <p class="text-sm font-medium text-gray-700">Click to upload room images</p>
                                            <p class="text-xs text-gray-500 mt-1">Support: JPG, PNG, WEBP (Max 10MB each)</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="room-image-preview grid grid-cols-2 md:grid-cols-4 gap-3 mt-4" data-room="` + roomCounter + `"></div>
                            </div>
                        </div>
                    `;
    
                    $('#roomsContainer').append(roomHtml);
                }

                // Remove room functionality
                $(document).on('click', '.remove-room-btn', function () {
                    $(this).closest('.room-item').remove();
                    if ($('.room-item').length === 0) {
                        $('#noRoomsMessage').show();
                    }
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
                        input.value = '';
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
                                        `<div class="relative group">
                                        <img src="` + e.target.result + `" class="w-full h-24 object-cover rounded-lg border-2 border-gray-200 group-hover:border-orange-300 transition-colors">
                                        <button type="button" class="absolute -top-2 -right-2 bg-red-500 text-white rounded-full w-6 h-6 flex items-center justify-center text-xs hover:bg-red-600 transition-colors" onclick="$(this).parent().remove()">
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
                $('#submitRoomsBtn').on('click', function () {
                    const homestayId = $('#homestayId').val();
                    const rooms = $('.room-item');

                    // Validate homestay selection
                    if (!homestayId) {
                        showToast('Please select a homestay!', 'error');
                        return;
                    }

                    // Validate rooms
                    if (rooms.length === 0) {
                        showToast('Please add at least one room!', 'error');
                        return;
                    }

                    let roomValid = true;
                    let formData = new FormData();

                    formData.append('homestayId', homestayId);

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
                        if (!roomType || !roomStatus || !roomPrice || !maxGuests || roomPrice <= 0 || maxGuests <= 0 || !roomName || !roomPosition) {
                            showToast(`Please fill in all required information for Room ` + roomNumber + `!`, 'error');
                            roomValid = false;
                            return false;
                        }

                        if (roomName.length > 40) {
                            showToast(`Room name for Room ` + roomNumber + ` exceeds 40 characters!`, 'error');
                            roomValid = false;
                            return false;
                        }

                        if (roomDescription.length > 100) {
                            showToast(`Room description for Room ` + roomNumber + ` exceeds 100 characters!`, 'error');
                            roomValid = false;
                            return false;
                        }

                        if (roomPosition.length > 20) {
                            showToast(`Room position for Room ` + roomNumber + ` exceeds 20 characters!`, 'error');
                            roomValid = false;
                            return false;
                        }

                        // Validate room images
                        if (!roomImages || roomImages.length === 0) {
                            showToast(`Please upload at least one image for Room ` + roomNumber + `!`, 'error');
                            roomValid = false;
                            return false;
                        }

                        // Add room data to formData
                        formData.append(`rooms[` + index + `][roomNumber]`, roomNumber);
                        formData.append(`rooms[` + index + `][type]`, roomType);
                        formData.append(`rooms[` + index + `][status]`, roomStatus);
                        formData.append(`rooms[` + index + `][price]`, roomPrice);
                        formData.append(`rooms[` + index + `][maxGuests]`, maxGuests);
                        formData.append(`rooms[` + index + `][name]`, roomName);
                        formData.append(`rooms[` + index + `][position]`, roomPosition);
                        formData.append(`rooms[` + index + `][description]`, roomDescription || '');

                        // Add room images
                        for (let i = 0; i < roomImages.length; i++) {
                            formData.append(`rooms[` + index + `][images]`, roomImages[i]);
                        }
                    });

                    if (!roomValid) {
                        return;
                    }

                    // Add total room count
                    formData.append('totalRooms', rooms.length);

                    // Show loading and submit
                    Swal.fire({
                        title: 'Creating Rooms...',
                        text: 'Please wait while we create your rooms.',
                        allowOutsideClick: false,
                        didOpen: () => {
                            Swal.showLoading();
                        }
                    });

                    // Debug: Log form data
                    for (let [key, value] of formData.entries()) {
                        console.log(key + ": " + value);
                    }

                    $.ajax({
                        processData: false,
                        contentType: false,
                        url: '${pageContext.request.contextPath}/room/add',
                        type: 'POST',
                        data: formData,
                        success: function (response) {
                            Swal.close();
                            if (response.ok) {
                                showToast(response.message, 'success');
                                // Reset form or redirect
                                setTimeout(() => {
                                    window.location.href = '${pageContext.request.contextPath}/owner-house/detail?hid=' + homestayId;
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

                // Add initial room on page load
                addNewRoom();
            });
        </script>
    </body>
</html>