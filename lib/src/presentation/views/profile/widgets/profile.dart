import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projekt_frontend/src/presentation/views/profile/favoriteExercises.dart';
import 'package:projekt_frontend/src/presentation/views/profile/profileAccountPage.dart';
import 'package:projekt_frontend/src/presentation/views/profile/savedWorkoutsPage.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

const List<String> profileList = ['Account','Saved workouts','Favorite Exercises'];
const List<Icon> iconList = [Icon(Icons.person), Icon(Icons.fitness_center), Icon(Icons.fitness_center)];

class ProfileWidget extends StatefulWidget {
  final Auth0? auth0;
  const ProfileWidget({this.auth0, Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  UserProfile? _user;

  late Auth0 auth0;
  late Auth0Web auth0Web;

  @override
  void initState() {
    super.initState();
    auth0 = widget.auth0 ??
        Auth0(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
    auth0Web =
        Auth0Web(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);

    if (kIsWeb) {
      auth0Web.onLoad().then((final credentials) => setState(() {
        _user = credentials?.user;
      }));
    }
  }


  Future<void> logout() async {
    try {
      if (kIsWeb) {
        await auth0Web.logout(returnToUrl: 'http://localhost:3000');
      } else {
        await auth0
            .webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME'])
            .logout();
        setState(() {
          _user = null;
        });
      }
    } catch (e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 80)),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Signed in as:',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text(Global_user_mail!,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
                alignment: Alignment.center, padding: const EdgeInsets.all(10)),
            const Row(
              children: [
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
                    height: (MediaQuery.of(context).size.height) * 0.6,
                    width: (MediaQuery.of(context).size.width) * 0.9,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: profileList.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return ListTile(
                          leading: iconList[index],
                          title: Text(profileList[index]),
                          trailing: const Icon(Icons.navigate_next),
                            onTap: () => {
                              if(index == 0) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileAccountPage()))
                              } else if(index == 1) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const SavedWorkoutsPage()))
                              } else if(index == 2) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoriteExercisesPage()))
                              }
                            },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: logout,
                  icon: const Icon(Icons.logout_rounded, size: 25),
                  color: Colors.orangeAccent,
                ),
                const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                )
              ],
            ),
      ],
    ));
  }
}

