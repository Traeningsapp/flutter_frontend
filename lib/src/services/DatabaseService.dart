import 'dart:developer';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/models/musclegroup.dart';
import 'package:http/http.dart' as http;
import 'package:projekt_frontend/src/models/muscle.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

class DatabaseService {
  final String baseUrl = "https://10.0.2.2:7130/api";
  //final String baseUrl = "http://10.0.2.2:5110/api";

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
      print(response.statusCode);
      print(accessToken);
      if (response.statusCode == 200) {
        print(response.body);
        return musclesFromJson(response.body);
      }
    }
    catch (e) {
      print(e.toString());
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
      print(response.statusCode);
      print(accessToken);
      if (response.statusCode == 200) {
        print(response.body);
        return exercisesFromJson(response.body);
      }
    }
    catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }
}