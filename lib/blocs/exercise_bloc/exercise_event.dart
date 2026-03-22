/* 
Bloc Event คือ เหตุการณ์ต่างๆ ของแอป เช่น ผู้ใช้กดโหลดข้อมูลใหม่ เข้ามาหน้านี้ครั้งแรก
จะให้ทำ Logic อะไรบ้าง
*/ 
abstract class ExerciseEvent {}

class FetchExercises extends ExerciseEvent {}
class DeleteExercise extends ExerciseEvent {
  final int id;
  DeleteExercise(this.id);
}