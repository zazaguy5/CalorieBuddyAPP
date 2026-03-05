import 'package:flutter/material.dart';

Widget floatingButton() {
  return RotatedBox(
    quarterTurns: 1, // หมุนกล่องทวนเข็มนาฬิกา 90 องศา
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      width: 130,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue.shade700.withValues(alpha: 0.2),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Text("ประวัติ", style: TextStyle(fontSize: 20, color: Colors.white.withValues(alpha: 0.2), fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Icon(Icons.fitness_center, size: 22, color: Colors.white.withValues(alpha: 0.2))
        ],
      ), 
    ),
  );
}