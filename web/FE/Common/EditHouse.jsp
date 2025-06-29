<%-- 
    Document   : EditHomestay
    Created on : Jun 28, 2025, 8:19:35 AM
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
        <title>Edit Homestay</title>

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
        <style>
            .carousel-container {
                position: relative;
                overflow: hidden;
                border-radius: 1rem;
                width: 100%;
            }

            .carousel-track {
                display: flex;
                transition: transform 0.5s ease-in-out;
                width: 100%;
            }

            .carousel-slide {
                min-width: 100%;
                width: 100%;
                height: 300px;
                flex-shrink: 0;
            }

            .small-carousel .carousel-slide {
                height: 200px;
            }

            .carousel-slide img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
            }

            .carousel-nav {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                background: rgba(0, 0, 0, 0.5);
                color: white;
                border: none;
                padding: 10px 15px;
                cursor: pointer;
                border-radius: 50%;
                transition: background 0.3s;
                z-index: 10;
            }

            .carousel-nav:hover {
                background: rgba(0, 0, 0, 0.7);
            }

            .carousel-prev {
                left: 10px;
            }

            .carousel-next {
                right: 10px;
            }

            .carousel-dots {
                display: flex;
                justify-content: center;
                gap: 8px;
                margin-top: 15px;
            }

            .carousel-dot {
                width: 12px;
                height: 12px;
                border-radius: 50%;
                background: rgba(0, 0, 0, 0.3);
                cursor: pointer;
                transition: background 0.3s;
            }

            .carousel-dot.active {
                background: #f97316;
            }

            .room-card {
                border: 1px solid #e5e7eb;
                border-radius: 1rem;
                padding: 1.5rem;
                margin-bottom: 1rem;
                transition: shadow 0.3s;
            }

            .room-card:hover {
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            }

            .status-badge {
                display: inline-flex;
                align-items: center;
                padding: 0.375rem 0.75rem;
                border-radius: 9999px;
                font-size: 0.875rem;
                font-weight: 500;
            }

            .status-available {
                background-color: #dcfce7;
                color: #166534;
            }

            .status-booked {
                background-color: #fef3c7;
                color: #92400e;
            }

            .status-maintenance {
                background-color: #fee2e2;
                color: #991b1b;
            }

            .form-input {
                width: 100%;
                padding: 0.75rem 1rem;
                border: 2px solid #e5e7eb;
                border-radius: 0.5rem;
                font-size: 1rem;
                transition: all 0.3s;
                background-color: #ffffff;
            }

            .form-input:focus {
                outline: none;
                border-color: #3b82f6;
                box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
            }

            .form-textarea {
                min-height: 100px;
                resize: vertical;
            }

            .form-select {
                appearance: none;
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
                background-position: right 0.5rem center;
                background-repeat: no-repeat;
                background-size: 1.5em 1.5em;
                padding-right: 2.5rem;
            }

            .image-upload-area {
                border: 2px dashed #d1d5db;
                border-radius: 0.5rem;
                padding: 2rem;
                text-align: center;
                transition: all 0.3s;
                cursor: pointer;
            }

            .image-upload-area:hover {
                border-color: #3b82f6;
                background-color: #f8fafc;
            }

            .image-upload-area.dragover {
                border-color: #3b82f6;
                background-color: #eff6ff;
            }

            .image-preview {
                position: relative;
                display: inline-block;
                margin: 0.5rem;
            }

            .image-preview img {
                width: 100px;
                height: 100px;
                object-fit: cover;
                border-radius: 0.5rem;
                border: 2px solid #e5e7eb;
            }

            .image-preview .remove-btn {
                position: absolute;
                top: -8px;
                right: -8px;
                background-color: #ef4444;
                color: white;
                border: none;
                border-radius: 50%;
                width: 24px;
                height: 24px;
                font-size: 12px;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
            }
        </style>
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
                <h1 class="text-3xl font-bold mb-2">
                    <i class="fas fa-edit text-2xl mr-3"></i>
                    Edit Homestay
                </h1>
            </div>

            <!-- Main Form -->
            <form id="editHomestay" action="${pageContext.request.contextPath}/owner-house/edit" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="homestayId" value="${h.id}" />

                <div class="main space-y-5">
                    <!--Homestay section-->
                    <div class="bg-white backdrop-blur-sm rounded-2xl shadow-xl border border-white overflow-hidden p-6">
                        <a class="text-blue-500" href="#" onclick="history.back()">
                            <i class="fa-solid fa-arrow-left mr-2"></i>
                            Go back
                        </a>
                        <div class="flex items-center justify-between mb-6 mt-3">
                            <label class="block text-xl font-semibold text-gray-700 flex items-center">
                                <i class="fas fa-tag text-blue-500 mr-2"></i>
                                Edit Homestay Information
                            </label>
                            <div class="flex gap-3">
                                <button type="button" onclick="history.back()" 
                                        class="bg-gray-500 hover:bg-gray-600 text-white px-4 py-2 rounded-lg font-medium transition-all duration-300 flex items-center gap-2 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5">
                                    <i class="fas fa-times"></i>
                                    Cancel
                                </button>
                                <button type="button" onclick="handleSave()"
                                        class="bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-lg font-medium transition-all duration-300 flex items-center gap-2 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5">
                                    <i class="fas fa-save"></i>
                                    Save Changes
                                </button>
                            </div>
                        </div>

                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                            <!-- Information Section -->
                            <div class="space-y-6">
                                <!-- Name -->
                                <div>
                                    <label for="nameHomestay" class="block text-lg font-semibold text-gray-700 mb-2">
                                        <i class="fas fa-home mr-2 text-blue-500"></i>
                                        Homestay Name *
                                    </label>
                                    <input id="nameHomestay" name="name" type="text" value="${h.name}" 
                                           class="form-input" required placeholder="Enter homestay name" />
                                </div>

                                <!-- Description -->
                                <div>
                                    <label for="description" class="block text-lg font-semibold text-gray-700 mb-2">
                                        <i class="fas fa-align-left mr-2 text-blue-500"></i>
                                        Description *
                                    </label>
                                    <textarea id="description" name="description" 
                                              class="form-input form-textarea" required 
                                              placeholder="Describe your homestay...">${h.description}</textarea>
                                </div>

                                <!-- Type -->
                                <div>
                                    <label for="homestayType" class="block text-lg font-semibold text-gray-700 mb-2">
                                        <i class="fas fa-building mr-2 text-blue-500"></i>
                                        Homestay Type
                                    </label>
                                    <select id="homestayType" name="isWholeHouse" class="form-input form-select bg-gray-200" disabled="">
                                        <option value="true" ${h.is_whole_house ? 'selected' : ''}>Whole House</option>
                                        <option value="false" ${!h.is_whole_house ? 'selected' : ''}>Rooms</option>
                                    </select>
                                </div>

                                <!-- Price (for whole house only) -->
                                <div id="priceSection" style="display: ${h.is_whole_house ? 'block' : 'none'}">
                                    <label for="price" class="block text-lg font-semibold text-gray-700 mb-2">
                                        <i class="fas fa-money-bill-wave mr-2 text-green-500"></i>
                                        Price per Night (VND) *
                                    </label>
                                    <input id="price" name="pricePerNight" type="number" value="${h.price_per_night}" 
                                           class="form-input" min="0" step="1000" 
                                           placeholder="Enter price per night" />
                                </div>

                                <!-- Status -->
                                <div>
                                    <label for="status" class="block text-lg font-semibold text-gray-700 mb-2">
                                        <i class="fas fa-info-circle mr-2 text-blue-500"></i>
                                        Status *
                                    </label>
                                    <select id="status" name="status" class="form-input form-select" required>
                                        <c:forEach items="${statuses}" var="s">
                                            <option value="${s.id}" ${h.status.name == s.name ? 'selected' : ''}>${s.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Address Section -->
                                <div class="space-y-4 border-t pt-4">
                                    <h3 class="text-lg font-semibold text-gray-700">
                                        <i class="fas fa-map-marker-alt mr-2 text-red-500"></i>
                                        Address Information
                                    </h3>

                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                        <div>
                                            <label for="country" class="block text-sm font-medium text-gray-700 mb-1">Country *</label>
                                            <input id="country" name="country" type="text" value="${h.address.country}" 
                                                   class="form-input" required placeholder="Country" readonly />
                                        </div>
                                        <div>
                                            <label for="tinh" class="block text-sm font-medium text-gray-700 mb-1">Province *</label>
                                            <select id="tinh" name="province" class="form-input form-select" required>
                                                <option value="">Select Province</option>
                                            </select>
                                        </div>
                                        <div>
                                            <label for="quan" class="block text-sm font-medium text-gray-700 mb-1">District *</label>
                                            <select id="quan" name="district" class="form-input form-select" required>
                                                <option value="">Select District</option>
                                            </select>
                                        </div>
                                        <div>
                                            <label for="phuong" class="block text-sm font-medium text-gray-700 mb-1">Ward *</label>
                                            <select id="phuong" name="ward" class="form-input form-select" required>
                                                <option value="">Select Ward</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div>
                                        <label for="detail" class="block text-sm font-medium text-gray-700 mb-1">Detailed Address *</label>
                                        <input id="detail" name="addressDetail" type="text" value="${h.address.detail}" 
                                               class="form-input" required placeholder="House number, street name..." />
                                    </div>
                                </div>
                            </div>

                            <!-- Image Section -->
                            <div class="space-y-6">
                                <!-- Current Images -->
                                <div>
                                    <label class="block text-lg font-semibold text-gray-700 mb-4">
                                        <i class="fas fa-images mr-2 text-purple-500"></i>
                                        Current Images
                                    </label>

                                    <div class="carousel-container mb-6" id="homestayCarousel">
                                        <div class="carousel-track" id="homestayTrack">
                                            <c:forEach var="image" items="${h.medias}" varStatus="status">
                                                <div class="carousel-slide">
                                                    <img src="${pageContext.request.contextPath}/Asset/Common/House/${image.path}" 
                                                         alt="${h.name}" 
                                                         class="w-full h-full object-cover">
                                                </div>
                                            </c:forEach>
                                            <c:if test="${empty h.medias}">
                                                <div class="carousel-slide">
                                                    <img src="${pageContext.request.contextPath}/Asset/Common/House/no-image.webp" 
                                                         alt="No image available" 
                                                         class="w-full h-full object-cover">
                                                </div>
                                            </c:if>
                                        </div>

                                        <c:if test="${fn:length(h.medias) > 1}">
                                            <button type="button" class="carousel-nav carousel-prev" onclick="prevSlide('homestay')">
                                                <i class="fas fa-chevron-left"></i>
                                            </button>
                                            <button type="button" class="carousel-nav carousel-next" onclick="nextSlide('homestay')">
                                                <i class="fas fa-chevron-right"></i>
                                            </button>

                                            <div class="carousel-dots">
                                                <c:forEach var="image" items="${h.medias}" varStatus="status">
                                                    <div class="carousel-dot ${status.index == 0 ? 'active' : ''}" 
                                                         onclick="goToSlide('homestay', ${status.index})"></div>
                                                </c:forEach>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>

                                <!-- Upload New Images -->
                                <div>
                                    <label class="block text-lg font-semibold text-gray-700 mb-4">
                                        <i class="fas fa-upload mr-2 text-green-500"></i>
                                        Upload New Images
                                    </label>

                                    <div class="image-upload-area" id="imageUploadArea" onclick="document.getElementById('imageInput').click()">
                                        <input type="file" id="imageInput" name="images" multiple accept="image/*" 
                                               style="display: none;" onchange="handleImageUpload(event)" />
                                        <div class="text-center">
                                            <i class="fas fa-cloud-upload-alt text-4xl text-gray-400 mb-2"></i>
                                            <p class="text-gray-600 mb-2">Click to upload or drag and drop images</p>
                                            <p class="text-sm text-gray-500">PNG, JPG, JPEG up to 10MB each</p>
                                        </div>
                                    </div>

                                    <div id="imagePreview" class="mt-4"></div>
                                </div>

                                <!-- Remove Current Images -->
                                <c:if test="${not empty h.medias}">
                                    <div>
                                        <label class="block text-lg font-semibold text-gray-700 mb-4">
                                            <i class="fas fa-trash-alt mr-2 text-red-500"></i>
                                            Remove Current Images
                                        </label>
                                        <div class="grid grid-cols-3 gap-3">
                                            <c:forEach var="image" items="${h.medias}" varStatus="status">
                                                <div class="relative">
                                                    <img src="${pageContext.request.contextPath}/Asset/Common/House/${image.path}" 
                                                         alt="Current image" 
                                                         class="w-full h-20 object-cover rounded border">
                                                    <label class="absolute top-1 right-1 bg-red-500 text-white rounded-full w-6 h-6 flex items-center justify-center text-xs cursor-pointer">
                                                        <input type="checkbox" name="removeImages" value="${image.id}" class="hidden" />
                                                        <i class="fas fa-times"></i>
                                                    </label>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
                                                   // Vietnamese Address API Integration
                                                   $(document).ready(function () {

                                                       // Store current address values
                                                       const currentProvince = '${h.address.province}';
                                                       const currentDistrict = '${h.address.district}';
                                                       const currentWard = '${h.address.ward}';

                                                       // Load provinces
                                                       $.getJSON('https://esgoo.net/api-tinhthanh/1/0.htm', function (data_tinh) {
                                                           if (data_tinh.error == 0) {
                                                               $.each(data_tinh.data, function (key_tinh, val_tinh) {
                                                                   const isSelected = val_tinh.full_name === currentProvince ? 'selected' : '';
                                                                   $("#tinh").append('<option value="' + val_tinh.full_name + '" data-id="' + val_tinh.id + '" ' + isSelected + '>' + val_tinh.full_name + '</option>');
                                                               });

                                                               // If there's a current province, load its districts
                                                               if (currentProvince) {
                                                                   const selectedOption = $("#tinh").find(':selected');
                                                                   if (selectedOption.length) {
                                                                       loadDistricts(selectedOption.data('id'), currentDistrict, currentWard);
                                                                   }
                                                               }
                                                           }
                                                       });

                                                       // Province change handler
                                                       $("#tinh").change(function () {
                                                           const tentinh = $(this).val();
                                                           const idtinh = $(this).find(':selected').data('id');

                                                           if (idtinh) {
                                                               loadDistricts(idtinh);
                                                           } else {
                                                               $("#quan").html('<option value="">Select District</option>');
                                                               $("#phuong").html('<option value="">Select Ward</option>');
                                                           }
                                                       });

                                                       // Function to load districts
                                                       function loadDistricts(provinceId, selectedDistrict = '', selectedWard = '') {
                                                           $.getJSON('https://esgoo.net/api-tinhthanh/2/' + provinceId + '.htm', function (data_quan) {
                                                               if (data_quan.error == 0) {
                                                                   $("#quan").html('<option value="">Select District</option>');
                                                                   $("#phuong").html('<option value="">Select Ward</option>');

                                                                   $.each(data_quan.data, function (key_quan, val_quan) {
                                                                       const isSelected = val_quan.full_name === selectedDistrict ? 'selected' : '';
                                                                       $("#quan").append('<option value="' + val_quan.full_name + '" data-id="' + val_quan.id + '" ' + isSelected + '>' + val_quan.full_name + '</option>');
                                                                   });

                                                                   // If there's a selected district, load its wards
                                                                   if (selectedDistrict) {
                                                                       const selectedOption = $("#quan").find(':selected');
                                                                       if (selectedOption.length) {
                                                                           loadWards(selectedOption.data('id'), selectedWard);
                                                                       }
                                                                   }

                                                                   // District change handler
                                                                   $("#quan").off('change').on('change', function () {
                                                                       const tenquan = $(this).val();
                                                                       const idquan = $(this).find(':selected').data('id');

                                                                       if (idquan) {
                                                                           loadWards(idquan);
                                                                       } else {
                                                                           $("#phuong").html('<option value="">Select Ward</option>');
                                                                       }
                                                                   });
                                                               }
                                                           });
                                                       }

                                                       // Function to load wards
                                                       function loadWards(districtId, selectedWard = '') {
                                                           $.getJSON('https://esgoo.net/api-tinhthanh/3/' + districtId + '.htm', function (data_phuong) {
                                                               if (data_phuong.error == 0) {
                                                                   $("#phuong").html('<option value="">Select Ward</option>');

                                                                   $.each(data_phuong.data, function (key_phuong, val_phuong) {
                                                                       const isSelected = val_phuong.full_name === selectedWard ? 'selected' : '';
                                                                       $("#phuong").append('<option value="' + val_phuong.full_name + '" data-id="' + val_phuong.id + '" ' + isSelected + '>' + val_phuong.full_name + '</option>');
                                                                   });
                                                               }
                                                           });
                                                       }
                                                   });

                                                   let selectedFiles = [];

                                                   function handleImageUpload(event) {
                                                       const files = Array.from(event.target.files);
                                                       selectedFiles = selectedFiles.concat(files);
                                                       updateImagePreview();
                                                   }

                                                   function updateImagePreview() {
                                                       const preview = document.getElementById('imagePreview');
                                                       preview.innerHTML = '';

                                                       selectedFiles.forEach((file, index) => {
                                                           const reader = new FileReader();
                                                           reader.onload = function (e) {
                                                               const imageDiv = document.createElement('div');
                                                               imageDiv.className = 'image-preview';
                                                               imageDiv.innerHTML = `
                                                                    <img src="` + e.target.result + `" alt="Preview">
                                                                    <button type="button" class="remove-btn" onclick="removePreview(` + index + `)">
                                                                        <i class="fas fa-times"></i>
                                                                    </button>
                                                                `;
                                                               preview.appendChild(imageDiv);
                                                           };
                                                           reader.readAsDataURL(file);
                                                       });

                                                       // Update the file input
                                                       updateFileInput();
                                                   }

                                                   function removePreview(index) {
                                                       selectedFiles.splice(index, 1);
                                                       updateImagePreview();
                                                   }

                                                   function updateFileInput() {
                                                       const dt = new DataTransfer();
                                                       selectedFiles.forEach(file => dt.items.add(file));
                                                       document.getElementById('imageInput').files = dt.files;
                                                   }

                                                   // Drag and drop functionality
                                                   const uploadArea = document.getElementById('imageUploadArea');

                                                   uploadArea.addEventListener('dragover', function (e) {
                                                       e.preventDefault();
                                                       this.classList.add('dragover');
                                                   });

                                                   uploadArea.addEventListener('dragleave', function (e) {
                                                       e.preventDefault();
                                                       this.classList.remove('dragover');
                                                   });

                                                   uploadArea.addEventListener('drop', function (e) {
                                                       e.preventDefault();
                                                       this.classList.remove('dragover');

                                                       const files = e.dataTransfer.files;
                                                       document.getElementById('imageInput').files = files;
                                                       handleImageUpload({target: {files: files}});
                                                   });

                                                   // Carousel functionality
                                                   let currentSlide = 0;
                                                   let totalSlides = ${fn:length(h.medias)};

                                                   function updateCarousel() {
                                                       const track = document.getElementById('homestayTrack');
                                                       const dots = document.querySelectorAll('.carousel-dot');

                                                       if (track) {
                                                           track.style.transform = `translateX(-` + currentSlide * 100 + `%)`;
                                                       }

                                                       dots.forEach((dot, index) => {
                                                           dot.classList.toggle('active', index === currentSlide);
                                                       });
                                                   }

                                                   function nextSlide(carousel) {
                                                       if (currentSlide < totalSlides - 1) {
                                                           currentSlide++;
                                                       } else {
                                                           currentSlide = 0;
                                                       }
                                                       updateCarousel();
                                                   }

                                                   function prevSlide(carousel) {
                                                       if (currentSlide > 0) {
                                                           currentSlide--;
                                                       } else {
                                                           currentSlide = totalSlides - 1;
                                                       }
                                                       updateCarousel();
                                                   }

                                                   function goToSlide(carousel, slideIndex) {
                                                       currentSlide = slideIndex;
                                                       updateCarousel();
                                                   }

                                                   // Toast notification
                                                   function showToast(message, type = 'success') {
                                                       const backgroundColor = {
                                                           'success': '#10b981',
                                                           'error': '#ef4444',
                                                           'warning': '#f59e0b',
                                                           'info': '#3b82f6'
                                                       };

                                                       Toastify({
                                                           text: message,
                                                           duration: 3000,
                                                           gravity: "top",
                                                           position: "right",
                                                           backgroundColor: backgroundColor[type] || backgroundColor.success,
                                                           stopOnFocus: true,
                                                           close: true
                                                       }).showToast();
                                                   }

                                                   // Checkbox functionality for image removal
                                                   document.querySelectorAll('input[name="removeImages"]').forEach(checkbox => {
                                                       checkbox.addEventListener('change', function () {
                                                           const label = this.parentElement;
                                                           if (this.checked) {
                                                               label.classList.add('bg-red-500');
                                                               label.querySelector('i').className = 'fas fa-check text-white';
                                                           } else {
                                                               label.classList.remove('bg-red-500');
                                                               label.querySelector('i').className = 'fas fa-times';
                                                           }
                                                       });
                                                   });

                                                   // Form validation
                                                   document.querySelector('form').addEventListener('submit', function (e) {
                                                       const requiredFields = this.querySelectorAll('[required]');
                                                       let isValid = true;

                                                       requiredFields.forEach(field => {
                                                           if (!field.value.trim()) {
                                                               isValid = false;
                                                               field.classList.add('border-red-500');
                                                               field.focus();
                                                               showToast('Please fill in all required fields', 'error');
                                                           } else {
                                                               field.classList.remove('border-red-500');
                                                           }
                                                       });

                                                       if (!isValid) {
                                                           e.preventDefault();
                                                           return false;
                                                       }

                                                       // Show loading state
                                                       const submitBtn = this.querySelector('button[type="submit"]');
                                                       const originalText = submitBtn.innerHTML;
                                                       submitBtn.disabled = true;
                                                       submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Saving...';

                                                       // Re-enable button after 5 seconds to prevent permanent disable
                                                       setTimeout(() => {
                                                           submitBtn.disabled = false;
                                                           submitBtn.innerHTML = originalText;
                                                       }, 5000);
                                                   });

                                                   // Auto-save draft functionality (optional)
                                                   let autoSaveTimeout;
                                                   const formInputs = document.querySelectorAll('input, textarea, select');

                                                   formInputs.forEach(input => {
                                                       input.addEventListener('input', function () {
                                                           clearTimeout(autoSaveTimeout);
                                                           autoSaveTimeout = setTimeout(() => {
                                                               // Auto-save logic here if needed
                                                               console.log('Auto-saving draft...');
                                                           }, 2000);
                                                       });
                                                   });

                                                   // Confirm before leaving page with unsaved changes
                                                   let formChanged = false;
                                                   formInputs.forEach(input => {
                                                       input.addEventListener('change', function () {
                                                           formChanged = true;
                                                       });
                                                   });

                                                   window.addEventListener('beforeunload', function (e) {
                                                       if (formChanged) {
                                                           e.preventDefault();
                                                           e.returnValue = 'You have unsaved changes. Are you sure you want to leave?';
                                                           return e.returnValue;
                                                       }
                                                   });

                                                   // Remove beforeunload listener when form is submitted
                                                   document.querySelector('form').addEventListener('submit', function () {
                                                       formChanged = false;
                                                   });

                                                   function validateHomestayForm() {
                                                       const name = document.getElementById('nameHomestay').value.trim();
                                                       const description = document.getElementById('description').value.trim();
                                                       const pricePerNight = document.getElementById('price')?.value.trim();
                                                       const province = document.getElementById('tinh').value;
                                                       const district = document.getElementById('quan').value;
                                                       const ward = document.getElementById('phuong').value;
                                                       const detail = document.getElementById('detail').value.trim();
                                                       const imageInput = document.getElementById('imageInput');
                                                       const existingChecked = document.querySelectorAll('input[name="removeImages"]:checked');
                                                       const totalExisting = document.querySelectorAll('input[name="removeImages"]').length;

                                                       // Basic required field check
                                                       if (!name || !description || !province || !district || !ward || !detail) {
                                                           showToast("All required fields must be filled.", "error");
                                                           return false;
                                                       }

                                                       // Length checks
                                                       if (name.length > 40) {
                                                           showToast("Homestay name must be less than 40 characters.", "error");
                                                           return false;
                                                       }

                                                       if (description.length > 100) {
                                                           showToast("Description must be less than 100 characters.", "error");
                                                           return false;
                                                       }

                                                       // Price check (only if whole house)
                                                       const priceSection = document.getElementById('priceSection');
                                                       if (priceSection && priceSection.style.display !== 'none') {
                                                           if (!pricePerNight || isNaN(pricePerNight) || parseInt(pricePerNight) <= 0) {
                                                               showToast("Price per night must be a positive number.", "error");
                                                               return false;
                                                           }
                                                       }

                                                       // Image check: at least one image must remain or be uploaded
                                                       const newImages = imageInput.files.length;
                                                       const remaining = totalExisting - existingChecked.length;

                                                       if (remaining + newImages <= 0) {
                                                           showToast("At least one image must be provided.", "error");
                                                           return false;
                                                       }

                                                       return true;
                                                   }

                                                   function handleSave() {
                                                       const form = document.getElementById('editHomestay');

                                                       if (!validateHomestayForm())
                                                           return;

                                                       const formData = new FormData(form);

                                                       $.ajax({
                                                           url: '${pageContext.request.contextPath}/owner-house/edit',
                                                           type: 'POST',
                                                           data: formData,
                                                           contentType: false,
                                                           processData: false,
                                                           beforeSend: function () {
                                                               Swal.showLoading();
                                                           },
                                                           success: function (response) {
                                                               Swal.close();

                                                               if (response.ok) {
                                                                   showToast(response.message);
                                                               } else {
                                                                   showToast(response.message, 'error');
                                                               }

                                                               setTimeout(function () {
                                                                   location.reload();
                                                               }, 2000);
                                                           },
                                                           error: function (xhr) {
                                                               Swal.close();
                                                               showToast("Failed to update. Please try again.", "error");
                                                               console.error(xhr.responseText);
                                                           }
                                                       });
                                                   }
        </script>
    </body>
</html>