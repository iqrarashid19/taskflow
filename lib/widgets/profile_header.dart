import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 82,
          width: 82,
          decoration: BoxDecoration(
            color: AppTheme.softGreen,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.primaryGreen,
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.person_rounded,
            size: 42,
            color: AppTheme.primaryGreen,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppTheme.darkGreen,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          email.isEmpty ? 'TaskFlow User' : email,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            color: AppTheme.secondaryText,
          ),
        ),
      ],
    );
  }
}