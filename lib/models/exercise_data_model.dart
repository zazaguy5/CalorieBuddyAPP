class Exercise {
  final String name;
  final String description;
  final int sets;
  final int reps;
  final String image; // รูปหน้าปก
  final List<String> images; // รูปย่อย
  final String video;

  Exercise({
    required this.name,
    required this.description,
    required this.sets,
    required this.reps,
    required this.image,
    required this.images,
    required this.video,
  });
}