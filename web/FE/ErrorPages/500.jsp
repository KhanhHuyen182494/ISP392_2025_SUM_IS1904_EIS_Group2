<%-- 
    Document   : 500
    Created on : June 2, 2025
    Author     : Generated from 404 template
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Server Error - 500</title>
        
        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>
        
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        
        <style>
            body {
                background: linear-gradient(135deg, #dc2626 0%, #991b1b 50%, #7c2d12 100%);
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
                    box-shadow: 0 0 20px rgba(239, 68, 68, 0.5);
                }
                to {
                    box-shadow: 0 0 40px rgba(239, 68, 68, 0.8);
                }
            }
            
            .sparks {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: 1;
            }
            
            .spark {
                position: absolute;
                width: 3px;
                height: 3px;
                background: #fbbf24;
                border-radius: 50%;
                animation: sparkle 3s infinite;
            }
            
            @keyframes sparkle {
                0%, 100% { 
                    opacity: 0; 
                    transform: scale(0);
                }
                50% { 
                    opacity: 1; 
                    transform: scale(1);
                }
            }
            
            .error-number {
                font-size: clamp(8rem, 20vw, 16rem);
                background: linear-gradient(45deg, #ef4444, #f87171, #fca5a5);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                text-shadow: 0 0 30px rgba(239, 68, 68, 0.5);
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
            
            .explosion {
                animation: explosionFloat 4s ease-in-out infinite;
            }
            
            @keyframes explosionFloat {
                0%, 100% { 
                    transform: translateY(0px) rotate(-10deg) scale(1); 
                }
                50% { 
                    transform: translateY(-25px) rotate(10deg) scale(1.1); 
                }
            }
            
            .glitch {
                animation: glitch 2s linear infinite;
            }
            
            @keyframes glitch {
                2%, 64% {
                    transform: translate(2px,0) skew(0deg);
                }
                4%, 60% {
                    transform: translate(-2px,0) skew(0deg);
                }
                62% {
                    transform: translate(0,0) skew(5deg); 
                }
            }
        </style>
    </head>
    <body class="">
        <!-- Animated Sparks Background -->
        <div class="sparks" id="sparks"></div>
        
        <div class="min-h-screen flex items-center justify-center relative z-10 px-4">
            <div class="text-center max-w-4xl mx-auto">
                
                <!-- Floating Explosion Icon -->
                <div class="explosion mb-8">
                    <i class="fas fa-exclamation-triangle text-yellow-400 text-6xl opacity-80"></i>
                </div>
                
                <!-- 500 Number -->
                <div class="bounce-in">
                    <h1 class="error-number leading-none mb-4 glitch">500</h1>
                </div>
                
                <!-- Error Message -->
                <div class="fade-in">
                    <div class="glass-effect rounded-2xl p-8 mb-8">
                        <h2 class="text-3xl md:text-4xl font-bold text-white mb-4">
                            Baby, We Have a Problem!
                        </h2>
                        <p class="text-lg text-gray-200 mb-6 leading-relaxed">
                            Our servers are experiencing some technical difficulties. 
                            Our engineering team has been notified and is working to fix the issue.
                        </p>
                        
                        <!-- Error Details -->
                        <div class="bg-red-900/30 rounded-xl p-6 mb-6 border border-red-500/30">
                            <h3 class="text-xl font-semibold text-white mb-3">
                                <i class="fas fa-tools mr-2 text-red-400"></i>
                                What happened:
                            </h3>
                            <ul class="text-gray-200 space-y-2 text-left max-w-md mx-auto">
                                <li class="flex items-center">
                                    <i class="fas fa-circle mr-3 text-red-400 text-xs"></i>
                                    Internal server malfunction detected
                                </li>
                                <li class="flex items-center">
                                    <i class="fas fa-circle mr-3 text-red-400 text-xs"></i>
                                    Engineering team has been alerted
                                </li>
                                <li class="flex items-center">
                                    <i class="fas fa-circle mr-3 text-red-400 text-xs"></i>
                                    System recovery in progress
                                </li>
                                <li class="flex items-center">  
                                    <i class="fas fa-circle mr-3 text-red-400 text-xs"></i>
                                    Expected resolution: shortly
                                </li>
                            </ul>
                        </div>
                        
                        <!-- Action Buttons -->
                        <div class="flex flex-col sm:flex-row gap-4 justify-center items-center">
                            <button onclick="refreshPage()" class="hover-lift pulse-glow bg-red-600 hover:bg-red-700 text-white font-bold py-4 px-8 rounded-xl transition-all duration-300 flex items-center gap-3 min-w-[200px] justify-center">
                                <i class="fas fa-sync-alt text-lg"></i>
                                Try Again
                            </button>
                            
                            <button onclick="goHome()" class="hover-lift glass-effect hover:bg-white/20 text-white font-bold py-4 px-8 rounded-xl transition-all duration-300 flex items-center gap-3 min-w-[200px] justify-center">
                                <i class="fas fa-home text-lg"></i>
                                Go Home
                            </button>
                        </div>
                        
                        <!-- Contact Support -->
                        <div class="mt-8 pt-6 border-t border-white/20">
                            <p class="text-gray-300 mb-3">Issue persists?</p>
                            <button onclick="contactSupport()" class="text-red-300 hover:text-red-200 font-medium transition-colors duration-300 flex items-center gap-2 mx-auto">
                                <i class="fas fa-bug"></i>
                                Report Issue
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Floating Elements -->
                <div class="absolute top-20 left-10 floating opacity-30">
                    <i class="fas fa-fire text-orange-400 text-3xl"></i>
                </div>
                <div class="absolute top-32 right-16 floating opacity-20" style="animation-delay: 1s;">
                    <i class="fas fa-bolt text-yellow-400 text-2xl"></i>
                </div>
                <div class="absolute bottom-32 left-20 floating opacity-25" style="animation-delay: 2s;">
                    <i class="fas fa-cog text-gray-400 text-4xl"></i>
                </div>
                <div class="absolute bottom-20 right-10 floating opacity-30" style="animation-delay: 0.5s;">
                    <i class="fas fa-server text-red-400 text-3xl"></i>
                </div>
            </div>
        </div>
        
        <script>
            // Create animated sparks
            function createSparks() {
                const sparksContainer = document.getElementById('sparks');
                const numberOfSparks = 80;
                
                for (let i = 0; i < numberOfSparks; i++) {
                    const spark = document.createElement('div');
                    spark.className = 'spark';
                    spark.style.left = Math.random() * 100 + '%';
                    spark.style.top = Math.random() * 100 + '%';
                    spark.style.animationDelay = Math.random() * 3 + 's';
                    spark.style.animationDuration = (Math.random() * 2 + 2) + 's';
                    sparksContainer.appendChild(spark);
                }
            }
            
            // Navigation functions
            function refreshPage() {
                window.location.reload();
            }
            
            function goHome() {
                // Customize this path to your actual home page
                window.location.href = '${pageContext.request.contextPath}/';
            }
            
            function contactSupport() {
                // Customize this to your actual contact/support page
                window.location.href = '${pageContext.request.contextPath}/contact';
            }
            
            // Initialize sparks when page loads
            document.addEventListener('DOMContentLoaded', function() {
                createSparks();
                
                // Add some interactive effects
                document.addEventListener('mousemove', function(e) {
                    const sparks = document.querySelectorAll('.spark');
                    const x = e.clientX / window.innerWidth;
                    const y = e.clientY / window.innerHeight;
                    
                    sparks.forEach((spark, index) => {
                        if (index % 8 === 0) { // Only affect every 8th spark for performance
                            const moveX = (x - 0.5) * 15;
                            const moveY = (y - 0.5) * 15;
                            spark.style.transform = `translate(${moveX}px, ${moveY}px)`;
                        }
                    });
                });
            });
            
            // Add keyboard navigation
            document.addEventListener('keydown', function(e) {
                if (e.key === 'Enter' || e.key === ' ') {
                    refreshPage();
                } else if (e.key === 'Escape') {
                    goHome();
                } else if (e.key === 'r' || e.key === 'R') {
                    refreshPage();
                }
            });
            
            // Auto-refresh after 30 seconds (optional)
            setTimeout(function() {
                const autoRefresh = confirm('The page will refresh automatically. Continue?');
                if (autoRefresh) {
                    refreshPage();
                }
            }, 30000);
        </script>
    </body>
</html>