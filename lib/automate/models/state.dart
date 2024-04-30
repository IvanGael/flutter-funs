
import 'package:flutter/material.dart';

import '../enum/state_enum.dart';

class Etat {
  final StateType type;
  final int id;
  final Offset offset;
  final String? label;

  Etat({
    this.label,
    required this.type,
    required this.id,
    required this.offset,
  });

  Etat copyWith({Offset? offset, int? id, String? label}) {
    return Etat(
      type: type,
      id: id ?? this.id,
      label: label ?? this.label,
      offset: offset ?? this.offset,
    );
  }

  String get image {
    return states[type.index];
  }

  static String imageByType(StateType t) {
    return states[t.index];
  }

  static const List<String> states = [
    "assets/automate/simple_state.png",
    "assets/automate/final_state.png",
    "assets/automate/simple_start_state.png",
    "assets/automate/end_start_state.png",
    "assets/automate/initial_boucle.png",
    "assets/automate/end_boucle.png",
    "assets/automate/simple_boucle.png",
    "assets/automate/initial_final_boucle.png",
  ];
}