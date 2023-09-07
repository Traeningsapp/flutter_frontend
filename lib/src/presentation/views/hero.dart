import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projekt_frontend/src/utils/constants.dart';

final Shader linearGradient = const LinearGradient(colors: <Color>[
  Color.fromRGBO(110, 43, 43, 100),
  Color.fromRGBO(247, 0, 0, 100)
], begin: Alignment.topLeft, end: Alignment.bottomRight)
    .createShader(const Rect.fromLTWH(100.0, 200.0, 500.0, 70.0));

class HeroWidget extends StatelessWidget {
  const HeroWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(padding: EdgeInsets.only(top: 30)),
      Container(
        child: Image.asset('assets/images/BeefcakeLogo.png', width: 160),
      ),
      Expanded(
          child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text('Enter',
                    style: GoogleFonts.spaceGrotesk(
                      foreground: Paint()..shader = linearGradient,
                      fontSize: 64,
                      height: 0.8,
                      fontWeight: FontWeight.w800,
                    )),
                Container(
                  margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1, 10, 0, 10),
                  child:
                    Text('The',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 38,
                          height: 0.6,
                          fontWeight: FontWeight.w600,
                        )),
                ),
                Text('Factory',
                    style: GoogleFonts.spaceGrotesk(
                      foreground: Paint()..shader = linearGradient,
                      fontSize: 54,
                      height: 0.8,
                      fontWeight: FontWeight.w600,
                    )),
              ])))
    ]);
  }
}
