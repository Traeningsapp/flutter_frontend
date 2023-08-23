import 'dart:developer';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/models/musclegroup.dart';
import 'package:http/http.dart' as http;
import 'package:projekt_frontend/src/models/muscle.dart';
import 'package:projekt_frontend/src/models/workout.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';


//
//
// Skal dbservice splittes op i exercise_dbservice og workout_dbservice?
// Naming er irrelevant, but u get my point ;)
//

class DatabaseService {
  final String baseUrl = "https://10.0.2.2:7130/api";

  final String? accessToken = Global_Access_token;

  Future<List<Muscle>?> getMuscles(int muscleGroupId) async {
    try {
      final url = Uri.parse("$baseUrl/Exercise/get/muscle/$muscleGroupId");
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken'
        },
      );
      if (response.statusCode == 200) {
        return musclesFromJson(response.body);
      }
    }
    catch (e) {
      log(e.toString());
    }
  }

  Future<List<Exercise>?> getMuscleExercises(int muscleId) async {
    try {
      final url = Uri.parse("$baseUrl/Exercise/get/exerciselist/$muscleId");
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken'
        },
      );
      if (response.statusCode == 200) {
        return exercisesFromJson(response.body);
      }
    }
    catch (e) {
      log(e.toString());
    }
  }

  Future<Workout?> getNewWorkout(int splitType) async {
    try{
      final url = Uri.parse("$baseUrl/Workout/get/newworkout/$splitType");
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken'
        }
      );
      if(response.statusCode == 200) {
        return workoutFromJson(response.body);
      }
    }
    catch(e) {
      log(e.toString());
    }
  }
}