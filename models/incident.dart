class Incident {
  String title;
  DateTime date;
  String description;
  String photoPath;
  String audioPath;

  Incident({
    required this.title,
    required this.date,
    required this.description,
    required this.photoPath,
    required this.audioPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date.toIso8601String(),
      'description': description,
      'photoPath': photoPath,
      'audioPath': audioPath,
    };
  }
}



