import 'dart:collection';

import 'package:projekt_frontend/src/models/exercise.dart';

class Workout {
  final String id;
  final queue = Queue<Exercise>();

  // constructor
  Workout({
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

}
