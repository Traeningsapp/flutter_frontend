import 'dart:convert';

class ExerciseHowTo {
  final int exerciseId;
  final int step;
  final String step_text;

  ExerciseHowTo({
    required this.exerciseId,
    required this.step,
    required this.step_text
  });

  factory ExerciseHowTo.fromJson(Map<String, dynamic>map){
    return ExerciseHowTo(
        exerciseId: map['exerciseId'],
        step: map['step'],
        step_text: map['step_text']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "exerciseId": exerciseId,
      "step": step,
      "step_text": step_text,
    };
  }

  @override
  String toString() {
    return 'MuscleExercises {exerciseId: $exerciseId, step: $step, step_text: $step_text}';
  }
}

List<ExerciseHowTo> exerciseHowToFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<ExerciseHowTo>.from(data.map((item) => ExerciseHowTo.fromJson(item)));
}

String exerciseHowToToJson(ExerciseHowTo data) {
  return jsonEncode(data);
}