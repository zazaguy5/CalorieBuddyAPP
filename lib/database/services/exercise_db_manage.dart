import 'package:calories_buddy/database/database_helper.dart';
import 'package:calories_buddy/models/exercise_data_model.dart';

class ExerciseDbManage {
  Future<List<Map<String, dynamic>>> getAllExercises() async {
    final db = await DatabaseHelper.instance.db;
    return await db.query('exercises');
  }

  Future<List<Map<String, dynamic>>> getDayExercises(String day) async {
    final db = await DatabaseHelper.instance.db;
    return await db.query('exercises', where: 'day = ?', whereArgs: [day]);
  }

  Future<void> deleteAllExercises() async {
    final db = await DatabaseHelper.instance.db;
    await db.delete('exercises');
  }

  Future<void> deleteExerciseById(String id) async {
    final db = await DatabaseHelper.instance.db;
    await db.delete('exercises', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertExercise(Exercise exercise) async {
    final db = await DatabaseHelper.instance.db;
    return await db.insert('exercises', exercise.toMap());
  }

  Future<void> initializeExercises() async {
    List<Exercise> exercises = [
      Exercise(
        name: 'Bench Press', 
        description: 'วิธีการ: การตั้งท่าที่มั่นคง วางเท้าให้ราบกับพื้น หลังแนบม้านั่ง จับบาร์กว้างกว่าไหล่เล็กน้อย และล็อคข้อมือให้ตรง', 
        muscle: 'อก',
        sets: 4, 
        reps: 12, 
        day: "จ.",
        image: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg', 
        images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg', 
        video: 'https://www.youtube.com/watch?v=AJFf4ATImPA'
      ),
      Exercise(
        name: 'Cable Fly',
        description: 'วิธีการ: กดด้ามจับสายเคเบิลให้มาอยู่ด้านหน้าหน้าอก โดยยืดแขนออกและให้ฝ่ามือหันเข้าหากัน จากนั้นเริ่มทำซ้ำโดยช้าๆ ให้ด้ามจับเคลื่อนไปทางเครื่องสายเคเบิลเป็นทิศทางโค้ง',
        muscle: 'อก',
        sets: 4,
        reps: 12,
        day: "จ.",
        image: 'https://liftmanual.com/wp-content/uploads/2023/04/cable-standing-fly.jpg',
        images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
        video: 'assets/videos/chest_press.mp4'
      ),
      Exercise(
        name: 'Pull Up',
        description: 'วิธีการ: ห้อยตัวบนบาร์ ดึงตัวขึ้นจนคางเกินบาร์',
        muscle: 'หลัง',
        sets: 3,
        reps: 8,
        day: "อ.",
        image: 'https://anabolicaliens.com/cdn/shop/articles/199990_400x.png?v=1645089103',
        images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
        video: 'assets/videos/pullup.mp4'
      ),
      Exercise(
        name: 'T Bar Row',
        description: 'วิธีการ: ยืนคร่อมบาร์ ก้มตัวลงเล็กน้อย และใช้มือทั้งสองข้างจับที่ปลายบาร์ จากนั้นยกน้ำหนักขึ้นโดยดึงบาร์เข้าหาลำตัว',
        muscle: 'หลัง',
        sets: 3,
        reps: 12,
        day: "อ.",
        image: 'https://www.shutterstock.com/image-illustration/lever-tbar-row-plate-loaded-260nw-622379585.jpg',
        images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
        video: 'assets/videos/bent_row.mp4'
      ),
      Exercise(
        name: 'Bicep Curl',
        description: 'วิธีการ: ยกดัมเบลขึ้นลงด้วยกล้ามเนื้อต้นแขน',
        muscle: 'แขน',
        sets: 3,
        reps: 15,
        day: "พ.",
        image: 'assets/images/exercises/bicep_curl.jpg',
        images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
        video: 'assets/videos/bicep_curl.mp4'
      ),
      Exercise(
        name: 'Tricep Dip',
        description: 'วิธีการ: วางมือบนเก้าอี้ ลดตัวลงแล้วดันขึ้น',
        muscle: 'แขน',
        sets: 3,
        reps: 12,
        day: "พ.",
        image: 'assets/images/exercises/tricep_dip.jpg',
        images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
        video: 'assets/videos/tricep_dip.mp4'
      ),
      Exercise(
        name: 'Lateral Dumbbell Raise',
        description: 'วิธีการ: ยกดัมเบลขึ้นเหนือศีรษะ',
        muscle: 'ไหล่',
        sets: 3,
        reps: 12,
        day: "พฤ.",
        image: 'assets/images/exercises/shoulder_press.jpg',
        images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
        video: 'assets/videos/shoulder_press.mp4'
      ),
      Exercise(
        name: 'Squat',
        description: 'วิธีการ: ยืนตรง นั่งลงแล้วลุกขึ้น',
        muscle: 'ขา',
        sets: 3,
        reps: 20,
        day: "ศ.",
        image: 'assets/images/exercises/squat.jpg',
        images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
        video: 'assets/videos/squat.mp4'
      ),
      Exercise(
        name: 'Lunges',
        description: 'วิธีการ: ก้าวขาไปข้างหน้าแล้วลงลึก',
        muscle: 'ขา',
        sets: 3,
        reps: 15,
        day: "ศ.",
        image: 'assets/images/exercises/lunges.jpg',
        images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
        video: 'assets/videos/lunges.mp4'
      ),
      Exercise(
        name: 'Sit Up',
        description: 'วิธีการ: นอนหงาย งอเข่า ลุกขึ้นด้วยกล้ามเนื้อหน้าท้อง',
        muscle: 'หน้าท้อง',
        sets: 3,
        reps: 25,
        day: "ส.",
        image: 'assets/images/exercises/situp.jpg',
        images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
        video: 'assets/videos/situp.mp4'
      ),
      Exercise(
        name: 'Plank',
        description: 'วิธีการ: ค้ำตัวด้วยข้อศอกและปลายเท้า (วินาที)',
        muscle: 'หน้าท้อง',
        sets: 3,
        reps: 60,
        day: "ส.",
        image: 'assets/images/exercises/plank.jpg',
        images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
        video: 'assets/videos/plank.mp4'
      ),
      Exercise(
        name: 'Sit Up',
        description: 'วิธีการ: นอนหงาย งอเข่า ลุกขึ้นด้วยกล้ามเนื้อหน้าท้อง',
        muscle: 'หน้าท้อง',
        sets: 3,
        reps: 25,
        day: "อา.",
        image: 'assets/images/exercises/situp.jpg',
        images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
        video: 'assets/videos/situp.mp4'
      ),
      Exercise(
        name: 'Plank',
        description: 'วิธีการ: ค้ำตัวด้วยข้อศอกและปลายเท้า (วินาที)',
        muscle: 'หน้าท้อง',
        sets: 3,
        reps: 60,
        day: "อา.",
        image: 'assets/images/exercises/plank.jpg',
        images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg',
        video: 'assets/videos/plank.mp4'
      )
    ];
    for (var exercise in exercises) {
      await insertExercise(exercise);
    }
  }
}