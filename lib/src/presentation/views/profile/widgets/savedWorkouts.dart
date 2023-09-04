import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/workout.dart';
import 'package:projekt_frontend/src/presentation/views/profile/widgets/specificWorkout.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar.dart';
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

  @override
  void initState() {
    super.initState();
    loadWorkoutList();
  }

  Future<void> loadWorkoutList() async {
    setState(() {
      workoutList = _dbService.getSavedWorkouts(Global_userid);
    });
  }

  void deleteWorkout(int workoutId) async {
    _dbService.deleteWorkoutFromHistory(workoutId);
    await Future.delayed(const Duration(milliseconds: 400));
    loadWorkoutList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'Saved Workouts'),
      body: FutureBuilder<List<Workout>?>(
        future: workoutList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final retrievedWorkoutData = snapshot.data!;
            print(retrievedWorkoutData);
            return ListView.builder(
              itemCount: retrievedWorkoutData.length,
              itemBuilder: (context, index) {
                return buildWorkoutCard(retrievedWorkoutData[index]);
              },
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
        leading: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Are you sure you want to delete workout?'),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          deleteWorkout(workout.id!);
                          Navigator.pop(context);
                          setState(() {

                          });
                        },
                        child: const Text('delete Workout')),
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'))
                  ],
                );
              },
            );// Image tapped
          },
          child: Image.asset(
            'assets/images/deleteImage.png',
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
        onTap: () { Navigator.push(context, MaterialPageRoute(
            builder: (context) => SpecificWorkoutWidget(workoutId: workout.id))); },
        tileColor: Colors.white,
        contentPadding: const EdgeInsets.only(left: 15, top: 3, bottom: 3),
        trailing: const Icon(Icons.arrow_right,),
        title: Text(workout.name!,
          style: const TextStyle(
              fontSize: fontsizeForTitles
          ),
        ),
        subtitle: Text(workout.splitType!,
          style: const TextStyle(
              fontSize: fontsizeForSubTitles
          ),
        ),
      ),
    );
  }
}
