import 'package:siapngabdi/features/home/model/news_model.dart';

abstract class HomeDataSource {
  Future<List<String>> getBanners();
  Future<List<NewsModel>> getNews();
}

class HomeDataSourceImpl implements HomeDataSource {
  @override
  Future<List<String>> getBanners() async {
    // Simulasi data dari API
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      'assets/banner1.png',
      'assets/banner2.png',
      'assets/banner1.png',
      'assets/banner2.png',
    ];
  }

  @override
  Future<List<NewsModel>> getNews() async {
    // Simulasi data dari API
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      NewsModel(
        title: "Jadwal Tes CPNS 2025",
        subtitle: "Silahkan periksa jadwal tes CPNS 2025 di sini",
        imageUrl:
            "https://static.promediateknologi.id/crop/0x0:0x0/750x500/webp/photo/p1/04/2024/01/01/CPNS-1675702163.jpeg",
      ),
      NewsModel(
        title: "Pelantiakan PNS dan P3K",
        subtitle: "Hasil pelantikan PNS dan P3K di sini",
        imageUrl:
            "https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/p2/82/2025/03/08/alasan-penundaan-pengangkatan-CPNS-2024-571629709.jpg",
      ),
    ];
  }
}
