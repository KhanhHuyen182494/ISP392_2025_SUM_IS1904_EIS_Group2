<%-- 
    Document   : PaymentDetail
    Created on : Jul 17, 2025, 1:58:50 PM
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
        <title>Payment Detail - #${payment.id}</title>

        <!-- Libs -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <link href="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

            body {
                font-family: 'Inter', sans-serif;
                background-color: #f8fafc;
            }

            .simple-card {
                background: white;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                border: 1px solid #e2e8f0;
            }

            .simple-card:hover {
                box-shadow: 0 4px 16px rgba(0, 0, 0, 0.15);
                transition: box-shadow 0.2s ease;
            }

            .status-badge {
                display: inline-flex;
                align-items: center;
                padding: 8px 16px;
                border-radius: 24px;
                font-size: 14px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .status-pending {
                background-color: #fef3c7;
                color: #92400e;
                border: 1px solid #fbbf24;
            }

            .status-completed {
                background-color: #d1fae5;
                color: #065f46;
                border: 1px solid #10b981;
            }

            .status-cancelled {
                background-color: #fee2e2;
                color: #991b1b;
                border: 1px solid #ef4444;
            }

            .status-processing {
                background-color: #dbeafe;
                color: #1e40af;
                border: 1px solid #3b82f6;
            }

            .btn-primary {
                background-color: #3b82f6;
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: 8px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.2s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-primary:hover {
                background-color: #2563eb;
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
            }

            .btn-secondary {
                background-color: #6b7280;
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: 8px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.2s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-secondary:hover {
                background-color: #4b5563;
                transform: translateY(-1px);
            }

            .btn-danger {
                background-color: #ef4444;
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: 8px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.2s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-danger:hover {
                background-color: #dc2626;
                transform: translateY(-1px);
            }

            .btn-success {
                background-color: #10b981;
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: 8px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.2s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-success:hover {
                background-color: #059669;
                transform: translateY(-1px);
            }

            .detail-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 16px 0;
                border-bottom: 1px solid #f1f5f9;
            }

            .detail-row:last-child {
                border-bottom: none;
            }

            .detail-label {
                font-weight: 500;
                color: #64748b;
                font-size: 14px;
            }

            .detail-value {
                font-weight: 600;
                color: #1e293b;
                text-align: right;
            }

            .amount-highlight {
                font-size: 24px;
                font-weight: 700;
                color: #059669;
            }

            .property-image {
                width: 80px;
                height: 80px;
                border-radius: 8px;
                object-fit: cover;
            }

            .timeline-item {
                display: flex;
                align-items: flex-start;
                gap: 16px;
                padding: 16px 0;
                border-bottom: 1px solid #f1f5f9;
            }

            .timeline-item:last-child {
                border-bottom: none;
            }

            .timeline-icon {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 16px;
                flex-shrink: 0;
            }

            .timeline-icon.pending {
                background-color: #f59e0b;
            }

            .timeline-icon.completed {
                background-color: #10b981;
            }

            .timeline-icon.cancelled {
                background-color: #ef4444;
            }

            .timeline-content {
                flex: 1;
            }

            .back-button {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                color: #6b7280;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.2s ease;
            }

            .back-button:hover {
                color: #374151;
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

        <div class="container mx-auto px-4 py-8 max-w-7xl">
            <!-- Breadcrumb -->
            <div class="mb-6">
                <a href="${pageContext.request.contextPath}/payment/history" class="back-button">
                    <i class="fas fa-arrow-left"></i>
                    Back to Payment History
                </a>
            </div>

            <!-- Page Title -->
            <div class="mb-8">
                <div class="simple-card p-6">
                    <div class="flex items-center justify-between">
                        <div>
                            <h1 class="text-3xl font-bold text-gray-800 mb-2">Payment Detail</h1>
                            <p class="text-gray-600">Payment ID: #${payment.id}</p>
                        </div>
                        <div class="text-right">
                            <div class="status-badge status-${fn:toLowerCase(payment.status.name)}">
                                ${payment.status.name}
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <!-- Main Content -->
                <div class="lg:col-span-2 space-y-6">
                    <!-- Payment Information -->
                    <div class="simple-card">
                        <div class="p-6 border-b border-gray-200">
                            <h2 class="text-xl font-semibold text-gray-800 mb-1">
                                <i class="fas fa-credit-card mr-2"></i>Payment Information
                            </h2>
                            <p class="text-gray-600 text-sm">Complete payment details and transaction information</p>
                        </div>
                        <div class="p-6">
                            <div class="detail-row">
                                <span class="detail-label">Payment ID</span>
                                <span class="detail-value">#${payment.id}</span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Amount</span>
                                <span class="detail-value amount-highlight">
                                    <fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="₫" />
                                </span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Payment Method</span>
                                <span class="detail-value">${payment.method}</span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Transaction ID</span>
                                <span class="detail-value">${payment.transaction_id != null ? payment.transaction_id : 'N/A'}</span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Created Date</span>
                                <span class="detail-value">
                                    <fmt:formatDate value="${payment.created_at}" pattern="dd/MM/yyyy HH:mm:ss" />
                                </span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Status</span>
                                <span class="detail-value">
                                    <span class="status-badge status-${fn:toLowerCase(payment.status.name)}">
                                        ${payment.status.name}
                                    </span>
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- Property Information -->
                    <div class="simple-card">
                        <div class="p-6 border-b border-gray-200">
                            <h2 class="text-xl font-semibold text-gray-800 mb-1">
                                <i class="fas fa-home mr-2"></i>Property Information
                            </h2>
                            <p class="text-gray-600 text-sm">Details about the booked property</p>
                        </div>
                        <div class="p-6">
                            <div class="flex items-start gap-4 mb-4">
                                <img src="${pageContext.request.contextPath}/Asset/Property/Images/${payment.booking.homestay.main_image}" 
                                     alt="${payment.booking.homestay.name}" 
                                     class="property-image">
                                <div class="flex-1">
                                    <h3 class="text-lg font-semibold text-gray-800 mb-2">${payment.booking.homestay.name}</h3>
                                    <p class="text-gray-600 text-sm mb-2">
                                        <i class="fas fa-map-marker-alt mr-1"></i>
                                        ${payment.booking.homestay.address}
                                    </p>
                                    <div class="flex items-center gap-4 text-sm text-gray-600">
                                        <span>
                                            <c:choose>
                                                <c:when test="${payment.booking.homestay.is_whole_house == true}">
                                                    <i class="fas fa-home mr-1"></i>Whole House
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-bed mr-1"></i>Room
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                        <span>
                                            <i class="fas fa-users mr-1"></i>
                                            ${payment.booking.homestay.max_guests} guests
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Check-in Date</span>
                                <span class="detail-value">
                                    <fmt:formatDate value="${payment.booking.check_in_date}" pattern="dd/MM/yyyy" />
                                </span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Check-out Date</span>
                                <span class="detail-value">
                                    <fmt:formatDate value="${payment.booking.check_out_date}" pattern="dd/MM/yyyy" />
                                </span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Number of Guests</span>
                                <span class="detail-value">${payment.booking.num_guests}</span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Total Nights</span>
                                <span class="detail-value">${payment.booking.total_nights}</span>
                            </div>
                        </div>
                    </div>

                    <!-- Guest Information -->
                    <div class="simple-card">
                        <div class="p-6 border-b border-gray-200">
                            <h2 class="text-xl font-semibold text-gray-800 mb-1">
                                <i class="fas fa-user mr-2"></i>Guest Information
                            </h2>
                            <p class="text-gray-600 text-sm">Information about the guest who made the booking</p>
                        </div>
                        <div class="p-6">
                            <div class="detail-row">
                                <span class="detail-label">Guest Name</span>
                                <span class="detail-value">${payment.booking.guest.first_name} ${payment.booking.guest.last_name}</span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Email</span>
                                <span class="detail-value">${payment.booking.guest.email}</span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Phone</span>
                                <span class="detail-value">${payment.booking.guest.phone != null ? payment.booking.guest.phone : 'N/A'}</span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Booking Date</span>
                                <span class="detail-value">
                                    <fmt:formatDate value="${payment.booking.booking_date}" pattern="dd/MM/yyyy HH:mm:ss" />
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="space-y-6">
                    <!-- Quick Actions -->
                    <div class="simple-card">
                        <div class="p-6 border-b border-gray-200">
                            <h3 class="text-lg font-semibold text-gray-800">Quick Actions</h3>
                        </div>
                        <div class="p-6 space-y-3">
                            <c:if test="${payment.status.id == 33 || payment.status.id == 31 || payment.status.id == 35}">
                                <button onclick="updatePaymentStatus('${payment.id}', 39)" 
                                        class="btn-danger w-full">
                                    <i class="fas fa-times"></i>
                                    Cancel Payment
                                </button>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/booking/contract/preview?bookId=${payment.booking.id}" 
                               class="btn-success w-full">
                                <i class="fas fa-file-contract"></i>
                                View Contract
                            </a>
                            <button onclick="window.print()" class="btn-secondary w-full">
                                <i class="fas fa-print"></i>
                                Print Receipt
                            </button>
                            <a href="${pageContext.request.contextPath}/payment/history" class="btn-primary w-full">
                                <i class="fas fa-list"></i>
                                All Payments
                            </a>
                        </div>
                    </div>

                    <!-- Payment Summary -->
                    <div class="simple-card">
                        <div class="p-6 border-b border-gray-200">
                            <h3 class="text-lg font-semibold text-gray-800">Payment Summary</h3>
                        </div>
                        <div class="p-6">
                            <div class="detail-row">
                                <span class="detail-label">Subtotal</span>
                                <span class="detail-value">
                                    <fmt:formatNumber value="${payment.amount * 0.9}" type="currency" currencySymbol="₫" />
                                </span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Service Fee</span>
                                <span class="detail-value">
                                    <fmt:formatNumber value="${payment.amount * 0.1}" type="currency" currencySymbol="₫" />
                                </span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">VAT (0%)</span>
                                <span class="detail-value">₫0</span>
                            </div>
                            <div class="detail-row" style="border-top: 2px solid #e2e8f0; padding-top: 16px; margin-top: 16px;">
                                <span class="detail-label text-lg font-semibold">Total Amount</span>
                                <span class="detail-value amount-highlight">
                                    <fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="₫" />
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- Payment Timeline -->
                    <div class="simple-card">
                        <div class="p-6 border-b border-gray-200">
                            <h3 class="text-lg font-semibold text-gray-800">Payment Timeline</h3>
                        </div>
                        <div class="p-6">
                            <div class="timeline-item">
                                <div class="timeline-icon pending">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <div class="timeline-content">
                                    <h4 class="font-semibold text-gray-800">Payment Created</h4>
                                    <p class="text-sm text-gray-600">
                                        <fmt:formatDate value="${payment.created_at}" pattern="dd/MM/yyyy HH:mm:ss" />
                                    </p>
                                </div>
                            </div>
                            <c:if test="${payment.status.id == 32}">
                                <div class="timeline-item">
                                    <div class="timeline-icon completed">
                                        <i class="fas fa-check"></i>
                                    </div>
                                    <div class="timeline-content">
                                        <h4 class="font-semibold text-gray-800">Payment Completed</h4>
                                        <p class="text-sm text-gray-600">Payment successfully processed</p>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${payment.status.id == 39}">
                                <div class="timeline-item">
                                    <div class="timeline-icon cancelled">
                                        <i class="fas fa-times"></i>
                                    </div>
                                    <div class="timeline-content">
                                        <h4 class="font-semibold text-gray-800">Payment Cancelled</h4>
                                        <p class="text-sm text-gray-600">Payment was cancelled</p>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
                                function updatePaymentStatus(payId, statusId) {
                                    const statusText = {
                                        39: 'Force Cancel'
                                    };

                                    const statusName = statusText[statusId];

                                    Swal.fire({
                                        title: statusName.charAt(0).toUpperCase() + statusName.slice(1) + ` Payment`,
                                        text: `Are you sure you want to ` + statusName + ` this payment (this action cannot be undone)?`,
                                        icon: 'warning',
                                        showCancelButton: true,
                                        confirmButtonColor: '#ef4444',
                                        cancelButtonColor: '#6b7280',
                                        confirmButtonText: `Yes, ` + statusName + ` it!`
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            Swal.fire({
                                                title: 'Processing...',
                                                text: 'Please wait while we update the payment status.',
                                                allowOutsideClick: false,
                                                allowEscapeKey: false,
                                                showConfirmButton: false,
                                                didOpen: () => {
                                                    Swal.showLoading();
                                                }
                                            });

                                            $.ajax({
                                                url: '${pageContext.request.contextPath}/payment/update',
                                                type: 'POST',
                                                data: {
                                                    payId: payId,
                                                    statusId: statusId
                                                },
                                                success: function (response) {
                                                    Swal.close();
                                                    if (response.ok) {
                                                        Swal.fire({
                                                            title: 'Success!',
                                                            text: `Payment has been ` + statusName + `ed successfully.`,
                                                            icon: 'success',
                                                            confirmButtonColor: '#3b82f6'
                                                        }).then(() => {
                                                            window.location.reload();
                                                        });
                                                    } else {
                                                        Swal.fire({
                                                            title: 'Error!',
                                                            text: response.message || 'Something went wrong. Please try again.',
                                                            icon: 'error',
                                                            confirmButtonColor: '#ef4444'
                                                        });
                                                    }
                                                },
                                                error: function (xhr, status, error) {
                                                    Swal.close();
                                                    Swal.fire({
                                                        title: 'Error!',
                                                        text: 'Network error. Please check your connection and try again.',
                                                        icon: 'error',
                                                        confirmButtonColor: '#ef4444'
                                                    });
                                                    console.error('Error updating payment status:', error);
                                                }
                                            });
                                        }
                                    });
                                }

                                // Print styles
                                const printStyles = `
                @media print {
                    .no-print { display: none !important; }
                    .simple-card { box-shadow: none !important; border: 1px solid #ddd !important; }
                    body { background-color: white !important; }
                    .btn-primary, .btn-secondary, .btn-danger, .btn-success { display: none !important; }
                }
            `;

                                // Add print styles to head
                                const styleSheet = document.createElement('style');
                                styleSheet.textContent = printStyles;
                                document.head.appendChild(styleSheet);

                                // Add no-print class to interactive elements
                                document.addEventListener('DOMContentLoaded', function () {
                                    const interactiveElements = document.querySelectorAll('button, .btn-primary, .btn-secondary, .btn-danger, .btn-success');
                                    interactiveElements.forEach(el => {
                                        el.classList.add('no-print');
                                    });
                                });
        </script>
    </body>
</html>