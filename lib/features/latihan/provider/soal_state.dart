import '../model/soal_model.dart';

class SoalState {
  final Map<int, List<Soal>> soalPerKategori;
  final Map<int, Map<int, String>> jawabanPerKategori;
  final bool isLoading;
  final String? error;

  SoalState({
    required this.soalPerKategori,
    required this.jawabanPerKategori,
    required this.isLoading,
    this.error,
  });

  SoalState.initial()
    : soalPerKategori = {},
      jawabanPerKategori = {},
      isLoading = false,
      error = null;

  SoalState copyWith({
    Map<int, List<Soal>>? soalPerKategori,
    Map<int, Map<int, String>>? jawabanPerKategori,
    bool? isLoading,
    String? error,
  }) {
    return SoalState(
      soalPerKategori: soalPerKategori ?? this.soalPerKategori,
      jawabanPerKategori: jawabanPerKategori ?? this.jawabanPerKategori,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
