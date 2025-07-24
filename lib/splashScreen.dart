import 'dart:async';
import 'package:flutter/material.dart';
import 'package:SiapNgabdi/mainNav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Timer untuk pindah halaman dengan animasi setelah 3 detik
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MainNavigation(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Transisi slide dari bawah
            final slide =
                Tween<Offset>(
                  begin: const Offset(0.0, 1.0), // dari bawah
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut, // lebih terasa animasinya
                  ),
                );

            return SlideTransition(position: slide, child: child);
          },
          transitionDuration: const Duration(milliseconds: 600),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gambar background full layar
          Positioned.fill(
            child: Image.asset(
              'assets/splashscreen.png', // Pastikan file ini benar-benar ada
              fit: BoxFit.cover,
            ),
          ),

          // Loading spinner tepat 200px dari bawah
          Positioned(
            bottom: 200, // jangan diubah sesuai instruksi
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: const [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
