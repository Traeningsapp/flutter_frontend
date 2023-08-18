import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/musclegroup.dart';
import 'package:projekt_frontend/src/presentation/views/exercise/widgets/musclesubgroup_exercise.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar_widget.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';

class MuscleSubGroupPage extends StatefulWidget {
  final String musclegroup;
  const MuscleSubGroupPage({required this.musclegroup, super.key});

  @override
  State<MuscleSubGroupPage> createState() => _MuscleSubGroupPageState();
}

class _MuscleSubGroupPageState extends State<MuscleSubGroupPage> {
  final DatabaseService _dbService = DatabaseService();
  Future<List<MuscleGroup>>? muscleSubgroupsList;

  @override
  void initState() {
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    //muscleSubgroupsList = _dbService.getMusclegroups(widget.musclegroup);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'Subgroup', themecolor: Colors.green),
      body: FutureBuilder(
        future: muscleSubgroupsList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final muscleSubgroups = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(5),
              children: muscleSubgroups.map(buildMuscleSubgroup).toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildMuscleSubgroup(MuscleGroup muscleSubgroup) => Card(
    elevation: 4,
    child: ListTile(
        contentPadding: const EdgeInsets.only(left: 15, top: 3, bottom: 3),
        tileColor: Colors.white,
        title: Text(muscleSubgroup.name),
        trailing: const Icon(Icons.arrow_right,),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MuscleSubGroupExercisesWidget(muscleSubgroup: muscleSubgroup.name)))
    ),
  );
}
