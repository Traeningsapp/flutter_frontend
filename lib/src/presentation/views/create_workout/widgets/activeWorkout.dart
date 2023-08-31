import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projekt_frontend/src/models/ExerciseStatKey.dart';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/models/howTo.dart';
import 'package:projekt_frontend/src/presentation/views/create_workout/widgets/addRep.dart';
import 'package:projekt_frontend/src/presentation/views/create_workout/widgets/finishedWorkout.dart';
import 'package:projekt_frontend/src/presentation/views/exercise/widgets/exerciseHowTo.dart';
import 'package:projekt_frontend/src/presentation/views/stats/widgets/specificExerciseStat.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

class ActiveWorkoutWidget extends StatefulWidget {
  final List<Exercise>? activeWorkout;
  final String workoutType;
  final Color themecolor;
  final int? workoutId;
  const ActiveWorkoutWidget({Key? key, required this.activeWorkout, required this.workoutType, required this.themecolor, required this.workoutId})
      : super(key: key);

  @override
  State<ActiveWorkoutWidget> createState() => _ActiveWorkoutWidget();
}

class _ActiveWorkoutWidget extends State<ActiveWorkoutWidget> {
  final List<ExerciseStatKey> widgetKeys = [];
  late List<Exercise>? currentWorkout;  //List of exercises to be shown
  late List<Widget> widgetExerciseList; //List of widgets which takes each of the exercises in the above list
  int counter = 0;                      //counter when running through exercise widgets.
  late int workoutlength;               //amount of exercises in list
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
    if(shouldClearWidgetKeys) {
      widgetKeys.clear();
      if(widget.workoutId != 0) {
        workout.forEach((exercise) {
          if(exercise.exerciseStats != null || exercise.exerciseStats!.isNotEmpty) {
            exercise.exerciseStats!.forEach((stats) {
              if(stats.exerciseId == exerciseId) {
                widgetKeys.add(ExerciseStatKey.withRepsAndKilo(
                    DateTime.now(), exercise.id, stats.reps, stats.kilo,
                    stats.setnr!));
                setnr = stats.setnr! + 1;
                print('setnr ++ fra clearwidgetkeysloop');
              }
            });
          }
        });
        firstWidgetCall = false;
      }
    }
    List<Widget> list = <Widget>[];
    Widget _buildwidget;
    if(firstWidgetCall) {
      for(int i = 1; i <= setantal; i++){
        widgetKeys.add(ExerciseStatKey(DateTime.now(), exerciseId, i));
        setnr++;
        print('setnr ++ fra firstwidgetcall');
      }
      firstWidgetCall = false;
      shouldClearWidgetKeys = false;
    }

    for (var i = 0; i < workout.length; i++) {
      _buildwidget = buildWorkoutWidget(workout[i]);
      list.add(_buildwidget);
    }
    print(setnr);
    return list;
  }

  void _handleNext() {
    for (var key in widgetKeys) {
      if(key.stats.reps != null || key.stats.kilo != null) {
        statsList.add(key.stats);
      } else {
        Fluttertoast.showToast(msg: 'Udfyld alle felter eller fjern set', gravity : ToastGravity.CENTER);
        return;
      }
      key.reset();
    }
    setState(() {
      widgetKeys.clear();
      firstWidgetCall = true;
      setnr = 1;
      counter++;
      print('setnr sat = 1');
      shouldClearWidgetKeys = true;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBarWidget(title: 'Active Workout', themecolor: widget.themecolor),
        body: FutureBuilder<List<Exercise>?>(
            future: setList(),
            builder: (context, AsyncSnapshot<List<Exercise>?> snapshot) {
              if (snapshot.hasError) {
                return Text('something went wrong! ${snapshot.error}');
              } else if (snapshot.hasData) {
                final specificWorkout = snapshot.data!;
                if (counter >= specificWorkout.length) {
                  return FinishedWorkoutWidget(generatedWorkout: currentWorkout, workoutType: widget.workoutType, sentExerciseStats: statsList);
                } else {
                  exerciseId = specificWorkout[counter].id;
                  widgetExerciseList = generateExerciseWidgets(specificWorkout);
                  return widgetExerciseList[counter];
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            })
    );
  } // Scaffold

  Widget buildWorkoutWidget(Exercise generatedWorkout) => Column(
    children: [
      Expanded(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.5,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    generatedWorkout.name),
                IconButton(
                  alignment: Alignment.centerRight,
                  icon: const Icon(Icons.info_outline),
                  onPressed: () => showDialog(
                    context: context, builder: (BuildContext context) => ExerciseHowToOverlay(
                      exerciseId: generatedWorkout.id,
                      exerciseName: generatedWorkout.name)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                const SizedBox(
                  width: 90,
                  child: Text('Benefits :',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(generatedWorkout.benefits,
                    overflow: TextOverflow.clip,
                  ),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            Container(
                alignment: Alignment.center, padding: const EdgeInsets.all(15)),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                const SizedBox(
                  width: 90,
                  child: Text('Description :',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                    child: Text(
                      'Description :${generatedWorkout.description}',
                      overflow: TextOverflow.clip,
                    )
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            Container(
                alignment: Alignment.center, padding: const EdgeInsets.all(20)),
            const Text('Primary Activation : ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('${generatedWorkout.muscleActivation!}'),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.24,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/images/nocontent.gif')
                  ],
                )
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.25, 0, 0, 0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                      height: MediaQuery.of(context).size.height * 0.025,
                      child: RawMaterialButton(
                          onPressed: () {
                            setState(() {
                              widgetKeys.add(ExerciseStatKey(DateTime.now(), exerciseId, setnr));
                              setnr++;
                              shouldClearWidgetKeys = false;
                              print(setnr);
                            });
                          },
                          elevation: 2.0,
                          fillColor: Colors.grey,
                          child: Icon(
                            Icons.add,
                            size: 10.0,
                          ),
                          shape: BeveledRectangleBorder()
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01,0, 0, 0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                      height: MediaQuery.of(context).size.height * 0.025,
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
                          child: Icon(
                            Icons.remove,
                            size: 10.0,
                          ),
                          shape: BeveledRectangleBorder()
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.15, 0, MediaQuery.of(context).size.width * 0.05, 0),
                    child: Text("Kilo"),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, 0, MediaQuery.of(context).size.width * 0.05, 0),
                    child: Text("Reps"),
                  ),
                  IconButton(
                    alignment: Alignment.centerRight,
                    icon: const Icon(Icons.list_alt),
                    onPressed: () => showDialog(
                        context: context,
                        builder: ((BuildContext context) => ExerciseStatsOverlay(
                            exerciseId: generatedWorkout.id,
                            userId: Global_userid))
                    )
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: widgetKeys.length,
                  itemBuilder: (context, index) {
                    return AddSetWidget(
                      customKey: widgetKeys[index],
                      setnr: widgetKeys[index].stats.setnr,
                      initialKilo: widget.workoutId != 0 ? widgetKeys[index].stats.kilo : null,
                      initialReps: widget.workoutId != 0 ? widgetKeys[index].stats.reps : null,
                    );
                  }
              )
            ),
            Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      onPressed: () {
                        _handleNext();
                      },
                      child: const Text('Next Exercise')),
                )
            )
          ],
        ),
      )
    ],
  );
}