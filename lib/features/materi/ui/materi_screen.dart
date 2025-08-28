import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siapngabdi/core/theme/colors.dart';
import 'package:siapngabdi/core/theme/typography.dart';
import 'package:siapngabdi/features/materi/provider/materi_provider.dart';
import 'kategori_screen.dart';

class MateriScreen extends ConsumerWidget {
  const MateriScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final courseList = ref.watch(courseListProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Materi Kursus', style: theme.textTheme.headlineSmall),
        centerTitle: false,
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: courseList.when(
                data: (list) => ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final course = list[index];
                    final materiCountAsync = ref.watch(
                      materiCountProvider(course['id']),
                    );
                    return materiCountAsync.when(
                      data: (materiCount) {
                        return ModernCourseCard(
                          title: course['name'],
                          materiCount: materiCount,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    KategoriScreen(courseId: course['id']),
                              ),
                            );
                          },
                        );
                      },
                      loading: () => const CourseCardPlaceholder(),
                      error: (e, _) => Center(child: Text("Error: $e")),
                    );
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(
                  child: Text(
                    'Error: $e',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModernCourseCard extends StatelessWidget {
  final String title;
  final int materiCount;
  final VoidCallback onTap;

  const ModernCourseCard({
    required this.title,
    required this.materiCount,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFF0F4F7),
                      ),
                      child: const Icon(
                        Icons.library_books,
                        color: Color(0xFF3498DB),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2C3E50),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFECF0F1)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${materiCount.toString()} Materi',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CourseCardPlaceholder extends StatelessWidget {
  const CourseCardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
