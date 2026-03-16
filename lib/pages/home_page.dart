// import 'package:calories_buddy/contants/contants.dart';
// import 'package:calories_buddy/contants/date_time_constants.dart';
// import 'package:calories_buddy/contants/muscle_icons.dart';
// import 'package:calories_buddy/models/exercise_data_model.dart';
// import 'package:calories_buddy/pages/exercise_table_page.dart';
// import 'package:calories_buddy/widgets/custom_widget.dart';
// import 'package:calories_buddy/widgets/exercise_card_widget.dart';
// import 'package:calories_buddy/widgets/home/exercise_box_title.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   CustomWidget customWidget = CustomWidget();

//   String userName = 'Admin Testawdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwd';
//   String imageUrl = 'https://www.pngall.com/wp-content/uploads/5/Profile-PNG-High-Quality-Image.png';

//   List<List<String>> exerciseWeek = [
//     ['อก', 'หลัง'], ['หลัง', 'แขน', 'ไหล่'], ['พัก'], ['ขา', 'หน้าท้อง'], ['อก', 'หลัง'], ['หลัง', 'แขน', 'ไหล่'], ['พัก']
//   ];
//   final daysOrdered = List.generate(7, (index) {
//     return DateTimeConstants.DAYS_CONSTANT[((DateTime.now().weekday - 1) + index) % 7];
//   });

//   Map<String, List<Exercise>> exerciseList = {
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
//           images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
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
//           images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
//           video: 'assets/videos/pullup.mp4'
//         ),
//         Exercise(
//           name: 'T Bar Row',
//           description: 'วิธีการ: ยืนคร่อมบาร์ ก้มตัวลงเล็กน้อย และใช้มือทั้งสองข้างจับที่ปลายบาร์ จากนั้นยกน้ำหนักขึ้นโดยดึงบาร์เข้าหาลำตัว',
//           muscle: 'หลัง',
//           sets: 3,
//           reps: 12,
//           image: 'https://www.shutterstock.com/image-illustration/lever-tbar-row-plate-loaded-260nw-622379585.jpg',
//           images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
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
//           images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
//           video: 'assets/videos/bicep_curl.mp4'
//         ),
//         Exercise(
//           name: 'Tricep Dip',
//           description: 'วิธีการ: วางมือบนเก้าอี้ ลดตัวลงแล้วดันขึ้น',
//           muscle: 'แขน',
//           sets: 3,
//           reps: 12,
//           image: 'assets/images/exercises/tricep_dip.jpg',
//           images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
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
//           images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
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
//           images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
//           video: 'assets/videos/squat.mp4'
//         ),
//         Exercise(
//           name: 'Lunges',
//           description: 'วิธีการ: ก้าวขาไปข้างหน้าแล้วลงลึก',
//           muscle: 'ขา',
//           sets: 3,
//           reps: 15,
//           image: 'assets/images/exercises/lunges.jpg',
//           images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
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
//           images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
//           video: 'assets/videos/situp.mp4'
//         ),
//         Exercise(
//           name: 'Plank',
//           description: 'วิธีการ: ค้ำตัวด้วยข้อศอกและปลายเท้า (วินาที)',
//           muscle: 'หน้าท้อง',
//           sets: 3,
//           reps: 60,
//           image: 'assets/images/exercises/plank.jpg',
//           images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
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
//           images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
//           video: 'assets/videos/situp.mp4'
//         ),
//         Exercise(
//           name: 'Plank',
//           description: 'วิธีการ: ค้ำตัวด้วยข้อศอกและปลายเท้า (วินาที)',
//           muscle: 'หน้าท้อง',
//           sets: 3,
//           reps: 60,
//           image: 'assets/images/exercises/plank.jpg',
//           images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
//           video: 'assets/videos/plank.mp4'
//         )
//       ]
//     };

