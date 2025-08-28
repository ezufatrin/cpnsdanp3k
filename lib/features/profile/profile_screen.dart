import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: cs.background,
      appBar: AppBar(
        title: Text(
          "Profil Saya",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: cs.onBackground,
          ),
        ),
        centerTitle: true,
        backgroundColor: cs.background,
        foregroundColor: cs.onBackground,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              _buildProfileHeader(context),
              const SizedBox(height: 32),
              _buildMenuItemCard(
                context: context,
                icon: Icons.edit,
                label: "Edit Profil",
                onTap: () {},
              ),
              const SizedBox(height: 16),
              _buildMenuItemCard(
                context: context,
                icon: Icons.bar_chart,
                label: "Nilai Tryout",
                onTap: () {},
              ),
              const SizedBox(height: 16),
              _buildMenuItemCard(
                context: context,
                icon: Icons.bookmark,
                label: "Favorit",
                onTap: () {},
              ),
              const SizedBox(height: 16),
              _buildMenuItemCard(
                context: context,
                icon: Icons.settings,
                label: "Pengaturan",
                onTap: () {},
              ),
              const SizedBox(height: 24),
              _buildLogoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: Theme.of(context).brightness == Brightness.light
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ]
            : null,
      ),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: cs.primary.withOpacity(0.1),
            child: Icon(Icons.person, size: 50, color: cs.primary),
          ),
          const SizedBox(height: 16),
          Text(
            "Eli Zulkatri",
            style: tt.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "CPNS 2025 - Balikpapan",
            style: tt.bodyMedium?.copyWith(
              color: cs.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItemCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      color: cs.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        splashColor: cs.primary.withOpacity(0.1),
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Icon(icon, color: cs.primary),
              const SizedBox(width: 20),
              Text(
                label,
                style: tt.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: cs.onSurface,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: cs.onSurface.withOpacity(0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: cs.onError,
        backgroundColor: cs.error,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.logout, size: 20),
          SizedBox(width: 8),
          Text(
            "Keluar",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
