import 'package:calories_buddy/app.dart';
import 'package:calories_buddy/blocs/exercise_bloc/exercise_bloc.dart';
import 'package:calories_buddy/blocs/exercise_bloc/exercise_event.dart';
import 'package:calories_buddy/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  // เรียกฐานข้อมูลเพื่อสร้างและเพิ่มข้อมูลทดสอบ
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.initDb();
  //await ExerciseDbManage().deleteAllExercises();
  //await ExerciseDbManage().initializeExercises();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ExerciseBloc()..add(FetchExercises())),
      ], 
      child: App(),
    ),
  );
}