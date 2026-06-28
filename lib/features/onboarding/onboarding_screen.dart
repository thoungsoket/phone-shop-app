import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../auth/auth_service.dart';

class OnboardingData {
  final String imagePath;
  final String titleNormal;
  final String titleHighlight;
  final String description;

  OnboardingData({
    required this.imagePath,
    required this.titleNormal,
    required this.titleHighlight,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentStep = -1; 
  final PageController _pageController = PageController();

  final List<OnboardingData> _pages = [
    OnboardingData(
      imagePath: 'assets/images/onboarding_phone.png',
      titleNormal: 'Discover Latest\n',
      titleHighlight: 'Smartphones',
      description: 'Explore the newest models with cutting-edge technology and premium designs, all in one place.',
    ),
    OnboardingData(
      imagePath: 'assets/images/onboarding_compare.png',
      titleNormal: 'Compare Phones\n',
      titleHighlight: 'Easily',
      description: 'Put devices side-by-side to compare specs, prices, and features to find your perfect match.',
    ),
    OnboardingData(
      imagePath: 'assets/images/onboarding_store.png',
      titleNormal: 'Reserve & Buy In\n',
      titleHighlight: 'Store',
      description: 'Skip the line. Reserve your favorite devices online and pick them up at a PhoneHub location near you.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _currentStep = 0;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildMeshBackground(),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _currentStep == -1 
                ? _buildScreen1Splash() 
                : _buildSliderLayout(),
          ),
        ],
      ),
    );
  }

  Widget _buildScreen1Splash() {
    return Center(
      key: const ValueKey('screen_1_splash'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(36),
              border: Border.all(color: Colors.white.withOpacity(0.6), width: 1.5),
            ),
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.06),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              padding: const EdgeInsets.all(26),
              child: _buildLogoGraphic(),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'PhoneHub',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0A40A4),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white),
            ),
            child: const Text(
              'Premium Tech, Delivered.',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF5C6B73)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderLayout() {
    double screenHeight = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    bool isLastPage = _currentStep == _pages.length - 1;

    return PageView.builder(
      controller: _pageController,
      itemCount: _pages.length,
      onPageChanged: (index) {
        setState(() {
          _currentStep = index;
        });
      },
      itemBuilder: (context, index) {
        final page = _pages[index];
        bool localIsLastPage = index == _pages.length - 1;

        return Container(
          margin: EdgeInsets.only(top: statusBarHeight),
          child: Column(
            children: [
              if (!isLastPage)
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      _pageController.jumpToPage(_pages.length - 1);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black.withOpacity(0.04),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                ),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.45,
                        child: Image.asset(
                          page.imagePath,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.phone_android, size: 120, color: Color(0xFF007BF6));
                          },
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1A1A1A),
                                  height: 1.2,
                                ),
                                children: [
                                  TextSpan(text: page.titleNormal),
                                  TextSpan(
                                    text: page.titleHighlight,
                                    style: const TextStyle(color: Color(0xFF007BF6)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            
                            Text(
                              page.description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14, color: Color(0xFF656E77), height: 1.4),
                            ),
                            
                            const SizedBox(height: 24),
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                _pages.length,
                                (dotIndex) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  margin: const EdgeInsets.symmetric(horizontal: 6),
                                  height: 8,
                                  width: _currentStep == dotIndex ? 24 : 8,
                                  decoration: BoxDecoration(
                                    color: _currentStep == dotIndex
                                        ? const Color(0xFF007BF6)
                                        : const Color(0xFFE0E0E0),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 24),
                            
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (localIsLastPage) {
                                    // This now navigates to your new home screen
                                    await AuthService.instance.completeOnboarding();

                                      if (!context.mounted) return;

                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/login',
                                        (route) => false,
                                      );
                                  } else {
                                    _pageController.nextPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF007BF6),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                child: Text(
                                  localIsLastPage ? 'Get Started' : 'Next',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMeshBackground() {
    return Stack(
      children: [
        Container(color: const Color(0xFFF7F9FC)),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.22,
          left: MediaQuery.of(context).size.width * 0.05,
          child: Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF90CAF9).withOpacity(0.35),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.38,
          right: MediaQuery.of(context).size.width * 0.05,
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE3F2FD).withOpacity(0.4),
            ),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: const SizedBox(),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoGraphic() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF42A5F5), Color(0xFF007BF6)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(3, (index) => Container(
            margin: const EdgeInsets.symmetric(vertical: 2.5),
            height: 4,
            width: index == 2 ? 16 : 26,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2)),
          )),
          const SizedBox(height: 10),
          Container(
            height: 6,
            width: 6,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}