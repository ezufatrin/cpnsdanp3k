import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final ThemeData theme;

  const HomeHeader({super.key, required this.userName, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Halo, $userName!",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Selamat datang kembali",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
            ),
          ],
        ),
        const CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(
            'https://i.pravatar.cc/150?u=a042581f4e29026704d',
          ),
        ),
      ],
    );
  }
}
