import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projekt_frontend/src/models/ExerciseStatKey.dart';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/presentation/views/workout/widgets/addRep.dart';
import 'package:projekt_frontend/src/presentation/views/workout/widgets/finishedWorkout.dart';
import 'package:projekt_frontend/src/presentation/views/exercise/widgets/exerciseHowTo.dart';
import 'package:projekt_frontend/src/presentation/views/stats/widgets/specificExerciseStat.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

class ActiveWorkoutWidget extends StatefulWidget {
  final List<Exercise>? activeWorkout;
  final String workoutType;
  final int? workoutId;
  const ActiveWorkoutWidget(
      {Key? key,
      required this.activeWorkout,
      required this.workoutType,
      required this.workoutId})
      : super(key: key);

  @override
  State<ActiveWorkoutWidget> createState() => _ActiveWorkoutWidget();
}

class _ActiveWorkoutWidget extends State<ActiveWorkoutWidget> {
  final List<ExerciseStatKey> widgetKeys = [];
  late List<Exercise>? currentWorkout; //List of exercises to be shown
  late List<Widget>
      widgetExerciseList; //List of widgets which takes each of the exercises in the above list
  int counter = 0; //counter when running through exercise widgets.
  late int workoutlength; //amount of exercises in list
  int setantal = 3;
  int setnr = 1;
  late int exerciseId;
  bool firstWidgetCall = true;
  bool shouldClearWidgetKeys = true;

  var statsList = [];

  @override
  void initState() {
    super.initState();
    workoutlength = widget.activeWorkout!.length;
  }

  Future<List<Exercise>?> setList() async {
    currentWorkout = widget.activeWorkout;
    return currentWorkout;
  }

  List<Widget> generateExerciseWidgets(List<Exercise> workout) {
    if (shouldClearWidgetKeys) {
      widgetKeys.clear();
      if (widget.workoutId != 0) {
        for (var exercise in workout) {
          if (exercise.exerciseStats != null ||
              exercise.exerciseStats!.isNotEmpty) {
            for (var stats in exercise.exerciseStats!) {
              if (stats.exerciseId == exerciseId) {
                widgetKeys.add(ExerciseStatKey.withRepsAndKilo(DateTime.now(),
                    exercise.id, stats.reps, stats.kilo, stats.setnr!));
                setnr = stats.setnr! + 1;
              }
            }
          }
        }
        firstWidgetCall = false;
      }
    }
    List<Widget> list = <Widget>[];
    Widget _buildwidget;
    if (firstWidgetCall) {
      for (int i = 1; i <= setantal; i++) {
        widgetKeys.add(ExerciseStatKey(DateTime.now(), exerciseId, i));
        setnr++;
      }
      firstWidgetCall = false;
      shouldClearWidgetKeys = false;
    }

    for (var i = 0; i < workout.length; i++) {
      _buildwidget = buildWorkoutWidget(workout[i]);
      list.add(_buildwidget);
    }
    return list;
  }

