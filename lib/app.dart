import 'package:flutter/material.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/home/home_screen.dart';
import 'features/compare/compare_screen.dart';
// import 'features/favorites/favorites_screen.dart';
import 'theme/app_theme.dart';

class PhoneShopApp extends StatelessWidget {
  const PhoneShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phone Shop App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const OnboardingScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/compare': (context) => const CompareScreen(),
        // '/favorites': (context) => const FavoritesScreen(),
      },
      onGenerateRoute: (settings) {
        return null;
      },
    );
  }
}