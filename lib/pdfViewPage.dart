import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
        backgroundColor: const Color(0xFF007BFF),
        foregroundColor: Colors.white,
      ),
      body: SfPdfViewer.asset(assetPath),
    );
  }
}
