class UserExercise {
  final String userId;
  int currentSet = 0;
  int currentRep = 0;
  bool isCompleted = false;

  UserExercise({
    required this.userId,
    this.currentSet = 0,
    this.currentRep = 0,
    this.isCompleted = false
  });

  Map<String, dynamic> toMap() {
    return {userId: userId, 'currentRep': currentRep, 'isCompleted': isCompleted};
  }

  factory UserExercise.fromMap(Map<String, dynamic> data) {
    return UserExercise(
      userId: data['userId'],
      currentSet: data['currentSet'],
      currentRep: data['currentRep'],
      isCompleted: data['isCompleted'] == 1
    );
  }
}