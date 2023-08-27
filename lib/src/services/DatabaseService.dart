import 'dart:developer';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/models/exerciseStats.dart';
import 'package:http/http.dart' as http;
import 'package:projekt_frontend/src/models/muscle.dart';
import 'package:projekt_frontend/src/models/workout.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';


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

  Future<Workout?> getNewWorkout(int splitType, String userid) async {
    try{
      final url = Uri.parse("$baseUrl/Workout/get/newworkout/split/$splitType/user/$userid");
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken'
        }
      );
      print(Global_userid);
      print(response.statusCode);
      if(response.statusCode == 200) {
        //print(response.body);
        return workoutFromJson(response.body);
      }
    }
    catch(e) {
      log(e.toString());
    }
  }

  Future<String?> postWorkout(Workout workout, List<ExerciseStats> stats, String userid) async {
    try{
      final url = Uri.parse("$baseUrl/Workout/post/workout/user/$userid");

      List<Map<String, dynamic>> jsonExerciseStatList = exerciseStatsListToJson(stats);
      String JsonWorkout = workoutToJson(workout);

      final bodyData = {
        JsonWorkout,
        jsonExerciseStatList
      };

      //print(bodyData);
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken'
        },
        body: bodyData
      );

      if (response.statusCode == 200) {
        return "Success!";
      } else {
        return "Failed with status code: ${response.statusCode}";
      }
    }
    catch(e) {
      log(e.toString());
      return "An error occurred";
    }
  }

  /*
  Future<String> postSavedWorkout(Workout savedWorkout) async {
    try{
      final url = Uri.parse("$baseUrl/Workout/post/WorkoutStats/$exerciseStats");

      final List<Map<String, dynamic>> exerciseStatsJson = exerciseStats.map((stats) => stats.toJson()).toList();

      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $accessToken'
          },
          body: exerciseStatsJson
      );

      if (response.statusCode == 200) {
        return "Success!";
      } else {
        return "Failed with status code: ${response.statusCode}";
      }
    }
    catch(e) {
      log(e.toString());
      return "An error occurred";
    }
  }
  */
}


