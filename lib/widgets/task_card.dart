import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String time;
  final String priority;
  final IconData icon;
  final Color iconBackground;
  final bool isCompleted;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskCard({
    super.key,
    required this.title,
    required this.time,
    required this.priority,
    required this.icon,
    required this.iconBackground,
    required this.isCompleted,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppTheme.border,
          width: 0.8,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryGreen,
              size: 19,
            ),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.darkGreen,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 12,
                      color: AppTheme.secondaryText,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppTheme.secondaryText,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _PriorityBadge(
                      text: priority,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 4),

          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                onEdit();
              }

              if (value == 'delete') {
                onDelete();
              }
            },
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.more_vert_rounded,
              size: 20,
              color: AppTheme.secondaryText,
            ),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_outline_rounded,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(width: 2),

          GestureDetector(
            onTap: onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                color: isCompleted
                    ? AppTheme.primaryGreen
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted
                      ? AppTheme.primaryGreen
                      : AppTheme.border,
                  width: 1.5,
                ),
              ),
              child: isCompleted
                  ? const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  final String text;

  const _PriorityBadge({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    Color background;

    switch (text.toLowerCase()) {
      case 'high':
        background = AppTheme.softPink;
        break;

      case 'medium':
        background = AppTheme.softYellow;
        break;

      default:
        background = AppTheme.softBlue;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w600,
          color: AppTheme.darkGreen,
        ),
      ),
    );
  }
}