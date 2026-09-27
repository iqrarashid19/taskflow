import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class HomeHeader extends StatelessWidget {
  final bool compact;

  const HomeHeader({
    super.key,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getGreeting(),
                style: TextStyle(
                  fontSize: compact ? 12 : 13,
                  color: AppTheme.secondaryText,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                'Iqra 👋',
                style: TextStyle(
                  fontSize: compact ? 23 : 26,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.darkGreen,
                ),
              ),
            ],
          ),
        ),

        Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: AppTheme.border,
            ),
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: AppTheme.darkGreen,
            size: 22,
          ),
        ),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    }

    if (hour < 17) {
      return 'Good Afternoon';
    }

    return 'Good Evening';
  }
}