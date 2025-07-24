import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class OnlinePDFViewer extends StatefulWidget {
  const OnlinePDFViewer({super.key});

  @override
  State<OnlinePDFViewer> createState() => _OnlinePDFViewerState();
}

class _OnlinePDFViewerState extends State<OnlinePDFViewer> {
  File? localPDF;
  bool isLoading = true;

  final String pdfUrl =
      "https://your-server.com/materi_twk.pdf"; // Ganti dengan URL PDF kamu
  final String fileName = "materi_twk.pdf";

  @override
  void initState() {
    super.initState();
    _preparePDF();
  }

  Future<void> _preparePDF() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/$fileName");

    if (!await file.exists()) {
      // download file
      final response = await http.get(Uri.parse(pdfUrl));
      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
      } else {
        throw Exception("Gagal mengunduh PDF");
      }
    }

    setState(() {
      localPDF = file;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Materi TWK"),
        backgroundColor: const Color(0xFF007BFF),
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SfPdfViewer.file(localPDF!),
    );
  }
}
