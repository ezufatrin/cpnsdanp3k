import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siapngabdi/features/latihan/model/soal_model.dart';
import 'package:siapngabdi/features/latihan/provider/dependencies.dart';
import '../data/soal_repository.dart';
import 'soal_state.dart';

final soalProvider = StateNotifierProvider<SoalNotifier, SoalState>((ref) {
  final repository = ref.watch(soalRepositoryProvider);
  return SoalNotifier(repository);
});

final kategoriAktifProvider = StateProvider<int>((ref) => 1);

class SoalNotifier extends StateNotifier<SoalState> {
  final SoalRepository repository;

  SoalNotifier(this.repository) : super(SoalState.initial());

  Future<void> loadSoal(int kategoriId) async {
    if (state.soalPerKategori.containsKey(kategoriId)) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final data = await repository.getSoalByKategori(kategoriId);
      final soalList = data.map((json) => Soal.fromJson(json)).toList();

      state = state.copyWith(
        soalPerKategori: {...state.soalPerKategori, kategoriId: soalList},
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void jawab(int kategoriId, int soalIndex, String jawaban) {
    final currentJawaban = {...state.jawabanPerKategori};
    final kategoriJawaban = {...currentJawaban[kategoriId] ?? {}};
    kategoriJawaban[soalIndex] = jawaban;

    state = state.copyWith(
      jawabanPerKategori: {...currentJawaban, kategoriId: kategoriJawaban},
    );
  }

  void resetJawaban(int kategoriId) {
    final currentJawaban = {...state.jawabanPerKategori};
    currentJawaban.remove(kategoriId);

    state = state.copyWith(jawabanPerKategori: currentJawaban);
  }
}
