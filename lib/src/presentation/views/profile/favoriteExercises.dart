import 'package:flutter/material.dart';
import 'package:projekt_frontend/src/presentation/views/profile/widgets/favoriteExercises.dart';

class FavoriteExercisesPage extends StatefulWidget {
  const FavoriteExercisesPage({Key? key}) : super(key: key);

  @override
  State<FavoriteExercisesPage> createState() => _FavoriteExercisesPageState();
}

class _FavoriteExercisesPageState extends State<FavoriteExercisesPage> {
  @override
  Widget build(BuildContext context) {
    return FavoriteExercisesWidget();
  }
}
