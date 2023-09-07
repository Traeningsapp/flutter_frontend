import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/models/exerciseStats.dart';
import 'package:projekt_frontend/src/models/workout.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';
import 'package:projekt_frontend/src/utils/constants.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

class FinishedWorkoutWidget extends StatefulWidget {
  final List sentExerciseStats;
  final List<Exercise>? generatedWorkout;
  final String workoutType;
  const FinishedWorkoutWidget(
      {Key? key,
      required this.generatedWorkout,
      required this.workoutType,
      required this.sentExerciseStats})
      : super(key: key);

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

  late int? workoutId;

  @override
  void initState() {
    super.initState();
    setList();
    setupWorkout();
    storeWorkoutData();
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
        exercises: recievedGeneratedWorkout?.map((exercise) {
          List<ExerciseStats> stats = exerciseStatsList
              .where((stats) => stats.exerciseId == exercise.id)
              .toList();
          return exercise.copyWith(stats: stats);
        }).toList(),
        visibleToUser: visibleToUser);
  }

  void saveWorkout() {
    workout.visibleToUser = true;
    workout.name = _workoutNameController.text;

    storeWorkoutData();
  }

  Future<void> storeWorkoutData() async {
    workout.id = await _dbService.postWorkout(workout, Global_userid, widget.workoutType);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
              alignment: Alignment.center, padding: const EdgeInsets.all(20)),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                  'You have finished your workout. Great job mate.'),
            ],
          ),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0, 60, 0, 0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(SelectedSecondaryColor)
                ),
                onPressed: () => showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Give the workout a name'),
                        content: TextField(
                          onChanged: (value) {},
                          controller: _workoutNameController,
                          decoration:
                              const InputDecoration(hintText: "Workout name"),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                saveWorkout();
                                Navigator.pop(context);
                              },
                              child: const Text('Save Workout'))
                        ],
                      );
                    }),
                child: const Text('Save workout for later'),
              ),
            ],
          ),
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.6)),
          Align(
              alignment: Alignment.bottomCenter,
              child: Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(SelectedSecondaryColor)
                    ),
                    child: const Text('Go to homepage'),
                    onPressed: () =>
                        Navigator.popUntil(context, (route) => route.isFirst)),
              )),
        ],
      ),
    );
  }
}
