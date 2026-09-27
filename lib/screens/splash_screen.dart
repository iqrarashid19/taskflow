
import 'dart:async';

import 'package:flutter/material.dart';

import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _fade;
  late Animation<double> _scale;
  late Animation<double> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1400,
      ),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _scale = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _slide = Tween<double>(
      begin: 35,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();

    // Splash duration: 4 seconds
    Timer(
      const Duration(seconds: 4),
      () {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const WelcomeScreen(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF2F6EF),
      body: SafeArea(
        child: Stack(
          children: [
            _buildBackground(),

            _buildTopDecoration(),

            _buildBottomDecoration(),

            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder:
                    (context, child) {
                  return FadeTransition(
                    opacity: _fade,
                    child:
                        Transform.translate(
                      offset: Offset(
                        0,
                        _slide.value,
                      ),
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min,
                        children: [
                          ScaleTransition(
                            scale: _scale,
                            child:
                                _buildLogo(),
                          ),

                          const SizedBox(
                            height: 24,
                          ),

                          const Text(
                            'TaskFlow',
                            style:
                                TextStyle(
                              fontSize: 36,
                              fontWeight:
                                  FontWeight.w800,
                              letterSpacing:
                                  -1.2,
                              color:
                                  Color(
                                0xFF18351F,
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          const Text(
                            'Plan smarter. Work better.',
                            style:
                                TextStyle(
                              fontSize: 13,
                              fontWeight:
                                  FontWeight.w500,
                              letterSpacing:
                                  0.2,
                              color:
                                  Color(
                                0xFF7C897F,
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 28,
                          ),

                          _buildProgress(),

                          const SizedBox(
                            height: 10,
                          ),

                          const Text(
                            'Organizing your day...',
                            style:
                                TextStyle(
                              fontSize: 9,
                              fontWeight:
                                  FontWeight.w500,
                              color:
                                  Color(
                                0xFF9AA69C,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 18,
              child: FadeTransition(
                opacity: _fade,
                child: const Text(
                  'YOUR DAY. YOUR FLOW.',
                  textAlign:
                      TextAlign.center,
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight:
                        FontWeight.w700,
                    letterSpacing: 2.2,
                    color:
                        Color(0xFF9AA69C),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // LOGO
  // =========================

  Widget _buildLogo() {
    return Container(
      height: 112,
      width: 112,
      decoration: BoxDecoration(
        color: const Color(
          0xFF064D1F,
        ),
        borderRadius:
            BorderRadius.circular(34),
        boxShadow: [
          BoxShadow(
            color: const Color(
              0xFF064D1F,
            ).withValues(alpha: 0.18),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 12,
            right: 13,
            child: Container(
              height: 10,
              width: 10,
              decoration:
                  const BoxDecoration(
                color:
                    Color(0xFFF3F0D8),
                shape:
                    BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            bottom: 13,
            left: 13,
            child: Container(
              height: 7,
              width: 7,
              decoration:
                  const BoxDecoration(
                color:
                    Color(0xFFE5F0E4),
                shape:
                    BoxShape.circle,
              ),
            ),
          ),

          Center(
            child: Container(
              height: 66,
              width: 66,
              decoration: BoxDecoration(
                color: Colors.white
                    .withValues(
                  alpha: 0.10,
                ),
                shape:
                    BoxShape.circle,
                border: Border.all(
                  color: Colors.white
                      .withValues(
                    alpha: 0.12,
                  ),
                ),
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 43,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // PROGRESS
  // =========================

  Widget _buildProgress() {
    return Container(
      height: 5,
      width: 92,
      decoration: BoxDecoration(
        color: const Color(
          0xFFDDE7DC,
        ),
        borderRadius:
            BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: 5,
          width: 42,
          decoration: BoxDecoration(
            color: const Color(
              0xFF064D1F,
            ),
            borderRadius:
                BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // =========================
  // BACKGROUND
  // =========================

  Widget _buildBackground() {
    return Stack(
      children: [
        Positioned(
          top: -80,
          right: -65,
          child: Container(
            height: 210,
            width: 210,
            decoration:
                const BoxDecoration(
              color:
                  Color(0xFFE5F0E4),
              shape:
                  BoxShape.circle,
            ),
          ),
        ),

        Positioned(
          bottom: -90,
          left: -70,
          child: Container(
            height: 220,
            width: 220,
            decoration:
                const BoxDecoration(
              color:
                  Color(0xFFF3F0D8),
              shape:
                  BoxShape.circle,
            ),
          ),
        ),

        Positioned(
          top: 145,
          left: -25,
          child: Container(
            height: 65,
            width: 65,
            decoration:
                const BoxDecoration(
              color:
                  Color(0xFFF3E5ED),
              shape:
                  BoxShape.circle,
            ),
          ),
        ),

        Positioned(
          bottom: 170,
          right: -22,
          child: Container(
            height: 58,
            width: 58,
            decoration:
                const BoxDecoration(
              color:
                  Color(0xFFE5EDF2),
              shape:
                  BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  // =========================
  // TOP DECORATION
  // =========================

  Widget _buildTopDecoration() {
    return Stack(
      children: [
        Positioned(
          top: 55,
          left: 25,
          child: _miniCheck(),
        ),

        Positioned(
          top: 105,
          right: 26,
          child: _miniCalendar(),
        ),

        Positioned(
          top: 190,
          left: 28,
          child: _miniDot(),
        ),

        Positioned(
          top: 220,
          right: 42,
          child: _miniDot(
            size: 8,
            color:
                const Color(
              0xFF064D1F,
            ),
          ),
        ),
      ],
    );
  }

  // =========================
  // BOTTOM DECORATION
  // =========================

  Widget _buildBottomDecoration() {
    return Stack(
      children: [
        Positioned(
          bottom: 115,
          left: 25,
          child: _miniTaskCard(
            icon: Icons.check_rounded,
            text: 'Completed',
            color:
                const Color(
              0xFFE5F0E4,
            ),
          ),
        ),

        Positioned(
          bottom: 185,
          right: 20,
          child: _miniTaskCard(
            icon:
                Icons.access_time_rounded,
            text: 'Focus',
            color:
                const Color(
              0xFFF3F0D8,
            ),
          ),
        ),

        Positioned(
          bottom: 92,
          right: 55,
          child: _miniDot(
            size: 7,
            color:
                const Color(
              0xFF064D1F,
            ),
          ),
        ),

        Positioned(
          bottom: 235,
          left: 50,
          child: _miniDot(
            size: 6,
            color:
                const Color(
              0xFF9AA69C,
            ),
          ),
        ),
      ],
    );
  }

  // =========================
  // SMALL UI ELEMENTS
  // =========================

  Widget _miniCheck() {
    return Container(
      height: 38,
      width: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(13),
        border: Border.all(
          color:
              const Color(0xFFE0E8DE),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withValues(alpha: 0.04),
            blurRadius: 12,
            offset:
                const Offset(0, 5),
          ),
        ],
      ),
      child: const Icon(
        Icons.check_rounded,
        size: 19,
        color:
            Color(0xFF064D1F),
      ),
    );
  }

  Widget _miniCalendar() {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),
        border: Border.all(
          color:
              const Color(0xFFE0E8DE),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withValues(alpha: 0.04),
            blurRadius: 14,
            offset:
                const Offset(0, 6),
          ),
        ],
      ),
      child: const Icon(
        Icons.calendar_month_rounded,
        size: 22,
        color:
            Color(0xFF064D1F),
      ),
    );
  }

  Widget _miniTaskCard({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      width: 105,
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),
        border: Border.all(
          color:
              const Color(0xFFE0E8DE),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withValues(alpha: 0.045),
            blurRadius: 14,
            offset:
                const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 27,
            width: 27,
            decoration: BoxDecoration(
              color: color,
              borderRadius:
                  BorderRadius.circular(9),
            ),
            child: Icon(
              icon,
              size: 15,
              color:
                  const Color(
                0xFF064D1F,
              ),
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow:
                  TextOverflow.ellipsis,
              style:
                  const TextStyle(
                fontSize: 9,
                fontWeight:
                    FontWeight.w700,
                color:
                    Color(0xFF18351F),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniDot({
    double size = 10,
    Color color =
        const Color(0xFF7C897F),
  }) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

