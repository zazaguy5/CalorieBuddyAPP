import 'package:calories_buddy/contants/contants.dart';
import 'package:calories_buddy/contants/muscle_icons.dart';
import 'package:calories_buddy/models/exercise_data_model.dart';
import 'package:calories_buddy/widgets/custom_widget.dart';
import 'package:calories_buddy/widgets/floating_button.dart';
import 'package:calories_buddy/util/counter_timer.dart';
import 'package:flutter/material.dart';
import 'package:calories_buddy/widgets/add_remove_widget.dart';

class ExercisePage extends StatefulWidget {
  final List<Exercise> exercises;
  const ExercisePage({super.key, required this.exercises});

  @override             
  // ignore: no_logic_in_create_state
  State<ExercisePage> createState() => _ExercisePageState(exercises: exercises);
}

class _ExercisePageState extends State<ExercisePage> {
  final List<Exercise> exercises;
  _ExercisePageState({required this.exercises});

  CustomWidget customWidget = CustomWidget();
  late CounterTimer counterTimer;
  Duration selectTime = Duration(seconds: 60);
  int index = 0; // index ท่าออกกกำลังกายปัจจุบัน
  int sets = 0 ; // เซ็ตปัจจุบัน

  @override
  void initState() {
    super.initState();
    counterTimer = CounterTimer(counterDuration: selectTime);

    counterTimer.startTimer();
  }

  String durationToTxt(Duration duration) {
    int totalSeconds = duration.inSeconds;
    int min = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    if (min > 0 && seconds > 0) {
      return "$min นาที $seconds วินาที";
    } else if (min > 0) {
      return "$min นาที";
    } else {
      return "$seconds วินาที";
    }
  }

