import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projekt_frontend/src/models/ExerciseStatKey.dart';
import 'package:projekt_frontend/src/presentation/views/workout/interfaces/AddSetWidgetInterface.dart';

class AddSetWidget extends StatefulWidget {
  final ExerciseStatKey customKey;
  final int? setnr;
  final int? initialKilo;
  final int? initialReps;
  AddSetWidget({required this.customKey, required this.setnr, this.initialKilo, this.initialReps}) : super(key: customKey.key);

  @override
  State<AddSetWidget> createState() => _AddSetWidgetState();
}

class _AddSetWidgetState extends State<AddSetWidget> implements IAddSetWidget {
  final kiloController = TextEditingController();
  final repsController = TextEditingController();
  late int? setnr;

  @override
  void resetFields() {
    kiloController.clear();
    repsController.clear();
  }

  @override void initState() {
    super.initState();
    setnr = widget.setnr;
    if(widget.initialKilo != null) kiloController.text = widget.initialKilo.toString();
    if(widget.initialReps != null) repsController.text = widget.initialReps.toString();
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
              style: const TextStyle(
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              controller: kiloController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3)
              ],
              onChanged: (value) {
                widget.customKey.stats.kilo = int.tryParse(value) ?? 0;
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
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
              style: const TextStyle(
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              controller: repsController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3)
              ],
              onChanged: (value) {
                widget.customKey.stats.reps = int.tryParse(value) ?? 0;
              },
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

