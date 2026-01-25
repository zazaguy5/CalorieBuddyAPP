import 'package:calories_buddy/models/exercise_data_model.dart';
import 'package:flutter/material.dart';

class ExercisePage extends StatefulWidget {
  final List<Exercise> exercises;
  const ExercisePage({super.key, required this.exercises});

  @override
  // ignore: no_logic_in_create_state
  State<ExercisePage> createState() => _ExercisePageState(exercises: exercises);
}

class _ExercisePageState extends State<ExercisePage> {
  final List<Exercise> exercises;
  _ExercisePageState({required this.exercises});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}