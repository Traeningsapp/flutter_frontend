import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Shader linearGradient = const LinearGradient(colors: <Color>[
  Color.fromRGBO(255, 79, 64, 100),
  Color.fromRGBO(255, 68, 221, 100)
], begin: Alignment.topLeft, end: Alignment.bottomRight)
    .createShader(const Rect.fromLTWH(0.0, 0.0, 500.0, 70.0));

class HeroWidget extends StatelessWidget {
  const HeroWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: Image.asset('assets/images/Logo.png', width: 160),
      ),
      Expanded(
          child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text('Trænings',
                    style: GoogleFonts.spaceGrotesk(
                      foreground: Paint()..shader = linearGradient,
                      fontSize: 64,
                      height: 0.8,
                      fontWeight: FontWeight.w800,
                    )),
                Text('App',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 54,
                      height: 0.8,
                      fontWeight: FontWeight.w600,
                    )),
              ])))
    ]);
  }
}
