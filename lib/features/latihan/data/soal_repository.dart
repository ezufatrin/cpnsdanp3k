import 'soal_data_source.dart';

abstract class SoalRepository {
  Future<List<Map<String, dynamic>>> getSoalByKategori(int kategoriId);
}

class SoalRepositoryImpl implements SoalRepository {
  final SoalDataSource dataSource;

  SoalRepositoryImpl(this.dataSource);

  @override
  Future<List<Map<String, dynamic>>> getSoalByKategori(int kategoriId) async {
    try {
      return await dataSource.fetchSoalByKategori(kategoriId);
    } catch (e) {
      throw Exception('Failed to fetch soal: $e');
    }
  }
}
