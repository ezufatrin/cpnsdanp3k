import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/materi_datasource.dart';

final materiDatasourceProvider = Provider((ref) => MateriDatasource());

final downloadedMateriProvider = FutureProvider((ref) async {
  final data = ref.watch(materiDatasourceProvider);
  return data.loadDownloadedFiles();
});
