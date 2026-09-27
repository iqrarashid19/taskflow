import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu_item.dart';
import '../services/task_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {
  String profileName = 'Iqra Rashid';
  String profileEmail = '';
  bool notificationsEnabled = true;

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    final name =
        await TaskStorage.getProfileName();

    final email =
        await TaskStorage.getProfileEmail();

    final notifications =
        await TaskStorage
            .getNotificationsEnabled();

    if (!mounted) return;

    setState(() {
      profileName = name;
      profileEmail = email;
      notificationsEnabled = notifications;
    });
  }

  // =========================
  // EDIT PROFILE
  // =========================

  Future<void> _editProfile() async {
    nameController.text = profileName;
    emailController.text = profileEmail;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(
                sheetContext,
              ).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                20,
                12,
                20,
                24,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
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

                  const SizedBox(height: 20),

                  const Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.darkGreen,
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: nameController,
                    textCapitalization:
                        TextCapitalization.words,
                    decoration: _inputDecoration(
                      'Full Name',
                      Icons.person_outline_rounded,
                    ),
                  ),

                  const SizedBox(height: 14),

                  TextField(
                    controller: emailController,
                    keyboardType:
                        TextInputType.emailAddress,
                    decoration: _inputDecoration(
                      'Email Address',
                      Icons.email_outlined,
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        final name =
                            nameController.text.trim();

                        final email =
                            emailController.text.trim();

                        if (name.isEmpty) {
                          return;
                        }

                        await TaskStorage.saveProfile(
                          name: name,
                          email: email,
                        );

                        if (!mounted) return;

                        setState(() {
                          profileName = name;
                          profileEmail = email;
                        });

                        Navigator.of(
                          sheetContext,
                        ).pop();
                      },
                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            AppTheme.primaryGreen,
                        foregroundColor:
                            Colors.white,
                        elevation: 0,
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // =========================
  // NOTIFICATIONS
  // =========================

  Future<void> _showNotifications() async {
    bool value = notificationsEnabled;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.fromLTRB(
              20,
              12,
              20,
              28,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            child: StatefulBuilder(
              builder: (
                context,
                setSheetState,
              ) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 4,
                      width: 42,
                      decoration: BoxDecoration(
                        color: AppTheme.border,
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Container(
                          height: 44,
                          width: 44,
                          decoration:
                              const BoxDecoration(
                            color:
                                AppTheme.softGreen,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons
                                .notifications_none_rounded,
                            color:
                                AppTheme.primaryGreen,
                          ),
                        ),

                        const SizedBox(width: 14),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              Text(
                                'Notifications',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.w700,
                                  color:
                                      AppTheme.darkGreen,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                'Task reminders and updates',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppTheme
                                      .secondaryText,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Switch(
                          value: value,
                          activeThumbColor:
                              AppTheme.primaryGreen,
                          onChanged:
                              (newValue) async {
                            setSheetState(() {
                              value = newValue;
                            });

                            await TaskStorage
                                .saveNotificationsEnabled(
                              newValue,
                            );

                            if (!mounted) return;

                            setState(() {
                              notificationsEnabled =
                                  newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  // =========================
  // SETTINGS
  // =========================

  Future<void> _showSettings() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.fromLTRB(
              20,
              12,
              20,
              28,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
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

                const SizedBox(height: 20),

                const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.darkGreen,
                  ),
                ),

                const SizedBox(height: 18),

                _settingsRow(
                  icon: Icons
                      .notifications_none_rounded,
                  title: 'Notifications',
                  trailing: Switch(
                    value: notificationsEnabled,
                    activeThumbColor:
                        AppTheme.primaryGreen,
                    onChanged: (value) async {
                      await TaskStorage
                          .saveNotificationsEnabled(
                        value,
                      );

                      if (!mounted) return;

                      setState(() {
                        notificationsEnabled =
                            value;
                      });

                      Navigator.of(
                        sheetContext,
                      ).pop();
                    },
                  ),
                ),

                const Divider(
                  color: AppTheme.border,
                  height: 1,
                ),

                _settingsRow(
                  icon: Icons.palette_outlined,
                  title: 'App Theme',
                  trailing: const Text(
                    'Light',
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          AppTheme.secondaryText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // =========================
  // ABOUT
  // =========================

  Future<void> _showAbout() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(24),
          ),
          title: const Text(
            'TaskFlow',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: AppTheme.darkGreen,
            ),
          ),
          content: const Text(
            'TaskFlow is a simple and modern task '
            'management app designed to help you '
            'plan your day, organize tasks and '
            'stay focused.\n\n'
            'Version 1.0.0',
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: AppTheme.secondaryText,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
              child: const Text(
                'Close',
                style: TextStyle(
                  color: AppTheme.primaryGreen,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // HELPERS
  // =========================

  InputDecoration _inputDecoration(
    String hint,
    IconData icon,
  ) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(
        icon,
        color: AppTheme.primaryGreen,
        size: 20,
      ),
      filled: true,
      fillColor: AppTheme.background,
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppTheme.primaryGreen,
          width: 1,
        ),
      ),
    );
  }

  Widget _settingsRow({
    required IconData icon,
    required String title,
    required Widget trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 21,
            color: AppTheme.primaryGreen,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.darkGreen,
              ),
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Account',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppTheme.darkGreen,
        ),
      ),
    );
  }

  Widget _buildVersion() {
    return const Text(
      'TaskFlow v1.0.0',
      style: TextStyle(
        fontSize: 10,
        color: AppTheme.secondaryText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          18,
          18,
          18,
          20,
        ),
        child: Column(
          children: [
            ProfileHeader(
              name: profileName,
              email: profileEmail,
            ),

            const SizedBox(height: 24),

            _buildSectionTitle(),

            const SizedBox(height: 10),

            ProfileMenuItem(
              icon:
                  Icons.person_outline_rounded,
              title: 'Edit Profile',
              onTap: _editProfile,
            ),

            ProfileMenuItem(
              icon:
                  Icons.notifications_none_rounded,
              title: 'Notifications',
              onTap: _showNotifications,
            ),

            ProfileMenuItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: _showSettings,
            ),

            ProfileMenuItem(
              icon: Icons.info_outline_rounded,
              title: 'About TaskFlow',
              onTap: _showAbout,
            ),

            const SizedBox(height: 8),

            _buildVersion(),
          ],
        ),
      ),
    );
  }
}