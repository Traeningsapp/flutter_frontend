import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projekt_frontend/src/models/ExerciseStatKey.dart';
import 'package:projekt_frontend/src/models/exerciseStats.dart';
import 'package:projekt_frontend/src/presentation/views/create_workout/interfaces/AddSetWidgetInterface.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

class AddSetWidget extends StatefulWidget {
  final ExerciseStatKey customKey;
  final int setnr;
  // final ValueChanged<ExerciseStats> onChanged;
  AddSetWidget({required this.customKey, required this.setnr}) : super(key: customKey.key);

  //const AddSetWidget({required this.rowcount, required this.exerciseId, required this.onSetDataChanged, required this.onChanged, super.key});

  @override
  State<AddSetWidget> createState() => _AddSetWidgetState();
}

class _AddSetWidgetState extends State<AddSetWidget> implements IAddSetWidget {
  final kiloController = TextEditingController();
  final repsController = TextEditingController();
  late int setnr;

  void resetFields() {
    kiloController.clear();
    repsController.clear();
  }

  @override void initState() {
    super.initState();
    setnr = widget.setnr;
  }

  @override
  void dispose() {
    kiloController.dispose();
    repsController.dispose();
    super.dispose();
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
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                widget.customKey.stats.kilo = int.tryParse(value) ?? 0;
              },
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
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                widget.customKey.stats.reps = int.tryParse(value) ?? 0;
              },
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