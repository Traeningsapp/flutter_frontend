import 'dart:convert';
import 'dart:ui';

class ExerciseStats {
  final int? workoutId;
  final String? userId;
  final int? exerciseId;
  final DateTime createdDate;
  final int setnr;
  final int reps;
  final int kilo;


  ExerciseStats({
    this.workoutId,
    this.userId,
    this.exerciseId,
    required this.createdDate,
    required this.setnr,
    required this.reps,
    required this.kilo,
  });

  factory ExerciseStats.fromJson(Map<String, dynamic>map){
    return ExerciseStats(
      workoutId: map['workoutId'],
      userId: map['userId'],
      exerciseId: map['exerciseId'],
      createdDate: map['createdDate'],
      setnr: map['setnr'],
      reps: map['reps'],
      kilo: map['kilo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "workoutId": workoutId,
      "userId": userId,
      "exerciseId": exerciseId,
      "timestamp": createdDate,
      "setnr": setnr,
      "reps": reps,
      "kilo": kilo,
    };
  }

  @override
  String toString() {
    return 'ExerciseStats {workoutId: $workoutId, userId: $userId, exerciseId: $exerciseId, createdDate: $createdDate, setnr: $setnr, reps: $reps, kilo: $kilo}';
  }
}

List<ExerciseStats> exerciseStatsFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<ExerciseStats>.from(data.map((item) => ExerciseStats.fromJson(item)));
}

String exerciseStatsToJson(ExerciseStats data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

