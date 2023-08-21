import 'dart:developer';
import 'package:projekt_frontend/src/models/musclegroup.dart';
import 'package:http/http.dart' as http;
import 'package:projekt_frontend/src/models/muscle.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

class DatabaseService {
  final String baseUrl = "https://10.0.2.2:7130/api";
  //final String baseUrl = "http://10.0.2.2:5110/api";

  Future<List<Muscle>?> getMuscles(int muscleSubId) async {
    try {
      final String accessToken = Global_Access_token;
      final url = Uri.parse("$baseUrl/Exercise/get/muscle/$muscleSubId");
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'content-type': 'application/json'
        },
      ).timeout(Duration(seconds: 10));
      print(Global_Access_token);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        print('success');
        return musclesFromJson(response.body);
      }
    }
    catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }
}