import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';
import 'package:projekt_frontend/src/utils/extensions.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

class ExerciseWidget extends StatefulWidget {
  final Exercise exercise;
  final Color themecolor;
  const ExerciseWidget({Key? key, required this.exercise, required this.themecolor}) : super(key: key);

  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  final DatabaseService _dbService = DatabaseService();
  late Future<bool?> isFavorite;
  late bool? favorite = false;

  late Exercise exercise;

  @override
  void initState() {
    super.initState();

    exercise = widget.exercise;
    isFavorite = _dbService.getFavoriteExercise(Global_userid, exercise.id);
    changeBool();
  }

  @override
  dispose() {
    super.dispose();
  }

  void changeBool() async {
    favorite = await isFavorite!;
  }

  void SetOrDeleteFavorite() async {
    setState(() {
      if(favorite == false) {
        _dbService.setFavoriteExercise(Global_userid, exercise.id);
        favorite = true;
      } else {
        _dbService.deleteFavoriteExercise(Global_userid, exercise.id);
        favorite = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
          title: widget.exercise.name!,
          themecolor: widget.themecolor),
      body: Container(
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(top: 30.0),
              child: buildExercise(widget.exercise),
            ),
      ),
    ));
  }

  Widget buildExercise(Exercise snapshotData) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Exercise information',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w500),
                ),
                IconButton(
                    onPressed: () {
                      SetOrDeleteFavorite();
                    },
                    icon: favorite == true ? const Icon(Icons.favorite, color: Colors.red) : const Icon(Icons.favorite_border, color: Colors.red,))
              ],
            ),
            Text('name: ${snapshotData.name}'),
            Text('Description: ${snapshotData.description}'),
            Text('Benefits: ${snapshotData.benefits}'),
            Text('Included in:  ${snapshotData.includedIn}'
                .removeSquareBrackets()
                .toTitleCase()),
            Text('muscle activation:  ${snapshotData.muscleActivation}'
                .removeSquareBrackets()),
            Text('Starting compound?:  ${snapshotData.startingCompound}'),
          ],
        ),
      );
}

