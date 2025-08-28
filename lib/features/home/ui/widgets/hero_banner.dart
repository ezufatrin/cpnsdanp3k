import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HeroBannerCarousel extends StatefulWidget {
  const HeroBannerCarousel({
    super.key,
    required this.images,
    this.borderRadius = 16,
  });

  final List<String> images;
  final double borderRadius;

  @override
  State<HeroBannerCarousel> createState() => _HeroBannerCarouselState();
}

class _HeroBannerCarouselState extends State<HeroBannerCarousel> {
  late final PageController _ctrl;
  Timer? _timer;
  bool _dragging = false;

  @override
  void initState() {
    super.initState();
    _ctrl = PageController(viewportFraction: .94);
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted || !_ctrl.hasClients || _dragging || widget.images.isEmpty)
        return;
      final next = ((_ctrl.page ?? 0).round() + 1) % widget.images.length;
      _ctrl.animateToPage(
        next,
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final dpr = MediaQuery.of(context).devicePixelRatio;
    final cacheW = (MediaQuery.of(context).size.width * dpr).round();

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 7,
          child: NotificationListener<ScrollNotification>(
            onNotification: (n) {
              if (n is ScrollStartNotification) _dragging = true;
              if (n is ScrollEndNotification) _dragging = false;
              return false;
            },
            child: PageView.builder(
              controller: _ctrl,
              itemCount: widget.images.length,
              itemBuilder: (_, i) => ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: Material(
                  color: cs.surface,
                  elevation: 1.5,
                  shadowColor: Colors.black.withOpacity(.06),
                  child: Image.asset(
                    widget.images[i],
                    fit: BoxFit.cover,
                    cacheWidth: cacheW,
                    errorBuilder: (_, __, ___) =>
                        ColoredBox(color: cs.surfaceVariant),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SmoothPageIndicator(
          controller: _ctrl,
          count: widget.images.length,
          effect: ExpandingDotsEffect(
            dotHeight: 6,
            dotWidth: 6,
            spacing: 6,
            activeDotColor: cs.primary,
            dotColor: cs.outlineVariant,
          ),
        ),
      ],
    );
  }
}
