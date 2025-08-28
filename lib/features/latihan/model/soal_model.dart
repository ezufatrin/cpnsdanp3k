class Soal {
  final int id;
  final int kategoriId;
  final String pertanyaan;
  final String pilihanA;
  final String pilihanB;
  final String pilihanC;
  final String pilihanD;
  final String pilihanE;

  Soal({
    required this.id,
    required this.kategoriId,
    required this.pertanyaan,
    required this.pilihanA,
    required this.pilihanB,
    required this.pilihanC,
    required this.pilihanD,
    required this.pilihanE,
  });

  factory Soal.fromJson(Map<String, dynamic> json) {
    return Soal(
      id: json['id'],
      kategoriId: json['kategori_id'],
      pertanyaan: json['pertanyaan'],
      pilihanA: json['pilihan_a'],
      pilihanB: json['pilihan_b'],
      pilihanC: json['pilihan_c'],
      pilihanD: json['pilihan_d'],
      pilihanE: json['pilihan_e'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kategori_id': kategoriId,
      'pertanyaan': pertanyaan,
      'pilihan_a': pilihanA,
      'pilihan_b': pilihanB,
      'pilihan_c': pilihanC,
      'pilihan_d': pilihanD,
      'pilihan_e': pilihanE,
    };
  }
}
