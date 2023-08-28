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
      createdDate: map['createdDate'] != null ? DateTime.parse(map['createdDate']) : null,
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
      "timestamp": createdDate?.toIso8601String(),
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

List<Map<String, dynamic>> exerciseStatsListToJson(List<ExerciseStats> exerciseStatsList) {
  List<Map<String, dynamic>> jsonList = [];
  for (var stats in exerciseStatsList) {
    jsonList.add(stats.toJson());
  }
  return jsonList;
}
