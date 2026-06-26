import 'package:flutter/material.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/home/home_screen.dart';
import 'features/compare/compare_screen.dart';
import 'features/favorites/favorites_screen.dart';
import 'features/cart/cart_screen.dart';
import 'features/checkout/checkout_screen.dart';
import 'features/checkout/order_success_screen.dart';
import 'features/promotions/promotions_screen.dart';
import 'features/nearby/nearby_screen.dart';
import 'features/map/map_screen.dart';
import 'features/category/category_screen.dart';
import 'features/detail/product_detail_screen.dart';
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
        '/favorites': (context) => const FavoritesScreen(),
        '/cart': (context) => const CartScreen(),
        '/checkout': (context) => const CheckoutScreen(),
        '/order-success': (context) => const OrderSuccessScreen(),
        '/promotions': (context) => const PromotionsScreen(),
        '/nearby': (context) => const NearbyScreen(),
        '/map': (context) => const MapScreen(),
        '/category': (context) => const CategoryScreen(
          categoryName: 'Smartphones',
        ),
      },
      onGenerateRoute: (settings) {
        // Handle routes with parameters
        if (settings.name == '/product-detail') {
          final product = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          );
        }
        if (settings.name == '/category') {
          final args = settings.arguments as Map<String, dynamic>?;
          return MaterialPageRoute(
            builder: (context) => CategoryScreen(
              categoryName: args?['categoryName'] ?? 'Smartphones',
              initialFilter: args?['initialFilter'],
              searchQuery: args?['searchQuery'],
            ),
          );
        }
        return null;
      },
    );
  }
}