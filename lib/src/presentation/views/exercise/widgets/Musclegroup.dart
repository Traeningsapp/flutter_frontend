import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/musclegroup.dart';
import 'package:projekt_frontend/src/presentation/views/exercise/widgets/Muscle.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';
import 'package:projekt_frontend/src/utils/constants.dart';

class MuscleGroupPage extends StatefulWidget {
  const MuscleGroupPage({super.key});

  @override
  State<MuscleGroupPage> createState() => _MuscleGroupPageState();
}

class _MuscleGroupPageState extends State<MuscleGroupPage> {
  final DatabaseService _dbService = DatabaseService();
  late Future<List<MuscleGroup>?> muscleGroupList;

  Future<void> _initRetrieval() async {
    muscleGroupList = _dbService.getMuscleGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          padding: const EdgeInsets.fromLTRB(5, 110, 5, 0),
          children: <Widget>[
            //BuildGroupCard(title: muscleGroupList., subtitle: subtitle, assetLocal: assetLocal, onTapRoute: onTapRoute)
            buildCardWidget('Shoulders', 'Front-, middle- & back deltoids', fontsizeForTitles, fontsizeForSubTitles, 'assets/musclegroups/shoulders.png', 2),
            buildCardWidget('Back', 'Traps, laterals, teres major and lower back', fontsizeForTitles, fontsizeForSubTitles, 'assets/musclegroups/back.png', 3),
            buildCardWidget('Chest', 'Inner-, middle-, lower- & upper chest', fontsizeForTitles, fontsizeForSubTitles, 'assets/musclegroups/chest.png', 1),
            buildCardWidget('Arms', 'Biceps, triceps and forearm', fontsizeForTitles, fontsizeForSubTitles, 'assets/musclegroups/triceps.png', 4),
            buildCardWidget('Legs', 'Quads, glutes, hamstrings and calves', fontsizeForTitles, fontsizeForSubTitles, 'assets/musclegroups/quads.png', 6),
            buildCardWidget('Abs', 'Internal- & external core', fontsizeForTitles, fontsizeForSubTitles, 'assets/musclegroups/abs.png', 5),
          ]
      ),
    );
  }

  Widget buildCardWidget(String title, String subtitle, double titleFontsize, double subtitleFontsize, String assetLocation, int onTapRoute) {
    return Card(
      elevation: 4,
      child: ListTile(
        onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => MusclePage(musclegroupId: onTapRoute))); },
        tileColor: Colors.white,
        contentPadding: const EdgeInsets.only(left: 15, top: 3, bottom: 3),
        leading: ConstrainedBox(
          constraints: const BoxConstraints(
          ),
          child: Image.asset(assetLocation, fit: BoxFit.cover),
        ),
        trailing: const Icon(Icons.arrow_right,),
        title: Text(title,
          style: TextStyle(
              fontSize: titleFontsize
          ),
        ),
        subtitle: Text(subtitle,
          style: TextStyle(
              fontSize: subtitleFontsize
          ),
        ),
      ),
    );
  }
}


