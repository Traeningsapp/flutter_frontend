import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/howTo.dart';

class ExerciseHowToOverlay extends StatefulWidget {
  final List<ExerciseHowTo> exerciseHowTo;
  final String exerciseName;
  const ExerciseHowToOverlay(
      {required this.exerciseHowTo, required this.exerciseName, super.key});

  @override
  State<ExerciseHowToOverlay> createState() => _ExerciseHowToOverlayState();
}

class _ExerciseHowToOverlayState extends State<ExerciseHowToOverlay>
    with SingleTickerProviderStateMixin {
  late List<ExerciseHowTo> exerciseHowTo;
  late String exerciseName;

  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    exerciseHowTo = widget.exerciseHowTo;
    exerciseName = widget.exerciseName;

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  // Initial setup. Fix this. Return rows with how to steps.
  void createHowToList() {
    if (exerciseHowTo != null) {
      for (int i = 0; i < exerciseHowTo!.length; i++) {
        Row(children: [
            Text('Step ${(exerciseHowTo![i].step)} :'),
            Text(exerciseHowTo![i].step_text)
        ]);
      }
    } else {
      throw Exception('No how to for exercise');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(15.0),
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: ShapeDecoration(
                color: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(exerciseName),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('How To:')],
                ),
                const Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
