import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/presentation/views/exercise/widgets/Muscle.dart';
import 'package:projekt_frontend/src/utils/constants.dart';

class BuildGroupCard extends StatelessWidget {
  const BuildGroupCard({Key? key, required this.title, required this.subtitle, required this.assetLocal, required this.onTapRoute}) : super(key: key);

  final String title;
  final String subtitle;
  final String assetLocal;
  final int onTapRoute;


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => MusclePage(musclegroupId: onTapRoute))); },
        tileColor: Colors.white,
        contentPadding: const EdgeInsets.only(left: 15, top: 3, bottom: 3),
        leading: ConstrainedBox(
          constraints: const BoxConstraints(
          ),
          child: Image.asset(assetLocal, fit: BoxFit.cover),
        ),
        trailing: const Icon(Icons.arrow_right,),
        title: Text(title,
          style: const TextStyle(
              fontSize: fontsizeForTitles
          ),
        ),
        subtitle: Text(subtitle,
          style: const TextStyle(
              fontSize: fontsizeForSubTitles
          ),
        ),
      ),
    );
  }
}

