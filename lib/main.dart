import 'package:calories_buddy/app.dart';
import 'package:calories_buddy/database/database_helper.dart';
import 'package:calories_buddy/database/services/exercise_db_manage.dart';
import 'package:calories_buddy/widgets/custom_widget.dart';
import 'package:flutter/material.dart';

void main() async {
  // เรียกฐานข้อมูลเพื่อสร้างและเพิ่มข้อมูลทดสอบ
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.initDb();
  //await ExerciseDbManage().deleteAllExercises();
  //await ExerciseDbManage().initializeExercises();

  runApp(
    App()
  );
}