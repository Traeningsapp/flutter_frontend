import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projekt_frontend/src/models/exerciseStats.dart';
import 'package:projekt_frontend/src/utils/constants.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

class AddSetWidget extends StatefulWidget {
  final int rowcount;
  final int exerciseId;
  final void Function(ExerciseStats exerciseStat) onSetDataChanged;


  const AddSetWidget({required this.rowcount, required this.exerciseId, required this.onSetDataChanged, super.key});

  @override
  State<AddSetWidget> createState() => _AddSetWidgetState();
}

class _AddSetWidgetState extends State<AddSetWidget> {
  late int setnr;
  int reps = 0;
  int kilo = 0;

  late ExerciseStats exerciseStat;

  final kiloController = TextEditingController();
  final repsController = TextEditingController();


  @override void initState() {
    super.initState();
    setnr = widget.rowcount;

    kiloController.addListener(_kiloControllerListener);
    repsController.addListener(_repsControllerListener);
  }

  void clearInputs() {
    kiloController.clear();
    repsController.clear();
  }

  @override void dispose() {
    kiloController.removeListener(_kiloControllerListener);
    repsController.removeListener(_repsControllerListener);
    kiloController.dispose();
    repsController.dispose();

    reps = 0;
    kilo = 0;

    super.dispose();
  }

  void _kiloControllerListener() {
    kilo = int.parse(kiloController.text);
    if(reps != 0)
    {
      createStatObject();
    }
  }

  void _repsControllerListener() {
    reps = int.parse(repsController.text);
    if(kilo != 0)
    {
      createStatObject();
    }
  }

  void createStatObject() {
    exerciseStat = ExerciseStats(
        userId: Global_userid,
        exerciseId: widget.exerciseId,
        createdDate: DateTime.now(),
        setnr: setnr,
        reps: reps!,
        kilo: kilo!);

    widget.onSetDataChanged(exerciseStat);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(0, 0.2, 0, 0.2),
            child: Text('Set $setnr')),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.17, 0.2, 0, 0.2),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.13,
            height: MediaQuery.of(context).size.height * 0.028,
            child: TextField(
              style: TextStyle(
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              controller: kiloController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3)
              ],
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, 0.2, 0, 0.2),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.13,
            height: MediaQuery.of(context).size.height * 0.028,
            child: TextField(
              style: TextStyle(
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              controller: repsController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3)
              ],
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}