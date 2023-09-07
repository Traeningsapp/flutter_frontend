import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/presentation/views/workout/createWorkout.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

class HomeWidget extends StatelessWidget {

  HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SelectedMainColor,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                  textAlign: TextAlign.center,
                  'Velkommen',
                  textScaleFactor: 2,
                  style: TextStyle(
                    color: SelectedHeadlineColor,
                  ),
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(),
                ),
                Expanded(
                  child: Column(),
                ),
                Expanded(
                  child: Column(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                'Workout App',
                textScaleFactor: 2.5,
                style: TextStyle(
                  color: SelectedHeadlineColor,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              child: FittedBox(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(SelectedSecondaryColor)
                  ),
                  child: Text(
                      textScaleFactor: 0.7,
                      textAlign: TextAlign.center,
                      'Create workout',
                      style: TextStyle(
                        color: SelectedHeadlineColor
                      ),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateWorkoutPage()),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}