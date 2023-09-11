import 'dart:convert';
import 'dart:developer';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:http/http.dart' as http;
import 'package:projekt_frontend/src/models/exerciseStats.dart';
import 'package:projekt_frontend/src/models/howTo.dart';
import 'package:projekt_frontend/src/models/muscle.dart';
import 'package:projekt_frontend/src/models/muscleGroup.dart';
import 'package:projekt_frontend/src/models/workout.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';


class DatabaseService {
  final String baseUrl = "http://192.168.0.151:5110/api";

  final String? accessToken = Global_Access_token;

  Future<List<MuscleGroup>?> getMuscleGroups() async {
    try
    {
      final url = Uri.parse("$baseUrl/Exercise/get/musclegroups");
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken'
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return muscleGroupFromJson(response.body);
      }
    }
    catch (e) {
      log(e.toString());
    }
  }

  Future<List<Muscle>?> getMuscles(int muscleGroupId) async {
    try
    {
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
    try
    {
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

  Future<Workout?> getNewWorkout(int splitType, String userid, bool includeAbs, bool prioFavorites) async {
    try
    {
      final url = Uri.parse("$baseUrl/Workout/get/newworkout/split/$splitType/user/$userid/abs/$includeAbs/prioritizeFavs/$prioFavorites");
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken'
        }
      );
      print(Global_userid);
      print(response.statusCode);
      if(response.statusCode == 200) {
        return workoutFromJson(response.body);
      }
    }
    catch(e) {
      log(e.toString());
    }
  }

  Future<int?> postWorkout(Workout workout, String userid, String splitType) async {
    try
    {
      final url = Uri.parse("$baseUrl/Workout/post/workout/user/$userid/split/$splitType");

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
        return int.parse(response.body);
      } else {
        log("Error with status code: ${response.statusCode}");
        return null;
      }
    } catch(e) {
      return 500;
    }
  }

  Future<List<Workout>?> getSavedWorkouts(String userId) async {
    try
    {
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
      }
    }
    catch (e) {
      log(e.toString());
    }
  }

  Future<Workout?> getSpecificWorkout(int workoutId, String userId) async {
    try
    {
      final url = Uri.parse("$baseUrl/Workout/get/workoutfromhistory/user/$userId/workout/$workoutId");
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken'
        },
      );
      if (response.statusCode == 200) {
        return workoutFromJson(response.body);
      }
      return null;
    }
    catch (e) {
      log(e.toString());
    }
  }

  Future<List<ExerciseStats>?> getStatsForExercise(String userId, int exerciseId) async {
    try
    {
      final url = Uri.parse("$baseUrl/Exercise/get/exerciseStats/$exerciseId/user/$userId");
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken'
        },
      );
      if (response.statusCode == 200) {
        return exerciseStatsFromJson(response.body);
      }
    } 
    catch(e) {
      log(e.toString());
    }
  }


  Future<List<Exercise>?> getFavoriteExercises(String userId) async {
    try
    {
      final url = Uri.parse("$baseUrl/Exercise/get/favorites/user/$userId");
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
    catch(e) {
      log(e.toString());
    }
  }

  Future<bool?> getFavoriteExercise(String userId, int exerciseId) async {
    try
    {
      final url = Uri.parse("$baseUrl/Exercise/get/favorite/exercise/$exerciseId/user/$userId");
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken'
        },
      );
      if (response.statusCode == 200) {
        if(response.body == "true") {
          return true;
        } else {
          return false;
        }
      }
    }
    catch(e) {
      log(e.toString());
    }
  }

  Future<void> setFavoriteExercise(String userId, int exerciseId) async {
    try
    {
      final url = Uri.parse("$baseUrl/Exercise/post/favorites/user/$userId/exercise/$exerciseId");
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken'
        },
      );
      if (response.statusCode == 200) {
        return;
      }
    }
    catch(e) {
      log(e.toString());
    }
  }

  Future<void> deleteFavoriteExercise(String userId, int exerciseId) async {
    try
    {
      final url = Uri.parse("$baseUrl/Exercise/delete/favorites/user/$userId/exercise/$exerciseId");
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken'
        },
      );
      if(response.statusCode == 200) {
        return;
      }
    }
    catch(e) {
      log(e.toString());
    }
  }

  Future<List<ExerciseHowTo>?> getExerciseHowTo(int exerciseId) async {
    try
    {
      final url = Uri.parse("$baseUrl/Exercise/get/HowTo/exercise/$exerciseId");
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken'
        },
      );
      if(response.statusCode == 200) {
        return exerciseHowToFromJson(response.body);
      }
    }
    catch(e)
    {
      log(e.toString());
    }
  }

  Future<List<ExerciseStats>?> getExerciseStats(String userId, int exerciseId) async {
    try
    {
      final url = Uri.parse("$baseUrl/Exercise/get/exerciseStats/$exerciseId/user/$userId");
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken'
        },
      );
      if(response.statusCode == 200) {
        return exerciseStatsFromJson(response.body);
      }
    }
    catch(e)
    {
      log(e.toString());
    }
  }

  void deleteWorkoutFromHistory(int workoutId) async {
    try
    {
      final url = Uri.parse("$baseUrl/Workout/patch/workout/$workoutId");
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken'
        },
      );
      if(response.statusCode == 200) {
      }
    }
    catch(e)
    {
      log(e.toString());
    }
  }

  void setActiveValue(String userId, int exerciseId, bool? active) async {
    try
    {
      final url = Uri.parse("$baseUrl/Admin/patch/exercise/$exerciseId/activevalue/$active/user/$userId");
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken'
        },
      );
      if(response.statusCode == 200) {
        // måske reeturn statuscode, så vi kan vise en toast i frontend
      }
    }
    catch(e)
    {
      log(e.toString());
    }
  }

}