  int txtToSeconds(String duration) {
    final firstMacth = RegExp(r'(\d+)\s*นาที').firstMatch(duration);
    final secondMacth = RegExp(r'(\d+)\s*วินาที').firstMatch(duration);

    int min = firstMacth != null ? int.parse(firstMacth.group(1)!) : 0;
    int second = secondMacth != null ? int.parse(secondMacth.group(1)!) : 0;
    return min * 60 + second;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customWidget.appBarCustom(context, 'ออกกำลังกาย', null, null),
      drawer: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          width: 250,
          decoration: BoxDecoration(
            color: Colors.grey.shade700,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
          ),
          child: ListView(
            children: exercises.map((exercise) {
              return exerciseCardWidget(exercises.indexOf(exercise) == exercises.length - 1, exercise);
            }).toList(),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 150,
            child: Builder(
              builder: (context) {
                return InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: floatingButton(),
                );
              }
            ),
          ),
      
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Image.network(exercises[index].image, width: 400, height: 200, fit: BoxFit.cover),
                const SizedBox(height: 10),
                Text(exercises[index].name, style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600)),
                const SizedBox(height: 20),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 25),
                    IconButton(onPressed: () => counterTimer.addSeconds(10), icon: Image.asset("assets/images/plus_10.png", width: 32, height: 32, color: Colors.white)),
                    const SizedBox(width: 15),
                    IconButton(onPressed: () => counterTimer.restartTimer(), icon: Icon(Icons.replay, size: 32, color: Colors.white),),
                  ],
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20),
                    TextButton.icon(onPressed: () => setState(() {
                      if (index > 0) {
                        setState(() {
                          index--;
                        });
                      }   
                    }), label: Text("ท่าก่อนหน้า", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600)), icon: Icon(Icons.skip_previous, size: 32, color: Colors.white),),
                    IconButton(onPressed: () {
                      setState(() {
                        counterTimer.isPlay? counterTimer.stopTimer() : counterTimer.startTimer();
                      });
                    }, icon: Icon(counterTimer.isPlay? Icons.pause : Icons.play_arrow_rounded, size: 32, color: Colors.white),),
                    TextButton.icon(onPressed: () {
                      if (index < exercises.length - 1) {
                        setState(() {
                          index++;
                          counterTimer.restartTimer();
                        });
                      }
                    }, label: Text("ท่าถัดไป", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600)), icon: Icon(Icons.skip_next, size: 32, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 10),
                ValueListenableBuilder<Duration>(
                  valueListenable: counterTimer.counterNotifier,
                  builder: (_, duration, _) {
                    String text = "เวลาพัก ${durationToTxt(duration)}";
                    // ตัวนับเวลาหมดแล้วคือ ถึงเวลาออกกำลังกายแล้ว
                    if (duration.inSeconds == 0) {
                      text = "ถึงเวลาออกกำลังกายแล้ว!";
                    }
                    return Text(text, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600));
                  },
                ),
                const SizedBox(height: 20),
            
                DropdownMenu<String>(
                  initialSelection: durationToTxt(selectTime),
                  onSelected: (String? value) {
                    setState(() {
                      selectTime = Duration(seconds: txtToSeconds(value!));
                      counterTimer.setCounterTime(selectTime);
                    });
                  },
                  textStyle: TextTheme.of(context).titleMedium!,
                  trailingIcon: Icon(Icons.arrow_drop_down_rounded, color: Colors.white, size: 28),
                  inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.5), borderRadius: BorderRadius.circular(12)),),
                  dropdownMenuEntries: [60, 90, 120].map<DropdownMenuEntry<String>>((int value) {
                    String label = durationToTxt(Duration(seconds: value));
                    return DropdownMenuEntry<String>(
                      value: label,
                      label: label
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),


                Text("เซ็ตที่ ${sets + 1}", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                Text("ออกกำลังกาย ${exercises[index].reps} ครั้ง", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600)),
                ValueListenableBuilder<Duration>(
                  valueListenable: counterTimer.counterNotifier,
                  builder: (_, duration, _) {

                    return duration.inSeconds != 0 ? Container() : Column(
                      children: [
                        Text(""),
                        const SizedBox(height: 10),
                    
                        TextButton(onPressed: () {
                          setState(() {
                            sets += 1;
                            counterTimer.restartTimer();
                          });
                        }, child: Text("เสร็จสิ้น", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600))),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget exerciseCardWidget(bool isLast, Exercise exercise) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            height: 35,
            width: 35,
            decoration: BoxDecoration(color: progressColor, shape: BoxShape.circle),
            child: Center(child: Image.asset(muscleIcons[exercise.muscle]!, color: Colors.white, width: 20, height: 20, fit: BoxFit.cover)),
          ),
          Expanded(
            child: Text(exercise.name, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis)
          )
        ],
      ),
      Row(
        children: [
          Checkbox(value: exercise.isCompleted, onChanged: (value) {}),
          Text(exercise.isCompleted ? "ออกกำลังกายแล้ว" : "ยังไม่ได้ออกกำลังกาย", style: TextStyle(fontSize: 16, color: exercise.isCompleted ? Colors.white : Colors.grey, fontWeight: FontWeight.w400)),
        ],
      ),

      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF2E2E2E),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            trainingCard(Icons.fitness_center, "เซ็ตที่", exercise.currentSet, exercise.sets),
            const SizedBox(width: 20),
            trainingCard(Icons.repeat, "ครั้งที่", exercise.currentRep, exercise.reps, color: progressColor),
          ],
        ),
      ),
      const SizedBox(height: 20)
    ],
  );
}

Widget trainingCard(IconData icon, String title, int value, int max, {Color color = Colors.deepOrangeAccent}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        children: [
          Icon(icon, size: 16, color: color),
          SizedBox(width: 4),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.white54, fontWeight: FontWeight.w500))
        ],
      ),
      const SizedBox(height: 4),
      RichText(
        text: TextSpan(
          children: [
            TextSpan(text: value.toString(), style: TextStyle( fontSize: 26, fontWeight: FontWeight.bold, color: color)),
            TextSpan(text: " / $max", style: const TextStyle(fontSize: 13, color: Colors.white70))
          ],
        ),
      ),
    ],
  );
}