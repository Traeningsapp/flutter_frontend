import 'dart:convert';
import 'dart:ui';

import 'package:projekt_frontend/src/models/exerciseStats.dart';
import 'package:projekt_frontend/src/models/muscle.dart';

class Exercise {
  final int id;
  final String name;
  final String description;
  final String benefits;
  final List<Muscle?>? muscles;
  final bool? startingCompound;
  final List<ExerciseStats>? exerciseStats;
  bool active;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.benefits,
    this.muscles,
    required this.startingCompound,
    this.exerciseStats,
    required this.active
  });

  Exercise copyWith({
    List<ExerciseStats>? stats,
    List<Muscle>? activation,
  }) {
    return Exercise(
      id: id,
      name: name,
      description: description,
      benefits: benefits,
      startingCompound: startingCompound,
      muscles: activation ?? muscles,
      exerciseStats: stats ?? exerciseStats,
      active: active,
    );
  }

  factory Exercise.fromJson(Map<String, dynamic>map){
    List<ExerciseStats> exerciseStatsList = [];
    if (map['exerciseStats'] != null) {
      var exerciseStatsData = map['exerciseStats'] as List<dynamic>;
      exerciseStatsList = exerciseStatsData.map((exerciseStatsData) => ExerciseStats.fromJson(exerciseStatsData)).toList();
    }

    List<Muscle> muscleActivationList = [];
    if (map['muscles'] != null) {
      var muscleActivationData = map['muscles'] as List<dynamic>;
      muscleActivationList = muscleActivationData.map((muscleActivationData) => Muscle.fromJson(muscleActivationData)).toList();
    }

    return Exercise(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      benefits: map['benefits'],
      muscles: muscleActivationList,
      startingCompound: map['starting_compound'],
      exerciseStats: exerciseStatsList,
      active: map['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "benefits": benefits,
      "muscles": muscles == null ? [] : List<dynamic>.from(muscles!.map((x) => x!.toJson())).toList(),
      "starting_compound": startingCompound,
      "exerciseStats": exerciseStats == null ? [] : List<dynamic>.from(exerciseStats!.map((x) => x.toJson())).toList(),
      "active": active,
    };
  }

  @override
  String toString() {
    return 'MuscleExercises {id: $id, name: $name, description: $description, benefits: $benefits, muscles: $muscles, starting_compound: $startingCompound, exerciseStats: $exerciseStats, active: $active}';
  }
}

List<Exercise> exercisesFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Exercise>.from(data.map((item) => Exercise.fromJson(item)));
}

String exerciseToJson(Exercise data) {
  return jsonEncode(data);
}
