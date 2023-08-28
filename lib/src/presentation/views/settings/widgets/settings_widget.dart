import 'package:flutter/material.dart';

const List<String> feedbackList = ['Report a Bug', 'Send Feedback', 'About','Get support'];
const List<Icon> iconList = [Icon(Icons.bug_report), Icon(Icons.mail), Icon(Icons.question_mark), Icon(Icons.contact_support)];

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
              itemCount: feedbackList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return ListTile(
                  leading: iconList[index],
                  title: Text(feedbackList[index]),
                  trailing: const Icon(Icons.navigate_next),
                  onTap: () => {},
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
