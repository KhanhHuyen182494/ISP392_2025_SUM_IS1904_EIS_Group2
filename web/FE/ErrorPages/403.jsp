<%-- 
    Document   : 403
    Created on : June 28, 2025
    Author     : Huyen
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Access Forbidden - 403</title>

        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

        <style>
            body {
                background: linear-gradient(135deg, #ef4444 0%, #dc2626 50%, #991b1b 100%);
                min-height: 100vh;
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            }

            .floating {
                animation: floating 3s ease-in-out infinite;
            }

            @keyframes floating {
                0%, 100% {
                    transform: translateY(0px);
                }
                50% {
                    transform: translateY(-20px);
                }
            }

            .bounce-in {
                animation: bounceIn 1s ease-out;
            }

            @keyframes bounceIn {
                0% {
                    opacity: 0;
                    transform: scale(0.3);
                }
                50% {
                    opacity: 1;
                    transform: scale(1.05);
                }
                70% {
                    transform: scale(0.9);
                }
                100% {
                    opacity: 1;
                    transform: scale(1);
                }
            }

            .fade-in {
                animation: fadeInUp 1s ease-out 0.5s both;
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .pulse-glow {
                animation: pulseGlow 2s ease-in-out infinite alternate;
            }

            @keyframes pulseGlow {
                from {
                    box-shadow: 0 0 20px rgba(239, 68, 68, 0.5);
                }
                to {
                    box-shadow: 0 0 40px rgba(239, 68, 68, 0.8);
                }
            }

            .stars {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: 1;
            }

            .star {
                position: absolute;
                width: 2px;
                height: 2px;
                background: white;
                border-radius: 50%;
                animation: twinkle 2s infinite;
            }

            @keyframes twinkle {
                0%, 100% {
                    opacity: 0;
                }
                50% {
                    opacity: 1;
                }
            }

            .error-number {
                font-size: clamp(8rem, 20vw, 16rem);
                background: linear-gradient(45deg, #fbbf24, #f59e0b, #d97706);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                text-shadow: 0 0 30px rgba(251, 191, 36, 0.5);
                font-weight: 900;
                letter-spacing: -0.05em;
            }

            .glass-effect {
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.2);
            }

            .hover-lift {
                transition: all 0.3s ease;
            }

            .hover-lift:hover {
                transform: translateY(-5px);
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
            }

            .shield {
                animation: shieldPulse 3s ease-in-out infinite;
            }

            @keyframes shieldPulse {
                0%, 100% {
                    transform: scale(1) rotate(0deg);
                    opacity: 0.9;
                }
                50% {
                    transform: scale(1.1) rotate(3deg);
                    opacity: 1;
                }
            }

            .warning-flash {
                animation: warningFlash 2s ease-in-out infinite;
            }

            @keyframes warningFlash {
                0%, 100% {
                    color: #fbbf24;
                }
                50% {
                    color: #ef4444;
                }
            }

            .restricted-zone {
                animation: restrictedZone 4s ease-in-out infinite;
            }

            @keyframes restrictedZone {
                0%, 100% {
                    box-shadow: 0 0 20px rgba(239, 68, 68, 0.3);
                    border-color: rgba(239, 68, 68, 0.5);
                }
                50% {
                    box-shadow: 0 0 40px rgba(239, 68, 68, 0.6);
                    border-color: rgba(239, 68, 68, 0.8);
                }
            }
        </style>
    </head>
    <body class="">
        <!-- Animated Stars Background -->
        <div class="stars" id="stars"></div>

        <div class="min-h-screen flex items-center justify-center relative z-10 px-4">
            <div class="text-center max-w-4xl mx-auto">

                <!-- Shield Warning Icon -->
                <div class="shield mb-8">
                    <i class="fas fa-shield-alt text-red-400 text-6xl opacity-80"></i>
                </div>

                <!-- 403 Number -->
                <div class="bounce-in">
                    <h1 class="error-number leading-none mb-4">403</h1>
                </div>

                <!-- Error Message -->
                <div class="fade-in">
                    <div class="glass-effect rounded-2xl p-8 mb-8 restricted-zone border-2">
                        <h2 class="text-3xl md:text-4xl font-bold text-white mb-4">
                            <i class="fas fa-exclamation-triangle warning-flash mr-3"></i>
                            Access Forbidden
                        </h2>
                        <p class="text-lg text-gray-200 mb-6 leading-relaxed">
                            You've entered a restricted area of cyberspace! 
                            Your security clearance is insufficient to access this galactic sector.
                        </p>

                        <!-- Restricted Info -->
                        <div class="bg-red-900/30 rounded-xl p-6 mb-6 border border-red-500/30">
                            <h3 class="text-xl font-semibold text-white mb-3">
                                <i class="fas fa-lock mr-2 text-red-400"></i>
                                Restricted Zone - Clearance Required
                            </h3>
                            <ul class="text-gray-200 space-y-2 text-left max-w-md mx-auto">
                                <li class="flex items-center">
                                    <i class="fas fa-times-circle mr-3 text-red-400"></i>
                                    Insufficient permissions
                                </li>
                                <li class="flex items-center">
                                    <i class="fas fa-times-circle mr-3 text-red-400"></i>
                                    Authentication required
                                </li>
                                <li class="flex items-center">
                                    <i class="fas fa-times-circle mr-3 text-red-400"></i>
                                    Contact administrator
                                </li>
                                <li class="flex items-center">
                                    <i class="fas fa-times-circle mr-3 text-red-400"></i>
                                    Return to safe zone
                                </li>
                            </ul>
                        </div>

                        <!-- Action Buttons -->
                        <div class="flex flex-col sm:flex-row gap-4 justify-center items-center">
                            <button onclick="goHome()" class="hover-lift pulse-glow bg-red-500 hover:bg-red-600 text-white font-bold py-4 px-8 rounded-xl transition-all duration-300 flex items-center gap-3 min-w-[200px] justify-center">
                                <i class="fas fa-home text-lg"></i>
                                Return to Base
                            </button>

                            <button onclick="requestAccess()" class="hover-lift glass-effect hover:bg-white/20 text-white font-bold py-4 px-8 rounded-xl transition-all duration-300 flex items-center gap-3 min-w-[200px] justify-center">
                                <i class="fas fa-key text-lg"></i>
                                Request Access
                            </button>
                        </div>

                        <!-- Contact Admin -->
                        <div class="mt-8 pt-6 border-t border-white/20">
                            <p class="text-gray-300 mb-3">Need higher clearance?</p>
                            <button onclick="contactAdmin()" class="text-yellow-300 hover:text-yellow-200 font-medium transition-colors duration-300 flex items-center gap-2 mx-auto">
                                <i class="fas fa-user-shield"></i>
                                Contact Administrator
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Floating Security Elements -->
                <div class="absolute top-20 left-10 floating opacity-30">
                    <i class="fas fa-satellite-dish text-white text-3xl"></i>
                </div>
                <div class="absolute top-32 right-16 floating opacity-20" style="animation-delay: 1s;">
                    <i class="fas fa-radar text-white text-2xl"></i>
                </div>
                <div class="absolute bottom-32 left-20 floating opacity-25" style="animation-delay: 2s;">
                    <i class="fas fa-shield-virus text-white text-4xl"></i>
                </div>
                <div class="absolute bottom-20 right-10 floating opacity-30" style="animation-delay: 0.5s;">
                    <i class="fas fa-eye text-white text-3xl"></i>
                </div>
            </div>
        </div>

        <script>
            // Create animated stars
            function createStars() {
                const starsContainer = document.getElementById('stars');
                const numberOfStars = 100;

                for (let i = 0; i < numberOfStars; i++) {
                    const star = document.createElement('div');
                    star.className = 'star';
                    star.style.left = Math.random() * 100 + '%';
                    star.style.top = Math.random() * 100 + '%';
                    star.style.animationDelay = Math.random() * 2 + 's';
                    star.style.animationDuration = (Math.random() * 3 + 1) + 's';
                    starsContainer.appendChild(star);
                }
            }

            // Navigation functions
            function goHome() {
                // Customize this path to your actual home page
                window.location.href = '${pageContext.request.contextPath}/';
            }

            function requestAccess() {
                // Customize this to your actual login/access request page
                window.location.href = '${pageContext.request.contextPath}/login';
            }

            function contactAdmin() {
                // Customize this to your actual admin contact page
                window.location.href = '${pageContext.request.contextPath}/contact?type=access';
            }

            // Initialize stars when page loads
            document.addEventListener('DOMContentLoaded', function () {
                createStars();

                // Add some interactive effects
                document.addEventListener('mousemove', function (e) {
                    const stars = document.querySelectorAll('.star');
                    const x = e.clientX / window.innerWidth;
                    const y = e.clientY / window.innerHeight;

                    stars.forEach((star, index) => {
                        if (index % 10 === 0) { // Only affect every 10th star for performance
                            const moveX = (x - 0.5) * 20;
                            const moveY = (y - 0.5) * 20;
                            star.style.transform = `translate(${moveX}px, ${moveY}px)`;
                        }
                    });
                });

                // Add security alert effect
                setInterval(() => {
                    const shield = document.querySelector('.shield i');
                    if (shield) {
                        shield.style.color = '#ef4444';
                        setTimeout(() => {
                            shield.style.color = '#f87171';
                        }, 200);
                    }
                }, 5000);
            });

            // Add keyboard navigation
            document.addEventListener('keydown', function (e) {
                if (e.key === 'Enter' || e.key === ' ') {
                    goHome();
                } else if (e.key === 'Escape') {
                    goHome();
                } else if (e.key === 'r' || e.key === 'R') {
                    requestAccess();
                }
            });

            // Add security scanning effect
            function simulateSecurityScan() {
                const body = document.body;
                body.style.background = 'linear-gradient(135deg, #dc2626 0%, #991b1b 50%, #7f1d1d 100%)';
                setTimeout(() => {
                    body.style.background = 'linear-gradient(135deg, #ef4444 0%, #dc2626 50%, #991b1b 100%)';
                }, 300);
            }

            // Run security scan periodically
            setInterval(simulateSecurityScan, 8000);
        </script>
    </body>
</html>