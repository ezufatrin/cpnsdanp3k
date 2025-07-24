import 'dart:io';
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
        backgroundColor: const Color(0xFF007BFF),
        foregroundColor: Colors.white,
      ),
      body: PDFView(
        filePath: assetPath,
        autoSpacing: true,
        enableSwipe: true,
        swipeHorizontal: false,
        pageSnap: true,
        pageFling: true,
        onError: (error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Gagal membuka PDF: $error")));
        },
        onRender: (_pages) {},
      ),
    );
  }
}


// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class PDFViewerPage extends StatelessWidget {
//   final String title;
//   final String assetPath;

//   const PDFViewerPage({
//     super.key,
//     required this.title,
//     required this.assetPath,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         backgroundColor: const Color(0xFF007BFF),
//         foregroundColor: Colors.white,
//       ),
//       body: SfPdfViewer.file(File(assetPath)),
//     );
//   }
// }