  void _handleNext() {
    for (var key in widgetKeys) {
      if (key.stats.reps != null || key.stats.kilo != null) {
        statsList.add(key.stats);
      } else {
        Fluttertoast.showToast(
            msg: 'Udfyld alle felter eller fjern set',
            gravity: ToastGravity.CENTER);
        return;
      }
      key.reset();
    }
    setState(() {
      widgetKeys.clear();
      firstWidgetCall = true;
      setnr = 1;
      counter++;
      shouldClearWidgetKeys = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: SelectedMainColor,

        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBarWidget(title: 'Active Workout'),
        body: FutureBuilder<List<Exercise>?>(
            future: setList(),
            builder: (context, AsyncSnapshot<List<Exercise>?> snapshot) {
              if (snapshot.hasError) {
                return Text('something went wrong! ${snapshot.error}');
              } else if (snapshot.hasData) {
                final specificWorkout = snapshot.data!;
                if (counter >= specificWorkout.length) {
                  return FinishedWorkoutWidget(
                      generatedWorkout: currentWorkout,
                      workoutType: widget.workoutType,
                      sentExerciseStats: statsList);
                } else {
                  exerciseId = specificWorkout[counter].id;
                  widgetExerciseList = generateExerciseWidgets(specificWorkout);
                  return widgetExerciseList[counter];
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  } // Scaffold

  Widget buildWorkoutWidget(Exercise generatedWorkout) => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [const Color(0xffffffff), SelectedMainColor],
        stops: const [0.3, 0.45],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 3),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.26,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                              'assets/exerciseGifs/${generatedWorkout.id}.gif',
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height * 0.26,
                              width: MediaQuery.of(context).size.width * 0.6)
                        ],
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        alignment: Alignment.centerRight,
                        icon: const Icon(Icons.info_outline),
                        onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                ExerciseHowToOverlay(
                                    exerciseId: generatedWorkout.id,
                                    exerciseName: generatedWorkout.name)),
                      ),
                      IconButton(
                          alignment: Alignment.centerRight,
                          icon: const Icon(Icons.list_alt),
                          onPressed: () => showDialog(
                              context: context,
                              builder: ((BuildContext context) =>
                                  ExerciseStatsOverlay(
                                    exerciseId: generatedWorkout.id,
                                    userId: Global_userid,
                                    exerciseName: generatedWorkout.name,
                                  )))),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Description',
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                generatedWorkout.description,
                                style: const TextStyle(
                                    color: Colors.black38,
                                    fontSize: 13
                                ),
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Benefits',
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                generatedWorkout.benefits,
                                style: const TextStyle(
                                    color: Colors.black38,
                                    fontSize: 13
                                ),
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
                      height: MediaQuery.of(context).size.height * 0.22,
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: SelectedTertiaryColor, width: 2),
                      // ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.20, 0, 0, 0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.05,
                                    height: MediaQuery.of(context).size.height * 0.02,
                                    child: RawMaterialButton(
                                        onPressed: () {
                                          setState(() {
                                            widgetKeys.add(ExerciseStatKey(
                                                DateTime.now(), exerciseId, setnr));
                                            setnr++;
                                            shouldClearWidgetKeys = false;
                                          });
                                        },
                                        elevation: 2.0,
                                        fillColor: Colors.grey,
                                        shape: const BeveledRectangleBorder(),
                                        child: const Icon(
                                          Icons.add,
                                          size: 10.0,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.01, 0, 0, 0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.05,
                                    height: MediaQuery.of(context).size.height * 0.02,
                                    child: RawMaterialButton(
                                        onPressed: () {
                                          if (widgetKeys.isNotEmpty) {
                                            setState(() {
                                              widgetKeys.removeLast();
                                              setnr--;
                                              shouldClearWidgetKeys = false;
                                            });
                                          }
                                        },
                                        elevation: 2.0,
                                        fillColor: Colors.grey,
                                        shape: const BeveledRectangleBorder(),
                                        child: const Icon(
                                          Icons.remove,
                                          size: 10.0,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.15,
                                      0,
                                      MediaQuery.of(context).size.width * 0.05,
                                      0),
                                  child: const Text("Kilo"),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.05,
                                      0,
                                      MediaQuery.of(context).size.width * 0.05,
                                      0),
                                  child: const Text("Reps"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.18,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  itemCount: widgetKeys.length,
                                  itemBuilder: (context, index) {
                                    return AddSetWidget(
                                      customKey: widgetKeys[index],
                                      setnr: widgetKeys[index].stats.setnr,
                                      initialKilo: widget.workoutId != 0
                                          ? widgetKeys[index].stats.kilo
                                          : null,
                                      initialReps: widget.workoutId != 0
                                          ? widgetKeys[index].stats.reps
                                          : null,
                                    );
                          })),
                        ],
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(SelectedSecondaryColor)
                          ),
                          onPressed: () {
                            _handleNext();
                          },
                          child: Text(
                              'Next Exercise',
                              style: TextStyle(
                                color: SelectedHeadlineColor
                              ),
                          )),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
  );
}
