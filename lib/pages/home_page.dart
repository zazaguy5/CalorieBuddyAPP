import 'package:calories_buddy/blocs/exercise_bloc/exercise_bloc.dart';
import 'package:calories_buddy/blocs/exercise_bloc/exercise_strate.dart';
import 'package:calories_buddy/contants/date_time_constants.dart';
import 'package:calories_buddy/widgets/custom_widget.dart';
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

  List<List<String>> exerciseWeek = [
    ['อก', 'หลัง'], ['หลัง', 'แขน', 'ไหล่'], ['พัก'], ['ขา', 'หน้าท้อง'], ['อก', 'หลัง'], ['หลัง', 'แขน', 'ไหล่'], ['พัก']
  ];
  
  @override
  Widget build(BuildContext context) {
    final daysOrdered = List.generate(7, (index) {
      return DateTimeConstants.DAYS_CONSTANT[((DateTime.now().weekday - 1) + index) % 7];
    });
    final exerciseTxtOrdered = List.generate(7, (index) {
      return exerciseWeek[((DateTime.now().weekday - 1) + index) % 7];
    });

    return BlocBuilder<ExerciseBloc, ExerciseState>(
      builder: (context, state) {
        if (state is ExerciseLoading) {
          return const CircularProgressIndicator();
        }
        if (state is ExerciseLoadError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        if (state is ExerciseLoaded) {
          final exerciseDayBox = List.generate(7, (i) => ExerciseDayBox(
            day: daysOrdered[i], 
            isRestDay: exerciseTxtOrdered[i].contains('พัก'), 
            isToday: i == 0, 
            exerciseMuscle: exerciseTxtOrdered[i]
          ));
          final Map<String, List> exercises = {};
          for (var i = 0; i < 7; i++) {
             exercises[daysOrdered[i]] = state.exercises
              .where((e) => e.day == daysOrdered[i])
              .toList();
          }

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
                          //titleExpand(context, 'ตารางออกกำลังกาย', ExerciseTablePage(exerciseWeek: exerciseWeek)),
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
                            children: List.generate(7, (i) => weeklySection(
                              context,
                              exercises, 
                              daysOrdered[i], 
                              i ==0,
                              exerciseTxtOrdered[i].contains('พัก')
                            )),
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

        return SizedBox();
      },
    );
  }

  Widget weeklySection(BuildContext context, Map<String, List> exercises, String day, bool isToday, bool isRestDay) {
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

        if (!isRestDay) ...exercises[day]!.map((e) => exerciseBox(context, e)),
      ],
    );
  }
}