import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';

class FinishedWorkoutWidget extends StatefulWidget {
  final List<String> sentExerciseIds;
  final List<Exercise>? generatedWorkout;
  final String workoutType;
  const FinishedWorkoutWidget({Key? key, required this.generatedWorkout, required this.workoutType, required this.sentExerciseIds}) : super(key: key);

  @override
  State<FinishedWorkoutWidget> createState() => _FinishedWorkoutWidgetState();
}

class _FinishedWorkoutWidgetState extends State<FinishedWorkoutWidget> {
  final DatabaseService _dbService = DatabaseService();
  late final List<String> exerciseIds;

  final TextEditingController _workoutNameController = TextEditingController();

  late Future<String> confirmation;

  @override
  void initState() {
    super.initState();
    setList();
  }

  Future<void> setList() async {
    exerciseIds = widget.sentExerciseIds;
    debugPrint(exerciseIds.toString());
  }

  /*
  Future<bool?> SaveWorkout() async {
    confirmation = _dbService.SaveWorkout(exerciseIds, _workoutNameController.text, user.email!, widget.workoutType);
    Navigator.of(context).pop();

    // evt. noget ala det her for confirmation.
    // if(confirmation == 'Success')
    //   {
    //     showDialog(
    //         context: context,
    //         builder: (context) => AlertDialog(
    //           title: const Text('Saved Workout'),
    //           content: const Text('Your workout has been saved'),
    //           actions: [
    //             TextButton(onPressed: () => Navigator.pop(context),
    //                 child: const Text('OK'))
    //           ],
    //         ));
    //   } else if(confirmation == 'Error') {
    //     showDialog(
    //         context: context,
    //         builder: (context) => AlertDialog(
    //           title: const Text('Workout not saved'),
    //           content: const Text('Something went wrong while trying to save workout'),
    //           actions: [
    //             TextButton(onPressed: () => Navigator.pop(context),
    //                 child: const Text('OK'))
    //           ],
    //         ));
    //   }
    //
    //
  }
  */

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              alignment: Alignment.center, padding: const EdgeInsets.all(20)),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(style: TextStyle(
                fontSize: 16
              ),
                  textAlign: TextAlign.center,
                  'You have finished your workout. GJ mate'),
            ],
          ),
          Container(
              alignment: Alignment.center, padding: const EdgeInsets.fromLTRB(0,60,0,0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Center(
                    child: ElevatedButton(
                      child: const Text('Go to homepage'),
                      onPressed: () =>
                          Navigator.popUntil(context, (route) => route.isFirst),
                    ),
                  )
                ],
              )
            ],
          ),
          Expanded(
            flex: 2,
              child: Container(
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                elevation: 4,
                onPressed: () => showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    title: const Text('Indtast navn som workout gemmes under'),
                    content: TextField(
                      onChanged: (value) { },
                      controller: _workoutNameController,
                      decoration: const InputDecoration(hintText: "Workout navn"),
                    ),
                    actions: [
                      TextButton(onPressed: () => (),
                          child: const Text('Gem Workout')
                      )
                    ],
                  );
                }),
                child: const Icon(Icons.add),
              ),
            ],
          )
        ],
      ),
    );
  }
}

