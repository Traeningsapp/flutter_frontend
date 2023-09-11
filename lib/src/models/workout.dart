import 'dart:convert';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/models/muscle.dart';

class Workout {
  late int? id;
  late String? userId;
  late String? name;
  late DateTime? createdDate;
  late List<Exercise>? exercises;
  late bool? visibleToUser;
  late String? splitType;

  // constructor
  Workout({
    this.id,
    this.userId,
    this.name,
    this.createdDate,
    this.exercises,
    this.visibleToUser,
    this.splitType,
  });

  factory Workout.fromJson(Map<String, dynamic> map) {
    List<Exercise> exerciseList = [];
    if (map['exercises'] != null) {
      var exercisesData = map['exercises'] as List<dynamic>;
      exerciseList = exercisesData.map((exerciseData) => Exercise.fromJson(exerciseData)).toList();
    }

    return Workout(
        id: map['id'],
        userId: map['userId'],
        name: map['name'],
        createdDate: map['createdDate'] != null ? DateTime.parse(map['createdDate']) : null,
        exercises: exerciseList,
        visibleToUser: map['visibleToUser'],
        splitType: map['splitType']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id ?? 0,
      "userId": userId,
      "name": name,
      "createdDate": createdDate?.toString(),
      "exercises": exercises == null ? [] : List<dynamic>.from(exercises!.map((x) => x.toJson())).toList(),
      "visibleToUser": visibleToUser,
      "splitType": splitType
    };
  }

  @override
  String toString() {
    return 'Workout {id: $id, userId: $userId, name: $name, createdDate: $createdDate, exercises: $exercises, visibleToUser: $visibleToUser, splitType: $splitType}';
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
  return jsonEncode(jsonData);
}