import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/presentation/views/exercise/widgets/muscleGroup.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MuscleGroupWidget(),
    );
  }
}
