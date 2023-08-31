import 'package:flutter/cupertino.dart';
import 'exerciseStats.dart';

class ExerciseStatKey {
  final GlobalKey key = GlobalKey();
  ExerciseStats stats;

  ExerciseStatKey(DateTime createdDate, int exerciseId, int setnr)
  : stats = ExerciseStats(createdDate: createdDate, exerciseId: exerciseId, setnr: setnr);

  ExerciseStatKey.withRepsAndKilo(DateTime createdDate, int exerciseId, int? reps, int? kilo, int setnr)
  : stats = ExerciseStats(createdDate: createdDate, exerciseId: exerciseId, reps: reps, kilo: kilo, setnr: setnr);


  reset() {
    stats = ExerciseStats();
  }
}
