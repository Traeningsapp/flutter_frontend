import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/presentation/views/workout/widgets/newWorkout.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar.dart';

class CreateWorkoutPage extends StatelessWidget {
  const CreateWorkoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'New Workout'),
      body: NewWorkoutWidget()
    );
  }
}