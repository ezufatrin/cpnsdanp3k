import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Provider untuk daftar kursus (CPNS, P3K)
final courseListProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final response = await Supabase.instance.client
      .from('courses')
      .select('id, name');

  return List<Map<String, dynamic>>.from(response);
});

/// Provider untuk daftar kategori berdasarkan course_id
final kategoriListProvider =
    FutureProvider.family<List<Map<String, dynamic>>, int>((
      ref,
      courseId,
    ) async {
      final response = await Supabase.instance.client
          .from('categories')
          .select('id, name')
          .eq('course_id', courseId);
      return List<Map<String, dynamic>>.from(response);
    });

/// Provider untuk daftar materi berdasarkan category_id
final materiListProvider =
    FutureProvider.family<List<Map<String, dynamic>>, int>((
      ref,
      categoryId,
    ) async {
      final response = await Supabase.instance.client
          .from('materials')
          .select('id, title, pdf_url')
          .eq('category_id', categoryId);
      return List<Map<String, dynamic>>.from(response);
    });

final materiCountProvider = FutureProvider.family<int, int>((
  ref,
  courseId,
) async {
  final result = await Supabase.instance.client
      .from('materials')
      .select('id')
      .eq('course_id', courseId);

  return result.length;
});
