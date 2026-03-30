/* 
Bloc Event คือ เหตุการณ์ต่างๆ ของแอป เช่น ผู้ใช้กดโหลดข้อมูลใหม่ เข้ามาหน้านี้ครั้งแรก
จะให้ทำ Logic อะไรบ้าง
*/ 
abstract class ExerciseEvent {}

class FetchExercises extends ExerciseEvent {}
class FetchExerciseById extends ExerciseEvent {
  final int id;
  FetchExerciseById(this.id);
}