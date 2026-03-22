/*
สมองที่รับ Event แล้วตัดสินใจว่าจะ emit State อะไร
*/
import 'package:calories_buddy/blocs/exercise_bloc/exercise_event.dart';
import 'package:calories_buddy/blocs/exercise_bloc/exercise_strate.dart';
import 'package:calories_buddy/database/services/exercise_db_manage.dart';
import 'package:calories_buddy/models/exercise_data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  ExerciseBloc() : super(ExerciseInitial()) {
    on<FetchExercises>(_onFetchExercises);
  }

  Future<void> _onFetchExercises(FetchExercises event, Emitter<ExerciseState> emit) async {
    emit(ExerciseLoading());
    try {
      List data = await ExerciseDbManage().getAllExercises();
      final exercises = data.map((e) => Exercise.fromMap(e)).toList();
      emit(ExerciseLoaded(exercises));
    } catch (e) {
      emit(ExerciseLoadError(e.toString()));
    }
  }

  Future<void> _onDeleteExercise(DeleteExercise event, Emitter<ExerciseState> emit, String id) async {
    try {
      await ExerciseDbManage().deleteExerciseById(id);
    } catch (e) {
      emit(ExerciseLoadError(e.toString()));
    }
  }
}