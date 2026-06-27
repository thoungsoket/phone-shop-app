
import 'package:flutter/material.dart';

import '../common/phonehub_ui.dart';
import '../common/phonehub_store.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int step = 0;
  int selectedService = 0;
  int selectedBranch = 0;
  int selectedDate = 1;
  int selectedTime = 2;

  final TextEditingController deviceController =
      TextEditingController(text: 'iPhone 15 Pro');
  final TextEditingController noteController = TextEditingController();

  final services = const [
    _RepairService(
      title: 'Screen Repair',
      subtitle: 'Cracked display, touch issue, dead pixels',
      icon: Icons.phone_android_rounded,
      price: '\$89',
      duration: '1–2 hours',
    ),
    _RepairService(
      title: 'Battery Replacement',
      subtitle: 'Battery drains fast or device shuts down',
      icon: Icons.battery_charging_full_rounded,
      price: '\$49',
      duration: '45 min',
    ),
    _RepairService(
      title: 'Camera Repair',
      subtitle: 'Blurry camera, broken lens, camera error',
      icon: Icons.camera_alt_rounded,
      price: '\$69',
      duration: '1 hour',
    ),
    _RepairService(
      title: 'Speaker Repair',
      subtitle: 'Low sound, no sound, microphone issue',
      icon: Icons.volume_up_rounded,
      price: '\$39',
      duration: '30 min',
    ),
  ];

  final branches = const [
    _RepairBranch(
      name: 'PhoneHub Phnom Penh',
      address: 'BKK1, Phnom Penh',
      distance: '1.2 km',
      open: 'Open until 8:00 PM',
    ),
    _RepairBranch(
      name: 'PhoneHub Toul Kork',
      address: 'TK Avenue, Phnom Penh',
      distance: '3.8 km',
      open: 'Open until 9:00 PM',
    ),
    _RepairBranch(
      name: 'PhoneHub Aeon Mall',
      address: 'Aeon Mall Sen Sok',
      distance: '5.1 km',
      open: 'Open until 10:00 PM',
    ),
  ];

  final dates = const [
    _RepairDate(day: 'Mon', date: '24'),
    _RepairDate(day: 'Tue', date: '25'),
    _RepairDate(day: 'Wed', date: '26'),
    _RepairDate(day: 'Thu', date: '27'),
    _RepairDate(day: 'Fri', date: '28'),
  ];

  final times = const [
    '09:00',
    '10:30',
    '13:00',
    '15:30',
    '17:00',
    '18:30',
  ];

  @override
  void dispose() {
    deviceController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void nextStep() {
    if (step < 3) {
      setState(() => step++);
    }
  }

  void previousStep() {
    if (step > 0) {
      setState(() => step--);
    } else {
      Navigator.maybePop(context);
    }
  }

  void confirmBooking() {
    final service = services[selectedService];
    final date = '${dates[selectedDate].day} ${dates[selectedDate].date}';
    final time = times[selectedTime];

    PhoneHubStore.instance.addBooking(
      service: service.title,
      date: date,
      time: time,
      price: service.price,
      device: deviceController.text,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _SuccessDialog(
        service: service.title,
        date: date,
        time: time,
        onTrack: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/repair-tracker');
        },
        onDone: () {
          Navigator.pop(context);
          Navigator.maybePop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PhoneHubPageShell(
      child: Column(
        children: [
          _BookingHeader(
            step: step,
            onBack: previousStep,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
              children: [
                _StepProgress(currentStep: step),
                const SizedBox(height: 18),
                if (step == 0) _buildServiceStep(),
                if (step == 1) _buildBranchStep(),
                if (step == 2) _buildScheduleStep(),
                if (step == 3) _buildConfirmStep(),
              ],
            ),
          ),
          _BottomActionBar(
            primaryText: step == 3 ? 'Confirm Booking' : 'Continue',
            secondaryText: step == 0 ? 'Cancel' : 'Back',
            onPrimary: step == 3 ? confirmBooking : nextStep,
            onSecondary: previousStep,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PageTitle(
          title: 'What needs fixing?',
          subtitle: 'Choose the service that best matches your device issue.',
        ),
        const SizedBox(height: 16),
        TextField(
          controller: deviceController,
          decoration: InputDecoration(
            labelText: 'Device model',
            hintText: 'Example: iPhone 15 Pro',
            filled: true,
            fillColor: Colors.white,
            prefixIcon: const Icon(
              Icons.phone_iphone_rounded,
              color: PhoneHubColors.blue,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: PhoneHubColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: PhoneHubColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: PhoneHubColors.blue, width: 1.5),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(
          services.length,
          (index) {
            final service = services[index];
            final active = selectedService == index;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ServiceCard(
                service: service,
                selected: active,
                onTap: () => setState(() => selectedService = index),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        _InfoBanner(
          icon: Icons.verified_user_outlined,
          title: 'Free inspection included',
          text:
              'Our technician checks your device first. You confirm the final price before repair starts.',
        ),
      ],
    );
  }

  Widget _buildBranchStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PageTitle(
          title: 'Choose Repair Center',
          subtitle: 'Select the most convenient PhoneHub branch.',
        ),
        const SizedBox(height: 16),
        ...List.generate(
          branches.length,
          (index) {
            final branch = branches[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _BranchCard(
                branch: branch,
                selected: selectedBranch == index,
                onTap: () {
                  setState(() {
                    selectedBranch = index;
                  });
                },
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        const _InfoBanner(
          icon: Icons.location_on_outlined,
          title: 'Walk-in Available',
          text:
              'You may also visit directly without an appointment, but booking guarantees your repair slot.',
        ),
      ],
    );
  }

  Widget _buildScheduleStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PageTitle(
          title: 'Schedule Appointment',
          subtitle: 'Choose your preferred date and time.',
        ),
        const SizedBox(height: 18),

        const Text(
          'Available Dates',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            color: PhoneHubColors.textDark,
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 86,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = dates[index];
              final active = selectedDate == index;

              return InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () {
                  setState(() {
                    selectedDate = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 72,
                  decoration: BoxDecoration(
                    gradient: active
                        ? const LinearGradient(
                            colors: [
                              PhoneHubColors.blue,
                              PhoneHubColors.cyan,
                            ],
                          )
                        : null,
                    color: active ? null : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: active
                          ? Colors.transparent
                          : PhoneHubColors.border,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.day,
                        style: TextStyle(
                          color: active
                              ? Colors.white70
                              : PhoneHubColors.textGray,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.date,
                        style: TextStyle(
                          color: active
                              ? Colors.white
                              : PhoneHubColors.textDark,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 24),

        const Text(
          'Available Time',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            color: PhoneHubColors.textDark,
          ),
        ),

        const SizedBox(height: 14),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(
            times.length,
            (index) {
              final active = selectedTime == index;

              return InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: () {
                  setState(() {
                    selectedTime = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    gradient: active
                        ? const LinearGradient(
                            colors: [
                              PhoneHubColors.blue,
                              PhoneHubColors.cyan,
                            ],
                          )
                        : null,
                    color: active ? null : Colors.white,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: active
                          ? Colors.transparent
                          : PhoneHubColors.border,
                    ),
                  ),
                  child: Text(
                    times[index],
                    style: TextStyle(
                      color: active
                          ? Colors.white
                          : PhoneHubColors.textDark,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 24),

        TextField(
          controller: noteController,
          minLines: 4,
          maxLines: 5,
          decoration: InputDecoration(
            labelText: 'Additional Notes',
            hintText:
                'Describe your device problem so the technician can prepare.',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmStep() {
    final service = services[selectedService];
    final branch = branches[selectedBranch];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PageTitle(
          title: 'Confirm Booking',
          subtitle: 'Please review your appointment before confirming.',
        ),
        const SizedBox(height: 18),

        PhoneHubCard(
          child: Column(
            children: [
              _SummaryTile(
                icon: Icons.phone_iphone_rounded,
                title: 'Device',
                value: deviceController.text,
              ),
              const Divider(),
              _SummaryTile(
                icon: service.icon,
                title: 'Repair Service',
                value: service.title,
              ),
              const Divider(),
              _SummaryTile(
                icon: Icons.store_rounded,
                title: 'Branch',
                value: branch.name,
              ),
              const Divider(),
              _SummaryTile(
                icon: Icons.calendar_today_rounded,
                title: 'Appointment',
                value:
                    '${dates[selectedDate].day} ${dates[selectedDate].date} • ${times[selectedTime]}',
              ),
              const Divider(),
              _SummaryTile(
                icon: Icons.schedule_rounded,
                title: 'Estimated Duration',
                value: service.duration,
              ),
              const Divider(),
              _SummaryTile(
                icon: Icons.attach_money_rounded,
                title: 'Estimated Cost',
                value: service.price,
                valueColor: PhoneHubColors.blue,
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        if (noteController.text.isNotEmpty)
          PhoneHubCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Technician Notes',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: PhoneHubColors.textDark,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  noteController.text,
                  style: const TextStyle(
                    color: PhoneHubColors.textGray,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

        const SizedBox(height: 20),

        const _InfoBanner(
          icon: Icons.info_outline_rounded,
          title: 'Before You Visit',
          text:
              'Please back up your data before bringing your device. PhoneHub is not responsible for personal data loss during repair.',
        ),

        const SizedBox(height: 16),

        const _InfoBanner(
          icon: Icons.security_rounded,
          title: 'Repair Warranty',
          text:
              'All repairs include a 90-day service warranty covering workmanship and replaced parts.',
        ),
      ],
    );
  }
}

class _BookingHeader extends StatelessWidget {
  final int step;
  final VoidCallback onBack;

  const _BookingHeader({
    required this.step,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    const titles = [
      'Book Repair',
      'Choose Branch',
      'Schedule',
      'Confirmation',
    ];

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Row(
          children: [
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                titles[step],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: PhoneHubColors.textDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepProgress extends StatelessWidget {
  final int currentStep;

  const _StepProgress({
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    const labels = [
      'Service',
      'Branch',
      'Schedule',
      'Confirm',
    ];

    return Row(
      children: List.generate(
        4,
        (index) {
          final active = index <= currentStep;

          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: active
                        ? const LinearGradient(
                            colors: [
                              PhoneHubColors.blue,
                              PhoneHubColors.cyan,
                            ],
                          )
                        : null,
                    color: active ? null : PhoneHubColors.softCard,
                  ),
                  child: Center(
                    child: active
                        ? const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 18,
                          )
                        : Text(
                            '${index + 1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: PhoneHubColors.textGray,
                            ),
                          ),
                  ),
                ),
                if (index != 3)
                  Expanded(
                    child: Container(
                      height: 3,
                      color: index < currentStep
                          ? PhoneHubColors.blue
                          : PhoneHubColors.border,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PageTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const _PageTitle({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: PhoneHubColors.textDark,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(
            color: PhoneHubColors.textGray,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  final String primaryText;
  final String secondaryText;
  final VoidCallback onPrimary;
  final VoidCallback onSecondary;

  const _BottomActionBar({
    required this.primaryText,
    required this.secondaryText,
    required this.onPrimary,
    required this.onSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: Offset(0, -5),
            color: Color(0x14000000),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onSecondary,
              child: Text(secondaryText),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: PhoneHubGradientButton(
              text: primaryText,
              onTap: onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const _InfoBanner({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return PhoneHubCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: PhoneHubColors.softCard,
            child: Icon(icon, color: PhoneHubColors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: PhoneHubColors.textDark,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  text,
                  style: const TextStyle(
                    color: PhoneHubColors.textGray,
                    height: 1.45,
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

class _ServiceCard extends StatelessWidget {
  final _RepairService service;
  final bool selected;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.service,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? null : Colors.white,
          gradient: selected
              ? const LinearGradient(
                  colors: [PhoneHubColors.blue, PhoneHubColors.cyan],
                )
              : null,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? Colors.transparent : PhoneHubColors.border,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F2563EB),
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: selected ? Colors.white.withOpacity(.18) : PhoneHubColors.softCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                service.icon,
                color: selected ? Colors.white : PhoneHubColors.blue,
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.title,
                    style: TextStyle(
                      color: selected ? Colors.white : PhoneHubColors.textDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    service.subtitle,
                    style: TextStyle(
                      color: selected ? Colors.white70 : PhoneHubColors.textGray,
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        service.duration,
                        style: TextStyle(
                          color: selected ? Colors.white : PhoneHubColors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        service.price,
                        style: TextStyle(
                          color: selected ? Colors.white : PhoneHubColors.textDark,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              selected ? Icons.check_circle_rounded : Icons.circle_outlined,
              color: selected ? Colors.white : PhoneHubColors.border,
            ),
          ],
        ),
      ),
    );
  }
}

class _BranchCard extends StatelessWidget {
  final _RepairBranch branch;
  final bool selected;
  final VoidCallback onTap;

  const _BranchCard({
    required this.branch,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? PhoneHubColors.blue : PhoneHubColors.border,
            width: selected ? 1.5 : 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F2563EB),
              blurRadius: 14,
              offset: Offset(0, 7),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                gradient: selected
                    ? const LinearGradient(
                        colors: [PhoneHubColors.blue, PhoneHubColors.cyan],
                      )
                    : null,
                color: selected ? null : PhoneHubColors.softCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.storefront_rounded,
                color: selected ? Colors.white : PhoneHubColors.blue,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    branch.name,
                    style: const TextStyle(
                      color: PhoneHubColors.textDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    branch.address,
                    style: const TextStyle(
                      color: PhoneHubColors.textGray,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 14,
                        color: PhoneHubColors.blue,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        branch.distance,
                        style: const TextStyle(
                          color: PhoneHubColors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          branch.open,
                          style: const TextStyle(
                            color: Color(0xFF16A34A),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? PhoneHubColors.blue : PhoneHubColors.border,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color? valueColor;

  const _SummaryTile({
    required this.icon,
    required this.title,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: PhoneHubColors.softCard,
            child: Icon(icon, color: PhoneHubColors.blue, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: PhoneHubColors.textGray,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: valueColor ?? PhoneHubColors.textDark,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuccessDialog extends StatelessWidget {
  final String service;
  final String date;
  final String time;
  final VoidCallback onTrack;
  final VoidCallback onDone;

  const _SuccessDialog({
    required this.service,
    required this.date,
    required this.time,
    required this.onTrack,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(22),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 30,
              offset: Offset(0, 14),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [PhoneHubColors.blue, PhoneHubColors.cyan],
                ),
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 42,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Booking Confirmed',
              style: TextStyle(
                color: PhoneHubColors.textDark,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$service is booked on $date at $time.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: PhoneHubColors.textGray,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 22),
            PhoneHubGradientButton(
              text: 'Track Repair',
              onTap: onTrack,
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: onDone,
              child: const Text('Back to Previous Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class _RepairService {
  final String title;
  final String subtitle;
  final IconData icon;
  final String price;
  final String duration;

  const _RepairService({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.price,
    required this.duration,
  });
}

class _RepairBranch {
  final String name;
  final String address;
  final String distance;
  final String open;

  const _RepairBranch({
    required this.name,
    required this.address,
    required this.distance,
    required this.open,
  });
}

class _RepairDate {
  final String day;
  final String date;

  const _RepairDate({
    required this.day,
    required this.date,
  });
}