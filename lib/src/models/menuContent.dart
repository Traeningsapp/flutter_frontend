import 'package:projekt_frontend/src/models/rive_model.dart';

class Menu {
  final String title;
  //final String route;
  final RiveModel rive;

  Menu({required this.title, /*required this.route ,*/ required this.rive});
}

List<Menu> sideMenuTiles = [
  Menu(
    title: "Home",
    rive: RiveModel(
        src: "assets/RiveAssets/Updated_icons.riv",
        artboard: "HOME",
        stateMachineName: "HOME_Interactivity"),
  ),
  Menu(
    title: "Explore exercises",
    rive: RiveModel(
        src: "assets/RiveAssets/Updated_icons.riv",
        artboard: "RULES",
        stateMachineName: "RULES_Interactivity"),
  ),
  Menu(
    title: "Profile",
    rive: RiveModel(
        src: "assets/RiveAssets/Updated_icons.riv",
        artboard: "USER",
        stateMachineName: "USER_Interactivity"),
  ),
];


List<Menu> bottomSideMenuTiles = [
  Menu(
    title: "Settings",
    rive: RiveModel(
        src: "assets/RiveAssets/Updated_icons.riv",
        artboard: "SETTINGS",
        stateMachineName: "SETTINGS_Interactivity"),
  )
];
