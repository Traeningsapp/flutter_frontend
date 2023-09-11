import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/presentation/views/stats/widgets/stats.dart';
import 'package:projekt_frontend/src/presentation/views/universal/customappbar.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StatsPageWidget()
    );
  }
}