import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/simulasi.dart';
import '../provider/simulasi_provider.dart';
import 'simulasi_hasil_screen.dart';

class SimulasiSoalScreen extends ConsumerStatefulWidget {
  final int kategoriId;
  const SimulasiSoalScreen({super.key, required this.kategoriId});

  @override
  ConsumerState<SimulasiSoalScreen> createState() => _SimulasiSoalScreenState();
}

class _SimulasiSoalScreenState extends ConsumerState<SimulasiSoalScreen> {
  int currentIndex = 0;
  Map<int, String> jawabanUser = {};
  late Timer _timer;
  int sisaDetik = 600;
  bool waktuHabis = false;
  bool sudahMulai = false;
  bool _popupTampil = false;

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (sisaDetik == 0) {
        timer.cancel();
        setState(() => waktuHabis = true);
        _showWaktuHabisPopup();
      } else {
        setState(() => sisaDetik--);
      }
    });
  }

  void _showInstruksiPopup(List<Simulasi> soalList) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Instruksi Simulasi"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("🕒 Waktu: ${(sisaDetik ~/ 60)} menit"),
            const SizedBox(height: 8),
            Text("📝 Jumlah Soal: ${soalList.length}"),
            const SizedBox(height: 16),
            const Text("Pastikan menjawab semua soal sebelum waktu habis."),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              startTimer();
              setState(() => sudahMulai = true);
            },
            child: const Text("Mulai Mengerjakan"),
          ),
        ],
      ),
    );
  }

  void _showWaktuHabisPopup() {
    final soalList = ref.read(simulasiProvider(widget.kategoriId)).requireValue;
    int jumlahJawaban = jawabanUser.length;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Waktu Habis!"),
        content: Text(
          "Kamu telah menjawab $jumlahJawaban dari ${soalList.length} soal.",
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => SimulasiHasilScreen(
                    soalList: soalList,
                    jawabanUser: jawabanUser,
                  ),
                ),
              );
            },
            child: const Text("Cek Hasil"),
          ),
        ],
      ),
    );
  }

  void _showNavigasiPopup(List<Simulasi> soalList) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Center(child: Text("Navigasi Soal")),
        content: SizedBox(
          width: 260,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: List.generate(soalList.length, (index) {
              Color warna;
              if (index == currentIndex) {
                warna = Colors.orange;
              } else if (jawabanUser.containsKey(index)) {
                warna = Colors.blue;
              } else {
                warna = Colors.grey.shade300;
              }
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  setState(() => currentIndex = index);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: warna,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text("${index + 1}"),
                ),
              );
            }),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Keluar Simulasi"),
            content: const Text(
              "Semua jawaban Anda akan hilang. Yakin ingin keluar?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Batal"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  "Keluar",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  void pilihJawaban(String opsi) {
    setState(() {
      jawabanUser[currentIndex] = opsi;
    });
  }

  @override
  Widget build(BuildContext context) {
    final simulasiAsync = ref.watch(simulasiProvider(widget.kategoriId));

    return simulasiAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text("Error: $e"))),
      data: (soalList) {
        if (!_popupTampil) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showInstruksiPopup(soalList);
            _popupTampil = true;
          });
        }

        final soal = soalList[currentIndex];

        return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Simulasi Soal"),
              backgroundColor: const Color(0xFF007BFF),
              actions: [
                if (sisaDetik > 60)
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const Icon(Icons.timer, color: Colors.white),
                        const SizedBox(width: 6),
                        Text(
                          "${(sisaDetik ~/ 60).toString().padLeft(2, '0')}:${(sisaDetik % 60).toString().padLeft(2, '0')}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 60.0, end: sisaDetik.toDouble()),
                      duration: const Duration(seconds: 1),
                      builder: (context, value, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: sisaDetik / 60,
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.red,
                              ),
                              strokeWidth: 4,
                            ),
                            Text(
                              sisaDetik.toString(),
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "PERTANYAAN ke ${currentIndex + 1}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(soal.pertanyaan, style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  for (var opsi in ['A', 'B', 'C', 'D', 'E'])
                    _opsiWidget(soal, opsi, soal.getPilihan(opsi)),

                  const Spacer(),

                  if (jawabanUser.length == soalList.length)
                    Card(
                      color: Colors.green[50],
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Center(
                          child: Column(
                            children: [
                              const Text(
                                "✅ Anda telah menjawab semua soal!",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.check),
                                label: const Text("Selesai"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  _timer.cancel();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => SimulasiHasilScreen(
                                        soalList: soalList,
                                        jawabanUser: jawabanUser,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: currentIndex > 0
                            ? () => setState(() => currentIndex--)
                            : null,
                        child: const Text("Sebelumnya"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: () => _showNavigasiPopup(soalList),
                        child: const Icon(Icons.list),
                      ),
                      ElevatedButton(
                        onPressed: currentIndex < soalList.length - 1
                            ? () => setState(() => currentIndex++)
                            : null,
                        child: const Text("Selanjutnya"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _opsiWidget(Simulasi soal, String label, String? isi) {
    final isSelected = jawabanUser[currentIndex] == label;
    return ListTile(
      title: Text("$label. $isi"),
      leading: Radio<String>(
        value: label,
        groupValue: jawabanUser[currentIndex],
        onChanged: (value) => pilihJawaban(value!),
      ),
      tileColor: isSelected ? Colors.blue[50] : null,
    );
  }
}
