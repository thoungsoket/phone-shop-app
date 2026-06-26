import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'features/favorites/favorites_screen.dart';
import 'features/nearby/nearby_screen.dart';
import 'features/map/map_screen.dart';
import 'features/promotions/promotions_screen.dart';
import 'features/cart/cart_screen.dart';
import 'features/checkout/checkout_screen.dart';
import 'features/checkout/order_success_screen.dart';

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
      home: const AppScreen(),
    );
  }
}

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
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}