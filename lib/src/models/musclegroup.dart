import 'dart:convert';

class MuscleGroup {
  final int id;
  final String name;

  MuscleGroup({required this.id, required this.name});

  factory MuscleGroup.fromJson(Map<String, dynamic> map) {
    return MuscleGroup(id: map["group_id"], name: map["group_name"]);
  }

  Map<String, dynamic> toJson() {
    return {"group_id": id, "group_name": name};
  }

  @override
  String toString() {
    return 'Musclegroups{group_id: $id, group_name: $name}';
  }
}

List<MuscleGroup> muscleGroupFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<MuscleGroup>.from(data.map((item) => MuscleGroup.fromJson(item)));
}

String muscleGroupToJson(MuscleGroup data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}