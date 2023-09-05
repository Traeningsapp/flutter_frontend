import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/howTo.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';

class ExerciseHowToOverlay extends StatefulWidget {
  final int exerciseId;
  final String exerciseName;
  const ExerciseHowToOverlay(
      {required this.exerciseId, required this.exerciseName, super.key});

  @override
  State<ExerciseHowToOverlay> createState() => _ExerciseHowToOverlayState();
}

class _ExerciseHowToOverlayState extends State<ExerciseHowToOverlay>
    with SingleTickerProviderStateMixin {
  final DatabaseService _dbService = DatabaseService();

  late int exerciseId;
  late String exerciseName;
  List<ExerciseHowTo>? howTo = [];

  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initRetrieval();
    _setupControllerAndAnimation();
  }

  Future<void> _initRetrieval() async {
    exerciseId = widget.exerciseId;
    exerciseName = widget.exerciseName;

    howTo = await _dbService.getExerciseHowTo(exerciseId);
  }

  void _setupControllerAndAnimation() {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(15.0),
            height: MediaQuery.of(context).size.height * 0.5,
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ListView.builder(
                      itemCount: howTo!.length,
                      itemBuilder: (context, index) {
                        return createHowToRoW(howTo![index]);
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row createHowToRoW(ExerciseHowTo howTo) {
    if (howTo != null) {
      return Row(
          children: [Text('Step ${(howTo!.step)} :'), Text(howTo!.step_text)]);
    } else {
      throw Exception('No how to for exercise');
    }
  }
}
