import 'dart:async';

import 'package:siapngabdi/LatihanSoalScreen/latihan_soal_screen.dart';
import 'package:siapngabdi/core/theme/colors.dart';
import 'package:siapngabdi/core/theme/typography.dart';
import 'package:siapngabdi/features/materi/ui/materi_screen.dart';
import 'package:siapngabdi/features/simulasi/ui/simulasi_screen.dart';
import 'package:siapngabdi/tipsPage.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  final List<String> bannerImages = [
    'assets/banner1.png',
    'assets/banner2.png',
    'assets/banner1.png',
    'assets/banner2.png',
  ];
  int _currentPage = 0;
  Timer? _timer;

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < bannerImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: const Color(0xFF007BFF), // Warna biru dari logo
        title: const Text("Siap Ngabdi", style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.black),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 20),
            _buildBanner(),
            const SizedBox(height: 20),
            const Text(
              "Kategori",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildCategoryRow(),
            const SizedBox(height: 20),
            const Text(
              "Top Course",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildTopCourses(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Cari course...",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: PageView.builder(
              controller: _pageController,
              itemCount: bannerImages.length,
              onPageChanged: (index) {
                _currentPage = index; // update page saat swipe manual
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  bannerImages[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
            ),
          ),
          Positioned(
            bottom: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: bannerImages.length,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 6,
                  activeDotColor: Colors.blue,
                  dotColor: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildBanner() {
  //   return Container(
  //     height: 150,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(12),
  //       color: Colors.grey[200], // fallback jika gambar error
  //     ),
  //     child: Stack(
  //       alignment: Alignment.bottomCenter,
  //       children: [
  //         ClipRRect(
  //           borderRadius: BorderRadius.circular(12),
  //           child: PageView.builder(
  //             controller: _pageController,
  //             itemCount: bannerImages.length,
  //             itemBuilder: (context, index) {
  //               return Image.asset(
  //                 bannerImages[index],
  //                 fit: BoxFit.cover,
  //                 width: double.infinity,
  //               );
  //             },
  //           ),
  //         ),
  //         // Dot indicator di dalam kotak
  //         Positioned(
  //           bottom: 8,
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  //             decoration: BoxDecoration(
  //               color: Colors.white.withOpacity(0.7),
  //               borderRadius: BorderRadius.circular(20),
  //             ),
  //             child: SmoothPageIndicator(
  //               controller: _pageController,
  //               count: bannerImages.length,
  //               effect: WormEffect(
  //                 dotHeight: 8,
  //                 dotWidth: 8,
  //                 spacing: 6,
  //                 activeDotColor: Colors.blue,
  //                 dotColor: Colors.grey,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildCategoryRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _CategoryItem(
          icon: Icons.code,

          label: "Materi",
          onTap: (context) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MateriScreen()),
            );
          },
        ),
        _CategoryItem(
          icon: Icons.design_services,
          label: "Latihan Soal",
          onTap: (context) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LatihanSoal()),
            );
          },
        ),
        _CategoryItem(
          icon: Icons.router,
          label: "Simulasi",
          onTap: (context) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SimulasiScreen()),
            );
          },
        ),
        _CategoryItem(
          icon: Icons.devices,
          label: "Tips",
          onTap: (context) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Tipspage()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTopCourses() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          _CourseCard(title: "TWK", price: "100 SOAL"),
          _CourseCard(title: "TIU", price: "100 SOAL"),
          _CourseCard(title: "TKP", price: "100 SOAL"),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final void Function(BuildContext context) onTap;
  const _CategoryItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: const Color(0xFF007BFF),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(label, style: AppTextStyles.body),
        ],
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final String title;
  final String price;
  const _CourseCard({required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 160,
          height: 120,
          margin: const EdgeInsets.only(right: 12),
          // padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            image: const DecorationImage(
              image: AssetImage('assets/image1.png'),
              fit: BoxFit.cover,
            ),

            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Placeholder(fallbackHeight: 80),
              const SizedBox(height: 5),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(price, style: const TextStyle(color: Color(0xFF007BFF))),
            ],
          ),
        ),
      ],
    );
  }
}
