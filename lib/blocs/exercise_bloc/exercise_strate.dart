/*
ส่วนรับ Event แล้วแยกว่าเป็น Event อะไรที่เข้ามา snapshot ของ UI — UI จะ render ตาม state ที่เป็นอยู่ตอนนั้น
*/

abstract class ExerciseState {}

class ExerciseInitial extends ExerciseState {} // ดึงข้อมูลการออกกำลังกาย
class ExerciseLoading extends ExerciseState {} // State กำลังโหลด Exercise
class ExerciseLoaded extends ExerciseState {  // State เมื่อโหลด Exercise เสร็จ
  final List exercises;
  ExerciseLoaded(this.exercises);
}

class ExerciseLoadError extends ExerciseState { // State เมื่อโหลด Exercise แล้วเกิด Error
  final String message;
  ExerciseLoadError(this.message);
}