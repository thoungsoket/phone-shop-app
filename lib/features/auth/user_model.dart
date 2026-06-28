class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String password;
  final String phone;
  final String address;
  final String payment;
  final int avatarIndex;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.payment,
    required this.avatarIndex,
  });

  UserModel copyWith({
    String? fullName,
    String? email,
    String? password,
    String? phone,
    String? address,
    String? payment,
    int? avatarIndex,
  }) {
    return UserModel(
      id: id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      payment: payment ?? this.payment,
      avatarIndex: avatarIndex ?? this.avatarIndex,
    );
  }

  String encode() {
    return [
      id,
      fullName,
      email,
      password,
      phone,
      address,
      payment,
      avatarIndex.toString(),
    ].join('¦');
  }

  static UserModel decode(String value) {
    final p = value.split('¦');

    return UserModel(
      id: p.isNotEmpty ? p[0] : DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: p.length > 1 ? p[1] : 'PhoneHub User',
      email: p.length > 2 ? p[2] : '',
      password: p.length > 3 ? p[3] : '',
      phone: p.length > 4 ? p[4] : '+855 12 345 678',
      address: p.length > 5 ? p[5] : 'Phnom Penh, Cambodia',
      payment: p.length > 6 ? p[6] : 'Visa •••• 2048',
      avatarIndex: p.length > 7 ? int.tryParse(p[7]) ?? 0 : 0,
    );
  }
}