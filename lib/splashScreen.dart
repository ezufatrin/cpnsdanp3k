import 'package:SiapNgabdi/homePage.dart';
import 'package:SiapNgabdi/mainNav.dart';
import 'package:flutter/material.dart';
import 'homepage.dart' hide HomePage;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigation()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/logo.png', // pastikan file ini ada di folder assets
          width: 180,
        ),
      ),
    );
  }
}
