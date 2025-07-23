import 'package:flutter/material.dart';

class Tipspage extends StatefulWidget {
  const Tipspage({super.key});

  @override
  State<Tipspage> createState() => _TipspageState();
}

class _TipspageState extends State<Tipspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Tips')));
  }
}
