import 'package:flutter/material.dart';


class PhoneHubColors {
  static const blue = Color(0xFF2563EB);
  static const cyan = Color(0xFF00C2FF);
  static const background = Color(0xFFF5F8FC);
  static const card = Color(0xFFFFFFFF);
  static const softCard = Color(0xFFF2F4F6);
  static const textDark = Color(0xFF0F172A);
  static const textGray = Color(0xFF64748B);
  static const border = Color(0xFFE5E7EB);
}

class PhoneHubCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const PhoneHubCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: PhoneHubColors.card.withOpacity(0.92),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.4)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(37, 99, 235, 0.05),
            blurRadius: 32,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class PhoneHubGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const PhoneHubGradientButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [PhoneHubColors.blue, PhoneHubColors.cyan],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PhoneHubPageShell extends StatelessWidget {
  final Widget child;
  final bool showBottomNav;
  final int currentIndex;

  const PhoneHubPageShell({
    super.key,
    required this.child,
    this.showBottomNav = false,
    this.currentIndex = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PhoneHubColors.background,
      body: SafeArea(
        child: child,
      ),
      bottomNavigationBar: showBottomNav
          ? BottomNavigationBar(
              currentIndex: currentIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: PhoneHubColors.blue,
              unselectedItemColor: const Color(0xFF94A3B8),
              selectedFontSize: 11,
              unselectedFontSize: 11,
              onTap: (index) {
                if (index == 0) Navigator.pushNamed(context, '/home');
                if (index == 1) Navigator.pushNamed(context, '/compare');
                if (index == 2) Navigator.pushNamed(context, '/favorites');
                if (index == 3) Navigator.pushNamed(context, '/nearby');
                if (index == 4) Navigator.pushNamed(context, '/profile');
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.compare_arrows_rounded), label: 'Compare'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite_border_rounded), label: 'Favorites'),
                BottomNavigationBarItem(icon: Icon(Icons.storefront_rounded), label: 'Nearby'),
                BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
              ],
            )
          : null,
    );
  }
}