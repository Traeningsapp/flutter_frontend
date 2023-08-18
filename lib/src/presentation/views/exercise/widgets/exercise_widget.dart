import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar_widget.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';
import 'package:projekt_frontend/src/utils/extensions.dart';

class ExerciseWidget extends StatefulWidget {
  final String exercise;
  const ExerciseWidget({Key? key, required this.exercise}) : super(key: key);

  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  final DatabaseService _dbService = DatabaseService();
  Future<Exercise?>? exercise;
  late Future<String?>? confirmation;

  @override
  void initState() {
    super.initState();
    _initExercise();
  }

  @override
  dispose() {
    super.dispose();
  }

  Future<void> _initExercise() async {
    //exercise = _dbService.getExercise(widget.exercise);
  }

  /*
  Future<void> setFavorite(String? exerciseId) async {
    confirmation = _db.setFavoriteExercise(exerciseId!, user.email!);

    if(confirmation == Future.value('Added')) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exercise set as favorite'),
            content: const Text('The exercise has been added as one of your favorites, you can now easy find it under Profile - Favorite Exercises'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context),
                  child: const Text('OK'))
            ],
          ));
    } if(confirmation == Future.value('Removed')) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exercise removed as favorite'),
            content: const Text('The exercise has been removed as one of your favorites, you can easily add it again by finding the exercise and clicking the favorite heart'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context),
                  child: const Text('OK'))
            ],
          ));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Something went wrong'),
            content: const Text('The exercise has neither been added or removed due to an error.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context),
                  child: const Text('OK'))
            ],
          ));
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: exercise,
      builder: (context, snapshot) => Scaffold(
          appBar: CustomAppBarWidget(
              title: (snapshot.hasData) ? snapshot.data!.name! : '',
              themecolor: Colors.green),
          body: Center(
            child: (snapshot.hasData)
                ? Container(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: buildExercise(snapshot.data!),
                  )
                : (snapshot.hasError)
                    ? Text('${snapshot.error}')
                    : const CircularProgressIndicator(),
          )),
    );
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
                    onPressed: () => (),
                    icon: const Icon(Icons.favorite))
              ],
            ),
            Text('name: ${snapshotData.name}'),
            Text('Description: ${snapshotData.description}'),
            Text('Benefits: ${snapshotData.benefits}'),
            Text('Included in:  ${snapshotData.includedIn}'
                .removeSquareBrackets()
                .toTitleCase()),
            Text('Primary: ${snapshotData.primaryActivation}'),
            Text('Secondary:  ${snapshotData.secondaryActivation}'
                .removeSquareBrackets()),
            Text('Starting compound?:  ${snapshotData.startingCompound}'),
          ],
        ),
      );
}

// setFavorite(snapshotData.id!)