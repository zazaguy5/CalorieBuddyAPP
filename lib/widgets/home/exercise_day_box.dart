// ignore_for_file: must_be_immutable

import 'package:calories_buddy/widgets/home/exercise_box_title.dart';
import 'package:calories_buddy/contants/muscle_icons.dart';
import 'package:calories_buddy/contants/contants.dart';
import 'package:flutter/material.dart';

class ExerciseDayBox extends StatelessWidget {
  bool isToday;
  bool isRestDay;
  String day;
  List exerciseMuscle;
  ExerciseDayBox({super.key, required this.day, required this.isRestDay, required this.isToday, required this.exerciseMuscle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          // ส่วนหัวแสดงวัน
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            decoration: BoxDecoration(
              color: isToday ? Colors.blue.shade700 : Colors.grey.shade800,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            ),
            child: ExerciseBoxTitle(day: day, isToday: isToday, isRestDay: isRestDay),
          ),

          // ส่วนแสดงเนื้อหา ตารางออกกำลังกาย
          Container(
            height: 180,
            width: 150,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isRestDay? [Colors.grey.shade500, Colors.grey.shade600] : isToday? [Colors.blue.shade500, Colors.blue.shade700] : [Colors.grey.shade700, Colors.grey.shade900],
              ),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
              boxShadow: [BoxShadow(color: isToday ? Colors.blue.withValues(alpha: 0.5) : Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
            ),
            child: isRestDay ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
                  child: Icon(Icons.self_improvement, size: 42, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text('พักผ่อน', style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.w500, color: Colors.white)),
              ],
            ) : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('กลุ่มกล้ามเนื้อ', style: TextTheme.of(context).titleSmall!.copyWith(fontWeight: FontWeight.w500, color: Colors.white70)),
                const SizedBox(height: 12),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: exerciseMuscle.map((muscle) {
                      return Container(
                        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(muscleIcons[muscle]!, height: 28, width: 28, color: isToday? Colors.white : elementColor),
                            const SizedBox(height: 4),
                            Text(muscle, style: TextTheme.of(context).labelMedium!.copyWith(fontWeight: FontWeight.w500, color: Colors.white), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}