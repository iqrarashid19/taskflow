import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class PlannerDateSelector extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDateChanged;

  const PlannerDateSelector({
    super.key,
    required this.selectedIndex,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    final dates = [
      {'day': 'MON', 'date': '20'},
      {'day': 'TUE', 'date': '21'},
      {'day': 'WED', 'date': '22'},
      {'day': 'THU', 'date': '23'},
      {'day': 'FRI', 'date': '24'},
    ];

    return Row(
      children: List.generate(
        dates.length,
        (index) {
          final selected = index == selectedIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                onDateChanged(index);
              },
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 180,
                ),
                margin: EdgeInsets.only(
                  right: index == dates.length - 1 ? 0 : 8,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? AppTheme.primaryGreen
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: selected
                        ? AppTheme.primaryGreen
                        : AppTheme.border,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      dates[index]['day']!,
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        color: selected
                            ? Colors.white70
                            : AppTheme.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dates[index]['date']!,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: selected
                            ? Colors.white
                            : AppTheme.darkGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}