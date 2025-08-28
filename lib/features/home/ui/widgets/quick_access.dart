import 'package:flutter/material.dart';
import 'package:siapngabdi/LatihanSoalScreen/latihan_soal_screen.dartfasdfad';
import 'package:siapngabdi/features/materi/ui/materi_screen.dart';
import 'package:siapngabdi/features/simulasi/ui/simulasi_screen.dart';
import 'package:siapngabdi/features/info/info_screen.dart';

class QuickAccessGrid extends StatelessWidget {
  final ThemeData theme;
  final BuildContext context;

  const QuickAccessGrid({
    super.key,
    required this.theme,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = theme.brightness == Brightness.light
        ? Colors.white
        : theme.colorScheme.surfaceVariant;

    final items = <Widget>[
      _buildQuickAccessItem(
        Icons.menu_book_rounded,
        "Materi",
        cardColor,
        theme,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MateriScreen()),
        ),
      ),
      _buildQuickAccessItem(
        Icons.fact_check_rounded,
        "Latihan",
        cardColor,
        theme,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LatihanSoal()),
        ),
      ),
      _buildQuickAccessItem(
        Icons.school_rounded,
        "Simulasi",
        cardColor,
        theme,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SimulasiScreen()),
        ),
      ),
      _buildQuickAccessItem(
        Icons.tips_and_updates_rounded,
        "Tips",
        cardColor,
        theme,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const InfoScreen()),
        ),
      ),
    ];

    return Row(
      children: List.generate(items.length, (i) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: i == 0 ? 0 : 6,
              right: i == items.length - 1 ? 0 : 6,
            ),
            child: items[i],
          ),
        );
      }),
    );
  }

  Widget _buildQuickAccessItem(
    IconData icon,
    String label,
    Color color,
    ThemeData theme, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(18),
              boxShadow: theme.brightness == Brightness.light
                  ? [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        spreadRadius: 1,
                        blurRadius: 10,
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              icon,
              size: 30,
              color: theme.brightness == Brightness.light
                  ? Colors.blueGrey
                  : Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          Text(label, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
