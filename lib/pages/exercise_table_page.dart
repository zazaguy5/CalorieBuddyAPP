// import 'package:calories_buddy/contants/contants.dart';
// import 'package:calories_buddy/contants/date_time_constants.dart';
// import 'package:calories_buddy/contants/muscle_icons.dart';
// import 'package:calories_buddy/models/exercise_data_model.dart';
// import 'package:calories_buddy/pages/exercise_page.dart';
// import 'package:calories_buddy/widgets/custom_widget.dart';
// import 'package:calories_buddy/widgets/exercise_table/detail_button.dart';
// import 'package:calories_buddy/widgets/exercise_table/restday_dialog.dart';
// import 'package:flutter/material.dart';

// class ExerciseTablePage extends StatelessWidget {
//   final List<List<String>> exerciseWeek;
//   const ExerciseTablePage({super.key, required this.exerciseWeek});

//   @override
//   Widget build(BuildContext context) {
//     CustomWidget customWidget = CustomWidget();

//     Map<String, List<Exercise>> exerciseList = {
//       'จ.': [
//         Exercise(
//           name: 'Bench Press', 
//           description: 'วิธีการ: การตั้งท่าที่มั่นคง วางเท้าให้ราบกับพื้น หลังแนบม้านั่ง จับบาร์กว้างกว่าไหล่เล็กน้อย และล็อคข้อมือให้ตรง', 
//           muscle: 'อก',
//           sets: 4, 
//           reps: 12, 
//           image: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg', 
//           images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg', 
//           video: 'https://www.youtube.com/watch?v=AJFf4ATImPA'
//         ),
//         Exercise(
//           name: 'Cable Fly',
//           description: 'วิธีการ: กดด้ามจับสายเคเบิลให้มาอยู่ด้านหน้าหน้าอก โดยยืดแขนออกและให้ฝ่ามือหันเข้าหากัน จากนั้นเริ่มทำซ้ำโดยช้าๆ ให้ด้ามจับเคลื่อนไปทางเครื่องสายเคเบิลเป็นทิศทางโค้ง',
//           muscle: 'อก',
//           sets: 4,
//           reps: 12,
//           image: 'https://liftmanual.com/wp-content/uploads/2023/04/cable-standing-fly.jpg',
//           images: 'https://liftmanual.com/wp-content/uploads/2023/04/cable-standing-fly.jpg',
//           video: 'assets/videos/chest_press.mp4'
//         ),
//       ],
//       'อ.': [
//         Exercise(
//           name: 'Pull Up',
//           description: 'วิธีการ: ห้อยตัวบนบาร์ ดึงตัวขึ้นจนคางเกินบาร์',
//           muscle: 'หลัง',
//           sets: 3,
//           reps: 8,
//           image: 'https://anabolicaliens.com/cdn/shop/articles/199990_400x.png?v=1645089103',
//           images: 'https://kinxlearning.com/cdn/shop/files/exercise-18_1000x.jpg?v=1613154703',
//           video: 'assets/videos/pullup.mp4'
//         ),
//         Exercise(
//           name: 'T Bar Row',
//           description: 'วิธีการ: ยืนคร่อมบาร์ ก้มตัวลงเล็กน้อย และใช้มือทั้งสองข้างจับที่ปลายบาร์ จากนั้นยกน้ำหนักขึ้นโดยดึงบาร์เข้าหาลำตัว',
//           muscle: 'หลัง',
//           sets: 3,
//           reps: 12,
//           image: 'https://www.shutterstock.com/image-illustration/lever-tbar-row-plate-loaded-260nw-622379585.jpg',
//           images: 'https://kinxlearning.com/cdn/shop/files/exercise-18_1000x.jpg?v=1613154703',
//           video: 'assets/videos/bent_row.mp4'
//         )
//       ],
//       'พ.': [
//         Exercise(
//           name: 'Bicep Curl',
//           description: 'วิธีการ: ยกดัมเบลขึ้นลงด้วยกล้ามเนื้อต้นแขน',
//           muscle: 'แขน',
//           sets: 3,
//           reps: 15,
//           image: 'assets/images/exercises/bicep_curl.jpg',
//           images: 'https://kinxlearning.com/cdn/shop/files/exercise-18_1000x.jpg?v=1613154703',
//           video: 'assets/videos/bicep_curl.mp4'
//         ),
//         Exercise(
//           name: 'Tricep Dip',
//           description: 'วิธีการ: วางมือบนเก้าอี้ ลดตัวลงแล้วดันขึ้น',
//           muscle: 'แขน',
//           sets: 3,
//           reps: 12,
//           image: 'assets/images/exercises/tricep_dip.jpg',
//           images: 'https://kinxlearning.com/cdn/shop/files/exercise-18_1000x.jpg?v=1613154703',
//           video: 'assets/videos/tricep_dip.mp4'
//         )
//       ],
//       'พฤ.': [
//         Exercise(
//           name: 'Lateral Dumbbell Raise',
//           description: 'วิธีการ: ยกดัมเบลขึ้นเหนือศีรษะ',
//           muscle: 'ไหล่',
//           sets: 3,
//           reps: 12,
//           image: 'assets/images/exercises/shoulder_press.jpg',
//           images: 'https://kinxlearning.com/cdn/shop/files/exercise-18_1000x.jpg?v=1613154703',
//           video: 'assets/videos/shoulder_press.mp4'
//         )
//       ],
//       'ศ.': [
//         Exercise(
//           name: 'Squat',
//           description: 'วิธีการ: ยืนตรง นั่งลงแล้วลุกขึ้น',
//           muscle: 'ขา',
//           sets: 3,
//           reps: 20,
//           image: 'assets/images/exercises/squat.jpg',
//           images: 'https://kinxlearning.com/cdn/shop/files/exercise-18_1000x.jpg?v=1613154703',
//           video: 'assets/videos/squat.mp4'
//         ),
//         Exercise(
//           name: 'Lunges',
//           description: 'วิธีการ: ก้าวขาไปข้างหน้าแล้วลงลึก',
//           muscle: 'ขา',
//           sets: 3,
//           reps: 15,
//           image: 'assets/images/exercises/lunges.jpg',
//           images: 'https://kinxlearning.com/cdn/shop/files/exercise-18_1000x.jpg?v=1613154703',
//           video: 'assets/videos/lunges.mp4'
//         )
//       ],
//       'ส.': [
//         Exercise(
//           name: 'Sit Up',
//           description: 'วิธีการ: นอนหงาย งอเข่า ลุกขึ้นด้วยกล้ามเนื้อหน้าท้อง',
//           muscle: 'หน้าท้อง',
//           sets: 3,
//           reps: 25,
//           image: 'assets/images/exercises/situp.jpg',
//           images: 'https://kinxlearning.com/cdn/shop/files/exercise-18_1000x.jpg?v=1613154703',
//           video: 'assets/videos/situp.mp4'
//         ),
//         Exercise(
//           name: 'Plank',
//           description: 'วิธีการ: ค้ำตัวด้วยข้อศอกและปลายเท้า (วินาที)',
//           muscle: 'หน้าท้อง',
//           sets: 3,
//           reps: 60,
//           image: 'assets/images/exercises/plank.jpg',
//           images: 'https://kinxlearning.com/cdn/shop/files/exercise-18_1000x.jpg?v=1613154703',
//           video: 'assets/videos/plank.mp4'
//         )
//       ],
//       'อา.': [
//         Exercise(
//           name: 'Sit Up',
//           description: 'วิธีการ: นอนหงาย งอเข่า ลุกขึ้นด้วยกล้ามเนื้อหน้าท้อง',
//           muscle: 'หน้าท้อง',
//           sets: 3,
//           reps: 25,
//           image: 'assets/images/exercises/situp.jpg',
//           images: 'https://kinxlearning.com/cdn/shop/files/exercise-18_1000x.jpg?v=1613154703',
//           video: 'assets/videos/situp.mp4'
//         ),
//         Exercise(
//           name: 'Plank',
//           description: 'วิธีการ: ค้ำตัวด้วยข้อศอกและปลายเท้า (วินาที)',
//           muscle: 'หน้าท้อง',
//           sets: 3,
//           reps: 60,
//           image: 'assets/images/exercises/plank.jpg',
//           images: 'https://kinxlearning.com/cdn/shop/files/exercise-18_1000x.jpg?v=1613154703',
//           video: 'assets/videos/plank.mp4'
//         )
//       ]
//     };

