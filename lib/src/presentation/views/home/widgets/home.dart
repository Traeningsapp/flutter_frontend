import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/presentation/views/create_workout/createWorkout.dart';

class HomeWidget extends StatelessWidget {

  HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Expanded(
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
                  child: const Text(
                      textScaleFactor: 0.7,
                      textAlign: TextAlign.center,
                      'Create workout'
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