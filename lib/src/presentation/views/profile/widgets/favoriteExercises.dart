import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/presentation/views/exercise/widgets/exercise.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

class FavoriteExercisesWidget extends StatefulWidget {
  const FavoriteExercisesWidget({super.key});

  @override
  State<FavoriteExercisesWidget> createState() => _FavoriteExercisesWidgetState();
}

class _FavoriteExercisesWidgetState extends State<FavoriteExercisesWidget> {
  final DatabaseService _dbService = DatabaseService();
  late Future<List<Exercise>?> favoriteExerciseList;


  @override
  void initState() {
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    favoriteExerciseList = _dbService.getFavoriteExercises(Global_userid);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'Favorite Exercises'),
      body: FutureBuilder(
        future: favoriteExerciseList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final retrievedExerciseData = snapshot.data!;
            return ListView.builder(
                itemCount: retrievedExerciseData.length,
                itemBuilder: (context, index) {
                  return buildFavoriteExercise(retrievedExerciseData[index]);
                }
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildFavoriteExercise(Exercise favoriteExercise) => OpenContainer(
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
            title: Text(favoriteExercise.name!),
            trailing: const Icon(Icons.arrow_drop_down),
            onTap: openContainer
        ),
      );
    },
    openBuilder: (BuildContext _, VoidCallback __) {
      return ExerciseWidget(exercise: favoriteExercise, themecolor: Colors.orange);
    },
  );

}
