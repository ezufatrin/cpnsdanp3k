import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerPage extends StatelessWidget {
  final String title;
  final String assetPath;

  const PDFViewerPage({
    super.key,
    required this.title,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color.fromARGB(255, 212, 219, 226),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        top: false, // mepet atas (langsung di bawah AppBar)
        bottom: true, // tetap aman dengan home indicator iOS
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: PDFView(
            filePath: assetPath,
            enableSwipe: true,
            swipeHorizontal: false, // vertical scroll
            autoSpacing: false, // <-- hilangkan gap antar halaman
            pageFling: false, // <-- no fling per page
            pageSnap: false, // <-- no snap per page
            // fitPolicy: FitPolicy.WIDTH, // opsional: fit lebar layar
            onError: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Gagal memuat PDF: $error")),
              );
            },
          ),
        ),
      ),
    );
  }
}
