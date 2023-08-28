import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/models/workout.dart';
import 'package:projekt_frontend/src/presentation/views/create_workout/widgets/activeWorkout.dart';
import 'package:projekt_frontend/src/presentation/views/exercise/widgets/exercise.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

class SpecificWorkoutWidget extends StatefulWidget {
  final int? workoutId;
  const SpecificWorkoutWidget({required this.workoutId, super.key});

  @override
  State<SpecificWorkoutWidget> createState() => _SpecificWorkoutWidgetState();
}

class _SpecificWorkoutWidgetState extends State<SpecificWorkoutWidget> {
  final DatabaseService _dbService = DatabaseService();
  late Future<Workout?> savedWorkout;
  late List<Exercise>? exercisesToStartWorkout;

  @override
  void initState() {
    super.initState();
    _initRetrieval();
    createWorkoutList();
  }

  Future<void> _initRetrieval() async {
    savedWorkout = _dbService.getSpecificWorkout(widget.workoutId!, Global_userid);
  }

  void createWorkoutList() async {
    if(savedWorkout != null) {
      Workout? workout = await savedWorkout;
      exercisesToStartWorkout = workout!.exercises;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'Exercises in Workout', themecolor: Colors.orange),
      body: FutureBuilder(
        future: savedWorkout,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final specificWorkout = snapshot.data!;
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.83,
                  child: ListView.builder(
                  itemCount: specificWorkout.exercises!.length,
                      itemBuilder: (context, index) {
                        return buildWorkoutExercise(specificWorkout.exercises![index]);
                      }
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.04),
                      child: ElevatedButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ActiveWorkoutWidget(
                                activeWorkout: exercisesToStartWorkout,
                                workoutType: 'Push',
                                themecolor: Colors.orange,
                              ))),
                          child: const Text('Start workout')
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
                      child: ElevatedButton(
                          onPressed: () => (),
                          child: const Text('Edit workout')
                      ),
                    )
                  ],
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildWorkoutExercise(Exercise specificWorkoutExercise) => OpenContainer(
    transitionDuration: const Duration(milliseconds: 700),
    closedColor: Colors.transparent,
    closedElevation: 0,
    transitionType: ContainerTransitionType.fadeThrough,
    closedBuilder: (BuildContext _, VoidCallback openContainer) {
      return Card(
        elevation: 3,
        child: ListTile(
            contentPadding: const EdgeInsets.only(left: 15, top: 3, bottom: 3),
            tileColor: Colors.white,
            title: Text(specificWorkoutExercise.name!),
            trailing: const Icon(Icons.arrow_drop_down),
            onTap: openContainer
        ),
      );
    },
    openBuilder: (BuildContext _, VoidCallback __) {
      return ExerciseWidget(exercise: specificWorkoutExercise, themecolor: Colors.orange);
    },
  );

}
