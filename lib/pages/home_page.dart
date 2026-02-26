import 'package:calories_buddy/contants/contants.dart';
import 'package:calories_buddy/contants/date_time_constants.dart';
import 'package:calories_buddy/contants/muscle_icons.dart';
import 'package:calories_buddy/models/exercise_data_model.dart';
import 'package:calories_buddy/pages/exercise_table_page.dart';
import 'package:calories_buddy/widgets/custom_widget.dart';
import 'package:calories_buddy/widgets/exercise_card_widget.dart';
import 'package:calories_buddy/widgets/home/exercise_box_title.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CustomWidget customWidget = CustomWidget();

  String userName = 'Admin Testawdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwd';
  String imageUrl = 'https://www.pngall.com/wp-content/uploads/5/Profile-PNG-High-Quality-Image.png';

  List<List<String>> exerciseWeek = [
    ['อก', 'หลัง'], ['หลัง', 'แขน', 'ไหล่'], ['พัก'], ['ขา', 'หน้าท้อง'], ['อก', 'หลัง'], ['หลัง', 'แขน', 'ไหล่'], ['พัก']
  ];
  final daysOrdered = List.generate(7, (index) {
    return DateTimeConstants.DAYS_CONSTANT[((DateTime.now().weekday - 1) + index) % 7];
  });

  Map<String, List<Exercise>> exerciseList = {
      'จ.': [
        Exercise(
          name: 'Bench Press', 
          description: 'วิธีการ: การตั้งท่าที่มั่นคง วางเท้าให้ราบกับพื้น หลังแนบม้านั่ง จับบาร์กว้างกว่าไหล่เล็กน้อย และล็อคข้อมือให้ตรง', 
          muscle: 'อก',
          sets: 4, 
          reps: 12, 
          image: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg', 
          images: ['https://cdn.mos.cms.futurecdn.net/v2/t:0,l:218,cw:563,ch:563,q:80,w:563/pLaRi5jXSHDKu6WRydetBo.jpg', 'https://images.ctfassets.net/8urtyqugdt2l/4wPk3KafRwgpwIcJzb0VRX/4894054c6182c62c1d850628935a4b0b/desktop-best-chest-exercises.jpg'], 
          video: 'https://www.youtube.com/watch?v=AJFf4ATImPA'
        ),
        Exercise(
          name: 'Cable Fly',
          description: 'วิธีการ: กดด้ามจับสายเคเบิลให้มาอยู่ด้านหน้าหน้าอก โดยยืดแขนออกและให้ฝ่ามือหันเข้าหากัน จากนั้นเริ่มทำซ้ำโดยช้าๆ ให้ด้ามจับเคลื่อนไปทางเครื่องสายเคเบิลเป็นทิศทางโค้ง',
          muscle: 'อก',
          sets: 4,
          reps: 12,
          image: 'https://liftmanual.com/wp-content/uploads/2023/04/cable-standing-fly.jpg',
          images: ['https://www.puregym.com/media/0c2ijzzq/cable-chest-flyes.jpg?quality=80', 'https://the-optimal-you.com/wp-content/uploads/2018/01/Cable-Fly.jpg'],
          video: 'assets/videos/chest_press.mp4'
        ),
      ],
      'อ.': [
        Exercise(
          name: 'Pull Up',
          description: 'วิธีการ: ห้อยตัวบนบาร์ ดึงตัวขึ้นจนคางเกินบาร์',
          muscle: 'หลัง',
          sets: 3,
          reps: 8,
          image: 'https://anabolicaliens.com/cdn/shop/articles/199990_400x.png?v=1645089103',
          images: ['https://liftmanual.com/wp-content/uploads/2023/04/reverse-grip-pull-up.jpg', 'https://rockrun.com/cdn/shop/articles/859664_1600x.jpg?v=1585560306'],
          video: 'assets/videos/pullup.mp4'
        ),
        Exercise(
          name: 'T Bar Row',
          description: 'วิธีการ: ยืนคร่อมบาร์ ก้มตัวลงเล็กน้อย และใช้มือทั้งสองข้างจับที่ปลายบาร์ จากนั้นยกน้ำหนักขึ้นโดยดึงบาร์เข้าหาลำตัว',
          muscle: 'หลัง',
          sets: 3,
          reps: 12,
          image: 'https://www.shutterstock.com/image-illustration/lever-tbar-row-plate-loaded-260nw-622379585.jpg',
          images: ['https://watsongym.co.uk/wp-content/uploads/2023/03/DSC09119.jpg', 'https://cdn.shopify.com/s/files/1/0618/9462/3460/files/istockphoto-532792113-612x612-1.jpg'],
          video: 'assets/videos/bent_row.mp4'
        )
      ],
      'พ.': [
        Exercise(
          name: 'Bicep Curl',
          description: 'วิธีการ: ยกดัมเบลขึ้นลงด้วยกล้ามเนื้อต้นแขน',
          muscle: 'แขน',
          sets: 3,
          reps: 15,
          image: 'assets/images/exercises/bicep_curl.jpg',
          images: ['https://www.shutterstock.com/image-illustration/dumbbell-biceps-curl-upper-arms-600nw-2327162897.jpg', 'https://i0.wp.com/www.muscleandfitness.com/wp-content/uploads/2017/11/1109-hammer-curl.jpg?quality=86&strip=all'],
          video: 'assets/videos/bicep_curl.mp4'
        ),
        Exercise(
          name: 'Tricep Dip',
          description: 'วิธีการ: วางมือบนเก้าอี้ ลดตัวลงแล้วดันขึ้น',
          muscle: 'แขน',
          sets: 3,
          reps: 12,
          image: 'assets/images/exercises/tricep_dip.jpg',
          images: ['https://images.squarespace-cdn.com/content/v1/5ffcea9416aee143500ea103/1638261887966-89KVMRDCF0WGGE7CH5YV/Assisted%2BTriceps%2BDips.jpeg', 'https://liftmanual.com/wp-content/uploads/2023/04/dumbbell-standing-triceps-extension.jpg', 'https://images.squarespace-cdn.com/content/v1/5ffcea9416aee143500ea103/1638260103209-NCDPK0RI94MTSL5YWMZM/One%2BArm%2BOverhead%2BStanding%2BTriceps%2BExtensions.jpeg'],
          video: 'assets/videos/tricep_dip.mp4'
        )
      ],
      'พฤ.': [
        Exercise(
          name: 'Lateral Dumbbell Raise',
          description: 'วิธีการ: ยกดัมเบลขึ้นเหนือศีรษะ',
          muscle: 'ไหล่',
          sets: 3,
          reps: 12,
          image: 'assets/images/exercises/shoulder_press.jpg',
          images: ['https://kinxlearning.com/cdn/shop/files/exercise-32_1000x.jpg?v=1613157925', 'https://cdn.muscleandstrength.com/sites/default/files/one-arm-seated-dumbbell-lateral-raise.jpg'],
          video: 'assets/videos/shoulder_press.mp4'
        )
      ],
      'ศ.': [
        Exercise(
          name: 'Squat',
          description: 'วิธีการ: ยืนตรง นั่งลงแล้วลุกขึ้น',
          muscle: 'ขา',
          sets: 3,
          reps: 20,
          image: 'assets/images/exercises/squat.jpg',
          images: ['https://t4.ftcdn.net/jpg/00/89/03/89/360_F_89038937_M6GCms3m25qJyFuLRzudxCOSO6vc8BOK.jpg', 'https://hips.hearstapps.com/hmg-prod/images/man-training-with-weights-royalty-free-image-1718637105.jpg?crop=0.670xw:1.00xh;0.138xw,0&resize=1200:*'],
          video: 'assets/videos/squat.mp4'
        ),
        Exercise(
          name: 'Lunges',
          description: 'วิธีการ: ก้าวขาไปข้างหน้าแล้วลงลึก',
          muscle: 'ขา',
          sets: 3,
          reps: 15,
          image: 'assets/images/exercises/lunges.jpg',
          images: ['https://kinxlearning.com/cdn/shop/files/exercise-14_1000x.jpg?v=1613154730', 'https://images.ctfassets.net/8urtyqugdt2l/4wPk3KafRwgpwIcJzb0VRX/4894054c6182c62c1d850628935a4b0b/desktop-best-chest-exercises.jpg'],
          video: 'assets/videos/lunges.mp4'
        )
      ],
      'ส.': [
        Exercise(
          name: 'Sit Up',
          description: 'วิธีการ: นอนหงาย งอเข่า ลุกขึ้นด้วยกล้ามเนื้อหน้าท้อง',
          muscle: 'หน้าท้อง',
          sets: 3,
          reps: 25,
          image: 'assets/images/exercises/situp.jpg',
          images: ['https://kinxlearning.com/cdn/shop/files/exercise-18_1000x.jpg?v=1613154703', 'https://images.ctfassets.net/8urtyqugdt2l/4wPk3KafRwgpwIcJzb0VRX/4894054c6182c62c1d850628935a4b0b/desktop-best-chest-exercises.jpg'],
          video: 'assets/videos/situp.mp4'
        ),
        Exercise(
          name: 'Plank',
          description: 'วิธีการ: ค้ำตัวด้วยข้อศอกและปลายเท้า (วินาที)',
          muscle: 'หน้าท้อง',
          sets: 3,
          reps: 60,
          image: 'assets/images/exercises/plank.jpg',
          images: ['https://cdn.mos.cms.futurecdn.net/v2/t:0,l:218,cw:563,ch:563,q:80,w:563/pLaRi5jXSHDKu6WRydetBo.jpg', 'https://images.ctfassets.net/8urtyqugdt2l/4wPk3KafRwgpwIcJzb0VRX/4894054c6182c62c1d850628935a4b0b/desktop-best-chest-exercises.jpg'],
          video: 'assets/videos/plank.mp4'
        )
      ],
      'อา.': [
        Exercise(
          name: 'Sit Up',
          description: 'วิธีการ: นอนหงาย งอเข่า ลุกขึ้นด้วยกล้ามเนื้อหน้าท้อง',
          muscle: 'หน้าท้อง',
          sets: 3,
          reps: 25,
          image: 'assets/images/exercises/situp.jpg',
          images: ['https://kinxlearning.com/cdn/shop/files/exercise-18_1000x.jpg?v=1613154703', 'https://images.ctfassets.net/8urtyqugdt2l/4wPk3KafRwgpwIcJzb0VRX/4894054c6182c62c1d850628935a4b0b/desktop-best-chest-exercises.jpg'],
          video: 'assets/videos/situp.mp4'
        ),
        Exercise(
          name: 'Plank',
          description: 'วิธีการ: ค้ำตัวด้วยข้อศอกและปลายเท้า (วินาที)',
          muscle: 'หน้าท้อง',
          sets: 3,
          reps: 60,
          image: 'assets/images/exercises/plank.jpg',
          images: ['https://cdn.mos.cms.futurecdn.net/v2/t:0,l:218,cw:563,ch:563,q:80,w:563/pLaRi5jXSHDKu6WRydetBo.jpg', 'https://images.ctfassets.net/8urtyqugdt2l/4wPk3KafRwgpwIcJzb0VRX/4894054c6182c62c1d850628935a4b0b/desktop-best-chest-exercises.jpg'],
          video: 'assets/videos/plank.mp4'
        )
      ]
    };

  @override
  Widget build(BuildContext context) {
    final exerciseOrdered = List.generate(7, (index) {
      return exerciseWeek[((DateTime.now().weekday - 1) + index) % 7];
    });
  
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbarUser(userName: userName, imageUrl: imageUrl),
              
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    customWidget.titleExpand(context, 'ตารางออกกำลังกาย', ExerciseTablePage(exerciseWeek: exerciseWeek)),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: List.generate(7, (index) {
                            final isRestDay = exerciseOrdered[index].contains('พัก');
                            final isToday = index == 0;
                
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
                                    child: ExerciseBoxTitle(day: daysOrdered[index], isToday: isToday, isRestDay: isRestDay),
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
                                            children: exerciseOrdered[index].map((muscle) {
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
                          }),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    Text('ออกกำลังกายรายสัปดาห์', style: TextTheme.of(context).headlineSmall!.copyWith(color: Colors.white),),
                    const SizedBox(height: 12),
                
                    Column(
                      children: List.generate(7, (index) {
                        final day = daysOrdered[index];
                        final isRestDay = exerciseOrdered[index].contains('พัก');
                        final isToday = index == 0;
                
                        return weeklySection(day, isToday, isRestDay);
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget weeklySection(String day, bool isToday, bool isRestDay) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: isToday ? [Colors.blue.shade500, Colors.blue.shade700] : [Colors.grey.shade800, Colors.grey.shade900]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ExerciseBoxTitle(day: day, isToday: isToday, isRestDay: isRestDay)
        ),

        if (!isRestDay) ...exerciseList[day]!.map((e) => exerciseBox(context, e)),
      ],
    );


  Widget exerciseBox(BuildContext context, Exercise exercise) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color:  Colors.white.withValues(alpha: 0.1), width: 1),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.3), spreadRadius: 0, blurRadius: 8, offset: Offset(0, 2))
        ],
      ),
      child: Stack(
        children: [
          exerciseImage(exercise.image),

          Positioned(
            top: 0,
            left: 80,
            child: Text(exercise.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          ),

          Positioned(
            top: 30,
            left: 80,
            child: exerciseSetsReps(context, '${exercise.sets} เซ็ต x ${exercise.reps} ${exercise.name == 'Plank' ? 'วินาที' : 'ครั้ง'}'),
          ),

          Positioned(
            right: 10,
            bottom: 10,
            child: exerciseMuscleGroup(context, exercise.muscle)
          ),

          Positioned(
            top: 0,
            right: 10,
            child: InkWell(
              onTap: () {
                setState(() {
                  exercise.isCompleted = !exercise.isCompleted;
                });
              },
              child: Container(
                height: 26,
                width: 26,
                decoration: BoxDecoration(
                  color: exercise.isCompleted ? Colors.green : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: exercise.isCompleted ? Colors.green : Colors.white54, width: 2),
                ),
                child: exercise.isCompleted ? const Icon(Icons.check, size: 18, color: Colors.white) : null
              ),
            ),
          ),
        ],
      ),
    );
  }
}