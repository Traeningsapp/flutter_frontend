import 'dart:convert';
import 'dart:developer';
import 'package:projekt_frontend/src/models/exercise.dart';
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

  Future<int?> postWorkout(Workout workout, String userid) async {
    try {
      final url = Uri.parse("$baseUrl/Workout/post/workout/user/$userid");

      String jsonWorkout = workoutToJson(workout);

      var bodyData = {
        "WorkoutAsJson": jsonWorkout
      };

      final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json'
          },
          body: json.encode(bodyData)
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        return responseData['result'];
      } else {
        log("Error with status code: ${response.statusCode}");
        return null;
      }
    } catch(e) {
      log(e.toString());
      return 500;
    }
  }

  Future<List<Workout>?> getSavedWorkouts(String userId) async {
    try {
      final url = Uri.parse("$baseUrl/Workout/get/workouthistory/user/$userId");
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken'
        },
      );
      if (response.statusCode == 200) {
        return workoutsFromJson(response.body);
      } else {
        print(response.statusCode);
      }
    }
    catch (e) {
      log(e.toString());
    }
  }

  Future<Workout?> getSpecificWorkout(int workoutId, String userId) async {
    try {
      final url = Uri.parse("$baseUrl/Workout/get/workoutfromhistory/user/$userId/workout/$workoutId");
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken'
        },
      );
      if (response.statusCode == 200) {
        return workoutFromJson(response.body);
      } else {
        print(response.statusCode);
      }
    }
    catch (e) {
      log(e.toString());
    }
  }

}


