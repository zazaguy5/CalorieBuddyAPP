import 'dart:io';

import 'package:calories_buddy/blocs/exercise_bloc/exercise_bloc.dart';
import 'package:calories_buddy/blocs/exercise_bloc/exercise_event.dart';
import 'package:calories_buddy/blocs/exercise_bloc/exercise_state.dart';
import 'package:calories_buddy/contants/contants.dart';
import 'package:calories_buddy/contants/muscle_icons.dart';
import 'package:calories_buddy/database/services/exercise_db_manage.dart';
import 'package:calories_buddy/models/exercise_data_model.dart';
import 'package:calories_buddy/pages/add_edit_exercise_page.dart';
import 'package:calories_buddy/widgets/custom_widget.dart';
import 'package:calories_buddy/widgets/exercise_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseDetailPage extends StatefulWidget {
  final Exercise exercise;
  const ExerciseDetailPage({super.key, required this.exercise});

  @override
  State<ExerciseDetailPage> createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  late ExerciseBloc _exerciseBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _exerciseBloc = context.read<ExerciseBloc>();
  }

  @override
  void initState() {
    super.initState();
    context.read<ExerciseBloc>().add(FetchExerciseById(widget.exercise.id));
  }

  @override
  void dispose() {
    _exerciseBloc.add(FetchExercises());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context, 'รายละเอียด', null, null),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<ExerciseBloc, ExerciseState>(
            builder: (context, state) {
              if (state is ExerciseLoading) {
                return const CircularProgressIndicator();
              }
              if (state is ExerciseLoadError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              if (state is ExerciseDetailLoaded) {
                return Column(
                  children: [
                    Text(state.exercise.first.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Text(state.exercise.first.description, maxLines: 4, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.white))
                    ),
                    const SizedBox(height: 20),

                    Image.file(
                      File(state.exercise.first.image),
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(muscleIcons[state.exercise.first.muscle]!, height: 28, width: 28, color: elementColor),
                              const SizedBox(height: 4),
                              Text(state.exercise.first.muscle, style: TextTheme.of(context).labelMedium!.copyWith(fontWeight: FontWeight.w500, color: Colors.white), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                            ],
                          ),
                        ),

                        exerciseSetsReps(context, '${state.exercise.first.sets} เซ็ต x ${state.exercise.first.reps} ${state.exercise.first.name == 'Plank' ? 'วินาที' : 'ครั้ง'}'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditExercisePage(exercise: widget.exercise, isAdd: false))),
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
                                    await ExerciseDbManage().deleteExerciseById(widget.exercise.id);
                
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
                );
              }
              return SizedBox(); 
            }, 
          ),
        ),
      ),
    );
  }
}