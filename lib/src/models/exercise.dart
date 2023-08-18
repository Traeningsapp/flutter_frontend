import 'dart:convert';

Exercise? exerciseFromMap(String str) => Exercise.fromMap(json.decode(str));
String exerciseToMap(Exercise? data) => json.encode(data!.toMap());

class Exercise {
  Exercise({
    required this.asset_location,
    required this.id,
    required this.benefits,
    this.secondaryActivation,
    required this.includedIn,
    this.name,
    required this.description,
    required this.primaryActivation,
    required this.startingCompound,
  });

  String asset_location;
  String? benefits;
  List<String?>? secondaryActivation;
  List<String?>? includedIn;
  String? name;
  String? description;
  String? primaryActivation;
  String? id;
  bool? startingCompound;


  factory Exercise.fromMap(Map<String, dynamic> json) => Exercise(
    asset_location: json['asset_location'],
    benefits: json["benefits"],
    secondaryActivation: json["secondary_activation"] == null ? [] : List<String?>.from(json["secondary_activation"]!.map((x) => x)),
    includedIn: json["included_in"] == null ? [] : List<String?>.from(json["included_in"]!.map((x) => x)),
    name: json["name"],
    description: json["description"],
    primaryActivation: json["primary_activation"],
    id: json["id"],
    startingCompound: json["starting_compound"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "asset_location": asset_location,
    "benefits": benefits,
    "secondary_activation": secondaryActivation == null ? [] : List<dynamic>.from(secondaryActivation!.map((x) => x)),
    "included_in": primaryActivation == null ? [] : List<dynamic>.from(includedIn!.map((x) => x)),
    "name": name,
    "description": description,
    "primary_activation": primaryActivation,
    "starting_compound": startingCompound,
  };
}
