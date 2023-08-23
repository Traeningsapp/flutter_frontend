import 'dart:math';
import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/models/menu_content.dart';
import 'package:projekt_frontend/src/presentation/views/exercise/exercise_page.dart';
import 'package:projekt_frontend/src/presentation/views/help/help_page.dart';
import 'package:projekt_frontend/src/presentation/views/home/home_page.dart';
import 'package:projekt_frontend/src/presentation/views/profile/profile_page.dart';
import 'package:projekt_frontend/src/presentation/views/landing/widgets/InfoCard.dart';
import 'package:projekt_frontend/src/presentation/views/landing/widgets/menubtn.dart';
import 'package:projekt_frontend/src/presentation/views/landing/widgets/topSideMenuTile.dart';
import 'package:projekt_frontend/src/presentation/views/landing/widgets/bottomSideMenuTile.dart';
import 'package:projekt_frontend/src/presentation/views/settings/settings_page.dart';
import 'package:projekt_frontend/src/presentation/views/stats/stats_page.dart';
import 'package:projekt_frontend/src/utils/rive_utils.dart';
import 'package:rive/rive.dart';


class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {

  int currentIndex = 0;
  final screens = [
    const HomePage(),
    const ExercisePage(),
    const ProfilePage(),
    const StatsPage()
  ];

  bool isSideDrawerOpen = false;

  Menu selectedMenuItem = sideMenuTiles.first;

  late SMIBool isMenuOpenInput;

  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(
        () {
          setState(() {});
        },
      );

    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void closeDrawer() {
    isSideDrawerOpen = !isSideDrawerOpen;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: Stack(
          children: [
            AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastOutSlowIn,
                width: 288,
                left: isSideDrawerOpen ? 0 : -288,
                top: 0,
                height: MediaQuery.of(context).size.height,
                child: DrawerMenu()),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(
                    1 * animation.value - 30 * (animation.value) * pi / 180),
              child: Transform.translate(
                offset: Offset(animation.value * 265, 0),
                child: Transform.scale(
                  scale: scaleAnimation.value,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(24),
                    ),
                    child: Scaffold(
                        body: IndexedStack(
                          index: currentIndex,
                          children: screens,
                        )
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              left: isSideDrawerOpen ? 220 : 0,
              top: 16,
              child: MenuBtn(
                press: () {
                  isMenuOpenInput.value = !isMenuOpenInput.value;

                  if (_animationController.value == 0) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }

                    setState(
                      () {
                        isSideDrawerOpen = !isSideDrawerOpen;
                      },
                  );
                },
                riveOnInit: (artboard) {
                  final controller = StateMachineController.fromArtboard(artboard, "State Machine");

                  artboard.addController(controller!);

                  isMenuOpenInput = controller.findInput<bool>("isOpen") as SMIBool;
                  isMenuOpenInput.value = true;
                },
              ),
            ),
          ],
        ),
      );

  Widget DrawerMenu() {
    return SafeArea(
      child: Container(
        width: 288,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30)
          ),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.black),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoCard(name: "indsæt email"),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "Browse".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.black),
                ),
              ),
              ...sideMenuTiles
                  .map((menu) => SideMenuTile(
                menu: menu,
                selectedMenu: selectedMenuItem,
                press: () {
                  RiveUtils.changeSMIBoolState(menu.rive.status!);
                  setState(() {
                    selectedMenuItem = menu;
                    if(menu.title == 'Home') {
                      currentIndex = 0;
                    } else if (menu.title == 'Explore exercises') {
                      currentIndex = 1;

                    } else if (menu.title == 'Profile') {
                      currentIndex = 2;

                    } else if (menu.title == 'Stats') {
                      currentIndex = 3;

                    }
                  });
                },
                riveOnInit: (artboard) {
                  menu.rive.status = RiveUtils.getRiveInput(artboard,
                      stateMachineName: menu.rive.stateMachineName!);
                },
              )).toList(),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 40, bottom: 16),
                child: Text(
                  "History".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.black),
                ),
              ),
              ...bottomSideMenuTiles
                  .map((menu) => BottomSideMenuTile(
                menu: menu,
                selectedMenu: selectedMenuItem,
                press: () {
                  RiveUtils.changeSMIBoolState(menu.rive.status!);
                  setState(() {
                    selectedMenuItem = menu;
                    if(menu.title == 'Settings') {
                      Navigator.push(context, MaterialPageRoute(builder:(context) => const SettingsPage()));
                    } else if (menu.title == 'Help') {
                      Navigator.push(context, MaterialPageRoute(builder:(context) => const HelpPage()));
                    }
                  });
                },
                riveOnInit: (artboard) {
                  menu.rive.status = RiveUtils.getRiveInput(artboard,
                      stateMachineName: menu.rive.stateMachineName!);
                },
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }
}