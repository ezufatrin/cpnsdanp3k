import 'package:flutter/material.dart';
import '../model/simulasi.dart';

class SimulasiHasilScreen extends StatelessWidget {
  final List<Simulasi> soalList;
  final Map<int, String> jawabanUser;

  const SimulasiHasilScreen({
    super.key,
    required this.soalList,
    required this.jawabanUser,
  });

  @override
  Widget build(BuildContext context) {
    final total = soalList.length;
    final dijawab = jawabanUser.length;
    final benar = soalList.asMap().entries.where((entry) {
      final index = entry.key;
      final soal = entry.value;
      return jawabanUser[index] == soal.jawaban;
    }).length;

    final salah = dijawab - benar;
    final nilai = (benar / total * 100).toStringAsFixed(1);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hasil Simulasi"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.green[100],
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStat("Total", total, Colors.blue),
                    _buildStat("Dijawab", dijawab, Colors.orange),
                    _buildStat("Benar", benar, Colors.green),
                    _buildStat("Salah", salah, Colors.red),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  "Nilai: $nilai",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: soalList.length,
              itemBuilder: (context, index) {
                final soal = soalList[index];
                final userJawab = jawabanUser[index];
                final bool isBenar = userJawab == soal.jawaban;

                return Card(
                  color: isBenar ? Colors.green[50] : Colors.red[50],
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    title: Text("Soal ${index + 1}: ${soal.pertanyaan}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text("Jawaban Anda: ${userJawab ?? '-'}"),
                        Text("Kunci Jawaban: ${soal.jawaban}"),
                        Text(isBenar ? "✅ Benar" : "❌ Salah"),
                      ],
                    ),
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        color: Colors.grey[100],
                        child: Text(
                          soal.pembahasan.isNotEmpty
                              ? soal.pembahasan
                              : "Belum ada pembahasan.",
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, int value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        CircleAvatar(
          backgroundColor: color,
          foregroundColor: Colors.white,
          radius: 18,
          child: Text(
            value.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
