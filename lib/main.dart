import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siapngabdi/core/theme/theme.dart';
import 'package:siapngabdi/navigation.dart';
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
      home: Navigation(),
      // theme: appTheme,
      theme: ThemeData(
        // Anda bisa gunakan tema yang sudah ada
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          background: const Color(0xFFF4F6FA),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        // Konfigurasi dark mode
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.deepPurple,
          background: const Color(0xFF1A1A1A),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}


// CPNS
//  A. TIU
//   1. Kemampuan Verbal
//   2. Kemampuan Numerik
//   3. Kemampuan Figural
//  B. TWK 
//   1. Pancasila
//   2. NKRI
//   3. UUD 1945
//  C. TKP 



// P3k
//  - Manajerial
//  - Sosiokultural
//  - Wawancara
