import 'package:calories_buddy/contants/contants.dart';
import 'package:calories_buddy/contants/muscle_icons.dart';
import 'package:flutter/material.dart';

Widget exerciseImage(String image) {
  return Container(
    width: 64,
    height: 64,
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [elementColor.withValues(alpha: 0.8), elementColor], begin: Alignment.topLeft, end: Alignment.bottomRight),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: elementColor.withValues(alpha: 0.3), spreadRadius: 0, blurRadius: 4, offset: Offset(0, 2))
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        image,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return Container(
            height: 120,
            width: 150,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey[100]),
            child: Center(child: CircularProgressIndicator(value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null))
          );
        },
        errorBuilder:(context, error, stackTrace) {
          return Container(
            height: 120,
            width: 150,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey[100]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.photo, size: 40, color: Colors.grey[400]),
                Text('No Image', style: TextTheme.of(context).bodySmall!.copyWith(color: Colors.grey[400], fontWeight: FontWeight.w500))
              ],
            ),
          );
        },
      ),
    ),
  );
}

Widget exerciseSetsReps(BuildContext context, String txt) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: elementColor.withValues(alpha: 0.4), borderRadius: BorderRadius.circular(8)),
    child: Text(txt, style: TextTheme.of(context).bodyMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
  );
}

Widget exerciseMuscleGroup(BuildContext context, String muscle) {
  return Row(
    children: [
      Text('กล้ามเนื้อ$muscle', style: TextTheme.of(context).bodySmall!.copyWith(color: Colors.white70, fontWeight: FontWeight.w500)),
      const SizedBox(width: 4),
      Image.asset(muscleIcons[muscle]!, color:  Colors.white70, width: 20, height: 20, fit: BoxFit.cover),
    ],
  );
}

