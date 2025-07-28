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
          return ListTile(
            title: Text(kategori['nama']),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SimulasiSoalScreen(kategoriId: 2),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
