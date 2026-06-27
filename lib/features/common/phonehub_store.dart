import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepairBooking {
  final String id;
  final String service;
  final String device;
  final String date;
  final String time;
  final String price;
  final double progress;
  final String status;

  const RepairBooking({
    required this.id,
    required this.service,
    required this.device,
    required this.date,
    required this.time,
    required this.price,
    required this.progress,
    required this.status,
  });

  String encode() {
    return [
      id,
      service,
      device,
      date,
      time,
      price,
      progress.toString(),
      status,
    ].join('¦');
  }

  static RepairBooking decode(String value) {
    final p = value.split('¦');
    return RepairBooking(
      id: p.isNotEmpty ? p[0] : 'RP-0000',
      service: p.length > 1 ? p[1] : 'Repair Service',
      device: p.length > 2 ? p[2] : 'Customer Device',
      date: p.length > 3 ? p[3] : 'Today',
      time: p.length > 4 ? p[4] : '09:00',
      price: p.length > 5 ? p[5] : '\$0',
      progress: p.length > 6 ? double.tryParse(p[6]) ?? .15 : .15,
      status: p.length > 7 ? p[7] : 'Booked',
    );
  }
}

class ReviewModel {
  final String name;
  final String product;
  final int rating;
  final String text;
  final String date;

  const ReviewModel({
    required this.name,
    required this.product,
    required this.rating,
    required this.text,
    required this.date,
  });

  String encode() {
    return [name, product, rating.toString(), text, date].join('¦');
  }

  static ReviewModel decode(String value) {
    final p = value.split('¦');
    return ReviewModel(
      name: p.isNotEmpty ? p[0] : 'Customer',
      product: p.length > 1 ? p[1] : 'PhoneHub Service',
      rating: p.length > 2 ? int.tryParse(p[2]) ?? 5 : 5,
      text: p.length > 3 ? p[3] : 'Great service.',
      date: p.length > 4 ? p[4] : 'Now',
    );
  }
}

class ChatMessage {
  final bool me;
  final String text;
  final String time;

  const ChatMessage({
    required this.me,
    required this.text,
    required this.time,
  });

  String encode() {
    return [me ? '1' : '0', text, time].join('¦');
  }

  static ChatMessage decode(String value) {
    final p = value.split('¦');
    return ChatMessage(
      me: p.isNotEmpty && p[0] == '1',
      text: p.length > 1 ? p[1] : '',
      time: p.length > 2 ? p[2] : 'Now',
    );
  }
}

class PhoneHubStore extends ChangeNotifier {
  static final PhoneHubStore instance = PhoneHubStore._internal();

  PhoneHubStore._internal();

  bool initialized = false;

  String fullName = 'Alex Tech';
  String email = 'alex.tech@email.com';
  String phone = '+855 12 345 678';
  String address = 'Phnom Penh, Cambodia';
  String payment = 'Visa •••• 2048';
  int avatarIndex = 0;

  bool pushNotifications = true;
  bool darkMode = false;
  bool biometricLogin = true;
  bool promotionalEmails = false;

  final List<RepairBooking> bookings = [];
  final List<ReviewModel> reviews = [];
  final List<ChatMessage> messages = [];
  final Set<String> favoriteGallery = {};

