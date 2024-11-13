import 'package:flutter/material.dart';
import 'package:food_donation/home/home.dart';
import 'package:food_donation/modules/login/SignupPage.dart';
import 'package:food_donation/modules/login/login.dart';
import 'package:food_donation/utils/appThems.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //  mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 140,
              ),
              const Text(
                'ZERO WASTE',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppColor.ornage,
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                'your food donation partner',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.black,
                  //    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const LoginPage()), // Replace with your home screen widget
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.ornage,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'LOG IN',
                  style: TextStyle(color: AppColor.white),
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const SignupPage()), // Replace with your home screen widget
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColor.ornage,
                  side: const BorderSide(color: AppColor.ornage),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('SIGN UP'),
              ),
              const Spacer(),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const HomePage()), // Replace with your home screen widget
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: AppColor.ornage,
                ),
                child: const Text('Skip for now >>'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
