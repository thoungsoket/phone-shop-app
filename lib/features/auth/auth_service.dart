import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/phonehub_store.dart';
import 'user_model.dart';

class AuthService extends ChangeNotifier {
  static final AuthService instance = AuthService._internal();

  AuthService._internal();

  bool initialized = false;
  bool hasSeenOnboarding = false;
  bool isLoggedIn = false;
  bool rememberMe = true;

  UserModel? currentUser;
  final List<UserModel> _users = [];

  List<UserModel> get users => List.unmodifiable(_users);

  Future<void> init() async {
    if (initialized) return;

    final prefs = await SharedPreferences.getInstance();

    hasSeenOnboarding = prefs.getBool('auth_seen_onboarding') ?? false;
    isLoggedIn = prefs.getBool('auth_logged_in') ?? false;
    rememberMe = prefs.getBool('auth_remember_me') ?? true;

    _users
      ..clear()
      ..addAll(
        (prefs.getStringList('auth_users') ?? []).map(UserModel.decode),
      );

    final currentEmail = prefs.getString('auth_current_email');

    if (currentEmail != null && currentEmail.isNotEmpty) {
      currentUser = _users.where((u) => u.email == currentEmail).firstOrNull;
    }

    if (!rememberMe) {
      isLoggedIn = false;
    }

    initialized = true;
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('auth_seen_onboarding', hasSeenOnboarding);
    await prefs.setBool('auth_logged_in', isLoggedIn);
    await prefs.setBool('auth_remember_me', rememberMe);
    await prefs.setStringList(
      'auth_users',
      _users.map((u) => u.encode()).toList(),
    );

    if (currentUser != null) {
      await prefs.setString('auth_current_email', currentUser!.email);
    }
  }

  Future<void> completeOnboarding() async {
    hasSeenOnboarding = true;
    notifyListeners();
    await _save();
  }

  Future<String?> register({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final cleanName = fullName.trim();
    final cleanEmail = email.trim().toLowerCase();
    final cleanPassword = password.trim();

    if (cleanName.isEmpty || cleanEmail.isEmpty || cleanPassword.isEmpty) {
      return 'Please fill in all fields.';
    }

    if (!cleanEmail.contains('@')) {
      return 'Please enter a valid email.';
    }

    if (cleanPassword.length < 6) {
      return 'Password must be at least 6 characters.';
    }

    if (cleanPassword != confirmPassword.trim()) {
      return 'Passwords do not match.';
    }

    final exists = _users.any((u) => u.email == cleanEmail);
    if (exists) {
      return 'This email is already registered.';
    }

    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: cleanName,
      email: cleanEmail,
      password: cleanPassword,
      phone: '+855 12 345 678',
      address: 'Phnom Penh, Cambodia',
      payment: 'Visa •••• 2048',
      avatarIndex: 0,
    );

    _users.add(user);
    currentUser = user;
    isLoggedIn = true;
    rememberMe = true;

    notifyListeners();
    await _save();

    await PhoneHubStore.instance.switchUserData();

    return null;
  }

  Future<String?> login({
    required String email,
    required String password,
    required bool remember,
  }) async {
    final cleanEmail = email.trim().toLowerCase();
    final cleanPassword = password.trim();

    if (cleanEmail.isEmpty || cleanPassword.isEmpty) {
      return 'Please enter your email and password.';
    }

    final matches = _users.where(
      (u) => u.email == cleanEmail && u.password == cleanPassword,
    );

    if (matches.isEmpty) {
      return 'Invalid email or password.';
    }

    currentUser = matches.first;
    isLoggedIn = true;
    rememberMe = remember;

    notifyListeners();
    await _save();

    await PhoneHubStore.instance.switchUserData();

    return null;
  }

  Future<void> logout() async {
    isLoggedIn = false;
    currentUser = null;

    await PhoneHubStore.instance.switchUserData();

    notifyListeners();
    await _save();
  }
  Future<void> updateCurrentUser(UserModel user) async {
    currentUser = user;

    final index = _users.indexWhere((u) => u.id == user.id);

    if (index != -1) {
      _users[index] = user;
    }

    notifyListeners();
    await _save();

    await PhoneHubStore.instance.switchUserData();
  }

  Future<void> saveCurrentUser() async {
    if (currentUser == null) return;

    final index = _users.indexWhere((u) => u.id == currentUser!.id);

    if (index != -1) {
      _users[index] = currentUser!;
    }

    notifyListeners();
    await _save();
  }
}