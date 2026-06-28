import 'package:flutter/material.dart';

import '../common/phonehub_ui.dart';
import '../common/phonehub_store.dart';
import '../auth/auth_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _showSnack(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  Future<void> _editProfile() async {
    final store = PhoneHubStore.instance;

    final nameController = TextEditingController(text: store.fullName);
    final emailController = TextEditingController(text: store.email);
    final phoneController = TextEditingController(text: store.phone);

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _EditSheet(
          title: 'Edit Profile',
          fields: [
            _SheetField('Full Name', nameController),
            _SheetField('Email', emailController),
            _SheetField('Phone Number', phoneController),
          ],
          onSave: () async {
           final auth = AuthService.instance;

            await auth.updateCurrentUser(
              auth.currentUser!.copyWith(
                fullName: nameController.text,
                email: emailController.text,
                phone: phoneController.text,
              ),
            );

            await auth.updateCurrentUser(
              auth.currentUser!.copyWith(
                fullName: nameController.text,
                email: emailController.text,
                phone: phoneController.text,
              ),
            );

            PhoneHubStore.instance.updateProfile(
              name: nameController.text,
              newEmail: emailController.text,
              newPhone: phoneController.text,
            );

            if (auth.currentUser != null) {
              auth.currentUser = auth.currentUser!.copyWith(
                fullName: nameController.text,
                email: emailController.text,
                phone: phoneController.text,
              );

              await auth.saveCurrentUser();
            }
            Navigator.pop(context);
            _showSnack('Profile updated');
          },
        );
      },
    );
  }

  Future<void> _editAddress() async {
    final controller = TextEditingController(
      text: PhoneHubStore.instance.address,
    );

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _EditSheet(
          title: 'Shipping Address',
          fields: [_SheetField('Address', controller)],
          onSave: () async {
            PhoneHubStore.instance.updateAddress(controller.text);
            Navigator.pop(context);
            _showSnack('Address updated');
          },
        );
      },
    );
  }

  Future<void> _editPayment() async {
    final controller = TextEditingController(
      text: PhoneHubStore.instance.payment,
    );

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _EditSheet(
          title: 'Payment Method',
          fields: [_SheetField('Payment Method', controller)],
          onSave: () {
            PhoneHubStore.instance.updatePayment(controller.text);
            Navigator.pop(context);
            _showSnack('Payment method updated');
          },
        );
      },
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showSnack('Logged out');
              },
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
            'This is a demo action. No account will be permanently deleted.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
                _showSnack('Account delete action confirmed');
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: PhoneHubStore.instance,
      builder: (context, _) {
        final store = PhoneHubStore.instance;

        return PhoneHubPageShell(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: PhoneHubColors.textDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              PhoneHubCard(
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFFE0F2FE),
                      child: Icon(
                        Icons.person_rounded,
                        color: PhoneHubColors.blue,
                        size: 34,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            store.fullName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: PhoneHubColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            store.email,
                            style: const TextStyle(
                              fontSize: 13,
                              color: PhoneHubColors.textGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: _editProfile,
                      icon: const Icon(
                        Icons.edit_rounded,
                        color: PhoneHubColors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _SettingsSection(
                title: 'Account',
                children: [
                  _SettingsTile(
                    icon: Icons.person_outline_rounded,
                    title: 'Personal Information',
                    subtitle: '${store.fullName} • ${store.phone}',
                    onTap: _editProfile,
                  ),
                  _SettingsTile(
                    icon: Icons.location_on_outlined,
                    title: 'Shipping Address',
                    subtitle: store.address,
                    onTap: _editAddress,
                  ),
                  _SettingsTile(
                    icon: Icons.payment_rounded,
                    title: 'Payment Methods',
                    subtitle: store.payment,
                    onTap: _editPayment,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _SettingsSection(
                title: 'Preferences',
                children: [
                  _SwitchTile(
                    icon: Icons.notifications_none_rounded,
                    title: 'Push Notifications',
                    subtitle: 'Order updates and repair alerts',
                    value: store.pushNotifications,
                    onChanged: (value) {
                      PhoneHubStore.instance.updatePreference('push', value);
                    },
                  ),
                  _SwitchTile(
                    icon: Icons.dark_mode_outlined,
                    title: 'Dark Mode',
                    subtitle: 'Use dark appearance',
                    value: store.darkMode,
                    onChanged: (value) {
                      PhoneHubStore.instance.updatePreference('dark', value);
                    },
                  ),
                  _SwitchTile(
                    icon: Icons.fingerprint_rounded,
                    title: 'Biometric Login',
                    subtitle: 'Unlock using fingerprint or face',
                    value: store.biometricLogin,
                    onChanged: (value) {
                      PhoneHubStore.instance.updatePreference('bio', value);
                    },
                  ),
                  _SwitchTile(
                    icon: Icons.local_offer_outlined,
                    title: 'Promotional Emails',
                    subtitle: 'Deals, offers, and new releases',
                    value: store.promotionalEmails,
                    onChanged: (value) {
                      PhoneHubStore.instance.updatePreference('promo', value);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _SettingsSection(
                title: 'Support',
                children: [
                  _SettingsTile(
                    icon: Icons.chat_bubble_outline_rounded,
                    title: 'Customer Support',
                    subtitle: 'Chat with our support team',
                    onTap: () => Navigator.pushNamed(context, '/chat'),
                  ),
                  _SettingsTile(
                    icon: Icons.star_outline_rounded,
                    title: 'Reviews',
                    subtitle: 'View customer feedback',
                    onTap: () => Navigator.pushNamed(context, '/reviews'),
                  ),
                  _SettingsTile(
                    icon: Icons.photo_library_outlined,
                    title: 'Gallery',
                    subtitle: 'Photos and videos',
                    onTap: () => Navigator.pushNamed(context, '/gallery'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              PhoneHubCard(
                child: Column(
                  children: [
                    _DangerTile(
                      icon: Icons.logout_rounded,
                      title: 'Log Out',
                      onTap: _confirmLogout,
                    ),
                    const Divider(height: 20),
                    _DangerTile(
                      icon: Icons.delete_outline_rounded,
                      title: 'Delete Account',
                      onTap: _confirmDelete,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SheetField {
  final String label;
  final TextEditingController controller;

  const _SheetField(this.label, this.controller);
}

class _EditSheet extends StatelessWidget {
  final String title;
  final List<_SheetField> fields;
  final VoidCallback onSave;

  const _EditSheet({
    required this.title,
    required this.fields,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 30,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [PhoneHubColors.blue, PhoneHubColors.cyan],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.edit_rounded,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: PhoneHubColors.textDark,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 18),
            ...fields.map(
              (field) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: TextField(
                  controller: field.controller,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: PhoneHubColors.textDark,
                  ),
                  decoration: InputDecoration(
                    labelText: field.label,
                    labelStyle: const TextStyle(
                      color: PhoneHubColors.textGray,
                      fontWeight: FontWeight.w600,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    prefixIcon: Icon(
                      _iconForField(field.label),
                      color: PhoneHubColors.blue,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(
                        color: PhoneHubColors.border,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(
                        color: PhoneHubColors.border,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(
                        color: PhoneHubColors.blue,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 52,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [PhoneHubColors.blue, PhoneHubColors.cyan],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: onSave,
                    child: const Center(
                      child: Text(
                        'Save Changes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForField(String label) {
    final value = label.toLowerCase();

    if (value.contains('name')) return Icons.person_rounded;
    if (value.contains('email')) return Icons.email_rounded;
    if (value.contains('phone')) return Icons.phone_rounded;
    if (value.contains('address')) return Icons.location_on_rounded;
    if (value.contains('payment')) return Icons.credit_card_rounded;

    return Icons.edit_rounded;
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return PhoneHubCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: PhoneHubColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: PhoneHubColors.softCard,
        child: Icon(icon, color: PhoneHubColors.blue),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          color: PhoneHubColors.textDark,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: PhoneHubColors.textGray,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      secondary: CircleAvatar(
        backgroundColor: PhoneHubColors.softCard,
        child: Icon(icon, color: PhoneHubColors.blue),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          color: PhoneHubColors.textDark,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: PhoneHubColors.textGray,
        ),
      ),
      value: value,
      activeThumbColor: PhoneHubColors.blue,
      onChanged: onChanged,
    );
  }
}

class _DangerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DangerTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFFFE4E6),
        child: Icon(icon, color: const Color(0xFFDC2626)),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFFDC2626),
          fontWeight: FontWeight.w800,
        ),
      ),
      onTap: onTap,
    );
  }
}