  Future<void> init() async {
    if (initialized) return;

    final prefs = await SharedPreferences.getInstance();

    fullName = prefs.getString('ph_fullName') ?? fullName;
    email = prefs.getString('ph_email') ?? email;
    phone = prefs.getString('ph_phone') ?? phone;
    address = prefs.getString('ph_address') ?? address;
    payment = prefs.getString('ph_payment') ?? payment;
    avatarIndex = prefs.getInt('ph_avatarIndex') ?? avatarIndex;

    pushNotifications = prefs.getBool('ph_push') ?? true;
    darkMode = prefs.getBool('ph_dark') ?? false;
    biometricLogin = prefs.getBool('ph_bio') ?? true;
    promotionalEmails = prefs.getBool('ph_promo') ?? false;

    bookings
      ..clear()
      ..addAll(
        (prefs.getStringList('ph_bookings') ??
                [
                  const RepairBooking(
                    id: 'RP-2048',
                    service: 'Screen Replacement',
                    device: 'iPhone 15 Pro',
                    date: 'Tue 25',
                    time: '13:00',
                    price: '\$89',
                    progress: .72,
                    status: 'In Progress',
                  ).encode(),
                ])
            .map(RepairBooking.decode),
      );

    reviews
      ..clear()
      ..addAll(
        (prefs.getStringList('ph_reviews') ??
                [
                  const ReviewModel(
                    name: 'Sokha Rin',
                    product: 'iPhone 16 Pro Max',
                    rating: 5,
                    date: '2 days ago',
                    text: 'Excellent service and fast delivery.',
                  ).encode(),
                  const ReviewModel(
                    name: 'Dara Chen',
                    product: 'Screen Repair',
                    rating: 5,
                    date: '1 week ago',
                    text: 'The repair was quick and professional.',
                  ).encode(),
                ])
            .map(ReviewModel.decode),
      );

    messages
      ..clear()
      ..addAll(
        (prefs.getStringList('ph_messages') ??
                [
                  const ChatMessage(
                    me: false,
                    text: 'Hello! Welcome to PhoneHub Support 👋',
                    time: '09:30',
                  ).encode(),
                  const ChatMessage(
                    me: false,
                    text:
                        'I can help with repairs, prices, warranty, delivery, payment, and store location.',
                    time: '09:31',
                  ).encode(),
                ])
            .map(ChatMessage.decode),
      );

    favoriteGallery
      ..clear()
      ..addAll(prefs.getStringList('ph_gallery_favorites') ?? []);

    initialized = true;
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('ph_fullName', fullName);
    await prefs.setString('ph_email', email);
    await prefs.setString('ph_phone', phone);
    await prefs.setString('ph_address', address);
    await prefs.setString('ph_payment', payment);
    await prefs.setInt('ph_avatarIndex', avatarIndex);

    await prefs.setBool('ph_push', pushNotifications);
    await prefs.setBool('ph_dark', darkMode);
    await prefs.setBool('ph_bio', biometricLogin);
    await prefs.setBool('ph_promo', promotionalEmails);

    await prefs.setStringList(
      'ph_bookings',
      bookings.map((e) => e.encode()).toList(),
    );
    await prefs.setStringList(
      'ph_reviews',
      reviews.map((e) => e.encode()).toList(),
    );
    await prefs.setStringList(
      'ph_messages',
      messages.map((e) => e.encode()).toList(),
    );
    await prefs.setStringList(
      'ph_gallery_favorites',
      favoriteGallery.toList(),
    );
  }

  String nowTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  void updateProfile({
    required String name,
    required String newEmail,
    required String newPhone,
  }) {
    if (name.trim().isNotEmpty) fullName = name.trim();
    if (newEmail.trim().isNotEmpty) email = newEmail.trim();
    if (newPhone.trim().isNotEmpty) phone = newPhone.trim();
    notifyListeners();
    _save();
  }

  void updateAvatar(int index) {
    avatarIndex = index;
    notifyListeners();
    _save();
  }

  void updateAddress(String value) {
    if (value.trim().isEmpty) return;
    address = value.trim();
    notifyListeners();
    _save();
  }

  void updatePayment(String value) {
    if (value.trim().isEmpty) return;
    payment = value.trim();
    notifyListeners();
    _save();
  }

  void updatePreference(String key, bool value) {
    if (key == 'push') pushNotifications = value;
    if (key == 'dark') darkMode = value;
    if (key == 'bio') biometricLogin = value;
    if (key == 'promo') promotionalEmails = value;
    notifyListeners();
    _save();
  }