//   @override
//   Widget build(BuildContext context) {
//     final exerciseOrdered = List.generate(7, (index) {
//       return exerciseWeek[((DateTime.now().weekday - 1) + index) % 7];
//     });
  
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomAppbarUser(userName: userName, imageUrl: imageUrl),
              
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     customWidget.titleExpand(context, 'ตารางออกกำลังกาย', ExerciseTablePage(exerciseWeek: exerciseWeek)),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         child: Row(
//                           children: List.generate(7, (index) {
//                             final isRestDay = exerciseOrdered[index].contains('พัก');
//                             final isToday = index == 0;
                
//                             return Container(
//                               width: 150,
//                               padding: const EdgeInsets.symmetric(horizontal: 8),
//                               child: Column(
//                                 children: [
//                                   // ส่วนหัวแสดงวัน
//                                   Container(
//                                     padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
//                                     decoration: BoxDecoration(
//                                       color: isToday ? Colors.blue.shade700 : Colors.grey.shade800,
//                                       borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
//                                     ),
//                                     child: ExerciseBoxTitle(day: daysOrdered[index], isToday: isToday, isRestDay: isRestDay),
//                                   ),
                
//                                   // ส่วนแสดงเนื้อหา ตารางออกกำลังกาย
//                                   Container(
//                                     height: 180,
//                                     width: 150,
//                                     padding: const EdgeInsets.all(15),
//                                     decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                         begin: Alignment.topCenter,
//                                         end: Alignment.bottomCenter,
//                                         colors: isRestDay? [Colors.grey.shade500, Colors.grey.shade600] : isToday? [Colors.blue.shade500, Colors.blue.shade700] : [Colors.grey.shade700, Colors.grey.shade900],
//                                       ),
//                                       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
//                                       boxShadow: [BoxShadow(color: isToday ? Colors.blue.withValues(alpha: 0.5) : Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
//                                     ),
//                                     child: isRestDay ? Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                           padding: EdgeInsets.all(12),
//                                           decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
//                                           child: Icon(Icons.self_improvement, size: 42, color: Colors.white),
//                                         ),
//                                         const SizedBox(height: 10),
//                                         Text('พักผ่อน', style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.w500, color: Colors.white)),
//                                       ],
//                                     ) : Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text('กลุ่มกล้ามเนื้อ', style: TextTheme.of(context).titleSmall!.copyWith(fontWeight: FontWeight.w500, color: Colors.white70)),
//                                         const SizedBox(height: 12),
//                                         Expanded(
//                                           child: GridView.count(
//                                             crossAxisCount: 2,
//                                             mainAxisSpacing: 8,
//                                             crossAxisSpacing: 8,
//                                             padding: EdgeInsets.zero,
//                                             shrinkWrap: true,
//                                             physics: NeverScrollableScrollPhysics(),
//                                             children: exerciseOrdered[index].map((muscle) {
//                                               return Container(
//                                                 decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
//                                                 child: Column(
//                                                   mainAxisAlignment: MainAxisAlignment.center,
//                                                   children: [
//                                                     Image.asset(muscleIcons[muscle]!, height: 28, width: 28, color: isToday? Colors.white : elementColor),
//                                                     const SizedBox(height: 4),
//                                                     Text(muscle, style: TextTheme.of(context).labelMedium!.copyWith(fontWeight: FontWeight.w500, color: Colors.white), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
//                                                   ],
//                                                 ),
//                                               );
//                                             }).toList(),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
                    
//                     Text('ออกกำลังกายรายสัปดาห์', style: TextTheme.of(context).headlineSmall!.copyWith(color: Colors.white),),
//                     const SizedBox(height: 12),
                
//                     Column(
//                       children: List.generate(7, (index) {
//                         final day = daysOrdered[index];
//                         final isRestDay = exerciseOrdered[index].contains('พัก');
//                         final isToday = index == 0;
                
//                         return weeklySection(day, isToday, isRestDay);
//                       }),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget weeklySection(String day, bool isToday, bool isRestDay) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: double.infinity,
//           margin: const EdgeInsets.symmetric(vertical: 12),
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(colors: isToday ? [Colors.blue.shade500, Colors.blue.shade700] : [Colors.grey.shade800, Colors.grey.shade900]),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: ExerciseBoxTitle(day: day, isToday: isToday, isRestDay: isRestDay)
//         ),

//         if (!isRestDay) ...exerciseList[day]!.map((e) => exerciseBox(context, e)),
//       ],
//     );
//   }
// }