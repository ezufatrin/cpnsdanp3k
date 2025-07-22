import 'package:cpnsdanp3k/homePage.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://thyydllpedglmqgvzarb.supabase.co/', // Ganti dengan URL-mu
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRoeXlkbGxwZWRnbG1xZ3Z6YXJiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY3MjM3MTcsImV4cCI6MjA2MjI5OTcxN30.j7jULkkiVdU7tF-DSNzHjPyNodzwEcnuuBijSlJ1yQQ',
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Latihan Soal CPNS',
      home: Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
