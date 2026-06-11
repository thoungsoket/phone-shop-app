import 'package:flutter/material.dart';
import 'features/onboarding/onboarding_screen.dart'; // Imported Onboarding Features
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
      // Point home to OnboardingScreen to launch Screen 1 (Splash) first
      home: const OnboardingScreen(), 
    );
  }
}

// Your main post-onboarding landing screen interface placeholder
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Shop'),
      ),
      body: const Center(
        child: Text(
          'Welcome to Phone Shop App 🚀',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}