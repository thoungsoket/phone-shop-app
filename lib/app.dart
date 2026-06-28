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
import 'features/profile/profile_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/booking/booking_screen.dart';
import 'features/repair_tracker/repair_tracker_screen.dart';
import 'features/chat/chat_screen.dart';
import 'features/reviews/reviews_screen.dart';
import 'features/gallery/gallery_screen.dart';
import 'features/common/phonehub_store.dart';
import 'theme/app_theme.dart';
import 'features/auth/auth_service.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/register_screen.dart';

class PhoneShopApp extends StatelessWidget {
  const PhoneShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: PhoneHubStore.instance,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Phone Shop App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: PhoneHubStore.instance.darkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          initialRoute: AuthService.instance.hasSeenOnboarding
          ? (AuthService.instance.isLoggedIn ? '/home' : '/login')
          : '/onboarding',
          routes: {
            '/onboarding': (context) => const OnboardingScreen(),
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const RegisterScreen(),
            '/home': (context) => const HomeScreen(),
            '/compare': (context) => const CompareScreen(),
            '/favorites': (context) => const FavoritesScreen(),
            '/cart': (context) => const CartScreen(),
            '/checkout': (context) => const CheckoutScreen(),
            '/order-success': (context) => const OrderSuccessScreen(),
            '/promotions': (context) => const PromotionsScreen(),
            '/nearby': (context) => const NearbyScreen(),
            '/map': (context) => const MapScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/settings': (context) => const SettingsScreen(),
            '/booking': (context) => const BookingScreen(),
            '/book-repair': (context) => const BookingScreen(),
            '/repair-tracker': (context) => const RepairTrackerScreen(),
            '/chat': (context) => const ChatScreen(),
            '/reviews': (context) => const ReviewsScreen(),
            '/gallery': (context) => const GalleryScreen(),
          },
          onGenerateRoute: (settings) {
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
      },
    );
  }
}