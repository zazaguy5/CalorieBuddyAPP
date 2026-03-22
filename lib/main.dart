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

// import 'package:calories_buddy/contants/contants.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: true,
//       theme: ThemeData(
//         scaffoldBackgroundColor: Colors.grey.shade700, 
//         canvasColor: Colors.white
//       ), 
//       home: TestPage()
//     )
//   );
// }

// class Exercise {
//   final String name;
//   final String description;
//   final String muscle;
//   final int sets;
//   final int currentSet;
//   final int reps;
//   final int currentRep;
//   bool isCompleted;
//   String day;
//   final String image; // รูปหน้าปก
//   final String images; // รูปย่อย
//   final String video;

//   Exercise({
//     required this.name,
//     required this.description,
//     required this.muscle,
//     required this.sets,
//     this.currentSet = 0,
//     required this.reps,
//     this.currentRep = 0,
//     this.isCompleted = false,
//     required this.day,
//     required this.image,
//     required this.images,
//     required this.video,
//   });
// }

// class TestPage extends StatefulWidget {
//   const TestPage({super.key});

//   @override
//   State<TestPage> createState() => _TestPageState();
// }

// class _TestPageState extends State<TestPage> {
//   List<Exercise> exercises = [
//     Exercise(
//       name: 'Bench Press', 
//       description: 'วิธีการ: การตั้งท่าที่มั่นคง วางเท้าให้ราบกับพื้น หลังแนบม้านั่ง จับบาร์กว้างกว่าไหล่เล็กน้อย และล็อคข้อมือให้ตรง', 
//       muscle: 'อก',
//       sets: 4, 
//       reps: 12, 
//       day: "จ.",
//       image: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg', 
//       images: 'https://liftmanual.com/wp-content/uploads/2023/04/barbell-reverse-grip-bench-press.jpg', 
//       video: 'https://www.youtube.com/watch?v=AJFf4ATImPA'
//     ),
//     Exercise(
//       name: 'Cable Fly',
//       description: 'วิธีการ: กดด้ามจับสายเคเบิลให้มาอยู่ด้านหน้าหน้าอก โดยยืดแขนออกและให้ฝ่ามือหันเข้าหากัน จากนั้นเริ่มทำซ้ำโดยช้าๆ ให้ด้ามจับเคลื่อนไปทางเครื่องสายเคเบิลเป็นทิศทางโค้ง',
//       muscle: 'อก',
//       sets: 4,
//       reps: 12,
//       day: "จ.",
//       image: 'https://liftmanual.com/wp-content/uploads/2023/04/cable-standing-fly.jpg',
//       images: 'https://liftmanual.com/wp-content/uploads/2023/04/cable-standing-fly.jpg',
//       video: 'assets/videos/chest_press.mp4'
//     ),
//   ];
//   Map<String, String> muscleIcons = {
//     'อก': 'assets/images/muscles/chest.png',
//     'หลัง': 'assets/images/muscles/back.png',
//     'แขน': 'assets/images/muscles/arm.png',
//     'ไหล่': 'assets/images/muscles/chest.png',
//     'ขา': 'assets/images/muscles/leg.png',
//     'หน้าท้อง': 'assets/images/muscles/six-pack.png'
//   };


// }

// class AddExercisePage extends StatefulWidget {
//   const AddExercisePage({super.key});

//   @override
//   State<AddExercisePage> createState() => _AddExercisePageState();
// }

// class _AddExercisePageState extends State<AddExercisePage> {
//   final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController setsController = TextEditingController();
//   final TextEditingController repsController = TextEditingController();
//   String selectDay = 'จ.';
//   String selectMucle = 'อก';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Exercise'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Form(
//           key: _formStateKey,
//           child: Column(
//             children: [
//               Text('Name', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
//               TextFormField(
//                 controller: nameController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'กรุณากรอกชื่อท่า';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 10),
//               Text('Description', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
//               TextFormField(
//                 controller: descriptionController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'กรุณากรอกคำอธิบายท่า';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 10),
//               Text('Sets', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
//               TextFormField(
//                 controller: setsController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'กรุณากรอกจำนวนเซ็ต';
//                   }
//                   return null;
//                 },
//                 keyboardType: TextInputType.number,
//               ),
//               const SizedBox(height: 10),
//               Text('Reps', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
//               TextFormField(
//                 controller: repsController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'กรุณากรอกจำนวนครั้ง';
//                   }
//                   return null;
//                 },
//                 keyboardType: TextInputType.number,
//               ),
//               const SizedBox(height: 20),

//               DropdownButton(
//                 value: selectDay,
//                 onChanged: (value) {
//                   setState(() {
//                     selectDay = value.toString();
//                   });
//                 },
//                 style: TextStyle(color: Colors.grey),
//                 items: ['จ.', 'อ.', 'พ.', 'พฤ.', 'ศ.', 'ส', 'อา.'].map((value) {
//                   return DropdownMenuItem(value: value, child: Text(value));
//                 }).toList(),
//               ),
//               const SizedBox(height: 20),

//               DropdownButton(
//                 value: selectMucle,
//                 onChanged: (value) {
//                   setState(() {
//                     selectMucle = value.toString();
//                   });
//                 },
//                 style: TextStyle(color: Colors.grey),
//                 items: exerciseContant.map((value) {
//                   return DropdownMenuItem(value: value, child: Text(value));
//                 }).toList(),
//               ),
//               const SizedBox(height: 20),

//               TextButton(onPressed: () async {
//                 if (_formStateKey.currentState!.validate()) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('บันทึกข้อมูลเรียบร้อย'))
//                   );
//                   Navigator.pop(context);
//                 } else {
//                   showDialog(context: context, builder: (context) => AlertDialog(
//                     title: Text('ข้อมูลไม่ถูกต้อง'),
//                     content: Text('กรุณาตรวจสอบข้อมูลให้ถูกต้อง'),
//                     actions: [
//                       TextButton(onPressed: () { Navigator.pop(context); }, child: Text('ตกลง', style: TextStyle(fontSize: 18, color: Colors.white))),
//                     ],
//                   ));
//                 }
//               }, child: Text('บันทึก', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold))),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }