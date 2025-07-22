import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider untuk kategori aktif
final kategoriAktifProvider = StateProvider<int>((ref) => 1);
final soalKeysProvider = StateProvider<Map<int, List<GlobalKey>>>((ref) => {});

// Provider untuk menyimpan daftar soal per kategori
final soalPerKategoriProvider =
    StateNotifierProvider<SoalNotifier, Map<int, List<Map<String, dynamic>>>>(
      (ref) => SoalNotifier(),
    );

class SoalNotifier extends StateNotifier<Map<int, List<Map<String, dynamic>>>> {
  SoalNotifier() : super({});

  void simpanSoal(int kategoriId, List<Map<String, dynamic>> soal) {
    state = {...state, kategoriId: soal};
  }
}

// Provider untuk menyimpan jawaban pengguna per kategori
final jawabanPerKategoriProvider =
    StateNotifierProvider<JawabanNotifier, Map<int, Map<int, String>>>(
      (ref) => JawabanNotifier(),
    );

class JawabanNotifier extends StateNotifier<Map<int, Map<int, String>>> {
  JawabanNotifier() : super({1: {}, 2: {}, 3: {}});

  void jawab(int kategoriId, int index, String value) {
    final kategoriJawaban = Map<int, String>.from(state[kategoriId] ?? {});
    kategoriJawaban[index] = value;
    state = {...state, kategoriId: kategoriJawaban};
  }
}
