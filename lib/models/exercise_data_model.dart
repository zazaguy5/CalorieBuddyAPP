class Exercise {
  final String name;
  final String description;
  final String muscle;
  final int sets;
  int currentSet = 0;
  final int reps;
  int currentRep = 0;
  bool isCompleted = false;
  final String image; // รูปหน้าปก
  final List<String> images; // รูปย่อย
  final String video;

  Exercise({
    required this.name,
    required this.description,
    required this.muscle,
    required this.sets,
    this.currentSet = 0,
    required this.reps,
    this.currentRep = 0,
    this.isCompleted = false,
    required this.image,
    required this.images,
    required this.video,
  });
}