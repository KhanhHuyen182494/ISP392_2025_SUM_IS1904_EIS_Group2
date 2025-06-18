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

        <div class="max-w-7xl mx-auto px-4 py-8">
            <div class="bg-white rounded-lg shadow-lg p-8">
                <h1 class="text-2xl font-bold text-gray-800 mb-6">New Post</h1>

                <form id="postForm" action="${pageContext.request.contextPath}/createpost" method="POST" enctype="multipart/form-data">
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
                                <!--                                <div>
                                                                    <p class="text-gray-600 text-sm">${sessionScope.user.role.name}</p>
                                                                </div>-->
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
                                            <c:if test="${pt.id != 3 and pt.id != 2}">
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

                        <div class="border-2 border-gray-200 rounded-lg p-4" id="roomSection" style="display: none;">
                            <label class="block text-sm font-medium text-gray-700 mb-2">Room</label>
                            <select name="room" id="roomSelect" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">

                            </select>
                        </div>
                    </div>

                    <!-- Content Section -->
                    <div class="border-2 border-gray-200 rounded-lg p-6 mb-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Post Content</label>
                            <textarea name="content" required rows="8" 
                                      class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                                      placeholder="Write your post content here..."></textarea>
                        </div>
                    </div>

                    <!-- Image Section -->
                    <div class="border-2 border-gray-200 rounded-lg p-6 mb-4">
                        <p class="text-sm text-gray-600 mb-4">If choosing homestay advertised, this will auto fetch. If normal, user can attach image.</p>

                        <div class="mb-4">
                            <label class="block text-sm font-medium text-gray-700 mb-2">Upload Images</label>
                            <div class="relative">
                                <input type="file" name="images" id="imageInput" multiple accept="image/*" class="hidden">
                                <div id="uploadBox" class="w-full h-32 border-2 border-dashed border-gray-300 rounded-lg flex items-center justify-center cursor-pointer hover:border-blue-400 hover:bg-blue-50 transition-all duration-200">
                                    <div class="text-center">
                                        <i class="fas fa-plus text-3xl text-gray-400 mb-2"></i>
                                        <p class="text-sm text-gray-500">Click to upload images</p>
                                        <p class="text-xs text-gray-400 mt-1">You can select multiple images</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="imagePreview" class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
                            <!-- Image previews will appear here -->
                        </div>
                    </div>

                    <!-- Post Button -->
                    <div class="flex justify-end">
                        <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white px-8 py-3 rounded-lg font-medium transition-colors flex items-center gap-2">
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
                let selectedTags = [];

                // Handle post type change
                $('#type').change(function () {
                    const selectedType = $(this).val();

                    if (selectedType === '1') {
                        $('#homestaySection').show();

                        // Call AJAX to fetch homestays
                        $.ajax({
                            url: '${pageContext.request.contextPath}/homestay/get', // Replace with your actual endpoint
                            type: 'GET',
                            dataType: 'json',
                            beforeSend: function () {
                                // Show loading indicator
                                $('#homestaySelect').html('<option value="">Loading...</option>');
                                $('#roomSection').hide();
                                $('#roomSelect').html('<option value="">Select a room</option>');
                            },
                            success: function (response) {
                                let homestayOptions = '<option value="">Select a homestay</option>';

                                if (response.homestays && response.homestays.length > 0) {
                                    response.homestays.forEach(function (homestay) {
                                        let houseType = homestay.isWholeHouse ? 'Whole House' : 'Rooms';
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

                        // Reset selects
                        $('#homestaySelect').html('<option value="">Select a homestay</option>');
                        $('#roomSelect').html('<option value="">Select a room</option>');
                    }
                });

                // Handle homestay selection change
                $(document).on('change', '#homestaySelect', function () {
                    const selectedHomestay = $(this).val();
                    const isWholeHouse = $(this).find('option:selected').data('whole-house');

                    if (selectedHomestay) {
                        if (isWholeHouse == true) {
                            // whole house - hide room section
                            $('#roomSection').hide();
                            $('#roomSelect').html('<option value="">Select a room</option>');
                        } else if (isWholeHouse == false) {
                            // Not Whole house - show room section and fetch rooms
                            $('#roomSection').show();

                            // Call AJAX to fetch rooms for selected homestay
                            $.ajax({
                                url: `${pageContext.request.contextPath}/homestay/rooms`,
                                type: 'GET',
                                dataType: 'json',
                                beforeSend: function () {
                                    $('#roomSelect').html('<option value="">Loading rooms...</option>');
                                },
                                success: function (response) {
                                    let roomOptions = '<option value="">Leave room blank to post about homestay</option>';

                                    if (response.data && response.data.length > 0) {
                                        response.data.forEach(function (room) {
                                            roomOptions += `<option value="${room.id}">${room.name} - ${room.type}</option>`;
                                        });
                                    } else {
                                        roomOptions = '<option value="">No rooms available</option>';
                                    }

                                    $('#roomSelect').html(roomOptions);
                                },
                                error: function (xhr, status, error) {
                                    console.error('Error fetching rooms:', error);
                                    $('#roomSelect').html('<option value="">Error loading rooms</option>');
                                }
                            });
                        }
                    } else {
                        // No homestay selected - hide room section
                        $('#roomSection').hide();
                        $('#roomSelect').html('<option value="">Select a room</option>');
                    }
                });

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

                // Handle form submission
                $('#postForm').submit(function (e) {
                    e.preventDefault();

                    Swal.fire({
                        title: 'Creating Post...',
                        text: 'Please wait while we create your post.',
                        allowOutsideClick: false,
                        didOpen: () => {
                            Swal.showLoading();
                        }
                    });

                    // Here you would normally submit the form via AJAX or allow normal form submission
                    // For demo purposes, we'll show a success message after 2 seconds
                    setTimeout(() => {
                        Swal.fire({
                            icon: 'success',
                            title: 'Post Created!',
                            text: 'Your post has been created successfully.',
                            confirmButtonColor: '#3b82f6'
                        }).then(() => {
                            // Redirect to feeds or reload page
                            window.location.href = '${pageContext.request.contextPath}/feeds';
                        });
                    }, 2000);
                });
            });
        </script>
    </body>
</html>