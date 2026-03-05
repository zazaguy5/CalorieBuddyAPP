import 'package:calories_buddy/widgets/custom_widget.dart';
import 'package:flutter/material.dart';

class ExerciseBoxTitle extends StatelessWidget {
  final String day;
  final bool isToday;
  final bool isRestDay;
  const ExerciseBoxTitle({super.key, required this.day, required this.isToday, required this.isRestDay});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(day, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        if (isToday)
          toDayBox(),
      ],
    );
  }
}