
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addNoteColorProvider = StateNotifierProvider<AddNoteColorProvider, Color>(
    (ref) => AddNoteColorProvider());

class AddNoteColorProvider extends StateNotifier<Color> {
  AddNoteColorProvider() : super(Colors.red);

  void changeColor(Color color) {
    state = color;
  }
}
