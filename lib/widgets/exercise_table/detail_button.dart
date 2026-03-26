import 'package:calories_buddy/contants/contants.dart';
import 'package:calories_buddy/widgets/exercise_table/detail_popup.dart';
import 'package:flutter/material.dart';

class ExerciseDetailButton extends StatelessWidget {
  final String day;
  final String exerciseStirng;
  final List exerciseList;
  const ExerciseDetailButton({super.key, required this.day, required this.exerciseStirng, required this.exerciseList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      color: Colors.transparent,
      child: Column(
        children: [
          // ส่วนหัวของรายละเอียด
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 20),
            decoration: BoxDecoration(
              color: elementColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // แถบกดลากได้
                Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(2)),
                ),

                // วันและส่วนที่โดน
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(day, style: TextTheme.of(context).headlineSmall!.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1, color: Colors.white)),
                          const SizedBox(height: 4),
                          Text(exerciseStirng, style: TextTheme.of(context).titleMedium!.copyWith(color: Colors.white.withValues(alpha: 0.9), fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),

                    // ปุ่มปิด
                    Container(
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close, color: Colors.white, size: 24),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // รายละเอียดท่าออกกำลังกาย
          Expanded(
            child: Container(
              color: backgroundColor,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: exerciseList.map((exercise) => DetailPopup(exercise: exercise)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}