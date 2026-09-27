import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../data/task_data.dart';
import '../data/planner_data.dart';
import '../services/task_storage.dart';
import '../widgets/task_card.dart';
import '../widgets/task_filter_tabs.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({
    super.key,
  });

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  int selectedTab = 0;

  bool isSearching = false;

  final TextEditingController searchController =
      TextEditingController();

  String searchQuery = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final compact =
        MediaQuery.of(context).size.height < 720;

    final filteredTasks = _filteredTasks();

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          compact ? 18 : 22,
          compact ? 12 : 18,
          compact ? 18 : 22,
          8,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            _buildHeader(compact),

            SizedBox(
              height: compact ? 16 : 20,
            ),

            TaskFilterTabs(
              selectedIndex: selectedTab,
              onChanged: (index) {
                setState(() {
                  selectedTab = index;
                });
              },
            ),

            SizedBox(
              height: compact ? 16 : 20,
            ),

            Expanded(
              child: filteredTasks.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount:
                          filteredTasks.length,
                      itemBuilder:
                          (context, index) {
                        final task =
                            filteredTasks[index];

                        return TaskCard(
                          title: task.title,
                          time: task.time,
                          priority: task.priority,
                          icon: task.icon,
                          iconBackground:
                              task.color,
                          isCompleted:
                              task.completed,
                          onToggle: () {
                            _toggleTask(task);
                          },
                          onEdit: () {
                            _editTask(task);
                          },
                          onDelete: () {
                            _deleteTask(task);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool compact) {
    if (isSearching) {
      return Row(
        children: [
          Expanded(
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(15),
                border: Border.all(
                  color: AppTheme.border,
                ),
              ),
              child: TextField(
                controller: searchController,
                autofocus: true,
                textInputAction:
                    TextInputAction.search,
                onChanged: (value) {
                  setState(() {
                    searchQuery =
                        value.trim().toLowerCase();
                  });
                },
                decoration:
                    const InputDecoration(
                  hintText: 'Search tasks...',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color:
                        AppTheme.secondaryText,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 20,
                    color:
                        AppTheme.darkGreen,
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(
                    vertical: 11,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _closeSearch,
            child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(15),
                border: Border.all(
                  color: AppTheme.border,
                ),
              ),
              child: const Icon(
                Icons.close_rounded,
                color: AppTheme.darkGreen,
                size: 21,
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'Manage your',
                style: TextStyle(
                  fontSize: compact ? 12 : 13,
                  color:
                      AppTheme.secondaryText,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Tasks',
                style: TextStyle(
                  fontSize:
                      compact ? 25 : 28,
                  fontWeight:
                      FontWeight.w700,
                  color: AppTheme.darkGreen,
                ),
              ),
            ],
          ),
        ),
        _buildSearchButton(),
      ],
    );
  }

  Widget _buildSearchButton() {
    return GestureDetector(
      onTap: _openSearch,
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(15),
          border: Border.all(
            color: AppTheme.border,
          ),
        ),
        child: const Icon(
          Icons.search_rounded,
          color: AppTheme.darkGreen,
          size: 21,
        ),
      ),
    );
  }

  void _openSearch() {
    setState(() {
      isSearching = true;
    });
  }

  void _closeSearch() {
    searchController.clear();

    setState(() {
      isSearching = false;
      searchQuery = '';
    });
  }

  List<TaskData> _filteredTasks() {
    List<TaskData> tasks;

    if (selectedTab == 0) {
      tasks = taskList
          .where(
            (task) =>
                task.category == 'today' &&
                !task.completed,
          )
          .toList();
    } else if (selectedTab == 1) {
      tasks = taskList
          .where(
            (task) =>
                task.category == 'upcoming' &&
                !task.completed,
          )
          .toList();
    } else {
      tasks = taskList
          .where(
            (task) => task.completed,
          )
          .toList();
    }

    if (searchQuery.isEmpty) {
      return tasks;
    }

    return tasks
        .where(
          (task) => task.title
              .toLowerCase()
              .contains(searchQuery),
        )
        .toList();
  }

  Future<void> _toggleTask(
    TaskData task,
  ) async {
    setState(() {
      task.completed = !task.completed;
    });

    await TaskStorage.saveTasks();
  }

  // =========================
  // EDIT TASK
  // =========================

  Future<void> _editTask(
    TaskData task,
  ) async {
    final titleController =
        TextEditingController(
      text: task.title,
    );

    TimeOfDay? selectedTime =
        _parseTime(task.time);

    String selectedPriority =
        task.priority;

    int selectedDate =
        task.date;

    final oldTitle = task.title;
    final oldDate = task.date;

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (
            context,
            setDialogState,
          ) {
            return AlertDialog(
              backgroundColor: Colors.white,
              scrollable: true,
              insetPadding:
                  const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 24,
              ),
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(22),
              ),
              titlePadding:
                  const EdgeInsets.fromLTRB(
                20,
                20,
                20,
                8,
              ),
              contentPadding:
                  const EdgeInsets.fromLTRB(
                20,
                4,
                20,
                8,
              ),
              title: const Text(
                'Edit Task',
                style: TextStyle(
                  fontSize: 19,
                  color:
                      AppTheme.darkGreen,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),
              content: ConstrainedBox(
                constraints:
                    const BoxConstraints(
                  maxWidth: 380,
                ),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Task Title',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight:
                            FontWeight.w600,
                        color:
                            AppTheme.darkGreen,
                      ),
                    ),
                    const SizedBox(height: 7),
                    TextField(
                      controller:
                          titleController,
                      textInputAction:
                          TextInputAction.done,
                      decoration:
                          InputDecoration(
                        hintText:
                            'Task title',
                        hintStyle:
                            const TextStyle(
                          fontSize: 11,
                          color: AppTheme
                              .secondaryText,
                        ),
                        filled: true,
                        fillColor:
                            AppTheme.background,
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(13),
                          borderSide:
                              BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight:
                            FontWeight.w600,
                        color:
                            AppTheme.darkGreen,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildEditDateSelector(
                      selectedDate:
                          selectedDate,
                      onChanged: (date) {
                        setDialogState(() {
                          selectedDate = date;
                        });
                      },
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child:
                              GestureDetector(
                            onTap: () async {
                              final time =
                                  await showTimePicker(
                                context:
                                    context,
                                initialTime:
                                    selectedTime ??
                                        TimeOfDay
                                            .now(),
                              );

                              if (time != null) {
                                setDialogState(() {
                                  selectedTime =
                                      time;
                                });
                              }
                            },
                            child:
                                _editOption(
                              icon: Icons
                                  .access_time_rounded,
                              text:
                                  selectedTime ==
                                          null
                                      ? 'Set Time'
                                      : selectedTime!
                                          .format(
                                          context,
                                        ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child:
                              PopupMenuButton<
                                  String>(
                            onSelected:
                                (value) {
                              setDialogState(() {
                                selectedPriority =
                                    value;
                              });
                            },
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                14,
                              ),
                            ),
                            itemBuilder:
                                (context) {
                              return const [
                                PopupMenuItem(
                                  value: 'Low',
                                  child: Text(
                                    'Low',
                                    style:
                                        TextStyle(
                                      fontSize:
                                          11,
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  value:
                                      'Medium',
                                  child: Text(
                                    'Medium',
                                    style:
                                        TextStyle(
                                      fontSize:
                                          11,
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'High',
                                  child: Text(
                                    'High',
                                    style:
                                        TextStyle(
                                      fontSize:
                                          11,
                                    ),
                                  ),
                                ),
                              ];
                            },
                            child:
                                _editOption(
                              icon: Icons
                                  .flag_outlined,
                              text:
                                  selectedPriority,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actionsPadding:
                  const EdgeInsets.fromLTRB(
                14,
                4,
                14,
                14,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      dialogContext,
                    );
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color:
                          AppTheme.secondaryText,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final newTitle =
                        titleController
                            .text
                            .trim();

                    if (newTitle.isEmpty) {
                      return;
                    }

                    final newTime =
                        selectedTime == null
                            ? task.time
                            : selectedTime!
                                .format(
                                context,
                              );

                    final newCategory =
                        selectedDate == 20
                            ? 'today'
                            : 'upcoming';

                    setState(() {
                      task.title =
                          newTitle;
                      task.time =
                          newTime;
                      task.priority =
                          selectedPriority;
                      task.date =
                          selectedDate;
                      task.category =
                          newCategory;
                    });

                    _updatePlannerTask(
                      oldTitle: oldTitle,
                      oldDate: oldDate,
                      newTitle: newTitle,
                      newTime: newTime,
                      newDate: selectedDate,
                    );

                    await TaskStorage
                        .saveTasks();

                    if (dialogContext
                        .mounted) {
                      Navigator.pop(
                        dialogContext,
                      );
                    }
                  },
                  style: ElevatedButton
                      .styleFrom(
                    backgroundColor:
                        AppTheme.primaryGreen,
                    foregroundColor:
                        Colors.white,
                    elevation: 0,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius
                              .circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    // Do NOT dispose titleController here.
  }

  Widget _buildEditDateSelector({
    required int selectedDate,
    required ValueChanged<int> onChanged,
  }) {
    const List<Map<String, dynamic>> dates = [
      {
        'day': 'MON',
        'date': 20,
      },
      {
        'day': 'TUE',
        'date': 21,
      },
      {
        'day': 'WED',
        'date': 22,
      },
      {
        'day': 'THU',
        'date': 23,
      },
      {
        'day': 'FRI',
        'date': 24,
      },
    ];

    return Row(
      children: List.generate(
        dates.length,
        (index) {
          final int date =
              dates[index]['date'] as int;

          final bool isSelected =
              selectedDate == date;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                onChanged(date);
              },
              child: AnimatedContainer(
                duration:
                    const Duration(
                  milliseconds: 180,
                ),
                margin: EdgeInsets.only(
                  right: index ==
                          dates.length - 1
                      ? 0
                      : 5,
                ),
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                decoration:
                    BoxDecoration(
                  color: isSelected
                      ? AppTheme.primaryGreen
                      : AppTheme.background,
                  borderRadius:
                      BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.primaryGreen
                        : AppTheme.border,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      dates[index]['day']
                          .toString(),
                      style: TextStyle(
                        fontSize: 7,
                        fontWeight:
                            FontWeight.w600,
                        color: isSelected
                            ? Colors.white70
                            : AppTheme
                                .secondaryText,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      date.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            FontWeight.w700,
                        color: isSelected
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

  Widget _editOption({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius:
            BorderRadius.circular(13),
        border: Border.all(
          color: AppTheme.border,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: AppTheme.primaryGreen,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow:
                  TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10,
                fontWeight:
                    FontWeight.w600,
                color: AppTheme.darkGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }

  TimeOfDay? _parseTime(
    String time,
  ) {
    if (time == 'Anytime') {
      return null;
    }

    try {
      final parts = time.split(' ');
      final timeParts =
          parts[0].split(':');

      int hour =
          int.parse(timeParts[0]);

      final int minute =
          int.parse(timeParts[1]);

      final isPM =
          parts.length > 1 &&
          parts[1].toUpperCase() == 'PM';

      if (isPM && hour != 12) {
        hour += 12;
      }

      if (!isPM && hour == 12) {
        hour = 0;
      }

      return TimeOfDay(
        hour: hour,
        minute: minute,
      );
    } catch (_) {
      return null;
    }
  }

  void _updatePlannerTask({
    required String oldTitle,
    required int oldDate,
    required String newTitle,
    required String newTime,
    required int newDate,
  }) {
    final index = plannerTasks.indexWhere(
      (plannerTask) =>
          plannerTask.title == oldTitle &&
          plannerTask.date == oldDate,
    );

    if (index == -1) {
      return;
    }

    final oldPlannerTask =
        plannerTasks[index];

    plannerTasks[index] = PlannerTask(
      title: newTitle,
      time: newTime,
      category:
          oldPlannerTask.category,
      date: newDate,
    );
  }

  Future<void> _deleteTask(
    TaskData task,
  ) async {
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(22),
          ),
          title: const Text(
            'Delete Task?',
            style: TextStyle(
              color: AppTheme.darkGreen,
              fontWeight:
                  FontWeight.w700,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete this task?',
            style: TextStyle(
              color:
                  AppTheme.secondaryText,
              fontSize: 13,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color:
                      AppTheme.secondaryText,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final taskTitle =
                    task.title;

                final taskDate =
                    task.date;

                setState(() {
                  taskList.remove(task);
                });

                plannerTasks.removeWhere(
                  (plannerTask) =>
                      plannerTask.title ==
                          taskTitle &&
                      plannerTask.date ==
                          taskDate,
                );

                await TaskStorage
                    .saveTasks();

                if (dialogContext
                    .mounted) {
                  Navigator.pop(
                    dialogContext,
                  );
                }
              },
              style: ElevatedButton
                  .styleFrom(
                backgroundColor:
                    AppTheme.primaryGreen,
                foregroundColor:
                    Colors.white,
              ),
              child: const Text(
                'Delete',
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState() {
    final hasSearch =
        searchQuery.isNotEmpty;

    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Container(
            height: 64,
            width: 64,
            decoration:
                const BoxDecoration(
              color:
                  AppTheme.softGreen,
              shape: BoxShape.circle,
            ),
            child: Icon(
              hasSearch
                  ? Icons.search_off_rounded
                  : Icons.task_alt_rounded,
              size: 30,
              color:
                  AppTheme.primaryGreen,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            hasSearch
                ? 'No tasks found'
                : 'No tasks here',
            style: const TextStyle(
              fontSize: 15,
              fontWeight:
                  FontWeight.w700,
              color:
                  AppTheme.darkGreen,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            hasSearch
                ? 'Try a different search.'
                : 'You are all caught up!',
            style: const TextStyle(
              fontSize: 11,
              color:
                  AppTheme.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}