import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/presentation/views/settings/widgets/ThemeColor.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

const List<String> settingsList = ['Theme Selection'];
const List<Icon> iconList = [Icon(Icons.color_lens_outlined)];

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: (MediaQuery.of(context).size.height) * (0.6),
            width: (MediaQuery.of(context).size.width) * (0.9),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: settingsList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return ListTile(
                  leading: iconList[index],
                  title: Text(
                    settingsList[index],
                      style: TextStyle(
                        color: SelectedHeadlineColor,
                        fontWeight: FontWeight.bold
                      ),
                  ),
                  trailing: const Icon(Icons.navigate_next),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ThemeColorWidget()))
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
