import 'package:flutter/cupertino.dart';
import 'exerciseStats.dart';

class ExerciseStatKey {
  final GlobalKey key = GlobalKey();
  ExerciseStats stats;

  ExerciseStatKey(DateTime createdDate, int exerciseId, int setnr)
  : stats = ExerciseStats(createdDate: createdDate, exerciseId: exerciseId, setnr: setnr);

  reset() {
    stats = ExerciseStats();
  }
}
