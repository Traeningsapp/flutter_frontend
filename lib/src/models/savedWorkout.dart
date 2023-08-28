import 'dart:convert';

SavedWorkout? savedWorkoutFromMap(String str) => SavedWorkout.fromMap(json.decode(str));
String savedWorkoutToMap(SavedWorkout? data) => json.encode(data!.toMap());

class SavedWorkout {
  SavedWorkout({
    required this.id,
    required this.exerciseIds,
    required this.name,
    required this.workoutType,
  });

  String id;
  List<String?>? exerciseIds;
  String name;
  String workoutType;

  factory SavedWorkout.fromMap(Map<String, dynamic> json) => SavedWorkout(
    id: json["id"],
    exerciseIds: json["exercise_ids"] == null ? [] : List<String?>.from(json["exercise_ids"]!.map((x) => x)),
    name: json["name"],
    workoutType: json["workout_type"],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'exerciseIds': exerciseIds,
      'name': name,
      'workout_type' : workoutType,
    };
  }

}



