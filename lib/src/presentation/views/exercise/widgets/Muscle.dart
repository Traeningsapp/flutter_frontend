import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/muscle.dart';
import 'package:projekt_frontend/src/presentation/views/exercise/widgets/musclesubgroup_exercise.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar_widget.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';

class MusclePage extends StatefulWidget {
  final int musclegroupId;
  const MusclePage({required this.musclegroupId, super.key});

  @override
  State<MusclePage> createState() => _MusclePageState();
}

class _MusclePageState extends State<MusclePage> {
  final DatabaseService _dbService = DatabaseService();
  late Future<List<Muscle>?> musclesList;

  @override
  void initState() {
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    print(widget.musclegroupId);
    musclesList = _dbService.getMuscles(widget.musclegroupId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'Subgroup', themecolor: Colors.green),
      body: FutureBuilder(
        future: musclesList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final muscle = snapshot.data!;
            return ListView.builder(
                itemCount: muscle.length,
                itemBuilder: (context, index) {
                  return buildMuscleWidget(muscle[index]);
                }
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildMuscleWidget(Muscle muscle) => Card(
    elevation: 4,
    child: ListTile(
        contentPadding: const EdgeInsets.only(left: 15, top: 3, bottom: 3),
        tileColor: Colors.white,
        title: Text(muscle.name),
        trailing: const Icon(Icons.arrow_right,),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MuscleExercisesWidget(muscle: muscle.name)))
    ),
  );
}