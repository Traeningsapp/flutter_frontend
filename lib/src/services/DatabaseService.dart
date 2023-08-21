import 'dart:developer';
import 'package:projekt_frontend/src/models/musclegroup.dart';
import 'package:http/http.dart' as http;
import 'package:projekt_frontend/src/models/muscle.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

class DatabaseService {
  final String baseUrl = "http://10.0.2.2:7130/api";

  Future<List<Muscle>?> getMuscles(int muscleSubId) async {
    try {
      final String accessToken = Global_Access_token;
      var url = Uri.parse("$baseUrl/Exercise/get/muscle/$muscleSubId");
      print('step1');
      print(url);
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('success');
        return musclesFromJson(response.body);
      }
    }
    catch (e) {
      print('failure');
      print(e.toString());
      log(e.toString());
    }
  }


}