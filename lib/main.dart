import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projekt_frontend/src/presentation/views/main_view.dart';

void main() async {
  await dotenv.load();

  runApp(const MainView());
}
