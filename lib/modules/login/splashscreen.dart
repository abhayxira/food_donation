import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_donation/modules/login/auth.dart';
//import 'package:food_donation/home/home.dart';
import 'package:food_donation/utils/appThems.dart';
//import 'package:food_donation/modules/Home/home_screen.dart'; // Import the home screen

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Animation: fade in from 0 (invisible) to 1 (fully visible)
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    // Start the animation
    _animationController.forward();

    // After 3 seconds, navigate to the home screen
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const AuthPage()), // Replace with your home screen widget
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor
          .white, // You can change this to your preferred background color
      body: Center(
        child: AnimatedOpacity(
          opacity: _animation.value,
          duration: const Duration(seconds: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated logo
              Image.asset(
                'images/logo/onlylogo.png', // Your logo image path
                height: 150, // Set height for your logo
                width: 150, // Set width for your logo
              ),
              const SizedBox(height: 20),
              // App name
              const Text(
                'Refeed',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange, // You can customize this
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
