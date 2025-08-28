import 'package:flutter/foundation.dart';
import '../data/home_repository.dart';
import 'home_state.dart';

class HomeProvider with ChangeNotifier {
  final HomeRepository repository;
  HomeState _state = HomeState.initial();

  HomeState get state => _state;

  HomeProvider({required this.repository});

  Future<void> loadHomeData() async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final banners = await repository.fetchBanners();
      final news = await repository.fetchNews();

      _state = _state.copyWith(banners: banners, news: news, isLoading: false);
    } catch (e) {
      _state = _state.copyWith(isLoading: false, error: e.toString());
    }

    notifyListeners();
  }

  void refresh() {
    loadHomeData();
  }
}
