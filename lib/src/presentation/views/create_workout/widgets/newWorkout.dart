import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/models/workout.dart';
import 'package:projekt_frontend/src/presentation/views/create_workout/widgets/activeWorkout.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

const List<String> splitList = <String>['Push', 'Pull', 'Legs'];
const List<String> additionalFocusList = <String>['No', 'Chest', 'Shoulders', 'Triceps'];
const List<String> absList = <String>['No', 'Yes'];
const List<String> addCompoundExercise = <String>['Yes', 'No'];

class NewWorkoutWidget extends StatefulWidget {
  NewWorkoutWidget({Key? key}) : super(key: key);

  @override
  State<NewWorkoutWidget> createState() => _NewWorkoutWidgetState();
}

class _NewWorkoutWidgetState extends State<NewWorkoutWidget> {
  final DatabaseService _dbService = DatabaseService();

  String splitdropdownValue = splitList.first;
  String additionalfocusdropdownValue = additionalFocusList.first;
  String absdropdownValue = absList.first;
  bool abs = false;
  late int split_id;


  Future<Workout?> getWorkout(int split_id, String userid) async {
    return _dbService.getNewWorkout(split_id, userid);
  }

  Future<void> GenerateWorkout() async {
    if(splitdropdownValue == 'Push') {
      split_id = 1;
    } else if (splitdropdownValue == 'Pull') {
      split_id = 2;
    } else {
      split_id = 3;
    }

    List<Exercise>? exerciseList;
    Workout? generatedWorkout = await getWorkout(split_id, Global_userid);

    if (generatedWorkout != null) {
      List<Exercise>? queue = generatedWorkout.exercises;
      exerciseList = queue!.toList();
    }

    if (exerciseList != null) {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ActiveWorkoutWidget(
            activeWorkout: exerciseList,
            workoutType: splitdropdownValue,
            themecolor: Colors.blue,
            workoutId: 0,
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: const Text(
                'Before a workout can be generated for you, you will need to select some values',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    'Please choose split type :'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  alignment: Alignment.center,
                  child: DropdownButton(
                      alignment: Alignment.center,
                      value: splitdropdownValue,
                      iconSize: 16,
                      isExpanded: true,
                      iconEnabledColor: Colors.blue,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      items: splitList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          // This is called when the user selects an item.
                          splitdropdownValue = value!;
                        });
                      }),
                ),
              ],
            ),
            //const Padding(padding: EdgeInsets.fromLTRB(0, 25, 0, 0)),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    'Add Abs exercises:'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  alignment: Alignment.center,
                  child: DropdownButton(
                      value: absdropdownValue,
                      iconSize: 16,
                      iconEnabledColor: Colors.blue,
                      isExpanded: true,
                      style: const TextStyle(color: Colors.black),
                      items: absList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          // This is called when the user selects an item.
                          absdropdownValue = value!;
                          if (absdropdownValue == 'Yes') {
                            abs = true;
                          }
                        });
                      }),
                ),
              ],
            ),
            //const Padding(padding: EdgeInsets.fromLTRB(0, 25, 0, 0)),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    'Apply additional focus : '),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  alignment: Alignment.center,
                  child: DropdownButton(
                      alignment: Alignment.center,
                      value: additionalfocusdropdownValue,
                      iconSize: 16,
                      iconEnabledColor: Colors.blue,
                      isExpanded: true,
                      style: const TextStyle(color: Colors.black),
                      items: additionalFocusList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          // This is called when the user selects an item.
                          additionalfocusdropdownValue = value!;
                        });
                      }),
                ),
              ],
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        child: const Text(
                            textAlign: TextAlign.center,
                            'Start Worktout'),
                        onPressed: () => GenerateWorkout(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ); // Scaffold
  }
}