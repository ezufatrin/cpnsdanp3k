import '../model/home_model.dart';
import '../model/news_model.dart';

class HomeState {
  final List<String> banners;
  final List<NewsModel> news;
  final bool isLoading;
  final String? error;

  HomeState({
    required this.banners,
    required this.news,
    required this.isLoading,
    this.error,
  });

  HomeState.initial()
    : banners = [],
      news = [],
      isLoading = false,
      error = null;

  HomeState copyWith({
    List<String>? banners,
    List<NewsModel>? news,
    bool? isLoading,
    String? error,
  }) {
    return HomeState(
      banners: banners ?? this.banners,
      news: news ?? this.news,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
