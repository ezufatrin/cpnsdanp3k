import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/materi.dart';

class MateriDatasource {
  final List<Materi> pdfList = [
    Materi(
      title: "Ringkasan Materi TWK",
      url:
          "https://drive.google.com/uc?export=download&id=1bd2iG68yuTMJdkXG8oTesID6PY2XxxJM",
    ),
    Materi(
      title: "Ringkasan Materi TIU",
      url:
          "https://drive.google.com/uc?export=download&id=1kSahPNro5qKrK9oPjYGJ1pRXJtnWthEv",
    ),
  ];

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  Future<List<Map<String, dynamic>>> loadDownloadedFiles() async {
    final dir = await getApplicationDocumentsDirectory();
    List<Map<String, dynamic>> result = [];

    for (var materi in pdfList) {
      final file = File('${dir.path}/${materi.fileName}');
      if (await file.exists()) {
        result.add({'file': file, 'title': materi.title});
      }
    }

    return result;
  }

  Future<void> downloadAll({
    required Function(int index, double progress, String title) onProgress,
  }) async {
    final prefs = await _prefs;
    final dir = await getApplicationDocumentsDirectory();

    prefs.setBool('materi_in_progress', true);

    for (int i = 0; i < pdfList.length; i++) {
      final materi = pdfList[i];
      final file = File('${dir.path}/${materi.fileName}');

      try {
        final request = await http.Client().send(
          http.Request('GET', Uri.parse(materi.url)),
        );
        final total = request.contentLength ?? 0;
        List<int> bytes = [];
        int received = 0;

        await for (var chunk in request.stream) {
          bytes.addAll(chunk);
          received += chunk.length;
          onProgress(i, total > 0 ? received / total : 0.0, materi.title);
        }

        await file.writeAsBytes(bytes);
      } catch (_) {
        rethrow;
      }
    }

    prefs.setBool('materi_downloaded', true);
    prefs.setBool('materi_in_progress', false);
  }

  Future<bool> isDownloaded() async {
    final prefs = await _prefs;
    return prefs.getBool("materi_downloaded") ?? false;
  }
}
