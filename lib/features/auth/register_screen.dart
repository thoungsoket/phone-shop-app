import 'package:flutter/material.dart';

import '../common/phonehub_ui.dart';
import 'auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool showPassword = false;
  bool loading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    setState(() => loading = true);

    final error = await AuthService.instance.register(
      fullName: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmController.text,
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
        padding: const EdgeInsets.fromLTRB(22, 28, 22, 28),
        children: [
          const Text(
            'Create Account',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: PhoneHubColors.blue,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Join PhoneHub and manage your orders, repairs, and saved media.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: PhoneHubColors.textGray,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),

          PhoneHubCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(
                  Icons.person_add_alt_1_rounded,
                  color: PhoneHubColors.blue,
                  size: 54,
                ),
                const SizedBox(height: 18),

                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full name',
                    prefixIcon: Icon(Icons.person_outline_rounded),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 14),

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
                const SizedBox(height: 14),

                TextField(
                  controller: confirmController,
                  obscureText: !showPassword,
                  decoration: const InputDecoration(
                    labelText: 'Confirm password',
                    prefixIcon: Icon(Icons.lock_reset_rounded),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 18),

                PhoneHubGradientButton(
                  text: loading ? 'Creating account...' : 'Register',
                  onTap: loading ? () {} : _register,
                ),

                const SizedBox(height: 16),

                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Already have an account? Login',
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