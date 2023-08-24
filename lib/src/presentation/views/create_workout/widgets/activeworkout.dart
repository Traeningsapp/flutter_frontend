import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/models/exerciseStats.dart';
import 'package:projekt_frontend/src/presentation/views/create_workout/widgets/addRep.dart';
import 'package:projekt_frontend/src/presentation/views/create_workout/widgets/finishedworkout.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar_widget.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

class ActiveWorkoutWidget extends StatefulWidget {
  final List<Exercise>? activeWorkout;
  final String workoutType;
  const ActiveWorkoutWidget({Key? key, required this.activeWorkout, required this.workoutType})
      : super(key: key);

  @override
  State<ActiveWorkoutWidget> createState() => _ActiveWorkoutWidget();
}

class _ActiveWorkoutWidget extends State<ActiveWorkoutWidget> {
  late List<Exercise>? currentWorkout;  //List of exercises to be shown
  late List<Widget> widgetExerciseList; //List of widgets which takes each of the exercises in the above list
  int counter = 0;                      //counter when running through exercise widgets.
  late int workoutlength;               //amount of exercises in list
  int setnr = 3;

  late ExerciseStats exerciseStat;
  late List<ExerciseStats> exerciseStatsList;

  @override
  void initState() {
    super.initState();
  }

  Future<List<Exercise>?> setList() async {
    currentWorkout = widget.activeWorkout;
    return currentWorkout;
  }

  List<Widget> generateExerciseWidgets(List<Exercise> workout) {
    List<Widget> list = <Widget>[];
    Widget _buildwidget;

    workoutlength = workout.length;

    for (var i = 0; i < workout.length; i++) {
      _buildwidget = buildWorkoutWidget(workout[i]);
      list.add(_buildwidget);
    }
    return list;
  }


  List<Widget> createSetList(int exerciseId) {
    List<Widget> exerciseStatsList = <Widget>[];
    Widget _buildwidget;

    for(int i = 1; i <= setnr; i++ ) {
      _buildwidget = AddSetWidget(
          rowcount: i,
          exerciseId: exerciseId,
          onSetDataChanged: (exerciseStat) {
            recordExerciseStats(exerciseStat);
          }
      );
      exerciseStatsList.add(_buildwidget);
    }
    return exerciseStatsList;
  }

  void AddSetRow() {
    setState(() {
        setnr = setnr + 1;
    });
  }
  void RemoveSetRow() {
    setState(() {
      setnr = setnr - 1;
    });
  }


  void recordExerciseStats(ExerciseStats stat) async {
    if(exerciseStatsList.)
      bool containsExercise = exercises.any((exercise) => exercise.id == targetId);

    exerciseStatsList.add(exerciseStat);

    print(exerciseStatsList);
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBarWidget(title: 'Active Workout', themecolor: Colors.blue),
        body: FutureBuilder<List<Exercise>?>(
            future: setList(),
            builder: (context, AsyncSnapshot<List<Exercise>?> snapshot) {
              if (snapshot.hasError) {
                return Text('something went wrong! ${snapshot.error}');
              } else if (snapshot.hasData) {
                final specificWorkout = snapshot.data!;
                widgetExerciseList = generateExerciseWidgets(specificWorkout);
                if(counter >= workoutlength) {
                  return FinishedWorkoutWidget(generatedWorkout : currentWorkout, workoutType: widget.workoutType /*, sentExerciseStats: exerciseStatsList */);
                } else {
                  return widgetExerciseList[counter];
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
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
                    onPressed: () => (),          // Åben info vindue.   {Navigator.push(context, MaterialPageRoute(builder: (context) => const ExerciseHowToWidget()));
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
                            AddSetRow();
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
                            RemoveSetRow();
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
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                  children: createSetList(generatedWorkout.id)
              ),
            ),
            Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      onPressed: () {
                        counter ++;
                        setState(() {
                        });
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

