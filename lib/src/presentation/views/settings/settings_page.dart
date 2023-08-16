import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/presentation/views/settings/components_widgets/settings_widget.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const String _title = 'Trænings App';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarWidget(title: 'Settings page', themecolor: Colors.deepPurple),
      body: SettingsWidget()
    );
  }
}