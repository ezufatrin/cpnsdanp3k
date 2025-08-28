import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/soal_data_source.dart';
import '../data/soal_repository.dart';

final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final soalDataSourceProvider = Provider<SoalDataSource>((ref) {
  final supabase = ref.watch(supabaseProvider);
  return SoalDataSourceImpl(supabase);
});

final soalRepositoryProvider = Provider<SoalRepository>((ref) {
  final dataSource = ref.watch(soalDataSourceProvider);
  return SoalRepositoryImpl(dataSource);
});
