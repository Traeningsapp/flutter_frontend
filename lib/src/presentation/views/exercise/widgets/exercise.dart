import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projekt_frontend/src/models/exercise.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';
import 'package:projekt_frontend/src/utils/constants.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

class ExerciseWidget extends StatefulWidget {
  final Exercise exercise;
  final Color themecolor;
  const ExerciseWidget({Key? key, required this.exercise, required this.themecolor}) : super(key: key);

  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  final DatabaseService _dbService = DatabaseService();
  late Future<bool?> isFavorite;
  late bool? favorite = false;
  late bool? isActive;

  late Exercise exercise;

  @override
  void initState() {
    super.initState();
    _initRetrieval();
  }

  @override
  dispose() {
    super.dispose();
  }

  Future<void> _initRetrieval() async {
    exercise = widget.exercise;
    isActive = exercise.active;
    favorite = await _dbService.getFavoriteExercise(Global_userid, exercise!.id);
  }


  void setOrDeleteFavorite() async {
    setState(() {
      if(favorite == false) {
        _dbService.setFavoriteExercise(Global_userid, exercise.id);
        favorite = true;
      } else {
        _dbService.deleteFavoriteExercise(Global_userid, exercise.id);
        favorite = false;
      }
    });
  }

  void deleteOrRestoreExercise() async {
    setState(() {
      exercise.active = !exercise.active;
      _dbService.setActiveValue(Global_userid, exercise.id, exercise.active);
    });
  }


  List<Widget> primaryActivationButton(Exercise exercise) {
    List<Widget> primaryList = [];
    if(exercise != null) {
      exercise.muscles?.forEach((muscle) {
        if(muscle?.isPrimary == true) {
          primaryList.add(SizedBox(
            height: MediaQuery.of(context).size.height * 0.038,
            width: MediaQuery.of(context).size.width * 0.24,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: ElevatedButton(
                  onPressed: ()=>(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade400,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                    padding: const EdgeInsets.only(left: 0, right: 0),
                  ),
                  child: Text(
                    muscle!.name,
                    style: const TextStyle(
                        color: activationColor,
                        fontSize: 12,
                    ),
                  )),
            ),
          ));
        }
      });
    }
    return primaryList;
  }

  List<Widget> secondaryActivationButtons(Exercise exercise) {
    List<Widget> buttonList = [];
    if(exercise != null) {
      exercise.muscles?.forEach((muscle) {
        if(muscle?.isPrimary != true) {
          buttonList.add(SizedBox(
            height: MediaQuery.of(context).size.height * 0.038,
            width: MediaQuery.of(context).size.width * 0.24,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: ElevatedButton(
                  onPressed: ()=>(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 116, 155, 194),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    padding: const EdgeInsets.only(left: 0, right: 0),
                  ),
                  child: Text(
                    muscle!.name,
                    style: const TextStyle(
                        color: activationColor,
                        fontSize: 12,
                    ),
                  )),
            ),
          ));
        }
      });
    }
    return buttonList;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
          title: exercise.name!),
      body: Container(
        color: MainColor,
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(top: 30.0),
              child: buildExercise(exercise),
            ),
      ),
    ));
  }

  Widget buildExercise(Exercise exercise) => SingleChildScrollView(
    child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/exerciseGifs/${exercise.id}.gif',
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        setOrDeleteFavorite();
                      },
                      icon: favorite == true ? const Icon(Icons.favorite, color: Colors.red) : const Icon(Icons.favorite_border, color: Colors.red,)
                  ),
                  if(Global_user_role == "Admin")
                    IconButton(
                        onPressed: () {
                          deleteOrRestoreExercise();
                        },
                        icon: exercise.active == true ? Icon(Icons.delete, color: Colors.red.shade300) : Icon(Icons.restore_from_trash, color: Colors.green.shade300,)
                    ),
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
                          color: HeadlineColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          ),
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              exercise.description,
                              style: const TextStyle(
                                color: TextColor
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
                          color: HeadlineColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              exercise.benefits,
                              style: const TextStyle(
                                color: TextColor
                            ),
                          )
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,30,10,10),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Text('Primary Activation',
                          style: TextStyle(
                            color: HeadlineColor,
                            fontSize: 14
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: primaryActivationButton(exercise),
                    )
                  ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Text('Secondary Activation',
                          style: TextStyle(
                            color: HeadlineColor,
                            fontSize: 14
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: secondaryActivationButtons(exercise),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
  );
}



