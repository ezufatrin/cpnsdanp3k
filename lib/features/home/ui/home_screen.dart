import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siapngabdi/core/theme/colors.dart';
import 'package:siapngabdi/features/home/model/news_model.dart';
import 'package:siapngabdi/features/home/provider/home_provider.dart';
import 'package:siapngabdi/features/home/data/home_data_source.dart';
import 'package:siapngabdi/features/home/data/home_repository.dart';

import '../ui/widgets/header.dart';
import '../ui/widgets/hero_banner.dart';
import '../ui/components/section_title.dart';
import '../ui/widgets/quick_access.dart';
import '../ui/widgets/content_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(
        repository: HomeRepositoryImpl(dataSource: HomeDataSourceImpl()),
      ),
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    // Load data saat pertama kali dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeProvider.loadHomeData();
    });

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Consumer<HomeProvider>(
          builder: (context, homeProvider, child) {
            if (homeProvider.state.isLoading &&
                homeProvider.state.banners.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (homeProvider.state.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${homeProvider.state.error}'),
                    ElevatedButton(
                      onPressed: homeProvider.refresh,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              children: [
                _buildHeader("Ezu", theme),
                const SizedBox(height: 24),
                _buildHeroBanner(homeProvider.state.banners),
                const SizedBox(height: 24),
                _buildSectionTitle("Kategori", theme),
                const SizedBox(height: 12),
                _buildQuickAccess(theme, context),
                const SizedBox(height: 24),
                _buildSectionTitle("Berita Terkini ✨", theme),
                const SizedBox(height: 12),
                _buildForYouFeed(theme, homeProvider.state.news),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(String userName, ThemeData theme) {
    return HomeHeader(userName: userName, theme: theme);
  }

  Widget _buildHeroBanner(List<String> banners) {
    return HeroBannerCarousel(images: banners, borderRadius: 20);
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return SectionTitle(title: title, theme: theme);
  }

  Widget _buildQuickAccess(ThemeData theme, BuildContext context) {
    return QuickAccessGrid(theme: theme, context: context);
  }

  Widget _buildForYouFeed(ThemeData theme, List<NewsModel> news) {
    return Column(
      children: [
        for (var newsItem in news)
          Column(
            children: [
              ContentCard(
                title: newsItem.title,
                subtitle: newsItem.subtitle,
                imageUrl: newsItem.imageUrl,
                theme: theme,
              ),
              if (newsItem != news.last) const SizedBox(height: 16),
            ],
          ),
      ],
    );
  }
}
