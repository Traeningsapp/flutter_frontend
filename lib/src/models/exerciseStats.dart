import 'dart:convert';
import 'dart:ui';

class Exercise {
  final int id;
  final String name;
  final String description;
  final String benefits;
  final Image? asset;
  final List<String?>? muscleActivation;
  final List<String?>? includedIn;
  final bool? startingCompound;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.benefits,
    this.asset,
    this.muscleActivation,
    this.includedIn,
    required this.startingCompound,
  });

  factory Exercise.fromJson(Map<String, dynamic>map){
    return Exercise(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      benefits: map['benefits'],
      asset: map['asset'],
      muscleActivation: map["muscleActivation"] == null ? [] : List<String?>.from(map["muscleActivation"]!.map((x) => x)),
      includedIn: map["included_in"] == null ? [] : List<String?>.from(map["included_in"]!.map((x) => x)),
      startingCompound: map['starting_compound'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "benefits": benefits,
      "asset": asset,
      "muscleActivation": muscleActivation == null ? [] : List<dynamic>.from(muscleActivation!.map((x) => x)),
      "included_in": includedIn == null ? [] : List<dynamic>.from(includedIn!.map((x) => x)),
      "starting_compound": startingCompound
    };
  }

  @override
  String toString() {
    return 'MuscleExercises {id: $id, name: $name, description: $description, benefits: $benefits, asset: $asset, muscleActivation: $muscleActivation, included_in: $includedIn, starting_compound: $startingCompound}';
  }
}

List<Exercise> exercisesFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Exercise>.from(data.map((item) => Exercise.fromJson(item)));
}

String exerciseToJson(Exercise data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
