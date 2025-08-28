import 'package:siapngabdi/features/home/data/home_data_source.dart';

import '../model/news_model.dart';

abstract class HomeRepository {
  Future<List<String>> fetchBanners();
  Future<List<NewsModel>> fetchNews();
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource dataSource;

  HomeRepositoryImpl({required this.dataSource});

  @override
  Future<List<String>> fetchBanners() async {
    try {
      return await dataSource.getBanners();
    } catch (e) {
      throw Exception('Failed to fetch banners: $e');
    }
  }

  @override
  Future<List<NewsModel>> fetchNews() async {
    try {
      return await dataSource.getNews();
    } catch (e) {
      throw Exception('Failed to fetch news: $e');
    }
  }
}
