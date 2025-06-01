<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forgot Password</title>

        <!-- Libs -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <link href="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
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
    </head>
    <body class="bg-gray-50 min-h-screen flex items-center justify-center p-4">
        <div id="spinner"></div>

        <div class="max-w-4xl w-full">
            <!-- Logo Section -->
            <div class="flex-1 flex flex-col items-center justify-center gap-4 mb-8">
                <div class="flex items-center gap-3">
                    <div class="w-16 h-16 flex items-center justify-center">
                        <img src="${pageContext.request.contextPath}/Asset/FUHF Logo/3.svg" />
                    </div>
                    <p class="font-bold text-[25px] text-orange-500">Forgot Password? Let's find your account</p>
                </div>
            </div>

            <!-- Forgot Form -->
            <div class="flex-1">
                <div class="bg-white rounded-2xl shadow-lg border-2 border-orange-500 p-8 w-full max-w-[40rem] mx-auto">
                    <form id="forgotForm">
                        <h2 class="text-xl font-semibold mb-4 text-gray-800">Find your account</h2>

                        <p class="text-gray-600 text-sm mb-6">Please type in your email for us to look up your account</p>

                        <div class="mb-6">
                            <input 
                                type="email" 
                                id="contact" 
                                name="contact" 
                                placeholder="Email or phone number" 
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-orange-500 outline-none transition-colors"
                                required
                                >
                        </div>

                        <div class="flex gap-3 justify-end">
                            <button 
                                type="button" 
                                id="cancelBtn"
                                class="px-6 py-2 bg-gray-400 text-white rounded-lg hover:bg-gray-500 transition-colors"
                                >
                                Cancel
                            </button>
                            <button 
                                type="submit" 
                                class="px-8 py-2 bg-orange-500 text-white rounded-lg hover:bg-orange-600 transition-colors font-medium"
                                >
                                Find
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <div class="absolute bottom-4 left-1/2 transform -translate-x-[45%]">
            <p class="text-orange-500 text-sm text-center">FU HOUSE FINDER © 2025</p>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
            // Form submission handler
            document.getElementById('forgotForm').addEventListener('submit', function (e) {
                e.preventDefault();
                const formData = new FormData(this);
                const data = Object.fromEntries(formData);

                if (!data.contact) {
                    showToast("Please enter your email", "error");
                    return;
                }

                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(data.contact)) {
                    showToast("Please enter a valid email address", "error");
                    return;
                }


                $.ajax({
                    url: '${pageContext.request.contextPath}/forgot-password',
                    type: 'POST',
                    beforeSend: function (xhr) {
                        showLoading();
                    },
                    data: {
                        contact: data.contact
                    },
                    success: function (response) {
                        Swal.close();
                        if (response.ok) {
                            showToast("Password reset instructions sent!", "success");
                        } else {
                            showToast(response.message || "Account not found", "error");
                        }
                    },
                    error: function (xhr) {
                        Swal.close();
                        showToast("Something went wrong. Please try again.", "error");
                    }
                });
            });

            // Cancel button handler
            document.getElementById('cancelBtn').addEventListener('click', function () {
                // Redirect back to login or previous page
                location.href = '${pageContext.request.contextPath}/login';
                // Or redirect to login: window.location.href = 'login.jsp';
            });

            function showLoading() {
                Swal.fire({
                    title: 'Looking up your account...',
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
                    text: message,
                    duration: 3000,
                    close: true,
                    gravity: "top",
                    position: "right",
                    backgroundColor: backgroundColor,
                    stopOnFocus: true
                }).showToast();
            }
        </script>
    </body>
</html>