import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/presentation/views/profile/widgets/savedWorkouts.dart';

class SavedWorkoutsPage extends StatefulWidget {
  const SavedWorkoutsPage({Key? key}) : super(key: key);

  @override
  State<SavedWorkoutsPage> createState() => _SavedWorkoutsPageState();
}

class _SavedWorkoutsPageState extends State<SavedWorkoutsPage> {
  @override
  Widget build(BuildContext context) {
    return SavedWorkoutWidget();
  }
}
