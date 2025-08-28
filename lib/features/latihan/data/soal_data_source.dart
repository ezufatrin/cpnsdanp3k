import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SoalDataSource {
  Future<List<Map<String, dynamic>>> fetchSoalByKategori(int kategoriId);
}

class SoalDataSourceImpl implements SoalDataSource {
  final SupabaseClient supabase;

  SoalDataSourceImpl(this.supabase);

  @override
  Future<List<Map<String, dynamic>>> fetchSoalByKategori(int kategoriId) async {
    final res = await supabase
        .from('soal')
        .select()
        .eq('kategori_id', kategoriId)
        .order('id');

    return List<Map<String, dynamic>>.from(res);
  }
}
