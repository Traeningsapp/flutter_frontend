import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/presentation/views/exercise/widgets/exercise.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar_widget.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';

class MuscleExercisesWidget extends StatefulWidget {
  final int muscle_id;
  const MuscleExercisesWidget({required this.muscle_id ,super.key});

  @override
  State<MuscleExercisesWidget> createState() => _MuscleExercisesWidgetState();
}

class _MuscleExercisesWidgetState extends State<MuscleExercisesWidget> {
  final DatabaseService _dbService = DatabaseService();
  late Future<List<Exercise>?> muscleExerciseList;

  @override
  void initState() {
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    muscleExerciseList = _dbService.getMuscleExercises(widget.muscle_id);
    print('after dbservice');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'Exercises', themecolor: Colors.green),
      body: FutureBuilder(
        future: muscleExerciseList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final specificMuscleExercise = snapshot.data!;
            return ListView.builder(
                itemCount: specificMuscleExercise.length,
                itemBuilder: (context, index) {
                  return buildMuscleExercise(specificMuscleExercise[index]);
                }
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildMuscleExercise(Exercise specificMuscleExercise) => OpenContainer(
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
            title: Text(specificMuscleExercise.name!),
            trailing: const Icon(Icons.arrow_drop_down),
            onTap: openContainer
        ),
      );
    },
    openBuilder: (BuildContext _, VoidCallback __) {
      return ExerciseWidget(exercise: specificMuscleExercise);
    },
  );

}

