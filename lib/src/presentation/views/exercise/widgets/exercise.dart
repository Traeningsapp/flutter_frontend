import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar.dart';
import 'package:projekt_frontend/src/utils/extensions.dart';

class ExerciseWidget extends StatefulWidget {
  final Exercise exercise;
  final Color themecolor;
  const ExerciseWidget({Key? key, required this.exercise, required this.themecolor}) : super(key: key);

  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {


  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
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
            Text('muscle activation:  ${snapshotData.muscleActivation}'
                .removeSquareBrackets()),
            Text('Starting compound?:  ${snapshotData.startingCompound}'),
          ],
        ),
      );
}

