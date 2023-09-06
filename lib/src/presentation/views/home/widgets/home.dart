import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/presentation/views/workout/createWorkout.dart';
import 'package:projekt_frontend/src/utils/constants.dart';

class HomeWidget extends StatelessWidget {

  HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor,
      body: Column(
        children: [
          const Expanded(
            flex: 2,
            child: Center(
              child: Text(
                  textAlign: TextAlign.center,
                  'Velkommen',
                  textScaleFactor: 2),
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
          const Expanded(
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                'Workout App',
                textScaleFactor: 2.5,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              child: FittedBox(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(SecondaryColor)
                  ),
                  child: const Text(
                      textScaleFactor: 0.7,
                      textAlign: TextAlign.center,
                      'Create workout',
                      style: TextStyle(
                        color: HeadlineColor
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