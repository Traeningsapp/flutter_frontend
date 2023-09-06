import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/muscleGroup.dart';
import 'package:projekt_frontend/src/presentation/views/exercise/widgets/muscle.dart';
import 'package:projekt_frontend/src/services/DatabaseService.dart';
import 'package:projekt_frontend/src/utils/constants.dart';

class MuscleGroupPage extends StatefulWidget {
  const MuscleGroupPage({super.key});

  @override
  State<MuscleGroupPage> createState() => _MuscleGroupPageState();
}

class _MuscleGroupPageState extends State<MuscleGroupPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor,
      body: ListView(
          padding: const EdgeInsets.fromLTRB(5, 110, 5, 0),
          children: <Widget>[
            buildCardWidget('Arms & Shoulders', 'Front-, middle- & back deltoids. Biceps, triceps and forearm', fontsizeForTitles, fontsizeForSubTitles, 'assets/musclegroups/2.png', 2),
            buildCardWidget('Back', 'Traps, laterals, teres major and lower back', fontsizeForTitles, fontsizeForSubTitles, 'assets/musclegroups/3.png', 3),
            buildCardWidget('Chest', 'Inner-, middle-, lower- & upper chest', fontsizeForTitles, fontsizeForSubTitles, 'assets/musclegroups/1.png', 1),
            buildCardWidget('Legs', 'Quads, glutes, hamstrings and calves', fontsizeForTitles, fontsizeForSubTitles, 'assets/musclegroups/5.png', 5),
            buildCardWidget('Abs', 'Internal- & external core', fontsizeForTitles, fontsizeForSubTitles, 'assets/musclegroups/4.png', 4),
          ]
      ),
    );
  }

  Widget buildCardWidget(String title, String subtitle, double titleFontsize, double subtitleFontsize, String assetLocation, int onTapRoute) {
    return Card(
      elevation: 4,
      child: ListTile(
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: TertiaryColor, width: 2),
            borderRadius: BorderRadius.circular(5)
        ),
        onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => MusclePage(musclegroupId: onTapRoute))); },
        tileColor: SecondaryColor,
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
