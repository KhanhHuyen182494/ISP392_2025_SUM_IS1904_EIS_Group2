<%-- 
    Document   : PostRequestEdit
    Created on : Jul 17, 2025, 10:06:40 PM
    Author     : Huyen
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
        <title>Edit Post</title>

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
                            },
                            accent: {
                                50: '#f0f9ff',
                                100: '#e0f2fe',
                                500: '#0ea5e9',
                                600: '#0284c7',
                                700: '#0369a1'
                            }
                        }
                    }
                }
            }
        </script>
        <style>
            body {
                background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
                min-height: 100vh;
            }

            .card {
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 16px;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.06);
                border: 1px solid rgba(255, 255, 255, 0.2);
                transition: all 0.3s ease;
            }

            .card:hover {
                transform: translateY(-2px);
                box-shadow: 0 12px 40px rgba(0, 0, 0, 0.1);
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-label {
                display: block;
                font-size: 0.875rem;
                font-weight: 600;
                color: #374151;
                margin-bottom: 0.5rem;
                text-transform: uppercase;
                letter-spacing: 0.05em;
            }

            .form-input {
                width: 100%;
                padding: 0.875rem 1rem;
                border: 1px solid #e5e7eb;
                border-radius: 8px;
                font-size: 0.875rem;
                transition: all 0.2s ease;
                background: white;
                color: #374151;
            }

            .form-input:focus {
                outline: none;
                border-color: #0ea5e9;
                box-shadow: 0 0 0 3px rgba(14, 165, 233, 0.1);
            }

            .form-textarea {
                min-height: 120px;
                resize: vertical;
                font-family: inherit;
                line-height: 1.5;
            }

            .form-select {
                appearance: none;
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
                background-position: right 0.75rem center;
                background-repeat: no-repeat;
                background-size: 1.25em 1.25em;
                padding-right: 3rem;
            }

            .btn {
                padding: 0.75rem 1.5rem;
                border-radius: 8px;
                font-weight: 500;
                font-size: 0.875rem;
                transition: all 0.2s ease;
                border: none;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
            }

            .btn-primary {
                background: linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%);
                color: white;
            }

            .btn-primary:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(14, 165, 233, 0.4);
            }

            .btn-secondary {
                background: #f8fafc;
                color: #64748b;
                border: 1px solid #e2e8f0;
            }

            .btn-secondary:hover {
                background: #f1f5f9;
                color: #475569;
            }

            .btn-danger {
                background: #ef4444;
                color: white;
            }

            .btn-danger:hover {
                background: #dc2626;
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(239, 68, 68, 0.4);
            }

            .carousel-container {
                position: relative;
                overflow: hidden;
                border-radius: 12px;
                width: 100%;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            }

            .carousel-track {
                display: flex;
                transition: transform 0.5s ease-in-out;
                width: 100%;
            }

            .carousel-slide {
                min-width: 100%;
                width: 100%;
                height: 280px;
                flex-shrink: 0;
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
                background: rgba(255, 255, 255, 0.9);
                color: #374151;
                border: none;
                padding: 12px;
                cursor: pointer;
                border-radius: 50%;
                transition: all 0.3s ease;
                z-index: 10;
                backdrop-filter: blur(10px);
            }

            .carousel-nav:hover {
                background: white;
                transform: translateY(-50%) scale(1.1);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            }

            .carousel-prev {
                left: 15px;
            }

            .carousel-next {
                right: 15px;
            }

            .carousel-dots {
                display: flex;
                justify-content: center;
                gap: 10px;
                margin-top: 20px;
            }

            .carousel-dot {
                width: 8px;
                height: 8px;
                border-radius: 50%;
                background: rgba(148, 163, 184, 0.5);
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .carousel-dot.active {
                background: #0ea5e9;
                transform: scale(1.2);
            }

            .upload-zone {
                border: 2px dashed #cbd5e1;
                border-radius: 12px;
                padding: 2rem;
                text-align: center;
                transition: all 0.3s ease;
                cursor: pointer;
                background: #f8fafc;
            }

            .upload-zone:hover {
                border-color: #0ea5e9;
                background: #f0f9ff;
            }

            .upload-zone.dragover {
                border-color: #0ea5e9;
                background: #f0f9ff;
                border-style: solid;
            }

            .image-preview {
                position: relative;
                display: inline-block;
                margin: 0.5rem;
            }

            .image-preview img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 8px;
                border: 2px solid #e5e7eb;
            }

            .image-preview .remove-btn {
                position: absolute;
                top: -6px;
                right: -6px;
                background: #ef4444;
                color: white;
                border: none;
                border-radius: 50%;
                width: 20px;
                height: 20px;
                font-size: 10px;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.2s ease;
            }

            .image-preview .remove-btn:hover {
                background: #dc2626;
                transform: scale(1.1);
            }

            .section-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: #1f2937;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .section-title i {
                color: #0ea5e9;
            }

            .image-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
                gap: 1rem;
                margin-top: 1rem;
            }

            .image-item {
                position: relative;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                transition: all 0.2s ease;
            }

            .image-item:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            }

            .image-item img {
                width: 100%;
                height: 80px;
                object-fit: cover;
            }

            .image-item .remove-checkbox {
                position: absolute;
                top: 8px;
                right: 8px;
                background: rgba(255, 255, 255, 0.9);
                border-radius: 4px;
                padding: 4px;
                cursor: pointer;
                transition: all 0.2s ease;
            }

            .image-item .remove-checkbox:hover {
                background: #fee2e2;
            }

            .image-item .remove-checkbox input:checked + i {
                color: #ef4444;
            }

            .page-title {
                text-align: center;
                margin-bottom: 2rem;
            }

            .page-title h1 {
                font-size: 2rem;
                font-weight: 700;
                color: #1f2937;
                margin-bottom: 0.5rem;
            }

            .page-title p {
                color: #6b7280;
                font-size: 1rem;
            }

            .breadcrumb {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                margin-bottom: 2rem;
                font-size: 0.875rem;
                color: #6b7280;
            }

            .breadcrumb a {
                color: #0ea5e9;
                text-decoration: none;
                transition: color 0.2s ease;
            }

            .breadcrumb a:hover {
                color: #0284c7;
            }

            .status-badge {
                padding: 0.25rem 0.75rem;
                border-radius: 20px;
                font-size: 0.75rem;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 0.05em;
            }

            .status-available {
                background: #dcfce7;
                color: #166534;
            }

            .status-pending {
                background: #fef3c7;
                color: #92400e;
            }

            .status-rejected {
                background: #fee2e2;
                color: #991b1b;
            }
        </style>
    </head>
    <body>
        <!-- Header (keeping original) -->
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

        <div class="container mx-auto px-4 py-8 max-w-5xl">
            <!-- Breadcrumb -->
            <div class="breadcrumb">
                <a href="#" onclick="history.back()">
                    <i class="fas fa-arrow-left"></i>
                    Go back
                </a>
                <span>/</span>
                <span>Edit Post</span>
            </div>

            <!-- Page Title -->
            <div class="page-title">
                <h1>Edit Post</h1>
                <p>Update your post information and media</p>
            </div>

            <!-- Main Form -->
            <form id="editPost" action="${pageContext.request.contextPath}/owner-house/edit" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="postId" value="${p.id}" />

                <div class="space-y-6">
                    <!-- Post Information Card -->
                    <div class="card p-6">
                        <div class="flex items-center justify-between mb-6">
                            <h2 class="section-title">
                                <i class="fas fa-edit"></i>
                                Post Information
                            </h2>
                            <div class="flex gap-3">
                                <button type="button" onclick="history.back()" class="btn btn-secondary">
                                    <i class="fas fa-times"></i>
                                    Cancel
                                </button>
                                <button type="button" onclick="handleSave()" class="btn btn-primary">
                                    <i class="fas fa-save"></i>
                                    Save Changes
                                </button>
                            </div>
                        </div>

                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                            <!-- Left Column - Form Fields -->
                            <div class="space-y-4">
                                <!-- Content -->
                                <div class="form-group">
                                    <label for="content" class="form-label">
                                        <i class="fas fa-align-left mr-1"></i>
                                        Content *
                                    </label>
                                    <textarea id="content" name="content" 
                                              class="form-input form-textarea" required 
                                              placeholder="Describe your post...">${p.content}</textarea>
                                </div>

                                <!-- Post Type -->
                                <div class="form-group">
                                    <label for="postType" class="form-label">
                                        <i class="fas fa-tag mr-1"></i>
                                        Post Type
                                    </label>
                                    <input id="postType" name="postType" type="text" value="${p.post_type.name}" readonly
                                           class="form-input bg-gray-50" />
                                </div>

                                <!-- Status -->
                                <div class="form-group">
                                    <label for="status" class="form-label">
                                        <i class="fas fa-info-circle mr-1"></i>
                                        Status
                                    </label>
                                    <input id="status" name="status" type="text" value="${p.status.name}" readonly
                                           class="form-input bg-gray-50" />
                                </div>

                                <!-- Homestay Association -->
                                <c:if test="${p.post_type.id == 1}">
                                    <div class="form-group">
                                        <label for="homestay" class="form-label">
                                            <i class="fas fa-home mr-1"></i>
                                            Associated Homestay
                                        </label>
                                        <select id="homestay" name="homestay" class="form-input form-select">
                                            <c:forEach items="${hList}" var="h">
                                                <option value="${h.id}" ${h.id == p.house.id ? 'selected' : ''}>${h.name}</option>
                                            </c:forEach>
                                        </select>
                                        <p class="text-xs text-gray-500 mt-1">Homestay images will be displayed automatically</p>
                                    </div>
                                </c:if>
                            </div>

                            <!-- Right Column - Current Images -->
                            <div class="space-y-4">
                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-images mr-1"></i>
                                        Current Images
                                    </label>

                                    <div class="carousel-container" id="postCarousel">
                                        <div class="carousel-track" id="postTrack">
                                            <c:forEach var="image" items="${p.medias}" varStatus="status">
                                                <div class="carousel-slide">
                                                    <img src="${pageContext.request.contextPath}/Asset/Common/Post/${image.path}" 
                                                         alt="${p.content}" 
                                                         class="w-full h-full object-cover">
                                                </div>
                                            </c:forEach>
                                            <c:if test="${empty p.medias}">
                                                <div class="carousel-slide">
                                                    <img src="${pageContext.request.contextPath}/Asset/Common/House/no-image.webp" 
                                                         alt="No image available" 
                                                         class="w-full h-full object-cover">
                                                </div>
                                            </c:if>
                                        </div>

                                        <c:if test="${fn:length(p.medias) > 1}">
                                            <button type="button" class="carousel-nav carousel-prev" onclick="prevSlide('post')">
                                                <i class="fas fa-chevron-left"></i>
                                            </button>
                                            <button type="button" class="carousel-nav carousel-next" onclick="nextSlide('post')">
                                                <i class="fas fa-chevron-right"></i>
                                            </button>

                                            <div class="carousel-dots">
                                                <c:forEach var="image" items="${p.medias}" varStatus="status">
                                                    <div class="carousel-dot ${status.index == 0 ? 'active' : ''}" 
                                                         onclick="goToSlide('post', ${status.index})"></div>
                                                </c:forEach>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Image Management Card -->
                    <div class="card p-6">
                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                            <!-- Upload New Images -->
                            <div>
                                <h3 class="section-title">
                                    <i class="fas fa-cloud-upload-alt"></i>
                                    Upload New Images
                                </h3>

                                <div class="upload-zone" id="imageUploadArea" onclick="document.getElementById('imageInput').click()">
                                    <input type="file" id="imageInput" name="images" multiple accept="image/*" 
                                           style="display: none;" onchange="handleImageUpload(event)" />
                                    <div class="text-center">
                                        <i class="fas fa-cloud-upload-alt text-3xl text-gray-400 mb-3"></i>
                                        <p class="text-gray-600 mb-1 font-medium">Drop files here or click to browse</p>
                                        <p class="text-sm text-gray-500">PNG, JPG, JPEG up to 10MB each</p>
                                    </div>
                                </div>

                                <div id="imagePreview" class="mt-4"></div>
                            </div>

                            <!-- Remove Current Images -->
                            <c:if test="${not empty p.medias}">
                                <div>
                                    <h3 class="section-title">
                                        <i class="fas fa-trash-alt"></i>
                                        Remove Current Images
                                    </h3>
                                    <div class="image-grid">
                                        <c:forEach var="image" items="${p.medias}" varStatus="status">
                                            <div class="image-item">
                                                <img src="${pageContext.request.contextPath}/Asset/Common/Post/${image.path}" 
                                                     alt="Current image" />
                                                <label class="remove-checkbox">
                                                    <input type="checkbox" name="removeImages" value="${image.id}" class="hidden" />
                                                    <i class="fas fa-times text-gray-400"></i>
                                                </label>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
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
                                               let totalSlides = ${fn:length(p.medias)};

                                               function updateCarousel() {
                                                   const track = document.getElementById('postTrack');
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
                                                   const content = document.getElementById('content').value.trim();

                                                   // Basic required field check
                                                   if (!content) {
                                                       showToast("All required fields must be filled.", "error");
                                                       return false;
                                                   }

                                                   // Length checks
                                                   if (content.length > 1000) {
                                                       showToast("Content must be less than 1000 characters.", "error");
                                                       return false;
                                                   }

                                                   return true;
                                               }

                                               function handleSave() {
                                                   const form = document.getElementById('editPost');

                                                   if (!validateHomestayForm())
                                                       return;

                                                   const formData = new FormData(form);
                                                   formData.append("type", "post");

                                                   $.ajax({
                                                       url: '${pageContext.request.contextPath}/post-request/update',
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
                                                               setTimeout(function () {
                                                                   location.reload();
                                                               }, 1000);
                                                           } else {
                                                               showToast(response.message, 'error');
                                                           }
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