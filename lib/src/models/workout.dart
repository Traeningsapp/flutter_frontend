import 'dart:convert';
import 'package:projekt_frontend/src/models/exercise.dart';

class Workout {
  late int? id;
  late String? userId;
  late String? name;
  late DateTime? createdDate;
  late List<Exercise>? exercises;
  late bool? visibleToUser;

  // constructor
  Workout({
    this.id,
    this.userId,
    this.name,
    this.createdDate,
    this.exercises,
    this.visibleToUser,
  });

  factory Workout.fromJson(Map<String, dynamic>map) {
    List<Exercise> exerciseList = [];
    if (map['exercises'] != null) {
      var exercisesData = map['exercises'] as List<dynamic>;
      exerciseList = exercisesData.map((exerciseData) => Exercise.fromJson(exerciseData)).toList();
    }

    return Workout(
      id: map['id'],
      userId: map['userId'],
      name: map['name'],
      createdDate: map['createdDate'],
      exercises: exerciseList,
      visibleToUser: map['visibleToUser']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "name": name,
      "createdDate": createdDate,
      "exercises": exercises == null ? [] : List<dynamic>.from(exercises!.map((x) => x.toJson())).toList(),
      "visibleToUser": visibleToUser
    };
  }

  @override
  String toString() {
    return 'Workout {id: $id, userId: $userId, name: $name, createdDate: $createdDate, exercises: $exercises, visibleToUser: $visibleToUser}';
  }
}

Workout workoutFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return Workout.fromJson(data);
}

List<Workout> workoutsFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Workout>.from(data.map((item) => Workout.fromJson(item)));
}

String workoutToJson(Workout data) {
  final jsonData = data.toJson();
  print(jsonData);
  return jsonEncode(jsonData);
}