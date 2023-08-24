import 'dart:convert';
import 'dart:ui';

class ExerciseStats {
  final int? workoutId;
  final String? userId;
  final int? exerciseId;
  DateTime? createdDate;
  final int? setnr;
  int? reps;
  int? kilo;


  ExerciseStats({
    this.workoutId,
    this.userId,
    this.exerciseId,
    this.createdDate,
    this.setnr,
    this.reps,
    this.kilo,
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

