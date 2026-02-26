import 'package:calories_buddy/contants/contants.dart';
import 'package:calories_buddy/models/exercise_data_model.dart';
import 'package:calories_buddy/widgets/exercise_card_widget.dart';
import 'package:flutter/material.dart';

class DetailPopup extends StatelessWidget {
  final Exercise exercise;
  const DetailPopup({required this.exercise, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color:  Colors.white.withValues(alpha: 0.1), width: 1),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.3), spreadRadius: 0, blurRadius: 8, offset: Offset(0, 2))
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                exerciseImage(exercise.image),
                const SizedBox(width: 16),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(exercise.name, style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 6),
                      exerciseMuscleGroup(context, exercise.muscle),
                      const SizedBox(height: 6),
                      exerciseSetsReps(context, '${exercise.sets} เซ็ต x ${exercise.reps} ${exercise.name == 'Plank' ? 'วินาที' : 'ครั้ง'}'),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.schedule, size: 16, color:  Colors.white70),
                          SizedBox(width: 4),
                          Text('พัก 1 นาที 30 วินาที', style: TextTheme.of(context).bodyMedium!.copyWith(color:  Colors.white70, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Video Play Button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.red.withValues(alpha: 0.3), spreadRadius: 0, blurRadius: 4, offset: Offset(0, 2))
                    ],
                  ),
                  child: IconButton(onPressed: () {
                    // UrlLauncher urlLauncher = UrlLauncher();
                    // urlLauncher.launchLink(exercise['video']!);
                  }, icon: Icon(Icons.play_arrow, color: Colors.white, size: 24)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Description Container
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:  Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, size: 18, color: elementColor),
                  const SizedBox(width: 8),
                  Expanded(child: Text(exercise.description, style: TextTheme.of(context).bodyMedium!.copyWith(color: (Colors.white).withValues(alpha: 0.8), height: 1.5))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}