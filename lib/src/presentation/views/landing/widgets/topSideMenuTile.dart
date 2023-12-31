import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/menuContent.dart';
import 'package:projekt_frontend/src/utils/globalVariables.dart';
import 'package:rive/rive.dart';


class SideMenuTile extends StatelessWidget {
  const SideMenuTile({super.key, required this.menu, required this.press,  required this.riveOnInit, required this.selectedMenu});

  final Menu menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;
  final Menu selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(color: Colors.black, height: 1),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              width: selectedMenu == menu ? 288 : 0,
              height: 56,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: SelectedTertiaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 36,
                width: 36,
                child: RiveAnimation.asset(
                  menu.rive.src,
                  artboard: menu.rive.artboard,
                  onInit: riveOnInit,
                ),
              ),
              title: Text(
                menu.title,
                style: TextStyle(color: SelectedTextColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
