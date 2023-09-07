import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/presentation/views/settings/widgets/settings_widget.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar.dart';
import '../../../utils/globalVariables.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const String _title = 'Trænings App';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SelectedMainColor,
      appBar: const CustomAppBarWidget(title: 'Settings page'),
      body: const SettingsWidget()
    );
  }
}