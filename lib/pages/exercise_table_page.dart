import 'package:calories_buddy/contants/contants.dart';
import 'package:calories_buddy/contants/date_time_constants.dart';
import 'package:calories_buddy/contants/muscle_icons.dart';
import 'package:calories_buddy/widgets/custom_widget.dart';
import 'package:calories_buddy/widgets/exercise_table/detail_button.dart';
import 'package:flutter/material.dart';

class ExerciseTablePage extends StatelessWidget {
  final List<List<String>> exerciseWeek;
  const ExerciseTablePage({super.key, required this.exerciseWeek});

  @override
  Widget build(BuildContext context) {
    CustomWidget customWidget = CustomWidget();

    return Scaffold(
      appBar: customWidget.appBarCustom(context, 'ตารางการออกกำลังกาย', null, null),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.75), 
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    bool isRestDay = exerciseWeek[index].contains('พัก');
                  
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        border: Border.all(color: isRestDay ? cardBgColor : elementColor, width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.4),
                            spreadRadius: 0,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // วันในสัปดาห์
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(DateTimeConstants.DAYS_CONSTANT[index], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 0.5)),
                              Container(width: 8, height: 8, decoration: BoxDecoration(color: isRestDay ? greyOne :elementColor, shape: BoxShape.circle)),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // แท็กวันพักหรือวันออกกำลังกาย
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: isRestDay ? Colors.grey.shade800 : elementColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6)
                            ),
                            child: Text(
                              isRestDay ? 'REST DAY' : 'WORKOUT', 
                              style: TextTheme.of(context).labelSmall!.copyWith(fontWeight: FontWeight.bold, color: isRestDay ? greyOne : elementColor, letterSpacing: 1)
                            ),
                          ),

                          // รายการกล้ามเนื้อที่จะออกกำลังกายในวันนี้
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (isRestDay) 
                                  Flexible(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: backgroundColor,
                                            borderRadius: BorderRadius.circular(6)
                                          ),
                                          child: Icon(Icons.self_improvement, size: 30, color: greyOne),
                                        ),
                                        const SizedBox(height: 4,),
                                        Text('วันพัก', style: TextTheme.of(context).bodyMedium!.copyWith(color: greyOne, fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                  )
                                else 
                                  Flexible(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // แสดงกลุ่มกล้ามเนื้อที่จะออกกำลังกายในวันนี้
                                        Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: backgroundColor,
                                            borderRadius: BorderRadius.circular(6)
                                          ),
                                          child: Wrap(
                                            spacing: 3,
                                            runSpacing: 3,
                                            alignment: WrapAlignment.center,
                                            children: exerciseWeek[index].take(3).map((muscle) {
                                              return Container(
                                                width: 40,
                                                height: 40,
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(3)),
                                                child: Image.asset(muscleIcons[muscle]!, color: elementColor, width: 20, height: 20, fit: BoxFit.cover,),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        const SizedBox(height: 2,),
                                        Text(exerciseWeek[index].take(3).join(' • '), maxLines: 1,overflow: TextOverflow.ellipsis, style: TextTheme.of(context).bodyMedium!.copyWith(color: greyOne, fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5,),

                          // ปุ่มกดดูรายละเอียด
                          ExerciseDetailButton(day: DateTimeConstants.DAYS_CONSTANT[index], toDayExercises: exerciseWeek[index]),

                          // ปุ่มกดเริ่มออกกำลังกาย
                          if (!isRestDay) ...[
                            const SizedBox(height: 6,),

                            GestureDetector(
                              onTap: null,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: elementColor,
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(color: elementColor.withValues(alpha: 0.3), blurRadius: 3, offset: Offset(0, 1))
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.play_arrow, color: Colors.white, size: 18),
                                    const SizedBox(width: 3),
                                    Text('เริ่ม', style: TextTheme.of(context).labelMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.3)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}