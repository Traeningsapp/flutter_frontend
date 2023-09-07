import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projekt_frontend/src/presentation/views/hero.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:projekt_frontend/src/presentation/views/profile/widgets/ThemeColor.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';
import 'favoriteExercises.dart';
import 'profileAccount.dart';
import 'savedWorkouts.dart';

const List<String> profileList = ['Account','Saved workouts','Favorite Exercises', 'Themes'];
const List<Icon> iconList = [Icon(Icons.person), Icon(Icons.fitness_center), Icon(Icons.fitness_center), Icon(Icons.color_lens_outlined)];

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
    _setupAuth0();
  }

  void _setupAuth0() {
    auth0 = widget.auth0 ?? Auth0(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
    auth0Web = Auth0Web(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Signed in as:',
                  style: TextStyle(
                      color: SelectedHeadlineColor,
                      fontSize: 16),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text('Email here',
                  style: TextStyle(
                      color: SelectedTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
                alignment: Alignment.center, padding: const EdgeInsets.all(10)),
            Row(
              children: [
                Expanded(
                    child: Divider(
                  color: SelectedSecondaryColor,
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
                          title: Text(
                              profileList[index],
                              style: TextStyle(
                                color: SelectedTextColor,
                              ),
                          ),
                          trailing: const Icon(Icons.navigate_next),
                            onTap: () => {
                              if(index == 0) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileAccountWidget()))
                              } else if(index == 1) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const SavedWorkoutWidget()))
                              } else if(index == 2) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoriteExercisesWidget()))
                              } else if(index == 3) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ThemeColorWidget()))
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
                  onPressed: () async {
                    logout();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) =>
                            const HeroWidget()),
                            (route) => false);
                  },
                  icon: const Icon(Icons.logout_rounded, size: 25),
                  color: Colors.deepOrange,
                ),
                Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    color: SelectedTextColor,
                  ),
                )
              ],
            ),
      ],
    ));
  }
}

