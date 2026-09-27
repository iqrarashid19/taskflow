import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CreateTaskCard extends StatelessWidget {
  final bool compact;
  final VoidCallback onTap;

  const CreateTaskCard({
    super.key,
    required this.compact,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: compact ? 60 : 66,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            _buildIcon(),

            const SizedBox(width: 12),

            _buildText(),

            _buildArrow(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.16),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.add_task_rounded,
        color: Colors.white,
        size: 19,
      ),
    );
  }

  Widget _buildText() {
    return const Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create New Task',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 2),

          Text(
            'Plan your next task',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArrow() {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.arrow_forward_rounded,
        color: Colors.white,
        size: 17,
      ),
    );
  }
}