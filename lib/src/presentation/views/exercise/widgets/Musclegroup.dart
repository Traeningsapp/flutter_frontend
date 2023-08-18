import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/presentation/views/exercise/widgets/Musclesubgroup.dart';
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
      // backgroundColor: backgroundColorForSubpages,
      body: ListView(
          padding: const EdgeInsets.all(5),
          children: <Widget>[
            buildCardWidget('Shoulders', 'Front-, middle- & back deltoids', fontsizeForTitles, 12, 'assets/images/musclegroups/shoulders.png', 'shoulders'),
            buildCardWidget('Back', 'Traps, laterals, teres major and lower back', fontsizeForTitles, 12, 'assets/images/musclegroups/back.png', 'back'),
            buildCardWidget('Chest', 'Inner-, middle-, lower- & upper chest', fontsizeForTitles, 12, 'assets/images/musclegroups/chest.png', 'chest'),
            buildCardWidget('Triceps', 'Lateral-, long- & medial head', fontsizeForTitles, 12, 'assets/images/musclegroups/triceps.png', 'triceps'),
            buildCardWidget('Biceps', 'Long- & short head', fontsizeForTitles, 12, 'assets/images/musclegroups/biceps.png', 'biceps'),
            buildCardWidget('Forearms', 'Forearm flexor & extensor', fontsizeForTitles, 12, 'assets/images/musclegroups/forearms.png', 'forearms'),
            buildCardWidget('Quads & Hamstrings', 'Front- & back thighs', fontsizeForTitles, 12, 'assets/images/musclegroups/quads.png', 'thighs'),
            buildCardWidget('Glutes', 'Upper-, & lower butt', fontsizeForTitles, 12, 'assets/images/musclegroups/glutes.png', 'glutes'),
            buildCardWidget('Calves', 'Lateral- & medial head', fontsizeForTitles, 12, 'assets/images/musclegroups/calves.png', 'calves'),
            buildCardWidget('Abs', 'Internal- & external core', fontsizeForTitles, 12, 'assets/images/musclegroups/abs.png', 'abs'),
          ]
      ),
    );
  }


  Widget buildCardWidget(String title, String subtitle, double titleFontsize, double subtitleFontsize, String assetLocation, String onTapRoute) {
    return Card(
      elevation: 4,
      child: ListTile(
        onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => MuscleSubGroupPage(musclegroup: onTapRoute))); },
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

