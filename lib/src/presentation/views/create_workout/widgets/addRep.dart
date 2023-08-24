import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projekt_frontend/src/models/exerciseStats.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

class AddSetWidget extends StatefulWidget {
  final int rowcount;
  final int exerciseId;
  final ValueChanged<ExerciseStats> onChanged;
  final void Function(ExerciseStats exerciseStat) onSetDataChanged;

  const AddSetWidget({required this.rowcount, required this.exerciseId, required this.onSetDataChanged, required this.onChanged, super.key});

  @override
  State<AddSetWidget> createState() => _AddSetWidgetState();
}

class _AddSetWidgetState extends State<AddSetWidget> {
  late int setnr;
  late int? reps;
  late int? kilo;

  late ExerciseStats exerciseStat;

  final kiloController = TextEditingController();
  final repsController = TextEditingController();


  @override void initState() {
    super.initState();
    setnr = widget.rowcount;

    kiloController.addListener(_kiloControllerListener);
    repsController.addListener(_repsControllerListener);
  }

  @override void dispose() {
    kiloController.removeListener(_kiloControllerListener);
    repsController.removeListener(_repsControllerListener);
    kiloController.dispose();
    repsController.dispose();

    super.dispose();
  }

  void _kiloControllerListener() {
    kilo = int.parse(kiloController.text);
    if(reps != null)
    {
      createStatObject();
    }
  }

  void _repsControllerListener() {
    reps = int.parse(repsController.text);
    if(kilo != null)
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
        reps: reps,
        kilo: kilo);

    widget.onSetDataChanged(exerciseStat);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.04, 0, 0, 0),
            child: Text('Set $setnr')),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.17, 0, 0, 0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            height: MediaQuery.of(context).size.height * 0.03,
            child: TextFormField(
              controller: kiloController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.07, 0, 0, 0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            height: MediaQuery.of(context).size.height * 0.03,
            child: TextFormField(
              controller: repsController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}