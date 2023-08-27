import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/workout.dart';
import 'package:projekt_frontend/src/presentation/views/profile/widgets/specificWorkout.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar_widget.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';
import 'package:projekt_frontend/src/utils/constants.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

class SavedWorkoutWidget extends StatefulWidget {
  const SavedWorkoutWidget({super.key});

  @override
  State<SavedWorkoutWidget> createState() => _SavedWorkoutWidgetState();
}

class _SavedWorkoutWidgetState extends State<SavedWorkoutWidget> {
  DatabaseService _dbService = DatabaseService();

  late Future<List<Workout>?> workoutList;

  late String name;
  late String splitType;
  late int workoutId;



  @override
  void initState() {
    _initRetrieval();
  }


  Future<void> _initRetrieval() async {
    workoutList = _dbService.getSavedWorkouts(Global_userid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'Saved Workouts', themecolor: Colors.green),
      body: FutureBuilder(
        future: workoutList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final specificWorkout = snapshot.data!;
            return ListView.builder(
                itemCount: specificWorkout.length,
                itemBuilder: (context, index) {
                  return buildWorkoutCard(specificWorkout[index]);
                }
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildWorkoutCard(Workout workout) {
    return Card(
      elevation: 4,
      child: ListTile(
        onTap: () { Navigator.push(context, MaterialPageRoute(
            builder: (context) => SpecificWorkoutWidget(workoutId: workout.id))); },
        tileColor: Colors.white,
        contentPadding: const EdgeInsets.only(left: 15, top: 3, bottom: 3),
        trailing: const Icon(Icons.arrow_right,),
        title: Text(name,
          style: const TextStyle(
              fontSize: fontsizeForTitles
          ),
        ),
        subtitle: Text(workout.createdDate as String,
          style: const TextStyle(
              fontSize: fontsizeForSubTitles
          ),
        ),
      ),
    );
  }
}
