// Langkah 1: Tambahkan dependency flutter_riverpod dan supabase_flutter di pubspec.yaml

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'soal_provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

final soalKeysProvider = StateProvider<Map<int, List<GlobalKey>>>((ref) => {});
final itemScrollControllerProvider = Provider<ItemScrollController>((ref) {
  return ItemScrollController();
});

final itemPositionsListenerProvider = Provider<ItemPositionsListener>((ref) {
  return ItemPositionsListener.create();
});

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  final supabase = Supabase.instance.client;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchSoal(ref.read(kategoriAktifProvider));
  }

  Future<void> fetchSoal(int kategoriId) async {
    final res = await supabase
        .from('soal')
        .select()
        .eq('kategori_id', kategoriId)
        .order('id');

    final data = List<Map<String, dynamic>>.from(res);
    ref.read(soalPerKategoriProvider.notifier).simpanSoal(kategoriId, data);

    final currentKeys = ref.read(soalKeysProvider)[kategoriId];
    if (currentKeys == null || currentKeys.length != data.length) {
      final newKeys = List.generate(data.length, (_) => GlobalKey());
      ref
          .read(soalKeysProvider.notifier)
          .update((state) => {...state, kategoriId: newKeys});
    }
  }

  String getHuruf(int index) => String.fromCharCode(65 + index);

  Widget buildKategoriButton(String label, int kategoriId) {
    final selectedId = ref.watch(kategoriAktifProvider);
    final bool isSelected = selectedId == kategoriId;
    return ElevatedButton(
      onPressed: () async {
        if (!isSelected) {
          ref.read(kategoriAktifProvider.notifier).state = kategoriId;
          await fetchSoal(kategoriId);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      child: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    final kategoriId = ref.watch(kategoriAktifProvider);
    final soalList = ref.watch(soalPerKategoriProvider)[kategoriId] ?? [];
    final jawabanPerKategori = ref.watch(jawabanPerKategoriProvider);
    final soalKeys = ref.watch(soalKeysProvider)[kategoriId] ?? [];
    final itemScrollController = ref.watch(itemScrollControllerProvider);
    final itemPositionsListener = ref.watch(itemPositionsListenerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Soal Berdasarkan Kategori')),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildKategoriButton('TWK', 1),
              buildKategoriButton('TIU', 2),
              buildKategoriButton('TKP', 3),
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
                        ref
                            .read(itemScrollControllerProvider)
                            .scrollTo(
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
                  soal['pilihan_a'],
                  soal['pilihan_b'],
                  soal['pilihan_c'],
                  soal['pilihan_d'],
                  soal['pilihan_e'],
                ];
                final selected = ref.watch(
                  jawabanPerKategoriProvider.select(
                    (state) => state[kategoriId]?[index],
                  ),
                );

                return Card(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Soal ${index + 1}: ${soal['pertanyaan']}',
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
                                  .read(jawabanPerKategoriProvider.notifier)
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

          // Expanded(
          //   child: ListView.builder(
          //     controller: scrollController,
          //     padding: const EdgeInsets.all(16),
          //     itemCount: soalList.length,
          //     itemBuilder: (context, index) {
          //       final soal = soalList[index];
          //       final pilihan = [
          //         soal['pilihan_a'],
          //         soal['pilihan_b'],
          //         soal['pilihan_c'],
          //         soal['pilihan_d'],
          //         soal['pilihan_e'],
          //       ];

          //       final selected = ref.watch(
          //         jawabanPerKategoriProvider.select(
          //           (state) => state[kategoriId]?[index],
          //         ),
          //       );

          //       return Card(
          //         key: soalKeys[index],
          //         margin: const EdgeInsets.only(bottom: 24),
          //         child: Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 'Soal ${index + 1}: ${soal['pertanyaan']}',
          //                 style: const TextStyle(fontWeight: FontWeight.bold),
          //               ),
          //               const SizedBox(height: 12),
          //               ...List.generate(pilihan.length, (i) {
          //                 final huruf = getHuruf(i);
          //                 return RadioListTile<String>(
          //                   value: huruf,
          //                   groupValue: selected,
          //                   title: Text('$huruf. ${pilihan[i]}'),
          //                   onChanged: (val) {
          //                     ref
          //                         .read(jawabanPerKategoriProvider.notifier)
          //                         .jawab(kategoriId, index, val!);
          //                   },
          //                 );
          //               }),
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
