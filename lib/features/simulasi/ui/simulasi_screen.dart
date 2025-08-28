import 'package:flutter/material.dart';
import 'package:siapngabdi/features/simulasi/ui/simulasi_soal_screen.dart';

class SimulasiScreen extends StatelessWidget {
  final List<Map<String, dynamic>> kategoriList = [
    {"id": 1, "nama": "TWK"},
    {"id": 2, "nama": "TIU"},
    {"id": 3, "nama": "TKP"},
  ];

  SimulasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simulasi')),
      body: ListView.builder(
        itemCount: kategoriList.length,
        itemBuilder: (context, index) {
          final kategori = kategoriList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      SimulasiSoalScreen(kategoriId: kategori['id']),
                ),
              );
            },
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.menu_book_rounded, // bisa juga Icons.assignment
                      size: 28,
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        kategori['nama'], // <– ganti sesuai field JSON Anda
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937), // abu gelap modern
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
