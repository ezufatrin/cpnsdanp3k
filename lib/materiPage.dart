import 'package:flutter/material.dart';
import 'pdfViewPage.dart';

class MateriPage extends StatelessWidget {
  final List<Map<String, String>> materiList = [
    {'title': 'Materi TWK', 'file': 'assets/materitwk.pdf'},
    {'title': 'Materi TIU', 'file': 'assets/materitiu.pdf'},
    {'title': 'Materi TKP', 'file': 'assets/materitkp.pdf'},
  ];

  MateriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Materi'),
        backgroundColor: const Color(0xFF007BFF),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: materiList.length,
        itemBuilder: (context, index) {
          final materi = materiList[index];
          return ListTile(
            leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
            title: Text(materi['title'] ?? ''),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PDFViewerPage(
                    title: materi['title']!,
                    assetPath: materi['file']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
