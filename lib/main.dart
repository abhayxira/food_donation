import 'package:flutter/material.dart';
//import 'package:food_donation/modules/Ngo/NgoDetiledpage/ngoDetiled.dart';
import 'package:food_donation/modules/login/splashscreen.dart';
import 'package:food_donation/utils/appThems.dart';
//import 'package:food_donation/modules/Ngo/NgoDetiledpage/ngoDetiled.dart';
//import 'package:food_donation/modules/login/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Donation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        hintColor: AppColor.ornage,
        primaryColor: AppColor.ornage,
        useMaterial3: true,
      ),
      home: const SplashPage(),
      // NGODetailsPage(),
    );
  }
}
