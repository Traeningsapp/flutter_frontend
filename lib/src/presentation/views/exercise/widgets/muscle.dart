import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/muscle.dart';
import 'package:projekt_frontend/src/presentation/views/exercise/widgets/muscleExercises.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

class MuscleWidget extends StatefulWidget {
  final int musclegroupId;
  const MuscleWidget({required this.musclegroupId, super.key});

  @override
  State<MuscleWidget> createState() => _MuscleWidgetState();
}

class _MuscleWidgetState extends State<MuscleWidget> {
  final DatabaseService _dbService = DatabaseService();
  late Future<List<Muscle>?> musclesList;
  late List<Muscle>? muscles;

  @override
  void initState() {
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    musclesList = _dbService.getMuscles(widget.musclegroupId);
    muscles = await musclesList;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'Muscles'),
      backgroundColor: SelectedMainColor,
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
        tileColor: SelectedSecondaryColor,
        title: Text(muscle.name),
        trailing: const Icon(Icons.arrow_right,),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: SelectedTertiaryColor, width: 2),
            borderRadius: BorderRadius.circular(5)
        ),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MuscleExercisesWidget(muscle_id: muscle.id)))
    ),
  );
}