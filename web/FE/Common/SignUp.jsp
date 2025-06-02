<%-- 
    Document   : SignUp
    Created on : May 22, 2025, 10:23:36 PM
    Author     : Huyen
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Up</title>

        <!-- Libs -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <style>
        .radio-custom {
            appearance: none;
            width: 20px;
            height: 20px;
            border: 2px solid #e5e7eb;
            border-radius: 50%;
            position: relative;
        }

        .radio-custom:checked {
            border-color: #f97316;
            background-color: #f97316;
        }

        .radio-custom:checked::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background-color: white;
            transform: translate(-50%, -50%);
        }

        .swal2-loader {
            border-color: #FF7700 !important;
            border-top-color: transparent !important;
        }

        .swal2-loader {
            width: 2.2em !important;
            height: 2.2em !important;
            border-width: 0.22em !important;
        }
    </style>
    <body class="bg-gray-50 min-h-screen flex flex-col items-center justify-center p-4">

        <!-- Logo -->
        <div class="mb-8">
            <img src="${pageContext.request.contextPath}/Asset/FUHF Logo/2.svg" width="200"/>
        </div>

        <!-- Sign Up Form -->
        <div class="bg-white rounded-2xl shadow-lg border-2 border-orange-500 p-6 w-full max-w-md">
            <form id="signupForm" class="space-y-6">
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <input type="text" name="firstName" placeholder="First Name" 
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent">
                    </div>
                    <div>
                        <input type="text" name="lastName" placeholder="Last Name" 
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent">
                    </div>
                </div>

                <div>
                    <label class="block text-gray-700 text-sm font-medium mb-2">Date of birth</label>
                    <div class="grid grid-cols-3 gap-4">
                        <select name="day" id="daySelect" 
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent text-gray-700">
                            <option value="">Day</option>
                        </select>
                        <select name="month" id="monthSelect" 
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent text-gray-700">
                            <option value="">Month</option>
                            <option value="01">January</option>
                            <option value="02">February</option>
                            <option value="03">March</option>
                            <option value="04">April</option>
                            <option value="05">May</option>
                            <option value="06">June</option>
                            <option value="07">July</option>
                            <option value="08">August</option>
                            <option value="09">September</option>
                            <option value="10">October</option>
                            <option value="11">November</option>
                            <option value="12">December</option>
                        </select>
                        <select name="year" id="yearSelect" 
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent text-gray-700">
                            <option value="">Year</option>
                        </select>
                    </div>
                </div>

                <div>
                    <label class="block text-gray-700 text-sm font-medium mb-3">Gender</label>
                    <div class="flex space-x-6">
                        <label class="flex items-center cursor-pointer">
                            <input type="radio" name="gender" value="male" class="radio-custom">
                            <span class="ml-2 text-gray-700">Male</span>
                        </label>
                        <label class="flex items-center cursor-pointer">
                            <input type="radio" name="gender" value="female" class="radio-custom">
                            <span class="ml-2 text-gray-700">Female</span>
                        </label>
                        <label class="flex items-center cursor-pointer">
                            <input type="radio" name="gender" value="other" class="radio-custom">
                            <span class="ml-2 text-gray-700">Other</span>
                        </label>
                    </div>
                </div>

                <div>
                    <input type="text" name="contact" placeholder="Email" 
                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent">
                </div>

                <div class="relative">
                    <input type="password" name="password" placeholder="Password"  id="passwordField"
                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent">
                    <button type="button" id="togglePassword" class="absolute right-3 top-3 text-gray-500 hover:text-gray-700 focus:outline-none flex items-center justify-center w-6 h-6">
                        <i id="eyeIcon" class="fas fa-eye"></i>
                    </button>
                </div>

                <button type="submit" 
                        class="w-full bg-orange-500 hover:bg-orange-600 text-white font-semibold py-3 px-4 rounded-lg transition duration-200 focus:outline-none focus:ring-4 focus:ring-orange-200">
                    Sign Up
                </button>

                <div class="text-center">
                    <a href="${pageContext.request.contextPath}/login" class="text-blue-500 hover:text-blue-600 text-sm">Already have account?</a>
                </div>
            </form>
        </div>

        <!-- Footer -->
        <div class="mt-8 text-center">
            <p class="text-orange-500 text-sm">FU HOUSE FINDER © 2025 - ISP302 - G4</p>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
            // Password toggle functionality
            document.getElementById('togglePassword').addEventListener('click', function () {
                const passwordField = document.getElementById('passwordField');
                const eyeIcon = document.getElementById('eyeIcon');

                if (passwordField.type === 'password') {
                    passwordField.type = 'text';
                    eyeIcon.classList.remove('fa-eye');
                    eyeIcon.classList.add('fa-eye-slash');
                } else {
                    passwordField.type = 'password';
                    eyeIcon.classList.remove('fa-eye-slash');
                    eyeIcon.classList.add('fa-eye');
                }
            });

            function initializeDateSelectors() {
                const daySelect = document.getElementById('daySelect');
                const monthSelect = document.getElementById('monthSelect');
                const yearSelect = document.getElementById('yearSelect');

                // Populate years (from current year back to 1900)
                const currentYear = new Date().getFullYear();
                for (let year = currentYear; year >= 1900; year--) {
                    const option = document.createElement('option');
                    option.value = year;
                    option.textContent = year;
                    yearSelect.appendChild(option);
                }

                // Function to get days in a month
                function getDaysInMonth(month, year) {
                    // Month is 1-indexed (1 = January, 2 = February, etc.)
                    return new Date(year, month, 0).getDate();
                }

                // Function to check if a year is a leap year
                function isLeapYear(year) {
                    return (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);
                }

                // Function to update day options based on selected month and year
                function updateDayOptions() {
                    const selectedMonth = parseInt(monthSelect.value, 10);
                    const selectedYear = parseInt(yearSelect.value);
                    const selectedDay = parseInt(daySelect.value);

                    // Clear existing day options except the first one
                    daySelect.innerHTML = '<option value="">Day</option>';

                    if (selectedMonth && selectedYear) {
                        const daysInMonth = getDaysInMonth(selectedMonth, selectedYear);

                        for (let day = 1; day <= daysInMonth; day++) {
                            const option = document.createElement('option');
                            option.value = day;
                            option.textContent = day;
                            daySelect.appendChild(option);
                        }

                        // Restore selected day if it's still valid
                        if (selectedDay && selectedDay <= daysInMonth) {
                            daySelect.value = selectedDay;
                        }
                    } else if (selectedMonth) {
                        // If only month is selected, show days based on the maximum possible days
                        let maxDays;
                        if (selectedMonth === 2) {
                            // February - assume leap year to show 29 days
                            maxDays = 29;
                        } else if ([4, 6, 9, 11].includes(selectedMonth)) {
                            // April, June, September, November
                            maxDays = 30;
                        } else {
                            // January, March, May, July, August, October, December
                            maxDays = 31;
                        }

                        for (let day = 1; day <= maxDays; day++) {
                            const option = document.createElement('option');
                            option.value = day;
                            option.textContent = day;
                            daySelect.appendChild(option);
                        }

                        // Restore selected day if it's still valid
                        if (selectedDay && selectedDay <= maxDays) {
                            daySelect.value = selectedDay;
                        }
                    }
                }

                // Add event listeners to month and year selectors
                monthSelect.addEventListener('change', updateDayOptions);
                yearSelect.addEventListener('change', updateDayOptions);
            }

            document.addEventListener('DOMContentLoaded', initializeDateSelectors);

            function validatePassword(password) {
                if (password.length < 6 || password.length > 20) {
                    Toastify({
                        text: "Password must be 6–20 characters long",
                        backgroundColor: "#ef4444",
                        duration: 3000
                    }).showToast();
                    return false;
                }

                if (!/[!@#$%^&*(),.?":{}|<>]/.test(password)) {
                    Toastify({
                        text: "Password must contain a special character",
                        backgroundColor: "#ef4444",
                        duration: 3000
                    }).showToast();
                    return false;
                }

                if (!/[A-Z]/.test(password) || !/[0-9]/.test(password)) {
                    Toastify({
                        text: "Password must include at least 1 uppercase letter and 1 number",
                        backgroundColor: "#ef4444",
                        duration: 3000
                    }).showToast();
                    return false;
                }

                return true;
            }

            document.getElementById('signupForm').addEventListener('submit', function (e) {
                e.preventDefault();

                const formData = new FormData(this);
                const data = Object.fromEntries(formData);

                const emailRegex = /^[\w.%+-]+@[\w.-]+\.[a-zA-Z]{2,}$/;

                if (!data.firstName || !data.lastName || !data.contact || !data.password) {
                    showToast("Please fill in all required fields", "error");
                    return;
                }

                if (!data.gender) {
                    showToast("Please select your gender", "error");
                    return;
                }

                if (!emailRegex.test(data.contact)) {
                    showToast("Please enter a valid email address", "error");
                    return;
                }

                if (!validatePassword(data.password)) {
                    return;
                }

                console.log('Form data:', data);

                $.ajax({
                    url: '${pageContext.request.contextPath}/signup',
                    type: 'POST',
                    beforeSend: function (xhr) {
                        showLoading();
                    },
                    data: {
                        firstName: data.firstName,
                        lastName: data.lastName,
                        day: data.day,
                        month: data.month,
                        year: data.year,
                        gender: data.gender,
                        contact: data.contact,
                        password: data.password
                    },
                    success: function (response) {
                        if (response.ok == true) {
                            Swal.close();
                            Swal.fire({
                                title: 'Email Verification',
                                html: `
        <p>We have sent a verification link to your email. Please click on the link to verify your account before logging in!</p>
    `,
                                imageUrl: `${pageContext.request.contextPath}/Asset/FUHF Logo/3.svg`,
                                imageWidth: 150,
                                imageHeight: 150,
                                imageAlt: 'Custom icon',
                                confirmButtonText: 'Ok',
                                focusConfirm: false,
                                allowOutsideClick: false,
                                customClass: {
                                    popup: 'rounded-xl shadow-lg',
                                    title: 'text-xl font-semibold',
                                    confirmButton: 'bg-[#FF7700] text-white px-4 py-2 rounded',
                                },
                                buttonsStyling: false
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    location.href = '${pageContext.request.contextPath}/login';
                                }
                            });
                        } else {
                            Swal.close();
                            showToast(response.message, "error");
                        }
                    },
                    error: function (xhr) {
                        let errorMessage = xhr.responseJSON?.message;
                        showToast(errorMessage, "error");
                    }
                });
            });

            function showLoading() {
                Swal.fire({
                    title: 'Sending verification...',
                    didOpen: () => {
                        Swal.showLoading();
                    },
                    allowOutsideClick: false,
                    showConfirmButton: false,
                    customClass: {
                        title: 'text-xl font-semibold'
                    }
                });
            }

            function showToast(message, type = 'success') {
                let backgroundColor;

                if (type === "success") {
                    backgroundColor = "linear-gradient(to right, #00b09b, #96c93d)"; // Green
                } else if (type === "error") {
                    backgroundColor = "linear-gradient(to right, #ff416c, #ff4b2b)"; // Red
                } else if (type === "warning") {
                    backgroundColor = "linear-gradient(to right, #ffa502, #ff6348)"; // Orange
                } else if (type === "info") {
                    backgroundColor = "linear-gradient(to right, #1e90ff, #3742fa)"; // Blue
                } else {
                    backgroundColor = "#333"; // Default color (dark gray)
                }

                Toastify({
                    text: message, // Dynamically set message
                    duration: 2000,
                    close: true,
                    gravity: "top",
                    position: "right",
                    backgroundColor: backgroundColor, // Dynamically set background color
                    stopOnFocus: true
                }).showToast();
            }
        </script>
    </body>
</html>