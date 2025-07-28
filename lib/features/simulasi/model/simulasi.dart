class Simulasi {
  final int id;
  final int kategoriId;
  final String pertanyaan;
  final String pilihanA;
  final String pilihanB;
  final String pilihanC;
  final String pilihanD;
  final String pilihanE;
  final String jawaban;
  final String pembahasan;
  final DateTime? createdAt;

  Simulasi({
    required this.id,
    required this.kategoriId,
    required this.pertanyaan,
    required this.pilihanA,
    required this.pilihanB,
    required this.pilihanC,
    required this.pilihanD,
    required this.pilihanE,
    required this.jawaban,
    required this.pembahasan,
    this.createdAt,
  });

  factory Simulasi.fromJson(Map<String, dynamic> json) {
    return Simulasi(
      id: json['id'],
      kategoriId: json['kategori_id'],
      pertanyaan: json['pertanyaan'],
      pilihanA: json['pilihan_a'],
      pilihanB: json['pilihan_b'],
      pilihanC: json['pilihan_c'],
      pilihanD: json['pilihan_d'],
      pilihanE: json['pilihan_e'],
      jawaban: json['jawaban'],
      pembahasan: json['pembahasan'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }

  String getPilihan(String opsi) {
    switch (opsi.toUpperCase()) {
      case 'A':
        return pilihanA;
      case 'B':
        return pilihanB;
      case 'C':
        return pilihanC;
      case 'D':
        return pilihanD;
      case 'E':
        return pilihanE;
      default:
        return '-';
    }
  }
}
