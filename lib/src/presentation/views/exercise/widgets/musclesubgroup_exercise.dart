import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/presentation/views/exercise/widgets/exercise_widget.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar_widget.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';

class MuscleExercisesWidget extends StatefulWidget {
  final String muscle;
  const MuscleExercisesWidget({required this.muscle ,super.key});

  @override
  State<MuscleExercisesWidget> createState() => _MuscleExercisesWidgetState();
}

class _MuscleExercisesWidgetState extends State<MuscleExercisesWidget> {
  final DatabaseService _dbService = DatabaseService();
  Future<List<Exercise>>? muscleList;

  @override
  void initState() {
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    //muscleSubgroupList = _dbService.getMuscleSubgroupExercises(widget.muscleSubgroup);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'Exercises', themecolor: Colors.green),
      body: FutureBuilder(
        future: muscleList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final specificMuscleSubgroup = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(5),
              children: specificMuscleSubgroup.map(buildMuscleExercise).toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildMuscleExercise(Exercise specificMuscleSubgroup) => OpenContainer(
    // transitionDuration: const Duration(seconds: 2),
    closedColor: Colors.transparent,
    closedElevation: 0,
    transitionType: ContainerTransitionType.fadeThrough,
    closedBuilder: (BuildContext _, VoidCallback openContainer) {
      return Card(
        elevation: 3,
        child: ListTile(
            contentPadding: const EdgeInsets.only(left: 15, top: 3, bottom: 3),
            tileColor: Colors.white,
            title: Text(specificMuscleSubgroup.name!),
            trailing: const Icon(Icons.arrow_right,),
            onTap: openContainer
        ),
      );
    },
    openBuilder: (BuildContext _, VoidCallback __) {
      return ExerciseWidget(exercise: specificMuscleSubgroup.id!);
    },
  );

}

