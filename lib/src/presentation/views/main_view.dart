import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projekt_frontend/src/presentation/views/hero.dart';
import 'package:projekt_frontend/src/presentation/views/landing/landing_page.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

import '../../utils/constants.dart';

class MainView extends StatefulWidget {
  final Auth0? auth0;

  const MainView({this.auth0, final Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
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

  Future<void> login() async {
    try {
      if (kIsWeb) {
        return auth0Web.loginWithRedirect(redirectUrl: 'http://localhost:3000');
      }

      var credentials = await auth0
          .webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME'])
          .login();

      setState(() {
        _user = credentials.user;
        Global_userid = credentials.user.sub;
        Global_Access_token = credentials.accessToken;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Padding(
          padding: const EdgeInsets.only(
              top: padding,
              bottom: padding,
              left: padding / 2,
              right: padding / 2,
            ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(children: [
                    _user != null
                      ? const Expanded(child: LandingPage())
                      : const Expanded(child: HeroWidget())
              ])),
              _user != null
              ? Container() : ElevatedButton(
                  onPressed: login,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  child: const Text('Login'),
                )
        ]),
      )),
    );
  }
}
