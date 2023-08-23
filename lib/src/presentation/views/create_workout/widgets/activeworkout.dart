import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/models/workout.dart';
import 'package:projekt_frontend/src/presentation/views/create_workout/widgets/addRep.dart';
import 'package:projekt_frontend/src/presentation/views/create_workout/widgets/finishedworkout.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar_widget.dart';

class ActiveWorkoutWidget extends StatefulWidget {
  final List<Exercise>? activeWorkout;
  final String workoutType;
  const ActiveWorkoutWidget({Key? key, required this.activeWorkout, required this.workoutType})
      : super(key: key);

  @override
  State<ActiveWorkoutWidget> createState() => _ActiveWorkoutWidget();
}

class _ActiveWorkoutWidget extends State<ActiveWorkoutWidget> {
  late List<Exercise>? currentWorkout;
  late List<Widget> widgetExerciseList;
  List<String> exerciseIds = <String>[];

  int counter = 0;
  late int workoutlength;

  @override
  void initState() {
    super.initState();
  }

  Future<List<Exercise>?> setList() async {
    currentWorkout = widget.activeWorkout;
    return currentWorkout;
  }

  /*
  Future<void> setExerciseIds(List<Exercise> Workout) async {
    for (var i = 0; i < Workout.length; i++) {
      debugPrint('added ${Workout[i].id!}');
      exerciseIds.add(Workout[i].id!);
    }
  }
   */

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  //setExerciseIds(specificWorkout);
                  return FinishedWorkoutWidget(generatedWorkout : currentWorkout, workoutType: widget.workoutType, sentExerciseIds: exerciseIds);
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
            Container(
                alignment: Alignment.center, padding: const EdgeInsets.all(30)),
            Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: 300,
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/images/nocontent.gif')
                  ],
                )
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.3, 0, MediaQuery.of(context).size.width * 0.05, 0),
                    child: Text("Kilo"),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, 0, MediaQuery.of(context).size.width * 0.05, 0),
                    child: Text("Reps"),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, 0, MediaQuery.of(context).size.width * 0.1, 0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.06,
                      height: MediaQuery.of(context).size.height * 0.03,
                      child: RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: Colors.grey,
                        child: Icon(
                          Icons.add,
                          size: 20.0,
                        ),
                        shape: CircleBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
            Row(
              children: [
                AddSetWidget(ctn: 1),
                Padding(
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.04, 0, 0, 0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: MediaQuery.of(context).size.height * 0.02,


                    child: RawMaterialButton(
                      onPressed: () {},
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
              ],
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