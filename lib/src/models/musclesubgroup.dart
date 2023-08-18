import 'dart:convert';

class MuscleSubGroup {
  final int id;
  final String name;

  MuscleSubGroup({required this.id, required this.name});

  factory MuscleSubGroup.fromJson(Map<String, dynamic> map) {
    return MuscleSubGroup(id: map["group_id"], name: map["group_name"]);
  }

  Map<String, dynamic> toJson() {
    return {"group_id": id, "group_name": name};
  }

  @override
  String toString() {
    return 'Musclegroups{group_id: $id, group_name: $name}';
  }
}

List<MuscleSubGroup> muscleGroupFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<MuscleSubGroup>.from(data.map((item) => MuscleSubGroup.fromJson(item)));
}

String muscleGroupToJson(MuscleSubGroup data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}