  void addBooking({
    required String service,
    required String date,
    required String time,
    required String price,
    String device = 'Customer Device',
  }) {
    bookings.insert(
      0,
      RepairBooking(
        id: 'RP-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
        service: service,
        device: device.trim().isEmpty ? 'Customer Device' : device.trim(),
        date: date,
        time: time,
        price: price,
        progress: .15,
        status: 'Booked',
      ),
    );
    notifyListeners();
    _save();
  }

  void addMessage(String text) {
    if (text.trim().isEmpty) return;

    final clean = text.trim();

    messages.add(ChatMessage(me: true, text: clean, time: nowTime()));
    messages.add(ChatMessage(me: false, text: smartReply(clean), time: nowTime()));

    notifyListeners();
    _save();
  }

  String smartReply(String message) {
    final text = message.toLowerCase();

    if (text.contains('hi') || text.contains('hello') || text.contains('hey')) {
      return 'Hello 👋 Welcome to PhoneHub. You can ask about repair status, repair price, warranty, delivery, payment, or store location.';
    }

    if (text.contains('repair') ||
        text.contains('track') ||
        text.contains('status')) {
      if (bookings.isEmpty) {
        return 'You do not have an active repair yet. Please open Booking and choose a repair service first.';
      }

      final latest = bookings.first;

      return 'Repair update: ${latest.service}, Ticket ${latest.id}, status: ${latest.status}, ${(latest.progress * 100).round()}% completed. Scheduled on ${latest.date} at ${latest.time}.';
    }

    if (text.contains('price') ||
        text.contains('cost') ||
        text.contains('screen') ||
        text.contains('battery')) {
      return 'Repair price guide: Screen Repair \$89, Battery \$49, Camera \$69, Speaker \$39. Final price depends on your model and inspection.';
    }

    if (text.contains('payment') ||
        text.contains('card') ||
        text.contains('pay')) {
      return 'We support cash, cards, and digital wallets. Your saved method is $payment.';
    }

    if (text.contains('warranty')) {
      return 'Warranty usually covers manufacturer defects. Physical damage and water damage may require paid repair.';
    }

    if (text.contains('delivery') || text.contains('shipping')) {
      return 'Delivery normally takes 1–3 business days in Phnom Penh. Your saved address is $address.';
    }

    if (text.contains('location') ||
        text.contains('store') ||
        text.contains('branch')) {
      return 'You can check nearby branches from the Nearby page. The default branch is Phnom Penh Branch.';
    }

    if (text.contains('thank')) {
      return 'You are welcome! 😊 Let me know if you need anything else.';
    }

    return 'Thanks for your message. I can help with repairs, prices, warranty, delivery, payment, and store information.';
  }

  void addReview({
    required String product,
    required int rating,
    required String text,
  }) {
    reviews.insert(
      0,
      ReviewModel(
        name: fullName,
        product: product.trim().isEmpty ? 'PhoneHub Service' : product.trim(),
        rating: rating.clamp(1, 5),
        text: text.trim().isEmpty ? 'Great service.' : text.trim(),
        date: 'Now',
      ),
    );
    notifyListeners();
    _save();
  }

  void toggleGalleryFavorite(String title) {
    if (favoriteGallery.contains(title)) {
      favoriteGallery.remove(title);
    } else {
      favoriteGallery.add(title);
    }
    notifyListeners();
    _save();
  }

  Future<void> resetAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    initialized = false;

    fullName = 'Alex Tech';
    email = 'alex.tech@email.com';
    phone = '+855 12 345 678';
    address = 'Phnom Penh, Cambodia';
    payment = 'Visa •••• 2048';
    avatarIndex = 0;

    pushNotifications = true;
    darkMode = false;
    biometricLogin = true;
    promotionalEmails = false;

    bookings.clear();
    reviews.clear();
    messages.clear();
    favoriteGallery.clear();

    await init();
  }

  int get repairCount => bookings.length;
  int get reviewCount => reviews.length;
  int get galleryFavoriteCount => favoriteGallery.length;
}