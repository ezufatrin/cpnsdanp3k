import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../provider/soal_provider.dart';
import '../provider/scroll_providers.dart';
import '../provider/dependencies.dart';

class LatihanSoalScreen extends ConsumerStatefulWidget {
  const LatihanSoalScreen({super.key});

  @override
  ConsumerState<LatihanSoalScreen> createState() => _LatihanSoalScreenState();
}

class _LatihanSoalScreenState extends ConsumerState<LatihanSoalScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final kategoriId = ref.read(kategoriAktifProvider);
      ref.read(soalProvider.notifier).loadSoal(kategoriId);
    });
  }

  String getHuruf(int index) => String.fromCharCode(65 + index);

  Widget _buildKategoriButton(String label, int kategoriId) {
    final selectedId = ref.watch(kategoriAktifProvider);
    final bool isSelected = selectedId == kategoriId;
    final soalList = ref.watch(soalProvider).soalPerKategori[kategoriId] ?? [];
    final jawabanPerKategori = ref.watch(soalProvider).jawabanPerKategori;
    final jumlahJawaban = jawabanPerKategori[kategoriId]?.length ?? 0;

    return ElevatedButton(
      onPressed: () async {
        if (!isSelected) {
          ref.read(kategoriAktifProvider.notifier).state = kategoriId;
          await ref.read(soalProvider.notifier).loadSoal(kategoriId);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      child: Text("$label: $jumlahJawaban/${soalList.length}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final kategoriId = ref.watch(kategoriAktifProvider);
    final soalState = ref.watch(soalProvider);
    final soalList = soalState.soalPerKategori[kategoriId] ?? [];
    final jawabanPerKategori = soalState.jawabanPerKategori;
    final itemScrollController = ref.watch(itemScrollControllerProvider);
    final itemPositionsListener = ref.watch(itemPositionsListenerProvider);

    if (soalState.isLoading && soalList.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (soalState.error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: ${soalState.error}'),
              ElevatedButton(
                onPressed: () =>
                    ref.read(soalProvider.notifier).loadSoal(kategoriId),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Soal Berdasarkan Kategori')),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKategoriButton('TWK', 1),
              _buildKategoriButton('TIU', 2),
              _buildKategoriButton('TKP', 3),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemCount: soalList.length,
              itemBuilder: (context, index) {
                final sudahDijawab =
                    jawabanPerKategori[kategoriId]?[index] != null;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: sudahDijawab
                            ? Colors.blue
                            : Colors.grey[300],
                        foregroundColor: sudahDijawab
                            ? Colors.white
                            : Colors.black,
                        padding: EdgeInsets.zero,
                        textStyle: const TextStyle(fontSize: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed: () {
                        itemScrollController.scrollTo(
                          index: index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text('${index + 1}'),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ScrollablePositionedList.builder(
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
              itemCount: soalList.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final soal = soalList[index];
                final pilihan = [
                  soal.pilihanA,
                  soal.pilihanB,
                  soal.pilihanC,
                  soal.pilihanD,
                  soal.pilihanE,
                ];
                final selected = jawabanPerKategori[kategoriId]?[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Soal ${index + 1}: ${soal.pertanyaan}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        ...List.generate(pilihan.length, (i) {
                          final huruf = getHuruf(i);
                          return RadioListTile<String>(
                            value: huruf,
                            groupValue: selected,
                            title: Text('$huruf. ${pilihan[i]}'),
                            onChanged: (val) {
                              ref
                                  .read(soalProvider.notifier)
                                  .jawab(kategoriId, index, val!);
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
