import 'dart:convert';
import 'dart:ui';
import 'dart:collection';
import 'package:projekt_frontend/src/models/exercise.dart';

class Workout {
  final int id;
  final String name;
  final List<Exercise> exercises;

  // constructor
  Workout({
    required this.id,
    required this.name,
    required this.exercises,
  });

  factory Workout.fromJson(Map<String, dynamic>map) {
    List<Exercise> exerciseList = [];
    if (map['exercises'] != null) {
      var exercisesData = map['exercises'] as List<dynamic>;
      exerciseList = exercisesData.map((exerciseData) => Exercise.fromJson(exerciseData)).toList();
    }

    return Workout(
      id: map['id'],
      name: map['name'],
      exercises: exerciseList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "exercises": exercises == null ? [] : List<dynamic>.from(exercises!.map((x) => x)),
    };
  }

  @override
  String toString() {
    return 'Workout {id: $id, name: $name, exercises: $exercises}';
  }
}

Workout workoutFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return Workout.fromJson(data);
}

String workoutToJson(Workout data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}