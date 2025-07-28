import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/simulasi.dart';

class SimulasiDataSource {
  final _client = Supabase.instance.client;

  Future<List<Simulasi>> fetchSimulasi(int kategoriId) async {
    final result = await _client
        .from('soal')
        .select()
        .eq('kategori_id', kategoriId)
        .order('id');

    return (result as List).map((e) => Simulasi.fromJson(e)).toList();
  }
}
