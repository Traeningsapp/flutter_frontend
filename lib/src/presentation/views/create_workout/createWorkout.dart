import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/presentation/views/create_workout/widgets/newWorkout.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar.dart';

class CreateWorkoutPage extends StatelessWidget {
  const CreateWorkoutPage({Key? key}) : super(key: key);

  static const String _title = 'Create workout';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'New Workout', themecolor: Colors.blue),
      body: NewWorkoutWidget()
    );
  }
}