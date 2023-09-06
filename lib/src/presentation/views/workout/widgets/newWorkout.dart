import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/models/workout.dart';
import 'package:projekt_frontend/src/presentation/views/workout/widgets/activeWorkout.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';
import 'package:projekt_frontend/src/utils/constants.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

const List<String> splitList = <String>['Push', 'Pull', 'Legs'];
const List<String> additionalFocusList = <String>['No', 'Chest', 'Shoulders', 'Triceps'];
const List<String> YesNo = <String>['No','Yes'];

class NewWorkoutWidget extends StatefulWidget {
  NewWorkoutWidget({Key? key}) : super(key: key);

  @override
  State<NewWorkoutWidget> createState() => _NewWorkoutWidgetState();
}

class _NewWorkoutWidgetState extends State<NewWorkoutWidget> {
  final DatabaseService _dbService = DatabaseService();

  String splitdropdownValue = splitList.first;
  String additionalfocusdropdownValue = additionalFocusList.first;
  String absdropdownValue = YesNo.first;
  String favoritedropdownValue = YesNo.first;
  String equipmentdropdownValue = YesNo.first;

  late bool abs = false;
  late bool favorite = false;
  late int split_id;

  Future<void> generateWorkout() async {
    if      (splitdropdownValue == 'Push') {split_id = 1;}
    else if (splitdropdownValue == 'Pull') {split_id = 2;}
    else if (splitdropdownValue == 'Legs') {split_id = 3;}

    Workout? generatedWorkout = await _dbService.getNewWorkout(split_id, Global_userid, abs, favorite);

    List<Exercise>? exerciseList;
    if (generatedWorkout != null) {
      List<Exercise>? queue = generatedWorkout.exercises;
      exerciseList = queue!.toList();
    }
    if (exerciseList != null) {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ActiveWorkoutWidget(
            activeWorkout: exerciseList,
            workoutType: splitdropdownValue,
            workoutId: 0,
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30,30,30,30),
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: const Text(
                  'Before a workout can be generated for you, you will need to select some values',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: HeadlineColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Please choose split type',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: HeadlineColor,
                      fontWeight: FontWeight.bold,
                    ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  alignment: Alignment.center,
                  child: DropdownButton(
                      dropdownColor: SecondaryColor,
                      alignment: Alignment.center,
                      value: splitdropdownValue,
                      iconSize: 16,
                      isExpanded: true,
                      iconEnabledColor: SecondaryColor,
                      style: const TextStyle(
                        color: TextColor,
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
                    'Add Abs exercises',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: HeadlineColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  alignment: Alignment.center,
                  child: DropdownButton(
                      dropdownColor: SecondaryColor,
                      value: absdropdownValue,
                      iconSize: 16,
                      iconEnabledColor: SecondaryColor,
                      isExpanded: true,
                      style: const TextStyle(
                          color: TextColor,
                      ),
                      items: YesNo
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
                          } else {
                            abs = false;
                          }
                        });
                      }),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Prioritize favorites',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: HeadlineColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  alignment: Alignment.center,
                  child: DropdownButton(
                      dropdownColor: SecondaryColor,
                      alignment: Alignment.center,
                      value: favoritedropdownValue,
                      iconSize: 16,
                      isExpanded: true,
                      iconEnabledColor: SecondaryColor,
                      style: const TextStyle(
                        color: TextColor,
                      ),
                      items: YesNo
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          // This is called when the user selects an item.
                          favoritedropdownValue = value!;
                          if (favoritedropdownValue == 'Yes') {
                            favorite = true;
                          } else {
                            favorite = false;
                          }
                        });
                      }),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Access to equipment',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: HeadlineColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  alignment: Alignment.center,
                  child: DropdownButton(
                      dropdownColor: SecondaryColor,
                      alignment: Alignment.center,
                      value: equipmentdropdownValue,
                      iconSize: 16,
                      isExpanded: true,
                      iconEnabledColor: SecondaryColor,
                      style: const TextStyle(
                        color: TextColor,
                      ),
                      items: YesNo
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          // This is called when the user selects an item.
                          equipmentdropdownValue = value!;
                        });
                      }),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Apply additional focus',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: HeadlineColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  alignment: Alignment.center,
                  child: DropdownButton(
                      dropdownColor: SecondaryColor,
                      alignment: Alignment.center,
                      value: additionalfocusdropdownValue,
                      iconSize: 16,
                      iconEnabledColor: SecondaryColor,
                      isExpanded: true,
                      style: const TextStyle(
                          color: TextColor,
                      ),
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
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(SecondaryColor),
                        ),
                        child: const Text(
                            textAlign: TextAlign.center,
                            'Start Worktout',
                            style: TextStyle(
                              color: HeadlineColor
                            ),
                        ),
                        onPressed: () => generateWorkout(),
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