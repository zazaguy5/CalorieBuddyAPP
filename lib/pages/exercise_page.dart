import 'package:calories_buddy/contants/contants.dart';
import 'package:calories_buddy/contants/muscle_icons.dart';
import 'package:calories_buddy/models/exercise_data_model.dart';
import 'package:calories_buddy/util/counter_timer.dart';
import 'package:flutter/material.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override             
  // ignore: no_logic_in_create_state
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  List<Exercise> exercises = [
    Exercise(name: "Exercise 1", description: "description", muscle: "อก", currentSet: 0, sets: 4, currentRep: 0, reps: 10, image: "image", images: ["images"], video: ""),
    Exercise(name: "Exercise 2", description: "description", muscle: "อก", currentSet: 0, sets: 4, currentRep: 0, reps: 10, image: "image", images: ["images"], video: ""),
    Exercise(name: "Exercise 3", description: "description", muscle: "แขน", currentSet: 0, sets: 4, currentRep: 0, reps: 10, image: "image", images: ["images"], video: ""),
    Exercise(name: "Exercise 4", description: "description", muscle: "ขา", currentSet: 0, sets: 4, currentRep: 0, reps: 10, image: "image", images: ["images"], video: ""),
    Exercise(name: "Exercise 5", description: "description", muscle: "หลัง", currentSet: 0, sets: 4, currentRep: 0, reps: 10, image:"image", images:["images"], video:""),
  ];

  late CounterTimer counterTimer;
  Duration selectTime = Duration(seconds: 60);
  int index = 0; // index ท่าออกกกำลังกายปัจจุบัน
  bool isExercising = false;

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
      appBar: AppBar(title: Text('ออกกำลังกาย'),),
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(exercises[index].name, style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600)),
            const SizedBox(height: 20),

            Row(
              children: [
                IconButton(onPressed: () => counterTimer.addSeconds(10), icon: Icon(Icons.plus_one, size: 32, color: Colors.white),),
                const SizedBox(width: 15),
                IconButton(onPressed: () => counterTimer.restartTimer(), icon: Icon(Icons.replay, size: 32, color: Colors.white),),
              ],
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton.icon(onPressed: () => setState(() {
                  if (index > 0) {
                    setState(() {
                      index--;
                    });
                  }   
                }), label: Text("ท่าที่แล้ว", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600)), icon: Icon(Icons.skip_previous, size: 32, color: Colors.white),),
                const SizedBox(width: 15),
                IconButton(onPressed: () {
                  setState(() {
                    counterTimer.isPlay? counterTimer.stopTimer() : counterTimer.startTimer();
                  });
                }, icon: Icon(counterTimer.isPlay? Icons.pause : Icons.play_arrow_rounded, size: 32, color: Colors.white),),
                const SizedBox(width: 15),
                TextButton.icon(onPressed: () {
                  if (index < exercises.length - 1) {
                    setState(() {
                      index++;
                    });

                  }
                }, label: Text("ข้ามท่า", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600)), icon: Icon(Icons.skip_next, size: 32, color: Colors.white)),
              ],
            ),
            const SizedBox(height: 15),
            ValueListenableBuilder<Duration>(
              valueListenable: counterTimer.counterNotifier,
              builder: (_, duration, _) {
                return Text(counterTimer.isPlay && !isExercising ? "เหลือเวลาอีก ${durationToTxt(duration)}" : !counterTimer.isPlay && isExercising ? "กำลังออกกำลังกาย" : "หมดเวลาแล้ว", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600));
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

            IconButton(
              onPressed: () => setState(() => isExercising = !isExercising),
              icon: Icon(Icons.fitness_center, size: 32, color: Colors.white),
            ),
            const SizedBox(height: 20),

            AddRemoveWidget(
              value: "เซ็ต ${exercises[index].currentSet}", 
              onIncrement: () {
                setState(() {
                  exercises[index].currentSet = (exercises[index].currentSet + 1) % (exercises[index].sets + 1);
                });
              }, 
              onDecrement: () {
                setState(() {
                  exercises[index].currentSet = (exercises[index].currentSet - 1 < 0) ? exercises[index].sets : exercises[index].currentSet - 1;
                });
              }
            ),
            const SizedBox(height: 5),

            AddRemoveWidget(
              value: "ครั้ง ${exercises[index].currentRep}", 
              onIncrement: () {
                setState(() {
                  exercises[index].currentRep = (exercises[index].currentRep + 1) % (exercises[index].reps + 1);
                });
              }, 
              onDecrement: () {
                setState(() {
                  exercises[index].currentRep = (exercises[index].currentRep - 1 < 0) ? exercises[index].reps : exercises[index].currentRep - 1;
                });
              }
            ),
          ],
        ),
      ),
    );
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
              trainingCard(Icons.fitness_center, "จำนวนเซ็ต", exercise.currentSet, exercise.sets),
              const SizedBox(width: 20),
              trainingCard(Icons.repeat, "จำนวนครั้ง", exercise.currentRep, exercise.reps, color: progressColor),
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
}


class AddRemoveWidget extends StatelessWidget {
  final String value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const AddRemoveWidget({
    super.key,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onDecrement,
          icon: const Icon(Icons.remove, size: 32, color: Colors.white),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        IconButton(
          onPressed: onIncrement,
          icon: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
      ],
    );
  }
}