<%-- 
    Document   : 404
    Created on : May 26, 2025, 7:26:28 PM
    Author     : Huyen
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Page Not Found - 404</title>
        
        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>
        
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        
        <style>
            body {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            }
            
            .floating {
                animation: floating 3s ease-in-out infinite;
            }
            
            @keyframes floating {
                0%, 100% { transform: translateY(0px); }
                50% { transform: translateY(-20px); }
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
                    box-shadow: 0 0 20px rgba(249, 115, 22, 0.5);
                }
                to {
                    box-shadow: 0 0 40px rgba(249, 115, 22, 0.8);
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
                0%, 100% { opacity: 0; }
                50% { opacity: 1; }
            }
            
            .error-number {
                font-size: clamp(8rem, 20vw, 16rem);
                background: linear-gradient(45deg, #f97316, #fb923c, #fdba74);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                text-shadow: 0 0 30px rgba(249, 115, 22, 0.5);
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
            
            .astronaut {
                animation: astronautFloat 4s ease-in-out infinite;
            }
            
            @keyframes astronautFloat {
                0%, 100% { 
                    transform: translateY(0px) rotate(-5deg); 
                }
                50% { 
                    transform: translateY(-30px) rotate(5deg); 
                }
            }
        </style>
    </head>
    <body class="overflow-hidden">
        <!-- Animated Stars Background -->
        <div class="stars" id="stars"></div>
        
        <div class="min-h-screen flex items-center justify-center relative z-10 px-4">
            <div class="text-center max-w-4xl mx-auto">
                
                <!-- Floating Astronaut Icon -->
                <div class="astronaut mb-8">
                    <i class="fas fa-rocket text-white text-6xl opacity-80"></i>
                </div>
                
                <!-- 404 Number -->
                <div class="bounce-in">
                    <h1 class="error-number leading-none mb-4">404</h1>
                </div>
                
                <!-- Error Message -->
                <div class="fade-in">
                    <div class="glass-effect rounded-2xl p-8 mb-8">
                        <h2 class="text-3xl md:text-4xl font-bold text-white mb-4">
                            Oops! Page Not Found
                        </h2>
                        <p class="text-lg text-gray-200 mb-6 leading-relaxed">
                            The page you're looking for seems to have drifted into space. 
                            Don't worry, even astronauts get lost sometimes!
                        </p>
                        
                        <!-- Search Suggestions -->
                        <div class="bg-white/10 rounded-xl p-6 mb-6">
                            <h3 class="text-xl font-semibold text-white mb-3">
                                <i class="fas fa-lightbulb mr-2 text-yellow-300"></i>
                                What you can do:
                            </h3>
                            <ul class="text-gray-200 space-y-2 text-left max-w-md mx-auto">
                                <li class="flex items-center">
                                    <i class="fas fa-check-circle mr-3 text-green-400"></i>
                                    Check the URL for typos
                                </li>
                                <li class="flex items-center">
                                    <i class="fas fa-check-circle mr-3 text-green-400"></i>
                                    Go back to the previous page
                                </li>
                                <li class="flex items-center">
                                    <i class="fas fa-check-circle mr-3 text-green-400"></i>
                                    Visit our homepage
                                </li>
                                <li class="flex items-center">
                                    <i class="fas fa-check-circle mr-3 text-green-400"></i>
                                    Contact support if needed
                                </li>
                            </ul>
                        </div>
                        
                        <!-- Action Buttons -->
                        <div class="flex flex-col sm:flex-row gap-4 justify-center items-center">
                            <button onclick="goHome()" class="hover-lift pulse-glow bg-orange-500 hover:bg-orange-600 text-white font-bold py-4 px-8 rounded-xl transition-all duration-300 flex items-center gap-3 min-w-[200px] justify-center">
                                <i class="fas fa-home text-lg"></i>
                                Go Home
                            </button>
                            
                            <button onclick="goBack()" class="hover-lift glass-effect hover:bg-white/20 text-white font-bold py-4 px-8 rounded-xl transition-all duration-300 flex items-center gap-3 min-w-[200px] justify-center">
                                <i class="fas fa-arrow-left text-lg"></i>
                                Go Back
                            </button>
                        </div>
                        
                        <!-- Contact Support -->
                        <div class="mt-8 pt-6 border-t border-white/20">
                            <p class="text-gray-300 mb-3">Still having trouble?</p>
                            <button onclick="contactSupport()" class="text-orange-300 hover:text-orange-200 font-medium transition-colors duration-300 flex items-center gap-2 mx-auto">
                                <i class="fas fa-headset"></i>
                                Contact Support
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Floating Elements -->
                <div class="absolute top-20 left-10 floating opacity-30">
                    <i class="fas fa-satellite text-white text-3xl"></i>
                </div>
                <div class="absolute top-32 right-16 floating opacity-20" style="animation-delay: 1s;">
                    <i class="fas fa-meteor text-white text-2xl"></i>
                </div>
                <div class="absolute bottom-32 left-20 floating opacity-25" style="animation-delay: 2s;">
                    <i class="fas fa-space-shuttle text-white text-4xl"></i>
                </div>
                <div class="absolute bottom-20 right-10 floating opacity-30" style="animation-delay: 0.5s;">
                    <i class="fas fa-moon text-white text-3xl"></i>
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
            
            function goBack() {
                if (window.history.length > 1) {
                    window.history.back();
                } else {
                    goHome();
                }
            }
            
            function contactSupport() {
                // Customize this to your actual contact/support page
                window.location.href = '${pageContext.request.contextPath}/contact';
            }
            
            // Initialize stars when page loads
            document.addEventListener('DOMContentLoaded', function() {
                createStars();
                
                // Add some interactive effects
                document.addEventListener('mousemove', function(e) {
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
            });
            
            // Add keyboard navigation
            document.addEventListener('keydown', function(e) {
                if (e.key === 'Enter' || e.key === ' ') {
                    goHome();
                } else if (e.key === 'Escape') {
                    goBack();
                }
            });
        </script>
    </body>
</html>