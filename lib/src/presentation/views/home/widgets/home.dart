import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projekt_frontend/src/presentation/views/workout/createWorkout.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';

final Shader linearGradient = const LinearGradient(colors: <Color>[
  Color.fromRGBO(110, 43, 43, 100),
  Color.fromRGBO(247, 0, 0, 100)
], begin: Alignment.topLeft, end: Alignment.bottomRight)
    .createShader(const Rect.fromLTWH(100.0, 200.0, 500.0, 70.0));


class HomeWidget extends StatelessWidget {

  HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SelectedMainColor,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1, 10, 0, 0),
                    child: Text('Let the',
                        style: GoogleFonts.spaceGrotesk(
                          foreground: Paint()..shader = linearGradient,
                          fontSize: 50,
                          height: 0.8,
                          fontWeight: FontWeight.w800,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.2, 10, 0, 0),
                    child:
                    Text('Factory',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 56,
                          height: 0.6,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.3, 10, 0, 0),
                    child: Text('Mold you',
                        style: GoogleFonts.spaceGrotesk(
                          foreground: Paint()..shader = linearGradient,
                          fontSize: 50,
                          height: 0.8,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.6,
            child: FittedBox(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(SelectedSecondaryColor)
                ),
                child: Text(
                    textScaleFactor: 0.7,
                    textAlign: TextAlign.center,
                    'Punish me!',
                    style: TextStyle(
                      color: SelectedTextColor
                    ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateWorkoutPage()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}