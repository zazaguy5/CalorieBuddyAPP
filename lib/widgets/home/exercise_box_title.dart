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

        if (isRestDay) 
          Container(
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
            child: const Text('วันพัก', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600))
          )
      ],
    );
  }
}