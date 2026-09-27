import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class TaskFilterTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const TaskFilterTabs({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const tabs = [
      'Today',
      'Upcoming',
      'Completed',
    ];

    return Container(
      height: 42,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: List.generate(
          tabs.length,
          (index) {
            final selected = selectedIndex == index;

            return Expanded(
              child: GestureDetector(
                onTap: () => onChanged(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(11),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: selected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: selected
                          ? AppTheme.darkGreen
                          : AppTheme.secondaryText,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}