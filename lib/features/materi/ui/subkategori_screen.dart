import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:siapngabdi/features/materi/provider/materi_provider.dart';
import 'package:siapngabdi/shared/widget/pdf_view_page.dart';
import 'package:siapngabdi/shared/widget/web_view_page.dart';

class SubKategoriScreen extends ConsumerStatefulWidget {
  final int categoryId;
  const SubKategoriScreen({super.key, required this.categoryId});

  @override
  ConsumerState<SubKategoriScreen> createState() => _SubKategoriScreenState();
}

class _SubKategoriScreenState extends ConsumerState<SubKategoriScreen> {
  final Map<String, bool> isDownloading = {};

  String _generateFileName(String title) {
    return title
            .replaceAll(RegExp(r'[\\\\/:*?"<>|]'), '')
            .replaceAll(' ', '_') +
        '.pdf';
  }

  Future<File> _getLocalFile(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$fileName');
  }

  Future<bool> _isFileExists(String fileName) async {
    final file = await _getLocalFile(fileName);
    return file.exists();
  }

  @override
  Widget build(BuildContext context) {
    final materiList = ref.watch(materiListProvider(widget.categoryId));

    return Scaffold(
      backgroundColor: Colors.grey[50], // Latar belakang yang lebih soft
      appBar: AppBar(
        title: const Text(
          'Materi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF2C3E50)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: materiList.when(
        data: (list) => ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final item = list[index];
            final title = item['title'];
            final url = item['pdf_url'];
            final fileName = _generateFileName(title);

            return FutureBuilder<bool>(
              future: _isFileExists(fileName),
              builder: (context, snapshot) {
                return MaterialItemCard(
                  title: title,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WebViewPage(title: title, url: url),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class MaterialItemCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const MaterialItemCard({required this.title, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Row(
              children: [
                // Mengganti ikon dengan elemen visual yang minimalis
                Container(
                  width: 6,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3498DB),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C3E50),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
