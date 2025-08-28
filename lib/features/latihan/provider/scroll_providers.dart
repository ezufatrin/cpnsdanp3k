import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

final soalKeysProvider = StateProvider<Map<int, List<GlobalKey>>>((ref) => {});
final itemScrollControllerProvider = Provider<ItemScrollController>((ref) {
  return ItemScrollController();
});

final itemPositionsListenerProvider = Provider<ItemPositionsListener>((ref) {
  return ItemPositionsListener.create();
});
