import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final compact = height < 720;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            compact ? 12 : 16,
            compact ? 12 : 16,
            compact ? 12 : 16,
            compact ? 14 : 18,
          ),
          child: Column(
            children: [
              // MAIN PICTURE
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/welcome_person.jpeg',
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: compact ? 14 : 18,
              ),

              // GET STARTED BUTTON
              SizedBox(
                width: double.infinity,
                height: compact ? 54 : 58,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MainScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    "Let's Get Started",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
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
}