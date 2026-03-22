import 'package:calories_buddy/blocs/exercise_bloc/exercise_bloc.dart';
import 'package:calories_buddy/blocs/exercise_bloc/exercise_event.dart';
import 'package:calories_buddy/blocs/exercise_bloc/exercise_strate.dart';
import 'package:calories_buddy/contants/contants.dart';
import 'package:calories_buddy/contants/date_time_constants.dart';
import 'package:calories_buddy/contants/muscle_icons.dart';
import 'package:calories_buddy/database/services/exercise_db_manage.dart';
import 'package:calories_buddy/models/exercise_data_model.dart';
import 'package:calories_buddy/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseBloc, ExerciseState>(
      builder: (context, state) {
        if (state is ExerciseLoading) {
          return const CircularProgressIndicator();
        }
        if (state is ExerciseLoadError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        if (state is ExerciseLoaded) {
          return Scaffold(
            appBar: AppBar(centerTitle: true, backgroundColor: const Color.fromRGBO(46, 46, 46, 1), leading: Padding(
              padding: const EdgeInsets.only(left: 12),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 20,
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: null,
                ),
              ), title: Text('ท่าออกกำลังกาย', style: TextTheme.of(context).headlineSmall!.copyWith(color: Colors.white)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  for (var exercise in state.exercises)
                    Container(
                      width: double.infinity,
                      height: 185,
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(117, 117, 117, 1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color:  Colors.white.withValues(alpha: 0.1), width: 1),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.3), spreadRadius: 0, blurRadius: 8, offset: Offset(0, 2))
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Image.network(
                              exercise.image, 
                              height: 130, 
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
                                Text(exercise.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.40,
                                  child: Text(exercise.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.white))
                                ),
                                const SizedBox(height: 5),
                                Text("${exercise.sets} เซ็ต ${exercise.reps} ครั้ง", style: TextStyle(fontSize: 14, color: Colors.white)),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text('กล้ามเนื้อ${exercise.muscle}', style: TextTheme.of(context).bodyMedium!.copyWith(color: Colors.white70, fontWeight: FontWeight.w500)),
                                        const SizedBox(width: 4),
                                        Image.asset(muscleIcons[exercise.muscle]!, color:  Colors.white70, width: 20, height: 20, fit: BoxFit.cover),
                                      ],
                                    ),
                                    dayOfWeekBox(exercise.day)
                                  ],
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
        return const SizedBox();
      }
    );
  }

  Widget dayOfWeekBox(String title) {
    return Stack(
      children: [
        Container(
          width: 35,
          height: 40,
          decoration: BoxDecoration(color: Color.fromRGBO(255, 149, 79, 1), borderRadius: BorderRadius.circular(10)),
          child: Center(child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)))
        ),
        Container(
          width: 35,
          height: 15,
          decoration: BoxDecoration(color: Color.fromRGBO(247, 84, 69, 1), borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 2.5, height: 8,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))
              ),
              Container(width: 2.5, height: 8,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))
              ),
              Container(width: 2.5, height: 8,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))
              ),
            ],
          ),
        ),
      ],
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
  final TextEditingController setsController = TextEditingController();
  final TextEditingController repsController = TextEditingController();
  String selectDay = 'จ.';
  String selectMucle = 'อก';

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

              TextButton(onPressed: () async {
                if (_formStateKey.currentState!.validate()) {
                  loadingWidget(context);

                  // ถ้าข้อมูลถูกต้อง ให้ทำการบันทึกข้อมูล
                  Exercise newExercise = Exercise(
                    name: nameController.text,
                    description: descriptionController.text,
                    muscle: selectMucle,
                    sets: int.parse(setsController.value.text),
                    reps: int.parse(repsController.value.text),
                    day: selectDay,
                    image: '',
                    images: '',
                    video: ''
                  );
                  await ExerciseDbManage().insertExercise(newExercise);

                  if (!context.mounted) return;
                  context.read<ExerciseBloc>().add(FetchExercises());

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