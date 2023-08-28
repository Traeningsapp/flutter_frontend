import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/presentation/views/profile/profilePage.dart';

const List<String> accountList = ['My account settings','Initial questions','Delete account?'];
const List<Icon> iconList = [Icon(Icons.person), Icon(Icons.question_mark), Icon(Icons.delete_forever)];

class ProfileAccountWidget extends StatefulWidget {
  const ProfileAccountWidget({Key? key}) : super(key: key);

  @override
  State<ProfileAccountWidget> createState() => _ProfileAccountWidgetState();
}

class _ProfileAccountWidgetState extends State<ProfileAccountWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.center, padding: const EdgeInsets.all(10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(height: 10),
            Text(
              'Account settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Container(
            alignment: Alignment.center, padding: const EdgeInsets.all(10)),
        Row(
          children: const [
            Expanded(
                child: Divider(
                  color: Colors.orange,
                  height: 2,
                  indent: 1,
                  thickness: 1,
                ))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: (MediaQuery.of(context).size.height) * (0.6),
                width: (MediaQuery.of(context).size.width) * (0.9),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: accountList.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return ListTile(
                      leading: iconList[index],
                      title: Text(accountList[index]),
                      trailing: const Icon(Icons.navigate_next),
                      onTap: () => {
                        if(index == 0) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()))
                        } else if(index == 1) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()))
                        } else if(index == 2) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()))
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
