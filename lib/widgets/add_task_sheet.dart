
import 'package:flutter/material.dart';
import '../services/task_storage.dart';
import '../theme/app_theme.dart';
import '../data/task_data.dart';
import '../data/planner_data.dart';

class AddTaskSheet extends StatefulWidget {
  final VoidCallback onTaskAdded;

  const AddTaskSheet({
    super.key,
    required this.onTaskAdded,
  });

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final TextEditingController titleController =
      TextEditingController();

  TimeOfDay? selectedTime;
  String selectedPriority = 'Medium';
  int selectedDateIndex = 0;

  final List<Map<String, String>> dates = [
    {
      'day': 'MON',
      'date': '20',
    },
    {
      'day': 'TUE',
      'date': '21',
    },
    {
      'day': 'WED',
      'date': '22',
    },
    {
      'day': 'THU',
      'date': '23',
    },
    {
      'day': 'FRI',
      'date': '24',
    },
  ];

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  Future<void> _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null && mounted) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  void _addTask() async {
    if (titleController.text.trim().isEmpty) {
      return;
    }

    final timeText = selectedTime == null
        ? 'Anytime'
        : selectedTime!.format(context);

    // Keep the selected date identical
    // for both Tasks and Planner.
    final selectedDate =
        20 + selectedDateIndex;

    final taskTitle =
        titleController.text.trim();

    // =========================
    // ADD TO TASKS
    // =========================

    taskList.add(
      TaskData(
        title: taskTitle,
        time: timeText,
        priority: selectedPriority,
        icon: Icons.task_alt_rounded,
        color: AppTheme.softGreen,
        completed: false,
        category: 'today',
        date: selectedDate,
      ),
    );

    // =========================
    // ADD TO PLANNER
    // =========================

    plannerTasks.add(
      PlannerTask(
        title: taskTitle,
        time: timeText,
        category: 'Work',
        date: selectedDate,
      ),
    );

    // =========================
    // SAVE BOTH
    // =========================

    await TaskStorage.saveTasks();

    widget.onTaskAdded();

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset =
        MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(
        bottom: bottomInset,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          20,
          12,
          20,
          20,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(28),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  height: 4,
                  width: 42,
                  decoration: BoxDecoration(
                    color: AppTheme.border,
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                'Create New Task',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.darkGreen,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Add a task to your daily plan.',
                style: TextStyle(
                  fontSize: 11,
                  color: AppTheme.secondaryText,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Task Title',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkGreen,
                ),
              ),

              const SizedBox(height: 7),

              TextField(
                controller: titleController,
                textInputAction:
                    TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'Enter task title',
                  hintStyle: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.secondaryText,
                  ),
                  filled: true,
                  fillColor: AppTheme.background,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 13,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Date',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkGreen,
                ),
              ),

              const SizedBox(height: 8),

              Row(
                children: List.generate(
                  dates.length,
                  (index) {
                    final selected =
                        selectedDateIndex == index;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDateIndex =
                                index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(
                            milliseconds: 180,
                          ),
                          margin: EdgeInsets.only(
                            right: index ==
                                    dates.length - 1
                                ? 0
                                : 6,
                          ),
                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppTheme.primaryGreen
                                : AppTheme.background,
                            borderRadius:
                                BorderRadius.circular(13),
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
                                  fontSize: 7,
                                  fontWeight:
                                      FontWeight.w600,
                                  color: selected
                                      ? Colors.white70
                                      : AppTheme
                                          .secondaryText,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                dates[index]['date']!,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight:
                                      FontWeight.w700,
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
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _buildTimeSelector(),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildPrioritySelector(),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _addTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppTheme.primaryGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Add Task',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSelector() {
    return GestureDetector(
      onTap: _selectTime,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppTheme.border,
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.access_time_rounded,
              size: 17,
              color: AppTheme.primaryGreen,
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Text(
                selectedTime == null
                    ? 'Set Time'
                    : selectedTime!.format(context),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkGreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrioritySelector() {
    return PopupMenuButton<String>(
      onSelected: (value) {
        setState(() {
          selectedPriority = value;
        });
      },
      offset: const Offset(0, 45),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      itemBuilder: (context) {
        return const [
          PopupMenuItem(
            value: 'Low',
            child: Text(
              'Low',
              style: TextStyle(fontSize: 11),
            ),
          ),
          PopupMenuItem(
            value: 'Medium',
            child: Text(
              'Medium',
              style: TextStyle(fontSize: 11),
            ),
          ),
          PopupMenuItem(
            value: 'High',
            child: Text(
              'High',
              style: TextStyle(fontSize: 11),
            ),
          ),
        ];
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppTheme.border,
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.flag_outlined,
              size: 17,
              color: AppTheme.primaryGreen,
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Text(
                selectedPriority,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkGreen,
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 17,
              color: AppTheme.secondaryText,
            ),
          ],
        ),
      ),
    );
  }
}


