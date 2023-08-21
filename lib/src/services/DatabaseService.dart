import 'dart:io';

import 'package:projekt_frontend/src/models/musclegroup.dart';
import 'package:http/http.dart' show Client;
import 'package:projekt_frontend/src/models/muscle.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

class DatabaseService {
  final String baseUrl = "https://10.0.2.2:7130/api";
  Client client = Client();


  Future<List<MuscleGroup>?> getMuscleGroups() async {
    final response = await client.get("$baseUrl/Exercise/get/muscle" as Uri);
    if (response.statusCode == 200) {
      return muscleGroupFromJson(response.body);
    }
    else {
      return null;
    }
  }

  Future<List<Muscle>?> getMuscles(int muscleSubId) async {
    print('Dbservice start');
    final String accessToken = Global_Access_token;
    print(accessToken);
    final response = await client.get(
        Uri.parse("$baseUrl/Exercise/get/muscle/$muscleSubId"),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
    );
    if (response.statusCode == 200) {
      print('Dbservice 200');
      return musclesFromJson(response.body);
    } else {
      return null;
    }
  }


  /*
  //-----------------------------------------------------------------------------------------------
  //ALL THE FOLLOWING CODE IS FOR RETRIEVING MUSCLEGROUPS, MUSCLESUBGROUPS AND EXERCISES FOR THOSE.
  //-----------------------------------------------------------------------------------------------
  Future<List<MuscleGroup>> getMuscleSubgroups(String musclegroup) async {
      final response = await client.get("$baseUrl/api/musclesubgroups");
      if (response.statusCode == 200) {
        return BrandsFromJson(response.body);
      } else {
        return null;
      }
  }

  Future<List<MuscleGroup>> getMusclegroups(String musclegroupName) async {

  }

  Future<List<Exercise>> getMuscleSubgroupExercises(String primaryActivation) async {
      final response = await client.get("$baseUrl/api/Brands");
      if (response.statusCode == 200) {
        return Exercise.fromMap(response.body);
      } else {
        return null;
      }
  }

  Future<Exercise?> getExercise(String exerciseId) async {
    final response = await client.get("$baseUrl/api/Brands");
    if (response.statusCode == 200) {
      return Exercise.fromMap(response.body);
    } else {
      return null;
    }
  }


  //-----------------------------------------------------------------------------------------------
  //THE FOLLOWING METHOD IS FOR GENERATING A WORKOUT.
  //-----------------------------------------------------------------------------------------------
  Future<List<Exercise>> getWorkout(String workoutType) async {

  }



  //-----------------------------------------------------------------------------------------------
  //ALL THE FOLLOWING IS FOR RETRIEVING SAVED WORKOUTS
  //-----------------------------------------------------------------------------------------------
  // getting the workouts, just not sending it on to the widget.
  Future<List<SavedWorkout>> getSavedWorkouts(String userEmail) async {

  }

  // not tested yet
  Future<List<Exercise>> getExercisesForSavedWorkout(String workoutId) async {

  }


  //-----------------------------------------------------------------------------------------------
  //ALL THE FOLLOWING IS FOR SAVING WORKOUTS
  //-----------------------------------------------------------------------------------------------
  Future<String> SaveWorkout(List<String> exerciseList, String name, String userEmail, String workoutType) async {

  }


  //-----------------------------------------------------------------------------------------------
  //ALL THE FOLLOWING IS FOR ADDING/REMOVING FAVORITE ON EXERCISE
  //-----------------------------------------------------------------------------------------------
  Future<String> setFavoriteExercise(String exerciseId, String userEmail) async {

  }

  Future<bool> isFavorite(String userEmail, String exerciseId) async {

  }


  //-----------------------------------------------------------------------------------------------
  //ALL THE FOLLOWING IS FOR GETTING FAVORITE EXERCISES
  //-----------------------------------------------------------------------------------------------
  Future<List<Exercise>> getFavoriteExercises(String userEmail) async {

  }
   */
}