//     return Scaffold(
//       appBar: customWidget.appBarCustom(context, 'ตารางการออกกำลังกาย', null, null),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             children: [
//               Expanded(
//                 child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.75), 
//                   itemCount: 7,
//                   itemBuilder: (context, index) {
//                     bool isRestDay = exerciseWeek[index].contains('พัก');
//                     String day = DateTimeConstants.DAYS_CONSTANT[index];
                  
//                     return Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Colors.black.withValues(alpha: 0.6),
//                         border: Border.all(color: isRestDay ? cardBgColor : elementColor, width: 1.5),
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withValues(alpha: 0.4),
//                             spreadRadius: 0,
//                             blurRadius: 8,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // วันในสัปดาห์
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(day, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 0.5)),
//                               Container(width: 8, height: 8, decoration: BoxDecoration(color: isRestDay ? greyOne :elementColor, shape: BoxShape.circle)),
//                             ],
//                           ),
//                           const SizedBox(height: 8),

//                           // แท็กวันพักหรือวันออกกำลังกาย
//                           Container(
//                             padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                             decoration: BoxDecoration(
//                               color: isRestDay ? Colors.grey.shade800 : elementColor.withValues(alpha: 0.15),
//                               borderRadius: BorderRadius.circular(6)
//                             ),
//                             child: Text(
//                               isRestDay ? 'REST DAY' : 'WORKOUT', 
//                               style: TextTheme.of(context).labelSmall!.copyWith(fontWeight: FontWeight.bold, color: isRestDay ? greyOne : elementColor, letterSpacing: 1)
//                             ),
//                           ),

