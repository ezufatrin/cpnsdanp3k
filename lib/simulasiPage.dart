import 'package:flutter/material.dart';

class Simulasipage extends StatefulWidget {
  const Simulasipage({super.key});

  @override
  State<Simulasipage> createState() => _SimulasipageState();
}

class _SimulasipageState extends State<Simulasipage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Simulasi')));
  }
}
