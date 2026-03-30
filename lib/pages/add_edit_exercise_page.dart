import 'dart:io';

import 'package:calories_buddy/blocs/exercise_bloc/exercise_bloc.dart';
import 'package:calories_buddy/blocs/exercise_bloc/exercise_event.dart';
import 'package:calories_buddy/contants/contants.dart';
import 'package:calories_buddy/contants/date_time_constants.dart';
import 'package:calories_buddy/database/services/exercise_db_manage.dart';
import 'package:calories_buddy/models/exercise_data_model.dart';
import 'package:calories_buddy/widgets/custom_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class AddEditExercisePage extends StatefulWidget {
  final bool isAdd;
  final Exercise? exercise;
  const AddEditExercisePage({super.key, this.exercise, required this.isAdd});

  @override
  // ignore: no_logic_in_create_state
  State<AddEditExercisePage> createState() => _AddEditExercisePageState(exercise: exercise, isAdd: isAdd);
}

class _AddEditExercisePageState extends State<AddEditExercisePage> {
  final bool isAdd;
  final Exercise? exercise;
  _AddEditExercisePageState({this.exercise, required this.isAdd});
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController setsController = TextEditingController();
  final TextEditingController repsController = TextEditingController();
  String selectDay = 'จ.';
  String selectMucle = 'อก';

  final ImagePicker imagePicker = ImagePicker();
  XFile? selectImage;

  @override
  void initState() {
    super.initState();
    if (exercise != null) {
      initExercise();
    }
  }

  void initExercise() {
    nameController.text = exercise!.name;
    descriptionController.text = exercise!.description;
    setsController.text = exercise!.sets.toString();
    repsController.text = exercise!.reps.toString();
    selectDay = exercise!.day;
    selectMucle = exercise!.muscle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context, 'เพิ่มท่าออกกำลังกาย', null, null),
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

              const SizedBox(height: 10),
              Text('Sets', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: setsController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกจำนวนเซ็ต';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              Text('Reps', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: repsController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกจำนวนครั้ง';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              DropdownButton(
                value: selectDay,
                onChanged: (value) {
                  setState(() {
                    selectDay = value.toString();
                  });
                },
                style: TextStyle(color: Colors.grey),
                items: DateTimeConstants.DAYS_CONSTANT.map((value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
              ),
              const SizedBox(height: 20),

              DropdownButton(
                value: selectMucle,
                onChanged: (value) {
                  setState(() {
                    selectMucle = value.toString();
                  });
                },
                style: TextStyle(color: Colors.grey),
                items: exerciseContant.map((value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      selectImage = await imagePicker.pickImage(source: ImageSource.gallery);
                      setState(() {});
                    },
                    icon: Icon(Icons.photo_camera, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: () async {
                      selectImage = await imagePicker.pickImage(source: ImageSource.camera);
                      setState(() {});
                    },
                    icon: Icon(Icons.photo_camera, color: Colors.white, size: 30),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              selectImage != null ? Image.file(
                File(selectImage!.path),
                width: 100,
                height: 100,
              ) : Container(
                width: 100,
                height: 100,
                color: Colors.grey,
                child: Icon(Icons.image, color: Colors.white, size: 30),
              ),
              const SizedBox(height: 20),

              const SizedBox(height: 20),

              TextButton(onPressed: () async {
                if (_formStateKey.currentState!.validate()) {
                  loadingWidget(context);

                  if (isAdd) {
                    // ถ้าข้อมูลถูกต้อง ให้ทำการบันทึกข้อมูล
                    int lastedId = await ExerciseDbManage().getExericseLastedId();
                    //print('lastedId is: $lastedId');
                    Exercise newExercise = Exercise(
                      id: lastedId + 1,
                      name: nameController.text,
                      description: descriptionController.text,
                      muscle: selectMucle,
                      sets: int.parse(setsController.value.text),
                      reps: int.parse(repsController.value.text),
                      day: selectDay,
                      image: selectImage != null ? selectImage!.path : '',
                      images: '',
                      video: ''
                    );
                    await ExerciseDbManage().insertExercise(newExercise);
                  } else {
                    Exercise editExercise = Exercise(
                      id: exercise!.id,
                      name: nameController.text,
                      description: descriptionController.text,
                      muscle: selectMucle,
                      sets: int.parse(setsController.value.text),
                      reps: int.parse(repsController.value.text),
                      day: selectDay,
                      image: selectImage != null ? selectImage!.path : '',
                      images: '',
                      video: ''
                    );
                    await ExerciseDbManage().editExercise(editExercise);
                  }

                  if (!context.mounted) return;
                  isAdd ? context.read<ExerciseBloc>().add(FetchExercises()) : context.read<ExerciseBloc>().add(FetchExerciseById(exercise!.id));

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