import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Saya"),
        backgroundColor: const Color(0xFF007BFF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF007BFF),
            margin: const EdgeInsets.only(top: 10),

            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/banner1.png'),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Eli Zulkatri",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "CPNS 2025 - Balikpapan",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: const [
                _ProfileMenuItem(icon: Icons.edit, label: "Edit Profil"),
                _ProfileMenuItem(icon: Icons.bar_chart, label: "Nilai Tryout"),
                _ProfileMenuItem(icon: Icons.bookmark, label: "Favorit"),
                _ProfileMenuItem(icon: Icons.settings, label: "Pengaturan"),
                Divider(),
                _ProfileMenuItem(
                  icon: Icons.logout,
                  label: "Keluar",
                  isDestructive: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDestructive;

  const _ProfileMenuItem({
    required this.icon,
    required this.label,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : Colors.black),
      title: Text(
        label,
        style: TextStyle(color: isDestructive ? Colors.red : Colors.black),
      ),
      onTap: () {
        // TODO: Tambahkan aksi navigasi atau dialog
      },
    );
  }
}
