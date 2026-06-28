import 'package:flutter/material.dart';

import '../common/phonehub_ui.dart';
import 'auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool rememberMe = true;
  bool showPassword = false;
  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() => loading = true);

    final error = await AuthService.instance.login(
      email: emailController.text,
      password: passwordController.text,
      remember: rememberMe,
    );

    setState(() => loading = false);

    if (!mounted) return;

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      return;
    }

    Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return PhoneHubPageShell(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(22, 32, 22, 28),
        children: [
          const Text(
            'PhoneHub',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: PhoneHubColors.blue,
              fontSize: 34,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Welcome back. Login to continue.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: PhoneHubColors.textGray,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 28),

          PhoneHubCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(
                  Icons.lock_person_rounded,
                  color: PhoneHubColors.blue,
                  size: 54,
                ),
                const SizedBox(height: 18),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 14),

                TextField(
                  controller: passwordController,
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() => showPassword = !showPassword);
                      },
                      icon: Icon(
                        showPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      activeColor: PhoneHubColors.blue,
                      onChanged: (value) {
                        setState(() => rememberMe = value ?? true);
                      },
                    ),
                    const Text(
                      'Remember me',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                PhoneHubGradientButton(
                  text: loading ? 'Logging in...' : 'Login',
                  onTap: loading ? () {} : _login,
                ),

                const SizedBox(height: 16),

                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: const Text(
                    "Don't have an account? Create account",
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}