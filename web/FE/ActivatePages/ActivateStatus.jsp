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

        <div class="bg-white rounded-2xl shadow-lg border-2 border-orange-500 p-6 w-full max-w-md">
            <div class="flex justify-center">
                <p>${message}</p>
                <a href="${pageContext.request.contextPath}/login"><button class="bg-[#FF7700] text-white px-4 py-2 rounded">Login now!</button></a>
            </div>
        </div>

        <!-- Footer -->
        <div class="mt-8 text-center">
            <p class="text-orange-500 text-sm">FU HOUSE FINDER © 2025 - ISP302 - G4</p>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>

        </script>
    </body>
</html>