//                           // รายการกล้ามเนื้อที่จะออกกำลังกายในวันนี้
//                           Expanded(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 if (isRestDay) 
//                                   Flexible(
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Container(
//                                           width: 40,
//                                           height: 40,
//                                           decoration: BoxDecoration(
//                                             color: backgroundColor,
//                                             borderRadius: BorderRadius.circular(6)
//                                           ),
//                                           child: Icon(Icons.self_improvement, size: 30, color: greyOne),
//                                         ),
//                                         const SizedBox(height: 4,),
//                                         Text('วันพัก', style: TextTheme.of(context).bodyMedium!.copyWith(color: greyOne, fontWeight: FontWeight.w500))
//                                       ],
//                                     ),
//                                   )
//                                 else 
//                                   Flexible(
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         // แสดงกลุ่มกล้ามเนื้อที่จะออกกำลังกายในวันนี้
//                                         Container(
//                                           padding: const EdgeInsets.all(6),
//                                           decoration: BoxDecoration(
//                                             color: backgroundColor,
//                                             borderRadius: BorderRadius.circular(6)
//                                           ),
//                                           child: Wrap(
//                                             spacing: 3,
//                                             runSpacing: 3,
//                                             alignment: WrapAlignment.center,
//                                             children: exerciseWeek[index].take(3).map((muscle) {
//                                               return Container(
//                                                 width: 40,
//                                                 height: 40,
//                                                 padding: const EdgeInsets.all(5),
//                                                 decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(3)),
//                                                 child: Image.asset(muscleIcons[muscle]!, color: elementColor, width: 20, height: 20, fit: BoxFit.cover,),
//                                               );
//                                             }).toList(),
//                                           ),
//                                         ),
//                                         const SizedBox(height: 2,),
//                                         Text(exerciseWeek[index].take(3).join(' • '), maxLines: 1,overflow: TextOverflow.ellipsis, style: TextTheme.of(context).bodyMedium!.copyWith(color: greyOne, fontWeight: FontWeight.w500))
//                                       ],
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 5,),

//                           // ปุ่มกดดูรายละเอียด
//                           GestureDetector(
//                             onTap: () {
//                               if (isRestDay) {
//                                 Restdaydialog restdaydialog = Restdaydialog();
//                                 restdaydialog.showRestDayDialog(context);
//                                 return;
//                               }

//                               showModalBottomSheet(
//                                 context: context, 
//                                 isScrollControlled: true,
//                                 backgroundColor: Colors.transparent,
//                                 builder: (context) => ExerciseDetailButton(day: "วัน $day", exerciseStirng: exerciseWeek[index].join(' • '), exerciseList: exerciseList[day]!),
//                               );
//                             },
//                             child: Container(
//                               width: double.infinity,
//                               padding: EdgeInsets.symmetric(vertical: 6),
//                               decoration: BoxDecoration(
//                                 color: backgroundColor,
//                                 borderRadius: BorderRadius.circular(4),
//                                 border: Border.all(color: cardBgColor, width: 1)
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(Icons.info_outline, color: greyTwo, size: 18),
//                                   const SizedBox(width: 3),
//                                   Text('รายละเอียด', style: TextTheme.of(context).labelMedium!.copyWith(color: greyTwo, fontWeight: FontWeight.w600))
//                                 ],
//                               ),
//                             ),
//                           ),

//                           // ปุ่มกดเริ่มออกกำลังกาย
//                           if (!isRestDay) ...[
//                             const SizedBox(height: 6,),

//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(context, MaterialPageRoute(builder: (context) => ExercisePage(day: day, exercises: exerciseList[day]!)));
//                               },
//                               child: Container(
//                                 width: double.infinity,
//                                 padding: EdgeInsets.symmetric(vertical: 8),
//                                 decoration: BoxDecoration(
//                                   color: elementColor,
//                                   borderRadius: BorderRadius.circular(4),
//                                   boxShadow: [
//                                     BoxShadow(color: elementColor.withValues(alpha: 0.3), blurRadius: 3, offset: Offset(0, 1))
//                                   ],
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(Icons.play_arrow, color: Colors.white, size: 18),
//                                     const SizedBox(width: 3),
//                                     Text('เริ่ม', style: TextTheme.of(context).labelMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.3)),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }