import 'package:calories_buddy/blocs/exercise_bloc/exercise_bloc.dart';
import 'package:calories_buddy/blocs/exercise_bloc/exercise_event.dart';
import 'package:calories_buddy/database/services/exercise_db_manage.dart';
import 'package:calories_buddy/models/exercise_data_model.dart';
import 'package:calories_buddy/pages/add_edit_exercise_page.dart';
import 'package:calories_buddy/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseDetailPage extends StatefulWidget {
  final Exercise exercise;
  const ExerciseDetailPage({super.key, required this.exercise});

  @override
  // ignore: no_logic_in_create_state
  State<ExerciseDetailPage> createState() => _ExerciseDetailPageState(exercise: exercise);
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  final Exercise exercise;
  _ExerciseDetailPageState({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context, 'รายละเอียด', null, null),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(exercise.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.40,
                child: Text(exercise.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.white))
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditExercisePage(exercise: exercise))),
                child: Text("แก้ไขท่า", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () async {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('ท่านต้องการลบท่านี้หรือไม่?'),
                        content: Text(''),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('ตกลง'),
                            onPressed: () async {
                              loadingWidget(context);
                              await ExerciseDbManage().deleteExerciseById(exercise.id);

                              if (!context.mounted) return;
                              context.read<ExerciseBloc>().add(FetchExercises());

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('ลบข้อมูลเรียบร้อย'))
                              );
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: const Text('ยกเลิก'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }, 
                child: Text("ลบท่า", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500)),
              )
            ],
          ),
        ),
      ),
    );
  }
}