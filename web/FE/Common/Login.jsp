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
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <style>
        
    </style>
    <body class="bg-gray-50 min-h-screen flex items-center justify-center p-4">
        
        <div class="flex items-center space-x-16 max-w-4xl w-full">
            <!-- Logo Section -->
            <div class="flex-1 flex flex-col items-center">
                <img src="${pageContext.request.contextPath}/Asset/FUHF Logo/1.svg" width="300" alt="FU House Finder Logo" class="mb-4"/>
            </div>
            
            <!-- Login Form -->
            <div class="flex-1">
                <div class="bg-white rounded-2xl shadow-lg border-2 border-orange-500 p-8 w-full max-w-sm mx-auto">
                    <form id="loginForm" class="space-y-6">
                        <div>
                            <input type="text" name="contact" placeholder="Email address or phone number" 
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent text-gray-700 placeholder-gray-400">
                        </div>
                        
                        <div>
                            <input type="password" name="password" placeholder="Password" 
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent text-gray-700 placeholder-gray-400">
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
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
            document.getElementById('loginForm').addEventListener('submit', function(e) {
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
                
                Toastify({
                    text: "Login successful!",
                    backgroundColor: "#22c55e",
                    duration: 3000
                }).showToast();
                
                console.log('Login data:', data);
            });
        </script>
    </body>
</html>