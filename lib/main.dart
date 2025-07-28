// import 'package:siapngabdi/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:siapngabdi/contoh.dart';
import 'package:siapngabdi/core/theme/theme.dart';
import 'package:siapngabdi/main_navigation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://thyydllpedglmqgvzarb.supabase.co/',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRoeXlkbGxwZWRnbG1xZ3Z6YXJiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY3MjM3MTcsImV4cCI6MjA2MjI5OTcxN30.j7jULkkiVdU7tF-DSNzHjPyNodzwEcnuuBijSlJ1yQQ',
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Latihan Soal CPNS',
      home: MainNavigation(),
      theme: appTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
