import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/models/exerciseStats.dart';
import 'package:projekt_frontend/src/models/workout.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

class FinishedWorkoutWidget extends StatefulWidget {
  final List sentExerciseStats;
  final List<Exercise>? generatedWorkout;
  final String workoutType;
  const FinishedWorkoutWidget({Key? key, required this.generatedWorkout, required this.workoutType,required this.sentExerciseStats}) : super(key: key);

  @override
  State<FinishedWorkoutWidget> createState() => _FinishedWorkoutWidgetState();
}

class _FinishedWorkoutWidgetState extends State<FinishedWorkoutWidget> {
  final DatabaseService _dbService = DatabaseService();
  final TextEditingController _workoutNameController = TextEditingController();

  var recievedExerciseStats;
  late List<Exercise>? recievedGeneratedWorkout;
  List<ExerciseStats> exerciseStatsList = [];

  late Workout workout;
  late bool visibleToUser = false;

  late Future<String?> confirmation;

  @override
  void initState() {
    super.initState();
    setList();
    setupWorkout();
  }

  Future<void> setList() async {
    recievedGeneratedWorkout = widget.generatedWorkout;
    recievedExerciseStats = widget.sentExerciseStats;

    for (dynamic item in recievedExerciseStats) {
      if (item is ExerciseStats) {
        exerciseStatsList.add(item);
      }
    }
  }

  void setupWorkout() {
    workout = Workout(
        userId: Global_userid,
        createdDate: DateTime.now(),
        exercises: recievedGeneratedWorkout,
        visibleToUser: visibleToUser);

    print(workout);

    StoreWorkoutData();
  }

  void SaveWorkout() {
    workout.visibleToUser = true;
    workout.name = _workoutNameController.text;
  }

  Future<String?> StoreWorkoutData() async {
    confirmation = _dbService.postWorkout(workout, exerciseStatsList, Global_userid);

    if(confirmation == "Success!");
    {
      //Får vi et korrekt svar tilbage?
      print('Workout and Stats Saved.');
    }
  }


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
                  'You have finished your workout. Great job mate.'),
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
                          Navigator.popUntil(context, (route) => route.isFirst)
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
                      TextButton(onPressed: () => SaveWorkout(),
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

