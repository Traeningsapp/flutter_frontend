import 'dart:convert';

class Muscle {
  final int id;
  final int musclegroupId;
  final String name;
  final bool isPrimary;

  Muscle({required this.id, required this.musclegroupId, required this.name, required this.isPrimary});

  factory Muscle.fromJson(Map<String, dynamic> map) {
    return Muscle(id: map["id"], musclegroupId: map['musclegroupId'], name: map["name"], isPrimary: map["isPrimary"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "musclegroupId" : musclegroupId,
      "name": name,
      "isPrimary": isPrimary
    };
  }

  @override
  String toString() {
    return 'MuscleSubgroups{id: $id, musclegroupId: $musclegroupId, name: $name, isPrimary: $isPrimary}';
  }
}

List<Muscle> musclesFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Muscle>.from(data.map((item) => Muscle.fromJson(item)));
}

String muscleToJson(Muscle data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
