import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/simulasi.dart';
import '../data/simulasi_datasource.dart';

final simulasiProvider = FutureProvider.family<List<Simulasi>, int>((
  ref,
  kategoriId,
) async {
  final datasource = SimulasiDataSource();
  return datasource.fetchSimulasi(kategoriId);
});
