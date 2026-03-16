import 'package:calories_buddy/contants/contants.dart';
import 'package:calories_buddy/database/services/exercise_db_manage.dart';
import 'package:calories_buddy/models/exercise_data_model.dart';
import 'package:calories_buddy/widgets/custom_widget.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<Exercise> exercises = [];
  CustomWidget customWidget = CustomWidget();

  @override
  void initState() {
    super.initState();
    fetchExercises();
  }
  
  void fetchExercises() async {
    List data = await ExerciseDbManage().getAllExercises();
    setState(() {
      exercises = data.map((exercise) => Exercise.fromMap(exercise)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customWidget.appBarCustom(context, "ท่าออกกำลังกาย", null, null),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            for (var exercise in exercises)
              Container(
                width: double.infinity,
                height: 150,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: cardBgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color:  Colors.white.withValues(alpha: 0.1), width: 1),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.3), spreadRadius: 0, blurRadius: 8, offset: Offset(0, 2))
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.network(
                        exercise.image, 
                        height: 100, 
                        width: 150,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/images/no-image.jpg", height: 100, width: 80);
                        }
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(exercise.name, style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.40,
                            child: Text(exercise.description, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.white))
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

            const SizedBox(height: 20),
            TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddExercisePage())), child: Text('เพิ่มท่า', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    );
  }
}

class AddExercisePage extends StatefulWidget {
  const AddExercisePage({super.key});

  @override
  State<AddExercisePage> createState() => _AddExercisePageState();
}

class _AddExercisePageState extends State<AddExercisePage> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Exercise'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formStateKey,
          child: Column(
            children: [
              Text('Name', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกชื่อท่า';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Text('Description', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกคำอธิบายท่า';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextButton(onPressed: () async {
                if (_formStateKey.currentState!.validate()) {
                  CustomWidget().loadingWidget(context);

                  // ถ้าข้อมูลถูกต้อง ให้ทำการบันทึกข้อมูล
                  Exercise newExercise = Exercise(
                    name: nameController.text,
                    description: descriptionController.text,
                    muscle: 'อก',
                    sets: 4,
                    reps: 10,
                    day: 'จ.',
                    image: '',
                    images: '',
                    video: ''
                  );
                  await ExerciseDbManage().insertExercise(newExercise);

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('บันทึกข้อมูลเรียบร้อย'))
                  );
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else {
                  showDialog(context: context, builder: (context) => AlertDialog(
                    title: Text('ข้อมูลไม่ถูกต้อง'),
                    content: Text('กรุณาตรวจสอบข้อมูลให้ถูกต้อง'),
                    actions: [
                      TextButton(onPressed: () { Navigator.pop(context); }, child: Text('ตกลง', style: TextStyle(fontSize: 18, color: Colors.white))),
                    ],
                  ));
                }
              }, child: Text('บันทึก', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold))),
            ],
          ),
        ),
      ),
    );
  }
}