import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';
import 'package:rive/rive.dart';

class MenuBtn extends StatelessWidget {
  const MenuBtn({super.key, required this.press, required this.riveOnInit});

  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press,
        child: Container(
          margin: const EdgeInsets.only(left: 15, top: 10),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: SelectedSecondaryColor,
          ),
          child: RiveAnimation.asset(
            'assets/RiveAssets/menu_button.riv',
            onInit: riveOnInit,
          ),
        ),
      ),
    );
  }
}