class Exercise {
  final String name;
  final String description;
  final String muscle;
  final int sets;
  final int currentSet;
  final int reps;
  final int currentRep;
  bool isCompleted;
  String day;
  final String image; // รูปหน้าปก
  final String images; // รูปย่อย
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
    required this.day,
    required this.image,
    required this.images,
    required this.video,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'description': description, 'muscle': muscle, 'sets': sets, 'reps': reps, 'day': day, 
    'image': image, 'images': "", 'video': video};
  }

  factory Exercise.fromMap(Map<String, dynamic> data) {
    return Exercise(
      name: data['name'],
      description: data['description'],
      muscle: data['muscle'],
      sets: data['sets'],
      reps: data['reps'],
      day: data['day'],
      image: data['image'],
      images: data['images'] ?? '',
      video: data['video']
    );
  }
}