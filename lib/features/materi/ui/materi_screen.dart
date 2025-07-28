import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siapngabdi/shared/widget/pdf_view_page.dart';
import '../provider/materi_provider.dart';
import '../data/materi_datasource.dart';

class MateriScreen extends ConsumerStatefulWidget {
  const MateriScreen({super.key});

  @override
  ConsumerState<MateriScreen> createState() => _MateriScreenState();
}

class _MateriScreenState extends ConsumerState<MateriScreen> {
  bool isDownloading = false;
  double progress = 0.0;
  String currentTitle = "";

  Future<void> _downloadMateri() async {
    setState(() => isDownloading = true);
    final ds = ref.read(materiDatasourceProvider);

    try {
      await ds.downloadAll(
        onProgress: (index, p, title) {
          setState(() {
            progress = p;
            currentTitle = title;
          });
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal mengunduh: $currentTitle")));
    }

    setState(() => isDownloading = false);
    ref.invalidate(downloadedMateriProvider);
  }

  @override
  Widget build(BuildContext context) {
    final downloaded = ref.watch(downloadedMateriProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Materi")),
      body: isDownloading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(value: progress),
                  const SizedBox(height: 12),
                  Text("Mengunduh: $currentTitle"),
                  Text("${(progress * 100).toStringAsFixed(0)}%"),
                ],
              ),
            )
          : downloaded.when(
              data: (list) {
                if (list.isEmpty) {
                  return Center(
                    child: ElevatedButton(
                      onPressed: _downloadMateri,
                      child: const Text("Unduh Materi"),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, i) {
                    final file = list[i]['file'] as File;
                    final title = list[i]['title'] as String;

                    return ListTile(
                      leading: const Icon(
                        Icons.picture_as_pdf,
                        color: Colors.red,
                      ),
                      title: Text(title),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PDFViewerPage(title: title, assetPath: file.path),
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text("Error: $e")),
            ),
    );
  }
}
