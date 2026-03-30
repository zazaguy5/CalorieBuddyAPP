import 'package:calories_buddy/blocs/exercise_bloc/exercise_bloc.dart';
import 'package:calories_buddy/blocs/exercise_bloc/exercise_state.dart';
import 'package:calories_buddy/contants/date_time_constants.dart';
import 'package:calories_buddy/pages/exercise_table_page.dart';
import 'package:calories_buddy/widgets/custom_widget.dart';
import 'package:calories_buddy/widgets/exercise_table/detail_button.dart';
import 'package:calories_buddy/widgets/exercise_table/restday_dialog.dart';
import 'package:calories_buddy/widgets/home/exercise_box_title.dart';
import 'package:calories_buddy/widgets/home/exercise_day_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = 'Admin Testawdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwdwd';
  String imageUrl = 'https://www.pngall.com/wp-content/uploads/5/Profile-PNG-High-Quality-Image.png';

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
          final Map<String, List> exercises = {};
          final Map<String, List> muscleByDay = {};

          for (var i = 0; i < 7; i++) {
            final day = daysOrdered[i];

            exercises[day] = state.exercises
              .where((e) => e.day == day)
              .toList();

            muscleByDay[day] = exercises[day]!
              .map((e) => e.muscle)
              .toSet()
              .toList();
          }

          final exerciseDayBox = List.generate(7, (i) {
            final day = daysOrdered[i];
            final muscles = muscleByDay[day]!;
            final isRestDay = muscles.isEmpty;

            return InkWell(
              onTap: () {
                if (isRestDay) {
                  Restdaydialog restdaydialog = Restdaydialog();
                  restdaydialog.showRestDayDialog(context);
                  return;
                }

                String exerciseStirng = '';
                for (var i = 0; i < muscles.length; i++) {
                  if (i + 1 < muscles.length) {
                    exerciseStirng += muscles[i] + ' • ';
                  } else {
                    exerciseStirng = muscles[i];
                  }
                }

                showModalBottomSheet(
                  context: context, 
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => ExerciseDetailButton(day: "วัน $day", exerciseStirng: exerciseStirng, exerciseList: exercises[day]!),
                );
              },
              child: ExerciseDayBox(
                day: day, 
                isRestDay: isRestDay, 
                isToday: i == 0, 
                exerciseMuscle: muscles
              ),
            );
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
                          titleExpand(context, 'ตารางออกกำลังกาย', ExerciseTablePage(exerciseWeek: muscleByDay)),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                children: exerciseDayBox,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          Text('ออกกำลังกายรายสัปดาห์', style: TextTheme.of(context).headlineSmall!.copyWith(color: Colors.white),),
                          const SizedBox(height: 12),
                      
                          Column(
                            children: List.generate(7, (i) {
                              final day = daysOrdered[i];
                              final muscles = muscleByDay[day]!;
                              final isRestDay = muscles.isEmpty;
                              List exerciseDay = exercises[day]!;

                              return weeklySection(context, exerciseDay, day, i == 0, isRestDay);
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

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                CustomAppbarUser(),

                Expanded(
                  child: Center(
                    child: Text('โปรดรอซักครู่', style: TextTheme.of(context).headlineSmall!.copyWith(color: Colors.white),)
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget weeklySection(BuildContext context, List exercises, String day, bool isToday, bool isRestDay) {
    return Column(
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

        if (!isRestDay) ...exercises.map((e) => exerciseBox(context, e)),
      ],
    );
  }
}