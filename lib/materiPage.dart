import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pdfViewPage.dart';

class MateriPage extends StatefulWidget {
  const MateriPage({super.key});

  @override
  State<MateriPage> createState() => _MateriPageState();
}

class _MateriPageState extends State<MateriPage> {
  final List<Map<String, String>> pdfList = [
    {
      "title": "Ringkasan Materi TWK",
      "url":
          "https://drive.google.com/uc?export=download&id=1bd2iG68yuTMJdkXG8oTesID6PY2XxxJM",
    },
    {
      "title": "Ringkasan Materi TIU",
      "url":
          "https://drive.google.com/uc?export=download&id=1kSahPNro5qKrK9oPjYGJ1pRXJtnWthEv",
    },
  ];

  List<Map<String, dynamic>> downloadedFiles = [];
  bool isDownloading = false;
  int currentFileIndex = -1;
  double downloadProgress = 0.0;
  bool hasPromptedDownload = false;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool alreadyDownloaded = prefs.getBool("materi_downloaded") ?? false;
    bool isInProgress = prefs.getBool("materi_in_progress") ?? false;
    hasPromptedDownload = prefs.getBool("materi_prompted") ?? false;

    if (alreadyDownloaded) {
      await _loadExistingFiles();
    } else if (isInProgress) {
      int lastIndex = prefs.getInt("materi_last_downloaded_index") ?? 0;
      _startDownload(resumeFromIndex: lastIndex);
    } else if (!hasPromptedDownload) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showDownloadPrompt();
      });
    }
  }

  Future<void> _loadExistingFiles() async {
    final dir = await getApplicationDocumentsDirectory();
    downloadedFiles.clear();
    for (var pdf in pdfList) {
      final title = pdf['title']!;
      final fileName = "${title.replaceAll(' ', '_').toLowerCase()}.pdf";
      final file = File("${dir.path}/$fileName");
      if (await file.exists()) {
        downloadedFiles.add({"file": file, "title": title});
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _showDownloadPrompt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("materi_prompted", true);

    double approxSizeMb = pdfList.length * 1.5;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Unduh Materi?"),
        content: Text(
          "Untuk pertama kali, Anda perlu mengunduh materi sebesar sekitar ${approxSizeMb.toStringAsFixed(1)} MB. Lanjutkan?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _startDownload();
            },
            child: const Text("Unduh"),
          ),
        ],
      ),
    );
  }

  Future<void> _startDownload({int resumeFromIndex = 0}) async {
    final prefs = await SharedPreferences.getInstance();
    final dir = await getApplicationDocumentsDirectory();

    downloadedFiles.clear();
    for (int i = 0; i < resumeFromIndex; i++) {
      final title = pdfList[i]['title']!;
      final fileName = "${title.replaceAll(' ', '_').toLowerCase()}.pdf";
      final file = File("${dir.path}/$fileName");
      if (await file.exists()) {
        downloadedFiles.add({"file": file, "title": title});
      }
    }

    prefs.setBool("materi_in_progress", true);
    setState(() {
      isDownloading = true;
      currentFileIndex = resumeFromIndex;
    });

    for (int i = resumeFromIndex; i < pdfList.length; i++) {
      final title = pdfList[i]['title']!;
      final url = pdfList[i]['url']!;
      final fileName = "${title.replaceAll(' ', '_').toLowerCase()}.pdf";
      final file = File("${dir.path}/$fileName");

      try {
        final request = await http.Client().send(
          http.Request('GET', Uri.parse(url)),
        );
        final totalBytes = request.contentLength ?? 0;
        List<int> bytes = [];
        int received = 0;

        await for (var chunk in request.stream) {
          bytes.addAll(chunk);
          received += chunk.length;
          if (mounted) {
            setState(() {
              downloadProgress = totalBytes > 0 ? received / totalBytes : 0.0;
            });
          }
        }

        await file.writeAsBytes(bytes);
        downloadedFiles.add({"file": file, "title": title});
        prefs.setInt("materi_last_downloaded_index", i + 1);
      } catch (_) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Gagal mengunduh: $title")));
        }
      }
    }

    prefs.setBool("materi_downloaded", true);
    prefs.setBool("materi_in_progress", false);
    prefs.remove("materi_last_downloaded_index");

    if (mounted) {
      setState(() {
        isDownloading = false;
        currentFileIndex = -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoadingWidget = isDownloading && currentFileIndex >= 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Materi"),
        backgroundColor: const Color(0xFF007BFF),
        foregroundColor: Colors.white,
      ),
      body: isLoadingWidget
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(value: downloadProgress),
                  const SizedBox(height: 12),
                  Text("Mengunduh: ${pdfList[currentFileIndex]['title']}"),
                  Text("${(downloadProgress * 100).toStringAsFixed(0)}%"),
                ],
              ),
            )
          : downloadedFiles.isEmpty
          ? const Center(child: Text("Belum ada materi tersedia."))
          : ListView.builder(
              itemCount: downloadedFiles.length,
              itemBuilder: (context, index) {
                final file = downloadedFiles[index]["file"] as File;
                final title = downloadedFiles[index]["title"] as String;
                return ListTile(
                  leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                  title: Text(title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PDFViewerPage(title: title, assetPath: file.path),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
