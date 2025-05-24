<%-- 
    Document   : Login
    Created on : May 22, 2025, 10:23:36 PM
    Author     : Huyen
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>

        <!-- Libs -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <link href="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.css" rel="stylesheet" />
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <style>

    </style>
    <body class="bg-gray-50 min-h-screen flex items-center justify-center p-4">

        <div class="flex items-center space-x-16 max-w-4xl w-full">
            <!-- Logo Section -->
            <div class="flex-1 flex flex-col items-center">
                <img src="${pageContext.request.contextPath}/Asset/FUHF Logo/1.svg" width="290" alt="FU House Finder Logo" class="mb-4"/>
            </div>

            <!-- Login Form -->
            <div class="flex-1">
                <div class="bg-white rounded-2xl shadow-lg border-2 border-orange-500 p-8 w-full max-w-sm mx-auto">
                    <form id="loginForm" class="space-y-6">
                        <div>
                            <input type="text" name="contact" placeholder="Email address or phone number" 
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent text-gray-700 placeholder-gray-400">
                        </div>

                        <div class="relative">
                            <input type="password" id="passwordField" name="password" placeholder="Password" 
                                   class="w-full px-4 py-3 pr-12 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent text-gray-700 placeholder-gray-400">
                            <button type="button" id="togglePassword" class="absolute right-3 top-3 text-gray-500 hover:text-gray-700 focus:outline-none flex items-center justify-center w-6 h-6">
                                <i id="eyeIcon" class="fas fa-eye"></i>
                            </button>
                        </div>

                        <div class="flex items-center me-4">
                            <input checked id="orange-checkbox" type="checkbox" name="rememberme" class="w-4 h-4 text-orange-500 border rounded-sm focus:ring-orange-500">
                            <label for="orange-checkbox" class="ms-2 text-sm font-medium text-gray-500">Remember me</label>
                        </div>

                        <button type="submit" 
                                class="w-full bg-orange-500 hover:bg-orange-600 text-white font-semibold py-3 px-4 rounded-lg transition duration-200 focus:outline-none focus:ring-4 focus:ring-orange-200">
                            Login
                        </button>

                        <div class="text-center">
                            <a href="#" class="text-blue-500 hover:text-blue-600 text-sm">Forgotten password?</a>
                        </div>

                        <div class="text-center pt-4 border-t border-gray-200">
                            <p class="text-gray-600 text-sm">
                                Do not have account yet, 
                                <a href="${pageContext.request.contextPath}/signup" class="text-blue-500 hover:text-blue-600 font-medium">register now</a>
                            </p>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <div class="absolute bottom-4 left-1/2 transform -translate-x-1/2">
            <p class="text-orange-500 text-sm">FU HOUSE FINDER © 2025</p>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
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

            document.getElementById('loginForm').addEventListener('submit', function (e) {
                e.preventDefault();

                const formData = new FormData(this);
                const data = Object.fromEntries(formData);

                if (!data.contact || !data.password) {
                    Toastify({
                        text: "Please fill in all fields",
                        backgroundColor: "#ef4444",
                        duration: 3000
                    }).showToast();
                    return;
                }

                $.ajax({
                    url: '${pageContext.request.contextPath}/login',
                    type: 'POST',
                    data: {
                        contact: data.contact,
                        password: data.password,
                        rememberme: data.rememberme
                    }, 
                    success: function(response){
                        
                    }, 
                    error: function(xhr){
                        
                    }
                });
            });
            
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