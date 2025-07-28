import 'package:siapngabdi/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;

    // Cek apakah user sudah login
    if (session != null) {
      return const MainNavigation();
    } else {
      return const LoginScreen();
    }
  }
}
